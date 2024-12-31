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
        // out
        .{
            .pos = .{ .port = .A, .no = .@"15" },
            .pin_config = .{
                .Output = .{
                    .mode = .PP,
                    .speed = .@"50MHz",
                    .level = .low,
                },
            },
        },
        .{
            .pos = .{ .port = .B, .no = .@"3" },
            .pin_config = .{
                .Output = .{
                    .mode = .PP,
                    .speed = .@"50MHz",
                    .level = .low,
                },
            },
        },
        .{
            .pos = .{ .port = .B, .no = .@"4" },
            .pin_config = .{
                .Output = .{
                    .mode = .PP,
                    .speed = .@"50MHz",
                    .level = .low,
                },
            },
        },
        .{
            .pos = .{ .port = .B, .no = .@"5" },
            .pin_config = .{
                .Output = .{
                    .mode = .PP,
                    .speed = .@"50MHz",
                    .level = .low,
                },
            },
        },
        // exti0
        .{
            .pos = .{ .port = .A, .no = .@"0" },
            .pin_config = .{
                .Input = .{
                    .mode = .PD,
                    .pin_it = .{
                        .gf = key_single_it_gf,
                        .exti_cfg = .{
                            .imr = .enable,
                            .rtsr = .enable,
                        },
                    },
                },
            },
        },
        // exti6-9
        .{
            .pos = .{ .port = .B, .no = .@"9" },
            .pin_config = .{
                .Input = .{
                    .mode = .PU,
                    .pin_it = .{
                        .gf = c1_it_gf,
                        .exti_cfg = .{
                            .imr = .enable,
                            .ftsr = .enable,
                        },
                    },
                },
            },
        },
        .{
            .pos = .{ .port = .B, .no = .@"8" },
            .pin_config = .{
                .Input = .{
                    .mode = .PU,
                    .pin_it = .{
                        .gf = c2_it_gf,
                        .exti_cfg = .{
                            .imr = .enable,
                            .ftsr = .enable,
                        },
                    },
                },
            },
        },
        .{
            .pos = .{ .port = .B, .no = .@"7" },
            .pin_config = .{
                .Input = .{
                    .mode = .PU,
                    .pin_it = .{
                        .gf = c3_it_gf,
                        .exti_cfg = .{
                            .imr = .enable,
                            .ftsr = .enable,
                        },
                    },
                },
            },
        },
        .{
            .pos = .{ .port = .B, .no = .@"6" },
            .pin_config = .{
                .Input = .{
                    .mode = .PU,
                    .pin_it = .{
                        .gf = c4_it_gf,
                        .exti_cfg = .{
                            .imr = .enable,
                            .ftsr = .enable,
                        },
                    },
                },
            },
        },
    });
    const gpio_ctx = used_mcu.gpio.Gpio_Ct_Context{
        .single_cfgs = single_cfgs,
    };
    comptime var ct_ctx = used_mcu.ctx.Ct_Context{
        .sys = sys_ctx,
        .gpio = gpio_ctx,
    };
    _ = &ct_ctx;

    main_with_err(ct_ctx) catch {
        while (true) {}
    };
}

fn scan_key_col(comptime _cctx: used_mcu.ctx.Ct_Context) ?u2 {
    const c1 = used_mcu.gpio.B.pin(.@"9");
    const c2 = used_mcu.gpio.B.pin(.@"8");
    const c3 = used_mcu.gpio.B.pin(.@"7");
    const c4 = used_mcu.gpio.B.pin(.@"6");
    if (c1.get(_cctx, &rt_ctx) == 0) return 0;
    if (c2.get(_cctx, &rt_ctx) == 0) return 1;
    if (c3.get(_cctx, &rt_ctx) == 0) return 2;
    if (c4.get(_cctx, &rt_ctx) == 0) return 3;
    return null;
}
fn scan_key(comptime _cctx: used_mcu.ctx.Ct_Context) ?struct { u2, u2 } {
    const r1 = used_mcu.gpio.A.pin(.@"15");
    const r2 = used_mcu.gpio.B.pin(.@"3");
    const r3 = used_mcu.gpio.B.pin(.@"4");
    const r4 = used_mcu.gpio.B.pin(.@"5");
    defer {
        r1.ct_set(_cctx, &rt_ctx, 0);
        r2.ct_set(_cctx, &rt_ctx, 0);
        r3.ct_set(_cctx, &rt_ctx, 0);
        r4.ct_set(_cctx, &rt_ctx, 0);
    }

    inline for (0..4) |i| {
        r1.ct_set(_cctx, &rt_ctx, if (i == 0) 0 else 1);
        r2.ct_set(_cctx, &rt_ctx, if (i == 1) 0 else 1);
        r3.ct_set(_cctx, &rt_ctx, if (i == 2) 0 else 1);
        r4.ct_set(_cctx, &rt_ctx, if (i == 3) 0 else 1);
        if (scan_key_col(_cctx)) |col1| {
            used_mcu.sys.tick.delay_us(_cctx, &rt_ctx, 100);
            if (scan_key_col(_cctx)) |col2| {
                if (col1 == col2) return .{ i, col1 };
            }
        }
    }

    return null;
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

    const c13 = used_mcu.gpio.C.pin(.@"13");
    var key_4x4_r: u2 = 0;
    var key_4x4_c: u2 = 0;
    var press_count: u12 = 0;
    while (true) {
        if (@atomicLoad(bool, &key_4x4_flag, .acquire) == true) {
            if (scan_key(cctx)) |r_c| {
                key_4x4_r = r_c.@"0";
                key_4x4_c = r_c.@"1";
                press_count += 1;
                c13.toggle(cctx, rctx);
            }
            @atomicStore(bool, &key_4x4_flag, false, .release);
        }
        const key_single = used_mcu.gpio.A.pin(.@"0");
        if (@atomicLoad(bool, &key_single_flag, .acquire) == true) {
            used_mcu.sys.tick.delay_us(cctx, rctx, 100);
            if (key_single.get(cctx, rctx) == 1) {
                press_count += 1;
                c13.toggle(cctx, rctx);
            }
            @atomicStore(bool, &key_single_flag, false, .release);
        }
    }
}

// gf part
var key_single_flag: bool = false;
fn key_single_it_gf(comptime _cctx: used_mcu.ctx.Ct_Context) fn () void {
    return struct {
        pub fn f() void {
            defer used_mcu.it.Exti(.@"0").clear_pr(_cctx, &rt_ctx);
            @atomicStore(bool, &key_single_flag, true, .release);
        }
    }.f;
}

var key_4x4_flag: bool = false;
fn c1_it_gf(comptime _cctx: used_mcu.ctx.Ct_Context) fn () void {
    return struct {
        pub fn f() void {
            defer used_mcu.it.Exti(.@"9").clear_pr(_cctx, &rt_ctx);
        }
    }.f;
}
fn c2_it_gf(comptime _cctx: used_mcu.ctx.Ct_Context) fn () void {
    return struct {
        pub fn f() void {
            defer used_mcu.it.Exti(.@"8").clear_pr(_cctx, &rt_ctx);
        }
    }.f;
}
fn c3_it_gf(comptime _cctx: used_mcu.ctx.Ct_Context) fn () void {
    return struct {
        pub fn f() void {
            defer used_mcu.it.Exti(.@"7").clear_pr(_cctx, &rt_ctx);
        }
    }.f;
}
fn c4_it_gf(comptime _cctx: used_mcu.ctx.Ct_Context) fn () void {
    return struct {
        pub fn f() void {
            defer used_mcu.it.Exti(.@"6").clear_pr(_cctx, &rt_ctx);
            @atomicStore(bool, &key_4x4_flag, true, .release);
        }
    }.f;
}
