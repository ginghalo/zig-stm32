pub fn Gpio(
    comptime _Ct_Context: type,
    comptime _Rt_Context: type,
    comptime _Pos: type,
    comptime _gpio_fn: fn (comptime _Ct_Context: type, comptime _Rt_Context: type, comptime _port: _Pos.Port) type,
    comptime _port: _Pos.Port,
) type {
    const g = _gpio_fn(_Ct_Context, _Rt_Context, _port);
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;
        pub const Pos = _Pos;

        pub fn reg_gpio() type {
            return g.reg_gpio();
        }
        pub inline fn enable() void {
            g.enable();
        }
        pub inline fn disable() void {
            g.disable();
        }
        pub inline fn pin(comptime _pin: Pos.No) type {
            return g.pin(_pin);
        }

        pub fn get(comptime _cctx: Ct_Context, _rctx: *Rt_Context) u16 {
            return g.get(_cctx, _rctx);
        }
        pub fn set(comptime _cctx: Ct_Context, _rctx: *Rt_Context, _value: u16) void {
            g.set(_cctx, _rctx, _value);
        }
    };
}

pub fn Pin(
    comptime _Ct_Context: type,
    comptime _Rt_Context: type,
    comptime _Ct_Config: type,
    comptime _Rt_Config: type,
    comptime _Pos: type,
    comptime _pin_fn: fn (comptime _Ct_Context: type, comptime _Rt_Context: type, comptime _pos: _Pos) type,
    comptime _pos: _Pos,
) type {
    const p = _pin_fn(_Ct_Context, _Rt_Context, _pos);
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;
        pub const Ct_Config = _Ct_Config;
        pub const Rt_Config = _Rt_Config;
        pub const Pos = _Pos;

        pub inline fn reg_gpio() type {
            return p.reg_gpio();
        }

        pub inline fn get_cfg(comptime _cctx: Ct_Context, _rctx: *Rt_Context) struct { Ct_Config, ?Rt_Config } {
            return p.get_cfg(_cctx, _rctx);
        }

        pub inline fn check_use(_cctx: *Ct_Context) ?Ct_Config {
            return p.check_use(_cctx);
        }
        pub inline fn assert_use(_cctx: *Ct_Context) void {
            p.assert_use(_cctx);
        }
        pub inline fn use(_cctx: *Ct_Context, comptime _cfg: Ct_Config) void {
            p.use(_cctx, _cfg);
        }
        pub inline fn unuse(_cctx: *Ct_Context) void {
            p.unuse(_cctx);
        }

        pub inline fn config(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _config: Ct_Config) !void {
            try p.config(_cctx, _rctx, _config);
        }

        pub inline fn ct_set(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _value: u1) void {
            p.ct_set(_cctx, _rctx, _value);
        }
        pub inline fn get(comptime _cctx: Ct_Context, _rctx: *Rt_Context) u1 {
            return p.get(_cctx, _rctx);
        }
        pub inline fn set(comptime _cctx: Ct_Context, _rctx: *Rt_Context, _value: u1) void {
            p.set(_cctx, _rctx, _value);
        }

        pub inline fn toggle(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            p.toggle(_cctx, _rctx);
        }
    };
}
