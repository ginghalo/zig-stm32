const reg = @import("reg.zig");
const ctx = @import("ctx.zig");
const sys = @import("sys.zig");
const std = @import("std");
const ct_print = std.fmt.comptimePrint;

const interface = @import("../stm32.zig").interface;
const it = interface.it;

pub const Nvic_Config = struct {
    pri: u4 = 0xF,
};
pub const Interrupt_Type = union(enum) {
    sys: Sys_Interrupt,
    ext: reg.Interrupts,
    pub const Sys_Interrupt = enum(u8) {
        mem_fault = 12,
        bus_fault = 11,
        usage_fault = 10,
        svcall = 5,
        dbg_monitor = 4,
        pendsv = 2,
        systick = 1,
    };
};
pub const Exti_Config = struct {
    imr: Imr = .disable,
    emr: Emr = .disable,
    ftsr: Ftsr = .disable,
    rtsr: Rtsr = .disable,

    pub const Imr = enum(u1) { disable, enable };
    pub const Emr = enum(u1) { disable, enable };
    pub const Ftsr = enum(u1) { disable, enable };
    pub const Rtsr = enum(u1) { disable, enable };
};

pub const Line = enum { @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18" };

fn _Exti(comptime _Ct_Context: type, comptime _Rt_Context: type, comptime _line: Line) type {
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;

        pub fn enable(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _cfg: Exti_Config) void {
            @field(reg.EXTI.IMR, "MR" ++ @tagName(_line)) = comptime @intFromEnum(_cfg.imr);
            @field(reg.EXTI.EMR, "MR" ++ @tagName(_line)) = comptime @intFromEnum(_cfg.emr);
            @field(reg.EXTI.FTSR, "TR" ++ @tagName(_line)) = comptime @intFromEnum(_cfg.ftsr);
            @field(reg.EXTI.RTSR, "TR" ++ @tagName(_line)) = comptime @intFromEnum(_cfg.rtsr);
            clear_pr(_cctx, _rctx);
        }
        pub fn swi_start(comptime _: _Ct_Context, _: *_Rt_Context) void {
            @field(reg.EXTI.SWIER, "SWIER" ++ @tagName(_line)) = 0b1;
        }
        pub fn clear_pr(comptime _: _Ct_Context, _: *_Rt_Context) void {
            @field(reg.EXTI.PR, "PR" ++ @tagName(_line)) = 0b1; // clearing it by writing `0b1`. Weird, isn't it?
        }
    };
}
fn _Nvic(comptime _Ct_Context: type, comptime _Rt_Context: type, comptime _it: Interrupt_Type) type {
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;

        pub fn enable(comptime _: _Ct_Context, _: *_Rt_Context) void {
            switch (_it) {
                .sys => {},
                .ext => |irqn| {
                    const irqn_u8 = @intFromEnum(irqn);
                    if (irqn_u8 < 32) {
                        reg.NVIC.ISER0.SETENA |= comptime 1 << irqn_u8;
                    } else {
                        reg.NVIC.ISER1.SETENA |= comptime 1 << (irqn_u8 - 32);
                    }
                },
            }
        }
        pub fn disable(comptime _: _Ct_Context, _: *_Rt_Context) void {
            switch (_it) {
                .sys => {},
                .ext => |irqn| {
                    const irqn_u8 = comptime @intFromEnum(irqn);
                    if (irqn_u8 < 32) {
                        reg.NVIC.ICER0.CLRENA |= comptime 1 << irqn_u8;
                    } else {
                        reg.NVIC.ICER1.CLRENA |= comptime 1 << (irqn_u8 - 32);
                    }
                },
            }
        }

        inline fn get_priority_group() u3 {
            return 0;
        }
        inline fn get_priority_ubit() type {
            return u4;
        }
        pub fn set_priority(comptime _: _Ct_Context, _: *_Rt_Context, comptime _cfg: Nvic_Config) void {
            switch (_it) {
                .sys => |irqn| {
                    const irqn_u8 = @intFromEnum(irqn);
                    switch (irqn) {
                        .systick => reg.SCB.SHPR3.PRI_15 = comptime irqn_u8 << 4,
                        .pendsv => reg.SCB.SHPR3.PRI_14 = comptime irqn_u8 << 4,
                        // .dbg_monitor => reg.SCB.SHPR3.PRI_12 = comptime irqn_u8 << 4,
                        .dbg_monitor => {},
                        .svcall => reg.SCB.SHPR2.PRI_11 = comptime irqn_u8 << 4,
                        .usage_fault => reg.SCB.SHPR1.PRI_6 = comptime irqn_u8 << 4,
                        .bus_fault => reg.SCB.SHPR1.PRI_5 = comptime irqn_u8 << 4,
                        .mem_fault => reg.SCB.SHPR1.PRI_4 = comptime irqn_u8 << 4,
                    }
                },
                .ext => |irqn| {
                    const irqn_u8 = @intFromEnum(irqn);
                    @field(
                        @field(
                            reg.NVIC,
                            ct_print("IPR{}", .{irqn_u8 >> 2}),
                        ),
                        ct_print("IPR_N{}", .{irqn_u8 & 0x3}),
                    ) = comptime @as(u8, _cfg.pri) << 4;
                },
            }
        }
        // pub fn disable_irq() void {
        //     var cpsr: u32 = undefined;
        //     asm volatile ("mrs %[cpsr], primask\n" ++ "cpsid i\n"
        //         : [cpsr] "=r" (cpsr),
        //     );
        // }
        // pub fn enable_irq() void {
        //     asm volatile ("cpsie i");
        // }
    };
}

pub fn Exti(comptime _line: Line) type {
    return it.Exti(
        ctx.Ct_Context,
        ctx.Rt_Context,
        Exti_Config,
        Exti_Config,
        Line,
        _Exti,
        _line,
    );
}
pub fn Nvic(comptime _it: Interrupt_Type) type {
    return it.Nvic(
        ctx.Ct_Context,
        ctx.Rt_Context,
        Nvic_Config,
        Nvic_Config,
        Interrupt_Type,
        _Nvic,
        _it,
    );
}
