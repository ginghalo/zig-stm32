const reg = @import("reg.zig");
const gpio = @import("gpio.zig");
const sys = @import("sys.zig");
const ctx = @import("ctx.zig");
const it = @import("it.zig");
const dma = @import("dma.zig");

const interface = @import("../stm32.zig").interface;
const utils = interface.utils;
const uart = interface.uart;

pub var uart_its: [NO_NUMS]?*const fn () void = .{null} ** NO_NUMS;

pub const @"1" = Uart(.@"1");
pub const @"2" = Uart(.@"2");
pub const @"3" = Uart(.@"3");

pub const No = enum { @"1", @"2", @"3" };
pub const NO_NUMS = @typeInfo(No).Enum.fields.len;

pub const Uart_Ct_Context: type = CONTEXT: {
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
                    .type = ?Uart_Ct_Config,
                    .default_value = @ptrCast(&@as(?Uart_Ct_Config, null)),
                    .is_comptime = false,
                    .alignment = @alignOf(?Uart_Ct_Config),
                };
            }
            break :FIELDS &fields;
        },
    } });
};
pub const Uart_Rt_Context: type = CONTEXT: {
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
                    .type = ?Uart_Rt_Config,
                    .default_value = @ptrCast(&@as(?Uart_Rt_Config, null)),
                    .is_comptime = false,
                    .alignment = @alignOf(?Uart_Rt_Config),
                };
            }
            break :FIELDS &fields;
        },
    } });
};

pub const Uart_Ct_Config = struct {
    sbk: SBK = .disable,
    rwk: RWK = .disable,
    ps: PS = .even,
    pce: PCE = .disable,
    wake: WAKE = .idle,
    m: WordLen = .@"8bit",

    addr: ?ADDR = null,
    stop: STOP = .@"1.0",

    br: BR = 115200,

    uart_it: ?Uart_It = null,
    uart_dma: ?Uart_Dma = null,

    pub const SBK = enum(u1) { disable, enable };
    pub const RWK = enum(u1) { disable, enable };
    pub const PS = enum { even, odd };
    pub const PCE = enum { disable, enable };
    pub const WAKE = enum { idle, addr };
    pub const WordLen = enum(u1) { @"8bit", @"9bit" };

    pub const ADDR = u4;
    pub const STOP = enum(u2) { @"1.0", @"0.5", @"2.0", @"1.5" };

    pub const BR = u32;

    pub const Uart_It = struct {
        gf: *const fn (comptime _ctx: ctx.Ct_Context) fn () void,
        nvic_cfg: it.Nvic_Config = .{},

        rxneie: Rxneie = .disable,
        txeie: Txeie = .disable,
        // ctsie: Ctsie = .disable, TODO not used
        tcie: Tcie = .disable,
        // txneie: Txneie = .disable, not exsist?
        idleie: Idleie = .disable,
        peie: Peie = .disable,
        lbdie: Lbdie = .disable,
        eie: Eie = .disable,
        pub const Rxneie = enum(u1) { disable, enable };
        pub const Txeie = enum(u1) { disable, enable };
        // pub const Ctsie = enum(u1) { disable, enable };
        pub const Tcie = enum(u1) { disable, enable };
        // pub const Txneie = enum(u1) { disable, enable };
        pub const Idleie = enum(u1) { disable, enable };
        pub const Peie = enum(u1) { disable, enable };
        pub const Lbdie = enum(u1) { disable, enable };
        pub const Eie = enum(u1) { disable, enable };
    };
    pub const Uart_Dma = struct {
        rx_cfg: ?Dma_Ch_Ct_Config = null,
        tx_cfg: ?Dma_Ch_Ct_Config = null,
        pub const Dma_Ch_Ct_Config = struct {
            it: dma.Ch_Ct_Config.Ch_It,
            pl: dma.Ch_Ct_Config.Pl = .low,
        };
    };
};
pub const Uart_Rt_Config = struct {
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
    Wait_SR_Time_Out,
    Wait_RXNE_Time_Out,
    Wait_TXE_Time_Out,
    Wait_TC_Time_Out,
};

fn _Uart(comptime _Ct_Context: type, comptime _Rt_Context: type, comptime _no: No) type {
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;
        pub fn reg_uart() type {
            return switch (_no) {
                .@"1" => reg.USART1,
                .@"2" => reg.USART2,
                .@"3" => reg.USART3,
            };
        }

        inline fn rx_dma_ch_pos() dma.Pos {
            return switch (_no) {
                .@"1" => .{ .no = .@"1", .ch = .@"5" },
                .@"2" => .{ .no = .@"1", .ch = .@"6" },
                .@"3" => .{ .no = .@"1", .ch = .@"3" },
            };
        }
        inline fn tx_dma_ch_pos() dma.Pos {
            return switch (_no) {
                .@"1" => .{ .no = .@"1", .ch = .@"4" },
                .@"2" => .{ .no = .@"1", .ch = .@"7" },
                .@"3" => .{ .no = .@"1", .ch = .@"2" },
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
                .@"1" => reg.RCC.APB2ENR.USART1EN = 0b1,
                .@"2" => reg.RCC.APB1ENR.USART2EN = 0b1,
                .@"3" => reg.RCC.APB1ENR.USART3EN = 0b1,
            }
        }
        inline fn ape_disable() void {
            switch (_no) {
                .@"1" => reg.RCC.APB2ENR.USART1EN = 0,
                .@"2" => reg.RCC.APB1ENR.USART2EN = 0,
                .@"3" => reg.RCC.APB1ENR.USART3EN = 0,
            }
        }
        inline fn gpio_enable() void {
            switch (_no) {
                .@"1" => gpio.A.enable(),
                .@"2" => gpio.A.enable(),
                .@"3" => gpio.B.enable(),
            }
        }

        pub inline fn rx_pin() type {
            return switch (_no) {
                .@"1" => gpio.A.pin(.@"10"),
                .@"2" => gpio.A.pin(.@"3"),
                .@"3" => gpio.B.pin(.@"11"),
            };
        }
        pub inline fn tx_pin() type {
            return switch (_no) {
                .@"1" => gpio.A.pin(.@"9"),
                .@"2" => gpio.A.pin(.@"2"),
                .@"3" => gpio.B.pin(.@"10"),
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
                .@"1" => sys.clock.get_freq(_cctx).pclk2,
                .@"2" => sys.clock.get_freq(_cctx).pclk1,
                .@"3" => sys.clock.get_freq(_cctx).pclk1,
            };
        }

        pub inline fn get_ct_cfg(comptime _cctx: Ct_Context) Uart_Ct_Config {
            return @field(_cctx.uart, "cfg" ++ @tagName(_no)).?;
        }
        pub inline fn get_rt_cfg(_rctx: *Rt_Context) ?Uart_Rt_Config {
            return @field(_rctx.uart, "cfg" ++ @tagName(_no));
        }

        pub inline fn get_no() No {
            return _no;
        }

        // according to the tablet 21 from dataset of stm32f10x
        inline fn get_rx_pin_config() ?gpio.Pin_Ct_Config {
            return .{ .Input = .{ .mode = .PU } };
        }
        inline fn get_tx_pin_config() ?gpio.Pin_Ct_Config {
            return .{ .Output = .{ .mode = .AFPP, .speed = .@"50MHz" } };
        }

        inline fn get_rx_dma_ch_config(comptime _cctx: Ct_Context) ?dma.Ch_Ct_Config {
            const ct_cfg = comptime get_ct_cfg(_cctx);
            if (ct_cfg.uart_dma) |uart_dma| {
                switch (ct_cfg.m) {
                    .@"8bit" => {},
                    .@"9bit" => @compileError("Not supported yet"),
                }
                if (uart_dma.rx_cfg) |cc| {
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
            if (ct_cfg.uart_dma) |uart_dma| {
                switch (ct_cfg.m) {
                    .@"8bit" => {},
                    .@"9bit" => @compileError("Not supported yet"),
                }
                if (uart_dma.tx_cfg) |cc| {
                    return dma.Ch_Ct_Config{
                        .msize = .@"8bit",
                        .psize = .@"8bit",
                        .dir = .memory,
                        .ch = tx_dma_ch_pos().ch,
                        .ch_it = cc.it,
                        .pl = cc.pl,
                    };
                }
            }
            return null;
        }

        fn rx_use(_cctx: *_Ct_Context) void {
            if (comptime get_rx_pin_config()) |cfg| rx_pin().use(_cctx, cfg);
            if (comptime get_rx_dma_ch_config(_cctx.*)) |cfg| rx_dma_ch().use(_cctx, cfg);
        }
        fn tx_use(_cctx: *_Ct_Context) void {
            if (comptime get_tx_pin_config()) |cfg| tx_pin().use(_cctx, cfg);
            if (comptime get_tx_dma_ch_config(_cctx.*)) |cfg| tx_dma_ch().use(_cctx, cfg);
        }
        fn rx_unuse(_cctx: *_Ct_Context) void {
            if (comptime get_rx_pin_config()) |_| try rx_pin().unuse(_cctx);
            if (comptime get_rx_dma_ch_config(_cctx.*)) |_| rx_dma_ch().unuse(_cctx);
        }
        fn tx_unuse(_cctx: *_Ct_Context) void {
            if (comptime get_tx_pin_config()) |_| try tx_pin().unuse(_cctx);
            if (comptime get_tx_dma_ch_config(_cctx.*)) |_| tx_dma_ch().unuse(_cctx);
        }
        pub fn use(_cctx: *_Ct_Context) void {
            tx_use(_cctx);
            rx_use(_cctx);
        }
        pub fn unuse(_cctx: *_Ct_Context) void {
            tx_unuse(_cctx);
            rx_unuse(_cctx);
        }

        pub inline fn clear_it_flag(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;
            const u = reg_uart();
            _ = utils.modify(u.SR_struct, u.SR, comptime .{
                .RXNE = 0,
                .TC = 0,
                .TXE = 0,
                .LBD = 0,
                .CTS = 0,
                .NE = 0,
                .FE = 0,
                .PE = 0,
            });
            // IDLE
            if (u.SR.IDLE == 0b1) {
                _ = u.SR.*;
                _ = u.DR.DR;
                u.SR.IDLE = 0;
            }
            // ORE
            if (u.SR.ORE == 0b1) {
                _ = u.SR.*;
                _ = u.DR.*;
                _ = u.CR1.*;
                _ = u.CR2.*;
                _ = u.CR3.*;
                u.SR.ORE = 0;
            }
        }
        pub inline fn set_it_enable_bit(comptime _cctx: Ct_Context, _: *Rt_Context) void {
            const cfg = comptime get_ct_cfg(_cctx);
            const u = reg_uart();
            const ui = cfg.uart_it.?;

            u.CR3.EIE = comptime @intFromEnum(ui.eie);
            // _ = utils.modify(u.CR3_struct, u.CR3, comptime .{
            //     .CTSIE = @intFromEnum(ui.ctsie),
            //     .EIE = @intFromEnum(ui.eie),
            // });
            _ = utils.modify(u.CR1_struct, u.CR1, comptime .{
                .TXEIE = @intFromEnum(ui.txeie),
                .TCIE = @intFromEnum(ui.tcie),
                .PEIE = @intFromEnum(ui.peie),
                .IDLEIE = @intFromEnum(ui.idleie),
                .RXNEIE = @intFromEnum(ui.rxneie),
            });
        }
        pub inline fn clear_it_enable_bit(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;
            const u = reg_uart();

            u.CR3.EIE = 0;
            // _ = utils.modify(u.CR3_struct, u.CR3, comptime .{
            //     .CTSIE = 0,
            //     .EIE = 0,
            // });
            _ = utils.modify(u.CR1_struct, u.CR1, comptime .{
                .TXEIE = 0,
                .TCIE = 0,
                .PEIE = 0,
                .IDLEIE = 0,
                .RXNEIE = 0,
            });
        }

        fn div_round(comptime _numerator: u32, comptime _denominator: u32) u32 {
            return (_numerator + _denominator / 2) / _denominator;
        }

        inline fn config_it(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            const cfg = comptime get_ct_cfg(_cctx);

            if (cfg.uart_it) |ui| {
                const nvic = it.Nvic(.{ .ext = switch (_no) {
                    .@"1" => reg.Interrupts.USART1,
                    .@"2" => reg.Interrupts.USART2,
                    .@"3" => reg.Interrupts.USART3,
                } });

                clear_it_flag(_cctx, _rctx);
                uart_its[@intFromEnum(_no)] = ui.gf(_cctx);
                nvic.set_priority(_cctx, _rctx, ui.nvic_cfg);
                nvic.enable(_cctx, _rctx);
            }
        }

        fn rx_config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            if (comptime get_rx_pin_config()) |cfg| try rx_pin().config(_cctx, _rctx, cfg);
        }
        fn tx_config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            if (comptime get_tx_pin_config()) |cfg| try tx_pin().config(_cctx, _rctx, cfg);
        }

        pub fn config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            const u = reg_uart();
            const cfg = comptime get_ct_cfg(_cctx);

            enable(_cctx, _rctx);

            try rx_config(_cctx, _rctx);
            try tx_config(_cctx, _rctx);

            u.CR1.UE = 0;

            const freq = comptime get_freq(_cctx);
            const mantissa: u12 = comptime @truncate(freq / (16 * cfg.br));
            const fraction: u4 = comptime @truncate(div_round(freq - (@as(u32, mantissa) * 16 * cfg.br), cfg.br));

            _ = utils.modify(u.BRR_struct, u.BRR, .{
                .DIV_Mantissa = mantissa,
                .DIV_Fraction = fraction,
            });

            _ = utils.modify(u.CR1_struct, u.CR1, comptime .{
                .M = @intFromEnum(cfg.m),
                .PCE = @intFromEnum(cfg.pce),
                .PS = @intFromEnum(cfg.ps),
                .SBK = @intFromEnum(cfg.sbk),
                .RWU = @intFromEnum(cfg.rwk),
                .WAKE = @intFromEnum(cfg.wake),
                .TE = 0b1,
                .RE = 0b1,
            });

            _ = utils.modify(u.CR2_struct, u.CR2, comptime .{
                .LINEN = 0,
                .CLKEN = 0,
                .ADD = if (cfg.addr) |a| a else 0,
                .STOP = @intFromEnum(cfg.stop),
            });

            _ = utils.modify(u.CR3_struct, u.CR3, comptime .{
                .SCEN = 0,
                .HDSEL = 0,
                .IREN = 0,
                .RTSE = 0,
                .CTSE = 0,
            });

            config_it(_cctx, _rctx);

            u.CR1.UE = 0b1;
        }

        fn t2u(comptime _T: type, _value: _T) u9 {
            const bit_size: u16 = @bitSizeOf(_T);
            if (bit_size > 9) @compileError("Bitsize of type is more than 9");

            const u_bit_size: type = @Type(.{ .Int = .{
                .signedness = .unsigned,
                .bits = bit_size,
            } });

            return @as(u_bit_size, @bitCast(_value));
        }
        fn u2t(comptime _T: type, _value: u9) _T {
            const bit_size: u16 = @bitSizeOf(_T);
            if (bit_size > 9) @compileError("Bitsize of type is more than 9");

            const u_bit_size: type = @Type(.{ .Int = .{
                .signedness = .unsigned,
                .bits = bit_size,
            } });

            return @bitCast(@as(u_bit_size, @truncate(_value)));
        }

        fn wait_SR(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _name: []const u8, comptime _value: u1) Error!void {
            const u = reg_uart();
            if (@field(u.SR, _name) == _value) return;

            sys.tick.start(_cctx, _rctx, 10_000);
            defer sys.tick.stop(_cctx, _rctx);

            while (@field(u.SR, _name) != _value) {
                if (sys.tick.finished(_cctx, _rctx) == true) {
                    return Error.Wait_SR_Time_Out;
                }
            }
        }
        inline fn wait_TXE(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            wait_SR(_cctx, _rctx, "TXE", 0b1) catch return Error.Wait_TXE_Time_Out;
        }
        inline fn wait_RXNE(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            wait_SR(_cctx, _rctx, "RXNE", 0b1) catch return Error.Wait_RXNE_Time_Out;
        }
        inline fn wait_TC(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            wait_SR(_cctx, _rctx, "TC", 0b1) catch return Error.Wait_TC_Time_Out;
        }

        fn write_data(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _T: type, _data: []const _T) !void {
            const u = reg_uart();

            for (_data) |d| {
                try wait_TXE(_cctx, _rctx);
                u.DR.DR = t2u(_T, d);
            }
        }
        fn read_data(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _T: type, _data: []_T) !void {
            const u = reg_uart();

            for (0.._data.len) |index| {
                wait_RXNE(_cctx, _rctx);
                _data[index] = u2t(_T, u.DR.DR);
            }
        }

        pub fn write(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _T: type, _data: []const _T) !void {
            const cfg = comptime get_ct_cfg(_cctx);
            const u = reg_uart();

            try write_data(_cctx, _rctx, _T, _data);

            if (cfg.uart_it) |ui| {
                if (ui.tcie == .enable) {
                    u.CR1.TCIE = 0b1;
                } else {
                    try wait_TC(_cctx, _rctx); // interrupt clear it(TC)
                }
            }
        }
        pub fn read(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _T: type, _data: []_T) !void {
            try read_data(_cctx, _rctx, _T, _data);
        }

        pub fn it_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            const cfg = comptime get_ct_cfg(_cctx);
            const ui = cfg.uart_it.?;
            if (ui.rxneie == .disable and ui.txeie == .disable and ui.idleie == .disable) @compileError("Cannot start with both of rxneie and txeie is disable!");
            set_it_enable_bit(_cctx, _rctx);
        }
        pub fn it_stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            clear_it_enable_bit(_cctx, _rctx);
        }

        pub fn dma_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            const u = reg_uart();
            const rt_cfg = get_rt_cfg(_rctx);
            if (comptime get_rx_dma_ch_config(_cctx)) |_| {
                if (rt_cfg) |urc| {
                    if (urc.rx_cfg) |crc| {
                        const dcrc = dma.Ch_Rt_Config{
                            .ma = crc.ma,
                            .pa = @intFromPtr(u.DR),
                            .mem2mem = .disable,
                            .circ = crc.circ,
                            .minc = crc.minc,
                            .pinc = .disable,
                            .ndt = crc.ndt,
                        };
                        try rx_dma_ch().config(_cctx, _rctx, dcrc);
                        rx_dma_ch().start(_cctx, _rctx);
                        u.CR3.DMAR = 0b1;
                    }
                }
            }
            if (comptime get_tx_dma_ch_config(_cctx)) |_| {
                if (rt_cfg) |urc| {
                    if (urc.tx_cfg) |crc| {
                        const dcrc = dma.Ch_Rt_Config{
                            .ma = crc.ma,
                            .pa = @intFromPtr(u.DR),
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
                        u.CR3.DMAT = 0b1;
                    }
                }
            }
        }
        pub fn dma_stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            const u = reg_uart();
            if (comptime get_tx_dma_ch_config(_cctx)) |_| {
                rx_dma_ch().stop(_cctx, _rctx);
                u.CR3.DMAR = 0;
            }
            if (comptime get_tx_dma_ch_config(_cctx)) |_| {
                tx_dma_ch().stop(_cctx, _rctx);
                u.CR3.DMAT = 0;
            }
        }
    };
}

pub fn Uart(comptime _no: No) type {
    return uart.Uart(
        ctx.Ct_Context,
        ctx.Rt_Context,
        Uart_Ct_Config,
        Uart_Rt_Config,
        No,
        Error,
        _Uart,
        _no,
    );
}
