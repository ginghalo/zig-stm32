const reg = @import("reg.zig");
const gpio = @import("gpio.zig");
const sys = @import("sys.zig");
const it = @import("it.zig");
const ctx = @import("ctx.zig");
const dma = @import("dma.zig");

const interface = @import("../stm32.zig").interface;
const utils = interface.utils;
const spi = interface.spi;

pub var spi_its: [NO_NUMS]?*const fn () void = .{null} ** NO_NUMS;

pub const @"1" = Spi(.@"1");
pub const @"2" = Spi(.@"2");

pub const No = enum { @"1", @"2" };
pub const NO_NUMS = @typeInfo(No).Enum.fields.len;

pub const Spi_Ct_Context: type = CONTEXT: {
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
                    .type = ?Spi_Ct_Config,
                    .default_value = @ptrCast(&@as(?Spi_Ct_Config, null)),
                    .is_comptime = false,
                    .alignment = @alignOf(?Spi_Ct_Config),
                };
            }
            break :FIELDS &fields;
        },
    } });
};
pub const Spi_Rt_Context: type = CONTEXT: {
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
                    .type = ?Spi_Rt_Config,
                    .default_value = @ptrCast(&@as(?Spi_Rt_Config, null)),
                    .is_comptime = false,
                    .alignment = @alignOf(?Spi_Rt_Config),
                };
            }
            break :FIELDS &fields;
        },
    } });
};

pub const Spi_Ct_Config = struct {
    /// mode 0: .first .low
    /// mode 1: .first .high
    /// mode 2: .second .low
    /// mode 3: .second .high
    cpha: CPHA = .first,
    cpol: CPOL = .low,

    mstr: Mstr = .master,
    br: BR = .div8,
    first: First = .MSB,
    ssi: SSI = .low,
    ssm: SSM = .disable,
    rxonly: RxOnly = .duplex,
    dff: DFF = .@"8bit",
    bidioe: BiDiOE = .rx,
    bidimode: BiDiMode = .unidirection,

    ssoe: SSOE = .disable,

    /// Must NOT change it, it's operated by programming
    sclk_shared_count: u32 = 1,
    /// Must NOT change it, it's operated by programming
    mosi_shared_count: u32 = 1,
    /// Must NOT change it, it's operated by programming
    miso_shared_count: u32 = 1,

    spi_it: ?Spi_It = null,
    spi_dma: ?Spi_Dma = null,

    pub const CPHA = enum(u1) { first, second };
    pub const CPOL = enum(u1) { low, high };
    pub const Mstr = enum(u1) { slave, master };
    pub const BR = enum(u3) { div2, div4, div8, div16, div32, div64, div128, div256 };
    pub const First = enum(u1) { MSB, LSB };
    pub const SSI = enum(u1) { low, high }; // working when ssm is enable
    pub const SSM = enum(u1) { disable, enable };
    pub const RxOnly = enum(u1) { duplex, rxonly }; // working when bidimode is unidirection
    pub const DFF = enum(u1) { @"8bit", @"16bit" };
    // TODO enable crc
    pub const BiDiOE = enum(u1) { rx, tx }; // working when bidimode is unidirection
    pub const BiDiMode = enum(u1) { unidirection, bidirection };

    pub const SSOE = enum(u1) { disable, enable };

    pub const Spi_It = struct {
        gf: *const fn (comptime _ctx: ctx.Ct_Context) fn () void,
        nvic_cfg: it.Nvic_Config = .{},

        rxneie: Rxneie = .disable,
        txeie: Txeie = .disable,
        errie: Errie = .disable,
        pub const Rxneie = enum(u1) { disable, enable };
        pub const Txeie = enum(u1) { disable, enable };
        pub const Errie = enum(u1) { disable, enable };
    };
    pub const Spi_Dma = struct {
        rx_cfg: ?Dma_Ch_Ct_Config = null, // PA and DIR is unless
        tx_cfg: ?Dma_Ch_Ct_Config = null, // PA and DIR is unless
        pub const Dma_Ch_Ct_Config = struct {
            it: dma.Ch_Ct_Config.Ch_It,
            pl: dma.Ch_Ct_Config.Pl = .low,
        };
    };

    pub fn eql(_s1: Spi_Ct_Config, _s2: Spi_Ct_Config) bool {
        if (_s1.cpha != _s2.spha) return false;
        if (_s1.cpol != _s2.cpol) return false;
        if (_s1.mstr != _s2.mstr) return false;
        if (_s1.br != _s2.br) return false;
        if (_s1.first != _s2.first) return false;
        if (_s1.ssm != _s2.ssm) return false;
        if (_s1.ssm != _s2.ssm) return false;
        if (_s1.rxonly != _s2.rxonly) return false;
        if (_s1.dff != _s2.dff) return false;
        if (_s1.bidioe != _s2.bidioe) return false;
        if (_s1.bidimode != _s2.bidimode) return false;
        if (_s1.ssoe != _s2.ssoe) return false;

        return true;
    }
};
pub const Spi_Rt_Config = struct {
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
pub const Error = error{
    Spi_Time_Out,
    Wait_SR_Time_Out,
    Wait_BSY_Time_Out,
};

fn _Spi(comptime _Ct_Context: type, comptime _Rt_Context: type, comptime _no: No) type {
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;
        pub fn reg_spi() type {
            return switch (_no) {
                .@"1" => reg.SPI1,
                .@"2" => reg.SPI2,
            };
        }

        inline fn rx_dma_ch_pos() dma.Pos {
            return switch (_no) {
                .@"1" => .{ .no = .@"1", .ch = .@"2" },
                .@"2" => .{ .no = .@"1", .ch = .@"4" },
            };
        }
        inline fn tx_dma_ch_pos() dma.Pos {
            return switch (_no) {
                .@"1" => .{ .no = .@"1", .ch = .@"3" },
                .@"2" => .{ .no = .@"1", .ch = .@"5" },
            };
        }
        pub inline fn rx_dma_ch() type {
            return dma.Ch(rx_dma_ch_pos());
        }
        pub inline fn tx_dma_ch() type {
            return dma.Ch(tx_dma_ch_pos());
        }

        inline fn ape_enable() void {
            switch (_no) {
                .@"1" => reg.RCC.APB2ENR.SPI1EN = 0b1,
                .@"2" => reg.RCC.APB1ENR.SPI2EN = 0b1,
            }
        }
        inline fn ape_disable() void {
            switch (_no) {
                .@"1" => reg.RCC.APB2ENR.SPI1EN = 0,
                .@"2" => reg.RCC.APB1ENR.SPI2EN = 0,
            }
        }
        inline fn gpio_enable() void {
            switch (_no) {
                .@"1" => gpio.A.enable(),
                .@"2" => gpio.B.enable(),
            }
        }

        inline fn mosi_pin() type {
            return switch (_no) {
                .@"1" => gpio.A.pin(.@"7"),
                .@"2" => gpio.B.pin(.@"15"),
            };
        }
        inline fn miso_pin() type {
            return switch (_no) {
                .@"1" => gpio.A.pin(.@"6"),
                .@"2" => gpio.B.pin(.@"14"),
            };
        }
        inline fn sclk_pin() type {
            return switch (_no) {
                .@"1" => gpio.A.pin(.@"5"),
                .@"2" => gpio.B.pin(.@"13"),
            };
        }
        inline fn nss_pin() type {
            return switch (_no) {
                .@"1" => gpio.A.pin(.@"4"),
                .@"2" => gpio.B.pin(.@"12"),
            };
        }

        // according to the tablet 22 from dataset of stm32f10x
        inline fn get_mosi_pin_config(comptime _cctx: Ct_Context) ?gpio.Pin_Ct_Config {
            const cfg: Spi_Ct_Config = comptime @field(_cctx.spi, "cfg" ++ @tagName(_no)).?;
            return comptime switch (cfg.mstr) {
                .master => .{ .Output = .{
                    .mode = .AFPP,
                    .speed = .@"50MHz",
                } },
                .slave => switch (cfg.bidimode) {
                    .bidirection => null,
                    .unidirection => .{ .Input = .{ .mode = .PU } },
                },
            };
        }
        inline fn get_miso_pin_config(comptime _cctx: Ct_Context) ?gpio.Pin_Ct_Config {
            const cfg: Spi_Ct_Config = comptime @field(_cctx.spi, "cfg" ++ @tagName(_no)).?;
            return comptime switch (cfg.mstr) {
                .slave => .{ .Output = .{
                    .mode = .AFPP,
                    .speed = .@"50MHz",
                } },
                .master => switch (cfg.bidimode) {
                    .bidirection => null,
                    .unidirection => .{ .Input = .{
                        .mode = .PU,
                    } },
                },
            };
        }
        inline fn get_sclk_pin_config(comptime _cctx: Ct_Context) ?gpio.Pin_Ct_Config {
            const cfg: Spi_Ct_Config = comptime @field(_cctx.spi, "cfg" ++ @tagName(_no)).?;
            return comptime switch (cfg.mstr) {
                .master => .{ .Output = .{
                    .mode = .AFPP,
                    .speed = .@"50MHz",
                } },
                .slave => .{ .Input = .{ .mode = .Flt } },
            };
        }
        inline fn get_nss_pin_config(comptime _cctx: Ct_Context) ?gpio.Pin_Ct_Config {
            const cfg: Spi_Ct_Config = comptime @field(_cctx.spi, "cfg" ++ @tagName(_no)).?;
            return comptime switch (cfg.ssm) {
                .enable => null,
                .disable => switch (cfg.mstr) {
                    .slave => .{ .Input = .{ .mode = .PU } },
                    .master => switch (cfg.ssoe) {
                        .disable => .{ .Input = .{ .mode = .PU } },
                        .enable => .{ .Output = .{
                            .mode = .AFPP,
                            .speed = .@"50MHz",
                        } },
                    },
                },
            };
        }
        inline fn get_rx_dma_ch_config(comptime _cctx: Ct_Context) ?dma.Ch_Ct_Config {
            const ct_cfg = comptime get_ct_cfg(_cctx);
            const size = switch (ct_cfg.dff) {
                .@"8bit" => .@"8bit",
                .@"16bit" => .@"16bit",
            };
            if (ct_cfg.spi_dma) |spi_dma| {
                if (spi_dma.rx_cfg) |cc| {
                    return dma.Ch_Ct_Config{
                        .msize = size,
                        .psize = size,
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
            if (ct_cfg.spi_dma) |spi_dma| {
                if (spi_dma.tx_cfg) |cc| {
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

        inline fn mosi_config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            if (comptime get_mosi_pin_config(_cctx)) |cfg| try mosi_pin().config(_cctx, _rctx, cfg);
        }
        inline fn miso_config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            if (comptime get_miso_pin_config(_cctx)) |cfg| try miso_pin().config(_cctx, _rctx, cfg);
        }
        inline fn sclk_config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            if (comptime get_sclk_pin_config(_cctx)) |cfg| try sclk_pin().config(_cctx, _rctx, cfg);
        }
        inline fn nss_config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            if (comptime get_nss_pin_config(_cctx)) |cfg| try nss_pin().config(_cctx, _rctx, cfg);
        }

        // according to the tablet 22 from dataset of stm32f10x
        fn mosi_use(_cctx: *_Ct_Context) void {
            const p = mosi_pin();
            if (comptime get_mosi_pin_config(_cctx.*)) |mosi_pin_cfg| {
                if (p.check_use(_cctx)) |cfg| {
                    if (@field(_cctx.spi, "cfg" ++ @tagName(_no)).?.mosi_shared_count == 0)
                        @compileError("Try to use mosi with exsiting configuration!");
                    if (cfg.eql(mosi_pin_cfg) == false)
                        @compileError("Try to use mosi with different configuration!");
                } else {
                    p.use(_cctx, mosi_pin_cfg);
                }
                @field(_cctx.spi, "cfg" ++ @tagName(_no)).?.mosi_shared_count += 1;
            }
        }
        fn miso_use(_cctx: *_Ct_Context) void {
            const p = miso_pin();
            if (comptime get_miso_pin_config(_cctx.*)) |miso_pin_cfg| {
                if (p.check_use(_cctx)) |cfg| {
                    if (@field(_cctx.spi, "cfg" ++ @tagName(_no)).?.miso_shared_count == 0)
                        @compileError("Try to use miso with exsiting configuration!");
                    if (cfg.eql(miso_pin_cfg) == false)
                        @compileError("Try to use miso with different configuration!");
                } else {
                    p.use(_cctx, miso_pin_cfg);
                }
                @field(_cctx.spi, "cfg" ++ @tagName(_no)).?.miso_shared_count += 1;
            }
        }
        fn sclk_use(_cctx: *_Ct_Context) void {
            const p = sclk_pin();
            if (comptime get_sclk_pin_config(_cctx.*)) |sclk_pin_cfg| {
                if (p.check_use(_cctx)) |cfg| {
                    if (@field(_cctx.spi, "cfg" ++ @tagName(_no)).?.sclk_shared_count == 0)
                        @compileError("Try to use sclk with exsiting configuration!");
                    if (cfg.eql(sclk_pin_cfg) == false)
                        @compileError("Try to use sclk with different configuration!");
                } else {
                    p.use(_cctx, sclk_pin_cfg);
                }
                @field(_cctx.spi, "cfg" ++ @tagName(_no)).?.sclk_shared_count += 1;
            }
        }
        fn nss_use(_cctx: *_Ct_Context) void {
            const p = nss_pin();
            if (comptime get_nss_pin_config(_cctx.*)) |cfg| p.use(_cctx, cfg);
        }

        fn mosi_unuse(_cctx: *_Ct_Context) void {
            const p = mosi_pin();
            if (comptime get_mosi_pin_config(_cctx.*)) |_| {
                if (p.check_use(_cctx)) |_| {
                    if (@field(_cctx.spi, "cfg" ++ @tagName(_no)).mosi_shared_count == 1) p.unuse(_cctx);
                    @field(_cctx.spi, "cfg" ++ @tagName(_no)).mosi_shared_count -= 1;
                }
            }
        }
        fn miso_unuse(_cctx: *_Ct_Context) void {
            const p = miso_pin();
            if (comptime get_miso_pin_config(_cctx.*)) |_| {
                if (p.check_use(_cctx)) |_| {
                    if (@field(_cctx.spi, "cfg" ++ @tagName(_no)).miso_shared_count == 1) p.unuse(_cctx);
                    @field(_cctx.spi, "cfg" ++ @tagName(_no)).miso_shared_count -= 1;
                }
            }
        }
        fn sclk_unuse(_cctx: *_Ct_Context) void {
            const p = sclk_pin();
            if (comptime get_sclk_pin_config(_cctx.*)) |_| {
                if (p.check_use(_cctx)) |_| {
                    if (@field(_cctx.spi, "cfg" ++ @tagName(_no)).sclk_shared_count == 1) p.unuse(_cctx);
                    @field(_cctx.spi, "cfg" ++ @tagName(_no)).sclk_shared_count -= 1;
                }
            }
        }
        fn nss_unuse(_cctx: *_Ct_Context) void {
            const p = nss_pin();
            if (comptime get_nss_pin_config(_cctx.*)) |_| p.unuse(_cctx);
        }

        pub fn enable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;

            ape_enable();
            gpio_enable();
        }
        pub fn disable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;

            ape_disable();
        }

        pub inline fn get_freq(comptime _cctx: Ct_Context, _: *Rt_Context) u32 {
            return comptime switch (_no) {
                .@"1" => sys.clock.get_freq(_cctx).pclk2,
                .@"2" => sys.clock.get_freq(_cctx).pclk1,
            };
        }

        pub inline fn get_ct_cfg(comptime _cctx: Ct_Context) Spi_Ct_Config {
            return @field(_cctx.spi, "cfg" ++ @tagName(_no)).?;
        }
        pub inline fn get_rt_cfg(_rctx: *Rt_Context) ?Spi_Rt_Config {
            return @field(_rctx.spi, "cfg" ++ @tagName(_no));
        }

        pub inline fn get_no() No {
            return _no;
        }

        pub fn use(_cctx: *_Ct_Context) void {
            miso_use(_cctx);
            mosi_use(_cctx);
            sclk_use(_cctx);
            nss_use(_cctx);
            if (comptime get_tx_dma_ch_config(_cctx.*)) |cfg| tx_dma_ch().use(_cctx, cfg);
            if (comptime get_rx_dma_ch_config(_cctx.*)) |cfg| rx_dma_ch().use(_cctx, cfg);
        }
        pub fn unuse(_cctx: *_Ct_Context) void {
            miso_unuse(_cctx);
            mosi_unuse(_cctx);
            sclk_unuse(_cctx);
            nss_unuse(_cctx);
            if (comptime get_tx_dma_ch_config(_cctx.*)) |cfg| tx_dma_ch().unuse(_cctx, cfg);
            if (comptime get_rx_dma_ch_config(_cctx.*)) |cfg| rx_dma_ch().unuse(_cctx, cfg);
        }

        pub fn clear_it_flag(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;
            const s = reg_spi();
            _ = utils.modify(s.SR_struct, s.SR, comptime .{
                .RXNE = 0,
                .TXE = 0,
            });
            // OVR
            _ = s.DR.DR;
            _ = s.SR.*;
            // CRC
            s.SR.CRCERR = 0;
            // MODF: before doing this operation, please pull up the nss pin
            s.SR.MODF = 0;
            s.CR1.* = s.CR1.*;
        }
        pub inline fn set_it_enable_bit(comptime _cctx: Ct_Context, _: *Rt_Context) void {
            const cfg = comptime get_ct_cfg(_cctx);
            const s = reg_spi();
            const si = cfg.spi_it.?;

            _ = utils.modify(s.CR2_struct, s.CR2, comptime .{
                .TXEIE = @intFromEnum(si.txeie),
                .ERRIE = @intFromEnum(si.errie),
                .RXNEIE = @intFromEnum(si.rxneie),
            });
        }
        pub inline fn clear_it_enable_bit(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;
            const s = reg_spi();

            _ = utils.modify(s.CR2_struct, s.CR2, comptime .{
                .TXEIE = 0,
                .ERRIE = 0,
                .RXNEIE = 0,
            });
        }

        inline fn config_it(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            const cfg = comptime get_ct_cfg(_cctx);
            if (cfg.spi_it) |si| {
                const nvic = it.Nvic(.{ .ext = switch (_no) {
                    .@"1" => reg.Interrupts.SPI1,
                    .@"2" => reg.Interrupts.SPI2,
                } });

                clear_it_flag(_cctx, _rctx);
                spi_its[@intFromEnum(_no)] = si.gf(_cctx);
                nvic.set_priority(_cctx, _rctx, si.nvic_cfg);
                nvic.enable(_cctx, _rctx);
            }
        }
        pub fn config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            const cfg = comptime get_ct_cfg(_cctx);
            const s = reg_spi();

            enable(_cctx, _rctx);

            try miso_config(_cctx, _rctx);
            try mosi_config(_cctx, _rctx);
            try sclk_config(_cctx, _rctx);
            try nss_config(_cctx, _rctx);

            s.CR1.SPE = 0;

            _ = utils.modify(s.CR1_struct, s.CR1, comptime .{
                .MSTR = @intFromEnum(cfg.mstr),

                .BR = @intFromEnum(cfg.br),
                .CPOL = @intFromEnum(cfg.cpol),
                .CPHA = @intFromEnum(cfg.cpha),
                .DFF = @intFromEnum(cfg.dff),
                .LSBFIRST = @intFromEnum(cfg.first),
                .CRCEN = 0,

                .BIDIMODE = @intFromEnum(cfg.bidimode),
                .BIDIOE = @intFromEnum(cfg.bidioe),
                .RXONLY = @intFromEnum(cfg.rxonly),

                .SSM = @intFromEnum(cfg.ssm),
                .SSI = @intFromEnum(cfg.ssi),
            });

            s.CR2.SSOE = comptime @intFromEnum(cfg.ssoe);

            config_it(_cctx, _rctx);
        }

        inline fn u_bit(comptime _dff: Spi_Ct_Config.DFF, comptime _T: type) type {
            const u_bit_size = utils.u_bit(_T);
            const max_bit_size: u16 = switch (_dff) {
                .@"16bit" => 16,
                .@"8bit" => 8,
            };
            const max_bit_size_str: []const u8 = switch (_dff) {
                .@"16bit" => "16",
                .@"8bit" => "8",
            };
            if (@bitSizeOf(u_bit_size) > max_bit_size) @compileError("Bitsize of type is more than " ++ max_bit_size_str);
            return utils.u_bit(_T);
        }
        fn t2u(comptime _dff: Spi_Ct_Config.DFF, comptime _T: type, _value: _T) u16 {
            return @as(u_bit(_dff, _T), @bitCast(_value));
        }
        fn u2t(comptime _dff: Spi_Ct_Config.DFF, comptime _T: type, _value: u16) _T {
            return @bitCast(@as(u_bit(_dff, _T), @truncate(_value)));
        }

        fn wait_SR(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _name: []const u8, comptime _value: u1) Error!void {
            const s = reg_spi();
            if (@field(s.SR, _name) == _value) return;

            sys.tick.start(_cctx, _rctx, 10_000);
            defer sys.tick.stop(_cctx, _rctx);

            while (@field(s.SR, _name) != _value) {
                if (sys.tick.finished(_cctx, _rctx) == true) {
                    return Error.Wait_SR_Time_Out;
                }
            }
        }
        inline fn wait_BSY(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            wait_SR(_cctx, _rctx, "BSY", 0) catch return Error.Wait_BSY_Time_Out;
        }

        fn write_read_data(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _T: type, _rx_data: []_T, _tx_data: []const _T) Error!void {
            const cfg = comptime get_ct_cfg(_cctx);
            const s = reg_spi();

            const size: usize = @min(_rx_data.len, _tx_data.len);
            var tx_index: usize = 0;
            var rx_index: usize = 0;
            var txallowed = true;

            // TODO CRC

            if (cfg.mstr == .slave or size == 1) {
                s.DR.DR = t2u(cfg.dff, _T, _tx_data[0]);
                tx_index += 1;
            }

            // TODO CRC

            sys.tick.start(_cctx, _rctx, 100_000);
            defer sys.tick.stop(_cctx, _rctx);

            while (tx_index < _tx_data.len or rx_index < _rx_data.len) {
                if (s.SR.TXE == 0b1 and tx_index < _tx_data.len and txallowed == true) {
                    s.DR.DR = t2u(cfg.dff, _T, _tx_data[tx_index]);
                    tx_index += 1;
                    txallowed = false;

                    sys.tick.reset(_cctx, _rctx);
                    // TODO CRC
                }
                if (s.SR.RXNE == 0b1 and rx_index < _rx_data.len) {
                    _rx_data[rx_index] = u2t(cfg.dff, _T, s.DR.DR);
                    rx_index += 1;
                    txallowed = true;

                    sys.tick.reset(_cctx, _rctx);
                }
                if (sys.tick.finished(_cctx, _rctx) == true) {
                    return Error.Spi_Time_Out;
                }
            }
        }
        fn write_data(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _T: type, _data: []const _T) Error!void {
            const cfg = comptime get_ct_cfg(_cctx);
            const s = reg_spi();

            var index: usize = 0;

            // TODO CRC
            if (cfg.mstr == .slave or _data.len == 1) {
                s.DR.DR = t2u(cfg.dff, _T, _data[0]);
                index += 1;
            }

            // TODO CRC

            sys.tick.start(_cctx, _rctx, 100_000);
            defer sys.tick.stop(_cctx, _rctx);

            while (index < _data.len) {
                if (s.SR.TXE == 0b1) {
                    s.DR.DR = t2u(cfg.dff, _T, _data[index]);
                    index += 1;

                    sys.tick.reset(_cctx, _rctx);
                }
                if (sys.tick.finished(_cctx, _rctx) == true) {
                    return Error.Spi_Time_Out;
                }
            }
        }
        fn write_data_Ntimes(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _T: type, _value: _T, _size: usize) Error!void {
            const cfg = comptime get_ct_cfg(_cctx);
            const s = reg_spi();

            var index: usize = 0;

            // TODO CRC

            if (cfg.mstr == .slave or _size == 1) {
                s.DR.DR = t2u(cfg.dff, _T, _value);
                index += 1;
            }

            // TODO CRC

            sys.tick.start(_cctx, _rctx, 100_000);
            defer sys.tick.stop(_cctx, _rctx);

            while (index < _size) {
                if (s.SR.TXE == 0b1) {
                    s.DR.DR = t2u(cfg.dff, _T, _value);
                    index += 1;

                    sys.tick.reset(_cctx, _rctx);
                }
                if (sys.tick.finished(_cctx, _rctx) == true) {
                    return Error.Spi_Time_Out;
                }
            }
        }
        fn read_data(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _T: type, _data: []_T) Error!void {
            const cfg = comptime get_ct_cfg(_cctx);
            const s = reg_spi();

            if (cfg.bidimode == .bidirection and cfg.bidioe == .tx)
                @compileError("Cannot read data with Configuration of `bidioe.tx` and `rxonly.rxonly` and `bidimode.unidirection`!");

            if (s.CR1.SPE == 0) s.CR1.SPE = 0b1;

            var index: usize = 0;

            sys.tick.start(_cctx, _rctx, 100_000);
            defer sys.tick.stop(_cctx, _rctx);

            while (index < _data.len) {
                if (s.SR.TXE == 0b1) {
                    _data[index] = u2t(cfg.dff, _T, s.DR.DR);
                    index += 1;

                    sys.tick.reset(_cctx, _rctx);
                }
                if (sys.tick.finished(_cctx, _rctx) == true) {
                    return Error.Spi_Time_Out;
                }
            }
        }

        pub fn write_read(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _T: type, _rx_data: []_T, _tx_data: []const _T) !void {
            const cfg = comptime get_ct_cfg(_cctx);
            const s = reg_spi();
            if (s.CR1.SPE == 0) s.CR1.SPE = 0b1;
            defer s.CR1.SPE = 0;

            try write_read_data(_cctx, _rctx, _T, _rx_data, _tx_data);

            try wait_BSY(_cctx, _rctx);

            if (cfg.bidimode == .unidirection) s.SR.OVR = 0;
        }
        pub fn write(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _T: type, _data: []const _T) !void {
            const cfg = comptime get_ct_cfg(_cctx);
            const s = reg_spi();

            if (cfg.bidimode == .bidirection) {
                s.CR1.SPE = 0b1;
                s.CR1.BIDIOE = @intFromEnum(cfg.bidioe);
                if (cfg.bidioe != .tx) @compileError("Single Direction with wrong mode!");
            }
            if (s.CR1.SPE == 0) s.CR1.SPE = 0b1;
            defer s.CR1.SPE = 0;

            try write_data(_cctx, _rctx, _T, _data);

            try wait_BSY(_cctx, _rctx);

            if (cfg.mstr == .master and cfg.bidimode == .unidirection and cfg.rxonly == .duplex) _ = u2t(cfg.dff, _T, s.DR.DR);

            if (cfg.bidimode == .unidirection) s.SR.OVR = 0;
        }
        pub fn write_Ntimes(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _T: type, _value: _T, _size: usize) !void {
            const cfg = comptime get_ct_cfg(_cctx);
            const s = reg_spi();

            if (cfg.bidimode == .bidirection) {
                s.CR1.SPE = 0b1;
                s.CR1.BIDIOE = @intFromEnum(cfg.bidioe);
                if (cfg.bidioe != .tx) @compileError("Single Direction with wrong mode!");
            }
            if (s.CR1.SPE == 0) s.CR1.SPE = 0b1;
            defer s.CR1.SPE = 0;

            try write_data_Ntimes(_cctx, _rctx, _T, _value, _size);

            try wait_BSY(_cctx, _rctx);

            if (cfg.mstr == .master and cfg.bidimode == .unidirection and cfg.rxonly == .duplex) _ = u2t(cfg.dff, _T, s.DR.DR);

            if (cfg.bidimode == .unidirection) s.SR.OVR = 0;
        }
        pub fn read(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _T: type, _data: []_T) !void {
            const cfg = comptime get_ct_cfg(_cctx);
            const s = reg_spi();

            if (cfg.mstr == .master and cfg.bidimode == .unidirection and cfg.rxonly == .duplex) return write_read(_cctx, _rctx, _T, _data, _data);

            if (cfg.bidimode == .bidirection) {
                s.CR1.SPE = 0b1;
                s.CR1.BIDIOE = @intFromEnum(cfg.bidioe);
                if (cfg.bidioe != .rx) @compileError("Single Direction with wrong mode!");
            }
            if (s.CR1.SPE == 0) s.CR1.SPE = 0b1;
            defer s.CR1.SPE = 0;

            try read_data(_cctx, _rctx, _T, _data);

            // TODO CRC

        }

        pub fn it_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            const s = reg_spi();
            const cfg = comptime get_ct_cfg(_cctx);
            const si = cfg.spi_it.?;
            if (si.rxneie == .disable and si.txeie == .disable) @compileError("Cannot start with both of rxneie and txeie is disable!");

            if (s.CR1.SPE == 0) s.CR1.SPE = 0b1;

            set_it_enable_bit(_cctx, _rctx);
        }
        pub fn it_stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            clear_it_enable_bit(_cctx, _rctx);
        }

        pub fn dma_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            const s = reg_spi();
            const ct_cfg = comptime get_ct_cfg(_cctx);
            const rt_cfg = get_rt_cfg(_rctx);

            const size = switch (ct_cfg.dff) {
                .@"8bit" => .@"8bit",
                .@"16bit" => .@"16bit",
            };

            if (s.CR1.SPE == 0) s.CR1.SPE = 0b1;

            if (comptime get_rx_dma_ch_config(_cctx)) |_| {
                if (rt_cfg) |src| {
                    if (src.rx_cfg) |crc| {
                        const dcrc = dma.Ch_Rt_Config{
                            .ma = crc.ma,
                            .mem2mem = .disable,
                            .circ = crc.circ,
                            .minc = crc.minc,
                            .pinc = .disable,
                            .ndt = crc.ndt,
                            .pa = @intFromPtr(s.DR),
                            .psize = size,
                            .msize = size,
                        };
                        try rx_dma_ch().config(_cctx, _rctx, dcrc);
                        rx_dma_ch().start(_cctx, _rctx);
                        s.CR2.RXDMAEN = 0b1;
                    }
                }
            }
            if (comptime get_tx_dma_ch_config(_cctx)) |_| {
                if (rt_cfg) |src| {
                    if (src.tx_cfg) |crc| {
                        const dcrc = dma.Ch_Rt_Config{
                            .ma = crc.ma,
                            .mem2mem = .disable,
                            .circ = crc.circ,
                            .minc = crc.minc,
                            .pinc = .disable,
                            .ndt = crc.ndt,
                            .pa = @intFromPtr(s.DR),
                        };
                        try tx_dma_ch().config(_cctx, _rctx, dcrc);
                        tx_dma_ch().start(_cctx, _rctx);
                        s.CR2.TXDMAEN = 0b1;
                    }
                }
            }
        }
        pub fn dma_stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            const s = reg_spi();
            if (comptime get_tx_dma_ch_config(_cctx)) |_| {
                rx_dma_ch().stop(_cctx, _rctx);
                s.CR2.RXDMAEN = 0;
            }
            if (comptime get_tx_dma_ch_config(_cctx)) |_| {
                tx_dma_ch().stop(_cctx, _rctx);
                s.CR2.TXDMAEN = 0;
            }
        }
    };
}

pub fn Spi(comptime _no: No) type {
    return spi.Spi(
        ctx.Ct_Context,
        ctx.Rt_Context,
        Spi_Ct_Config,
        Spi_Rt_Config,
        No,
        Error,
        _Spi,
        _no,
    );
}
