const reg = @import("reg.zig");
const it = @import("it.zig");
const gpio = @import("gpio.zig");
const pbr = @import("pbr.zig");
const ctx = @import("ctx.zig");

const interface = @import("../stm32.zig").interface;
const utils = interface.utils;
const sys = interface.sys;

pub var systick_it: ?*const fn () void = null;
pub var rcc_it: ?*const fn () void = null;

pub const clock = Clock();
pub const tick = Tick();

pub const Sys_Ct_Context = struct {
    clock_cfg: ?Clock_Ct_Config = null,
    tick_cfg: ?Tick_Ct_Config = null,
};
pub const Sys_Rt_Context = struct {
    clock_cfg: ?Clock_Rt_Config = null,
    tick_cfg: ?Tick_Rt_Config = null,
};

pub const Frequency = struct {
    sysclk: u32,
    hclk: u32,
    pclk1: u32,
    pclk2: u32,
};

pub const Clock_Ct_Config = struct {
    /// Using the source of hsi, the frequency is divided by 2
    src: Source = .{ .HSI = {} },
    lsi: Lsi = .{ .enable = .{} },
    lse: Lse = .{ .disable = {} },
    hse: Hse = .{ .disable = {} },
    pllmul: PLLMul = .@"2",
    hpre: HPRE = .div1,
    ppre1: PPRE = .div1,
    ppre2: PPRE = .div1,

    mco: Mco = .disable,

    sysclock_it: ?Systick_it = null,

    pub const Source = union(enum) {
        HSI: void,
        HSE: HSET,

        pub const HSET = struct {
            pre: Pre = .div1,
            pub const Pre = enum(u1) { div1, div2 };
        };
    };
    pub const Lsi = union(enum) {
        disable: void,
        enable: LsiT,
        pub const LsiT = struct {
            speed: u32 = 40_000, // Hz
        };
    };
    pub const Lse = union(enum) {
        disable: void,
        enable: LseT,
        pub const LseT = struct {
            speed: u32 = 32_768, // Hz
            byp: Byp = .no,

            pub const Byp = enum(u1) { no, yes };
        };
    };
    pub const Hse = union(enum) {
        disable: void,
        enable: HseT,
        pub const HseT = struct {
            speed: u32 = 8_000_000, // Hz
            byp: Byp = .no,

            pub const Byp = enum(u1) { no, yes };
        };
    };
    pub const PLLMul = enum(u4) { @"2" = 0, @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16" };
    pub const HPRE = enum(u4) { div1 = 0b0111, div2, div4, div8, div16, div64, div128, div256, div512 };
    pub const PPRE = enum(u3) { div1 = 0b011, div2, div4, div8, div16 };
    pub const Mco = enum(u3) { disable = 0b011, sysclk, hsi, hse, plldiv2 };

    pub const Systick_it = struct {
        gf: *const fn (comptime _ctx: ctx.Ct_Context) fn () void,
        nvic_cfg: it.Nvic_Config = .{ .pri = 0xF },
        pllrdyie: Pllrdyie = .disable,
        hserdyie: Hserdyie = .disable,
        hsirdyie: Hsirdyie = .disable,
        lserdyie: Lserdyie = .disable,
        lsirdyie: Lsirdyie = .disable,

        pub const Pllrdyie = enum(u1) { disable, enable };
        pub const Hserdyie = enum(u1) { disable, enable };
        pub const Hsirdyie = enum(u1) { disable, enable };
        pub const Lserdyie = enum(u1) { disable, enable };
        pub const Lsirdyie = enum(u1) { disable, enable };
    };
};
pub const Clock_Rt_Config = struct {};
pub const Clock_Error = error{
    HSIRDY_Time_Out,
    HSERDY_Time_Out,
    LSIRDY_Time_Out,
    LSERDY_Time_Out,
    PLLSWS_Time_Out,
};

fn _Clock(comptime _Ct_Context: type, comptime _Rt_Context: type) type {
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;
        pub inline fn get_sysclk(comptime _cctx: Ct_Context) u32 {
            const cfg = comptime get_ct_cfg(_cctx);

            const pll_src_speed: comptime_int = switch (cfg.src) {
                .HSI => 8_000_000 / 2,
                .HSE => switch (cfg.hse) {
                    .disable => @compileError("Not activated source of HSE!"),
                    .enable => |hse| hse.speed,
                },
            };
            const pll_clk_speed: comptime_int = pll_src_speed * @as(comptime_int, @intFromEnum(cfg.pllmul) + 2);

            if (pll_clk_speed > 72_000_000) @compileError("Output frequency of pll must not be more than 72MHz!");

            return pll_clk_speed;
        }
        pub inline fn get_hclk(comptime _cctx: Ct_Context) u32 {
            const cfg = comptime get_ct_cfg(_cctx);

            return get_sysclk(_cctx) / switch (cfg.hpre) {
                .div1 => 1,
                .div2 => 2,
                .div4 => 4,
                .div8 => 8,
                .div16 => 16,
                .div64 => 64,
                .div128 => 128,
                .div256 => 256,
                .div512 => 512,
            };
        }

        inline fn _get_pclk(comptime _ppre: Clock_Ct_Config.PPRE, comptime _hclk: u32) u32 {
            return comptime _hclk >> (@intFromEnum(_ppre) - 0b11);
        }
        pub inline fn get_pclk(comptime _cctx: Ct_Context) struct { u32, u32 } {
            if (_cctx.sys.clock_cfg == null) @compileError("Config of Clock is not exsists!");
            const cfg = _cctx.sys.clock_cfg.?;

            return .{ _get_pclk(cfg.ppre1, get_hclk(_cctx)), _get_pclk(cfg.ppre2, get_hclk(_cctx)) };
        }
        pub inline fn get_freq(comptime _cctx: Ct_Context) Frequency {
            const pclk = get_pclk(_cctx);
            return .{
                .sysclk = get_sysclk(_cctx),
                .hclk = get_hclk(_cctx),
                .pclk1 = pclk.@"0",
                .pclk2 = pclk.@"1",
            };
        }

        pub inline fn get_ct_cfg(comptime _cctx: Ct_Context) Clock_Ct_Config {
            return _cctx.sys.clock_cfg.?;
        }
        pub inline fn get_rt_cfg(_rctx: *Rt_Context) ?Clock_Rt_Config {
            return _rctx.sys.clock_cfg;
        }

        pub fn use(_cctx: *_Ct_Context) void {
            const cfg = comptime get_ct_cfg(_cctx.*);
            if (cfg.mco != .disable) {
                gpio.A.pin(.@"8").use(_cctx, .{ .Output = .{ .mode = .AFPP, .speed = .@"50MHz" } });
            }
            if (cfg.lse == .enable) {
                gpio.C.pin(.@"14").use(_cctx, .{ .Input = .{} });
                gpio.C.pin(.@"15").use(_cctx, .{ .Input = .{} });
            }
            if (cfg.hse == .enable) {
                gpio.D.pin(.@"0").use(_cctx, .{ .Input = .{} });
                gpio.D.pin(.@"1").use(_cctx, .{ .Input = .{} });
            }
        }
        pub fn unuse(_cctx: *_Ct_Context) void {
            const cfg = comptime get_ct_cfg(_cctx.*);
            if (cfg.mco != .disable) {
                gpio.A.pin(.@"8").unuse(_cctx);
            }
            if (cfg.lse == .enable) {
                gpio.C.pin(.@"14").unuse(_cctx);
                gpio.C.pin(.@"15").unuse(_cctx);
            }
            if (cfg.hse == .enable) {
                gpio.D.pin(.@"0").unuse(_cctx);
                gpio.D.pin(.@"1").unuse(_cctx);
            }
        }

        inline fn check_pclk(comptime _cctx: Ct_Context) bool {
            const pclk = get_pclk(_cctx);

            return pclk[0] <= 36_000_000 and pclk[1] <= 72_000_000;
        }

        inline fn config_it(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            const cfg = comptime get_ct_cfg(_cctx);
            if (cfg.sysclock_it) |si| {
                const nvic = it.Nvic(.{ .ext = .RCC });
                // TODO fingure out whether it's essential for rcc interrupt
                _ = utils.modify(reg.RCC.CIR_struct, reg.RCC.CIR, comptime .{
                    .PLLRDYIE = @intFromEnum(si.pllrdyie),
                    .HSERDYIE = @intFromEnum(si.hserdyie),
                    .LSERDYIE = @intFromEnum(si.lserdyie),
                    .HSIRDYIE = @intFromEnum(si.hsirdyie),
                    .LSIRDYIE = @intFromEnum(si.lsirdyie),
                });
                rcc_it = si.gf(_cctx);
                nvic.set_priority(_cctx, _rctx, si.nvic_cfg);
                nvic.enable(_cctx, _rctx);
            }
        }
        inline fn mco_config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            const cfg = comptime get_ct_cfg(_cctx);
            if (cfg.mco != .disable) {
                try gpio.A.pin(.@"8").config(_cctx, _rctx, .{ .Output = .{ .mode = .AFPP, .speed = .@"50MHz" } });
            }
            reg.RCC.CFGR.MCO = comptime @intFromEnum(cfg.mco);
        }
        pub fn config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            const cfg = comptime get_ct_cfg(_cctx);

            // Clock activation
            reg.RCC.CR.HSION = 0b1;
            tick.wait_until(
                _cctx,
                _rctx,
                1_000,
                reg.RCC.CR_struct,
                reg.RCC.CR,
                "HSIRDY",
                0b1,
                null,
            ) catch return Clock_Error.HSIRDY_Time_Out;

            if (cfg.lsi == .enable) {
                reg.RCC.CSR.LSION = 0b1;
                tick.wait_until(
                    _cctx,
                    _rctx,
                    1_000,
                    reg.RCC.CSR_struct,
                    reg.RCC.CSR,
                    "LSIRDY",
                    0b1,
                    null,
                ) catch return Clock_Error.LSIRDY_Time_Out;
            }
            if (cfg.lse == .enable) {
                const p = pbr.pwr.reg_pwr();
                pbr.pwr.enable(_cctx, _rctx);
                try tick.modify_until_done(
                    _cctx,
                    _rctx,
                    1_000,
                    p.CR_struct,
                    p.CR,
                    comptime .{ .DBP = 0b1 },
                    null,
                );

                reg.RCC.BDCR.LSEON = 0;

                // LSEDRV
                reg.RCC.BDCR.LSEBYP = comptime @intFromEnum(cfg.lse.enable.byp);

                reg.RCC.BDCR.LSEON = 0b1;
                tick.wait_until(
                    _cctx,
                    _rctx,
                    1_000,
                    reg.RCC.BDCR_struct,
                    reg.RCC.BDCR,
                    "LSERDY",
                    0b1,
                    null,
                ) catch return Clock_Error.LSERDY_Time_Out;
            }
            if (cfg.hse == .enable) {
                reg.RCC.CR.HSEON = 0;

                if (cfg.hse.enable.byp == .yes)
                    if (cfg.hse.enable.speed < 4_000_000 or cfg.hse.enable.speed > 16_000_000)
                        @compileError("Frequency of Bypass Clock Source must be in [4,16]MHz!");
                reg.RCC.CR.HSEBYP = @intFromEnum(cfg.hse.enable.byp);

                reg.RCC.CR.HSEON = 0b1;
                tick.wait_until(
                    _cctx,
                    _rctx,
                    1_000,
                    reg.RCC.CR_struct,
                    reg.RCC.CR,
                    "HSERDY",
                    0b1,
                    null,
                ) catch return Clock_Error.HSERDY_Time_Out;
            }
            // PLL configuration
            reg.RCC.CR.PLLON = 0;

            const freq: u32 = comptime get_hclk(_cctx);
            if (comptime check_pclk(_cctx) == false) @compileError("Frequency of clock must not be more than the limitation!");

            switch (cfg.mco) {
                .disable, .sysclk, .plldiv2 => {},
                .hse => if (cfg.hse == .disable) @compileError("Mincrocontroller out clock's source(HSE) is disable!"),
                .hsi => if (cfg.hsi == .disable) @compileError("Mincrocontroller out clock's source(HSI) is disable!"),
            }

            switch (cfg.src) {
                .HSI => {
                    if (cfg.hsi == .disable) @compileError("Choosing the src of disable HSI!");
                    reg.RCC.CFGR.PLLSRC = 0;
                },
                .HSE => |hse| {
                    if (cfg.hse == .disable) @compileError("Choosing the src of disable HSE!");
                    reg.RCC.CFGR.PLLXTPRE = @intFromEnum(hse.pre);
                    reg.RCC.CFGR.PLLSRC = 0b1;
                },
            }

            _ = utils.modify(reg.RCC.CFGR_struct, reg.RCC.CFGR, comptime .{
                .PLLMUL = @intFromEnum(cfg.pllmul),
                .HPRE = @intFromEnum(cfg.hpre),
                .PPRE1 = @intFromEnum(cfg.ppre1),
                .PPRE2 = @intFromEnum(cfg.ppre2),
            });

            if (freq > 48_000_000) {
                reg.FLASH.ACR.LATENCY = 0b010;
            } else if (freq > 24_000_000) {
                reg.FLASH.ACR.LATENCY = 0b001;
            } else {
                reg.FLASH.ACR.LATENCY = 0b000;
            }
            reg.RCC.CR.PLLON = 0b1;

            reg.RCC.CFGR.SW = 0b10;
            tick.wait_until(
                _cctx,
                _rctx,
                1_000,
                reg.RCC.CFGR_struct,
                reg.RCC.CFGR,
                "SWS",
                0b10,
                null,
            ) catch return Clock_Error.PLLSWS_Time_Out;

            config_it(_cctx, _rctx);
            try mco_config(_cctx, _rctx);
        }
    };
}

pub const Tick_Ct_Config = struct {
    div: Div = .div8,
    systick_it: ?Systick_it = null,
    pub const Div = enum(u1) { div8, div1 };
    pub const Systick_it = struct {
        gf: *const fn (comptime _ctx: ctx.Ct_Context) fn () void,
        nvic_cfg: it.Nvic_Config = .{ .pri = 0xF },
    };
};
pub const Tick_Rt_Config = struct {};
pub const Tick_Error = error{
    Systick_Time_Out,
};

fn _Tick(comptime _Ct_Context: type, comptime _Rt_Context: type) type {
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;

        pub inline fn get_freq(comptime _cctx: Ct_Context) u32 {
            return comptime clock.get_freq(_cctx).hclk / switch (_cctx.sys.tick_cfg.?.div) {
                .div1 => 1,
                .div8 => 8,
            };
        }

        pub inline fn get_ct_cfg(comptime _cctx: Ct_Context) Tick_Ct_Config {
            return _cctx.sys.tick_cfg.?;
        }
        pub inline fn get_rt_cfg(_rctx: *Rt_Context) ?Tick_Rt_Config {
            return _rctx.sys.tick_cfg;
        }

        pub fn clear_it_flag(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;
            reg.STK.CTRL.COUNTFLAG = 0;
        }
        pub inline fn set_it_enable_bit(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;
            reg.STK.CTRL.TICKINT = 0b1;
        }
        pub inline fn clear_it_enable_bit(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;
            reg.STK.CTRL.TICKINT = 0;
        }

        inline fn config_it(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            const cfg = comptime get_ct_cfg(_cctx);

            if (cfg.systick_it) |si| {
                const nvic = it.Nvic(.{ .sys = .systick });

                systick_it = si.gf(_cctx);
                nvic.set_priority(_cctx, _rctx, si.nvic_cfg);
                nvic.enable(_cctx, _rctx);
            }
        }
        pub inline fn config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            const cfg = comptime get_ct_cfg(_cctx);
            reg.STK.CTRL.CLKSOURCE = comptime @intFromEnum(cfg.div);
            config_it(_cctx, _rctx);
        }

        pub inline fn start(comptime _cctx: Ct_Context, _rctx: *Rt_Context, _load: u24) void {
            _ = _cctx;
            _ = _rctx;

            reg.STK.CTRL.ENABLE = 0;

            reg.STK.LOAD_.RELOAD = _load;
            reg.STK.VAL.CURRENT = 0;
            reg.STK.CTRL.ENABLE = 0b1;
        }
        pub inline fn reset(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;

            reg.STK.CTRL.ENABLE = 0;
            reg.STK.VAL.CURRENT = 0;
            reg.STK.CTRL.ENABLE = 0b1;
        }
        pub inline fn stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;

            reg.STK.CTRL.ENABLE = 0;
            reg.STK.VAL.CURRENT = 0;
        }
        pub inline fn get(comptime _cctx: Ct_Context, _rctx: *Rt_Context) u24 {
            _ = _cctx;
            _ = _rctx;

            return reg.STK.VAL.CURRENT;
        }
        pub inline fn finished(comptime _cctx: Ct_Context, _rctx: *Rt_Context) bool {
            _ = _cctx;
            _ = _rctx;

            return reg.STK.CTRL.COUNTFLAG == 0b1;
        }
        pub inline fn wait(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            while (finished(_cctx, _rctx) == false) {}
        }

        pub inline fn delay(comptime _cctx: Ct_Context, _rctx: *Rt_Context, _load: u24) void {
            if (_load == 0) return;

            start(_cctx, _rctx, _load);
            defer stop(_cctx, _rctx);

            wait(_cctx, _rctx);
        }

        inline fn get_count(comptime _cctx: Ct_Context, _us: u64) u64 {
            return (@as(u64, _us) * @as(u64, comptime get_freq(_cctx)) + 500_000 - 1) / 1_000_000;
        }

        pub inline fn delay_us(comptime _cctx: Ct_Context, _rctx: *Rt_Context, _us: u64) void {
            const count: u64 = get_count(_cctx, _us);
            const full_times: usize = @truncate(count / 0xffffff);
            const last_count: u24 = @truncate(count % 0xffffff);
            for (0..full_times) |_| {
                delay(_cctx, _rctx, 0xffffff);
            }
            delay(_cctx, _rctx, last_count);
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
        ) Tick_Error!void {
            start(_cctx, _rctx, _load);
            defer stop(_cctx, _rctx);

            if (_eql_fn) |eql| {
                while (eql(_ptr, _value) == false) {
                    if (finished(_cctx, _rctx) == true) return Tick_Error.Systick_Time_Out;
                }
            } else {
                while (@field(_ptr, _name) != _value) {
                    if (finished(_cctx, _rctx) == true) return Tick_Error.Systick_Time_Out;
                }
            }
        }

        pub fn modify_until_done(
            comptime _cctx: Ct_Context,
            _rctx: *Rt_Context,
            _load: u24,
            comptime _T: type,
            comptime _ptr: *volatile _T,
            comptime _value: anytype,
            comptime _eql_fn: ?fn (_v1: _T, _v2: _T) bool,
        ) Tick_Error!void {
            const tmp = utils.modify(_T, _ptr, _value);

            start(_cctx, _rctx, _load);
            defer stop(_cctx, _rctx);

            if (_eql_fn) |eql| {
                while (eql(_ptr.*, tmp) == false) {
                    if (finished(_cctx, _rctx) == true) return Tick_Error.Systick_Time_Out;
                }
            } else {
                if (@bitSizeOf(_T) != @bitSizeOf(usize)) @compileError("Bitsize of " ++ @typeName(_T) ++ " is not the bitsize of usize!");

                while (@as(usize, @bitCast(_ptr.*)) != @as(usize, @bitCast(tmp))) {
                    if (finished(_cctx, _rctx) == true) return Tick_Error.Systick_Time_Out;
                }
            }
        }

        pub inline fn it_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            set_it_enable_bit(_cctx, _rctx);
        }
        pub inline fn it_stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            clear_it_enable_bit(_cctx, _rctx);
        }
    };
}

pub fn Clock() type {
    return sys.Clock(
        ctx.Ct_Context,
        ctx.Rt_Context,
        Clock_Ct_Config,
        Clock_Rt_Config,
        Frequency,
        Clock_Error,
        _Clock,
    );
}
pub fn Tick() type {
    return sys.Tick(
        ctx.Ct_Context,
        ctx.Rt_Context,
        Tick_Ct_Config,
        Tick_Rt_Config,
        Tick_Error,
        _Tick,
    );
}
