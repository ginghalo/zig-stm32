pub fn Clock(
    comptime _Ct_Context: type,
    comptime _Rt_Context: type,
    comptime _Ct_Config: type,
    comptime _Rt_Config: type,
    comptime _Frequency: type,
    comptime _Error: type,
    comptime _clock_fn: fn (comptime _Ct_Context: type, comptime _Rt_Context: type) type,
) type {
    const c = _clock_fn(_Ct_Context, _Rt_Context);
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;
        pub const Ct_Config = _Ct_Config;
        pub const Rt_Config = _Rt_Config;
        pub const Frequency = _Frequency;
        pub const Error = _Error;

        pub inline fn get_ct_cfg(comptime _cctx: Ct_Context) Ct_Config {
            return c.get_ct_cfg(_cctx);
        }
        pub inline fn get_rt_cfg(_rctx: *Rt_Context) ?Rt_Config {
            return c.get_rt_cfg(_rctx);
        }
        pub inline fn get_sysclk(comptime _cctx: Ct_Context) u32 {
            return c.get_sysclk(_cctx);
        }
        pub inline fn get_hclk(comptime _cctx: Ct_Context) u32 {
            return c.get_hclk(_cctx);
        }
        pub inline fn get_pclk(comptime _cctx: Ct_Context) []u32 {
            return c.get_pclk(_cctx);
        }
        pub inline fn get_freq(comptime _cctx: Ct_Context) Frequency {
            return c.get_freq(_cctx);
        }

        pub inline fn use(_cctx: *Ct_Context) void {
            c.use(_cctx);
        }
        pub inline fn unuse(_cctx: *Ct_Context) void {
            c.unuse(_cctx);
        }

        pub inline fn config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            try c.config(_cctx, _rctx);
        }
    };
}

pub fn Tick(
    comptime _Ct_Context: type,
    comptime _Rt_Context: type,
    comptime _Ct_Config: type,
    comptime _Rt_Config: type,
    comptime _Error: type,
    comptime _tick_fn: fn (comptime _Ct_Context: type, comptime _Rt_Context: type) type,
) type {
    const t = _tick_fn(_Ct_Context, _Rt_Context);
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;
        pub const Ct_Config = _Ct_Config;
        pub const Rt_Config = _Rt_Config;
        pub const Error = _Error;

        pub inline fn get_freq(comptime _cctx: Ct_Context) u32 {
            return t.get_freq(_cctx);
        }

        pub inline fn get_ct_cfg(comptime _cctx: Ct_Context) Ct_Config {
            return t.get_ct_cfg(_cctx);
        }
        pub inline fn get_rt_cfg(_rctx: *Rt_Context) ?Rt_Config {
            return t.get_rt_cfg(_rctx);
        }

        pub fn clear_it_flag(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            t.clear_it_flag(_cctx, _rctx);
        }
        pub inline fn set_it_enable_bit(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            t.set_it_enable_bit(_cctx, _rctx);
        }
        pub inline fn clear_it_enable_bit(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            t.clear_it_enable_bit(_cctx, _rctx);
        }

        pub inline fn config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            try t.config(_cctx, _rctx);
        }

        pub inline fn start(comptime _cctx: Ct_Context, _rctx: *Rt_Context, _load: u24) void {
            t.start(_cctx, _rctx, _load);
        }
        pub inline fn reset(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            t.reset(_cctx, _rctx);
        }
        pub inline fn stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            t.stop(_cctx, _rctx);
        }
        pub inline fn get(comptime _cctx: Ct_Context, _rctx: *Rt_Context) u24 {
            return t.get(_cctx, _rctx);
        }
        pub inline fn finished(comptime _cctx: Ct_Context, _rctx: *Rt_Context) bool {
            return t.finished(_cctx, _rctx);
        }
        pub inline fn wait(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            t.wait(_cctx, _rctx);
        }

        pub inline fn delay(comptime _cctx: Ct_Context, _rctx: *Rt_Context, _load: u24) void {
            t.delay(_cctx, _rctx, _load);
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

        pub inline fn it_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            t.it_start(_cctx, _rctx);
        }
        pub inline fn it_stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            t.it_stop(_cctx, _rctx);
        }
    };
}
