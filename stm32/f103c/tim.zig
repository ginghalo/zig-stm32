const reg = @import("reg.zig");
const gpio = @import("gpio.zig");
const sys = @import("sys.zig");
const ctx = @import("ctx.zig");
const it = @import("it.zig");
const dma = @import("dma.zig");

const std = @import("std");

const interface = @import("../stm32.zig").interface;
const utils = interface.utils;
const tim = interface.tim;

pub var tim_its: Tim_its = .{};
pub const Tim_its = struct {
    // advanced
    tim1_cc: ?*const fn () void = null,
    tim1_up: ?*const fn () void = null,
    tim1_brk: ?*const fn () void = null,
    tim1_trg_com: ?*const fn () void = null,
    // general
    tim2: ?*const fn () void = null,
    tim3: ?*const fn () void = null,
    tim4: ?*const fn () void = null,
};

pub const @"1" = Tim(.@"1");
pub const @"2" = Tim(.@"2");
pub const @"3" = Tim(.@"3");
pub const @"4" = Tim(.@"4");

pub const NO_NUMS = @typeInfo(Pos.No).Enum.fields.len;
pub const CH_NUMS = @typeInfo(Pos.Ch).Enum.fields.len;
pub const Pos = struct {
    no: No,
    ch: Channel,
    pub const No = enum {
        @"1",
        @"2",
        @"3",
        @"4",
        pub const Level = enum {
            basic,
            general,
            advanced,
        };
        pub inline fn no2level(comptime _no: No) Level {
            return switch (_no) {
                .@"1" => .advanced,
                .@"2", .@"3", .@"4" => .general,
            };
        }
    };
    pub const Channel = enum { etr, @"1", @"2", @"3", @"4" };
};

pub const Tim_Ct_Context: type = CONTEXT: {
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
                    .type = ?Tim_Ct_Config,
                    .default_value = @ptrCast(&@as(?Tim_Ct_Config, null)),
                    .is_comptime = false,
                    .alignment = @alignOf(?Tim_Ct_Config),
                };
            }
            break :FIELDS &fields;
        },
    } });
};
pub const Tim_Rt_Context: type = CONTEXT: {
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
                    .type = ?Tim_Rt_Config,
                    .default_value = @ptrCast(&@as(?Tim_Rt_Config, null)),
                    .is_comptime = false,
                    .alignment = @alignOf(?Tim_Rt_Config),
                };
            }
            break :FIELDS &fields;
        },
    } });
};

pub const Tim_Ct_Config = struct {
    dir: Dir = .up, // working when cms is edge
    cms: Cms = .edge,
    ckd: Ckd = .div1,

    arre: Arre = .disable,
    psc: u16 = 0,
    arr: u16 = 0,

    src: Src = .{ .internal = {} },

    mms: Mms = .reset,

    chs: []Ch_Ct_Config = &.{},

    tim_it: ?Tim_it = null,
    tim_dma: ?Tim_Dma = null,

    // Configurations below is only working in advanced timer
    rep: u8 = 0,
    msm: Msm = .disable,

    pub const Dir = enum(u1) { up, down };
    pub const Cms = enum(u2) { edge, cen1, cen2, cen3 };
    pub const Ckd = enum(u2) { div1, div2, div4 };

    pub const Arre = enum(u1) { disable, enable };

    pub const Src = union(enum) {
        internal: void,
        extern1: TS,
        extern2: void,
        pub const TS = enum(u3) { itr0, itr1, itr2, itr3, ti1f_ed, ti1fp1, ti2fp2, etrf };
    };
    pub const Mms = enum(u3) { reset, enable, update, oc1, oc1ref, oc2ref, oc3ref, oc4ref };

    pub const Tim_it = struct {
        it: It,
        uie: Uie = .disable,
        tie: Tie = .disable,
        bie: Bie = .disable, // working when tim_it  == .advanced
        comie: Comie = .disable, // working when tim_it  == .advanced
        pub const It = union(enum) {
            advanced: Advanced_it,
            general: General_it,
            pub const Advanced_it = struct {
                cc: ?General_it = null,
                up: ?General_it = null,
                brk: ?General_it = null,
                trg_com: ?General_it = null,
            };
            pub const General_it = struct {
                gf: *const fn (comptime _ctx: ctx.Ct_Context) fn () void,
                nvic_cfg: it.Nvic_Config = .{ .pri = 0xF },
            };
        };
    };
    pub const Tim_Dma = struct {
        cfg: Dma_Ch_Ct_Config,

        tde: Tde = .disable,
        ude: Ude = .disable,
        bde: Bde = .disable, // working when tim  == .advanced
        comde: Comde = .disable, // working when tim  == .advanced

        dbl: Dbl = .@"1half-word",
        dba: Dba = .cr1,
        pub const Dma_Ch_Ct_Config = union(enum) {
            tx_cfg: Cfg,
            rx_cfg: Cfg,
            const Cfg = struct {
                it: dma.Ch_Ct_Config.Ch_It,
                pl: dma.Ch_Ct_Config.Pl = .low,
            };
        };
    };

    pub const Uie = enum(u1) { disable, enable };
    pub const Tie = enum(u1) { disable, enable };

    pub const Ude = enum(u1) { disable, enable };
    pub const Tde = enum(u1) { disable, enable };

    pub const Msm = enum(u1) { disable, enable };
    pub const Comie = enum(u1) { disable, enable };
    pub const Bie = enum(u1) { disable, enable };

    pub const Comde = enum(u1) { disable, enable };
    pub const Bde = enum(u1) { disable, enable };

    pub const Dbl = enum(u5) {
        @"1half-word",
        @"2half-words",
        @"3half-words",
        @"4half-words",
        @"5half-word",
        @"6half-words",
        @"7half-words",
        @"8half-words",
        @"9half-word",
        @"10half-words",
        @"11half-words",
        @"12half-words",
        @"13half-word",
        @"14half-words",
        @"15half-words",
        @"16half-words",
        @"17half-word",
        @"18half-words",
    };
    pub const Dba = enum(u5) {
        cr1,
        cr2,
        smcr,
        dier,
        sr,
        egr,
        ccmr1,
        ccmr2,
        ccer,
        cnt,
        psc,
        arr,
        rcr,
        ccr1,
        ccr2,
        ccr3,
        ccr4,
        bdtr,
        dcr,
        dmar,
    };
};
pub const Tim_Rt_Config = struct {
    tim_dma: ?Tim_Dma = null,
    chs: []Ch_Rt_Config = &.{},
    pub const Tim_Dma = struct {
        cfg: Dma_Ch_Ct_Config,
        pub const Dma_Ch_Ct_Config = union(enum) {
            tx_cfg: Cfg,
            rx_cfg: Cfg,
            const Cfg = struct {
                ma: u32,
                ndt: u16,
                circ: dma.Ch_Rt_Config.Circ,
                minc: dma.Ch_Rt_Config.Minc,
            };
        };
    };
};
pub const Error = error{
    Tim_Time_Out,
};

/// Generic Timer
pub fn _Tim(comptime _Ct_Context: type, comptime _Rt_Context: type, comptime _no: Pos.No) type {
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;
        pub inline fn reg_tim() type {
            return switch (_no) {
                .@"1" => reg.TIM1,
                .@"2" => reg.TIM2,
                .@"3" => reg.TIM3,
                .@"4" => reg.TIM4,
            };
        }

        inline fn dma_ch_pos() dma.Pos {
            return switch (_no) {
                .@"1" => .{ .no = .@"1", .ch = .@"5" },
                .@"2" => .{ .no = .@"1", .ch = .@"2" },
                .@"3" => .{ .no = .@"1", .ch = .@"3" },
                .@"4" => .{ .no = .@"1", .ch = .@"7" },
            };
        }
        pub inline fn dma_ch() type {
            return dma.Ch(dma_ch_pos());
        }

        inline fn ape_enable() void {
            switch (_no) {
                .@"1" => reg.RCC.APB2ENR.TIM1EN = 0b1,
                .@"2" => reg.RCC.APB1ENR.TIM2EN = 0b1,
                .@"3" => reg.RCC.APB1ENR.TIM3EN = 0b1,
                .@"4" => reg.RCC.APB1ENR.TIM4EN = 0b1,
            }
        }
        inline fn ape_disable() void {
            switch (_no) {
                .@"1" => reg.RCC.APB2ENR.TIM1EN = 0,
                .@"2" => reg.RCC.APB1ENR.TIM2EN = 0,
                .@"3" => reg.RCC.APB1ENR.TIM3EN = 0,
                .@"4" => reg.RCC.APB1ENR.TIM4EN = 0,
            }
        }

        pub inline fn enable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;
            ape_enable();
        }
        pub inline fn disable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;
            ape_disable();
        }

        inline fn get_dma_ch_config(comptime _cctx: Ct_Context) ?dma.Ch_Ct_Config {
            const ct_cfg = comptime get_ct_cfg(_cctx);
            if (ct_cfg.tim_dma) |tim_dma| {
                return switch (tim_dma.cfg) {
                    .tx_cfg => |cfg| dma.Ch_Ct_Config{
                        .dir = .memory,
                        .ch = dma_ch_pos().ch,
                        .ch_it = cfg.it,
                        .pl = cfg.pl,
                    },
                    .rx_cfg => |cfg| dma.Ch_Ct_Config{
                        .dir = .peripheral,
                        .ch = dma_ch_pos().ch,
                        .ch_it = cfg.it,
                        .pl = cfg.pl,
                    },
                };
            }
            return null;
        }

        pub inline fn get_freq(comptime _cctx: Ct_Context, _: *Rt_Context) u32 {
            // return switch (_no) {
            //     .@"1" => sys.clock.get_freq(_cctx).pclk2,
            //     .@"2", .@"3", .@"4" => sys.clock.get_freq(_cctx).pclk1,
            // };
            return sys.clock.get_freq(_cctx).hclk;
        }

        pub inline fn get_ct_cfg(comptime _cctx: Ct_Context) Tim_Ct_Config {
            return @field(_cctx.tim, "cfg" ++ @tagName(_no)).?;
        }
        pub inline fn get_rt_cfg(_rctx: *Rt_Context) ?Tim_Rt_Config {
            return @field(_rctx.tim, "cfg" ++ @tagName(_no));
        }

        pub inline fn get_no() Pos.No {
            return _no;
        }

        pub inline fn channel(comptime _ch: Pos.Channel) type {
            return Ch(.{ .no = _no, .ch = _ch });
        }

        inline fn src_assert(_cctx: *_Ct_Context) void {
            const cfg: Tim_Ct_Config = comptime @field(_cctx.tim, "cfg" ++ @tagName(_no)).?;

            switch (comptime _no.no2level()) {
                .basic => {},
                .advanced, .general => {
                    switch (cfg.src) {
                        .internal => {},
                        .extern1 => |ex1| {
                            switch (ex1.ts) {
                                .itr0, .itr1, .itr2, .itr3 => {},
                                .ti1f_ed => TI1F_ED: {
                                    for (cfg.chs) |chc| if (chc.ch == .@"1" and chc.cfg == .ic) break :TI1F_ED;
                                    @compileError("Ti1f_ed does not exsit in chs for src using");
                                },
                                .ti1fp1 => TI1FP1: {
                                    for (cfg.chs) |chc| if (chc.ch == .@"1" and chc.cfg == .ic) break :TI1FP1;
                                    @compileError("Ti1fp1 does not exsit in chs for src using");
                                },
                                .ti2fp2 => TI2FP2: {
                                    for (cfg.chs) |chc| if (chc.ch == .@"2" and chc.cfg == .ic) break :TI2FP2;
                                    @compileError("Ti2fp2 does not exsit in chs for src using");
                                },
                                .etrf => ETRF: {
                                    for (cfg.chs) |chc| if (chc.ch == .etr and chc.cfg == .ic) break :ETRF;
                                    @compileError("Etrf does not exsit in chs for src using");
                                },
                            }
                        },
                        .extern2 => |_| ETRF: {
                            for (cfg.chs) |chc| if (chc.ch == .etr and chc.cfg == .ic) break :ETRF;
                            @compileError("Etrf does not exsit in chs for src using");
                        },
                    }
                },
            }
        }

        pub inline fn use(_cctx: *_Ct_Context) void {
            src_assert(_cctx);

            if (comptime get_dma_ch_config(_cctx.*)) |cfg| dma_ch().use(_cctx, cfg);

            const tim_cfg = comptime get_ct_cfg(_cctx.*);
            for (tim_cfg.chs) |chc| channel(chc.ch).use(_cctx);
        }
        pub inline fn unuse(_cctx: *_Ct_Context) void {
            src_assert(_cctx);

            if (comptime get_dma_ch_config(_cctx.*)) |_| dma_ch().unuse(_cctx);

            const tim_cfg = comptime get_ct_cfg(_cctx.*);
            for (tim_cfg.chs) |chc| channel(chc.ch).unuse(_cctx);
        }

        pub fn clear_it_flag(comptime _cctx: Ct_Context, _: *Rt_Context) void {
            const cfg = comptime get_ct_cfg(_cctx);
            const t = reg_tim();
            if (cfg.tim_it) |ti| {
                switch (ti.it) {
                    .general => {
                        if (comptime _no.no2level() == .advanced) @compileError("Wrong type of tim_it!");
                        _ = utils.modify(t.SR_struct, t.SR, comptime .{
                            .UIF = 0,
                            .TIF = 0,
                        });
                    },
                    .advanced => {
                        if (comptime _no.no2level() == .general) @compileError("Wrong type of tim_it!");
                        _ = utils.modify(t.SR_struct, t.SR, comptime .{
                            .UIF = 0,
                            .TIF = 0,
                            .COMIF = 0,
                            .BIF = 0,
                        });
                    },
                }
            }
            for (0..5) |_| asm volatile ("nop"); //without it the interrupt may trigger again
        }
        pub fn set_it_enable_bit(comptime _cctx: Ct_Context, _: *Rt_Context) void {
            const cfg = comptime get_ct_cfg(_cctx);
            const t = reg_tim();
            if (cfg.tim_it) |ti| {
                switch (ti.it) {
                    .general => {
                        if (comptime _no.no2level() == .advanced) @compileError("Wrong type of tim_it!");
                        _ = utils.modify(t.DIER_struct, t.DIER, comptime .{
                            .UIE = @intFromEnum(ti.uie),
                            .TIE = @intFromEnum(ti.tie),
                        });
                    },
                    .advanced => {
                        if (comptime _no.no2level() == .general) @compileError("Wrong type of tim_it!");
                        _ = utils.modify(t.DIER_struct, t.DIER, comptime .{
                            .UIE = @intFromEnum(ti.uie),
                            .TIE = @intFromEnum(ti.tie),
                            .COMIE = @intFromEnum(ti.comie),
                            .BIE = @intFromEnum(ti.bie),
                        });
                    },
                }
            }
        }
        pub fn clear_it_enable_bit(comptime _cctx: Ct_Context, _: *Rt_Context) void {
            const cfg = comptime get_ct_cfg(_cctx);
            const t = reg_tim();
            if (cfg.tim_it) |ti| {
                switch (ti.it) {
                    .general => {
                        if (comptime _no.no2level() == .advanced) @compileError("Wrong type of tim_it!");
                        _ = utils.modify(t.DIER_struct, t.DIER, comptime .{
                            .UIE = 0,
                            .TIE = 0,
                        });
                    },
                    .advanced => {
                        if (comptime _no.no2level() == .general) @compileError("Wrong type of tim_it!");
                        _ = utils.modify(t.DIER_struct, t.DIER, comptime .{
                            .UIE = 0,
                            .TIE = 0,
                            .COMIE = 0,
                            .BIE = 0,
                        });
                    },
                }
            }
        }

        inline fn config_it(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            const cfg = comptime get_ct_cfg(_cctx);

            if (cfg.tim_it) |ti| {
                if (comptime _no.no2level() == .advanced) {
                    const nvic_cc = it.Nvic(.{ .ext = @field(reg.Interrupts, "TIM" ++ @tagName(_no) ++ "_CC") });
                    const nvic_up = it.Nvic(.{ .ext = @field(reg.Interrupts, "TIM" ++ @tagName(_no) ++ "_UP") });
                    const nvic_brk = it.Nvic(.{ .ext = @field(reg.Interrupts, "TIM" ++ @tagName(_no) ++ "_BRK") });
                    const nvic_trg_com = it.Nvic(.{ .ext = @field(reg.Interrupts, "TIM" ++ @tagName(_no) ++ "_TRG_COM") });
                    if (ti.advanced.cc) |cc| {
                        @field(tim_its, "tim" ++ @tagName(_no) ++ "_cc") = cc.gf(_cctx);
                        nvic_cc.set_priority(cc.nvic_cfg);
                        nvic_cc.enable();
                    }
                    if (ti.advanced.up) |up| {
                        @field(tim_its, "tim" ++ @tagName(_no) ++ "_up") = up.gf(_cctx);
                        nvic_up.set_priority(up.nvic_cfg);
                        nvic_up.enable();
                    }
                    if (ti.advanced.brk) |brk| {
                        @field(tim_its, "tim" ++ @tagName(_no) ++ "_brk") = brk.gf(_cctx);
                        nvic_brk.set_priority(brk.nvic_cfg);
                        nvic_brk.enable();
                    }
                    if (ti.advanced.trg_com) |trg_com| {
                        @field(tim_its, "tim" ++ @tagName(_no) ++ "_trg_com") = trg_com.gf(_cctx);
                        nvic_trg_com.set_priority(trg_com.nvic_cfg);
                        nvic_trg_com.enable();
                    }
                } else {
                    const nvic = it.Nvic(.{ .ext = @field(reg.Interrupts, "TIM" ++ @tagName(_no)) });
                    @field(tim_its, "tim" ++ @tagName(_no)) = ti.it.general.gf(_cctx);
                    nvic.set_priority(_cctx, _rctx, ti.it.general.nvic_cfg);
                    nvic.enable(_cctx, _rctx);
                }
            }
        }
        pub fn config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            const cfg = comptime get_ct_cfg(_cctx);
            const t = reg_tim();

            enable(_cctx, _rctx);

            t.CR1.CEN = 0;

            switch (comptime _no.no2level()) {
                .basic => {},
                .advanced, .general => {
                    _ = utils.modify(t.CR1_struct, t.CR1, comptime .{
                        .CKD = @intFromEnum(cfg.ckd),
                        .CMS = @intFromEnum(cfg.cms),
                    });
                    if (cfg.cms == .edge) t.CR1.DIR = comptime @intFromEnum(cfg.dir);
                },
            }

            t.CR1.ARPE = comptime @intFromEnum(cfg.arre);
            t.ARR.ARR = cfg.arr;
            t.PSC.PSC = cfg.psc;

            switch (comptime _no.no2level()) {
                .basic, .general => {},
                .advanced => t.RCR.REP = cfg.rep,
            }

            t.EGR.UG = 0b1;

            if (t.SR.UIF == 0b1) t.SR.UIF = 0;

            // src
            switch (comptime _no.no2level()) {
                .basic => {},
                .advanced, .general => {
                    t.CR2.TI1S = 0;
                    _ = utils.modify(t.SMCR_struct, t.SMCR, .{
                        .SMS = 0,
                        .TS = 0,
                        .ETF = 0,
                        .ETPS = 0,
                        .ECE = 0,
                        .ETP = 0,
                    });
                    // TODO encoder mode
                    switch (cfg.src) {
                        .internal => {},
                        .extern2 => t.SMCR.ECE = 0b1,
                        .extern1 => |ts| {
                            _ = utils.modify(t.SMCR_struct, t.SMCR, comptime .{
                                .SMS = 0b111,
                                .TS = @intFromEnum(ts),
                            });
                        },
                    }
                    if (cfg.tim_dma) |tim_dma| {
                        _ = utils.modify(t.DCR_struct, t.DCR, comptime .{
                            .DBL = @intFromEnum(tim_dma.dbl),
                            .DBA = @intFromEnum(tim_dma.dba),
                        });
                    }
                },
            }

            t.CR2.MMS = comptime @intFromEnum(cfg.mms);
            if (comptime _no.no2level() == .advanced) t.SMCR.MSM = comptime @intFromEnum(cfg.msm);

            config_it(_cctx, _rctx);
            inline for (cfg.chs) |chc| try channel(chc.ch).config(_cctx, _rctx);
        }

        pub inline fn start(comptime _: Ct_Context, _: *Rt_Context) void {
            const t = reg_tim();
            t.CR1.CEN = 0b1;
        }
        pub inline fn reset(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            set(_cctx, _rctx, 0);
        }
        pub inline fn update(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;

            reg_tim().EGR.UG = 0b1;
        }
        pub inline fn stop(comptime _cctx: Ct_Context, _: *Rt_Context) void {
            const cfg = comptime get_ct_cfg(_cctx);
            _ = cfg; // check if tim is in trigger mode

            const t = reg_tim();

            t.CR1.CEN = 0;
            t.SR.UIF = 0;
        }
        pub inline fn set(comptime _cctx: Ct_Context, _rctx: *Rt_Context, _cnt: u16) void {
            _ = _cctx;
            _ = _rctx;

            reg_tim().CNT.CNT = _cnt;
        }
        pub inline fn get(comptime _cctx: Ct_Context, _rctx: *Rt_Context) u16 {
            _ = _cctx;
            _ = _rctx;

            const t = reg_tim();

            return t.CNT.CNT;
        }
        pub inline fn finished(comptime _cctx: Ct_Context, _rctx: *Rt_Context) bool {
            _ = _cctx;
            _ = _rctx;

            const t = reg_tim();
            if (t.SR.UIF == 0b1) {
                t.SR.UIF = 0;
                return true;
            }
            return false;
        }
        pub inline fn wait(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            while (finished(_cctx, _rctx) == false) {}
        }

        pub inline fn delay(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            start(_cctx, _rctx);
            reset(_cctx, _rctx);
            defer stop(_cctx, _rctx);

            wait(_cctx, _rctx);
        }

        inline fn get_count(comptime _cctx: Ct_Context, _rctx: *Rt_Context, _us: u64) u64 {
            const cfg = comptime get_ct_cfg(_cctx);
            return (_us * (comptime @as(u64, get_freq(_cctx, _rctx)) / (@as(u64, cfg.psc) + 1)) + 500_000 - 1) / 1_000_000;
        }
        pub inline fn delay_us(comptime _cctx: Ct_Context, _rctx: *Rt_Context, _us: u64) void {
            const cfg = comptime get_ct_cfg(_cctx);
            const count: u64 = get_count(_cctx, _rctx, _us);
            const full_times: usize = @truncate(count / (@as(u64, cfg.arr) + 1));
            const last_count: u16 = @truncate(count % (@as(u64, cfg.arr) + 1));
            if (cfg.arre == .disable and full_times != 0) @compileError("ARRE must be enable!");
            start(_cctx, _rctx);
            reset(_cctx, _rctx);
            defer stop(_cctx, _rctx);
            for (0..full_times) |_| {
                wait(_cctx, _rctx);
            }
            while (get(_cctx, _rctx) < last_count) {}
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
            start(_cctx, _rctx, _load);
            defer stop(_cctx, _rctx);

            if (_eql_fn) |eql| {
                while (eql(_ptr, _value) == false) {
                    if (finished(_cctx, _rctx) == true) return Error.Tim_Time_Out;
                }
            } else {
                while (@field(_ptr, _name) != _value) {
                    if (finished(_cctx, _rctx) == true) return Error.Tim_Time_Out;
                }
            }
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
            const tmp = utils.modify(_T, _ptr, _value);

            start(_cctx, _rctx, _load);
            defer stop(_cctx, _rctx);

            if (_eql_fn) |eql| {
                while (eql(_ptr.*, tmp) == false) {
                    if (finished(_cctx, _rctx) == true) return Error.Tim_Time_Out;
                }
            } else {
                if (@bitSizeOf(_T) != @bitSizeOf(usize)) @compileError("Bitsize of " ++ @typeName(_T) ++ " is not the bitsize of usize!");

                while (@as(usize, @bitCast(_ptr.*)) != @as(usize, @bitCast(tmp))) {
                    if (finished(_cctx, _rctx) == true) return Error.Tim_Time_Out;
                }
            }
        }

        pub fn it_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            set_it_enable_bit(_cctx, _rctx);
        }
        pub fn it_stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            clear_it_enable_bit(_cctx, _rctx);
        }

        pub fn dma_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            const t = reg_tim();
            const ct_cfg = comptime get_ct_cfg(_cctx);
            const rt_cfg = get_rt_cfg(_rctx);
            const dc = dma_ch();

            if (comptime get_dma_ch_config(_cctx)) |_| {
                if (rt_cfg) |src| {
                    if (src.tim_dma) |crc| {
                        const crc_cfg = switch (crc.cfg) {
                            .rx_cfg => |cfg| cfg,
                            .tx_cfg => |cfg| cfg,
                        };
                        const dcrc = dma.Ch_Rt_Config{
                            .ma = crc_cfg.ma,
                            .mem2mem = .disable,
                            .circ = crc_cfg.circ,
                            .minc = crc_cfg.minc,
                            .pinc = .disable,
                            .ndt = crc_cfg.ndt,
                            .pa = @intFromPtr(t.DMAR),
                            .psize = .@"16bit",
                            .msize = .@"16bit",
                        };
                        try dc.config(_cctx, _rctx, dcrc);
                        dc.start(_cctx, _rctx);

                        if (ct_cfg.tim_dma) |tim_dma| {
                            if (_no.no2level() == .advanced) {
                                t.DIER.BDE = comptime @intFromEnum(tim_dma.bde);
                                t.DIER.COMDE = comptime @intFromEnum(tim_dma.comde);
                            }
                            t.DIER.TDE = comptime @intFromEnum(tim_dma.tde);
                            t.DIER.UDE = comptime @intFromEnum(tim_dma.ude);
                        }
                    }
                }
            }
        }

        pub fn dma_stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            const t = reg_tim();
            if (_no.no2level() == .advanced) {
                t.DIER.BDE = 0;
                t.DIER.COMDE = 0;
            }
            t.DIER.TDE = 0;
            t.DIER.UDE = 0;
            if (comptime get_dma_ch_config(_cctx)) |_| {
                dma_ch().stop(_cctx, _rctx);
            }
        }
    };
}

pub const Ch_Ct_Config = struct {
    ch: Pos.Channel,
    cfg: Cfg,
    ite: Ite = .disable,

    ch_dma: ?Ch_Dma = null,

    pub const Cfg = union(enum) {
        Input: IC_Cfg,
        Output: OC_Cfg,
    };
    pub const IC_Cfg = struct {
        sel: Sel = .normal,
        fil: Fil = .div1N1,
        psc: Psc = .div1,
        pol: Pol = .high_up,

        pub const Sel = enum(u2) { normal = 0b01, counter, trc };
        pub const Fil = enum(u4) { div1N1, div1N2, div1N4, div1N8, div2N6, div2N8, div4N6, div4N8, div8N6, div8N8, div16N5, div16N6, div16N8, div32N5, div32N6, div32N8 };
        pub const Psc = enum(u2) { div1, div2, div4, div8 };
        pub const Pol = enum(u1) { high_up, down };
    };
    pub const OC_Cfg = struct {
        mode: Mode = .frozen,
        fast: Fast = .disable,
        pul: u16 = 0,
        prel: Prel = .disable,
        pol: Pol = .high_up,

        pub const Mode = enum(u3) { frozen, active, inactive, toggle, lref, href, pwm1, pwm2 };
        pub const Fast = enum(u1) { disable, enable };
        pub const Prel = enum(u1) { disable, enable };
        pub const Pol = enum(u1) { high_up, down };
    };
    pub const Ite = enum(u1) { disable, enable };

    pub const Ch_Dma = struct {
        cfg: Dma_Cfg,
        pub const Dma_Cfg = union(enum) {
            tx_cfg: Dma_Ch_Rt_Config,
            rx_cfg: Dma_Ch_Rt_Config,
            const Dma_Ch_Rt_Config = struct {
                it: dma.Ch_Ct_Config.Ch_It,
                pl: dma.Ch_Ct_Config.Pl = .low,
            };
        };
    };
};
pub const Ch_Rt_Config = struct {
    ch_dma: ?Ch_Dma = null,
    pub const Ch_Dma = struct {
        cfg: Dma_Ch_Ct_Config,
        pub const Dma_Ch_Ct_Config = union(enum) {
            tx_cfg: Cfg,
            rx_cfg: Cfg,
            const Cfg = struct {
                ma: u32,
                ndt: u16,
                circ: dma.Ch_Rt_Config.Circ,
                minc: dma.Ch_Rt_Config.Minc,
            };
        };
    };
};

pub fn _Ch(comptime _Ct_Context: type, comptime _Rt_Context: type, comptime _pos: Pos) type {
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;
        pub inline fn reg_tim() type {
            return switch (_pos.no) {
                .@"1" => reg.TIM1,
                .@"2" => reg.TIM2,
                .@"3" => reg.TIM3,
                .@"4" => reg.TIM4,
            };
        }

        inline fn dma_ch_pos() dma.Pos {
            return switch (_pos.no) {
                .@"1" => switch (_pos.ch) {
                    .@"1" => .{ .no = .@"1", .ch = .@"2" },
                    .@"2" => .{ .no = .@"1", .ch = .@"3" },
                    .@"3" => .{ .no = .@"1", .ch = .@"6" },
                    .@"4" => .{ .no = .@"1", .ch = .@"4" },
                    .etr => @compileLog("DMA is not supported in etr channel!"),
                },
                .@"2" => switch (_pos.ch) {
                    .@"1" => .{ .no = .@"1", .ch = .@"5" },
                    .@"2" => .{ .no = .@"1", .ch = .@"7" },
                    .@"3" => .{ .no = .@"1", .ch = .@"3" },
                    .@"4" => .{ .no = .@"1", .ch = .@"7" },
                    .etr => @compileLog("DMA is not supported in etr channel!"),
                },
                .@"3" => switch (_pos.ch) {
                    .@"1" => .{ .no = .@"1", .ch = .@"6" },
                    .@"2" => @compileLog("DMA is not supported in 2 channel!"),
                    .@"3" => .{ .no = .@"1", .ch = .@"2" },
                    .@"4" => .{ .no = .@"1", .ch = .@"3" },
                    .etr => @compileLog("DMA is not supported in etr channel!"),
                },
                .@"4" => switch (_pos.ch) {
                    .@"1" => .{ .no = .@"1", .ch = .@"1" },
                    .@"2" => .{ .no = .@"1", .ch = .@"4" },
                    .@"3" => .{ .no = .@"1", .ch = .@"5" },
                    .@"4" => @compileLog("DMA is not supported in 4 channel!"),
                    .etr => @compileLog("DMA is not supported in etr channel!"),
                },
            };
        }
        pub inline fn dma_ch() type {
            return dma.Ch(dma_ch_pos());
        }

        inline fn pin() type {
            return switch (_pos.no) {
                .@"1" => switch (_pos.ch) {
                    .etr => gpio.A.pin(.@"12"),
                    .@"1" => gpio.A.pin(.@"8"),
                    .@"2" => gpio.A.pin(.@"9"),
                    .@"3" => gpio.A.pin(.@"10"),
                    .@"4" => gpio.A.pin(.@"11"),
                },
                .@"2" => switch (_pos.ch) {
                    .etr => gpio.A.pin(.@"0"),
                    .@"1" => gpio.A.pin(.@"0"),
                    .@"2" => gpio.A.pin(.@"1"),
                    .@"3" => gpio.A.pin(.@"2"),
                    .@"4" => gpio.A.pin(.@"3"),
                },
                .@"3" => switch (_pos.ch) {
                    .etr => @compileError("Not exsists?"),
                    .@"1" => gpio.B.pin(.@"4"),
                    .@"2" => gpio.B.pin(.@"5"),
                    .@"3" => gpio.B.pin(.@"0"),
                    .@"4" => gpio.B.pin(.@"1"),
                },
                .@"4" => switch (_pos.ch) {
                    .etr => @compileError("Not exsists?"),
                    .@"1" => gpio.B.pin(.@"6"),
                    .@"2" => gpio.B.pin(.@"7"),
                    .@"3" => gpio.B.pin(.@"8"),
                    .@"4" => gpio.B.pin(.@"9"),
                },
            };
        }

        inline fn get_ch_pin_config(comptime _cctx: Ct_Context) ?gpio.Pin_Ct_Config {
            const ch_cfg = comptime get_ct_cfg(_cctx);

            return switch (ch_cfg.ch) {
                .etr => if (_pos.no == .@"1" or _pos.no == .@"2") .{ .Input = .{ .mode = .Flt } } else null,
                .@"1", .@"2", .@"3", .@"4" => switch (ch_cfg.cfg) {
                    .Input => |ic| switch (ic.sel) {
                        .normal => .{ .Input = .{ .mode = .Flt } },
                        .counter, .trc => null,
                    },
                    .Output => .{ .Output = .{ .mode = .AFPP, .speed = .@"50MHz" } },
                },
            };
        }

        inline fn gpio_enable() void {
            switch (_pos.no) {
                .@"1" => switch (_pos.ch) {
                    .etr => gpio.A.enable(),
                    .@"1" => gpio.A.enable(),
                    .@"2" => gpio.A.enable(),
                    .@"3" => gpio.A.enable(),
                    .@"4" => gpio.A.enable(),
                },
                .@"2" => switch (_pos.ch) {
                    .etr => gpio.A.enable(),
                    .@"1" => gpio.A.enable(),
                    .@"2" => gpio.A.enable(),
                    .@"3" => gpio.A.enable(),
                    .@"4" => gpio.A.enable(),
                },
                .@"3" => switch (_pos.ch) {
                    .etr => {},
                    .@"1" => gpio.B.enable(),
                    .@"2" => gpio.B.enable(),
                    .@"3" => gpio.B.enable(),
                    .@"4" => gpio.B.enable(),
                },
                .@"4" => switch (_pos.ch) {
                    .etr => {},
                    .@"1" => gpio.B.enable(),
                    .@"2" => gpio.B.enable(),
                    .@"3" => gpio.B.enable(),
                    .@"4" => gpio.B.enable(),
                },
            }
        }

        pub inline fn enable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;
            gpio_enable();
        }
        pub inline fn disable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;
        }

        inline fn get_dma_ch_config(comptime _cctx: Ct_Context) ?dma.Ch_Ct_Config {
            const ct_cfg = comptime get_ct_cfg(_cctx);
            if (ct_cfg.tim_dma) |tim_dma| {
                if (tim_dma.cfg) |cc| {
                    return switch (cc) {
                        .tx_cfg => dma.Ch_Ct_Config{
                            .mem2mem = .disable,
                            .msize = .@"16bit",
                            .psize = .@"16bit",
                            .dir = .memory,
                            .ch = dma_ch_pos().ch,
                            .ch_it = cc.it,
                            .pl = cc.pl,
                        },
                        .rx_cfg => dma.Ch_Ct_Config{
                            .mem2mem = .disable,
                            .msize = .@"16bit",
                            .psize = .@"16bit",
                            .dir = .peripheral,
                            .ch = dma_ch_pos().ch,
                            .ch_it = cc.it,
                            .pl = cc.pl,
                        },
                    };
                }
            }
            return null;
        }

        pub inline fn get_ct_cfg(comptime _cctx: Ct_Context) Ch_Ct_Config {
            const cfg = Tim(_pos.no).get_ct_cfg(_cctx);
            return comptime CH_CT_CFG: {
                for (cfg.chs) |chc| if (chc.ch == _pos.ch) break :CH_CT_CFG chc;
                @compileError("Not exsits in chs");
            };
        }
        pub inline fn get_rt_cfg(_rctx: *Rt_Context) ?Ch_Rt_Config {
            const cfg = Tim(_pos.no).get_rt_cfg(_rctx);
            return CH_RT_CFG: {
                if (cfg) |c| for (c.chs) |chc| if (chc.ch == _pos.ch) break :CH_RT_CFG chc;
                break :CH_RT_CFG null;
            };
        }

        pub inline fn get_pos() Pos {
            return _pos;
        }

        pub inline fn use(_cctx: *_Ct_Context) void {
            if (comptime get_ch_pin_config(_cctx.*)) |cfg| pin().use(_cctx, cfg);
        }
        pub inline fn unuse(_cctx: *_Ct_Context) void {
            if (comptime get_ch_pin_config(_cctx.*)) |cfg| pin().unuse(_cctx, cfg);
        }

        pub fn clear_it_flag(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;
            const t = reg_tim();

            switch (_pos.ch) {
                .etr => {},
                .@"1" => {
                    t.SR.CC1IF = 0;
                    t.SR.CC1OF = 0;
                },
                .@"2" => {
                    t.SR.CC2IF = 0;
                    t.SR.CC2OF = 0;
                },
                .@"3" => {
                    t.SR.CC3IF = 0;
                    t.SR.CC3OF = 0;
                },
                .@"4" => {
                    t.SR.CC4IF = 0;
                    t.SR.CC4OF = 0;
                },
            }
        }
        pub fn set_it_enable_bit(comptime _cctx: Ct_Context, _: *Rt_Context) void {
            const ch_cfg = comptime get_ct_cfg(_cctx);
            const t = reg_tim();
            switch (_pos.ch) {
                .etr => {},
                .@"1" => t.DIER.CC1IE = comptime @intFromEnum(ch_cfg.ite),
                .@"2" => t.DIER.CC2IE = comptime @intFromEnum(ch_cfg.ite),
                .@"3" => t.DIER.CC3IE = comptime @intFromEnum(ch_cfg.ite),
                .@"4" => t.DIER.CC4IE = comptime @intFromEnum(ch_cfg.ite),
            }
        }
        pub fn clear_it_enable_bit(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;
            const t = reg_tim();
            switch (_pos.ch) {
                .etr => {},
                .@"1" => t.DIER.CC1IE = 0,
                .@"2" => t.DIER.CC2IE = 0,
                .@"3" => t.DIER.CC3IE = 0,
                .@"4" => t.DIER.CC4IE = 0,
            }
        }

        inline fn etr_config(comptime _cctx: Ct_Context) void {
            const t = reg_tim();
            const ch_cfg = comptime get_ct_cfg(_cctx);
            switch (ch_cfg.cfg) {
                .ic => |ic| _ = utils.modify(t.CCMR1_Input_struct, t.CCMR1_Input, comptime .{
                    .ETF = @intFromEnum(ic.fil),
                    .ETPS = @intFromEnum(ic.psc),
                    .ETP = @intFromEnum(ic.pol),
                }),
                .oc => |_| @compileError("Mode `oc` does not exsists in etr channel!"),
            }
        }
        inline fn ch1_config(comptime _cctx: Ct_Context) void {
            const t = reg_tim();
            const ch_cfg = comptime get_ct_cfg(_cctx);

            t.CCER.CC1E = 0;
            if (comptime _pos.no.no2level() == .advanced) { // ???
                _ = utils.modify(t.CCER_struct, t.CCER, comptime .{
                    .CC1NP = 0,
                    .CC1NE = 0,
                });
                _ = utils.modify(t.CR2_struct, t.CR2, comptime .{
                    .OIS1 = 0,
                    .OIS1N = 0,
                });
            }
            switch (ch_cfg.cfg) {
                .Input => |ic| {
                    t.CCMR1_Output.CC1S = 0b01;
                    _ = utils.modify(t.CCMR1_Input_struct, t.CCMR1_Input, comptime .{
                        .CC1S = @intFromEnum(ic.sel),
                        .IC1PSC = @intFromEnum(ic.psc),
                        .IC1F = @intFromEnum(ic.fil),
                    });
                    t.CCER.CC1P = comptime @intFromEnum(ic.pol);
                },
                .Output => |oc| {
                    t.CCMR1_Output.CC1S = 0b1;
                    _ = utils.modify(t.CCMR1_Output_struct, t.CCMR1_Output, comptime .{
                        .OC1FE = @intFromEnum(oc.fast),
                        .OC1PE = @intFromEnum(oc.prel),
                        .OC1M = @intFromEnum(oc.mode),
                    });
                    t.CCMR1_Output.CC1S = 0;
                    t.CCR1.CCR1 = oc.pul;
                    t.CCER.CC1P = comptime @intFromEnum(oc.pol);
                },
            }
        }
        inline fn ch2_config(comptime _cctx: Ct_Context) void {
            const t = reg_tim();
            const ch_cfg = comptime get_ct_cfg(_cctx);

            t.CCER.CC2E = 0;
            if (comptime _pos.no.no2level() == .advanced) { // ???
                _ = utils.modify(t.CCER_struct, t.CCER, comptime .{
                    .CC2NP = 0,
                    .CC2NE = 0,
                });
                _ = utils.modify(t.CR2_struct, t.CR2, comptime .{
                    .OIS2 = 0,
                    .OIS2N = 0,
                });
            }
            switch (ch_cfg.cfg) {
                .Input => |ic| {
                    _ = utils.modify(t.CCMR1_Input_struct, t.CCMR1_Input, comptime .{
                        .CC2S = @intFromEnum(ic.sel),
                        .IC2PSC = @intFromEnum(ic.psc),
                        .IC2F = @intFromEnum(ic.fil),
                    });
                    t.CCER.CC2P = comptime @intFromEnum(ic.pol);
                },
                .Output => |oc| {
                    t.CCMR1_Output.CC2S = 0b01;
                    _ = utils.modify(t.CCMR1_Output_struct, t.CCMR1_Output, comptime .{
                        .OC2FE = @intFromEnum(oc.fast),
                        .OC2PE = @intFromEnum(oc.prel),
                        .OC2M = @intFromEnum(oc.mode),
                    });
                    t.CCMR1_Output.CC2S = 0;
                    t.CCER.CC2P = comptime @intFromEnum(oc.pol);
                },
            }
        }
        inline fn ch3_config(comptime _cctx: Ct_Context) void {
            const t = reg_tim();
            const ch_cfg = comptime get_ct_cfg(_cctx);

            t.CCER.CC3E = 0;
            if (comptime _pos.no.no2level() == .advanced) { // ???
                _ = utils.modify(t.CCER_struct, t.CCER, comptime .{
                    .CC3NP = 0,
                    .CC3NE = 0,
                });
                _ = utils.modify(t.CR2_struct, t.CR2, comptime .{
                    .OIS3 = 0,
                    .OIS3N = 0,
                });
            }
            switch (ch_cfg.cfg) {
                .Input => |ic| {
                    t.CCMR2_Output.CC3S = 0b01;
                    _ = utils.modify(t.CCMR2_Input_struct, t.CCMR2_Input, comptime .{
                        .CC3S = @intFromEnum(ic.sel),
                        .IC3PSC = @intFromEnum(ic.psc),
                        .IC3F = @intFromEnum(ic.fil),
                    });
                    t.CCER.CC1P = comptime @intFromEnum(ic.pol);
                },
                .Output => |oc| {
                    t.CCMR2_Output.CC3S = 0b01;
                    _ = utils.modify(t.CCMR2_Output_struct, t.CCMR2_Output, comptime .{
                        .OC3FE = @intFromEnum(oc.fast),
                        .OC3PE = @intFromEnum(oc.prel),
                        .OC3M = @intFromEnum(oc.mode),
                    });
                    t.CCMR2_Output.CC3S = 0;
                    t.CCR3.CCR3 = oc.pul;
                    t.CCER.CC3P = comptime @intFromEnum(oc.pol);
                },
            }
        }
        inline fn ch4_config(comptime _cctx: Ct_Context) void {
            const t = reg_tim();
            const ch_cfg = comptime get_ct_cfg(_cctx);

            t.CCER.CC4E = 0;
            if (comptime _pos.no.no2level() == .advanced) { // ???
                t.CR2.OIS4 = 0;
            }
            switch (ch_cfg.cfg) {
                .Input => |ic| {
                    t.CCMR2_Output.CC4S = 0b01;
                    _ = utils.modify(t.CCMR2_Input_struct, t.CCMR2_Input, comptime .{
                        .CC4S = @intFromEnum(ic.sel),
                        .IC4PSC = @intFromEnum(ic.psc),
                        .IC4F = @intFromEnum(ic.fil),
                    });
                    t.CCER.CC4P = comptime @intFromEnum(ic.pol);
                },
                .Output => |oc| {
                    t.CCMR2_Output.CC4S = 0b01;
                    _ = utils.modify(t.CCMR2_Output_struct, t.CCMR2_Output, comptime .{
                        .OC4FE = @intFromEnum(oc.fast),
                        .OC4PE = @intFromEnum(oc.prel),
                        .OC4M = @intFromEnum(oc.mode),
                    });
                    t.CCMR2_Output.CC4S = 0;
                    t.CCR4.CCR4 = oc.pul;
                    t.CCER.CC4P = comptime @intFromEnum(oc.pol);
                },
            }
        }
        pub inline fn config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            const ch_cfg = comptime get_ct_cfg(_cctx);

            enable(_cctx, _rctx);

            // TODO gpio init: oc ic pwm DMA? IT?
            switch (ch_cfg.ch) {
                .etr => etr_config(_cctx),
                .@"1" => ch1_config(_cctx),
                .@"2" => ch2_config(_cctx),
                .@"3" => ch3_config(_cctx),
                .@"4" => ch4_config(_cctx),
            }
            if (comptime get_ch_pin_config(_cctx)) |pcfg| try pin().config(_cctx, _rctx, pcfg);
        }

        pub inline fn set(comptime _cctx: Ct_Context, _: *Rt_Context, _cnt: u16) void {
            const t = reg_tim();
            const ch_cfg = comptime get_ct_cfg(_cctx);

            switch (ch_cfg.ch) {
                .etr => {},
                .@"1" => t.CCR1.CCR1 = _cnt,
                .@"2" => t.CCR2.CCR2 = _cnt,
                .@"3" => t.CCR3.CCR3 = _cnt,
                .@"4" => t.CCR4.CCR4 = _cnt,
            }
        }
        pub inline fn get(comptime _cctx: Ct_Context, _: *Rt_Context) u16 {
            const t = reg_tim();
            const ch_cfg = comptime get_ct_cfg(_cctx);

            switch (ch_cfg.ch) {
                .etr => @compileError("Cannot get value from ETR!"),
                .@"1" => return t.CCR1.CCR1,
                .@"2" => return t.CCR2.CCR2,
                .@"3" => return t.CCR3.CCR3,
                .@"4" => return t.CCR4.CCR4,
            }
            return 0;
        }
        pub inline fn start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            const t = reg_tim();

            _ = _cctx;
            _ = _rctx;

            switch (_pos.ch) {
                .etr => {},
                .@"1" => t.CCER.CC1E = 0b1,
                .@"2" => t.CCER.CC2E = 0b1,
                .@"3" => t.CCER.CC3E = 0b1,
                .@"4" => t.CCER.CC4E = 0b1,
            }
            t.CR1.CEN = 0b1;
        }
        pub inline fn stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            const t = reg_tim();

            _ = _cctx;
            _ = _rctx;

            switch (_pos.ch) {
                .etr => {},
                .@"1" => t.CCER.CC1E = 0,
                .@"2" => t.CCER.CC2E = 0,
                .@"3" => t.CCER.CC3E = 0,
                .@"4" => t.CCER.CC4E = 0,
            }
        }

        pub fn it_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            set_it_enable_bit(_cctx, _rctx);
        }
        pub fn it_stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            clear_it_enable_bit(_cctx, _rctx);
        }

        pub fn dma_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            const t = reg_tim();
            const rt_cfg = get_rt_cfg(_rctx);
            const dc = dma_ch();

            if (comptime get_dma_ch_config(_cctx)) |_| {
                if (rt_cfg) |src| {
                    if (src.ch_dma) |cd| {
                        const cd_cfg = switch (cd.cfg) {
                            .rx_cfg => |cfg| cfg,
                            .tx_cfg => |cfg| cfg,
                        };
                        const dcrc = dma.Ch_Rt_Config{
                            .ma = cd_cfg.ma,
                            .circ = cd_cfg.circ,
                            .minc = cd_cfg.minc,
                            .pinc = .disable,
                            .ndt = cd_cfg.ndt,
                            .pa = @intFromPtr(t.DMAR),
                        };
                        try dc.config(_cctx, _rctx, dcrc);
                        dc.start(_cctx, _rctx);
                        switch (_pos.ch) {
                            .etr => {},
                            .@"1" => t.DIER.CC1DE = 0b1,
                            .@"2" => t.DIER.CC2DE = 0b1,
                            .@"3" => t.DIER.CC3DE = 0b1,
                            .@"4" => t.DIER.CC4DE = 0b1,
                        }
                    }
                }
            }
        }
        pub fn dma_stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            const t = reg_tim();

            if (comptime get_dma_ch_config(_cctx)) |_| {
                dma_ch().stop(_cctx, _rctx);
                switch (_pos.ch) {
                    .etr => {},
                    .@"1" => t.DIER.CC1DE = 0,
                    .@"2" => t.DIER.CC2DE = 0,
                    .@"3" => t.DIER.CC3DE = 0,
                    .@"4" => t.DIER.CC4DE = 0,
                }
            }
        }
    };
}

pub fn Tim(comptime _no: Pos.No) type {
    return tim.Tim(
        ctx.Ct_Context,
        ctx.Rt_Context,
        Tim_Ct_Config,
        Tim_Rt_Config,
        Pos,
        Error,
        _Tim,
        _no,
    );
}

pub fn Ch(comptime _pos: Pos) type {
    return tim.Ch(
        ctx.Ct_Context,
        ctx.Rt_Context,
        Ch_Ct_Config,
        Ch_Rt_Config,
        Pos,
        Error,
        _Ch,
        _pos,
    );
}
