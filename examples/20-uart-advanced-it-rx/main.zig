const std = @import("std");
const stm32 = @import("stm32");
const plugins = @import("plugins");

const utils = stm32.interface.utils;
const used_mcu = stm32.f103c;

const FixedBufferAllocator = std.heap.FixedBufferAllocator;

export const vector_table linksection(".vectors") = used_mcu.vector.vector_table;

// These symbols below come from the linker script
// user_stack
extern var __user_stack_start__: u32;
extern const __stack_size__: u32;
extern const __user_stack_end__: u32;
// user_heap
extern var __user_heap_start__: u32;
extern const __heap_size__: u32;
extern const __user_heap_end__: u32;
// data
extern const __data_loadaddr__: u32;
extern var __data_start__: u32;
extern const __data_end__: u32;
// bss
extern var __bss_start__: u32;
extern const __bss_end__: u32;

export fn _start() void {
    // Copy data from flash to RAM
    const data_loadaddr = @as([*]const u8, @ptrCast(&__data_loadaddr__));
    const data = @as([*]u8, @ptrCast(&__data_start__));
    const data_size = @intFromPtr(&__data_end__) - @intFromPtr(&__data_start__);
    for (data_loadaddr[0..data_size], 0..) |d, i| data[i] = d;

    // Clear the bss
    const bss = @as([*]u8, @ptrCast(&__bss_start__));
    const bss_size = @intFromPtr(&__bss_end__) - @intFromPtr(&__bss_start__);
    for (bss[0..bss_size]) |*b| b.* = 0;

    main();
    while (true) {}
}

var rt_ctx = used_mcu.ctx.Rt_Context{};
pub fn main() void {
    const sys_ctx: used_mcu.sys.Sys_Ct_Context = .{
        .clock_cfg = .{
            .lsi = .{ .enable = .{} },
            .hse = .{ .enable = .{} },
            .src = .{ .HSE = .{ .pre = .div1 } },
            .pllmul = .@"9",
            .hpre = .div1,
            .ppre1 = .div2,
            .ppre2 = .div1,
        },
        .tick_cfg = .{},
    };
    const single_cfgs: used_mcu.gpio.Gpio_Ct_Context.Single_Configs = @constCast(&[_]used_mcu.gpio.Gpio_Ct_Context.Single_Config{});
    const gpio_ctx = used_mcu.gpio.Gpio_Ct_Context{
        .single_cfgs = single_cfgs,
    };
    const uart_ctx: used_mcu.uart.Uart_Ct_Context = .{
        .cfg1 = .{
            .m = .@"8bit",
            .uart_it = .{
                .gf = uart1_rxne_it_gf,
                .rxneie = .enable,
            },
        },
    };
    comptime var ct_ctx = used_mcu.ctx.Ct_Context{
        .sys = sys_ctx,
        .gpio = gpio_ctx,
        .uart = uart_ctx,
    };
    _ = &ct_ctx;

    main_with_err(ct_ctx) catch {
        while (true) {}
    };
}

fn main_with_err(comptime _cctx: used_mcu.ctx.Ct_Context) !void {
    comptime var cctx = _cctx;
    const rctx = &rt_ctx;
    comptime used_mcu.ctx.use(&cctx);
    try used_mcu.ctx.config(cctx, rctx);

    var fixed_buffer_allocator = FixedBufferAllocator.init(@as([*]u8, @ptrCast(&__user_heap_start__))[0..__heap_size__]);
    defer fixed_buffer_allocator.reset();
    const allocator = fixed_buffer_allocator.allocator();

    const uart1 = used_mcu.uart.@"1";
    const reader = uart1_fifo.reader();

    uart1.it_start(cctx, rctx);

    while (true) {
        if (@atomicLoad(bool, &uart1_rx_finished, .acquire) == true) {
            const data = try reader.readAllAlloc(allocator, __heap_size__);
            defer allocator.free(data);

            @atomicStore(bool, &uart1_rx_finished, false, .release);
            uart1.it_start(cctx, rctx);
        }
    }
}

//gf part
const Kfifo_u8_256 = std.fifo.LinearFifo(u8, .{ .Static = 256 });

var uart1_fifo: Kfifo_u8_256 = Kfifo_u8_256.init();
var uart1_rx_finished: bool = false;
fn uart1_rxne_it_gf(comptime _cctx: used_mcu.ctx.Ct_Context) fn () void {
    const uart1 = used_mcu.uart.@"1";
    const u = uart1.reg_uart();
    return struct {
        pub fn f() void {
            defer uart1.clear_it_flag(_cctx, &rt_ctx);

            if (u.SR.RXNE == 0b1) {
                if (u.DR.DR == '\n') {
                    @atomicStore(bool, &uart1_rx_finished, true, .release);
                    uart1.it_stop(_cctx, &rt_ctx);
                } else {
                    uart1_fifo.writeItem(@truncate(u.DR.DR)) catch {};
                }
            }
        }
    }.f;
}
