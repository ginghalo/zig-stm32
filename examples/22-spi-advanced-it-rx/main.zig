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
    const spi_ctx: used_mcu.spi.Spi_Ct_Context = .{
        .cfg1 = .{
            .mstr = .slave,
            .cpol = .high,
            .cpha = .second,
            .ssm = .enable,
            .ssi = .low,
            .spi_it = .{
                .gf = spi1_it_gf,
                .rxneie = .enable,
            },
        },
    };
    comptime var ct_ctx = used_mcu.ctx.Ct_Context{
        .sys = sys_ctx,
        .gpio = gpio_ctx,
        .spi = spi_ctx,
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

    const data = try allocator.alloc(u8, 32);
    defer allocator.free(data);
    @memset(data, 0xFF);

    const spi1 = used_mcu.spi.@"1";
    const spi1_nss = used_mcu.gpio.A.pin(.@"4");

    var spi1_rx_str: [256]u8 = undefined;
    var spi1_rx_str_len: usize = 0;

    spi1.it_start(cctx, rctx);

    while (true) {
        if (@atomicLoad(bool, &spi1_rx_started, .acquire) == true) {
            var byte = @atomicLoad(u8, &spi1_rx_first_byte, .acquire);
            while (spi1_nss.get(cctx, rctx) == 0) : (byte += 1) {
                var spi1_byte: [1]u8 = .{byte};
                try spi1.read(_cctx, rctx, u8, &spi1_byte);
                try spi1_fifo.write(&spi1_byte);
            }

            spi1_rx_str_len = spi1_fifo.read(&spi1_rx_str);
            spi1_rx_first_byte = 0xFF;
            spi1.it_start(cctx, rctx);
        }
    }
}

// gf part
const Kfifo_u8_256 = std.fifo.LinearFifo(u8, .{ .Static = 256 });

var spi1_fifo: Kfifo_u8_256 = Kfifo_u8_256.init();
var spi1_rx_started: bool = false;
var spi1_rx_first_byte: u8 = 0xFF;
fn spi1_it_gf(comptime _cctx: used_mcu.ctx.Ct_Context) fn () void {
    const spi1 = used_mcu.spi.@"1";
    const spi1_cfg = comptime spi1.get_ct_cfg(_cctx);
    return struct {
        pub fn f() void {
            defer spi1.clear_it_flag(_cctx, &rt_ctx);

            const s = spi1.reg_spi();
            if (s.SR.RXNE == 0b1) {
                spi1_rx_first_byte = @truncate(s.DR.DR);
                s.DR.DR = comptime switch (spi1_cfg.dff) {
                    .@"16bit" => 0xFFFF,
                    .@"8bit" => 0xFF,
                };
                spi1.it_stop(_cctx, &rt_ctx);
            }
        }
    }.f;
}
