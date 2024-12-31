// TODO
// bug: multi-channels mode only get the first channel's value without dma and it
const reg = @import("reg.zig");
const gpio = @import("gpio.zig");
const sys = @import("sys.zig");
const ctx = @import("ctx.zig");
const it = @import("it.zig");
const dma = @import("dma.zig");

const interface = @import("../stm32.zig").interface;
const adc = interface.adc;
const utils = interface.utils;

const ct_print = @import("std").fmt.comptimePrint;

pub var adc_its: [NO_NUMS]?*const fn () void = .{null} ** NO_NUMS;

pub const @"1" = Adc(.@"1");
pub const @"2" = Adc(.@"2");

pub const NO_NUMS = @typeInfo(Pos.No).Enum.fields.len;
pub const CH_NUMS = @typeInfo(Pos.Channel).Enum.fields.len;
pub const Pos = struct {
    no: No,
    ch: Channel,
    pub const No = enum { @"1", @"2" };
    pub const Channel = enum { @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17" };
};

pub const Adc_Ct_Context: type = CONTEXT: {
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
                    .type = ?Adc_Ct_Config,
                    .default_value = @ptrCast(&@as(?Adc_Ct_Config, null)),
                    .is_comptime = false,
                    .alignment = @alignOf(?Adc_Ct_Config),
                };
            }
            break :FIELDS &fields;
        },
    } });
};
pub const Adc_Rt_Context: type = CONTEXT: {
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
                    .type = ?Adc_Rt_Config,
                    .default_value = @ptrCast(&@as(?Adc_Rt_Config, null)),
                    .is_comptime = false,
                    .alignment = @alignOf(?Adc_Rt_Config),
                };
            }
            break :FIELDS &fields;
        },
    } });
};

pub const Adc_Ct_Config = struct {
    adcpre: AdcPre = .div2,

    awdch: AWDCh = .@"0",
    scan: Scan = .disable,
    awdsgl: AWDSgl = .all,
    jauto: JAuto = .disable,
    discen: DiscEn = .disable,
    jdiscen: JDiscEn = .disable,
    discnum: DiscNum = .@"1",
    jawden: JAWDEn = .disable,
    awden: AWDEn = .disable,

    tsvrefe: TsVrefE = .disable,
    extsel: Extsel = .swstart, // not follow the reset value, TODO fix it
    jextsel: Jextsel = .jswstart, // not follow the reset value, TODO fix it
    algn: Align = .right,
    cont: Cont = .single,

    ht: HT = 0,
    lt: LT = 0,

    l: L = .@"1",
    jl: JL = .@"1",

    joffsets: []u12 = &.{},

    chs: []Ch_Ct_Config = &.{},

    adc_it: ?Adc_It = null,
    adc_dma: ?Adc_Dma = null,

    pub const AdcPre = enum(u2) { div2, div4, div6, div8 };

    pub const AWDCh = enum(u5) { @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17" };
    pub const Scan = enum(u1) { disable, enable };
    pub const AWDSgl = enum(u1) { all, single };
    pub const JAuto = enum(u1) { disable, enable };
    pub const DiscEn = enum(u1) { disable, enable };
    pub const DiscNum = enum(u3) { @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8" };
    pub const JDiscEn = enum(u1) { disable, enable };
    pub const JAWDEn = enum(u1) { disable, enable };
    pub const AWDEn = enum(u1) { disable, enable };

    pub const TsVrefE = enum(u1) { disable, enable };
    // it only have adc1 and adc2, so it's neccessary to fit adc3's situation
    pub const Extsel = enum(u3) { tim1_cc1, tim1_cc2, tim1_cc3, tim2_cc2, tim3_trgo, tim4_cc4, exti11, swstart };
    pub const Jextsel = enum(u3) { tim1_trgo, tim1_cc4, tim2_trgo, tim2_cc1, tim3_cc4, tim4_trgo, exti15, jswstart };
    pub const Align = enum(u1) { right, left };
    pub const Cont = enum(u1) { single, continuous };

    pub const HT = u12;
    pub const LT = u12;

    pub const L = enum(u4) { @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16" };
    pub const JL = enum(u2) { @"1", @"2", @"3", @"4" };

    pub const Adc_It = struct {
        gf: *const fn (comptime _ctx: ctx.Ct_Context) fn () void,
        nvic_cfg: it.Nvic_Config = .{},

        eocie: Eocie = .disable,
        jeocie: Jeocie = .disable,
        awdie: Awdie = .disable,

        pub const Eocie = enum(u1) { disable, enable };
        pub const Jeocie = enum(u1) { disable, enable };
        pub const Awdie = enum(u1) { disable, enable };
    };
    pub const Adc_Dma = struct {
        cfg: ?Dma_Ch_Ct_Config = null,
        pub const Dma_Ch_Ct_Config = struct {
            it: dma.Ch_Ct_Config.Ch_It,
            pl: dma.Ch_Ct_Config.Pl = .low,
        };
    };
};
pub const Adc_Rt_Config = struct {
    // only enable when dma is started
    adc_dma: ?Dma_Ch_Rt_Config = null,
    chs: []Ch_Rt_Config = &.{},
    pub const Dma_Ch_Rt_Config = struct {
        ma: u32,
        ndt: u16,
        circ: dma.Ch_Rt_Config.Circ,
        minc: dma.Ch_Rt_Config.Minc,
    };
};
pub const Adc_Error = error{
    Adc_Wait_Time_Out,
    Adc_Modify_Time_Out,
};

fn _Adc(comptime _Ct_Context: type, comptime _Rt_Context: type, comptime _no: Pos.No) type {
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;
        pub fn reg_adc() type {
            return switch (_no) {
                .@"1" => reg.ADC1,
                .@"2" => reg.ADC2,
            };
        }

        inline fn dma_ch_pos() dma.Pos {
            return switch (_no) {
                .@"1" => .{ .no = .@"1", .ch = .@"1" },
                .@"2" => @compileLog("DMA is not supported for ADC2!"),
            };
        }
        pub inline fn dma_ch() type {
            return dma.Ch(dma_ch_pos());
        }

        pub fn ape_enable() void {
            switch (_no) {
                .@"1" => reg.RCC.APB2ENR.ADC1EN = 0b1,
                .@"2" => reg.RCC.APB2ENR.ADC2EN = 0b1,
            }
        }
        pub fn ape_disable() void {
            switch (_no) {
                .@"1" => reg.RCC.APB2ENR.ADC1EN = 0,
                .@"2" => reg.RCC.APB2ENR.ADC2EN = 0,
            }
        }

        pub fn enable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;

            ape_enable();
        }
        pub fn disable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;

            ape_disable();
        }

        inline fn get_dma_ch_config(comptime _cctx: Ct_Context) ?dma.Ch_Ct_Config {
            const ct_cfg = comptime get_ct_cfg(_cctx);
            if (ct_cfg.adc_dma) |adc_dma| {
                if (adc_dma.cfg) |cc| {
                    return dma.Ch_Ct_Config{
                        .dir = .peripheral,
                        .ch = dma_ch_pos().ch,
                        .ch_it = cc.it,
                        .pl = cc.pl,
                    };
                }
            }
            return null;
        }

        pub inline fn adc_cycles(comptime _cctx: Ct_Context) u32 {
            const adc_cfg: Adc_Ct_Config = @field(_cctx.adc, "cfg" ++ @tagName(_no)).?;
            return (@as(u32, @intFromEnum(adc_cfg.adcpre)) + 1) * 2;
        }
        pub inline fn get_freq(comptime _cctx: Ct_Context) u32 {
            const freq = comptime sys.clock.get_freq(_cctx);
            const aclk: comptime_int = comptime freq.pclk2 / adc_cycles(_cctx);
            if (aclk > 14_000_000) @compileError("Adc frequency must not be 14MHz");
            return aclk;
        }

        pub inline fn get_ct_cfg(comptime _cctx: Ct_Context) Adc_Ct_Config {
            return @field(_cctx.adc, "cfg" ++ @tagName(_no)).?;
        }
        pub inline fn get_rt_cfg(_rctx: *Rt_Context) ?Adc_Rt_Config {
            return @field(_rctx.adc, "cfg" ++ @tagName(_no));
        }

        pub inline fn get_no() Pos.No {
            return _no;
        }

        pub fn use(_cctx: *_Ct_Context) void {
            if (comptime get_dma_ch_config(_cctx.*)) |cfg| dma_ch().use(_cctx, cfg);
            const adc_cfg = get_ct_cfg(_cctx.*);
            for (adc_cfg.chs) |cc| channel(cc.ch).use(_cctx);
        }
        pub fn unuse(_cctx: *_Ct_Context) void {
            if (comptime get_dma_ch_config(_cctx.*)) |_| dma_ch().unuse(_cctx);
            const adc_cfg = get_ct_cfg(_cctx.*);
            for (adc_cfg.chs) |cc| channel(cc.ch).unuse(_cctx);
        }

        pub inline fn clear_it_flag(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;
            const a = reg_adc();
            _ = utils.modify(a.SR_struct, a.SR, comptime .{
                .EOC = 0,
                .JEOC = 0,
                .AWD = 0,
            });
        }
        pub inline fn set_it_enable_bit(comptime _cctx: Ct_Context, _: *Rt_Context) void {
            const cfg = get_ct_cfg(_cctx);
            const a = reg_adc();
            const ai = cfg.adc_it.?;

            _ = utils.modify(a.CR1_struct, a.CR1, comptime .{
                .EOCIE = @intFromEnum(ai.eocie),
                .JEOCIE = @intFromEnum(ai.jeocie),
                .AWDIE = @intFromEnum(ai.awdie),
            });
        }
        pub inline fn clear_it_enable_bit(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;
            const a = reg_adc();

            _ = utils.modify(a.CR1_struct, a.CR1, comptime .{
                .EOCIE = 0,
                .JEOCIE = 0,
                .AWDIE = 0,
            });
        }

        inline fn config_it(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            const cfg = get_ct_cfg(_cctx);

            if (cfg.adc_it) |ai| {
                const nvic = it.Nvic(.{ .ext = switch (_no) {
                    .@"1" => reg.Interrupts.ADC1_2,
                    .@"2" => reg.Interrupts.ADC1_2,
                } });

                clear_it_flag(_cctx, _rctx);
                adc_its[@intFromEnum(_no)] = ai.gf(_cctx);
                nvic.set_priority(_cctx, _rctx, ai.nvic_cfg);
                nvic.enable(_cctx, _rctx);
            }
        }
        pub fn config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            const cfg = get_ct_cfg(_cctx);
            const a = reg_adc();
            _ = get_freq(_cctx); // check freqency
            enable(_cctx, _rctx);
            try stop(_cctx, _rctx);

            sys.tick.modify_until_done(
                _cctx,
                _rctx,
                1000,
                reg.RCC.CFGR_struct,
                reg.RCC.CFGR,
                comptime .{ .ADCPRE = @intFromEnum(cfg.adcpre) },
                null,
            ) catch return Adc_Error.Adc_Modify_Time_Out;

            sys.tick.modify_until_done(_cctx, _rctx, 1000, a.CR1_struct, a.CR1, comptime .{
                .SCAN = @intFromEnum(cfg.scan),
                .AWDCH = @intFromEnum(cfg.awdch),
                .AWDEN = @intFromEnum(cfg.awden),
                .AWDSGL = @intFromEnum(cfg.awdsgl),
                .DISCEN = @intFromEnum(cfg.discen),
                .JDISCEN = @intFromEnum(cfg.jdiscen),
                .DISCNUM = @intFromEnum(cfg.discnum),
                .JAUTO = @intFromEnum(cfg.jauto),
            }, null) catch return Adc_Error.Adc_Modify_Time_Out;

            sys.tick.modify_until_done(_cctx, _rctx, 1000, a.CR2_struct, a.CR2, comptime .{
                .ALIGN = @intFromEnum(cfg.algn),
                .CONT = @intFromEnum(cfg.cont),
                .TSVREFE = @intFromEnum(cfg.tsvrefe),
                .EXTSEL = @intFromEnum(cfg.extsel),
                .JEXTSEL = @intFromEnum(cfg.jextsel),
            }, null) catch return Adc_Error.Adc_Modify_Time_Out;

            inline for (cfg.joffsets, 1..) |joffset, i| {
                const Ano_struct = @Type(.{
                    .Struct = .{
                        .layout = .auto,
                        .is_tuple = false,
                        .decls = &.{},
                        .fields = .{.{
                            .name = ct_print("JOFFSET{d}", .{i}),
                            .type = u12,
                            .default_value = @ptrCast(&@as(u12, joffset)),
                            .is_comptime = true,
                            .alignment = @alignOf(u12),
                        }},
                    },
                });
                sys.tick.modify_until_done(
                    _cctx,
                    _rctx,
                    1000,
                    @field(a, ct_print("JOFR{}_struct", .{i})),
                    @field(a, ct_print("JOFR{}", .{i})),
                    Ano_struct{},
                    null,
                ) catch return Adc_Error.Adc_Modify_Time_Out;
            }

            sys.tick.modify_until_done(
                _cctx,
                _rctx,
                1000,
                a.HTR_struct,
                a.HTR,
                comptime .{ .HT = cfg.ht },
                null,
            ) catch return Adc_Error.Adc_Modify_Time_Out;
            sys.tick.modify_until_done(
                _cctx,
                _rctx,
                1000,
                a.LTR_struct,
                a.LTR,
                comptime .{ .LT = cfg.lt },
                null,
            ) catch return Adc_Error.Adc_Modify_Time_Out;

            sys.tick.modify_until_done(
                _cctx,
                _rctx,
                1000,
                a.SQR1_struct,
                a.SQR1,
                comptime .{ .L = @intFromEnum(cfg.l) },
                null,
            ) catch return Adc_Error.Adc_Modify_Time_Out;
            sys.tick.modify_until_done(
                _cctx,
                _rctx,
                1000,
                a.JSQR_struct,
                a.JSQR,
                comptime .{ .JL = @intFromEnum(cfg.jl) },
                null,
            ) catch return Adc_Error.Adc_Modify_Time_Out;

            inline for (cfg.chs) |cc| try Ch(.{ .no = _no, .ch = cc.ch }).config(_cctx, _rctx);

            config_it(_cctx, _rctx);
        }

        pub fn regular_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            const cfg = get_ct_cfg(_cctx);
            const a = reg_adc();

            if (a.CR2.ADON == 0)
                sys.tick.modify_until_done(
                    _cctx,
                    _rctx,
                    1000,
                    a.CR2_struct,
                    a.CR2,
                    comptime .{ .ADON = 0b1 },
                    null,
                ) catch return Adc_Error.Adc_Modify_Time_Out;

            a.SR.EOC = 0;

            a.CR2.EXTTRIG = 0b1;
            if (cfg.extsel == .swstart and (_no == .@"1" or (_no == .@"2" and true))) { // TODO dual mode
                a.CR2.SWSTART = 0b1;
            }
        }
        pub fn injected_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            const cfg = get_ct_cfg(_cctx);
            const a = reg_adc();

            if (a.CR2.ADON == 0)
                sys.tick.modify_until_done(
                    _cctx,
                    _rctx,
                    1000,
                    a.CR2_struct,
                    a.CR2,
                    comptime .{ .ADON = 0b1 },
                    null,
                ) catch return Adc_Error.Adc_Modify_Time_Out;

            a.SR.JEOC = 0;

            a.CR2.JEXTTRIG = 0b1;
            if (cfg.extsel == .swstart and (_no == .@"1" or (_no == .@"2" and true))) { // TODO dual mode
                a.CR2.JSWSTART = 0b1;
            }
        }
        pub fn stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            const a = reg_adc();
            sys.tick.modify_until_done(
                _cctx,
                _rctx,
                1000,
                a.CR2_struct,
                a.CR2,
                comptime .{ .ADON = 0 },
                null,
            ) catch return Adc_Error.Adc_Modify_Time_Out;
        }

        pub fn calibration(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !u16 {
            const a = reg_adc();

            try stop(_cctx, _rctx);
            sys.tick.delay(_cctx, _rctx, comptime sys.tick.get_freq(_cctx) * 5 / get_freq(_cctx) + 1); // At least 2 adc cycles

            try regular_start(_cctx, _rctx);
            sys.tick.delay(_cctx, _rctx, comptime sys.tick.get_freq(_cctx) * 5 / get_freq(_cctx) + 1); // At least 2 adc cycles

            a.CR2.RSTCAL = 0b1;
            sys.tick.wait_until(
                _cctx,
                _rctx,
                1000,
                a.CR2_struct,
                a.CR2,
                "RSTCAL",
                0,
                null,
            ) catch return Adc_Error.Adc_Wait_Time_Out;

            a.CR2.CAL = 0b1;
            sys.tick.wait_until(
                _cctx,
                _rctx,
                1000,
                a.CR2_struct,
                a.CR2,
                "CAL",
                0,
                null,
            ) catch return Adc_Error.Adc_Wait_Time_Out;

            return a.DR.DATA;
        }

        inline fn u2t(comptime _T: type, _value: u16) _T {
            if (@bitSizeOf(_T) > 16) @compileError("Bitsize of type is more than 16");

            return @bitCast(@as(utils.u_bit(_T), @truncate(_value)));
        }

        inline fn get_max_cycles(comptime _cctx: Ct_Context) u32 {
            const cfg = get_ct_cfg(_cctx);
            comptime var cycles: u32 = 0;
            inline for (cfg.chs) |cc| {
                const ch_now = Ch(.{ .no = _no, .ch = cc.ch });
                cycles = @max(cycles, ch_now.smp_cycles(_cctx));
            }
            return cycles;
        }
        pub fn regular_read(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _T: type) !_T {
            const cfg = get_ct_cfg(_cctx);
            const a = reg_adc();

            if (cfg.scan == .disable and cfg.l == .@"1") {
                sys.tick.wait_until(
                    _cctx,
                    _rctx,
                    1000,
                    a.SR_struct,
                    a.SR,
                    "EOC",
                    0b1,
                    null,
                ) catch return Adc_Error.Adc_Wait_Time_Out;
            } else {
                const max_count = comptime get_freq(_cctx) * get_max_cycles(_cctx) / sys.tick.get_freq(_cctx) + 1;
                sys.tick.delay(_cctx, _rctx, max_count);
            }

            a.SR.EOC = 0;
            a.SR.STRT = 0;

            return u2t(_T, a.DR.DATA);
        }

        pub fn injected_read(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _T: type) ![]_T {
            const cfg = get_ct_cfg(_cctx);
            const a = reg_adc();
            var data: [4]_T = undefined;

            sys.tick.wait_until(
                _cctx,
                _rctx,
                1000,
                a.SR_struct,
                a.SR,
                "JEOC",
                0b1,
                null,
            ) catch return Adc_Error.Adc_Wait_Time_Out;

            a.SR.JEOC = 0;
            a.SR.JSTRT = 0;

            inline for (0..@intFromEnum(cfg.jl)) |i| data[i] = u2t(@field(a, ct_print("JDR{}", .{i})).JDATA);

            return data[0..cfg.jl];
        }

        pub inline fn regular_get(comptime _cctx: Ct_Context, _rctx: *Rt_Context) u16 {
            _ = _cctx;
            _ = _rctx;
            const a = reg_adc();
            return a.DR.DATA;
        }
        pub inline fn injected_get(comptime _cctx: Ct_Context, _rctx: *Rt_Context) []u16 {
            _ = _rctx;
            const cfg = get_ct_cfg(_cctx);
            const a = reg_adc();
            var data: [4]u16 = undefined;
            inline for (0..@intFromEnum(cfg.jl)) |i| data[i] = @field(a, ct_print("JDR{}", .{i})).JDATA;
            return data[0..cfg.jl];
        }

        pub inline fn it_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            set_it_enable_bit(_cctx, _rctx);
        }
        pub inline fn it_stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            clear_it_enable_bit(_cctx, _rctx);
        }

        pub fn regular_dma_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            const a = reg_adc();
            const rt_cfg = get_rt_cfg(_rctx);
            const dc = dma_ch();

            if (comptime get_dma_ch_config(_cctx)) |_| {
                if (rt_cfg) |src| {
                    if (src.adc_dma) |crc| {
                        const dcrc = dma.Ch_Rt_Config{
                            .ma = crc.ma,
                            .mem2mem = .disable,
                            .circ = crc.circ,
                            .minc = crc.minc,
                            .pinc = .disable,
                            .ndt = crc.ndt,
                            .pa = @intFromPtr(a.DR),
                            .msize = .@"16bit",
                            .psize = .@"16bit",
                        };
                        try dc.config(_cctx, _rctx, dcrc);
                        dc.start(_cctx, _rctx);
                        a.CR2.DMA = 0b1;
                    }
                }
            }
        }
        pub fn injected_dma_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            const a = reg_adc();
            const rt_cfg = get_rt_cfg(_rctx);
            const dc = dma_ch();

            if (comptime get_dma_ch_config(_cctx)) |_| {
                if (rt_cfg) |arc| {
                    if (arc.dma_cfg) |crc| {
                        const dcrc = dma.Ch_Rt_Config{
                            .ma = crc.ma,
                            .mem2mem = .disable,
                            .circ = crc.circ,
                            .minc = crc.minc,
                            .pinc = .enable,
                            .ndt = 4,
                            .pa = @intFromPtr(a.JDR1),
                            .msize = .@"16bit",
                            .psize = .@"16bit",
                        };
                        try dc.config(_cctx, _rctx, dcrc);
                        dc.start(_cctx, _rctx);
                        a.CR2.DMA = 0b1;
                    }
                }
            }
        }
        pub fn dma_stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            const a = reg_adc();
            if (comptime get_dma_ch_config(_cctx)) |_| {
                dma_ch().stop(_cctx, _rctx);
                a.CR2.DMA = 0;
            }
        }

        pub inline fn channel(comptime _ch: Pos.Channel) type {
            return Ch(.{ .no = _no, .ch = _ch });
        }
    };
}

pub const Ch_Ct_Config = struct {
    ch: Pos.Channel,
    target: Target,
    smp: Smp = .@"1.5cycle",

    pub const Smp = enum(u3) { @"1.5cycle", @"7.5cycle", @"13.5cycle", @"28.5cycle", @"41.5cycle", @"55.5cycle", @"71.5cycle", @"239.5cycle" };
    pub const Target = union(enum) {
        regular: RRank,
        injected: IRank,

        pub const RRank = enum(u4) { @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15" };
        pub const IRank = enum(u2) { @"0", @"1", @"2", @"3" };
    };
};
pub const Ch_Rt_Config = struct {};
pub const Adc_Ch_Error = error{
    Adc_Ch_Wait_Time_Out,
    Adc_Ch_Modify_Time_Out,
};

fn _Ch(comptime _Ct_Context: type, comptime _Rt_Context: type, comptime _pos: Pos) type {
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;
        pub fn reg_adc() type {
            return switch (_pos.no) {
                .@"1" => reg.ADC1,
                .@"2" => reg.ADC2,
            };
        }
        inline fn pin() type {
            return switch (_pos.no) {
                .@"1" => switch (_pos.ch) {
                    .@"0" => gpio.A.pin(.@"0"),
                    .@"1" => gpio.A.pin(.@"1"),
                    .@"2" => gpio.A.pin(.@"2"),
                    .@"3" => gpio.A.pin(.@"3"),
                    .@"4" => gpio.A.pin(.@"4"),
                    .@"5" => gpio.A.pin(.@"5"),
                    .@"6" => gpio.A.pin(.@"6"),
                    .@"7" => gpio.A.pin(.@"7"),
                    .@"8" => gpio.B.pin(.@"0"),
                    .@"9" => gpio.B.pin(.@"1"),
                    .@"10" => gpio.C.pin(.@"0"),
                    .@"11" => gpio.C.pin(.@"1"),
                    .@"12" => gpio.C.pin(.@"2"),
                    .@"13" => gpio.C.pin(.@"3"),
                    .@"14" => gpio.C.pin(.@"4"),
                    .@"15" => gpio.C.pin(.@"5"),
                    else => @compileError("In channel is not in gpio!"),
                },
                .@"2" => switch (_pos.ch) {
                    .@"0" => gpio.A.pin(.@"0"),
                    .@"1" => gpio.A.pin(.@"1"),
                    .@"2" => gpio.A.pin(.@"2"),
                    .@"3" => gpio.A.pin(.@"3"),
                    .@"4" => gpio.A.pin(.@"4"),
                    .@"5" => gpio.A.pin(.@"5"),
                    .@"6" => gpio.A.pin(.@"6"),
                    .@"7" => gpio.A.pin(.@"7"),
                    .@"8" => gpio.B.pin(.@"0"),
                    .@"9" => gpio.B.pin(.@"1"),
                    .@"10" => gpio.C.pin(.@"0"),
                    .@"11" => gpio.C.pin(.@"1"),
                    .@"12" => gpio.C.pin(.@"2"),
                    .@"13" => gpio.C.pin(.@"3"),
                    .@"14" => gpio.C.pin(.@"4"),
                    .@"15" => gpio.C.pin(.@"5"),
                    else => @compileError("In channel is not in gpio!"),
                },
            };
        }
        inline fn gpio_enable() void {
            switch (_pos.no) {
                .@"1" => switch (_pos.ch) {
                    .@"0" => gpio.A.enable(),
                    .@"1" => gpio.A.enable(),
                    .@"2" => gpio.A.enable(),
                    .@"3" => gpio.A.enable(),
                    .@"4" => gpio.A.enable(),
                    .@"5" => gpio.A.enable(),
                    .@"6" => gpio.A.enable(),
                    .@"7" => gpio.A.enable(),
                    .@"8" => gpio.B.enable(),
                    .@"9" => gpio.B.enable(),
                    .@"10" => gpio.C.enable(),
                    .@"11" => gpio.C.enable(),
                    .@"12" => gpio.C.enable(),
                    .@"13" => gpio.C.enable(),
                    .@"14" => gpio.C.enable(),
                    .@"15" => gpio.C.enable(),
                    else => {},
                },
                .@"2" => switch (_pos.ch) {
                    .@"0" => gpio.A.enable(),
                    .@"1" => gpio.A.enable(),
                    .@"2" => gpio.A.enable(),
                    .@"3" => gpio.A.enable(),
                    .@"4" => gpio.A.enable(),
                    .@"5" => gpio.A.enable(),
                    .@"6" => gpio.A.enable(),
                    .@"7" => gpio.A.enable(),
                    .@"8" => gpio.B.enable(),
                    .@"9" => gpio.B.enable(),
                    .@"10" => gpio.C.enable(),
                    .@"11" => gpio.C.enable(),
                    .@"12" => gpio.C.enable(),
                    .@"13" => gpio.C.enable(),
                    .@"14" => gpio.C.enable(),
                    .@"15" => gpio.C.enable(),
                    else => {},
                },
            }
        }
        pub inline fn enable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            Adc(_pos.no).enable(_cctx, _rctx);
            gpio_enable();
        }
        pub inline fn disable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;
        }

        pub inline fn get_ct_cfg(comptime _cctx: Ct_Context) Ch_Ct_Config {
            const cfg = comptime Adc(_pos.no).get_ct_cfg(_cctx);
            return comptime CH_CT_CFG: {
                for (cfg.chs) |chc| if (chc.ch == _pos.ch) break :CH_CT_CFG chc;
                @compileError("Not exsits in chs");
            };
        }
        pub inline fn get_rt_cfg(_rctx: *Rt_Context) ?Ch_Rt_Config {
            const cfg = Adc(_pos.no).get_rt_cfg(_rctx);
            return CH_RT_CFG: {
                if (cfg) |c| for (c.chs) |chc| if (chc.ch == _pos.ch) break :CH_RT_CFG chc;
                break :CH_RT_CFG null;
            };
        }

        pub inline fn get_pos() Pos {
            return _pos;
        }

        inline fn get_in_pin_config(comptime _cctx: Ct_Context) ?gpio.Pin_Ct_Config {
            const adc_cfg = comptime Adc(_pos.no).get_ct_cfg(_cctx);
            switch (_pos.ch) {
                .@"16", .@"17" => {
                    if (_pos.no != .@"1") @compileError("Sensor and Vref channel only exists in adc1!");
                    if (adc_cfg.tsvrefe == .disable) @compileError("Sensor and Vref channel is disable!");
                },
                else => {
                    return .{ .Input = .{ .mode = .Flt } };
                },
            }
            return null;
        }

        pub fn use(comptime _cctx: *_Ct_Context) void {
            if (get_in_pin_config(_cctx.*)) |cfg| pin().use(_cctx, cfg);
        }
        pub fn unuse(comptime _cctx: *_Ct_Context) void {
            if (get_in_pin_config(_cctx.*)) |_| pin().unuse(_cctx);
        }

        pub inline fn smp_cycles(comptime _cctx: Ct_Context) u32 {
            const cfg = comptime get_ct_cfg(_cctx);
            const scycles: comptime_int = (25 + switch (cfg.smp) {
                .@"1.5cycle" => 3,
                .@"7.5cycle" => 15,
                .@"13.5cycle" => 27,
                .@"28.5cycle" => 57,
                .@"41.5cycle" => 83,
                .@"55.5cycle" => 111,
                .@"71.5cycle" => 143,
                .@"239.5cycle" => 479,
            }) / 2; // 12.5 + smp

            return scycles;
        }

        pub fn config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            const adc_cfg = comptime Adc(_pos.no).get_ct_cfg(_cctx);
            const ch_cfg = comptime get_ct_cfg(_cctx);
            const a = reg_adc();
            enable(_cctx, _rctx);
            switch (ch_cfg.target) {
                .injected => |injected| {
                    try pin().config(_cctx, _rctx, .{ .Input = .{ .mode = .Flt } });
                    const rank = @intFromEnum(injected);
                    const l = @intFromEnum(adc_cfg.jl);
                    if (rank > l) @compileError("Rank out of Len!");

                    switch (injected) {
                        .@"0" => {
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.JSQR_struct,
                                a.JSQR,
                                .{ .SQ1 = @intFromEnum(_pos.ch) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.SMPR2_struct,
                                a.SMPR2,
                                .{ .SMP0 = @intFromEnum(ch_cfg.smp) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                        },
                        .@"1" => {
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.JSQR_struct,
                                a.JSQR,
                                .{ .SQ2 = @intFromEnum(_pos.ch) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.SMPR2_struct,
                                a.SMPR2,
                                .{ .SMP1 = @intFromEnum(ch_cfg.smp) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                        },
                        .@"2" => {
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.JSQR_struct,
                                a.JSQR,
                                .{ .SQ3 = @intFromEnum(_pos.ch) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.SMPR2_struct,
                                a.SMPR2,
                                .{ .SMP2 = @intFromEnum(ch_cfg.smp) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                        },
                        .@"3" => {
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.JSQR_struct,
                                a.JSQR,
                                .{ .SQ4 = @intFromEnum(_pos.ch) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.SMPR2_struct,
                                a.SMPR2,
                                .{ .SMP3 = @intFromEnum(ch_cfg.smp) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                        },
                    }
                },
                .regular => |regular| {
                    try pin().config(_cctx, _rctx, .{ .Input = .{ .mode = .Flt } });

                    const rank = @intFromEnum(regular);
                    const l = @intFromEnum(adc_cfg.l);
                    if (rank > l) @compileError("Rank out of Len!");

                    switch (regular) {
                        .@"0" => {
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.SQR3_struct,
                                a.SQR3,
                                comptime .{ .SQ1 = @intFromEnum(_pos.ch) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.SMPR2_struct,
                                a.SMPR2,
                                comptime .{ .SMP0 = @intFromEnum(ch_cfg.smp) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                        },
                        .@"1" => {
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.SQR3_struct,
                                a.SQR3,
                                comptime .{ .SQ2 = @intFromEnum(_pos.ch) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.SMPR2_struct,
                                a.SMPR2,
                                comptime .{ .SMP1 = @intFromEnum(ch_cfg.smp) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                        },
                        .@"2" => {
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.SQR3_struct,
                                a.SQR3,
                                comptime .{ .SQ3 = @intFromEnum(_pos.ch) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.SMPR2_struct,
                                a.SMPR2,
                                comptime .{ .SMP2 = @intFromEnum(ch_cfg.smp) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                        },
                        .@"3" => {
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.SQR3_struct,
                                a.SQR3,
                                comptime .{ .SQ4 = @intFromEnum(_pos.ch) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.SMPR2_struct,
                                a.SMPR2,
                                comptime .{ .SMP3 = @intFromEnum(ch_cfg.smp) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                        },
                        .@"4" => {
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.SQR3_struct,
                                a.SQR3,
                                comptime .{ .SQ5 = @intFromEnum(_pos.ch) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.SMPR2_struct,
                                a.SMPR2,
                                comptime .{ .SMP4 = @intFromEnum(ch_cfg.smp) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                        },
                        .@"5" => {
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.SQR3_struct,
                                a.SQR3,
                                comptime .{ .SQ6 = @intFromEnum(_pos.ch) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.SMPR2_struct,
                                a.SMPR2,
                                comptime .{ .SMP5 = @intFromEnum(ch_cfg.smp) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                        },
                        .@"6" => {
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.SQR2_struct,
                                a.SQR2,
                                comptime .{ .SQ7 = @intFromEnum(_pos.ch) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.SMPR2_struct,
                                a.SMPR2,
                                comptime .{ .SMP6 = @intFromEnum(ch_cfg.smp) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                        },
                        .@"7" => {
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.SQR2_struct,
                                a.SQR2,
                                comptime .{ .SQ8 = @intFromEnum(_pos.ch) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.SMPR2_struct,
                                a.SMPR2,
                                comptime .{ .SMP7 = @intFromEnum(ch_cfg.smp) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                        },
                        .@"8" => {
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.SQR2_struct,
                                a.SQR2,
                                comptime .{ .SQ9 = @intFromEnum(_pos.ch) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.SMPR2_struct,
                                a.SMPR2,
                                comptime .{ .SMP8 = @intFromEnum(ch_cfg.smp) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                        },
                        .@"9" => {
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.SQR2_struct,
                                a.SQR2,
                                comptime .{ .SQ10 = @intFromEnum(_pos.ch) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.SMPR2_struct,
                                a.SMPR2,
                                comptime .{ .SMP9 = @intFromEnum(ch_cfg.smp) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                        },
                        .@"10" => {
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.SQR2_struct,
                                a.SQR2,
                                comptime .{ .SQ11 = @intFromEnum(_pos.ch) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.SMPR1_struct,
                                a.SMPR1,
                                comptime .{ .SMP10 = @intFromEnum(ch_cfg.smp) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                        },
                        .@"11" => {
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.SQR2_struct,
                                a.SQR2,
                                comptime .{ .SQ12 = @intFromEnum(_pos.ch) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.SMPR1_struct,
                                a.SMPR1,
                                comptime .{ .SMP11 = @intFromEnum(ch_cfg.smp) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                        },
                        .@"12" => {
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.SQR1_struct,
                                a.SQR1,
                                comptime .{ .SQ13 = @intFromEnum(_pos.ch) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.SMPR1_struct,
                                a.SMPR1,
                                comptime .{ .SMP12 = @intFromEnum(ch_cfg.smp) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                        },
                        .@"13" => {
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.SQR1_struct,
                                a.SQR1,
                                comptime .{ .SQ14 = @intFromEnum(_pos.ch) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.SMPR1_struct,
                                a.SMPR1,
                                comptime .{ .SMP13 = @intFromEnum(ch_cfg.smp) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                        },
                        .@"14" => {
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.SQR1_struct,
                                a.SQR1,
                                comptime .{ .SQ15 = @intFromEnum(_pos.ch) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.SMPR1_struct,
                                a.SMPR1,
                                comptime .{ .SMP14 = @intFromEnum(ch_cfg.smp) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                        },
                        .@"15" => {
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.SQR1_struct,
                                a.SQR1,
                                comptime .{ .SQ16 = @intFromEnum(_pos.ch) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                            sys.tick.modify_until_done(
                                _cctx,
                                _rctx,
                                1000,
                                a.SMPR1_struct,
                                a.SMPR1,
                                comptime .{ .SMP15 = @intFromEnum(ch_cfg.smp) },
                                null,
                            ) catch return Adc_Ch_Error.Adc_Ch_Modify_Time_Out;
                        },
                    }
                },
            }
        }
    };
}

pub fn Adc(comptime _no: Pos.No) type {
    return adc.Adc(
        ctx.Ct_Context,
        ctx.Rt_Context,
        Adc_Ct_Config,
        Adc_Rt_Config,
        Pos,
        Adc_Error,
        _Adc,
        _no,
    );
}

pub fn Ch(comptime _pos: Pos) type {
    return adc.Ch(
        ctx.Ct_Context,
        ctx.Rt_Context,
        Ch_Ct_Config,
        Ch_Rt_Config,
        Pos,
        Adc_Ch_Error,
        _Ch,
        _pos,
    );
}
