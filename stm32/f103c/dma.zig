const reg = @import("reg.zig");
const gpio = @import("gpio.zig");
const sys = @import("sys.zig");
const ctx = @import("ctx.zig");
const it = @import("it.zig");
const std = @import("std");

const interface = @import("../stm32.zig").interface;
const dma = interface.dma;
const utils = interface.utils;

pub var dma_its: [NO_NUMS][CH_NUMS]?*const fn () void = .{.{null} ** CH_NUMS} ** NO_NUMS;

const ct_print = std.fmt.comptimePrint;

pub const @"1" = Dma(.@"1");

pub const NO_NUMS = @typeInfo(Pos.No).Enum.fields.len;
pub const CH_NUMS = @typeInfo(Pos.Channel).Enum.fields.len;
pub const Pos = struct {
    no: No,
    ch: Channel,
    pub const No = enum { @"1" };
    pub const Channel = enum { @"1", @"2", @"3", @"4", @"5", @"6", @"7" };
};

pub const Dma_Ct_Context: type = CONTEXT: {
    const __Context__std__ = @import("std");
    const __Context__StructField__ = __Context__std__.builtin.Type.StructField;
    const __Context__comptimePrint__ = __Context__std__.fmt.comptimePrint;
    break :CONTEXT @Type(.{
        .Struct = .{
            .layout = .auto,
            .is_tuple = false,
            .decls = &.{},
            .fields = FIELDS: {
                var fields: [NO_NUMS + 1]__Context__StructField__ = undefined;
                for (&fields, 1..) |*field, i| {
                    field.* = .{
                        .name = __Context__comptimePrint__("cfg{d}", .{i}),
                        .type = ?Dma_Ct_Config,
                        .default_value = @ptrCast(&@as(?Dma_Ct_Config, null)),
                        .is_comptime = false,
                        .alignment = @alignOf(?Dma_Ct_Config),
                    };
                }
                fields[NO_NUMS] = .{
                    .name = "cfgs",
                    .type = [NO_NUMS][CH_NUMS]?Ch_Ct_Config,
                    .default_value = @ptrCast(&@as([NO_NUMS][CH_NUMS]?Ch_Ct_Config, .{.{null} ** CH_NUMS} ** NO_NUMS)),
                    .is_comptime = false,
                    .alignment = @alignOf([NO_NUMS][CH_NUMS]?Ch_Ct_Config),
                };
                break :FIELDS &fields;
            },
        },
    });
};
pub const Dma_Rt_Context: type = CONTEXT: {
    const __Context__std__ = @import("std");
    const __Context__StructField__ = __Context__std__.builtin.Type.StructField;
    const __Context__comptimePrint__ = __Context__std__.fmt.comptimePrint;
    break :CONTEXT @Type(.{ .Struct = .{
        .layout = .auto,
        .is_tuple = false,
        .decls = &.{},
        .fields = FIELDS: {
            var fields: [NO_NUMS + 1]__Context__StructField__ = undefined;
            for (&fields, 1..) |*field, i| {
                field.* = .{
                    .name = __Context__comptimePrint__("cfg{d}", .{i}),
                    .type = ?Dma_Rt_Config,
                    .default_value = @ptrCast(&@as(?Dma_Rt_Config, null)),
                    .is_comptime = false,
                    .alignment = @alignOf(?Dma_Rt_Config),
                };
            }
            fields[NO_NUMS] = .{
                .name = "cfgs",
                .type = [NO_NUMS][CH_NUMS]?Ch_Rt_Config,
                .default_value = @ptrCast(&@as([NO_NUMS][CH_NUMS]?Ch_Rt_Config, .{.{null} ** CH_NUMS} ** NO_NUMS)),
                .is_comptime = false,
                .alignment = @alignOf([NO_NUMS][CH_NUMS]?Ch_Rt_Config),
            };
            break :FIELDS &fields;
        },
    } });
};

pub const Dma_Ct_Config = struct {
    chs: []Ch_Ct_Config = &.{},
};
pub const Dma_Rt_Config = struct {
    chs: []Ch_Rt_Config = &.{},
};
pub const Dma_Error = error{
    Dma_Wait_Time_Out,
    Dma_Modify_Time_Out,
    Rt_Config_Is_Null,
    Rt_Config_Chs_Not_Enough,
};

fn _Dma(comptime _Ct_Context: type, comptime _Rt_Context: type, comptime _no: Pos.No) type {
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;
        pub fn reg_dma() type {
            return switch (_no) {
                .@"1" => reg.DMA1,
            };
        }

        pub fn ahe_enable() void {
            switch (_no) {
                .@"1" => reg.RCC.AHBENR.DMA1EN = 0b1,
            }
        }
        pub fn ahe_disable() void {
            switch (_no) {
                .@"1" => reg.RCC.AHBENR.DMA1EN = 0,
            }
        }

        pub fn enable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;

            ahe_enable();
        }
        pub fn disable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;

            ahe_disable();
        }

        pub inline fn get_freq(comptime _cctx: Ct_Context, _rctx: *Rt_Context) u32 {
            return sys.clock.get_freq(_cctx, _rctx).hclk;
        }

        pub inline fn get_ct_cfg(comptime _cctx: Ct_Context) Dma_Ct_Config {
            return @field(_cctx.dma, "cfg" ++ @tagName(_no)).?;
        }
        pub inline fn get_rt_cfg(_rctx: *Rt_Context) ?Dma_Rt_Config {
            return @field(_rctx.dma, "cfg" ++ @tagName(_no));
        }

        pub fn use(_cctx: *_Ct_Context) void {
            const cfg = comptime get_ct_cfg(_cctx.*);
            for (cfg.chs) |cc| channel(cc.ch).use(_cctx, cc);
        }
        pub fn unuse(_cctx: *_Ct_Context) void {
            const cfg = comptime get_ct_cfg(_cctx.*);
            for (cfg.chs) |cc| channel(cc.ch).unuse(_cctx);
        }

        pub fn config(comptime _cctx: Ct_Context, _rctx: *Rt_Context) !void {
            const cfg = comptime get_ct_cfg(_cctx);
            const rt_cfg = get_rt_cfg(_rctx);
            inline for (cfg.chs, 0..) |cc, i| {
                if (rt_cfg == null) return Dma_Error.Rt_Config_Is_Null;
                if (rt_cfg.?.chs.len <= i) return Dma_Error.Rt_Config_Chs_Not_Enough;
                try Ch(.{ .no = _no, .ch = cc.ch }).config(_cctx, _rctx, rt_cfg.?.chs[i]);
            }
        }

        pub inline fn channel(comptime _ch: Pos.Channel) type {
            return Ch(.{ .no = _no, .ch = _ch });
        }
    };
}

pub const Ch_Ct_Config = struct {
    ch: Pos.Channel,

    dir: Dir = .peripheral,
    pl: Pl = .low,

    ch_it: ?Ch_It = null,

    pub const Dir = enum(u1) { peripheral, memory };
    pub const Pl = enum(u2) { low, mid, high, highest };

    pub const Ch_It = struct {
        gf: *const fn (comptime _ctx: ctx.Ct_Context) fn () void,
        nvic_cfg: it.Nvic_Config = .{},

        tcie: Tcie = .disable,
        htie: Htie = .disable,
        teie: Teie = .disable,

        pub const Tcie = enum(u1) { disable, enable };
        pub const Htie = enum(u1) { disable, enable };
        pub const Teie = enum(u1) { disable, enable };
    };
};
pub const Ch_Rt_Config = struct {
    pa: u32,
    ma: u32,
    ndt: u16,
    pinc: Pinc = .disable,
    minc: Minc = .disable,
    circ: Circ = .disable,
    mem2mem: Mem2mem = .disable,
    psize: Psize = .@"8bit",
    msize: Msize = .@"8bit",
    pub const Pinc = enum(u1) { disable, enable };
    pub const Minc = enum(u1) { disable, enable };
    pub const Circ = enum(u1) { disable, enable };
    pub const Mem2mem = enum(u1) { disable, enable };
    pub const Psize = enum(u2) { @"8bit", @"16bit", @"32bit" };
    pub const Msize = enum(u2) { @"8bit", @"16bit", @"32bit" };
};
pub const Dma_Ch_Error = error{
    Dma_Ch_Wait_Time_Out,
    Dma_Ch_Modify_Time_Out,
    Dma_Ch_Confliction_MEM2MEM_CIRC,
};

fn _Ch(comptime _Ct_Context: type, comptime _Rt_Context: type, comptime _pos: Pos) type {
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;
        pub fn reg_dma() type {
            return switch (_pos.no) {
                .@"1" => reg.DMA1,
            };
        }

        pub inline fn enable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            Dma(_pos.no).enable(_cctx, _rctx);
        }
        pub inline fn disable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;
        }

        pub inline fn get_ct_cfg(comptime _cctx: Ct_Context) Ch_Ct_Config {
            return _cctx.dma.cfgs[@intFromEnum(_pos.no)][@intFromEnum(_pos.ch)].?;
        }
        pub inline fn get_rt_cfg(_rctx: *Rt_Context) ?Ch_Rt_Config {
            return _rctx.dma.cfgs[@intFromEnum(_pos.no)][@intFromEnum(_pos.ch)];
        }
        pub inline fn get_pos() Pos {
            return _pos;
        }

        pub inline fn check_use(_cctx: *_Ct_Context) ?Ch_Ct_Config {
            return _cctx.dma.cfgs[@intFromEnum(_pos.no)][@intFromEnum(_pos.ch)];
        }
        pub inline fn assert_use(_cctx: *_Ct_Context) void {
            if (check_use(_cctx) != null) @compileError("Channel " ++ @tagName(_pos.ch) ++ " from DMA" ++ @tagName(_pos.no) ++ " had been used before!");
        }
        pub inline fn use(_cctx: *_Ct_Context, comptime _cfg: Ch_Ct_Config) void {
            assert_use(_cctx);
            _cctx.dma.cfgs[@intFromEnum(_pos.no)][@intFromEnum(_pos.ch)] = _cfg;
        }
        pub inline fn unuse(_cctx: *_Ct_Context) void {
            _cctx.dma.cfgs[@intFromEnum(_pos.no)][@intFromEnum(_pos.ch)] = null;
        }

        pub inline fn clear_it_flag(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;
            const d = reg_dma();
            const value = comptime @Type(.{ .Struct = .{
                .layout = .auto,
                .is_tuple = false,
                .decls = &.{},
                .fields = &[_]std.builtin.Type.StructField{
                    .{
                        .name = ct_print("CGIF{s}", .{@tagName(_pos.ch)}),
                        .type = u1,
                        .default_value = @ptrCast(&@as(u1, 0b1)),
                        .is_comptime = true,
                        .alignment = @alignOf(u1),
                    },
                    .{
                        .name = ct_print("CTCIF{s}", .{@tagName(_pos.ch)}),
                        .type = u1,
                        .default_value = @ptrCast(&@as(u1, 0b1)),
                        .is_comptime = true,
                        .alignment = @alignOf(u1),
                    },
                    .{
                        .name = ct_print("CHTIF{s}", .{@tagName(_pos.ch)}),
                        .type = u1,
                        .default_value = @ptrCast(&@as(u1, 0b1)),
                        .is_comptime = true,
                        .alignment = @alignOf(u1),
                    },
                    .{
                        .name = ct_print("CTEIF{s}", .{@tagName(_pos.ch)}),
                        .type = u1,
                        .default_value = @ptrCast(&@as(u1, 0b1)),
                        .is_comptime = true,
                        .alignment = @alignOf(u1),
                    },
                },
            } }){};
            _ = utils.modify(d.IFCR_struct, d.IFCR, value);
        }

        pub inline fn set_it_enable_bit(comptime _cctx: Ct_Context, _: *Rt_Context) void {
            const cfg = comptime get_ct_cfg(_cctx);
            const ci = cfg.ch_it.?;
            const d = reg_dma();

            _ = utils.modify(
                @field(d, "CCR" ++ @tagName(_pos.ch) ++ "_struct"),
                @field(d, "CCR" ++ @tagName(_pos.ch)),
                comptime .{
                    .TCIE = @intFromEnum(ci.tcie),
                    .HTIE = @intFromEnum(ci.htie),
                    .TEIE = @intFromEnum(ci.teie),
                },
            );
        }
        pub inline fn clear_it_enable_bit(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            _ = _cctx;
            _ = _rctx;
            const d = reg_dma();
            _ = utils.modify(
                @field(d, "CCR" ++ @tagName(_pos.ch) ++ "_struct"),
                @field(d, "CCR" ++ @tagName(_pos.ch)),
                comptime .{
                    .TCIE = 0,
                    .HTIE = 0,
                    .TEIE = 0,
                },
            );
        }

        inline fn config_it(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            const cfg = comptime get_ct_cfg(_cctx);
            if (cfg.ch_it) |ci| {
                const nvic = it.Nvic(.{
                    .ext = switch (_pos.no) {
                        .@"1" => switch (_pos.ch) {
                            .@"1" => reg.Interrupts.DMA1_Channel1,
                            .@"2" => reg.Interrupts.DMA1_Channel2,
                            .@"3" => reg.Interrupts.DMA1_Channel3,
                            .@"4" => reg.Interrupts.DMA1_Channel4,
                            .@"5" => reg.Interrupts.DMA1_Channel5,
                            .@"6" => reg.Interrupts.DMA1_Channel6,
                            .@"7" => reg.Interrupts.DMA1_Channel7,
                        },
                    },
                });
                clear_it_flag(_cctx, _rctx);
                dma_its[@intFromEnum(_pos.no)][@intFromEnum(_pos.ch)] = ci.gf(_cctx);
                nvic.set_priority(_cctx, _rctx, ci.nvic_cfg);
                nvic.enable(_cctx, _rctx);
            }
        }
        pub fn config(comptime _cctx: Ct_Context, _rctx: *Rt_Context, _rt_config: Ch_Rt_Config) !void {
            const d = reg_dma();
            const ct_cfg = comptime get_ct_cfg(_cctx);
            _rctx.dma.cfgs[@intFromEnum(_pos.no)][@intFromEnum(_pos.ch)] = _rt_config;
            enable(_cctx, _rctx);

            @field(d, "CCR" ++ @tagName(_pos.ch)).EN = 0;

            if (ct_cfg.ch != _pos.ch) @compileError("Wrong channel configuration!");
            if (_rt_config.mem2mem == .enable and _rt_config.circ == .enable) return Dma_Ch_Error.Dma_Ch_Confliction_MEM2MEM_CIRC;

            @field(d, "CMAR" ++ @tagName(_pos.ch)).MA = _rt_config.ma;
            @field(d, "CPAR" ++ @tagName(_pos.ch)).PA = _rt_config.pa;
            @field(d, "CNDTR" ++ @tagName(_pos.ch)).NDT = _rt_config.ndt;
            _ = utils.modify(
                @field(d, "CCR" ++ @tagName(_pos.ch) ++ "_struct"),
                @field(d, "CCR" ++ @tagName(_pos.ch)),
                comptime .{
                    .DIR = @intFromEnum(ct_cfg.dir),
                    .PL = @intFromEnum(ct_cfg.pl),
                },
            );
            _ = utils.rt_modify(
                @field(d, "CCR" ++ @tagName(_pos.ch) ++ "_struct"),
                @field(d, "CCR" ++ @tagName(_pos.ch)),
                .{
                    .MEM2MEM = @intFromEnum(_rt_config.mem2mem),
                    .CIRC = @intFromEnum(_rt_config.circ),
                    .PINC = @intFromEnum(_rt_config.pinc),
                    .MINC = @intFromEnum(_rt_config.minc),
                    .PSIZE = @intFromEnum(_rt_config.psize),
                    .MSIZE = @intFromEnum(_rt_config.msize),
                },
            );

            config_it(_cctx, _rctx);
        }
        pub inline fn start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            const d = reg_dma();
            clear_it_flag(_cctx, _rctx);
            set_it_enable_bit(_cctx, _rctx);
            @field(d, "CCR" ++ @tagName(_pos.ch)).EN = 0b1;
        }
        pub inline fn stop(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            const d = reg_dma();
            clear_it_flag(_cctx, _rctx);
            clear_it_enable_bit(_cctx, _rctx);
            @field(d, "CCR" ++ @tagName(_pos.ch)).EN = 0;
        }
    };
}

pub fn Dma(comptime _no: Pos.No) type {
    return dma.Dma(
        ctx.Ct_Context,
        ctx.Rt_Context,
        Dma_Ct_Config,
        Dma_Rt_Config,
        Pos,
        Dma_Error,
        _Dma,
        _no,
    );
}

pub fn Ch(comptime _pos: Pos) type {
    return dma.Ch(
        ctx.Ct_Context,
        ctx.Rt_Context,
        Ch_Ct_Config,
        Ch_Rt_Config,
        Pos,
        Dma_Ch_Error,
        _Ch,
        _pos,
    );
}
