const ctx = @import("ctx.zig");
// These two are the default empty implementations for exception handlers
export fn blocking_it() void {
    while (true) {}
}

export fn null_it() void {}

// This comes from the linker script and represents the initial stack pointer address.
// Not a function, but pretend it is to suppress type error
extern fn _stack() void;

// Launch in reset of mcu
// Implements in file 'main.zig'
extern fn _start() void;
// System Interrupt
export fn nmi_it() void {
    ctx.reg.RCC.CIR.CSSC = 0b1;
}
export fn hardFault_it() void {}
export fn memoryManagementFault_it() void {}
export fn busFault_it() void {}
export fn usageFault_it() void {}
export fn svCall_it() void {}
export fn debugMonitor_it() void {}
export fn pendSV_it() void {}
export fn systick_it() void {
    if (ctx.sys.systick_it) |it| it();
}
// Extern Interrupt
export fn wwdg_it() void {
    if (ctx.wdg.wwdg_it) |it| it();
}
export fn pvdg_it() void {
    if (ctx.pbr.pvdg_it) |it| it();
}
export fn tamper_it() void {
    if (ctx.pbr.tamper_it) |it| it();
}
export fn rtc_it() void {
    if (ctx.pbr.rtc_its.rtc_it) |it| it();
}
export fn flash_it() void {}
export fn rcc_it() void {
    if (ctx.sys.rcc_it) |it| it();
}
export fn exti0_it() void {
    if (ctx.gpio.pin_its[0]) |it| it();
}
export fn exti1_it() void {
    if (ctx.gpio.pin_its[1]) |it| it();
}
export fn exti2_it() void {
    if (ctx.gpio.pin_its[2]) |it| it();
}
export fn exti3_it() void {
    if (ctx.gpio.pin_its[3]) |it| it();
}
export fn exti4_it() void {
    if (ctx.gpio.pin_its[4]) |it| it();
}
export fn dma1c1_it() void {
    if (ctx.dma.dma_its[0][0]) |it| it();
}
export fn dma1c2_it() void {
    if (ctx.dma.dma_its[0][1]) |it| it();
}
export fn dma1c3_it() void {
    if (ctx.dma.dma_its[0][2]) |it| it();
}
export fn dma1c4_it() void {
    if (ctx.dma.dma_its[0][3]) |it| it();
}
export fn dma1c5_it() void {
    if (ctx.dma.dma_its[0][4]) |it| it();
}
export fn dma1c6_it() void {
    if (ctx.dma.dma_its[0][5]) |it| it();
}
export fn dma1c7_it() void {
    if (ctx.dma.dma_its[0][6]) |it| it();
}
export fn adc1_2_it() void {
    if (ctx.adc.adc_its[0]) |it| it();
    if (ctx.adc.adc_its[1]) |it| it();
}
export fn usb_hp_can_tx_it() void {}
export fn usb_lp_can_rx0_it() void {}
export fn can1_rx1_it() void {}
export fn can1_sce_it() void {}
export fn exti9_5_it() void {
    if (ctx.gpio.pin_its[5]) |it| it();
    if (ctx.gpio.pin_its[6]) |it| it();
    if (ctx.gpio.pin_its[7]) |it| it();
    if (ctx.gpio.pin_its[8]) |it| it();
    if (ctx.gpio.pin_its[9]) |it| it();
}
export fn tim1_brk_it() void {
    if (ctx.tim.tim_its.tim1_brk) |it| it();
}
export fn tim1_up_it() void {
    if (ctx.tim.tim_its.tim1_up) |it| it();
}
export fn tim1_trg_com_it() void {
    if (ctx.tim.tim_its.tim1_trg_com) |it| it();
}
export fn tim1_cc_it() void {
    if (ctx.tim.tim_its.tim1_cc) |it| it();
}
export fn tim2_it() void {
    if (ctx.tim.tim_its.tim2) |it| it();
}
export fn tim3_it() void {
    if (ctx.tim.tim_its.tim3) |it| it();
}
export fn tim4_it() void {
    if (ctx.tim.tim_its.tim4) |it| it();
}
export fn i2c1_ev_it() void {
    if (ctx.i2c.i2c_its[0].ev_it) |it| it();
}
export fn i2c1_er_it() void {
    if (ctx.i2c.i2c_its[0].err_it) |it| it();
}
export fn i2c2_ev_it() void {
    if (ctx.i2c.i2c_its[1].ev_it) |it| it();
}
export fn i2c2_er_it() void {
    if (ctx.i2c.i2c_its[1].err_it) |it| it();
}
export fn spi1_it() void {
    if (ctx.spi.spi_its[0]) |it| it();
}
export fn spi2_it() void {
    if (ctx.spi.spi_its[1]) |it| it();
}
export fn usart1_it() void {
    if (ctx.uart.uart_its[0]) |it| it();
}
export fn usart2_it() void {
    if (ctx.uart.uart_its[1]) |it| it();
}
export fn usart3_it() void {
    if (ctx.uart.uart_its[2]) |it| it();
}
export fn exti15_10_it() void {
    if (ctx.gpio.pin_its[10]) |it| it();
    if (ctx.gpio.pin_its[11]) |it| it();
    if (ctx.gpio.pin_its[12]) |it| it();
    if (ctx.gpio.pin_its[13]) |it| it();
    if (ctx.gpio.pin_its[14]) |it| it();
    if (ctx.gpio.pin_its[15]) |it| it();
}
export fn rtcAlarm_it() void {
    if (ctx.pbr.rtc_its.rtc_alarm_it) |it| it();
}
export fn usb_wkup_it() void {}
export fn tim8_brk_it() void {}
export fn tim8_up_it() void {}
export fn tim8_trg_com_it() void {}
export fn tim8_cc_it() void {}
export fn adc3_it() void {}
export fn fsmc_it() void {}
export fn sdio_it() void {}
export fn tim5_it() void {}
export fn spi3_it() void {}
export fn usart4_it() void {}
export fn usart5_it() void {}
export fn tim6_it() void {}
export fn tim7_it() void {}
export fn dma2c1_it() void {}
export fn dma2c2_it() void {}
export fn dma2c3_it() void {}
export fn dma2c4_5_it() void {}
// The vector table
pub const vector_table = [_]*allowzero const fn () callconv(.C) void{
    // system vector
    _stack,
    _start, // Reset
    nmi_it, // NMI
    hardFault_it, // Hard fault
    memoryManagementFault_it, // Memory management fault
    busFault_it, // Bus fault
    usageFault_it, // Usage fault
    @ptrFromInt(0), // Reserved 1
    @ptrFromInt(0), // Reserved 2
    @ptrFromInt(0), // Reserved 3
    @ptrFromInt(0), // Reserved 4
    svCall_it, // SVCall
    debugMonitor_it, // Debug monitor
    @ptrFromInt(0), // Reserved 5
    pendSV_it, // PendSV
    systick_it, // SysTick
    // external vector
    wwdg_it,
    pvdg_it,
    tamper_it,
    rtc_it,
    flash_it,
    rcc_it,
    exti0_it,
    exti1_it,
    exti2_it,
    exti3_it,
    exti4_it,
    dma1c1_it,
    dma1c2_it,
    dma1c3_it,
    dma1c4_it,
    dma1c5_it,
    dma1c6_it,
    dma1c7_it,
    adc1_2_it,
    usb_hp_can_tx_it,
    usb_lp_can_rx0_it,
    can1_rx1_it,
    can1_sce_it,
    exti9_5_it,
    tim1_brk_it,
    tim1_up_it,
    tim1_trg_com_it,
    tim1_cc_it,
    tim2_it,
    tim3_it,
    tim4_it,
    i2c1_ev_it,
    i2c1_er_it,
    i2c2_ev_it,
    i2c2_er_it,
    spi1_it,
    spi2_it,
    usart1_it,
    usart2_it,
    usart3_it,
    exti15_10_it,
    rtcAlarm_it,
    usb_wkup_it,
    tim8_brk_it,
    tim8_up_it,
    tim8_trg_com_it,
    tim8_cc_it,
    adc3_it,
    fsmc_it,
    sdio_it,
    tim5_it,
    spi3_it,
    usart4_it,
    usart5_it,
    tim6_it,
    tim7_it,
    dma2c1_it,
    dma2c2_it,
    dma2c3_it,
    dma2c4_5_it,
};
