const reg = @import("reg.zig");
const gpio = @import("gpio.zig");
const sys = @import("sys.zig");
const ctx = @import("ctx.zig");
const it = @import("it.zig");
const dma = @import("dma.zig");

const interface = @import("../stm32.zig").interface;
const utils = interface.utils;
const i2c = interface.i2c;

pub var i2c_its: [NO_NUMS]I2c_Its = .{.{}} ** NO_NUMS;
pub const I2c_Its = struct {
    ev_it: ?*const fn () void = null,
    err_it: ?*const fn () void = null,
};

pub const @"1" = I2c(.@"1");
pub const @"2" = I2c(.@"2");

pub const No = enum { @"1", @"2" };
pub const NO_NUMS = @typeInfo(No).Enum.fields.len;

pub const I2c_Ct_Context: type = CONTEXT: {
    const __Context__std__ = @import("std");
    const __Context__StructField__ = __Context__std__.builtin.Type.StructField;
    const __Context__comptimePrint__ = __Context__std__.fmt.comptimePrint;
    break :CONTEXT @Type(.{ .Struct = .{
        .layout = .auto,
        .is_tuple = false,
        .decls = &.{},
        .fields = FIELDS: {
            var fields: [NO_NUMS]__Context__StructField__ = undefined;
            for (&fields, 1..) |*field, i| {
                field.* = .{
                    .name = __Context__comptimePrint__("cfg{d}", .{i}),
                    .type = ?I2c_Ct_Config,
                    .default_value = @ptrCast(&@as(?I2c_Ct_Config, null)),
                    .is_comptime = false,
                    .alignment = @alignOf(?I2c_Ct_Config),
                };
            }
            break :FIELDS &fields;
        },
    } });
};
pub const I2c_Rt_Context: type = CONTEXT: {
    const __Context__std__ = @import("std");
    const __Context__StructField__ = __Context__std__.builtin.Type.StructField;
    const __Context__comptimePrint__ = __Context__std__.fmt.comptimePrint;
    break :CONTEXT @Type(.{ .Struct = .{
        .layout = .auto,
        .is_tuple = false,
        .decls = &.{},
        .fields = FIELDS: {
            var fields: [NO_NUMS]__Context__StructField__ = undefined;
            for (&fields, 1..) |*field, i| {
                field.* = .{
                    .name = __Context__comptimePrint__("cfg{d}", .{i}),
                    .type = ?I2c_Rt_Config,
                    .default_value = @ptrCast(&@as(?I2c_Rt_Config, null)),
                    .is_comptime = false,
                    .alignment = @alignOf(?I2c_Rt_Config),
                };
            }
            break :FIELDS &fields;
        },
    } });
};

pub const DevBitSize = enum { @"7bit", @"10bit" };
pub const MemBitSize = enum { @"8bit", @"16bit" };

pub const I2c_Ct_Config = struct {
    mode: Mode = .{ .standard = .{} },
    addr: Address = .{ .@"7bit" = .{} },
    scratch: Scratch = .disable,
    general_call: GenaralCall = .disable,

    /// Must NOT change it, it's operated by programming
    scl_shared_count: u32 = 0,
    /// Must NOT change it, it's operated by programming
    sda_shared_count: u32 = 0,

    i2c_it: ?I2c_It = null,
    i2c_dma: ?I2c_Dma = null,

    pub const Mode = union(enum) {
        standard: Standard,
        fast: Fast,

        pub const Standard = struct {
            speed: u32 = 100_000,
        };
        pub const Fast = struct {
            speed: u32 = 400_000,
            duty: Duty = .@"2/1",
            pub const Duty = enum(u1) { @"2/1", @"16/9" };
        };
    };
    pub const Address = union(enum) {
        @"7bit": @"7bit",
        @"10bit": @"10bit",

        pub const @"7bit" = struct {
            addr1: u7 = 0,
            addr2: ?u7 = null,
        };
        pub const @"10bit" = struct {
            addr: u10 = 0,
            pub fn to_tuple(self: @"10bit") struct { u1, u7, u2 } {
                return @bitCast(self.addr);
            }
        };
    };
    pub const Scratch = enum { enable, disable };
    pub const GenaralCall = enum { enable, disable };

    pub const I2c_It = struct {
        ev_it: ?I2c_Ev_It = null,
        err_it: ?I2c_Err_It = null,

        iteven: Evie = .disable,
        itbufen: Bufie = .disable,
        iterren: Errie = .disable,

        pub const I2c_Ev_It = struct {
            gf: *const fn (comptime _ctx: ctx.Ct_Context) fn () void,
            nvic_cfg: it.Nvic_Config = .{},
        };
        pub const I2c_Err_It = struct {
            gf: *const fn (comptime _ctx: ctx.Ct_Context) fn () void,
            nvic_cfg: it.Nvic_Config = .{},
        };
        pub const Evie = enum(u1) { disable, enable };
        pub const Bufie = enum(u1) { disable, enable };
        pub const Errie = enum(u1) { disable, enable };
    };
    pub const I2c_Dma = struct {
        rx_cfg: ?Dma_Ch_Ct_Config = null, // PA and DIR is unless
        tx_cfg: ?Dma_Ch_Ct_Config = null, // PA and DIR is unless
        pub const Dma_Ch_Ct_Config = struct {
            it: dma.Ch_Ct_Config.Ch_It,
            pl: dma.Ch_Ct_Config.Pl = .low,
        };
    };
};
pub const I2c_Rt_Config = struct {
    // only enable when dma is started
    tx_cfg: ?Ch_Rt_Config = null,
    rx_cfg: ?Ch_Rt_Config = null,
    pub const Ch_Rt_Config = struct {
        ma: u32,
        ndt: u16,
        circ: dma.Ch_Rt_Config.Circ,
        minc: dma.Ch_Rt_Config.Minc,
    };
};

// Used in dev address request
// little endian
pub const DevAddr10bit = packed struct {
    body: u8,
    head: u2,
};

// Used in mem address request
// little endian
pub const MemAddr16bit = packed struct {
    head: u8,
    body: u8,
};

pub const Error = error{
    I2c_Time_Out,
    I2c_Ack_Fail,
    I2c_Wait_SB_Time_Out,
    I2c_Wait_ADDR_Time_Out,
    I2c_Wait_ADDR10_Time_Out,
    I2c_Wait_TXE_Time_Out,
    I2c_Wait_RXNE_Time_Out,
    I2c_Wait_BTF_Time_Out,
};

fn _I2c(comptime _Ct_Context: type, comptime _Rt_Context: type, comptime _no: No) type {
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;
        pub inline fn reg_i2c() type {
            return switch (_no) {
                .@"1" => reg.I2C1,
                .@"2" => reg.I2C2,
            };
        }

        inline fn rx_dma_ch_pos() dma.Pos {
            return switch (_no) {
                .@"1" => .{ .no = .@"1", .ch = .@"7" },
                .@"2" => .{ .no = .@"1", .ch = .@"5" },
            };
        }
        inline fn tx_dma_ch_pos() dma.Pos {
            return switch (_no) {
                .@"1" => .{ .no = .@"1", .ch = .@"6" },
                .@"2" => .{ .no = .@"1", .ch = .@"4" },
            };
        }
        pub inline fn rx_dma_ch() type {
            return dma.Ch(rx_dma_ch_pos());
        }
        pub inline fn tx_dma_ch() type {
            return dma.Ch(tx_dma_ch_pos());
        }

        pub inline fn ape_enable() void {
            switch (_no) {
                .@"1" => reg.RCC.APB1ENR.I2C1EN = 0b1,
                .@"2" => reg.RCC.APB1ENR.I2C2EN = 0b1,
            }
        }
        pub inline fn ape_disable() void {
            switch (_no) {
                .@"1" => reg.RCC.APB1ENR.I2C1EN = 0,
                .@"2" => reg.RCC.APB1ENR.I2C2EN = 0,
            }
        }
        pub inline fn gpio_enable() void {
            switch (_no) {
                .@"1" => gpio.B.enable(),
                .@"2" => gpio.B.enable(),
            }
        }

        inline fn sda_pin() type {
            return switch (_no) {
                .@"1" => gpio.B.pin(.@"7"),
                .@"2" => gpio.B.pin(.@"11"),
            };
        }
        inline fn scl_pin() type {
            return switch (_no) {
                .@"1" => gpio.B.pin(.@"6"),
                .@"2" => gpio.B.pin(.@"10"),
            };
        }

        pub inline fn enable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;

            ape_enable();
            gpio_enable();
        }
        pub inline fn disable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;

            ape_disable();
        }

        pub inline fn get_freq(comptime _cctx: Ct_Context) u32 {
            return comptime switch (_no) {
                .@"1" => sys.clock.get_freq(_cctx).pclk1,
                .@"2" => sys.clock.get_freq(_cctx).pclk1,
            };
        }

        pub inline fn get_ct_cfg(comptime _cctx: Ct_Context) I2c_Ct_Config {
            return comptime @field(_cctx.i2c, "cfg" ++ @tagName(_no)).?;
        }
        pub inline fn get_rt_cfg(_rctx: *Rt_Context) ?I2c_Rt_Config {
            return switch (_no) {
                .@"1" => _rctx.i2c.cfg1,
                .@"2" => _rctx.i2c.cfg2,
            };
        }

        pub inline fn get_no() No {
            return _no;
        }

        inline fn get_sda_pin_config() gpio.Pin_Ct_Config {
            return comptime .{ .Output = .{ .mode = .AFOD, .speed = .@"50MHz" } };
        }
        inline fn get_scl_pin_config() gpio.Pin_Ct_Config {
            return comptime .{ .Output = .{ .mode = .AFOD, .speed = .@"50MHz" } };
        }
        inline fn get_rx_dma_ch_config(comptime _cctx: Ct_Context) ?dma.Ch_Ct_Config {
            const ct_cfg = comptime get_ct_cfg(_cctx);
            if (ct_cfg.i2c_dma) |i2c_dma| {
                if (i2c_dma.rx_cfg) |cc| {
                    return dma.Ch_Ct_Config{
                        .dir = .peripheral,
                        .ch = rx_dma_ch_pos().ch,
                        .ch_it = cc.it,
                        .pl = cc.pl,
                    };
                }
            }
            return null;
        }
        inline fn get_tx_dma_ch_config(comptime _cctx: Ct_Context) ?dma.Ch_Ct_Config {
            const ct_cfg = comptime get_ct_cfg(_cctx);
            if (ct_cfg.i2c_dma) |i2c_dma| {
                if (i2c_dma.tx_cfg) |cc| {
                    return dma.Ch_Ct_Config{
                        .dir = .memory,
                        .ch = tx_dma_ch_pos().ch,
                        .ch_it = cc.it,
                        .pl = cc.pl,
                    };
                }
            }
            return null;
        }

        inline fn sda_use(_cctx: *_Ct_Context) void {
            const p = sda_pin();
            const sda_pin_cfg = get_sda_pin_config();
            if (p.check_use(_cctx)) |cfg| {
                if (@field(_cctx.i2c, "cfg" ++ @tagName(_no)).?.sda_shared_count == 0) @compileError("Try to use sda with exsiting configuration!");
                if (cfg.eql(sda_pin_cfg) == false) @compileError("Try to use sda with different configuration!");
            } else {
                p.use(_cctx, sda_pin_cfg);
            }
            @field(_cctx.i2c, "cfg" ++ @tagName(_no)).?.sda_shared_count += 1;
        }
        inline fn sda_unuse(_cctx: *_Ct_Context) void {
            const p = sda_pin();
            if (p.check_use(_cctx)) |_| {
                if (@field(_cctx.i2c, "cfg" ++ @tagName(_no)).?.sda_shared_count == 1) p.unuse(_cctx);
                @field(_cctx.i2c, "cfg" ++ @tagName(_no)).?.sda_shared_count -= 1;
            }
        }
        inline fn scl_use(_cctx: *_Ct_Context) void {
            const p = scl_pin();
            const scl_pin_cfg = get_scl_pin_config();
            if (p.check_use(_cctx)) |cfg| {
                if (@field(_cctx.i2c, "cfg" ++ @tagName(_no)).?.scl_shared_count == 0)
                    @compileError("Try to use scl with exsiting configuration!");
                if (cfg.eql(scl_pin_cfg) == false)
                    @compileError("Try to use scl with different configuration!");
            } else {
                p.use(_cctx, scl_pin_cfg);
            }
            @field(_cctx.i2c, "cfg" ++ @tagName(_no)).?.scl_shared_count += 1;
        }
        inline fn scl_unuse(_cctx: *_Ct_Context) void {
            const p = scl_pin();
            if (p.check_use(_cctx)) |_| {
                if (@field(_cctx.i2c, "cfg" ++ @tagName(_no)).?.scl_shared_count == 1) p.unuse(_cctx);
                @field(_cctx.i2c, "cfg" ++ @tagName(_no)).?.scl_shared_count -= 1;
            }
        }

        pub inline fn use(_cctx: *_Ct_Context) void {
            scl_use(_cctx);
            sda_use(_cctx);
            if (comptime get_tx_dma_ch_config(_cctx.*)) |cfg| tx_dma_ch().use(_cctx, cfg);
            if (comptime get_rx_dma_ch_config(_cctx.*)) |cfg| rx_dma_ch().use(_cctx, cfg);
        }
        pub inline fn unuse(_cctx: *_Ct_Context) void {
            scl_unuse(_cctx);
            sda_unuse(_cctx);
            if (comptime get_tx_dma_ch_config(_cctx.*)) |cfg| tx_dma_ch().unuse(_cctx, cfg);
            if (comptime get_rx_dma_ch_config(_cctx.*)) |cfg| rx_dma_ch().unuse(_cctx, cfg);
        }

        pub inline fn clear_it_flag(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;
            const i = reg_i2c();
            _ = utils.modify(i.SR1_struct, i.SR1, comptime .{
                .BERR = 0,
                .ARLO = 0,
                .AF = 0,
                .OVR = 0,
                .PECERR = 0,
                .TIMEOUT = 0,
                .SMBALERT = 0,
            });
            if (i.SR1.SB == 0b1) {
                i.DR.DR = i.DR.DR;
                i.SR1.SB = 0;
            }
            if (i.SR1.ADDR == 0b1) {
                _ = i.SR2;
                i.SR1.ADDR = 0;
            }
            if (i.SR1.BTF == 0b1) {
                i.DR.DR = i.DR.DR;
                i.SR1.BTF = 0;
            }
            if (i.SR1.ADD10 == 0b1) {
                i.CR1.* = i.CR1.*;
                i.SR1.ADD10 = 0;
            }
            if (i.SR1.STOPF == 0b1) {
                i.CR1.* = i.CR1.*;
                i.SR1.STOPF = 0;
            }
            if (i.SR1.RxNE == 0b1) {
                i.DR.DR = i.DR.DR;
                i.SR1.RxNE = 0;
            }
            if (i.SR1.TxE == 0b1) {
                i.DR.DR = i.DR.DR;
                i.SR1.TxE = 0;
            }
        }

        pub inline fn set_it_enable_bit(comptime _cctx: Ct_Context, _: *Rt_Context) void {
            const cfg = comptime get_ct_cfg(_cctx);
            const i = reg_i2c();
            const ii = cfg.i2c_it.?;

            _ = utils.modify(i.CR2_struct, i.CR2, comptime .{
                .ITEVTEN = @intFromEnum(ii.iteven),
                .ITERREN = @intFromEnum(ii.iterren),
                .ITBUFEN = @intFromEnum(ii.itbufen),
            });
        }
        pub inline fn clear_it_enable_bit(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;
            const i = reg_i2c();

            _ = utils.modify(i.CR1_struct, i.CR1, comptime .{
                .ITEVEN = 0,
                .ITERREN = 0,
                .ITBUFEN = 0,
            });
        }

        inline fn _ccr_cal(comptime _pclk: u32, comptime _speed: u32, comptime _coeff: u32) u12 {
            return @truncate((_pclk - 1) / (_speed * _coeff) + 1);
        }
        inline fn ccr_cal(comptime _pclk: u32, comptime _mode: I2c_Ct_Config.Mode) u12 {
            return switch (_mode) {
                .standard => |s| @max(_ccr_cal(_pclk, s.speed, 2), 4), // 1/1
                .fast => |f| switch (f.duty) {
                    .@"2/1" => _ccr_cal(_pclk, f.speed, 3),
                    .@"16/9" => _ccr_cal(_pclk, f.speed, 25),
                },
            };
        }

        inline fn sda_config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            try sda_pin().config(_cctx, _rctx, get_sda_pin_config());
        }
        inline fn scl_config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            try scl_pin().config(_cctx, _rctx, get_scl_pin_config());
        }

        inline fn config_it(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            const cfg = comptime get_ct_cfg(_cctx);

            if (cfg.i2c_it) |ii| {
                const nvic_ev = it.Nvic(.{ .ext = switch (_no) {
                    .@"1" => reg.Interrupts.I2C1_EV,
                    .@"2" => reg.Interrupts.I2C2_EV,
                } });
                const nvic_err = it.Nvic(.{ .ext = switch (_no) {
                    .@"1" => reg.Interrupts.I2C1_ER,
                    .@"2" => reg.Interrupts.I2C2_ER,
                } });

                clear_it_flag(_cctx, _rctx);
                if (ii.ev_it) |ievi| {
                    i2c_its[@intFromEnum(_no)].ev_it = ievi.gf(_cctx);
                    nvic_ev.set_priority(_cctx, _rctx, ievi.nvic_cfg);
                    nvic_ev.enable(_cctx, _rctx);
                }
                if (ii.err_it) |ieri| {
                    i2c_its[@intFromEnum(_no)].err_it = ieri.gf(_cctx);
                    nvic_err.set_priority(_cctx, _rctx, ieri.nvic_cfg);
                    nvic_err.enable(_cctx, _rctx);
                }
            }
        }
        pub fn config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            const cfg = comptime get_ct_cfg(_cctx);
            const i = reg_i2c();

            enable(_cctx, _rctx);

            try sda_config(_cctx, _rctx);
            try scl_config(_cctx, _rctx);

            i.CR1.PE = 0;

            i.CR1.SWRST = 0b1;
            i.CR1.SWRST = 0;

            const pclk = get_freq(_cctx);
            const freq_MHz: u6 = @truncate(pclk / 1_000_000);
            if (freq_MHz < 0b000010 or freq_MHz > 0b100100) @compileError("Frequeny out of range:(2,36)MHz!");
            i.CR2.FREQ = freq_MHz;

            const ccr = comptime ccr_cal(pclk, cfg.mode);
            switch (cfg.mode) {
                .standard => {
                    if (freq_MHz < 2) @compileError("Frequeny must not be less than 2MHz on standard mode!");

                    i.TRISE.TRISE = freq_MHz + 1;

                    i.CCR.F_S = 0;
                    i.CCR.CCR = ccr;
                },
                .fast => |f| {
                    if (freq_MHz < 4) @compileError("Frequeny must not be less than 4MHz on fast mode!");

                    i.TRISE.TRISE = if (f.speed <= 100_000) freq_MHz + 1 else ((freq_MHz * 300) / 1_000 + 1);

                    i.CCR.F_S = 0b1;
                    i.CCR.DUTY = @intFromEnum(f.duty);
                    i.CCR.CCR = ccr;
                },
            }

            i.CR1.SMBUS = 0;
            i.CR1.NOSTRETCH = comptime @intFromEnum(cfg.scratch);
            i.CR1.ENGC = comptime @intFromEnum(cfg.general_call);

            switch (cfg.addr) {
                .@"7bit" => |a| {
                    i.OAR1.ADDMODE = 0;
                    i.OAR1.ADD7 = a.addr1;

                    if (a.addr2 != null) {
                        i.OAR2.ENDUAL = 0b1;
                        i.OAR2.ADD2 = a.addr2;
                    }
                },
                .@"10bit" => |a| {
                    const addr_tuple = comptime a.to_tuple();
                    i.OAR1.ADDMODE = 0b1;
                    i.OAR1.ADD0 = addr_tuple.@"0";
                    i.OAR1.ADD7 = addr_tuple.@"1";
                    i.OAR1.ADD10 = addr_tuple.@"2";
                    i.OAR2.ENDUAL = 0;
                },
            }

            config_it(_cctx, _rctx);

            i.CR1.PE = 0b1;
        }

        inline fn t2u(comptime _T: type, _value: _T) u8 {
            const bit_size: u16 = @bitSizeOf(_T);
            if (bit_size > 8) @compileError("Bitsize of type is more than 8");

            const u_bit_size: type = @Type(.{ .Int = .{
                .signedness = .unsigned,
                .bits = bit_size,
            } });

            return @as(u_bit_size, @bitCast(_value));
        }
        inline fn u2t(comptime _T: type, _value: u8) _T {
            const bit_size: u16 = @bitSizeOf(_T);
            if (bit_size > 8) @compileError("Bitsize of type is more than 8");

            const u_bit_size: type = @Type(.{ .Int = .{
                .signedness = .unsigned,
                .bits = bit_size,
            } });

            return @bitCast(@as(u_bit_size, @truncate(_value)));
        }

        fn wait_SR1(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _name: []const u8, comptime _value: u1) Error!void {
            const i = reg_i2c();
            if (@field(i.SR1, _name) == _value) return;

            sys.tick.start(_cctx, _rctx, 10_000);
            defer sys.tick.stop(_cctx, _rctx);

            while (@field(i.SR1, _name) != _value) {
                if (i.SR1.AF == 0b1) {
                    i.SR1.AF = 0;
                    return Error.I2c_Ack_Fail;
                }
                if (sys.tick.finished(_cctx, _rctx) == true) {
                    return Error.I2c_Time_Out;
                }
            }
        }
        fn wait_BUSY(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            const i = reg_i2c();
            if (i.SR2.BUSY == 0b1) return;

            sys.tick.start(_cctx, _rctx, 10_000);
            defer sys.tick.stop(_cctx, _rctx);

            while (i.SR2.BUSY != 0) {
                if (i.SR1.AF == 0b1) {
                    i.SR1.AF = 0;
                    return Error.I2c_Ack_Fail;
                }
                if (sys.tick.finished(_cctx, _rctx) == true) {
                    return Error.I2c_Time_Out;
                }
            }
        }
        inline fn wait_SB(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            wait_SR1(_cctx, _rctx, "SB", 0b1) catch return Error.I2c_Wait_SB_Time_Out;
        }
        inline fn wait_ADDR(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            wait_SR1(_cctx, _rctx, "ADDR", 0b1) catch return Error.I2c_Wait_ADDR_Time_Out;
        }
        inline fn wait_ADDR10(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            wait_SR1(_cctx, _rctx, "ADDR10", 0b1) catch return Error.I2c_Wait_ADDR10_Time_Out;
        }
        inline fn wait_RXNE(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            wait_SR1(_cctx, _rctx, "RxNE", 0b1) catch return Error.I2c_Wait_RXNE_Time_Out;
        }
        inline fn wait_TXE(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            wait_SR1(_cctx, _rctx, "TxE", 0b1) catch return Error.I2c_Wait_TXE_Time_Out;
        }
        inline fn wait_BTF(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            wait_SR1(_cctx, _rctx, "BTF", 0b1) catch return Error.I2c_Wait_BTF_Time_Out;
        }

        fn write_data_master(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _T: type, _data: []const _T) !void {
            const i = reg_i2c();
            var index: usize = 0;
            while (index < _data.len) : (index += 1) {
                try wait_TXE(_cctx, _rctx);
                i.DR.DR = t2u(_T, _data[index]);

                if (i.SR1.BTF == 0b1 and index < _data.len - 1) {
                    index += 1;
                    i.DR.DR = t2u(_T, _data[index]);
                }

                try wait_BTF(_cctx, _rctx);
            }
        }
        fn write_data_master_Ntimes(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _T: type, _value: _T, _size: usize) !void {
            const i = reg_i2c();
            var index: usize = 0;
            while (index < _size) : (index += 1) {
                try wait_TXE(_cctx, _rctx);
                i.DR.DR = t2u(_T, _value);

                if (i.SR1.BTF == 0b1 and index < _size - 1) {
                    index += 1;
                    i.DR.DR = t2u(_T, _value);
                }

                try wait_BTF(_cctx, _rctx);
            }
        }
        fn read_data_master(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _T: type, _data: []_T) !void {
            const i = reg_i2c();
            var index: usize = 0;
            while (index < _data.len) : (index += 1) {
                switch (_data.len - index) {
                    1 => {
                        try wait_RXNE(_cctx, _rctx);
                        _data[index] = u2t(_T, i.DR.DR);
                    },
                    2 => {
                        try wait_BTF(_cctx, _rctx);
                        i.CR1.STOP = 0b1;

                        _data[index] = u2t(_T, i.DR.DR);

                        index += 1;
                        _data[index + 1] = u2t(_T, i.DR.DR);
                    },
                    3 => {
                        try wait_BTF(_cctx, _rctx);
                        i.CR1.ACK = 0;

                        _data[index] = u2t(_T, i.DR.DR);

                        try wait_BTF(_cctx, _rctx);
                        i.CR1.STOP = 0b1;

                        index += 1;
                        _data[index] = u2t(_T, i.DR.DR);

                        index += 1;
                        _data[index] = u2t(_T, i.DR.DR);
                    },
                    else => {
                        try wait_RXNE(_cctx, _rctx);

                        _data[index] = u2t(_T, i.DR.DR);

                        if (i.SR1.BTF == 0b1) {
                            index += 1;
                            _data[index] = u2t(_T, i.DR.DR);
                        }
                    },
                }
            }
        }
        fn write_data_slave(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _T: type, _data: []const _T) !void {
            const i = reg_i2c();

            var index: usize = 0;
            while (index < _data.len) : (index += 1) {
                try wait_RXNE(_cctx, _rctx);
                i.DR.DR = t2u(_T, _data[index]);

                if (i.SR1.BTF == 0b1 and index < _data.len - 1) {
                    index += 1;
                    i.DR.DR = t2u(_T, _data[index]);
                }
            }
        }
        fn read_data_slave(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _T: type, _data: []_T) !void {
            const i = reg_i2c();

            var index: usize = 0;
            while (index < _data.len) : (index += 1) {
                try wait_TXE(_cctx, _rctx);
                _data[index] = u2t(_T, i.DR.DR);

                if (i.SR1.BTF == 0b1 and index < _data.len - 1) {
                    index += 1;
                    _data[index] = u2t(_T, i.DR.DR);
                }
            }
        }

        fn write_devaddr(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _bitsize: DevBitSize, _addr: switch (_bitsize) {
            .@"7bit" => u7,
            .@"10bit" => u10,
        }, comptime _read: bool) !void {
            const i = reg_i2c();

            switch (_bitsize) {
                .@"7bit" => i.DR.DR = (@as(u8, _addr) << 1) + @intFromBool(_read),
                .@"10bit" => {
                    // 0b11110_x9_x8_0 in receive
                    // 0b11110_x9_x8_1 in write
                    const addr: DevAddr10bit = @bitCast(_addr);

                    i.DR.DR = 0xF0 | (@as(u8, addr.head) << 1);
                    try wait_ADDR10(_cctx, _rctx);

                    i.DR.DR = addr.body;

                    if (_read == true) {
                        try wait_ADDR(_cctx, _rctx);
                        i.SR1.ADDR = 0;

                        i.CR1.START = 0b1;
                        try wait_SB(_cctx, _rctx);

                        i.DR.DR = 0xF1 | (@as(u8, addr.head) << 1);
                    }
                },
            }

            try wait_ADDR(_cctx, _rctx);

            _ = i.SR1.*;
            _ = i.SR2.*;

            i.SR1.ADDR = 0;
        }

        fn write_devaddr_memaddr(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _dev_bitsize: DevBitSize, _dev_addr: switch (_dev_bitsize) {
            .@"7bit" => u7,
            .@"10bit" => u10,
        }, comptime _mem_bitsize: MemBitSize, _mem_addr: switch (_mem_bitsize) {
            .@"8bit" => u8,
            .@"16bit" => u16,
        }, comptime _read: bool) !void {
            const i = reg_i2c();

            try write_devaddr(_cctx, _rctx, _dev_bitsize, _dev_addr, _read); // write addr

            try wait_TXE(_cctx, _rctx);
            switch (_mem_bitsize) {
                .@"8bit" => i.DR.DR = _mem_addr,
                .@"16bit" => {
                    const mem_addr: MemAddr16bit = @bitCast(_mem_addr);

                    i.DR.DR = mem_addr.head;

                    try wait_TXE(_cctx, _rctx);
                    i.DR.DR = mem_addr.body;
                },
            }

            if (_read == true) {
                try wait_TXE(_cctx, _rctx);

                i.CR1.START = 0b1;
                try wait_SB(_cctx, _rctx);

                try write_devaddr(_dev_bitsize, _dev_addr, _read); // write addr
            }
        }

        inline fn master_prepare(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            const i = reg_i2c();

            try wait_BUSY(_cctx, _rctx);

            if (i.CR1.PE == 0) i.CR1.PE = 0b1;

            i.CR1.POS = 0;

            i.CR1.START = 0b1;
            try wait_SB(_cctx, _rctx);
        }
        pub fn master_write(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _bitsize: DevBitSize, _addr: switch (_bitsize) {
            .@"7bit" => u7,
            .@"10bit" => u10,
        }, comptime _T: type, _data: []const _T) !void {
            const i = reg_i2c();
            defer i.CR1.STOP = 0b1;

            try master_prepare(_cctx, _rctx);

            try write_devaddr(_cctx, _rctx, _bitsize, _addr, false);

            try write_data_master(_cctx, _rctx, _T, _data);
        }
        pub fn master_write_Ntimes(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _bitsize: DevBitSize, _addr: switch (_bitsize) {
            .@"7bit" => u7,
            .@"10bit" => u10,
        }, comptime _T: type, _value: _T, _size: usize) !void {
            const i = reg_i2c();
            defer i.CR1.STOP = 0b1;

            try master_prepare(_cctx, _rctx);

            try write_devaddr(_cctx, _rctx, _bitsize, _addr, false);

            try write_data_master_Ntimes(_cctx, _rctx, _T, _value, _size);
        }
        pub fn master_read(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _bitsize: DevBitSize, _addr: switch (_bitsize) {
            .@"7bit" => u7,
            .@"10bit" => u10,
        }, comptime _T: type, _data: []_T) !void {
            const i = reg_i2c();
            defer i.CR1.STOP = 0b1;

            try master_prepare(_cctx, _rctx);

            try write_devaddr(_cctx, _rctx, _bitsize, _addr, true);

            try read_data_master(_cctx, _rctx, _T, _data);
        }

        inline fn slave_prepare(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            _ = _cctx;
            _ = _rctx;
            const i = reg_i2c();

            if (i.CR1.PE == 0) i.CR1.PE = 0b1;

            i.CR1.POS = 0;

            i.CR1.ACK = 0b1;
        }
        pub fn slave_write(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _dev_bitsize: DevBitSize, comptime _T: type, _data: []const _T) Error!void {
            const i = reg_i2c();

            try slave_prepare(_cctx, _rctx);
            defer {
                i.SR1.AF = 0;
                i.CR1.ACK = 0;
            }

            try wait_ADDR(_cctx, _rctx);
            i.SR1.ADDR = 0;
            if (_dev_bitsize == .@"10bit") {
                try wait_ADDR(_cctx, _rctx);
                i.SR1.ADDR = 0;
            }

            try write_data_slave(_cctx, _rctx, _T, _data);

            try wait_SR1(_cctx, _rctx, "AF", 0b1);
        }
        pub fn slave_read(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _dev_bitsize: DevBitSize, comptime _T: type, _data: []_T) void {
            const i = reg_i2c();

            try slave_prepare(_cctx, _rctx);
            defer {
                i.SR1.STOPF = 0;
                i.CR1.ACK = 0;
            }

            wait_ADDR(_cctx, _rctx);
            i.SR1.ADDR = 0;
            if (_dev_bitsize == .@"10bit") {
                try wait_ADDR(_cctx, _rctx);
                i.SR1.ADDR = 0;
            }

            try read_data_slave(_cctx, _rctx, _T, _data);

            try wait_SR1(_cctx, _rctx, "STOPF", 0b1);
        }

        inline fn mem_prepare(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _read: bool) !void {
            const i = reg_i2c();

            try wait_BUSY(_cctx, _rctx);

            if (i.CR1.PE != 0b1) i.CR1.PE = 0b1;

            i.CR1.POS = 0;
            if (_read == true) i.CR1.ACK = 0b1;
            i.CR1.START = 0b1;
            try wait_SB(_cctx, _rctx);
        }
        pub fn mem_write(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _dev_bitsize: DevBitSize, _dev_addr: switch (_dev_bitsize) {
            .@"7bit" => u7,
            .@"10bit" => u10,
        }, comptime _mem_bitsize: MemBitSize, _mem_addr: switch (_mem_bitsize) {
            .@"8bit" => u8,
            .@"16bit" => u16,
        }, comptime _T: type, _data: []const _T) Error!void {
            const i = reg_i2c();
            try mem_prepare(_cctx, _rctx, false);
            defer i.CR1.STOP = 0b1;

            try write_devaddr_memaddr(
                _cctx,
                _rctx,
                _dev_bitsize,
                _dev_addr,
                _mem_bitsize,
                _mem_addr,
                false,
            );

            try write_data_master(_cctx, _rctx, _T, _data);
        }
        pub fn mem_write_Ntimes(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _dev_bitsize: DevBitSize, _dev_addr: switch (_dev_bitsize) {
            .@"7bit" => u7,
            .@"10bit" => u10,
        }, comptime _mem_bitsize: MemBitSize, _mem_addr: switch (_mem_bitsize) {
            .@"8bit" => u8,
            .@"16bit" => u16,
        }, comptime _T: type, _value: _T, _size: usize) Error!void {
            const i = reg_i2c();

            try mem_prepare(_cctx, _rctx, false);
            defer i.CR1.STOP = 0b1;

            try write_devaddr_memaddr(
                _cctx,
                _rctx,
                _dev_bitsize,
                _dev_addr,
                _mem_bitsize,
                _mem_addr,
                false,
            );

            try write_data_master_Ntimes(_cctx, _rctx, _T, _value, _size);
        }
        pub fn mem_read(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _dev_bitsize: DevBitSize, _dev_addr: switch (_dev_bitsize) {
            .@"7bit" => u7,
            .@"10bit" => u10,
        }, comptime _mem_bitsize: MemBitSize, _mem_addr: switch (_mem_bitsize) {
            .@"8bit" => u8,
            .@"16bit" => u16,
        }, comptime _T: type, _data: []_T) Error!void {
            const i = reg_i2c();

            try mem_prepare(_cctx, _rctx, true);
            defer i.CR1.STOP = 0b1;

            try write_devaddr_memaddr(_cctx, _rctx, _dev_bitsize, _dev_addr, _mem_bitsize, _mem_addr, true);

            switch (_data.len) {
                0 => {
                    i.CR1.STOP = 0b1;
                },
                1 => {
                    i.CR1.ACK = 0;
                    i.CR1.STOP = 0b1;
                },
                2 => {
                    i.CR1.POS = 0b1;
                    i.CR1.ACK = 0;
                },
                else => {
                    i.CR1.ACK = 0;
                },
            }
            try read_data_master(_cctx, _rctx, _T, _data);
        }

        pub fn slave_it_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            const i = reg_i2c();
            const cfg = comptime get_ct_cfg(_cctx);
            const ii = cfg.i2c_it.?;
            errdefer {
                i.SR1.STOPF = 0;
                i.CR1.ACK = 0;
            }

            try slave_prepare(_cctx, _rctx);

            if (ii.itbufen == .enable and ii.iteven == .disable) @compileError("Only enabling ITBUFEN is useless!");
            set_it_enable_bit(_cctx, _rctx);
        }
        pub fn matser_it_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _dev_bitsize: DevBitSize, _dev_addr: switch (_dev_bitsize) {
            .@"7bit" => u7,
            .@"10bit" => u10,
        }, comptime _read: bool) !void {
            const i = reg_i2c();
            errdefer i.CR1.STOP = 0b1;

            try master_prepare(_cctx, _rctx);

            try write_devaddr(_cctx, _rctx, _dev_bitsize, _dev_addr, _read);

            set_it_enable_bit(_cctx, _rctx);
        }
        pub fn mem_it_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _dev_bitsize: DevBitSize, _dev_addr: switch (_dev_bitsize) {
            .@"7bit" => u7,
            .@"10bit" => u10,
        }, comptime _mem_bitsize: MemBitSize, _mem_addr: switch (_mem_bitsize) {
            .@"8bit" => u8,
            .@"16bit" => u16,
        }, comptime _read: bool) void {
            const i = reg_i2c();
            errdefer i.CR1.STOP = 0b1;

            try master_prepare(_cctx, _rctx);

            try write_devaddr_memaddr(_cctx, _rctx, _dev_bitsize, _dev_addr, _mem_bitsize, _mem_addr, _read);

            set_it_enable_bit(_cctx, _rctx);
        }
        pub fn it_stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            const i = reg_i2c();
            clear_it_enable_bit(_cctx, _rctx);
            i.CR1.STOP = 0b1;
        }

        pub fn slave_dma_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            const i = reg_i2c();
            errdefer i.CR1.STOP = 0b1;

            try slave_prepare(_cctx, _rctx);

            const cfg = comptime get_ct_cfg(_cctx);
            const rt_cfg = get_rt_cfg(_rctx);
            comptime var start_rx_dma = false;

            if (cfg.i2c_it) |ii| if (ii.itbufen == .enable) @compileError("Cannot enable ITBUFEN when using dma!");

            if (comptime get_rx_dma_ch_config(_cctx)) |_| {
                if (rt_cfg) |irc| {
                    if (irc.rx_cfg) |crc| {
                        start_rx_dma = true;

                        const dcrc = dma.Ch_Rt_Config{
                            .ma = crc.ma,
                            .pa = @intFromPtr(i.DR),
                            .mem2mem = .disable,
                            .circ = crc.circ,
                            .minc = crc.minc,
                            .pinc = .disable,
                            .ndt = crc.ndt,
                            .msize = .@"8bit",
                            .psize = .@"8bit",
                        };
                        try rx_dma_ch().config(_cctx, _rctx, dcrc);
                        rx_dma_ch().start(_cctx, _rctx);
                        i.CR2.DMAEN = 0b1;
                    }
                }
            }
            if (comptime get_tx_dma_ch_config(_cctx)) |_| {
                if (rt_cfg) |irc| {
                    if (irc.tx_cfg) |crc| {
                        if (start_rx_dma == true) @compileError("Cannot start both tx and rx dma at the same time!");

                        const dcrc = dma.Ch_Rt_Config{
                            .ma = crc.ma,
                            .pa = @intFromPtr(i.DR),
                            .mem2mem = .disable,
                            .circ = crc.circ,
                            .minc = crc.minc,
                            .pinc = .disable,
                            .ndt = crc.ndt,
                            .msize = .@"8bit",
                            .psize = .@"8bit",
                        };
                        try tx_dma_ch().config(_cctx, _rctx, dcrc);
                        tx_dma_ch().start(_cctx, _rctx);
                        i.CR2.DMAEN = 0b1;
                    }
                }
            }
        }
        pub fn master_dma_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _dev_bitsize: DevBitSize, _dev_addr: switch (_dev_bitsize) {
            .@"7bit" => u7,
            .@"10bit" => u10,
        }) !void {
            const i = reg_i2c();
            errdefer i.CR1.STOP = 0b1;

            try master_prepare(_cctx, _rctx);

            const cfg = comptime get_ct_cfg(_cctx);
            const rt_cfg = get_rt_cfg(_rctx);
            comptime var start_rx_dma = false;

            if (cfg.i2c_it) |ii| if (ii.itbufen == .enable) @compileError("Cannot enable ITBUFEN when using dma!");

            if (comptime get_rx_dma_ch_config(_cctx)) |_| {
                if (rt_cfg) |irc| {
                    if (irc.rx_cfg) |crc| {
                        start_rx_dma = true;

                        const dcrc = dma.Ch_Rt_Config{
                            .ma = crc.ma,
                            .pa = @intFromPtr(i.DR),
                            .mem2mem = .disable,
                            .circ = crc.circ,
                            .minc = crc.minc,
                            .pinc = .disable,
                            .ndt = crc.ndt,
                            .msize = .@"8bit",
                            .psize = .@"8bit",
                        };
                        try rx_dma_ch().config(_cctx, _rctx, dcrc);
                        try write_devaddr(_cctx, _rctx, _dev_bitsize, _dev_addr, start_rx_dma);
                        rx_dma_ch().start(_cctx, _rctx);
                        i.CR2.DMAEN = 0b1;
                    }
                }
            }
            if (comptime get_tx_dma_ch_config(_cctx)) |_| {
                if (rt_cfg) |irc| {
                    if (irc.tx_cfg) |crc| {
                        if (start_rx_dma == true) @compileError("Cannot start both tx and rx dma at the same time!");

                        const dcrc = dma.Ch_Rt_Config{
                            .ma = crc.ma,
                            .pa = @intFromPtr(i.DR),
                            .mem2mem = .disable,
                            .circ = crc.circ,
                            .minc = crc.minc,
                            .pinc = .disable,
                            .ndt = crc.ndt,
                            .msize = .@"8bit",
                            .psize = .@"8bit",
                        };
                        try tx_dma_ch().config(_cctx, _rctx, dcrc);
                        try write_devaddr(_cctx, _rctx, _dev_bitsize, _dev_addr, start_rx_dma);
                        tx_dma_ch().start(_cctx, _rctx);
                        i.CR2.DMAEN = 0b1;
                    }
                }
            }
        }
        pub fn mem_dma_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _dev_bitsize: DevBitSize, _dev_addr: switch (_dev_bitsize) {
            .@"7bit" => u7,
            .@"10bit" => u10,
        }, comptime _mem_bitsize: MemBitSize, _mem_addr: switch (_mem_bitsize) {
            .@"8bit" => u8,
            .@"16bit" => u16,
        }) !void {
            const i = reg_i2c();
            errdefer i.CR1.STOP = 0b1;

            const cfg = comptime get_ct_cfg(_cctx);
            const rt_cfg = get_rt_cfg(_rctx);
            comptime var start_rx_dma = false;
            if (cfg.i2c_it) |ii| if (ii.itbufen == .enable) @compileError("Cannot enable ITBUFEN when using dma!");

            if (comptime get_rx_dma_ch_config(_cctx)) |_| {
                if (rt_cfg) |irc| {
                    if (irc.rx_cfg) |crc| {
                        start_rx_dma = true;

                        const dcrc = dma.Ch_Rt_Config{
                            .ma = crc.ma,
                            .pa = @intFromPtr(i.DR),
                            .mem2mem = .disable,
                            .circ = crc.circ,
                            .minc = crc.minc,
                            .pinc = .disable,
                            .ndt = crc.ndt,
                            .msize = .@"8bit",
                            .psize = .@"8bit",
                        };
                        try rx_dma_ch().config(_cctx, _rctx, dcrc);
                        try mem_prepare(_cctx, _rctx, start_rx_dma);
                        try write_devaddr_memaddr(_cctx, _rctx, _dev_bitsize, _dev_addr, _mem_bitsize, _mem_addr, start_rx_dma);
                        rx_dma_ch().start(_cctx, _rctx);
                        i.CR2.DMAEN = 0b1;
                    }
                }
            }
            if (comptime get_tx_dma_ch_config(_cctx)) |_| {
                if (rt_cfg) |irc| {
                    if (irc.tx_cfg) |crc| {
                        if (start_rx_dma == true) @compileError("Cannot start both tx and rx dma at the same time!");

                        const dcrc = dma.Ch_Rt_Config{
                            .ma = crc.ma,
                            .pa = @intFromPtr(i.DR),
                            .mem2mem = .disable,
                            .circ = crc.circ,
                            .minc = crc.minc,
                            .pinc = .disable,
                            .ndt = crc.ndt,
                            .msize = .@"8bit",
                            .psize = .@"8bit",
                        };
                        try tx_dma_ch().config(_cctx, _rctx, dcrc);
                        try mem_prepare(_cctx, _rctx, start_rx_dma);
                        try write_devaddr_memaddr(_cctx, _rctx, _dev_bitsize, _dev_addr, _mem_bitsize, _mem_addr, start_rx_dma);
                        tx_dma_ch().start(_cctx, _rctx);
                        i.CR2.DMAEN = 0b1;
                    }
                }
            }
        }
        pub fn dma_stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            const i = reg_i2c();
            if (comptime get_tx_dma_ch_config(_cctx)) |_| {
                rx_dma_ch().stop(_cctx, _rctx);
                i.CR2.DMAEN = 0;
            }
            if (comptime get_tx_dma_ch_config(_cctx)) |_| {
                tx_dma_ch().stop(_cctx, _rctx);
                i.CR2.DMAEN = 0;
            }
            i.CR1.STOP = 0b1;
        }
    };
}

pub fn _DevUBitSize(comptime _dev_bitsize: DevBitSize) type {
    return switch (_dev_bitsize) {
        .@"7bit" => u7,
        .@"10bit" => u10,
    };
}
pub fn _MemUBitSize(comptime _mem_bitsize: MemBitSize) type {
    return switch (_mem_bitsize) {
        .@"8bit" => u8,
        .@"16bit" => u16,
    };
}

pub fn I2c(comptime _no: No) type {
    return i2c.I2c(
        ctx.Ct_Context,
        ctx.Rt_Context,
        I2c_Ct_Config,
        I2c_Rt_Config,
        No,
        Error,
        DevBitSize,
        _DevUBitSize,
        MemBitSize,
        _MemUBitSize,
        _I2c,
        _no,
    );
}
