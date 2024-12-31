pub fn Dma(
    comptime _Ct_Context: type,
    comptime _Rt_Context: type,
    comptime _Ct_Config: type,
    comptime _Rt_Config: type,
    comptime _Pos: type,
    comptime _Error: type,
    comptime _dma_fn: fn (comptime _Ct_Context: type, comptime _Rt_Context: type, comptime _no: _Pos.No) type,
    comptime _no: _Pos.No,
) type {
    const d = _dma_fn(_Ct_Context, _Rt_Context, _no);
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;
        pub const Ct_Config = _Ct_Config;
        pub const Rt_Config = _Rt_Config;
        pub const Pos = _Pos;
        pub const Error = _Error;

        pub inline fn reg_dma() type {
            return d.reg_dma();
        }

        pub inline fn enable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            d.enable(_cctx, _rctx);
        }
        pub inline fn disable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            d.disable(_cctx, _rctx);
        }

        pub inline fn get_freq(comptime _cctx: Ct_Context, _rctx: *Rt_Context) u32 {
            return d.get_freq(_cctx, _rctx);
        }

        pub inline fn get_ct_cfg(comptime _cctx: Ct_Context) Ct_Config {
            return d.get_ct_cfg(_cctx);
        }
        pub inline fn get_rt_cfg(_rctx: *Rt_Context) ?Rt_Config {
            return d.get_rt_cfg(_rctx);
        }

        pub inline fn use(_cctx: *Ct_Context) void {
            d.use(_cctx);
        }
        pub inline fn unuse(_cctx: *Ct_Context) void {
            d.unuse(_cctx);
        }

        pub inline fn config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            try d.config(_cctx, _rctx);
        }

        pub inline fn channel(comptime _ch: Pos.Channel) type {
            return d.channel(_ch);
        }
    };
}
pub fn Ch(
    comptime _Ct_Context: type,
    comptime _Rt_Context: type,
    comptime _Ct_Config: type,
    comptime _Rt_Config: type,
    comptime _Pos: type,
    comptime _Error: type,
    comptime _ch_fn: fn (comptime _Ct_Context: type, comptime _Rt_Context: type, comptime _pos: _Pos) type,
    comptime _pos: _Pos,
) type {
    const c = _ch_fn(_Ct_Context, _Rt_Context, _pos);
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;
        pub const Ct_Config = _Ct_Config;
        pub const Rt_Config = _Rt_Config;
        pub const Pos = _Pos;
        pub const Error = _Error;

        pub inline fn reg_dma() type {
            return c.reg_dma();
        }

        pub inline fn enable() void {
            c.enable();
        }
        pub inline fn disable() void {
            c.disable();
        }

        pub inline fn get_ct_cfg(comptime _cctx: Ct_Context) Ct_Config {
            return c.get_ct_cfg(_cctx);
        }
        pub inline fn get_rt_cfg(_rctx: *Rt_Context) ?Rt_Config {
            return c.get_rt_cfg(_rctx);
        }

        pub inline fn get_pos() Pos {
            return c.get_pos();
        }

        pub inline fn check_use(_cctx: *Ct_Context) ?Ct_Config {
            return c.check_use(_cctx);
        }
        pub inline fn assert_use(_cctx: *Ct_Context) void {
            c.assert_use(_cctx);
        }
        pub inline fn use(_cctx: *Ct_Context, comptime _cfg: Ct_Config) void {
            c.use(_cctx, _cfg);
        }
        pub inline fn unuse(_cctx: *Ct_Context) void {
            c.unuse(_cctx);
        }

        pub fn clear_it_flag(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            c.clear_it_flag(_cctx, _rctx);
        }
        pub inline fn set_it_enable_bit(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            c.set_it_enable_bit(_cctx, _rctx);
        }
        pub inline fn clear_it_enable_bit(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            c.clear_it_enable_bit(_cctx, _rctx);
        }

        pub inline fn config(comptime _cctx: Ct_Context, _rctx: *Rt_Context, _rt_config: Rt_Config) !void {
            try c.config(_cctx, _rctx, _rt_config);
        }

        pub inline fn start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            c.start(_cctx, _rctx);
        }
        pub inline fn stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            c.stop(_cctx, _rctx);
        }
    };
}
