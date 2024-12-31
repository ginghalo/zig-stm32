const ctx = @import("ctx.zig");

pub fn Uart(
    comptime _Ct_Context: type,
    comptime _Rt_Context: type,
    comptime _Ct_Config: type,
    comptime _Rt_Config: type,
    comptime _No: type,
    comptime _Error: type,
    comptime _uart_fn: fn (comptime _Ct_Context: type, comptime _Rt_Context: type, comptime _no: _No) type,
    comptime _no: _No,
) type {
    const u = _uart_fn(_Ct_Context, _Rt_Context, _no);
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;
        pub const Ct_Config = _Ct_Config;
        pub const Rt_Config = _Rt_Config;
        pub const No = _No;
        pub const Error = _Error;

        pub inline fn reg_uart() type {
            return u.reg_uart();
        }
        pub inline fn rx_dma_ch() type {
            return u.rx_dma_ch();
        }
        pub inline fn tx_dma_ch() type {
            return u.tx_dma_ch();
        }

        pub inline fn enable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            u.enable(_cctx, _rctx);
        }
        pub inline fn disable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            u.disable(_cctx, _rctx);
        }

        pub inline fn get_freq(comptime _cctx: Ct_Context, _rctx: *Rt_Context) u32 {
            return u.get_freq(_cctx, _rctx);
        }

        pub inline fn get_ct_cfg(comptime _cctx: Ct_Context) Ct_Config {
            return u.get_ct_cfg(_cctx);
        }
        pub inline fn get_rt_cfg(_rctx: *Rt_Context) ?Rt_Config {
            return u.get_rt_cfg(_rctx);
        }

        pub inline fn get_no() No {
            return u.get_no();
        }

        pub inline fn use(_cctx: *Ct_Context) void {
            u.use(_cctx);
        }
        pub inline fn unuse(_cctx: *Ct_Context) void {
            u.unuse(_cctx);
        }

        pub fn clear_it_flag(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            u.clear_it_flag(_cctx, _rctx);
        }
        pub inline fn set_it_enable_bit(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            u.set_it_enable_bit(_cctx, _rctx);
        }
        pub inline fn clear_it_enable_bit(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            u.clear_it_enable_bit(_cctx, _rctx);
        }

        pub inline fn config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            try u.config(_cctx, _rctx);
        }

        pub inline fn write(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _T: type, _data: []const _T) Error!void {
            return u.write(_cctx, _rctx, _T, _data);
        }
        pub inline fn read(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _T: type, _data: []_T) Error!void {
            return u.read(_cctx, _rctx, _T, _data);
        }

        pub fn it_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            u.it_start(_cctx, _rctx);
        }
        pub fn it_stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            u.it_stop(_cctx, _rctx);
        }

        pub fn dma_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            try u.dma_start(_cctx, _rctx);
        }
        pub fn dma_stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            u.dma_stop(_cctx, _rctx);
        }
    };
}
