const reg = @import("reg.zig");
const sys = @import("sys.zig");
const ctx = @import("ctx.zig");
const it = @import("it.zig");

const gpio = @import("../stm32.zig").interface.gpio;

const meta_eql = @import("std").meta.eql;

pub const A = Gpio(.A);
pub const B = Gpio(.B);
pub const C = Gpio(.C);
pub const D = Gpio(.D);

pub var pin_its: [NO_NUMS]?*const fn () void = .{null} ** NO_NUMS;

pub const Gpio_Ct_Context = struct {
    cfgs: [PORT_NUMS][NO_NUMS]?Pin_Ct_Config = .{.{null} ** NO_NUMS} ** PORT_NUMS,

    single_cfgs: Single_Configs = &[_]Single_Config{},
    pub const Single_Config = struct { pos: Pos, pin_config: Pin_Ct_Config };
    pub const Single_Configs = []Single_Config;
};
pub const Gpio_Rt_Context = struct {
    cfgs: [PORT_NUMS][NO_NUMS]?Pin_Rt_Config = .{.{null} ** NO_NUMS} ** PORT_NUMS,
};

pub const PORT_NUMS = @typeInfo(Pos.Port).Enum.fields.len;
pub const NO_NUMS = @typeInfo(Pos.No).Enum.fields.len;
pub const Pos = struct {
    port: Port,
    no: No,
    pub const Port = enum { A, B, C, D, E, F, G };
    pub const No = enum { @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15" };
};

pub const Pin_Ct_Config = union(enum) {
    Input: InCfg,
    Output: OutCfg,

    pub const InCfg = struct {
        mode: Mode = .Ana,
        pin_it: ?Pin_it = null,

        pub const Pin_it = struct {
            gf: *const fn (comptime _ctx: ctx.Ct_Context) fn () void,
            nvic_cfg: it.Nvic_Config = .{},
            exti_cfg: it.Exti_Config = .{},
        };
        pub const Mode = enum(u2) { Ana = 0, Flt, PU, PD };
    };
    pub const OutCfg = struct {
        mode: Mode = .PP,
        speed: Speed = .@"10MHz",
        level: ?Level = null,

        pub const Mode = enum(u2) { PP = 0, OD, AFPP, AFOD };
        pub const Speed = enum(u2) { @"10MHz" = 0b01, @"2MHz", @"50MHz" };
        pub const Level = enum(u1) { low = 0, high };
    };

    pub inline fn to_cnf(comptime _config: Pin_Ct_Config) u2 {
        return switch (_config) {
            .Output => |out| @intFromEnum(out.mode),
            .Input => |in| switch (in.mode) {
                .PD => 0b10,
                else => |m| @intFromEnum(m),
            },
        };
    }
    pub inline fn to_mode(comptime _config: Pin_Ct_Config) u2 {
        return switch (_config) {
            .Output => |out| @intFromEnum(out.speed),
            .Input => 0,
        };
    }
    pub inline fn eql(_p1: Pin_Ct_Config, _p2: Pin_Ct_Config) bool {
        return meta_eql(_p1, _p2);
    }
};
pub const Pin_Rt_Config = struct {};
fn _Gpio(
    comptime _Ct_Context: type,
    comptime _Rt_Context: type,
    comptime _port: Pos.Port,
) type {
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;
        pub fn reg_gpio() type {
            return switch (_port) {
                .A => reg.GPIOA,
                .B => reg.GPIOB,
                .C => reg.GPIOC,
                .D => reg.GPIOD,
                .E => reg.GPIOE,
                .F => reg.GPIOF,
                .G => reg.GPIOG,
            };
        }

        fn ape_enable() void {
            reg.RCC.APB2ENR.AFIOEN = 0b1;
            switch (_port) {
                .A => reg.RCC.APB2ENR.IOPAEN = 0b1,
                .B => reg.RCC.APB2ENR.IOPBEN = 0b1,
                .C => reg.RCC.APB2ENR.IOPCEN = 0b1,
                .D => reg.RCC.APB2ENR.IOPDEN = 0b1,
                .E => reg.RCC.APB2ENR.IOPEEN = 0b1,
                .F => reg.RCC.APB2ENR.IOPFEN = 0b1,
                .G => reg.RCC.APB2ENR.IOPGEN = 0b1,
            }
        }
        fn ape_disable() void {
            switch (_port) {
                .A => reg.RCC.APB2ENR.IOPAEN = 0,
                .B => reg.RCC.APB2ENR.IOPBEN = 0,
                .C => reg.RCC.APB2ENR.IOPCEN = 0,
                .D => reg.RCC.APB2ENR.IOPDEN = 0,
                .E => reg.RCC.APB2ENR.IOPEEN = 0,
                .F => reg.RCC.APB2ENR.IOPFEN = 0,
                .G => reg.RCC.APB2ENR.IOPGEN = 0,
            }
        }

        pub fn enable() void {
            ape_enable();
        }
        pub fn disable() void {
            ape_disable();
        }

        pub fn pin(comptime _no: Pos.No) type {
            return Pin(.{ .port = _port, .no = _no });
        }

        pub fn get(comptime _cctx: Ct_Context, _rctx: *Rt_Context) u16 {
            _ = _cctx;
            _ = _rctx;
            return @truncate(@as(u32, @bitCast(reg_gpio().IDR.*)));
        }
        pub fn set(comptime _cctx: Ct_Context, _rctx: *Rt_Context, _value: u16) void {
            _ = _cctx;
            _ = _rctx;
            reg_gpio().ODR.* = @bitCast(@as(u32, _value));
        }
    };
}

fn _Pin(
    comptime _Ct_Context: type,
    comptime _Rt_Context: type,
    comptime _pos: Pos,
) type {
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;
        pub fn reg_gpio() type {
            return switch (_pos.port) {
                .A => reg.GPIOA,
                .B => reg.GPIOB,
                .C => reg.GPIOC,
                .D => reg.GPIOD,
                .E => reg.GPIOE,
                .F => reg.GPIOF,
                .G => reg.GPIOG,
            };
        }

        pub inline fn get_cfg(comptime _cctx: Ct_Context, _rctx: *Rt_Context) Pin_Ct_Config {
            return .{
                comptime _cctx.gpio.cfgs[@intFromEnum(_pos.port)][@intFromEnum(_pos.no)].?,
                _rctx.gpio.cfgs[@intFromEnum(_pos.port)][@intFromEnum(_pos.no)],
            };
        }

        pub inline fn check_use(_cctx: *_Ct_Context) ?Pin_Ct_Config {
            return _cctx.gpio.cfgs[@intFromEnum(_pos.port)][@intFromEnum(_pos.no)];
        }
        pub inline fn assert_use(_cctx: *_Ct_Context) void {
            if (check_use(_cctx) != null) @compileError("The Pin" ++ @tagName(_pos.no) ++ " from GPIO" ++ @tagName(_pos.port) ++ " had been used before!");
        }
        pub inline fn use(_cctx: *_Ct_Context, comptime _cfg: Pin_Ct_Config) void {
            assert_use(_cctx);
            _cctx.gpio.cfgs[@intFromEnum(_pos.port)][@intFromEnum(_pos.no)] = _cfg;
        }
        pub inline fn unuse(_cctx: *_Ct_Context) void {
            _cctx.gpio.cfgs[@intFromEnum(_pos.port)][@intFromEnum(_pos.no)] = null;
        }

        inline fn afio_exti_config_it(comptime _config: Pin_Ct_Config) void {
            switch (_config) {
                .Output => {},
                .Input => |cfg| {
                    if (cfg.pin_it) |_| {
                        reg.RCC.APB2ENR.AFIOEN = 0b1;
                        switch (_pos.no) {
                            .@"0" => reg.AFIO.EXTICR1.EXTI0 = comptime @intFromEnum(_pos.port),
                            .@"1" => reg.AFIO.EXTICR1.EXTI1 = comptime @intFromEnum(_pos.port),
                            .@"2" => reg.AFIO.EXTICR1.EXTI2 = comptime @intFromEnum(_pos.port),
                            .@"3" => reg.AFIO.EXTICR1.EXTI3 = comptime @intFromEnum(_pos.port),
                            .@"4" => reg.AFIO.EXTICR2.EXTI4 = comptime @intFromEnum(_pos.port),
                            .@"5" => reg.AFIO.EXTICR2.EXTI5 = comptime @intFromEnum(_pos.port),
                            .@"6" => reg.AFIO.EXTICR2.EXTI6 = comptime @intFromEnum(_pos.port),
                            .@"7" => reg.AFIO.EXTICR2.EXTI7 = comptime @intFromEnum(_pos.port),
                            .@"8" => reg.AFIO.EXTICR3.EXTI8 = comptime @intFromEnum(_pos.port),
                            .@"9" => reg.AFIO.EXTICR3.EXTI9 = comptime @intFromEnum(_pos.port),
                            .@"10" => reg.AFIO.EXTICR3.EXTI10 = comptime @intFromEnum(_pos.port),
                            .@"11" => reg.AFIO.EXTICR3.EXTI11 = comptime @intFromEnum(_pos.port),
                            .@"12" => reg.AFIO.EXTICR4.EXTI12 = comptime @intFromEnum(_pos.port),
                            .@"13" => reg.AFIO.EXTICR4.EXTI13 = comptime @intFromEnum(_pos.port),
                            .@"14" => reg.AFIO.EXTICR4.EXTI14 = comptime @intFromEnum(_pos.port),
                            .@"15" => reg.AFIO.EXTICR4.EXTI15 = comptime @intFromEnum(_pos.port),
                        }
                    }
                },
            }
        }
        inline fn config_it(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _config: Pin_Ct_Config) void {
            afio_exti_config_it(_config);
            switch (_config) {
                .Output => {},
                .Input => |cfg| {
                    if (cfg.pin_it) |pi| {
                        const nvic = it.Nvic(.{ .ext = switch (_pos.no) {
                            .@"0" => reg.Interrupts.EXTI0,
                            .@"1" => reg.Interrupts.EXTI1,
                            .@"2" => reg.Interrupts.EXTI2,
                            .@"3" => reg.Interrupts.EXTI3,
                            .@"4" => reg.Interrupts.EXTI4,
                            .@"5", .@"6", .@"7", .@"8", .@"9" => reg.Interrupts.EXTI9_5,
                            .@"10", .@"11", .@"12", .@"13", .@"14", .@"15" => reg.Interrupts.EXTI15_10,
                        } });
                        const exti = it.Exti(@field(it.Line, @tagName(_pos.no)));

                        pin_its[@intFromEnum(_pos.no)] = pi.gf(_cctx);
                        nvic.set_priority(_cctx, _rctx, pi.nvic_cfg);
                        nvic.enable(_cctx, _rctx);
                        exti.enable(_cctx, _rctx, pi.exti_cfg);
                    }
                },
            }
        }

        pub fn config(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _config: Pin_Ct_Config) !void {
            const g = reg_gpio();

            //@compileLog(_pos, _config);
            Gpio(_pos.port).enable();

            if ((_pos.port == .B and _pos.no == .@"4") or (_pos.port == .B and _pos.no == .@"3") or (_pos.port == .A and _pos.no == .@"15")) {
                reg.AFIO.MAPR.SWJ_CFG = 0b010; // no jtag, use sw
                for (0..5) |_| asm volatile ("nop"); // wait for 2 cycles or more
            }
            if (_pos.port == .A and (_pos.no == .@"13" or _pos.no == .@"14")) {
                @compileError("Must use SW-DP!");
            }

            switch (_config) {
                .Input => |incfg| switch (incfg.mode) {
                    .PD => ct_set(_cctx, _rctx, 0),
                    .PU => ct_set(_cctx, _rctx, 0b1),
                    else => {},
                },
                .Output => |outcfg| if (outcfg.level) |level| ct_set(_cctx, _rctx, @intFromEnum(level)),
            }

            switch (_pos.no) {
                .@"0" => {
                    try sys.tick.modify_until_done(_cctx, _rctx, 1000, g.CRL_struct, g.CRL, comptime .{
                        .CNF0 = _config.to_cnf(),
                        .MODE0 = _config.to_mode(),
                    }, null);
                },
                .@"1" => {
                    try sys.tick.modify_until_done(_cctx, _rctx, 1000, g.CRL_struct, g.CRL, comptime .{
                        .CNF1 = _config.to_cnf(),
                        .MODE1 = _config.to_mode(),
                    }, null);
                },
                .@"2" => {
                    try sys.tick.modify_until_done(_cctx, _rctx, 1000, g.CRL_struct, g.CRL, comptime .{
                        .CNF2 = _config.to_cnf(),
                        .MODE2 = _config.to_mode(),
                    }, null);
                },
                .@"3" => {
                    try sys.tick.modify_until_done(_cctx, _rctx, 1000, g.CRL_struct, g.CRL, comptime .{
                        .CNF3 = _config.to_cnf(),
                        .MODE3 = _config.to_mode(),
                    }, null);
                },
                .@"4" => {
                    try sys.tick.modify_until_done(_cctx, _rctx, 1000, g.CRL_struct, g.CRL, comptime .{
                        .CNF4 = _config.to_cnf(),
                        .MODE4 = _config.to_mode(),
                    }, null);
                },
                .@"5" => {
                    try sys.tick.modify_until_done(_cctx, _rctx, 1000, g.CRL_struct, g.CRL, comptime .{
                        .CNF5 = _config.to_cnf(),
                        .MODE5 = _config.to_mode(),
                    }, null);
                },
                .@"6" => {
                    try sys.tick.modify_until_done(_cctx, _rctx, 1000, g.CRL_struct, g.CRL, comptime .{
                        .CNF6 = _config.to_cnf(),
                        .MODE6 = _config.to_mode(),
                    }, null);
                },
                .@"7" => {
                    try sys.tick.modify_until_done(_cctx, _rctx, 1000, g.CRL_struct, g.CRL, comptime .{
                        .CNF7 = _config.to_cnf(),
                        .MODE7 = _config.to_mode(),
                    }, null);
                },
                .@"8" => {
                    try sys.tick.modify_until_done(_cctx, _rctx, 1000, g.CRH_struct, g.CRH, comptime .{
                        .CNF8 = _config.to_cnf(),
                        .MODE8 = _config.to_mode(),
                    }, null);
                },
                .@"9" => {
                    try sys.tick.modify_until_done(_cctx, _rctx, 1000, g.CRH_struct, g.CRH, comptime .{
                        .CNF9 = _config.to_cnf(),
                        .MODE9 = _config.to_mode(),
                    }, null);
                },
                .@"10" => {
                    try sys.tick.modify_until_done(_cctx, _rctx, 1000, g.CRH_struct, g.CRH, comptime .{
                        .CNF10 = _config.to_cnf(),
                        .MODE10 = _config.to_mode(),
                    }, null);
                },
                .@"11" => {
                    try sys.tick.modify_until_done(_cctx, _rctx, 1000, g.CRH_struct, g.CRH, comptime .{
                        .CNF11 = _config.to_cnf(),
                        .MODE11 = _config.to_mode(),
                    }, null);
                },
                .@"12" => {
                    try sys.tick.modify_until_done(_cctx, _rctx, 1000, g.CRH_struct, g.CRH, comptime .{
                        .CNF12 = _config.to_cnf(),
                        .MODE12 = _config.to_mode(),
                    }, null);
                },
                .@"13" => {
                    try sys.tick.modify_until_done(_cctx, _rctx, 1000, g.CRH_struct, g.CRH, comptime .{
                        .CNF13 = _config.to_cnf(),
                        .MODE13 = _config.to_mode(),
                    }, null);
                },
                .@"14" => {
                    try sys.tick.modify_until_done(_cctx, _rctx, 1000, g.CRH_struct, g.CRH, comptime .{
                        .CNF14 = _config.to_cnf(),
                        .MODE14 = _config.to_mode(),
                    }, null);
                },
                .@"15" => {
                    try sys.tick.modify_until_done(_cctx, _rctx, 1000, g.CRH_struct, g.CRH, comptime .{
                        .CNF15 = _config.to_cnf(),
                        .MODE15 = _config.to_mode(),
                    }, null);
                },
            }

            config_it(_cctx, _rctx, _config);
        }

        pub inline fn get(comptime _cctx: Ct_Context, _rctx: *Rt_Context) u1 {
            _ = _cctx;
            _ = _rctx;

            const g = reg_gpio();
            return @field(g.IDR, "IDR" ++ @tagName(_pos.no));
        }

        pub inline fn ct_set(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _value: u1) void {
            _ = _cctx;
            _ = _rctx;

            const g = reg_gpio();
            @field(g.BSRR, (if (_value == 0) "BR" else "BS") ++ @tagName(_pos.no)) = 0b1;
        }

        pub inline fn set(comptime _cctx: Ct_Context, _rctx: *Rt_Context, _value: u1) void {
            _ = _cctx;
            _ = _rctx;

            const g = reg_gpio();
            if (_value == 1) {
                @field(g.BSRR, "BS" ++ @tagName(_pos.no)) = 0b1;
            } else {
                @field(g.BSRR, "BR" ++ @tagName(_pos.no)) = 0b1;
            }
        }

        pub inline fn toggle(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            const g = reg_gpio();
            const v = get(_cctx, _rctx);
            if (v == 1) {
                @field(g.BSRR, "BR" ++ @tagName(_pos.no)) = 0b1;
            } else {
                @field(g.BSRR, "BS" ++ @tagName(_pos.no)) = 0b1;
            }
        }
    };
}

pub fn Gpio(comptime _port: Pos.Port) type {
    return gpio.Gpio(
        ctx.Ct_Context,
        ctx.Rt_Context,
        Pos,
        _Gpio,
        _port,
    );
}
pub fn Pin(comptime _pos: Pos) type {
    return gpio.Pin(
        ctx.Ct_Context,
        ctx.Rt_Context,
        Pin_Ct_Config,
        Pin_Rt_Config,
        Pos,
        _Pin,
        _pos,
    );
}
