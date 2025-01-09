pub fn I2c(
    comptime _Ct_Context: type,
    comptime _Rt_Context: type,
    comptime _Ct_Config: type,
    comptime _Rt_Config: type,
    comptime _No: type,
    comptime _Error: type,
    comptime _DevBitSize: type,
    comptime _DevUBitSize: fn (comptime _dev_bitsize: _DevBitSize) type,
    comptime _MemBitSize: type,
    comptime _MemUBitSize: fn (comptime _mem_bitsize: _MemBitSize) type,
    comptime _i2c_fn: fn (comptime _Ct_Context: type, comptime _Rt_Context: type, comptime _no: _No) type,
    comptime _no: _No,
) type {
    const i = _i2c_fn(_Ct_Context, _Rt_Context, _no);
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;
        pub const Ct_Config = _Ct_Config;
        pub const Rt_Config = _Rt_Config;
        pub const No = _No;
        pub const Error = _Error;
        pub const DevBitSize = _DevBitSize;
        pub const MemBitSize = _MemBitSize;

        pub inline fn reg_i2c() type {
            return i.reg_i2c();
        }
        pub inline fn rx_dma_ch() type {
            return i.rx_dma_ch();
        }
        pub inline fn tx_dma_ch() type {
            return i.tx_dma_ch();
        }

        pub inline fn enable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            i.enable(_cctx, _rctx);
        }
        pub inline fn disable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            i.disable(_cctx, _rctx);
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

        pub inline fn get_no() No {
            return i.get_no();
        }

        pub inline fn use(_cctx: *Ct_Context) void {
            i.use(_cctx);
        }
        pub inline fn unuse(_cctx: *Ct_Context) void {
            i.unuse(_cctx);
        }

        pub fn clear_it_flag(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            i.clear_it_flag(_cctx, _rctx);
        }
        pub inline fn set_it_enable_bit(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            i.set_it_enable_bit(_cctx, _rctx);
        }
        pub inline fn clear_it_enable_bit(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            i.clear_it_enable_bit(_cctx, _rctx);
        }

        pub inline fn config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            try i.config(_cctx, _rctx);
        }

        pub inline fn master_write(
            comptime _cctx: Ct_Context,
            _rctx: *Rt_Context,
            comptime _bitsize: DevBitSize,
            _addr: _DevUBitSize(_bitsize),
            comptime _T: type,
            _data: []const _T,
        ) Error!void {
            return i.master_write(_cctx, _rctx, _bitsize, _addr, _T, _data);
        }
        pub inline fn master_write_Ntimes(
            comptime _cctx: Ct_Context,
            _rctx: *Rt_Context,
            comptime _bitsize: DevBitSize,
            _addr: _DevUBitSize(_bitsize),
            comptime _T: type,
            _data: []const _T,
            _times: usize,
        ) Error!void {
            return i.master_write_Ntimes(_cctx, _rctx, _bitsize, _addr, _T, _data, _times);
        }
        pub inline fn master_read(
            comptime _cctx: Ct_Context,
            _rctx: *Rt_Context,
            comptime _bitsize: DevBitSize,
            _addr: _DevUBitSize(_bitsize),
            comptime _T: type,
            _data: []_T,
        ) Error!void {
            return i.master_read(_cctx, _rctx, _bitsize, _addr, _T, _data);
        }

        pub inline fn slave_write(
            comptime _cctx: Ct_Context,
            _rctx: *Rt_Context,
            comptime _dev_bitsize: DevBitSize,
            comptime _T: type,
            _data: []const _T,
        ) Error!void {
            return i.slave_write(_cctx, _rctx, _dev_bitsize, _T, _data);
        }
        pub inline fn slave_read(
            comptime _cctx: Ct_Context,
            _rctx: *Rt_Context,
            comptime _dev_bitsize: DevBitSize,
            comptime _T: type,
            _data: []_T,
        ) Error!void {
            return i.slave_read(_cctx, _rctx, _dev_bitsize, _T, _data);
        }

        pub inline fn mem_write(
            comptime _cctx: Ct_Context,
            _rctx: *Rt_Context,
            comptime _dev_bitsize: DevBitSize,
            _dev_addr: _DevUBitSize(_dev_bitsize),
            comptime _mem_bitsize: MemBitSize,
            _mem_addr: _MemUBitSize(_mem_bitsize),
            comptime _T: type,
            _data: []const _T,
        ) Error!void {
            return i.mem_write(_cctx, _rctx, _dev_bitsize, _dev_addr, _mem_bitsize, _mem_addr, _T, _data);
        }
        pub inline fn mem_write_Ntimes(
            comptime _cctx: Ct_Context,
            _rctx: *Rt_Context,
            comptime _dev_bitsize: DevBitSize,
            _dev_addr: _DevUBitSize(_dev_bitsize),
            comptime _mem_bitsize: MemBitSize,
            _mem_addr: _MemUBitSize(_mem_bitsize),
            comptime _T: type,
            _data: []const _T,
            _times: usize,
        ) Error!void {
            return i.mem_write_Ntimes(_cctx, _rctx, _dev_bitsize, _dev_addr, _mem_bitsize, _mem_addr, _T, _data, _times);
        }
        pub inline fn mem_read(
            comptime _cctx: Ct_Context,
            _rctx: *Rt_Context,
            comptime _dev_bitsize: DevBitSize,
            _dev_addr: _DevUBitSize(_dev_bitsize),
            comptime _mem_bitsize: _MemBitSize,
            _mem_addr: _MemUBitSize(_mem_bitsize),
            comptime _T: type,
            _data: []_T,
        ) Error!void {
            return i.mem_read(_cctx, _rctx, _dev_bitsize, _dev_addr, _mem_bitsize, _mem_addr, _T, _data);
        }

        pub fn slave_it_start(
            comptime _cctx: Ct_Context,
            _rctx: *Rt_Context,
        ) !void {
            try i.slave_it_start(_cctx, _rctx);
        }
        pub fn master_it_start(
            comptime _cctx: Ct_Context,
            _rctx: *Rt_Context,
            comptime _bitsize: DevBitSize,
            _addr: _DevUBitSize(_bitsize),
        ) !void {
            try i.master_it_start(_cctx, _rctx, _bitsize, _addr);
        }
        pub fn mem_it_start(
            comptime _cctx: Ct_Context,
            _rctx: *Rt_Context,
            comptime _bitsize: DevBitSize,
            _addr: _DevUBitSize(_bitsize),
            comptime _mem_bitsize: _MemBitSize,
            _mem_addr: _MemUBitSize(_mem_bitsize),
        ) !void {
            try i.mem_it_start(_cctx, _rctx, _bitsize, _addr, _mem_bitsize, _mem_addr);
        }
        pub fn it_stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            i.it_stop(_cctx, _rctx);
        }

        pub fn slave_dma_start(
            comptime _cctx: Ct_Context,
            _rctx: *Rt_Context,
        ) !void {
            try i.slave_dma_start(_cctx, _rctx);
        }
        pub fn master_dma_start(
            comptime _cctx: Ct_Context,
            _rctx: *Rt_Context,
            comptime _bitsize: DevBitSize,
            _addr: _DevUBitSize(_bitsize),
        ) !void {
            try i.master_dma_start(_cctx, _rctx, _bitsize, _addr);
        }
        pub fn mem_dma_start(
            comptime _cctx: Ct_Context,
            _rctx: *Rt_Context,
            comptime _bitsize: DevBitSize,
            _addr: _DevUBitSize(_bitsize),
            comptime _mem_bitsize: _MemBitSize,
            _mem_addr: _MemUBitSize(_mem_bitsize),
        ) !void {
            try i.mem_dma_start(_cctx, _rctx, _bitsize, _addr, _mem_bitsize, _mem_addr);
        }
        pub fn dma_stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            i.dma_stop(_cctx, _rctx);
        }
    };
}
