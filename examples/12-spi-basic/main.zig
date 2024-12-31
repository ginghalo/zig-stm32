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
    const single_cfgs: used_mcu.gpio.Gpio_Ct_Context.Single_Configs = @constCast(&[_]used_mcu.gpio.Gpio_Ct_Context.Single_Config{
        .{
            .pos = .{ .port = .A, .no = .@"4" },
            .pin_config = .{
                .Output = .{
                    .mode = .PP,
                    .speed = .@"50MHz",
                    .level = .high,
                },
            },
        },
    });
    const gpio_ctx = used_mcu.gpio.Gpio_Ct_Context{
        .single_cfgs = single_cfgs,
    };
    const spi_ctx: used_mcu.spi.Spi_Ct_Context = .{
        .cfg1 = .{
            .mstr = .master,
            .cpol = .high,
            .cpha = .second,
            .ssm = .enable,
            .ssi = .high,
        },
        .cfg2 = .{
            .mstr = .master,
            .cpol = .low,
            .cpha = .first,
            .ssm = .disable,
            .ssoe = .enable,
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

    const spi1 = used_mcu.spi.@"1";
    const spi2 = used_mcu.spi.@"2";
    const spi1_nss = used_mcu.gpio.A.pin(.@"4");
    const Spi_writer_ctx = struct {
        pub const Spi_writer_ctx = @This();
        pub fn write(_log_ctx: Spi_writer_ctx, _bytes: []const u8) used_mcu.spi.Error!usize {
            _ = _log_ctx;
            spi1_nss.ct_set(cctx, rctx, 0);
            try spi1.write(cctx, rctx, u8, _bytes);
            spi1_nss.ct_set(cctx, rctx, 1);
            try spi2.write(cctx, rctx, u8, _bytes);
            return _bytes.len;
        }
    };
    const Spi_reader_ctx = struct {
        pub const Spi_reader_ctx = @This();
        pub fn read(_log_ctx: Spi_reader_ctx, _bytes: []u8) used_mcu.spi.Error!usize {
            _ = _log_ctx;
            spi1_nss.ct_set(cctx, rctx, 0);
            try spi1.read(cctx, rctx, u8, _bytes);
            spi1_nss.ct_set(cctx, rctx, 1);
            try spi2.write_read(cctx, rctx, u8, _bytes, _bytes);
            return _bytes.len;
        }
    };
    const spi_writer = std.io.GenericWriter(Spi_writer_ctx, used_mcu.spi.Error, Spi_writer_ctx.write){ .context = Spi_writer_ctx{} };
    const spi_reader = std.io.GenericReader(Spi_reader_ctx, used_mcu.spi.Error, Spi_reader_ctx.read){ .context = Spi_reader_ctx{} };

    const str = "Hello World!";

    const data = try allocator.alloc(u8, 32);
    defer allocator.free(data);
    @memset(data, 0xFF);

    spi1_nss.ct_set(cctx, rctx, 0);
    try spi1.write(cctx, rctx, u8, str);
    spi1_nss.ct_set(cctx, rctx, 1);
    try spi2.write_read(cctx, rctx, u8, data, str);
    try spi_writer.print("{s}\n", .{str});
    const read_data = try spi_reader.readAllAlloc(allocator, std.math.maxInt(usize));
    defer allocator.free(read_data);

    while (true) {}
}
