pub const sys = @import("sys.zig");
pub const pbr = @import("pbr.zig");
pub const wdg = @import("wdg.zig");
pub const gpio = @import("gpio.zig");
pub const spi = @import("spi.zig");
pub const i2c = @import("i2c.zig");
pub const uart = @import("uart.zig");
pub const adc = @import("adc.zig");
pub const tim = @import("tim.zig");
pub const it = @import("it.zig");
pub const dma = @import("dma.zig");
pub const vector = @import("vector.zig");
pub const reg = @import("reg.zig");

const interface = @import("../stm32.zig").interface;
const Ctx = interface.Ctx;
pub const utils = interface.utils;

const std = @import("std");
const Allocator = std.mem.Allocator;
const ct_print = std.fmt.comptimePrint;

pub const Ct_Context = struct {
    sys: sys.Sys_Ct_Context = .{
        .clock_cfg = .{},
        .tick_cfg = .{},
    },
    pbr: pbr.Pbr_Ct_Context = .{},
    wdg: wdg.Wdg_Ct_Context = .{},
    gpio: gpio.Gpio_Ct_Context = .{},
    tim: tim.Tim_Ct_Context = .{},
    spi: spi.Spi_Ct_Context = .{},
    i2c: i2c.I2c_Ct_Context = .{},
    uart: uart.Uart_Ct_Context = .{},
    adc: adc.Adc_Ct_Context = .{},
    dma: dma.Dma_Ct_Context = .{},
};
pub const Rt_Context = struct {
    sys: sys.Sys_Rt_Context = .{},
    pbr: pbr.Pbr_Rt_Context = .{},
    wdg: wdg.Wdg_Rt_Context = .{},
    gpio: gpio.Gpio_Rt_Context = .{},
    tim: tim.Tim_Rt_Context = .{},
    spi: spi.Spi_Rt_Context = .{},
    i2c: i2c.I2c_Rt_Context = .{},
    uart: uart.Uart_Rt_Context = .{},
    adc: adc.Adc_Rt_Context = .{},
    dma: dma.Dma_Rt_Context = .{},
    allocator: ?Allocator = null,
};

pub const ctx = Ctx(Ct_Context, Rt_Context, config, use, unuse);

fn config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) anyerror!void {
    // sys
    if (_cctx.sys.tick_cfg) |_| try sys.tick.config(_cctx, _rctx);
    if (_cctx.sys.clock_cfg) |_| try sys.clock.config(_cctx, _rctx);
    // wdg
    if (_cctx.wdg.iwdg_cfg) |_| try wdg.iwdg.config(_cctx, _rctx);
    if (_cctx.wdg.wwdg_cfg) |_| try wdg.wwdg.config(_cctx, _rctx);
    // bpr
    if (_cctx.pbr.pwr_cfg) |_| try pbr.pwr.config(_cctx, _rctx);
    if (_cctx.pbr.bkp_cfg) |_| try pbr.bkp.config(_cctx, _rctx);
    if (_cctx.pbr.rtc_cfg) |_| try pbr.rtc.config(_cctx, _rctx);
    // gpio
    inline for (_cctx.gpio.single_cfgs) |cfg| {
        gpio.Gpio(cfg.pos.port).enable();
        try gpio.Pin(cfg.pos).config(_cctx, _rctx, cfg.pin_config);
    }
    // dma
    inline for (@typeInfo(dma.Dma_Ct_Context).Struct.fields[0..dma.NO_NUMS], 1..) |cfg_field, i|
        if (@field(_cctx.dma, cfg_field.name)) |_|
            try @field(dma, ct_print("{d}", .{i})).config(_cctx, _rctx);
    // spi
    inline for (@typeInfo(spi.Spi_Ct_Context).Struct.fields, 1..) |cfg_field, i|
        if (@field(_cctx.spi, cfg_field.name)) |_|
            try @field(spi, ct_print("{d}", .{i})).config(_cctx, _rctx);
    // i2c
    inline for (@typeInfo(i2c.I2c_Ct_Context).Struct.fields, 1..) |cfg_field, i|
        if (@field(_cctx.i2c, cfg_field.name)) |_|
            try @field(i2c, ct_print("{d}", .{i})).config(_cctx, _rctx);
    // uart
    inline for (@typeInfo(uart.Uart_Ct_Context).Struct.fields, 1..) |cfg_field, i|
        if (@field(_cctx.uart, cfg_field.name)) |_|
            try @field(uart, ct_print("{d}", .{i})).config(_cctx, _rctx);
    // adc
    inline for (@typeInfo(adc.Adc_Ct_Context).Struct.fields, 1..) |cfg_field, i|
        if (@field(_cctx.adc, cfg_field.name)) |_|
            try @field(adc, ct_print("{d}", .{i})).config(_cctx, _rctx);
    // tim
    inline for (@typeInfo(tim.Tim_Ct_Context).Struct.fields, 1..) |cfg_field, i|
        if (@field(_cctx.tim, cfg_field.name)) |_|
            try @field(tim, ct_print("{d}", .{i})).config(_cctx, _rctx);
}

fn use(_cctx: *Ct_Context) void {
    // sys
    if (_cctx.sys.clock_cfg) |_| sys.clock.use(_cctx);
    // bpr
    if (_cctx.pbr.pwr_cfg) |_| pbr.pwr.use(_cctx);
    if (_cctx.pbr.bkp_cfg) |_| pbr.bkp.use(_cctx);
    if (_cctx.pbr.rtc_cfg) |_| pbr.rtc.use(_cctx);
    // wdg
    if (_cctx.wdg.iwdg_cfg) |_| wdg.iwdg.use(_cctx);
    if (_cctx.wdg.wwdg_cfg) |_| wdg.wwdg.use(_cctx);
    // gpio
    inline for (_cctx.gpio.single_cfgs) |cfg|
        gpio.Pin(cfg.pos).use(_cctx, cfg.pin_config);
    // dma
    inline for (@typeInfo(dma.Dma_Ct_Context).Struct.fields[0..dma.NO_NUMS], 1..) |cfg_field, i|
        if (@field(_cctx.dma, cfg_field.name)) |_|
            @field(dma, ct_print("{d}", .{i})).use(_cctx);
    // tim
    inline for (@typeInfo(tim.Tim_Ct_Context).Struct.fields, 1..) |cfg_field, i|
        if (@field(_cctx.tim, cfg_field.name)) |_|
            comptime @field(tim, ct_print("{d}", .{i})).use(_cctx);
    // spi
    inline for (@typeInfo(spi.Spi_Ct_Context).Struct.fields, 1..) |cfg_field, i|
        if (@field(_cctx.spi, cfg_field.name)) |_|
            comptime @field(spi, ct_print("{d}", .{i})).use(_cctx);
    //i2c
    inline for (@typeInfo(i2c.I2c_Ct_Context).Struct.fields, 1..) |cfg_field, i|
        if (@field(_cctx.i2c, cfg_field.name)) |_|
            comptime @field(i2c, ct_print("{d}", .{i})).use(_cctx);
    //uart
    inline for (@typeInfo(uart.Uart_Ct_Context).Struct.fields, 1..) |cfg_field, i|
        if (@field(_cctx.uart, cfg_field.name)) |_|
            comptime @field(uart, ct_print("{d}", .{i})).use(_cctx);
    //adc
    inline for (@typeInfo(adc.Adc_Ct_Context).Struct.fields, 1..) |cfg_field, i|
        if (@field(_cctx.adc, cfg_field.name)) |_|
            comptime @field(adc, ct_print("{d}", .{i})).use(_cctx);
}
fn unuse(_cctx: *Ct_Context) void {
    // sys
    if (_cctx.sys.clock_cfg) |_| sys.clock.unuse(_cctx);
    // bpr
    if (_cctx.pbr.pwr_cfg) |_| pbr.pwr.unuse(_cctx);
    if (_cctx.pbr.bkp_cfg) |_| pbr.bkp.unuse(_cctx);
    if (_cctx.pbr.rtc_cfg) |_| pbr.rtc.unuse(_cctx);
    // gpio
    inline for (_cctx.gpio.single_cfgs) |cfg|
        gpio._Pin(cfg.pos, null).unuse(_cctx, cfg.pin_config);
    // dma
    inline for (@typeInfo(dma.Dma_Ct_Context).Struct.fields[0..dma.NO_NUMS], 1..) |cfg_field, i|
        if (@field(_cctx.dma, cfg_field.name)) |_|
            @field(dma, ct_print("{d}", .{i})).unuse(_cctx);
    // tim
    inline for (@typeInfo(tim.Tim_Ct_Context).Struct.fields, 1..) |cfg_field, i|
        if (@field(_cctx.tim, cfg_field.name)) |_|
            comptime @field(tim, ct_print("{d}", .{i})).unuse(_cctx);
    // spi
    inline for (@typeInfo(spi.Spi_Ct_Context).Struct.fields, 1..) |cfg_field, i|
        if (@field(_cctx.spi, cfg_field.name)) |_|
            comptime @field(spi, ct_print("{d}", .{i})).unuse(_cctx);
    //i2c
    inline for (@typeInfo(i2c.I2c_Ct_Context).Struct.fields, 1..) |cfg_field, i|
        if (@field(_cctx.i2c, cfg_field.name)) |_|
            comptime @field(i2c, ct_print("{d}", .{i})).unuse(_cctx);
    //uart
    inline for (@typeInfo(uart.Uart_Ct_Context).Struct.fields, 1..) |cfg_field, i|
        if (@field(_cctx.uart, cfg_field.name)) |_|
            comptime @field(uart, ct_print("{d}", .{i})).unuse(_cctx);
    //adc
    inline for (@typeInfo(adc.Adc_Ct_Context).Struct.fields, 1..) |cfg_field, i|
        if (@field(_cctx.adc, cfg_field.name)) |_|
            comptime @field(adc, ct_print("{d}", .{i})).unuse(_cctx);
}
