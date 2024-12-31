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
const pulses = [8]u16{ 3_600 * 1, 3_600 * 2, 3_600 * 3, 3_600 * 4, 3_600 * 5, 3_600 * 6, 3_600 * 7, 3_600 * 8 };
pub fn main() void {
    const sys_ctx: used_mcu.sys.Sys_Ct_Context = .{
        .clock_cfg = .{
            .lsi = .{ .enable = .{} },
            .hse = .{ .enable = .{} },
            .src = .{ .HSE = .{ .pre = .div1 } },
            .pllmul = .@"9",
            .hpre = .div1,
            .ppre1 = .div2,
            .ppre2 = .div1,
        },
        .tick_cfg = .{},
    };
    const single_cfgs: used_mcu.gpio.Gpio_Ct_Context.Single_Configs = @constCast(&[_]used_mcu.gpio.Gpio_Ct_Context.Single_Config{});
    const gpio_ctx = used_mcu.gpio.Gpio_Ct_Context{
        .single_cfgs = single_cfgs,
    };
    const adc_ctx: used_mcu.adc.Adc_Ct_Context = .{
        .cfg1 = .{
            .adcpre = .div8,
            .scan = .enable,
            .discen = .disable,
            .cont = .single,
            .l = .@"8",
            .extsel = .swstart,
            .chs = @constCast(&[_]used_mcu.adc.Ch_Ct_Config{
                .{
                    .ch = .@"1",
                    .target = .{ .regular = .@"0" },
                    .smp = .@"1.5cycle",
                },
                .{
                    .ch = .@"2",
                    .target = .{ .regular = .@"1" },
                    .smp = .@"1.5cycle",
                },
                .{
                    .ch = .@"3",
                    .target = .{ .regular = .@"2" },
                    .smp = .@"1.5cycle",
                },
                .{
                    .ch = .@"4",
                    .target = .{ .regular = .@"3" },
                    .smp = .@"1.5cycle",
                },
                .{
                    .ch = .@"5",
                    .target = .{ .regular = .@"4" },
                    .smp = .@"1.5cycle",
                },
                .{
                    .ch = .@"6",
                    .target = .{ .regular = .@"5" },
                    .smp = .@"1.5cycle",
                },
                .{
                    .ch = .@"7",
                    .target = .{ .regular = .@"6" },
                    .smp = .@"1.5cycle",
                },
                .{
                    .ch = .@"8",
                    .target = .{ .regular = .@"7" },
                    .smp = .@"1.5cycle",
                },
            }),
            .adc_dma = .{
                .cfg = .{
                    .it = .{
                        .gf = adc1_dma_it_gf,
                        .tcie = .enable,
                    },
                },
            },
        },
    };
    comptime var ct_ctx = used_mcu.ctx.Ct_Context{
        .sys = sys_ctx,
        .gpio = gpio_ctx,
        .adc = adc_ctx,
    };
    _ = &ct_ctx;

    main_with_err(ct_ctx) catch {
        while (true) {}
    };
}

fn main_with_err(comptime _cctx: used_mcu.ctx.Ct_Context) !void {
    comptime var cctx = _cctx;
    const rctx = &rt_ctx;
    comptime used_mcu.ctx.use(&cctx);
    try used_mcu.ctx.config(cctx, rctx);

    var fixed_buffer_allocator = FixedBufferAllocator.init(@as([*]u8, @ptrCast(&__user_heap_start__))[0..__heap_size__]);
    defer fixed_buffer_allocator.reset();
    const allocator = fixed_buffer_allocator.allocator();

    const data_u16_8 = try allocator.alloc(u16, 8);
    defer allocator.free(data_u16_8);
    const data_per_8 = try allocator.alloc(u8, 8);
    defer allocator.free(data_per_8);

    const adc_rt_ctx = used_mcu.adc.Adc_Rt_Context{
        .cfg1 = .{
            .adc_dma = .{
                .circ = .disable,
                .minc = .enable,
                .ma = @intFromPtr(data_u16_8.ptr),
                .ndt = @truncate(data_u16_8.len),
            },
        },
    };
    rctx.adc = adc_rt_ctx;

    const adc1 = used_mcu.adc.@"1";

    try adc1.regular_dma_start(cctx, rctx);
    try adc1.regular_start(cctx, rctx);

    while (true) {
        if (@atomicLoad(bool, &adc1_transfer_finished, .acquire) == true) {
            adc1.dma_stop(cctx, rctx);
            try adc1.stop(cctx, rctx);

            @atomicStore(bool, &adc1_transfer_finished, false, .release);

            for (0..data_u16_8.len) |i| data_per_8[i] = @truncate(@as(u32, data_u16_8[i]) * 100 / std.math.maxInt(u12));

            try adc1.regular_dma_start(cctx, rctx);
            try adc1.regular_start(cctx, rctx);
        }
    }
}

// gf part
var adc1_transfer_finished: bool = true;
fn adc1_dma_it_gf(comptime _cctx: used_mcu.ctx.Ct_Context) fn () void {
    const adc1 = used_mcu.adc.@"1";
    const dc = adc1.dma_ch();
    const dc_pos = comptime dc.get_pos();
    const d = dc.reg_dma();
    return struct {
        pub fn f() void {
            defer dc.clear_it_flag(_cctx, &rt_ctx);
            if (@field(d.ISR, "TCIF" ++ @tagName(dc_pos.ch)) == 0b1) {
                @atomicStore(bool, &adc1_transfer_finished, true, .release);
            }
        }
    }.f;
}
