const std = @import("std");
const stm32 = @import("stm32");
const plugins = @import("plugins");

const utils = stm32.interface.utils;
const used_mcu = stm32.f103c;
const oled = plugins.ssd1306;

const math = std.math;
const FixedBufferAllocator = std.heap.FixedBufferAllocator;
const epoch = std.time.epoch;

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
const oi = oled.I2c(used_mcu, .@"2", .@"0.91inch");

inline fn err_handler(comptime _cctx: used_mcu.ctx.Ct_Context, _err: anytype) void {
    comptime var cctx = _cctx;
    comptime oi.use(&cctx);
    oi.init(cctx, &rt_ctx) catch {
        while (true) {}
    };
    var oled_ctx_i2c = oi.OLED_Context{
        .rt_ctx = &rt_ctx,
        .page = 0,
        .column = 0,
    };
    oi.raw_fill_zero(cctx, &rt_ctx) catch {};

    oled_ctx_i2c.page = 0;
    oled_ctx_i2c.column = 0;

    const logger = oi.writer(cctx, &oled_ctx_i2c);
    logger.print("{any}\n", .{_err}) catch {};
}

pub fn main() void {
    const sys_ctx: used_mcu.sys.Sys_Ct_Context = .{
        .clock_cfg = .{
            .lsi = .{ .enable = .{} },
            // .lse = .{ .enable = .{ .byp = .yes, .speed = 60_000 } },
            .hse = .{ .enable = .{} },
            .src = .{ .HSE = .{ .pre = .div1 } },
            .pllmul = .@"2",
            .hpre = .div8,
            .ppre1 = .div1,
            .ppre2 = .div1,
            .mco = .plldiv2,
        },
        .tick_cfg = .{},
    };

    const pbr_ctx: used_mcu.pbr.Pbr_Ct_Context = .{
        .pwr_cfg = .{},
        .bkp_cfg = .{},
        .rtc_cfg = .{
            // .sel = .lse,
            // .prl = sys_ctx.clock_cfg.?.lse.enable.speed - 1, // 1s
            .sel = .hse,
            .prl = sys_ctx.clock_cfg.?.hse.enable.speed / 128 - 1,
            .rtc_its = .{
                .rtc_it = .{
                    .gf = rtc_global_it_gf,
                },
                .secie = .enable,
            },
        },
    };
    const wdg_ctx: used_mcu.wdg.Wdg_Ct_Context = .{
        .iwdg_cfg = .{
            .pr = .div64,
            .rl = 0x9C3, // 4s
        },
    };
    const single_cfgs: used_mcu.gpio.Gpio_Ct_Context.Single_Configs = @constCast(&[_]used_mcu.gpio.Gpio_Ct_Context.Single_Config{
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
    const dma_ctx = used_mcu.dma.Dma_Ct_Context{
        .cfg1 = .{},
    };
    const tim_ctx: used_mcu.tim.Tim_Ct_Context = .{
        .cfg2 = .{
            .arre = .disable,
            .cms = .edge,
            .dir = .up,
            .arr = 20000 - 1,
            .psc = 2 - 1,
            .chs = @constCast(&[_]used_mcu.tim.Ch_Ct_Config{
                .{ // freq:50Hz for mg90s, 5 for min, 25 for max
                    .ch = .@"1",
                    .cfg = .{
                        .Output = .{
                            .mode = .pwm1,
                            .pul = 5000,
                            .prel = .enable,
                        },
                    },
                },
                .{
                    .ch = .@"2",
                    .cfg = .{
                        .Output = .{
                            .mode = .toggle,
                            .pul = 0,
                            .prel = .disable,
                        },
                    },
                    .ite = .enable,
                },
            }),
            .tim_it = .{
                .it = .{
                    .general = .{
                        .gf = general_tim2_it_gf,
                        .nvic_cfg = .{ .pri = 9 },
                    },
                },
            },
        },
        .cfg3 = .{
            .arre = .disable,
            .cms = .edge,
            .dir = .up,
            .arr = 0xFFFF,
            .psc = 200 - 1,
        },
    };
    const uart_ctx: used_mcu.uart.Uart_Ct_Context = .{
        .cfg1 = .{
            .uart_it = .{
                .gf = uart1_rx_idle_it_gf,
                .nvic_cfg = .{ .pri = 10 },
                .idleie = .enable,
            },
            .uart_dma = .{
                .rx_cfg = .{
                    .it = .{
                        .gf = uart1_rx_dma_it_gf,
                        .nvic_cfg = .{ .pri = 4 },
                        .htie = .enable,
                        .tcie = .enable,
                    },
                },
            },
        },
    };
    const uart_rt_ctx: used_mcu.uart.Uart_Rt_Context = .{
        .cfg1 = .{
            .rx_cfg = .{
                .circ = .enable,
                .minc = .enable,
                .ma = @intFromPtr(&uart1_rx_tmp_buff),
                .ndt = uart1_rx_tmp_buff.len,
            },
        },
    };
    rt_ctx.uart = uart_rt_ctx;
    const i2c_ctx: used_mcu.i2c.I2c_Ct_Context = .{};
    const spi_ctx: used_mcu.spi.Spi_Ct_Context = .{
        .cfg2 = .{
            .mstr = .slave,
            .cpol = .low,
            .cpha = .first,
            .ssm = .disable,
            .spi_it = .{
                .gf = spi2_it_gf,
                .rxneie = .enable,
            },
        },
    };
    const adc_ctx: used_mcu.adc.Adc_Ct_Context = .{
        .cfg1 = .{
            .scan = .enable,
            .discen = .disable,
            .cont = .single,
            .l = .@"2",
            .extsel = .swstart,
            .chs = @constCast(&[_]used_mcu.adc.Ch_Ct_Config{
                .{
                    .ch = .@"3",
                    .target = .{ .regular = .@"0" },
                    .smp = .@"239.5cycle",
                },
                .{
                    .ch = .@"2",
                    .target = .{ .regular = .@"1" },
                    .smp = .@"239.5cycle",
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
    const adc_rt_ctx = used_mcu.adc.Adc_Rt_Context{
        .cfg1 = .{
            .adc_dma = .{
                .circ = .disable,
                .minc = .enable,
                .ma = @intFromPtr(&adc1_2ch_tmp_buff),
                .ndt = adc1_2ch_tmp_buff.len,
            },
        },
    };
    rt_ctx.adc = adc_rt_ctx;
    comptime var ct_ctx = used_mcu.ctx.Ct_Context{
        .sys = sys_ctx,
        .pbr = pbr_ctx,
        .wdg = wdg_ctx,
        .gpio = gpio_ctx,
        .dma = dma_ctx,
        .tim = tim_ctx,
        .uart = uart_ctx,
        .i2c = i2c_ctx,
        .spi = spi_ctx,
        .adc = adc_ctx,
    };
    _ = &ct_ctx;

    main_with_err(ct_ctx) catch |err| {
        err_handler(ct_ctx, err);

        while (true) {}
    };
}

var press_count: u12 = 0;

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

var adc1_2ch_tmp_buff: [2]u16 = undefined;
fn main_with_err(comptime _cctx: used_mcu.ctx.Ct_Context) !void {
    comptime var cctx = _cctx;
    const rctx = &rt_ctx;
    comptime used_mcu.ctx.use(&cctx);
    try used_mcu.ctx.config(cctx, rctx);

    var fixed_buffer_allocator = FixedBufferAllocator.init(@as([*]u8, @ptrCast(&__user_heap_start__))[0..__heap_size__]);
    defer fixed_buffer_allocator.reset();
    const allocator = fixed_buffer_allocator.allocator();

    const o = oled.Spi_Dma(
        used_mcu,
        .@"1",
        .@"0.96inch",
        .{ .port = .B, .no = .@"0" },
        .{ .port = .B, .no = .@"1" },
        .{ .port = .C, .no = .@"13" },
        &rt_ctx,
    );
    comptime o.use(&cctx);
    try o.init(cctx);
    var oled_ctx = o.OLED_Context{
        .page = 0,
        .column = 0,
    };
    const logger = o.writer(cctx, &oled_ctx);

    comptime oi.use(&cctx);
    try oi.init(cctx, rctx);
    var oled_ctx_i2c = oi.OLED_Context{
        .rt_ctx = rctx,
        .page = 0,
        .column = 0,
    };
    const dbg_logger = oi.writer(cctx, &oled_ctx_i2c);

    const w = plugins.w25q.@"64"(
        used_mcu,
        .@"1",
        .{ .port = .A, .no = .@"4" },
    );
    comptime w.use(&cctx);
    try w.init(cctx, rctx);

    const data = try allocator.alloc(u8, 12);
    defer allocator.free(data);
    @memset(data, 0xFF);

    try w.read(cctx, rctx, 0, data);

    try logger.print("Data:{s}\n", .{data});

    const adc1 = used_mcu.adc.@"1";
    const adc1_cal: u12 = @truncate(try adc1.calibration(cctx, rctx));

    const tim2 = used_mcu.tim.@"2";
    const tim2c1 = tim2.channel(.@"1");
    const tim2c2 = tim2.channel(.@"2");

    const tim3 = used_mcu.tim.@"3";

    const uart1 = used_mcu.uart.@"1";
    const Uart_log_ctx = struct {
        pub const Uart_log_ctx = @This();
        pub fn write(_log_ctx: Uart_log_ctx, _bytes: []const u8) used_mcu.uart.Error!usize {
            _ = _log_ctx;
            try uart1.write(cctx, rctx, u8, _bytes);
            return _bytes.len;
        }
    };
    const uart1_log = std.io.GenericWriter(Uart_log_ctx, uart1.Error, Uart_log_ctx.write){ .context = Uart_log_ctx{} };
    var uart1_rx_str: [256]u8 = undefined;
    var uart1_rx_str_len: usize = 0;

    const spi2 = used_mcu.spi.@"2";
    const spi2_nss = used_mcu.gpio.B.pin(.@"12");

    var spi2_rx_str: [256]u8 = undefined;
    var spi2_rx_str_len: usize = 0;

    const rtc = used_mcu.pbr.rtc;

    tim2.start(cctx, rctx);
    tim2c1.start(cctx, rctx);
    tim2c2.it_start(cctx, rctx);
    tim2c2.start(cctx, rctx);

    uart1.it_start(cctx, rctx);
    try uart1.dma_start(cctx, rctx);

    spi2.it_start(cctx, rctx);

    used_mcu.wdg.iwdg.feed(cctx, rctx);

    var key_r: u2 = 0;
    var key_c: u2 = 0;

    var logger_tmp_buff: [32]u8 = undefined;
    while (true) {
        tim3.start(cctx, rctx);
        tim3.reset(cctx, rctx);
        defer tim3.stop(cctx, rctx);

        // logger print begin
        try logger.writeByte(0);

        if (1 == 1) {
            if (@atomicLoad(bool, &adc1_transfer_finished, .acquire) == true) {
                @atomicStore(bool, &adc1_transfer_finished, false, .release);
                adc1.dma_stop(cctx, rctx);
                try adc1.stop(cctx, rctx);
                try adc1.regular_dma_start(cctx, rctx);
                try adc1.regular_start(cctx, rctx);
            }

            // try adc1.regular_start(cctx, rctx);
            // const value_y: u8 = @truncate(@as(u32, try adc1.regular_read(cctx, rctx, u12)) * 100 / std.math.maxInt(u12));
            // try adc1.regular_start(cctx, rctx);
            // const value_x: u8 = @truncate(@as(u32, try adc1.regular_read(cctx, rctx, u12)) * 100 / std.math.maxInt(u12));
            const value_y: u8 = @truncate(@as(u32, adc1_2ch_tmp_buff[0]) * 100 / std.math.maxInt(u12));
            const value_x: u8 = @truncate(@as(u32, adc1_2ch_tmp_buff[1]) * 100 / std.math.maxInt(u12));

            tim2_oc_delta_cnt = @min(600, (500 * @as(u32, value_y)) / 100 + 100); // freq:0.8k-3.6kHz
            tim2c1.set(cctx, rctx, @min(2500, (2000 * @as(u32, value_x)) / 100 + 500)); // duty:0.5-12.5%

            _ = try logger.write(try std.fmt.bufPrint(&logger_tmp_buff, "ADC: X:{d:0>2} Y:{d:0>2} C:{d: <4}\n", .{ value_x, value_y, adc1_cal }));

            const epoch_seconds = epoch.EpochSeconds{ .secs = rtc.get(cctx, rctx) };
            const day_seconds = epoch_seconds.getDaySeconds();
            const hours = day_seconds.getHoursIntoDay();
            const minutes = day_seconds.getMinutesIntoHour();
            const seconds = day_seconds.getSecondsIntoMinute();
            _ = try logger.write(try std.fmt.bufPrint(&logger_tmp_buff, "RTC: {d:0>2}-{d:0>2}-{d:0>2}\n", .{ hours, minutes, seconds }));

            if (@atomicLoad(bool, &key_flag, .acquire) == true) {
                if (scan_key(cctx)) |r_c| {
                    key_r = r_c.@"0";
                    key_c = r_c.@"1";
                    press_count += 1;
                    try uart1_log.print("Press: R:{d:1} C:{d:1}\n", .{ key_r, key_c });
                }
                @atomicStore(bool, &key_flag, false, .release);
            }
            _ = try logger.write(try std.fmt.bufPrint(&logger_tmp_buff, "Key: R:{d:1} C:{d:1} PC:{d: <4}\n", .{ key_r, key_c, press_count }));

            if (@atomicLoad(bool, &uart1_rx_finished, .acquire) == true) {
                if (uart1_fifo.readableLength() != 0) {
                    uart1_rx_str_len = uart1_fifo.read(&uart1_rx_str);
                    if (uart1_rx_str_len >= 2 and std.mem.eql(u8, uart1_rx_str[uart1_rx_str_len - 2 .. uart1_rx_str_len], "\r\n")) uart1_rx_str_len -= 2;
                }
                uart1.it_start(cctx, rctx);
                @atomicStore(bool, &uart1_rx_finished, false, .release);
            }
            _ = try logger.write(try std.fmt.bufPrint(&logger_tmp_buff, "URT: {s}\n", .{uart1_rx_str[0..uart1_rx_str_len]}));

            if (spi2_rx_first_byte) |first_byte| {
                var byte = first_byte;
                while (spi2_nss.get(cctx, rctx) == 0) : (byte += 1) {
                    var spi2_byte: [1]u8 = .{byte};
                    try spi2.read(_cctx, rctx, u8, &spi2_byte);
                    try spi2_fifo.write(&spi2_byte);
                }

                spi2_rx_str_len = spi2_fifo.read(&spi2_rx_str);
                spi2_rx_first_byte = null;
                spi2.it_start(cctx, rctx);
            }
            _ = try logger.write(try std.fmt.bufPrint(&logger_tmp_buff, "SPI: {s}\n", .{spi2_rx_str[0..spi2_rx_str_len]}));
        }
        // logger print end
        try logger.writeByte(0);

        _ = try dbg_logger.write(try std.fmt.bufPrint(&logger_tmp_buff, "\x00Loop costs {0d:0>5}00us\x00", .{tim3.get(cctx, rctx)}));
    }
}

// gf part
const Kfifo_u8_256 = std.fifo.LinearFifo(u8, .{ .Static = 256 });

fn error_it_gf(comptime _cctx: used_mcu.ctx.Ct_Context) fn () void {
    _ = _cctx;
    return struct {
        pub fn f() void {
            @compileError("Empty function!");
        }
    }.f;
}
fn nonsense_it_gf(comptime _cctx: used_mcu.ctx.Ct_Context) fn () void {
    _ = _cctx;
    return struct {
        pub fn f() void {}
    }.f;
}

fn pvdg_it_gf(comptime _cctx: used_mcu.ctx.Ct_Context) fn () void {
    const pwr = used_mcu.pbr.pwr;
    return struct {
        pub fn f() void {
            defer pwr.clear_it_flag(_cctx, &rt_ctx);
        }
    }.f;
}
fn systick_it_gf(comptime _cctx: used_mcu.ctx.Ct_Context) fn () void {
    const tick = used_mcu.sys.tick;
    return struct {
        pub fn f() void {
            defer tick.clear_it_flag(_cctx, &rt_ctx);
        }
    }.f;
}

var tim2_oc_delta_cnt: u16 = 1000;
fn general_tim2_it_gf(comptime _cctx: used_mcu.ctx.Ct_Context) fn () void {
    const tim2 = used_mcu.tim.@"2";
    const tim2c2 = tim2.channel(.@"2");
    const t = tim2.reg_tim();
    const max_cnt = comptime tim2.get_ct_cfg(_cctx).arr;
    return struct {
        inline fn get_psc_it_should_be() u16 {
            const cnt = tim2.get(_cctx, &rt_ctx);
            const delta = @min(max_cnt / 10, tim2_oc_delta_cnt);
            const add_ret: u16 = cnt + delta; // known that it won't overflow
            return if (add_ret > max_cnt) add_ret - max_cnt else add_ret;
        }
        pub fn f() void {
            defer tim2.clear_it_flag(_cctx, &rt_ctx);

            if (t.SR.CC2IF == 0b1) {
                tim2c2.set(_cctx, &rt_ctx, get_psc_it_should_be());
                tim2c2.clear_it_flag(_cctx, &rt_ctx);
            }
        }
    }.f;
}

var key_flag: bool = false;
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

            @atomicStore(bool, &key_flag, true, .release);
        }
    }.f;
}

var uart1_rx_tmp_buff: [2]u8 = undefined;
var uart1_fifo: Kfifo_u8_256 = Kfifo_u8_256.init();
var uart1_rx_finished: bool = false;
fn uart1_rx_idle_it_gf(comptime _cctx: used_mcu.ctx.Ct_Context) fn () void {
    const uart1 = used_mcu.uart.@"1";
    const u = uart1.reg_uart();
    return struct {
        pub fn f() void {
            defer uart1.clear_it_flag(_cctx, &rt_ctx);

            if (u.SR.IDLE == 0b1) {
                uart1.it_stop(_cctx, &rt_ctx);
                @atomicStore(bool, &uart1_rx_finished, true, .release);
            }
        }
    }.f;
}
fn uart1_rx_dma_it_gf(comptime _cctx: used_mcu.ctx.Ct_Context) fn () void {
    const uart1 = used_mcu.uart.@"1";
    const dc = uart1.rx_dma_ch();
    const dc_pos = comptime dc.get_pos();
    const d = dc.reg_dma();
    return struct {
        pub fn f() void {
            defer dc.clear_it_flag(_cctx, &rt_ctx);

            if (@field(d.ISR, "HTIF" ++ @tagName(dc_pos.ch)) == 0b1) {
                uart1_fifo.write(uart1_rx_tmp_buff[0..1]) catch {};
            }
            if (@field(d.ISR, "TCIF" ++ @tagName(dc_pos.ch)) == 0b1) {
                uart1_fifo.write(uart1_rx_tmp_buff[1..2]) catch {};
            }
        }
    }.f;
}

fn rtc_global_it_gf(comptime _cctx: used_mcu.ctx.Ct_Context) fn () void {
    const rtc = used_mcu.pbr.rtc;
    return struct {
        pub fn f() void {
            defer rtc.clear_it_flag(_cctx, &rt_ctx);

            used_mcu.wdg.iwdg.feed(_cctx, &rt_ctx);
        }
    }.f;
}

var spi2_fifo: Kfifo_u8_256 = Kfifo_u8_256.init();
var spi2_rx_first_byte: ?u8 = null;
fn spi2_it_gf(comptime _cctx: used_mcu.ctx.Ct_Context) fn () void {
    const spi2 = used_mcu.spi.@"2";
    const spi2_cfg = comptime spi2.get_ct_cfg(_cctx);
    return struct {
        pub fn f() void {
            defer spi2.clear_it_flag(_cctx, &rt_ctx);

            const s = spi2.reg_spi();
            if (s.SR.RXNE == 0b1) {
                spi2_rx_first_byte = @truncate(s.DR.DR);
                s.DR.DR = switch (spi2_cfg.dff) {
                    .@"16bit" => 0xFFFF,
                    .@"8bit" => 0xFF,
                };
                spi2.it_stop(_cctx, &rt_ctx);
            }
        }
    }.f;
}
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
