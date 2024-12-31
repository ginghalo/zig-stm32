pub fn Pwr(
    comptime _Ct_Context: type,
    comptime _Rt_Context: type,
    comptime _Ct_Config: type,
    comptime _Rt_Config: type,
    comptime _Error: type,
    comptime _pwr_fn: fn (comptime _Ct_Context: type, comptime _Rt_Context: type) type,
) type {
    const p = _pwr_fn(_Ct_Context, _Rt_Context);
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;
        pub const Ct_Config = _Ct_Config;
        pub const Rt_Config = _Rt_Config;
        pub const Error = _Error;

        pub inline fn reg_pwr() type {
            return p.reg_pwr();
        }

        pub fn enable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            p.enable(_cctx, _rctx);
        }
        pub fn disable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            p.disable(_cctx, _rctx);
        }

        pub inline fn get_ct_cfg(comptime _cctx: Ct_Context) Ct_Config {
            return p.get_ct_cfg(_cctx);
        }
        pub inline fn get_rt_cfg(_rctx: *Rt_Context) ?Rt_Config {
            return p.get_rt_cfg(_rctx);
        }

        pub inline fn use(_cctx: *Ct_Context) void {
            p.use(_cctx);
        }
        pub inline fn unuse(_cctx: *Ct_Context) void {
            p.unuse(_cctx);
        }

        pub fn clear_it_flag(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            p.clear_it_flag(_cctx, _rctx);
        }
        pub fn set_it_enable_bit(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            p.set_it_enable_bit(_cctx, _rctx);
        }
        pub fn clear_it_enable_bit(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            p.clear_it_enable_bit(_cctx, _rctx);
        }

        pub inline fn config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            try p.config(_cctx, _rctx);
        }

        pub fn it_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            p.it_start(_cctx, _rctx);
        }
        pub fn it_stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            p.it_stop(_cctx, _rctx);
        }

        pub inline fn wfi(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            p.wfi(_cctx, _rctx);
        }
        pub inline fn wfe(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            p.wfe(_cctx, _rctx);
        }
    };
}

pub fn Bkp(
    comptime _Ct_Context: type,
    comptime _Rt_Context: type,
    comptime _Ct_Config: type,
    comptime _Rt_Config: type,
    comptime _No: type,
    comptime _Error: type,
    comptime _bkp_fn: fn (comptime _Ct_Context: type, comptime _Rt_Context: type) type,
) type {
    const b = _bkp_fn(_Ct_Context, _Rt_Context);
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;
        pub const Ct_Config = _Ct_Config;
        pub const Rt_Config = _Rt_Config;
        pub const No = _No;
        pub const Error = _Error;

        pub inline fn reg_bkp() type {
            return b.reg_bkp();
        }

        pub fn enable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            b.enable(_cctx, _rctx);
        }
        pub fn disable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            b.disable(_cctx, _rctx);
        }

        pub inline fn get_ct_cfg(comptime _cctx: Ct_Context) Ct_Config {
            return b.get_ct_cfg(_cctx);
        }
        pub inline fn get_rt_cfg(_rctx: *Rt_Context) ?Rt_Config {
            return b.get_rt_cfg(_rctx);
        }

        pub inline fn use(_cctx: *Ct_Context) void {
            b.use(_cctx);
        }
        pub inline fn unuse(_cctx: *Ct_Context) void {
            b.unuse(_cctx);
        }

        pub fn clear_it_flag(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            b.clear_it_flag(_cctx, _rctx);
        }
        pub fn set_it_enable_bit(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            b.set_it_enable_bit(_cctx, _rctx);
        }
        pub fn clear_it_enable_bit(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            b.clear_it_enable_bit(_cctx, _rctx);
        }

        pub inline fn config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            try b.config(_cctx, _rctx);
        }

        pub fn get(comptime _cctx: Ct_Context, _rctx: *Rt_Context, _no: _No) u16 {
            return b.get(_cctx, _rctx, _no);
        }

        pub fn cmpt_get(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _no: _No) u16 {
            return b.cmpt_get(_cctx, _rctx, _no);
        }
    };
}
pub fn Rtc(
    comptime _Ct_Context: type,
    comptime _Rt_Context: type,
    comptime _Ct_Config: type,
    comptime _Rt_Config: type,
    comptime _Error: type,
    comptime _rtc_fn: fn (comptime _Ct_Context: type, comptime _Rt_Context: type) type,
) type {
    const r = _rtc_fn(_Ct_Context, _Rt_Context);
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;
        pub const Ct_Config = _Ct_Config;
        pub const Rt_Config = _Rt_Config;
        pub const Error = _Error;

        pub inline fn reg_rtc() type {
            return r.reg_rtc();
        }

        pub inline fn enable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            r.enable(_cctx, _rctx);
        }
        pub inline fn disable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            r.disable(_cctx, _rctx);
        }

        pub inline fn get_freq(comptime _cctx: Ct_Context, _rctx: *Rt_Context) u32 {
            return r.get_freq(_cctx, _rctx);
        }

        pub inline fn get_ct_cfg(comptime _cctx: Ct_Context) Ct_Config {
            return r.get_ct_cfg(_cctx);
        }
        pub inline fn get_rt_cfg(_rctx: *Rt_Context) ?Rt_Config {
            return r.get_rt_cfg(_rctx);
        }

        pub inline fn use(_cctx: *Ct_Context) void {
            r.use(_cctx);
        }
        pub inline fn unuse(_cctx: *Ct_Context) void {
            r.unuse(_cctx);
        }

        pub fn clear_it_flag(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            r.clear_it_flag(_cctx, _rctx);
        }
        pub fn set_it_enable_bit(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            r.set_it_enable_bit(_cctx, _rctx);
        }
        pub fn clear_it_enable_bit(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            r.clear_it_enable_bit(_cctx, _rctx);
        }

        pub inline fn config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            try r.config(_cctx, _rctx);
        }

        pub fn set(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            r.set(_cctx, _rctx);
        }
        pub inline fn get(comptime _cctx: Ct_Context, _rctx: *Rt_Context) u32 {
            return r.get(_cctx, _rctx);
        }
        pub fn delay(comptime _cctx: Ct_Context, _rctx: *Rt_Context, _cnt: u32) void {
            r.delay(_cctx, _rctx, _cnt);
        }

        pub fn it_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            r.it_start(_cctx, _rctx);
        }
        pub fn it_stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            r.it_stop(_cctx, _rctx);
        }
    };
}
