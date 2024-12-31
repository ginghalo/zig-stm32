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
    const i2c_ctx: used_mcu.i2c.I2c_Ct_Context = .{
        .cfg1 = .{
            .addr = .{
                .@"7bit" = .{
                    .addr1 = 0x64,
                },
            },
            .i2c_it = .{
                .ev_it = .{
                    .gf = i2c1_ev_it_gf,
                },
                .iteven = .enable,
                .itbufen = .enable,
            },
        },
    };
    comptime var ct_ctx = used_mcu.ctx.Ct_Context{
        .sys = sys_ctx,
        .gpio = gpio_ctx,
        .i2c = i2c_ctx,
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

    const i2c1 = used_mcu.i2c.@"1";

    try i2c1.slave_it_start(cctx, rctx);

    while (true) {}
}

//gf part
const Kfifo_u8_256 = std.fifo.LinearFifo(u8, .{ .Static = 256 });
const Slave_mode = enum(u2) { receiver, transmitter, none };

var i2c1_fifo: Kfifo_u8_256 = Kfifo_u8_256.init();
var i2c1_slave_mode: Slave_mode = .none;
var i2c1_tx_finished: bool = false;
var i2c1_rx_finished: bool = false;
fn i2c1_ev_it_gf(comptime _cctx: used_mcu.ctx.Ct_Context) fn () void {
    const i2c1 = used_mcu.i2c.@"1";
    const i = i2c1.reg_i2c();
    return struct {
        inline fn read_DR() void {
            if (i2c1_fifo.readableLength() == i2c1_fifo.buf.len) i2c1_fifo.discard(1);
            i2c1_fifo.writeItem(i.DR.DR) catch {};
        }
        inline fn write_DR() void {
            i.DR.DR = if (i2c1_fifo.readItem()) |fifo_item| fifo_item else 0;
        }
        pub fn f() void {
            if (i.SR2.MSL == 0b1) return; // This interrupt only is used when it's slave mode
            defer i2c1.clear_it_flag(_cctx, &rt_ctx);
            @atomicStore(bool, &i2c1_rx_finished, false, .release);
            @atomicStore(bool, &i2c1_tx_finished, false, .release);
            // EV1
            if (i.SR1.ADDR == 0b1) {
                i2c1_slave_mode = @enumFromInt(i.SR2.TRA);
                i.SR1.ADDR = 0;
            }
            // EV2
            if (i.SR1.RxNE == 0b1) {
                read_DR();
            }
            // EV3-1
            if (i.SR1.TxE == 0b1) {
                write_DR();
            }
            // EV3
            if (i.SR1.BTF == 0b1) {
                if (i2c1_slave_mode == .none) i2c1_slave_mode = @enumFromInt(i.SR2.TRA);
                switch (i2c1_slave_mode) {
                    .receiver => read_DR(),
                    .transmitter => write_DR(),
                    .none => {},
                }
            }
            // EV3-2
            if (i.SR1.AF == 0b1) {
                i.SR1.AF = 0;
                i.CR1.ACK = 0;
                @atomicStore(bool, &i2c1_tx_finished, true, .release);
                @atomicStore(Slave_mode, &i2c1_slave_mode, .none, .release);
            }
            // EV4
            if (i.SR1.STOPF == 0b1) {
                i.SR1.STOPF = 0;
                i.CR1.ACK = 0;
                @atomicStore(bool, &i2c1_rx_finished, true, .release);
                @atomicStore(Slave_mode, &i2c1_slave_mode, .none, .release);
            }
        }
    }.f;
}
