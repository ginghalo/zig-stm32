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
        .tick_cfg = .{},
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
    const tim_ctx: used_mcu.tim.Tim_Ct_Context = .{
        .cfg2 = .{
            .arre = .enable,
            .cms = .edge,
            .dir = .up,
            .arr = 1000 - 1,
            .psc = 72 - 1,
            .chs = @constCast(&[_]used_mcu.tim.Ch_Ct_Config{
                .{
                    .ch = .@"2",
                    .cfg = .{
                        .Output = .{
                            .mode = .toggle,
                            .pul = 500,
                            .prel = .disable,
                        },
                    },
                    .ite = .enable,
                },
            }),
            .tim_it = .{
                .it = .{
                    .general = .{
                        .gf = tim2_it_gf,
                        .nvic_cfg = .{ .pri = 9 },
                    },
                },
                .uie = .disable,
            },
        },
    };
    const adc_ctx: used_mcu.adc.Adc_Ct_Context = .{
        .cfg1 = .{
            .adcpre = .div8,
            .scan = .disable,
            .discen = .disable,
            .cont = .single,
            .l = .@"1",
            .extsel = .swstart,
            .chs = @constCast(&[_]used_mcu.adc.Ch_Ct_Config{
                .{
                    .ch = .@"0",
                    .target = .{ .regular = .@"0" },
                    .smp = .@"239.5cycle",
                },
            }),
        },
    };
    comptime var ct_ctx = used_mcu.ctx.Ct_Context{
        .sys = sys_ctx,
        .gpio = gpio_ctx,
        .tim = tim_ctx,
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

    rctx.allocator = allocator;

    const data = try allocator.alloc(u8, 12);
    defer allocator.free(data);
    @memset(data, 0xFF);

    const tim2 = used_mcu.tim.@"2";
    const tim2c2 = tim2.channel(.@"2");

    const adc1 = used_mcu.adc.@"1";

    tim2.start(cctx, rctx);
    tim2c2.it_start(cctx, rctx);
    tim2c2.start(cctx, rctx);

    while (true) {
        try adc1.regular_start(cctx, rctx);
        const v_per = @as(u32, try adc1.regular_read(cctx, rctx, u12)) * 100 / std.math.maxInt(u12);
        try adc1.stop(cctx, rctx);

        @atomicStore(u16, &tim2_oc_delta_cnt, @min(1000, (900 * @as(u32, v_per)) / 100 + 100), .release); // 100-1000 10-1kHz
    }
}

// gf part
var tim2_oc_delta_cnt: u16 = 500;
fn tim2_it_gf(comptime _cctx: used_mcu.ctx.Ct_Context) fn () void {
    const tim2 = used_mcu.tim.@"2";
    const tim2c2 = tim2.channel(.@"2");
    const t = tim2.reg_tim();
    const max_cnt = comptime tim2.get_ct_cfg(_cctx).arr;
    return struct {
        inline fn get_psc_it_should_be() u16 {
            const cnt = tim2.get(_cctx, &rt_ctx);

            const delta = @min(max_cnt / 10, @atomicLoad(u16, &tim2_oc_delta_cnt, .acquire));
            const add_ret: u16 = cnt + delta; // known that it won't overflow
            return if (add_ret > max_cnt) add_ret - max_cnt else add_ret;
        }
        pub fn f() void {
            defer tim2.clear_it_flag(_cctx, &rt_ctx);

            if (t.SR.CC2IF == 0b1) {
                defer tim2c2.clear_it_flag(_cctx, &rt_ctx);
                tim2c2.set(_cctx, &rt_ctx, get_psc_it_should_be());
            }
        }
    }.f;
}
