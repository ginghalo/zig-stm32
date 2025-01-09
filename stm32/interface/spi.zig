pub fn Spi(
    comptime _Ct_Context: type,
    comptime _Rt_Context: type,
    comptime _Ct_Config: type,
    comptime _Rt_Config: type,
    comptime _No: type,
    comptime _Error: type,
    comptime _spi_fn: fn (comptime _Ct_Context: type, comptime _Rt_Context: type, comptime _no: _No) type,
    comptime _no: _No,
) type {
    const s = _spi_fn(_Ct_Context, _Rt_Context, _no);
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;
        pub const Ct_Config = _Ct_Config;
        pub const Rt_Config = _Rt_Config;
        pub const No = _No;
        pub const Error = _Error;

        pub fn reg_spi() type {
            return s.reg_spi();
        }
        pub inline fn rx_dma_ch() type {
            return s.rx_dma_ch();
        }
        pub inline fn tx_dma_ch() type {
            return s.tx_dma_ch();
        }

        pub inline fn enable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            s.enable(_cctx, _rctx);
        }
        pub inline fn disable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            s.disable(_cctx, _rctx);
        }

        pub inline fn get_freq(comptime _cctx: Ct_Context, _rctx: *Rt_Context) u32 {
            return s.get_freq(_cctx, _rctx);
        }

        pub inline fn get_ct_cfg(comptime _cctx: Ct_Context) Ct_Config {
            return s.get_ct_cfg(_cctx);
        }
        pub inline fn get_rt_cfg(_rctx: *Rt_Context) ?Rt_Config {
            return s.get_rt_cfg(_rctx);
        }

        pub inline fn get_no() No {
            return s.get_no();
        }

        pub inline fn use(_cctx: *Ct_Context) void {
            s.use(_cctx);
        }
        pub inline fn unuse(_cctx: *Ct_Context) void {
            s.unuse(_cctx);
        }

        pub fn clear_it_flag(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            s.clear_it_flag(_cctx, _rctx);
        }
        pub inline fn set_it_enable_bit(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            s.set_it_enable_bit(_cctx, _rctx);
        }
        pub inline fn clear_it_enable_bit(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            s.clear_it_enable_bit(_cctx, _rctx);
        }

        pub inline fn config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            try s.config(_cctx, _rctx);
        }

        pub inline fn write_read(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _T: type, _rx_data: []_T, _tx_data: []const _T) Error!void {
            return s.write_read(_cctx, _rctx, _T, _rx_data, _tx_data);
        }
        pub inline fn write(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _T: type, _data: []const _T) Error!void {
            return s.write(_cctx, _rctx, _T, _data);
        }
        pub inline fn write_Ntimes(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _T: type, _data: []const _T, _size: usize) Error!void {
            return s.write_Ntimes(_cctx, _rctx, _T, _data, _size);
        }
        pub inline fn read(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _T: type, _data: []_T) Error!void {
            return s.read(_cctx, _rctx, _T, _data);
        }

        pub fn it_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            s.it_start(_cctx, _rctx);
        }
        pub fn it_stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            s.it_stop(_cctx, _rctx);
        }

        pub fn dma_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            try s.dma_start(_cctx, _rctx);
        }
        pub fn dma_stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            s.dma_stop(_cctx, _rctx);
        }
    };
}
