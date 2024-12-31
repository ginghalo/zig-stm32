const reg = @import("reg.zig");
const gpio = @import("gpio.zig");
const sys = @import("sys.zig");
const it = @import("it.zig");
const ctx = @import("ctx.zig");

const interface = @import("../stm32.zig").interface;
const utils = interface.utils;
const pbr = interface.pbr;

pub var pvdg_it: ?*const fn () void = null;
pub var tamper_it: ?*const fn () void = null;
pub var rtc_its: Rtc_It = .{};
pub const Rtc_It = struct {
    rtc_it: ?*const fn () void = null,
    rtc_alarm_it: ?*const fn () void = null,
};

pub const pwr = Pwr();
pub const bkp = Bkp();
pub const rtc = Rtc();

pub const Error = error{ Time_Out, Unknown_Error };

pub const Pbr_Ct_Context = struct {
    pwr_cfg: ?Pwr_Ct_Config = null,
    bkp_cfg: ?Bkp_Ct_Config = null,
    rtc_cfg: ?Rtc_Ct_Config = null,
};
pub const Pbr_Rt_Context = struct {
    pwr_cfg: ?Pwr_Rt_Config = null,
    bkp_cfg: ?Bkp_Rt_Config = null,
    rtc_cfg: ?Rtc_Rt_Config = null,
};

pub const Pwr_Ct_Config = struct {
    lpds: Lpds = .normal, // working when pdds is stop
    pdds: Pdds = .stop,
    pls: Pls = .@"2.2V",

    ewup: Ewup = .disable,

    slponex: SlpOnEx = .now,
    slpdeep: SlpDeep = .disable,

    pvdg_it: ?Pvdg_it = null,

    pub const Lpds = enum(u1) { normal, lowp };
    pub const Pdds = enum(u1) { stop, stdby };
    pub const Pvde = enum(u1) { disable, enable };
    pub const Pls = enum(u3) { @"2.2V", @"2.3V", @"2.4V", @"2.5V", @"2.6V", @"2.7V", @"2.8V", @"2.9V" };

    pub const Pvdo = enum(u1) { higher, lower };
    pub const Ewup = enum(u1) { disable, enable };

    pub const SlpOnEx = enum(u1) { now, onex };
    pub const SlpDeep = enum(u1) { disable, enable };

    pub const Pvdg_it = struct {
        gf: *const fn (comptime _ctx: ctx.Ct_Context) fn () void,
        exti_cfg: it.Exti_Config = .{},
        nvic_cfg: it.Nvic_Config = .{ .pri = 0 },
    };
};
pub const Pwr_Rt_Config = struct {};

pub fn _Pwr(comptime _Ct_Context: type, comptime _Rt_Context: type) type {
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;
        pub inline fn reg_pwr() type {
            return reg.PWR;
        }

        inline fn ape_enbale() void {
            reg.RCC.APB1ENR.PWREN = 0b1;
            _ = reg.RCC.APB1ENR.PWREN;
        }
        inline fn ape_disbale() void {
            reg.RCC.APB1ENR.PWREN = 0;
            _ = reg.RCC.APB1ENR.PWREN;
        }

        inline fn gpio_enable(comptime _cctx: Ct_Context) void {
            if (_cctx.pbr.pwr_cfg.?.ewup == .enable) gpio.A.enable();
        }

        pub fn enable(comptime _cctx: Ct_Context, _: *Rt_Context) void {
            ape_enbale();
            gpio_enable(_cctx);
        }
        pub fn disable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;
            ape_disbale();
        }

        pub inline fn get_ct_cfg(comptime _cctx: Ct_Context) Pwr_Ct_Config {
            return _cctx.pbr.pwr_cfg.?;
        }
        pub inline fn get_rt_cfg(_rctx: *Rt_Context) ?Pwr_Rt_Config {
            return _rctx.pbr.pwr_cfg;
        }

        pub inline fn use(_cctx: *_Ct_Context) void {
            const cfg = comptime get_ct_cfg(_cctx.*);
            if (cfg.ewup == .enable) gpio.A.pin(.@"0").use(_cctx, .{ .Input = .{ .mode = .PD } });
        }
        pub inline fn unuse(_cctx: *_Ct_Context) void {
            const cfg = comptime get_ct_cfg(_cctx.*);
            if (cfg.ewup == .enable) gpio.A.pin(.@"0").unuse();
        }

        pub fn clear_it_flag(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;
            const p = reg_pwr();
            _ = utils.modify(p.CR_struct, p.CR, comptime .{
                .CSBF = 0b1,
                .CWUF = 0b1,
            });
        }
        pub fn set_it_enable_bit(comptime _cctx: Ct_Context, _: *Rt_Context) void {
            const cfg = comptime get_ct_cfg(_cctx);
            const p = reg_pwr();
            if (cfg.pvdg_it) |_| {
                p.CR.PVDE = 0b1;
            }
        }
        pub fn clear_it_enable_bit(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;
            const p = reg_pwr();
            p.CR.PVDE = 0;
        }

        // EXTI Line 16
        inline fn config_it(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            const cfg = comptime get_ct_cfg(_cctx);
            if (cfg.pvdg_it) |pi| {
                const nvic = it.Nvic(.{ .ext = reg.Interrupts.PVD });
                const exti = it.Exti(.@"16");
                pvdg_it = pi.gf(_cctx);
                nvic.set_priority(_cctx, _rctx, pi.nvic_cfg);
                nvic.enable(_cctx, _rctx);
                exti.enable(_cctx, _rctx, pi.exti_cfg);
            }
        }
        pub fn config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            const cfg = comptime get_ct_cfg(_cctx);
            const p = reg_pwr();
            enable(_cctx, _rctx);

            _ = utils.modify(p.CR_struct, p.CR, comptime .{
                .LPDS = @intFromEnum(cfg.lpds),
                .PDDS = @intFromEnum(cfg.pdds),
                .PVDE = 0,
                .PLS = @intFromEnum(cfg.pls),
            });

            _ = utils.modify(p.CSR_struct, p.CSR, comptime .{
                .EWUP = @intFromEnum(cfg.ewup),
            });

            _ = utils.modify(reg.SCB.SCR_struct, reg.SCB.SCR, comptime .{
                .SLEEPONEXIT = @intFromEnum(cfg.slponex),
                .SLEEPDEEP = @intFromEnum(cfg.slpdeep),
            });

            // Set by hardware if (cfg.ewup == .enable) try gpio.A.pin(.@"0").config(_cctx,_rctx, .{ .Input = .{ .mode = .PD } });

            config_it(_cctx, _rctx);
        }

        /// Based on tablet 8-12
        inline fn preprocess_before_wait(comptime _cctx: Ct_Context, _: *Rt_Context) void {
            const p = reg_pwr();
            const cfg = comptime get_ct_cfg(_cctx);

            switch (cfg.slpdeep) {
                .disable => {}, // nothing when being in sleep mode
                .enable => switch (cfg.pdds) { // stop or standby mode
                    .stdby => p.CR.CSBF = 0b1,
                    .stop => {
                        reg.EXTI.PR.* = @bitCast(@as(u32, 0)); // Clear all request bit of EXTI_PR
                        rtc.reg_rtc().CRL.ALRF = 0; // Clear bit of alarming from RTC
                    },
                },
            }
        }

        pub inline fn it_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            set_it_enable_bit(_cctx, _rctx);
        }
        pub inline fn it_stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            clear_it_enable_bit(_cctx, _rctx);
        }

        pub inline fn wfi(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            preprocess_before_wait(_cctx, _rctx);
            asm volatile ("WFI");
        }
        pub inline fn wfe(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            preprocess_before_wait(_cctx, _rctx);
            asm volatile ("WFE");
        }
    };
}

pub const Bkp_Ct_Config = struct {
    tpe: Tpe = .disable,
    tpal: Tpal = .high, // working when tpe is enable

    bkp_it: ?Bkp_it = null,

    pub const Tpe = enum(u1) { disable, enable };
    pub const Tpal = enum(u1) { high, low };

    pub const Bkp_it = struct {
        gf: *const fn (comptime _ctx: ctx.Ct_Context) fn () void,
        nvic_cfg: it.Nvic_Config = .{ .pri = 0xF },
    };
};
pub const Bkp_Rt_Config = struct {};

pub const Bkp_No = enum { @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10" };

pub fn _Bkp(comptime _Ct_Context: type, comptime _Rt_Context: type) type {
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;
        pub inline fn reg_bkp() type {
            return reg.BKP;
        }

        inline fn write_enable() void {
            pwr.reg_pwr().CR.DBP = 0b1;
        }
        inline fn ape_enable() void {
            reg.RCC.APB1ENR.BKPEN = 0b1;
        }
        inline fn ape_disable() void {
            reg.RCC.APB1ENR.BKPEN = 0;
        }
        inline fn gpio_enable(comptime _cctx: Ct_Context) void {
            const cfg: Bkp_Ct_Config = _cctx.pbr.bkp_cfg.?;

            if (cfg.tpe == .enable) gpio.C.enable(); // configrated by hardware,so it just a notice that it is used
        }
        pub fn enable(comptime _cctx: Ct_Context, _: *Rt_Context) void {
            write_enable();
            ape_enable();
            gpio_enable(_cctx);
        }
        pub fn disable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;

            ape_disable();
        }

        pub inline fn get_ct_cfg(comptime _cctx: Ct_Context) Bkp_Ct_Config {
            return _cctx.pbr.bkp_cfg.?;
        }
        pub inline fn get_rt_cfg(_rctx: *Rt_Context) ?Bkp_Rt_Config {
            return _rctx.pbr.bkp_cfg;
        }

        pub inline fn use(_cctx: *_Ct_Context) void {
            const cfg = comptime get_ct_cfg(_cctx.*);

            if (cfg.tpe == .enable) gpio.C.pin(.@"13").use(.{ .Output = .{} }); // using it with cco is none
        }
        pub inline fn unuse(_cctx: *_Ct_Context) void {
            const cfg = comptime get_ct_cfg(_cctx.*);

            if (cfg.tpe == .enable) gpio.C.pin(.@"13").unuse();
            if (cfg.cco == .div64) gpio.C.pin(.@"13").unuse();
            if (cfg.asoe == .enable) gpio.C.pin(.@"13").unuse();
        }

        pub fn clear_it_flag(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;
            const b = reg_bkp();
            _ = utils.modify(b.CSR_struct, b.CSR, comptime .{
                .CTI = 0b1,
                .CTE = 0b1,
            });
        }
        pub fn set_it_enable_bit(comptime _cctx: Ct_Context, _: *Rt_Context) void {
            const cfg = comptime get_ct_cfg(_cctx);
            const b = reg_bkp();
            if (cfg.bkp_it) |_| {
                if (cfg.tpe == .disable) @compileError("Enable the tamper interrupt without enabling TPE!");
                b.CSR.TPIE = 0b1;
            }
        }
        pub fn clear_it_enable_bit(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;
            const b = reg_bkp();
            b.CSR.TPIE = 0;
        }

        inline fn config_it(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            const cfg = comptime get_ct_cfg(_cctx);
            const rtc_cfg = comptime rtc.get_ct_cfg(_cctx);

            set_it_enable_bit(_cctx, _rctx);
            if (cfg.bkp_it) |bi| {
                if (rtc_cfg.asoe == .enable) @compileError("Enable the tamper interrupt but enabling ASOE!");
                if (rtc_cfg.cco == .enable) @compileError("Enable the tamper interrupt but enabling CCO!");

                const nvic = it.Nvic(.{ .ext = .TAMPER });

                tamper_it = bi.gf(_cctx);

                nvic.set_priority(_cctx, _rctx, bi.nvic_cfg);
                nvic.enable(_cctx, _rctx);
            }
        }
        pub fn config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            const cfg = comptime get_ct_cfg(_cctx);
            const rtc_cfg = comptime rtc.get_ct_cfg(_cctx);
            const b = reg_bkp();

            enable(_cctx, _rctx);

            b.CSR.TPIE = 0;

            if (cfg.tpe == .enable and (rtc_cfg.cco == .div64 or rtc_cfg.asoe)) @compileError("Confliction between TPE and CCO or ASOE!");
            b.CR.TPE = 0; // avoid fake tamper event
            b.CR.TPAL = comptime @intFromEnum(cfg.tpal);
            b.CR.TPE = comptime @intFromEnum(cfg.tpe);

            config_it(_cctx, _rctx);
        }

        fn t2u(comptime _T: type, _value: _T) u16 {
            if (@bitSizeOf(_T) > 16) @compileError("Bitsize of type is more than 16!");

            return utils.type2uint(_value);
        }

        pub fn set(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _T: type, _no: Bkp_No, _value: _T) void {
            _ = _cctx;
            _ = _rctx;

            const b = reg_bkp();
            switch (_no) {
                .@"1" => b.DR1.D1 = t2u(_T, _value),
                .@"2" => b.DR2.D2 = t2u(_T, _value),
                .@"3" => b.DR3.D3 = t2u(_T, _value),
                .@"4" => b.DR4.D4 = t2u(_T, _value),
                .@"5" => b.DR5.D5 = t2u(_T, _value),
                .@"6" => b.DR6.D6 = t2u(_T, _value),
                .@"7" => b.DR7.D7 = t2u(_T, _value),
                .@"8" => b.DR8.D8 = t2u(_T, _value),
                .@"9" => b.DR9.D9 = t2u(_T, _value),
                .@"10" => b.DR10.D10 = t2u(_T, _value),
            }
        }
        pub fn cmpt_set(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _T: type, comptime _no: Bkp_No, _value: _T) void {
            _ = _cctx;
            _ = _rctx;

            const b = reg_bkp();
            switch (_no) {
                .@"1" => b.DR1.D1 = t2u(_T, _value),
                .@"2" => b.DR2.D2 = t2u(_T, _value),
                .@"3" => b.DR3.D3 = t2u(_T, _value),
                .@"4" => b.DR4.D4 = t2u(_T, _value),
                .@"5" => b.DR5.D5 = t2u(_T, _value),
                .@"6" => b.DR6.D6 = t2u(_T, _value),
                .@"7" => b.DR7.D7 = t2u(_T, _value),
                .@"8" => b.DR8.D8 = t2u(_T, _value),
                .@"9" => b.DR9.D9 = t2u(_T, _value),
                .@"10" => b.DR10.D10 = t2u(_T, _value),
            }
        }

        pub fn get(comptime _cctx: Ct_Context, _rctx: *Rt_Context, _no: Bkp_No) u16 {
            _ = _cctx;
            _ = _rctx;

            const b = reg_bkp();
            return switch (_no) {
                .@"1" => b.DR1.D1,
                .@"2" => b.DR2.D2,
                .@"3" => b.DR3.D3,
                .@"4" => b.DR4.D4,
                .@"5" => b.DR5.D5,
                .@"6" => b.DR6.D6,
                .@"7" => b.DR7.D7,
                .@"8" => b.DR8.D8,
                .@"9" => b.DR9.D9,
                .@"10" => b.DR10.D10,
            };
        }
        pub fn cmpt_get(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _no: Bkp_No) u16 {
            _ = _cctx;
            _ = _rctx;

            const b = reg_bkp();
            return switch (_no) {
                .@"1" => b.DR1.D1,
                .@"2" => b.DR2.D2,
                .@"3" => b.DR3.D3,
                .@"4" => b.DR4.D4,
                .@"5" => b.DR5.D5,
                .@"6" => b.DR6.D6,
                .@"7" => b.DR7.D7,
                .@"8" => b.DR8.D8,
                .@"9" => b.DR9.D9,
                .@"10" => b.DR10.D10,
            };
        }
    };
}

pub const Rtc_Ct_Config = struct {
    prl: u20 = 0x08000,
    cnt: ?u32 = null,
    alr: u32 = 0xFFFFFFFF,

    cco: Cco = .none,
    asoe: Asoe = .disable,
    asos: Asos = .rtc_alarm,

    sel: Sel = .none,
    cal: u7 = 0,

    rtc_its: ?Rtc_its = null,

    pub const Cco = enum(u1) { none, div64 };
    pub const Asoe = enum(u1) { disable, enable };
    pub const Asos = enum(u1) { rtc_alarm, sec };

    pub const Sel = enum(u2) { none, lse, lsi, hse };

    pub const Rtc_its = struct {
        rtc_it: ?Rtc_it = null,
        rtc_alarm_it: ?Rtc_alarm_it = null,

        secie: Secie = .disable,
        alrie: Alrie = .disable,
        owie: Owie = .disable,

        pub const Rtc_it = struct {
            gf: *const fn (comptime _ctx: ctx.Ct_Context) fn () void,
            nvic_cfg: it.Nvic_Config = .{ .pri = 0xF },
        };
        pub const Rtc_alarm_it = struct {
            gf: *const fn (comptime _ctx: ctx.Ct_Context) fn () void,
            nvic_cfg: it.Nvic_Config = .{ .pri = 0xF },
            exti_cfg: it.Exti_Config = .{ .rtsr = .enable },
        };

        pub const Secie = enum(u1) { disable, enable };
        pub const Alrie = enum(u1) { disable, enable };
        pub const Owie = enum(u1) { disable, enable };
    };
};
pub const Rtc_Rt_Config = struct {};

fn _Rtc(comptime _Ct_Context: type, comptime _Rt_Context: type) type {
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;
        pub inline fn reg_rtc() type {
            return reg.RTC;
        }

        inline fn write_enable() void {
            pwr.reg_pwr().CR.DBP = 0b1;
        }
        inline fn bdcr_enable() void {
            reg.RCC.BDCR.RTCEN = 0b1;
        }
        inline fn bdcr_disable() void {
            reg.RCC.BDCR.RTCEN = 0;
        }
        inline fn gpio_enable(comptime _cctx: Ct_Context) void {
            const cfg = comptime get_ct_cfg(_cctx);
            if (cfg.cco == .div64) gpio.C.enable(); // configrated by hardware,so it just a notice that it is used
            if (cfg.asoe == .enable) gpio.C.enable(); // configrated by hardware,so it just a notice that it is used
        }
        pub fn enable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            pwr.enable(_cctx, _rctx);
            write_enable();
            bkp.enable(_cctx, _rctx);
            bdcr_enable();
            gpio_enable(_cctx);
        }
        pub fn disable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;
            bdcr_disable();
        }

        pub inline fn get_ct_cfg(comptime _cctx: Ct_Context) Rtc_Ct_Config {
            return _cctx.pbr.rtc_cfg.?;
        }
        pub inline fn get_rt_cfg(_rctx: *Rt_Context) ?Rtc_Rt_Config {
            return _rctx.pbr.rtc_cfg;
        }

        pub fn use(_cctx: *_Ct_Context) void {
            const cfg = comptime get_ct_cfg(_cctx.*);
            if (cfg.cco == .div64) gpio.C.pin(.@"13").use(_cctx, .{ .Output = .{} }); // using it with tpe is disable
            if (cfg.asoe == .enable) gpio.C.pin(.@"13").use(_cctx, .{ .Output = .{} }); // using it with tpe is disable
        }
        pub fn unuse(_cctx: *_Ct_Context) void {
            const cfg = comptime get_ct_cfg(_cctx.*);
            if (cfg.cco == .div64) gpio.C.pin(.@"13").unuse(); // using it with tpe is disable
            if (cfg.asoe == .enable) gpio.C.pin(.@"13").unuse(); // using it with tpe is disable
        }

        pub fn clear_it_flag(comptime _: _Ct_Context, _: *_Rt_Context) void {
            const r = reg_rtc();

            for (0..5) |_| if (r.CRL.RTOFF == 0b1) break;
            _ = utils.modify(r.CRL_struct, r.CRL, comptime .{
                .OWF = 0,
                .ALRF = 0,
                .SECF = 0,
            });
        }
        pub fn set_it_enable_bit(comptime _cctx: Ct_Context, _: *Rt_Context) void {
            const cfg = comptime get_ct_cfg(_cctx);
            const r = reg_rtc();

            for (0..5) |_| if (r.CRL.RTOFF == 0b1) break;
            if (cfg.rtc_its) |ris| {
                _ = utils.modify(r.CRH_struct, r.CRH, comptime .{
                    .SECIE = @intFromEnum(ris.secie),
                    .ALRIE = @intFromEnum(ris.alrie),
                    .OWIE = @intFromEnum(ris.owie),
                });
            }
        }
        pub fn clear_it_enable_bit(comptime _: _Ct_Context, _: *_Rt_Context) void {
            const r = reg_rtc();

            for (0..5) |_| if (r.CRL.RTOFF == 0b1) break;
            _ = utils.modify(r.CRH_struct, r.CRH, comptime .{
                .SECIE = 0,
                .ALRIE = 0,
                .OWIE = 0,
            });
        }

        fn wait_CRL(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _name: []const u8, comptime _value: u1) !void {
            const r = reg_rtc();

            sys.tick.start(_cctx, _rctx, 10_000);
            defer sys.tick.stop(_cctx, _rctx);

            while (@field(r.CRL, _name) != _value) {
                if (sys.tick.finished(_cctx, _rctx) == true) {
                    return Error.Time_Out;
                }
            }
        }

        inline fn wait_RSF(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            try wait_CRL(_cctx, _rctx, "RSF", 0b1);
        }
        inline fn wait_RTOFF(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            try wait_CRL(_cctx, _rctx, "RTOFF", 0b1);
        }

        inline fn config_it(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            const cfg = comptime get_ct_cfg(_cctx);

            set_it_enable_bit(_cctx, _rctx); // TODO it_start
            if (cfg.rtc_its) |ris| {
                if (ris.rtc_it) |ri| {
                    const nvic = it.Nvic(.{ .ext = .RTC });

                    rtc_its.rtc_it = ri.gf(_cctx);
                    nvic.set_priority(_cctx, _rctx, ri.nvic_cfg);
                    nvic.enable(_cctx, _rctx);
                }
                if (ris.rtc_alarm_it) |rai| {
                    const nvic = it.Nvic(.{ .ext = .RTCAlarm });
                    const exti = it.Exti(.@"17");

                    if (ris.rtc_it) |ri| {
                        if (ri.nvic_cfg.pri <= rai.nvic_cfg.pri) @compileError("Interrupt of RTC Alarming Must have higher priority than global RTC interrupt!");
                    }
                    if (cfg.alrie == .disable) @compileError("Must be enable in ALRIE");
                    if (rai.exti_cfg.rtsr == .disable or rai.exti_cfg.ftsr == .enable) @compileError("Must be triggered by rising egde!");

                    rtc_its.rtc_alarm_it = rai.gf(_cctx);
                    nvic.set_priority(_cctx, _rctx, rai.nvic_cfg);
                    exti.enable(_cctx, _rctx, rai.exti_cfg);
                    nvic.enable(_cctx, _rctx);
                }
            }
        }
        pub inline fn config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            const cfg = comptime get_ct_cfg(_cctx);
            const r = reg_rtc();
            const b = bkp.reg_bkp();

            enable(_cctx, _rctx);

            switch (cfg.sel) {
                .none => @compileError("I don't know why you want to use the RTC with selection of none clock."),
                .lsi => if (_cctx.sys.clock_cfg.?.lsi == .disable) @compileError("Not activate the lsi clock!"),
                .lse => if (_cctx.sys.clock_cfg.?.lse == .disable) @compileError("Not activate the lse clock!"),
                .hse => if (_cctx.sys.clock_cfg.?.hse == .disable) @compileError("Not activate the hse clock!"),
            }

            reg.RCC.BDCR.RTCSEL = comptime @intFromEnum(cfg.sel);

            r.CRL.RSF = 0;
            try wait_RSF(_cctx, _rctx);

            try wait_RTOFF(_cctx, _rctx);
            r.CRL.CNF = 0b1;
            if (cfg.cco == .div64 and cfg.asoe == .enable) @compileError("Confliction between CCO and ASOE!");
            _ = utils.modify(b.RTCCR_struct, b.RTCCR, comptime .{
                .CCO = @intFromEnum(cfg.cco),
                .ASOE = @intFromEnum(cfg.asoe),
                .ASOS = @intFromEnum(cfg.asos),
                .CAL = cfg.cal,
            });
            clear_it_enable_bit(_cctx, _rctx);
            clear_it_flag(_cctx, _rctx);

            try bkp.config(_cctx, _rctx);

            r.PRLH.PRLH = @truncate(cfg.prl >> 16);
            r.PRLL.PRLL = @truncate(cfg.prl);

            if (cfg.cnt) |cnt| {
                r.CNTH.CNTH = @truncate(cnt >> 16);
                r.CNTL.CNTL = @truncate(cnt);
            }

            r.ALRH.ALRH = @truncate(cfg.alr >> 16);
            r.ALRL.ALRL = @truncate(cfg.alr);

            r.CRL.CNF = 0;
            try wait_RTOFF(_cctx, _rctx);

            config_it(_cctx, _rctx);
        }

        pub inline fn get_freq(comptime _cctx: Ct_Context, _: *Rt_Context) u32 {
            return comptime switch (_cctx.pbr.rtc_cfg.?.sel) {
                .none => @compileError("None clock selection."),
                .hse => _cctx.sys.clock.?.clock_cfg.?.hse.enable.speed / 128,
                .lse => _cctx.sys.clock.?.clock_cfg.?.lse.enable.speed,
                .lse => _cctx.sys.clock.?.clock_cfg.?.lsi.enable.speed,
            };
        }

        pub fn set(comptime _cctx: Ct_Context, _: *Rt_Context) void {
            const cfg = comptime get_ct_cfg(_cctx);
            if (cfg.cnt) |cnt| {
                const r = reg_rtc();
                for (0..5) |_| if (r.CRL.RTOFF == 0b1) break;
                r.CRL.CNF = 0b1;

                r.CNTH.CNTH = @truncate(cnt >> 16);
                r.CNTL.CNTL = @truncate(cnt);

                r.CRL.CNF = 0;
                for (0..5) |_| if (r.CRL.RTOFF == 0b1) break;
            }
        }

        pub fn get(comptime _cctx: Ct_Context, _rctx: *Rt_Context) u32 {
            _ = _cctx;
            _ = _rctx;

            const r = reg_rtc();
            const h1: u32 = r.CNTH.CNTH;
            const l: u32 = r.CNTL.CNTL;
            const h2: u32 = r.CNTH.CNTH;

            return if (h1 == h2) h1 << 16 | l else h2 << 16 | @as(u32, r.CNTL.CNTL);
        }

        pub fn delay(comptime _cctx: Ct_Context, _rctx: *Rt_Context, _cnt: u32) void {
            const now = get(_cctx, _rctx);
            while (now + _cnt < get(_cctx, _rctx)) {}
        }
    };
}

pub fn Pwr() type {
    return pbr.Pwr(
        ctx.Ct_Context,
        ctx.Rt_Context,
        Pwr_Ct_Config,
        Pwr_Rt_Config,
        Error,
        _Pwr,
    );
}
pub fn Bkp() type {
    return pbr.Bkp(
        ctx.Ct_Context,
        ctx.Rt_Context,
        Bkp_Ct_Config,
        Bkp_Rt_Config,
        Bkp_No,
        Error,
        _Bkp,
    );
}
pub fn Rtc() type {
    return pbr.Rtc(
        ctx.Ct_Context,
        ctx.Rt_Context,
        Rtc_Ct_Config,
        Rtc_Rt_Config,
        Error,
        _Rtc,
    );
}
