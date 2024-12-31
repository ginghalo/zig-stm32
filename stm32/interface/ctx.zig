pub const utils = @import("utils.zig");
pub const gpio = @import("gpio.zig");
pub const sys = @import("sys.zig");
pub const spi = @import("spi.zig");
pub const i2c = @import("i2c.zig");
pub const uart = @import("uart.zig");
pub const adc = @import("adc.zig");
pub const dac = @import("dac.zig");
pub const tim = @import("tim.zig");
pub const pbr = @import("pbr.zig");
pub const wdg = @import("wdg.zig");
pub const it = @import("it.zig");
pub const dma = @import("dma.zig");

pub fn Ctx(
    comptime _Ct_Context: type,
    comptime _Rt_Context: type,
    comptime _config_fn: fn (comptime _cctx: _Ct_Context, _rctx: *_Rt_Context) anyerror!void,
    comptime _use_fn: fn (_ctx: *_Ct_Context) void,
    comptime _unuse_fn: fn (_ctx: *_Ct_Context) void,
) type {
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;

        pub inline fn config(comptime _cctx: _Ct_Context, _rctx: *_Rt_Context) anyerror!void {
            return _config_fn(_cctx, _rctx);
        }

        pub inline fn use(_cctx: *_Ct_Context) void {
            _use_fn(_cctx);
        }
        pub inline fn unuse(_cctx: *_Ct_Context) void {
            _unuse_fn(_cctx);
        }
    };
}
