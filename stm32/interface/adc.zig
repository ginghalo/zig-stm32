pub fn Adc(
    comptime _Ct_Context: type,
    comptime _Rt_Context: type,
    comptime _Ct_Config: type,
    comptime _Rt_Config: type,
    comptime _Pos: type,
    comptime _Error: type,
    comptime _adc_fn: fn (comptime _Ct_Context: type, comptime _Rt_Context: type, comptime _no: _Pos.No) type,
    comptime _no: _Pos.No,
) type {
    const a = _adc_fn(_Ct_Context, _Rt_Context, _no);
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;
        pub const Ct_Config = _Ct_Config;
        pub const Rt_Config = _Rt_Config;
        pub const Pos = _Pos;
        pub const Error = _Error;

        pub inline fn reg_adc() type {
            return a.reg_adc();
        }

        pub inline fn dma_ch() type {
            return a.dma_ch();
        }

        pub inline fn enable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            a.enable(_cctx, _rctx);
        }
        pub inline fn disable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            a.disable(_cctx, _rctx);
        }

        pub inline fn adc_cycles(comptime _cctx: Ct_Context, _rctx: *Rt_Context) u32 {
            return a.adc_cycles(_cctx, _rctx);
        }

        pub inline fn get_freq(comptime _cctx: Ct_Context, _rctx: *Rt_Context) u32 {
            return a.get_freq(_cctx, _rctx);
        }

        pub inline fn get_ct_cfg(comptime _cctx: Ct_Context) Ct_Config {
            return a.get_ct_cfg(_cctx);
        }
        pub inline fn get_rt_cfg(_rctx: *Rt_Context) ?Rt_Config {
            return a.get_rt_cfg(_rctx);
        }

        pub inline fn get_no() Pos.No {
            return a.get_no();
        }

        pub inline fn use(_cctx: *Ct_Context) void {
            a.use(_cctx);
        }
        pub inline fn unuse(_cctx: *Ct_Context) void {
            a.unuse(_cctx);
        }

        pub fn clear_it_flag(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            a.clear_it_flag(_cctx, _rctx);
        }
        pub inline fn set_it_enable_bit(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            a.set_it_enable_bit(_cctx, _rctx);
        }
        pub inline fn clear_it_enable_bit(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            a.clear_it_enable_bit(_cctx, _rctx);
        }

        pub inline fn config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            try a.config(_cctx, _rctx);
        }

        pub fn regular_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            try a.regular_start(_cctx, _rctx);
        }
        pub fn injected_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            try a.injected_start(_cctx, _rctx);
        }
        pub fn stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            try a.stop(_cctx, _rctx);
        }

        pub fn calibration(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !u16 {
            return a.calibration(_cctx, _rctx);
        }
        pub inline fn regular_read(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _T: type) Error!_T {
            return a.regular_read(_cctx, _rctx, _T);
        }
        pub inline fn injected_read(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _T: type) Error![]_T {
            return a.injected_read(_cctx, _rctx, _T);
        }

        pub inline fn regular_get(comptime _cctx: Ct_Context, _rctx: *Rt_Context) u16 {
            return a.regular_get(_cctx, _rctx);
        }
        pub inline fn injected_get(comptime _cctx: Ct_Context, _rctx: *Rt_Context) []u16 {
            return a.injected_get(_cctx, _rctx);
        }

        pub fn it_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            a.it_start(_cctx, _rctx);
        }
        pub fn it_stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            a.it_stop(_cctx, _rctx);
        }

        pub fn regular_dma_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            try a.regular_dma_start(_cctx, _rctx);
        }
        pub fn injected_dma_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            try a.injected_dma_start(_cctx, _rctx);
        }
        pub fn dma_stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            a.dma_stop(_cctx, _rctx);
        }

        pub inline fn channel(comptime _ch: Pos.Channel) type {
            return a.channel(_ch);
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

        pub inline fn reg_adc() type {
            return c.reg_adc();
        }

        pub inline fn dma_ch() type {
            return c.dma_ch();
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

        pub inline fn use(_cctx: *Ct_Context) void {
            c.use(_cctx);
        }
        pub inline fn unuse(_cctx: *Ct_Context) void {
            c.unuse(_cctx);
        }

        pub inline fn smp_cycles(comptime _cctx: Ct_Context) u32 {
            return c.smp_cycles(_cctx);
        }

        pub inline fn config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            try c.config(_cctx, _rctx);
        }
    };
}
