pub fn IWDG(
    comptime _Ct_Context: type,
    comptime _Rt_Context: type,
    comptime _Ct_Config: type,
    comptime _Rt_Config: type,
    comptime _iwdg_fn: fn (comptime _Ct_Context: type, comptime _Rt_Context: type) type,
) type {
    const i = _iwdg_fn(_Ct_Context, _Rt_Context);
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;
        pub const Ct_Config = _Ct_Config;
        pub const Rt_Config = _Rt_Config;

        pub inline fn reg_iwdg() type {
            return i.reg_adc();
        }

        pub inline fn enable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            i.enable(_cctx, _rctx);
        }

        pub inline fn get_freq(comptime _cctx: Ct_Context, _rctx: *Rt_Context) u32 {
            return i.get_freq(_cctx, _rctx);
        }

        pub inline fn get_ct_cfg(comptime _cctx: Ct_Context) Ct_Config {
            return i.get_ct_cfg(_cctx);
        }
        pub inline fn get_rt_cfg(_rctx: *Rt_Context) ?Rt_Config {
            return i.get_rt_cfg(_rctx);
        }

        pub inline fn use(_cctx: *Ct_Context) void {
            i.use(_cctx);
        }
        pub inline fn unuse(_cctx: *Ct_Context) void {
            i.unuse(_cctx);
        }

        pub inline fn config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            try i.config(_cctx, _rctx);
        }

        pub inline fn feed(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            i.feed(_cctx, _rctx);
        }
    };
}

pub fn WWDG(
    comptime _Ct_Context: type,
    comptime _Rt_Context: type,
    comptime _Ct_Config: type,
    comptime _Rt_Config: type,
    comptime _wwdg_fn: fn (comptime _Ct_Context: type, comptime _Rt_Context: type) type,
) type {
    const w = _wwdg_fn(_Ct_Context, _Rt_Context);
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;
        pub const Ct_Config = _Ct_Config;
        pub const Rt_Config = _Rt_Config;

        pub inline fn reg_wwdg() type {
            return w.reg_adc();
        }

        pub inline fn enable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            w.enable(_cctx, _rctx);
        }

        pub inline fn get_freq(comptime _cctx: Ct_Context, _rctx: *Rt_Context) u32 {
            return w.get_freq(_cctx, _rctx);
        }

        pub inline fn get_cfg(comptime _cctx: Ct_Context, _rctx: *Rt_Context) struct { Ct_Config, ?Rt_Config } {
            return w.get_cfg(_cctx, _rctx);
        }

        pub inline fn use(_cctx: *Ct_Context) void {
            w.use(_cctx);
        }
        pub inline fn unuse(_cctx: *Ct_Context) void {
            w.unuse(_cctx);
        }

        pub fn clear_it_flag(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            w.clear_it_flag(_cctx, _rctx);
        }
        pub fn set_it_enable_bit(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            w.set_it_enable_bit(_cctx, _rctx);
        }
        pub fn clear_it_enable_bit(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            w.clear_it_enable_bit(_cctx, _rctx);
        }

        pub inline fn config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            try w.config(_cctx, _rctx);
        }

        pub inline fn start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            w.start(_cctx, _rctx);
        }

        pub inline fn feed(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            w.feed(_cctx, _rctx);
        }

        pub inline fn it_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            w.it_start(_cctx, _rctx);
        }
        pub inline fn it_stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            w.it_stop(_cctx, _rctx);
        }
    };
}
