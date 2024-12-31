pub fn Tim(
    comptime _Ct_Context: type,
    comptime _Rt_Context: type,
    comptime _Ct_Config: type,
    comptime _Rt_Config: type,
    comptime _Pos: type,
    comptime _Error: type,
    comptime _tim_fn: fn (comptime _Ct_Context: type, comptime _Rt_Context: type, comptime _no: _Pos.No) type,
    comptime _no: _Pos.No,
) type {
    const t = _tim_fn(_Ct_Context, _Rt_Context, _no);
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;
        pub const Ct_Config = _Ct_Config;
        pub const Rt_Config = _Rt_Config;
        pub const Pos = _Pos;
        pub const Error = _Error;
        pub inline fn reg_tim() type {
            return t.reg_tim();
        }

        pub inline fn dma_ch() type {
            return t.dma_ch();
        }

        pub inline fn enable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            t.enable(_cctx, _rctx);
        }
        pub inline fn disable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            t.disable(_cctx, _rctx);
        }

        pub inline fn channel(comptime _ch: Pos.Channel) type {
            return t.channel(_ch);
        }

        pub inline fn get_freq(comptime _cctx: Ct_Context, _rctx: *Rt_Context) u32 {
            return t.get_freq(_cctx, _rctx);
        }
        pub inline fn get_ct_cfg(comptime _cctx: Ct_Context) Ct_Config {
            return t.get_ct_cfg(_cctx);
        }
        pub inline fn get_rt_cfg(_rctx: *Rt_Context) ?Rt_Config {
            return t.get_rt_cfg(_rctx);
        }

        pub inline fn get_no() Pos.No {
            return t.get_no();
        }

        pub inline fn use(_cctx: *Ct_Context) void {
            t.use(_cctx);
        }
        pub inline fn unuse(_cctx: *Ct_Context) void {
            t.unuse(_cctx);
        }

        pub fn clear_it_flag(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            t.clear_it_flag(_cctx, _rctx);
        }
        pub fn set_it_enable_bit(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            t.set_it_enable_bit(_cctx, _rctx);
        }
        pub fn clear_it_enable_bit(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            t.clear_it_enable_bit(_cctx, _rctx);
        }

        pub inline fn config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            try t.config(_cctx, _rctx);
        }

        pub inline fn start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            t.start(_cctx, _rctx);
        }
        pub inline fn reset(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            t.reset(_cctx, _rctx);
        }
        pub inline fn update(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            t.update(_cctx, _rctx);
        }
        pub inline fn stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            t.stop(_cctx, _rctx);
        }
        pub inline fn set(comptime _cctx: Ct_Context, _rctx: *Rt_Context, _cnt: u16) void {
            return t.set(_cctx, _rctx, _cnt);
        }
        pub inline fn get(comptime _cctx: Ct_Context, _rctx: *Rt_Context) u16 {
            return t.get(_cctx, _rctx);
        }
        pub inline fn finished(comptime _cctx: Ct_Context, _rctx: *Rt_Context) bool {
            return t.finished(_cctx, _rctx);
        }
        pub inline fn wait(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            t.wait(_cctx, _rctx);
        }

        pub inline fn delay(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            t.delay(_cctx, _rctx);
        }

        pub inline fn delay_us(comptime _cctx: Ct_Context, _rctx: *Rt_Context, _us: u64) void {
            t.delay_us(_cctx, _rctx, _us);
        }

        pub inline fn wait_until(
            comptime _cctx: Ct_Context,
            _rctx: *Rt_Context,
            _load: u24,
            comptime _T: type,
            comptime _ptr: *volatile _T,
            comptime _name: []const u8,
            comptime _value: @TypeOf(@field(_ptr, _name)),
            comptime _eql_fn: ?fn (_v1: @TypeOf(_value), _v2: @TypeOf(_value)) bool,
        ) Error!void {
            return t.wait_until(_cctx, _rctx, _load, _T, _ptr, _name, _value, _eql_fn);
        }

        pub inline fn modify_until_done(
            comptime _cctx: Ct_Context,
            _rctx: *Rt_Context,
            _load: u24,
            comptime _T: type,
            comptime _ptr: *volatile _T,
            comptime _value: anytype,
            comptime _eql_fn: ?fn (_v1: _T, _v2: _T) bool,
        ) Error!void {
            return t.modify_until_done(_cctx, _rctx, _load, _T, _ptr, _value, _eql_fn);
        }

        pub fn it_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            t.it_start(_cctx, _rctx);
        }
        pub fn it_stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            t.it_stop(_cctx, _rctx);
        }

        pub fn dma_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            try t.dma_start(_cctx, _rctx);
        }
        pub fn dma_stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            t.dma_stop(_cctx, _rctx);
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
        pub inline fn reg_tim() type {
            return c.reg_tim();
        }

        pub inline fn dma_ch() type {
            return c.dma_ch();
        }

        pub inline fn enable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            return c.enable(_cctx, _rctx);
        }
        pub inline fn disable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            return c.enable(_cctx, _rctx);
        }

        pub inline fn get_cfg(comptime _cctx: Ct_Context, _rctx: *Rt_Context) struct { Ct_Config, ?Rt_Config } {
            return c.get_cfg(_cctx, _rctx);
        }

        pub inline fn get_pos() Pos {
            return c.get_Pos();
        }

        pub inline fn use(_cctx: *Ct_Context) void {
            c.use(_cctx);
        }
        pub inline fn unuse(_cctx: *Ct_Context) void {
            c.unuse(_cctx);
        }

        pub fn clear_it_flag(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            c.clear_it_flag(_cctx, _rctx);
        }
        pub fn set_it_enable_bit(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            c.set_it_enable_bit(_cctx, _rctx);
        }
        pub fn clear_it_enable_bit(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            c.clear_it_enable_bit(_cctx, _rctx);
        }

        pub inline fn config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            try c.config(_cctx, _rctx);
        }

        pub inline fn set(comptime _cctx: Ct_Context, _rctx: *Rt_Context, _cnt: u16) void {
            c.set(_cctx, _rctx, _cnt);
        }
        pub inline fn get(comptime _cctx: Ct_Context, _rctx: *Rt_Context) u16 {
            return c.get(_cctx, _rctx);
        }

        pub inline fn start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            c.start(_cctx, _rctx);
        }
        pub inline fn stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            c.stop(_cctx, _rctx);
        }

        pub fn it_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            c.it_start(_cctx, _rctx);
        }
        pub fn it_stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            c.it_stop(_cctx, _rctx);
        }

        pub fn dma_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            c.dma_start(_cctx, _rctx);
        }
        pub fn dma_stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            c.dma_stop(_cctx, _rctx);
        }
    };
}
