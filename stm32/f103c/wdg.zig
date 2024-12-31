const reg = @import("reg.zig");
const gpio = @import("gpio.zig");
const sys = @import("sys.zig");
const it = @import("it.zig");
const ctx = @import("ctx.zig");

const interface = @import("../stm32.zig").interface;
const utils = interface.utils;
const wdg = interface.wdg;

pub var wwdg_it: ?*const fn () void = null;

pub const iwdg = IWDG();
pub const wwdg = WWDG();

pub const Wdg_Ct_Context = struct {
    iwdg_cfg: ?Iwdg_Ct_Config = null,
    wwdg_cfg: ?Wwdg_Ct_Config = null,
};
pub const Wdg_Rt_Context = struct {
    iwdg_cfg: ?Iwdg_Rt_Config = null,
    wwdg_cfg: ?Wwdg_Rt_Config = null,
};

pub const Iwdg_Ct_Config = struct {
    rl: u12 = 0xFFF,
    pr: Pr = .div4,
    pub const Pr = enum(u3) { div4, div8, div16, div32, div64, div128, div256 };
};
pub const Iwdg_Rt_Config = struct {};

pub fn _IWDG(comptime _Ct_Context: type, comptime _Rt_Context: type) type {
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;

        pub inline fn reg_iwdg() type {
            return reg.IWDG;
        }

        pub fn enable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;
            reg_iwdg().KR.KEY = 0xCCCC;
        }

        pub fn get_freq(comptime _cctx: Ct_Context, _: *Rt_Context) u32 {
            return _cctx.sys.clock_cfg.?.lsi.enable.speed;
        }

        pub inline fn get_ct_cfg(comptime _cctx: Ct_Context) Iwdg_Ct_Config {
            return _cctx.wdg.iwdg_cfg.?;
        }
        pub inline fn get_rt_cfg(_rctx: *Rt_Context) ?Iwdg_Rt_Config {
            return _rctx.wdg.iwdg_cfg;
        }

        pub inline fn use(_cctx: *_Ct_Context) void {
            _ = _cctx;
        }
        pub inline fn unuse(_cctx: *_Ct_Context) void {
            _ = _cctx;
        }

        pub fn config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            const cfg = comptime get_ct_cfg(_cctx);
            const i = reg_iwdg();

            if (_cctx.sys.clock_cfg.?.lsi == .disable) @compileError("IWDG needs lsi clock to launch!");
            enable(_cctx, _rctx);

            i.KR.KEY = 0x5555;

            try sys.tick.wait_until(_cctx, _rctx, 10_000, i.SR_struct, i.SR, "PVU", 0, null);
            i.PR.PR = comptime @intFromEnum(cfg.pr);

            try sys.tick.wait_until(_cctx, _rctx, 10_000, i.SR_struct, i.SR, "RVU", 0, null);
            i.RLR.RL = cfg.rl;

            feed(_cctx, _rctx);
        }

        pub inline fn feed(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;
            reg_iwdg().KR.KEY = 0xAAAA;
        }
    };
}

pub const Wwdg_Ct_Config = struct {
    t: u7 = 0x7F, // Must be in [40,w] to feed wwdg
    w: u7 = 0x7F,
    wdgtb: WDGTB = .div1,

    wwdg_it: ?Wwdg_it = null,

    pub const WDGTB = enum(u2) { div1, div2, div4, div8 };

    pub const Wwdg_it = struct {
        gf: *const fn (comptime _ctx: ctx.Ct_Context) fn () void,
        nvic_cfg: it.Nvic_Config = .{ .pri = 0xF },
        ewi: Ewi = .disable,
        pub const Ewi = enum(u1) { disable, enable };
    };
};
pub const Wwdg_Rt_Config = struct {};

pub fn _WWDG(comptime _Ct_Context: type, comptime _Rt_Context: type) type {
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;

        pub inline fn reg_wwdg() type {
            return reg.WWDG;
        }

        pub inline fn enable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;

            reg.RCC.APB1ENR.WWDGEN = 0b1;
        }

        pub inline fn get_freq(comptime _cctx: Ct_Context, _rctx: *Rt_Context) u32 {
            return comptime sys.clock.get_freq(_cctx, _rctx).pclk1;
        }

        pub inline fn get_ct_cfg(comptime _cctx: Ct_Context) Wwdg_Ct_Config {
            return _cctx.wdg.wwdg_cfg.?;
        }
        pub inline fn get_rt_cfg(_rctx: *Rt_Context) ?Wwdg_Rt_Config {
            return _rctx.wdg.wwdg_cfg;
        }

        pub inline fn use(_cctx: *_Ct_Context) void {
            _ = _cctx;
        }
        pub inline fn unuse(_cctx: *_Ct_Context) void {
            _ = _cctx;
        }

        pub fn clear_it_flag(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;
            const w = reg_wwdg();
            w.SR.EWI = 0;
        }
        pub fn set_it_enable_bit(comptime _cctx: Ct_Context, _: *Rt_Context) void {
            const cfg = comptime get_ct_cfg(_cctx);
            const w = reg_wwdg();
            if (cfg.wwdg_it) |wi| {
                w.CFR.EWI = comptime @intFromEnum(wi.ewi);
            }
        }
        pub fn clear_it_enable_bit(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;
            const w = reg_wwdg();
            w.CFR.EWI = 0;
        }

        inline fn config_it(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            const cfg = comptime get_ct_cfg(_cctx);

            if (cfg.wwdg_it) |wi| {
                const nvic = it.Nvic(.{ .ext = .WWDG });

                wwdg_it = wi.gf(_cctx);

                nvic.set_priority(_cctx, _rctx, wi.nvic_cfg);
                nvic.enable(_cctx, _rctx);
            }
        }
        pub inline fn config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            const cfg = get_ct_cfg(_cctx);
            const w = reg_wwdg();

            enable(_cctx, _rctx);

            _ = utils.modify(w.CFR_struct, w.CFR, .{
                .EWI = 0,
                .WDGTB = @intFromEnum(cfg.wdgtb),
                .W = cfg.w,
            });

            w.CR.T = cfg.t;

            config_it(_cctx, _rctx);
        }

        pub inline fn start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;

            reg_wwdg().CR.WDGA = 0b1;
        }

        pub inline fn feed(comptime _cctx: Ct_Context, _: *Rt_Context) void {
            const cfg = comptime get_ct_cfg(_cctx);
            const w = reg_wwdg();
            w.CR.T = cfg.t;
        }

        pub inline fn it_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            set_it_enable_bit(_cctx, _rctx);
        }
        pub inline fn it_stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            clear_it_enable_bit(_cctx, _rctx);
        }
    };
}

pub fn IWDG() type {
    return wdg.IWDG(
        ctx.Ct_Context,
        ctx.Rt_Context,
        Iwdg_Ct_Config,
        Iwdg_Rt_Config,
        _IWDG,
    );
}
pub fn WWDG() type {
    return wdg.WWDG(
        ctx.Ct_Context,
        ctx.Rt_Context,
        Wdg_Ct_Context,
        Wwdg_Rt_Config,
        _WWDG,
    );
}
