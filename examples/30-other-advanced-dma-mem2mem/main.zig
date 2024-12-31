const std = @import("std");
const stm32 = @import("stm32");
const plugins = @import("plugins");

const utils = stm32.interface.utils;
const used_mcu = stm32.f103c;

const FixedBufferAllocator = std.heap.FixedBufferAllocator;

export const vector_table linksection(".vectors") = used_mcu.vector.vector_table;

// These symbols below come from the linker script
// user_stack
extern var __user_stack_start__: u32;
extern const __stack_size__: u32;
extern const __user_stack_end__: u32;
// user_heap
extern var __user_heap_start__: u32;
extern const __heap_size__: u32;
extern const __user_heap_end__: u32;
// data
extern const __data_loadaddr__: u32;
extern var __data_start__: u32;
extern const __data_end__: u32;
// bss
extern var __bss_start__: u32;
extern const __bss_end__: u32;

export fn _start() void {
    // Copy data from flash to RAM
    const data_loadaddr = @as([*]const u8, @ptrCast(&__data_loadaddr__));
    const data = @as([*]u8, @ptrCast(&__data_start__));
    const data_size = @intFromPtr(&__data_end__) - @intFromPtr(&__data_start__);
    for (data_loadaddr[0..data_size], 0..) |d, i| data[i] = d;

    // Clear the bss
    const bss = @as([*]u8, @ptrCast(&__bss_start__));
    const bss_size = @intFromPtr(&__bss_end__) - @intFromPtr(&__bss_start__);
    for (bss[0..bss_size]) |*b| b.* = 0;

    main();
    while (true) {}
}

var rt_ctx = used_mcu.ctx.Rt_Context{};
pub fn main() void {
    const sys_ctx: used_mcu.sys.Sys_Ct_Context = .{
        .clock_cfg = .{
            .hse = .{ .enable = .{} },
            .src = .{ .HSE = .{ .pre = .div1 } },
            .pllmul = .@"9",
            .hpre = .div1,
            .ppre1 = .div2,
            .ppre2 = .div1,
        },
    };
    const single_cfgs: used_mcu.gpio.Gpio_Ct_Context.Single_Configs = @constCast(&[_]used_mcu.gpio.Gpio_Ct_Context.Single_Config{
        .{
            .pos = .{ .port = .C, .no = .@"13" },
            .pin_config = .{
                .Output = .{
                    .mode = .PP,
                    .speed = .@"50MHz",
                    .level = .high,
                },
            },
        },
    });
    const gpio_ctx = used_mcu.gpio.Gpio_Ct_Context{
        .single_cfgs = single_cfgs,
    };
    const dma_ctx: used_mcu.dma.Dma_Ct_Context = .{
        .cfg1 = .{
            .chs = @constCast(&[_]used_mcu.dma.Ch_Ct_Config{
                .{
                    .ch = .@"1",
                    .dir = .peripheral,
                    .pl = .high,
                    .ch_it = .{
                        .gf = dma1c1_it_gf,
                        .tcie = .enable,
                    },
                },
            }),
        },
    };
    const dma_rt_ctx: used_mcu.dma.Dma_Rt_Context = .{
        .cfg1 = .{
            .chs = @constCast(&[_]used_mcu.dma.Ch_Rt_Config{
                .{
                    .ma = 0,
                    .pa = 0,
                    .ndt = 0,
                    .circ = .disable,
                    .mem2mem = .enable,
                    .psize = .@"8bit",
                    .msize = .@"8bit",
                    .minc = .enable,
                    .pinc = .enable,
                },
            }),
        },
    };
    rt_ctx.dma = dma_rt_ctx;
    comptime var ct_ctx = used_mcu.ctx.Ct_Context{
        .sys = sys_ctx,
        .gpio = gpio_ctx,
        .dma = dma_ctx,
    };
    _ = &ct_ctx;

    main_with_err(ct_ctx) catch {
        while (true) {}
    };
}

inline fn wait_tx_finished(comptime _cctx: used_mcu.ctx.Ct_Context) anyerror!void {
    used_mcu.sys.tick.start(_cctx, &rt_ctx, 100_000);
    defer used_mcu.sys.tick.stop(_cctx, &rt_ctx);

    while (@atomicLoad(bool, &dma1c1_tx_finished, .acquire) != true) {
        if (used_mcu.sys.tick.finished(_cctx, &rt_ctx) == true) return error.Wait_Tx_Finished_Time_Out;
    }
}
fn memset(comptime _cctx: used_mcu.ctx.Ct_Context, comptime _T: type, _dst: []_T, _value: *const _T) !void {
    const dma1 = used_mcu.dma.@"1";
    const dma1c1 = dma1.channel(.@"1");
    const c1_ct_cfg = dma1c1.get_ct_cfg(_cctx);

    const mp_size = comptime MP_SIZE: {
        const bitsize = @bitSizeOf(_T);
        if (bitsize <= 8) break :MP_SIZE .@"8bit";
        if (bitsize <= 16) break :MP_SIZE .@"16bit";
        if (bitsize <= 32) break :MP_SIZE .@"32bit";
        @compileError("Out of size from type " ++ @typeName(_T) ++ "!");
    };

    const dcrc = used_mcu.dma.Ch_Rt_Config{
        .ma = if (comptime c1_ct_cfg.dir == .peripheral) @intFromPtr(_dst.ptr) else @intFromPtr(_value),
        .pa = if (comptime c1_ct_cfg.dir == .peripheral) @intFromPtr(_value) else @intFromPtr(_dst.ptr),
        .minc = if (comptime c1_ct_cfg.dir == .peripheral) .enable else .disable,
        .pinc = if (comptime c1_ct_cfg.dir == .peripheral) .disable else .enable,
        .ndt = @truncate(_dst.len),
        .circ = .disable,
        .mem2mem = .enable,
        .psize = mp_size,
        .msize = mp_size,
    };
    try dma1c1.config(_cctx, &rt_ctx, dcrc);

    try wait_tx_finished(_cctx);

    @atomicStore(bool, &dma1c1_tx_finished, false, .release);
    dma1c1.start(_cctx, &rt_ctx);
}

fn memcpy(comptime _cctx: used_mcu.ctx.Ct_Context, comptime _T: type, _dst: []_T, _src: []const _T) !void {
    const dma1 = used_mcu.dma.@"1";
    const dma1c1 = dma1.channel(.@"1");
    const c1_ct_cfg = dma1c1.get_ct_cfg(_cctx);

    const mp_size = comptime MP_SIZE: {
        const bitsize = @bitSizeOf(_T);
        if (bitsize <= 8) break :MP_SIZE .@"8bit";
        if (bitsize <= 16) break :MP_SIZE .@"16bit";
        if (bitsize <= 32) break :MP_SIZE .@"32bit";
        @compileError("Out of size from type " ++ @typeName(_T) ++ "!");
    };

    const dcrc = used_mcu.dma.Ch_Rt_Config{
        .ma = if (comptime c1_ct_cfg.dir == .peripheral) @intFromPtr(_dst.ptr) else @intFromPtr(_src.ptr),
        .pa = if (comptime c1_ct_cfg.dir == .peripheral) @intFromPtr(_src.ptr) else @intFromPtr(_dst.ptr),
        .ndt = @truncate(@min(_src.len, _dst.len)),
        .circ = .disable,
        .mem2mem = .enable,
        .psize = mp_size,
        .msize = mp_size,
        .minc = .enable,
        .pinc = .enable,
    };
    try dma1c1.config(_cctx, &rt_ctx, dcrc);

    try wait_tx_finished(_cctx);

    @atomicStore(bool, &dma1c1_tx_finished, false, .release);
    dma1c1.start(_cctx, &rt_ctx);
}

fn main_with_err(comptime _cctx: used_mcu.ctx.Ct_Context) !void {
    comptime var cctx = _cctx;
    const rctx = &rt_ctx;
    comptime used_mcu.ctx.use(&cctx);
    try used_mcu.ctx.config(cctx, rctx);

    var fixed_buffer_allocator = FixedBufferAllocator.init(@as([*]u8, @ptrCast(&__user_heap_start__))[0..__heap_size__]);
    defer fixed_buffer_allocator.reset();
    const allocator = fixed_buffer_allocator.allocator();

    const data = try allocator.alloc(u8, 12);
    defer allocator.free(data);
    for (0..data.len) |i| data[i] = @truncate(i);
    const value: u8 = 0;
    try memset(cctx, u8, data[data.len / 2 ..], &value);
    try memcpy(cctx, u8, data[data.len / 2 ..], data[0 .. data.len / 2]);

    while (true) {
        if (@atomicLoad(bool, &dma1c1_tx_finished, .acquire) == true) {
            if (std.mem.eql(u8, data[0 .. data.len / 2], data[data.len / 2 ..]) == true)
                used_mcu.gpio.C.pin(.@"13").ct_set(cctx, rctx, 0);
            @atomicStore(bool, &dma1c1_tx_finished, false, .release);
        }
    }
}

var dma1c1_tx_finished: bool = true;
fn dma1c1_it_gf(comptime _cctx: used_mcu.ctx.Ct_Context) fn () void {
    const dma1 = used_mcu.dma.@"1";
    const dma1c1 = dma1.channel(.@"1");
    const d = dma1.reg_dma();
    return struct {
        pub fn f() void {
            defer dma1c1.clear_it_flag(_cctx, &rt_ctx);

            if (d.ISR.TCIF1 == 0b1) {
                @atomicStore(bool, &dma1c1_tx_finished, true, .release);
            }
        }
    }.f;
}
