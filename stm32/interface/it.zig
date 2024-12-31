pub fn Exti(
    comptime _Ct_Context: type,
    comptime _Rt_Context: type,
    comptime _Ct_Config: type,
    comptime _Rt_Config: type,
    comptime _Line: type,
    comptime _exti_fn: fn (comptime _Ct_Context: type, comptime _Rt_Context: type, comptime _line: _Line) type,
    comptime _line: _Line,
) type {
    const e = _exti_fn(_Ct_Context, _Rt_Context, _line);
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;
        pub const Ct_Config = _Ct_Config;
        pub const Rt_Config = _Rt_Config;
        pub const Line = _Line;
        pub fn enable(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _cfg: Ct_Config) void {
            e.enable(_cctx, _rctx, _cfg);
        }
        pub fn swi_start(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            e.swi_start(_cctx, _rctx);
        }
        pub fn clear_pr(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            e.clear_pr(_cctx, _rctx);
        }
    };
}
pub fn Nvic(
    comptime _Ct_Context: type,
    comptime _Rt_Context: type,
    comptime _Ct_Config: type,
    comptime _Rt_Config: type,
    comptime _Interrupt_Type: type,
    comptime _nvic_fn: fn (comptime _Ct_Context: type, comptime _Rt_Context: type, comptime _it: _Interrupt_Type) type,
    comptime _it: _Interrupt_Type,
) type {
    const n = _nvic_fn(_Ct_Context, _Rt_Context, _it);
    return struct {
        pub const Ct_Context = _Ct_Context;
        pub const Rt_Context = _Rt_Context;
        pub const Ct_Config = _Ct_Config;
        pub const Rt_Config = _Rt_Config;
        pub const Interrupt_Type = _Interrupt_Type;
        pub fn enable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            n.enable(_cctx, _rctx);
        }
        pub fn disable(comptime _cctx: Ct_Context, _rctx: *Rt_Context) void {
            n.disable(_cctx, _rctx);
        }
        pub fn set_priority(comptime _cctx: Ct_Context, _rctx: *Rt_Context, comptime _cfg: Ct_Config) void {
            n.set_priority(_cctx, _rctx, _cfg);
        }
    };
}

// pub fn disable_irq() void {
//     n.disable_irq();
// }
// pub fn enable_irq() void {
//     n.enable_irq();
// }
