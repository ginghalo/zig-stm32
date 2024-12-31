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
    const adc_ctx: used_mcu.adc.Adc_Ct_Context = .{
        .cfg1 = .{
            .adcpre = .div8,
            .scan = .disable,
            .discen = .disable,
            .cont = .continuous,
            .l = .@"1",
            .extsel = .swstart,
            .chs = @constCast(&[_]used_mcu.adc.Ch_Ct_Config{
                .{
                    .ch = .@"0",
                    .target = .{ .regular = .@"0" },
                    .smp = .@"239.5cycle",
                },
            }),
            .adc_it = .{
                .gf = adc1_it_gf,
                .eocie = .enable,
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

    const data = try allocator.alloc(u8, 12);
    defer allocator.free(data);
    @memset(data, 0xFF);

    const adc1 = used_mcu.adc.@"1";
    const c13 = used_mcu.gpio.C.pin(.@"13");

    adc1.it_start(cctx, rctx);
    try adc1.regular_start(cctx, rctx);

    while (true) {
        c13.set(cctx, rctx, if (@atomicLoad(u8, &v_per, .acquire) > 50) 0 else 1);
    }
}

// gf part
var v_per: u8 = 0;
fn adc1_it_gf(comptime _cctx: used_mcu.ctx.Ct_Context) fn () void {
    const adc1 = used_mcu.adc.@"1";
    const a = adc1.reg_adc();
    return struct {
        pub fn f() void {
            defer adc1.clear_it_flag(_cctx, &rt_ctx);

            if (a.SR.EOC == 0b1) {
                const v_per_u32 = @as(u32, adc1.regular_get(_cctx, &rt_ctx)) * 100 / std.math.maxInt(u12);
                @atomicStore(u8, &v_per, @truncate(v_per_u32), .release);
            }
        }
    }.f;
}
