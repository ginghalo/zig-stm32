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
        .cfg1 = .{},
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

    const tx_addr: u7 = 0x64;
    // const tx_mem_addr: u8 = 0x00;

    const i2c1 = used_mcu.i2c.@"1";
    const I2c_log_ctx = struct {
        pub const I2c_log_ctx = @This();
        pub fn write(_log_ctx: I2c_log_ctx, _bytes: []const u8) used_mcu.i2c.Error!usize {
            _ = _log_ctx;
            try i2c1.master_write(cctx, rctx, .@"7bit", tx_addr, u8, _bytes);
            // try i2c1.mem_write(cctx, rctx, .@"7bit", 0x00, .@"8bit", tx_addr, u8, _bytes);
            return _bytes.len;
        }
    };
    const I2c_reader_ctx = struct {
        pub const I2c_reader_ctx = @This();
        pub fn read(_log_ctx: I2c_reader_ctx, _bytes: []u8) used_mcu.i2c.Error!usize {
            _ = _log_ctx;
            try i2c1.master_read(cctx, rctx, .@"7bit", tx_addr, u8, _bytes);
            // try i2c1.mem_read(cctx, rctx, .@"7bit", tx_addr, .@"8bit", tx_mem_addr, u8, _bytes);
            return _bytes.len;
        }
    };
    const i2c1_log = std.io.GenericWriter(I2c_log_ctx, i2c1.Error, I2c_log_ctx.write){ .context = I2c_log_ctx{} };
    const i2c1_reader = std.io.GenericReader(I2c_reader_ctx, i2c1.Error, I2c_reader_ctx.read){ .context = I2c_reader_ctx{} };

    const str = "Hello World!";

    _ = try i2c1.master_write(cctx, rctx, .@"7bit", tx_addr, u8, str);
    _ = try i2c1.master_read(cctx, rctx, .@"7bit", tx_addr, u8, data);
    // try i2c1.mem_write(cctx, rctx, .@"7bit", tx_addr, .@"8bit", tx_mem_addr, u8, str);
    // try i2c1.mem_read(cctx, rctx, .@"7bit", tx_addr, .@"8bit", tx_mem_addr, u8, data);
    try i2c1_log.print("{s}\n", .{str});
    const read_data = try i2c1_reader.readAllAlloc(allocator, std.math.maxInt(usize));
    defer allocator.free(read_data);

    while (true) {}
}