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
    const i2c_ctx: used_mcu.i2c.I2c_Ct_Context = .{
        .cfg1 = .{
            .i2c_dma = .{
                .tx_cfg = .{
                    .it = .{
                        .gf = i2c_tx_dma_it_gf,
                        .htie = .disable,
                        .tcie = .enable,
                    },
                },
            },
        },
    };
    comptime var ct_ctx = used_mcu.ctx.Ct_Context{
        .sys = sys_ctx,
        .gpio = gpio_ctx,
        .i2c = i2c_ctx,
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

    const data = try allocator.alloc(u8, 12);
    defer allocator.free(data);
    @memset(data, 0xFF);

    const tx_addr: u7 = 0x64;

    const tick = used_mcu.sys.tick;
    const i2c1 = used_mcu.i2c.@"1";
    const I2c_writer_ctx = struct {
        pub const I2c_writer_ctx = @This();
        pub const Error = i2c1.Error;

        inline fn wait_tx_finished() Error!void {
            tick.start(cctx, rctx, 100_000);
            defer tick.stop(cctx, rctx);

            while (@atomicLoad(bool, &i2c_tx_finished, .acquire) != true) {
                if (tick.finished(cctx, rctx) == true) return Error.I2c_Time_Out;
            }
        }
        pub fn write(_log_ctx: I2c_writer_ctx, _bytes: []const u8) !usize {
            rctx.i2c = .{
                .cfg1 = .{
                    .tx_cfg = .{
                        .ma = @intFromPtr(_bytes.ptr),
                        .ndt = @truncate(_bytes.len),
                        .circ = .disable,
                        .minc = .enable,
                    },
                },
            };
            _ = _log_ctx;

            try wait_tx_finished();

            @atomicStore(bool, &i2c_tx_finished, false, .release);
            try i2c1.master_dma_start(cctx, rctx, .@"7bit", tx_addr);
            return _bytes.len;
        }
    };
    const i2c_writer = std.io.GenericWriter(I2c_writer_ctx, anyerror, I2c_writer_ctx.write){ .context = I2c_writer_ctx{} };

    const str = "Hello World!";

    try i2c_writer.print("{s}\n", .{str});

    while (true) {}
}

//gf part
var i2c_tx_finished: bool = true;
fn i2c_tx_dma_it_gf(comptime _cctx: used_mcu.ctx.Ct_Context) fn () void {
    const i2c1 = used_mcu.i2c.@"1";
    const tick = used_mcu.sys.tick;
    const i = i2c1.reg_i2c();
    const i2c_dma_ch = i2c1.tx_dma_ch();
    const dc_pos = comptime i2c_dma_ch.get_pos();
    const d = i2c_dma_ch.reg_dma();
    return struct {
        pub fn f() void {
            defer i2c_dma_ch.clear_it_flag(_cctx, &rt_ctx);
            if (@field(d.ISR, "TCIF" ++ @tagName(dc_pos.ch)) == 0b1) {
                tick.wait_until(
                    _cctx,
                    &rt_ctx,
                    10_000,
                    i.SR1_struct,
                    i.SR1,
                    "BTF",
                    0b1,
                    null,
                ) catch {};

                i2c1.dma_stop(_cctx, &rt_ctx);
                @atomicStore(bool, &i2c_tx_finished, true, .release);
            }
        }
    }.f;
}
