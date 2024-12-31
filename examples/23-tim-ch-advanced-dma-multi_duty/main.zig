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
    const tim_ctx: used_mcu.tim.Tim_Ct_Context = .{
        .cfg2 = .{
            .arre = .enable,
            .cms = .edge,
            .dir = .up,
            .arr = 36_000 - 1,
            .psc = 2_000 - 1, // 1s
            .chs = @constCast(&[_]used_mcu.tim.Ch_Ct_Config{
                .{
                    .ch = .@"1",
                    .cfg = .{
                        .Output = .{
                            .mode = .pwm1,
                            .pul = 3_600 * 1,
                            .prel = .enable,
                        },
                    },
                },
                .{
                    .ch = .@"2",
                    .cfg = .{
                        .Output = .{
                            .mode = .pwm1,
                            .pul = 3_600 * 2,
                            .prel = .enable,
                        },
                    },
                },
                .{
                    .ch = .@"3",
                    .cfg = .{
                        .Output = .{
                            .mode = .pwm1,
                            .pul = 3_600 * 3,
                            .prel = .enable,
                        },
                    },
                },
                .{
                    .ch = .@"4",
                    .cfg = .{
                        .Output = .{
                            .mode = .pwm1,
                            .pul = 3_600 * 4,
                            .prel = .enable,
                        },
                    },
                },
            }),
            .tim_dma = .{
                .cfg = .{
                    .tx_cfg = .{
                        .it = .{
                            .gf = tim2_dma_it_gf,
                        },
                    },
                },
                .ude = .enable,
                .dba = .ccr1,
                .dbl = .@"4half-words",
            },
        },
    };
    const tim_rt_ctx: used_mcu.tim.Tim_Rt_Context = .{
        .cfg2 = .{
            .tim_dma = .{
                .cfg = .{
                    .tx_cfg = .{
                        .ma = @intFromPtr(&pulses),
                        .ndt = pulses.len,
                        .circ = .enable,
                        .minc = .enable,
                    },
                },
            },
        },
    };
    rt_ctx.tim = tim_rt_ctx;
    comptime var ct_ctx = used_mcu.ctx.Ct_Context{
        .sys = sys_ctx,
        .gpio = gpio_ctx,
        .tim = tim_ctx,
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

    const tim2 = used_mcu.tim.@"2";

    try tim2.dma_start(cctx, rctx);
    tim2.start(cctx, rctx);

    while (true) {}
}

fn tim2_dma_it_gf(comptime _cctx: used_mcu.ctx.Ct_Context) fn () void {
    const tim2 = used_mcu.tim.@"2";
    const dc = tim2.dma_ch();
    return struct {
        pub fn f() void {
            defer dc.clear_it_flag(_cctx, &rt_ctx);
        }
    }.f;
}
