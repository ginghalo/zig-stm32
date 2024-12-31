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
            .ssoe = .disable,
            .spi_dma = .{
                .tx_cfg = .{
                    .it = .{
                        .gf = spi_tx_dma_it_gf,
                        .htie = .disable,
                        .tcie = .enable,
                    },
                },
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

    const data = try allocator.alloc(u8, 36);
    defer allocator.free(data);
    @memset(data, 0xAA);

    const tick = used_mcu.sys.tick;
    const spi1 = used_mcu.spi.@"1";
    const nss = used_mcu.gpio.A.pin(.@"4");
    const s = spi1.reg_spi();
    const Spi_writer_ctx = struct {
        pub const Spi_writer_ctx = @This();
        pub fn write(_log_ctx: Spi_writer_ctx, _bytes: []const u8) !usize {
            rctx.spi = .{
                .cfg1 = .{
                    .tx_cfg = .{
                        .ma = @intFromPtr(_bytes.ptr),
                        .ndt = @truncate(_bytes.len),
                        .circ = .disable,
                        .minc = .enable,
                    },
                },
            };
            _ = _log_ctx;
            tick.wait_until(
                _cctx,
                rctx,
                10_000,
                s.SR_struct,
                s.SR,
                "BSY",
                0,
                null,
            ) catch return used_mcu.spi.Error.Wait_BSY_Time_Out;

            nss.ct_set(_cctx, rctx, 0);
            try spi1.dma_start(cctx, rctx);

            return _bytes.len;
        }
    };
    const spi_writer = std.io.GenericWriter(Spi_writer_ctx, anyerror, Spi_writer_ctx.write){ .context = Spi_writer_ctx{} };

    const str = "Hello World!";

    try spi_writer.print("{s}\n", .{str});
    while (true) {}
}

//gf part
fn spi_tx_dma_it_gf(comptime _cctx: used_mcu.ctx.Ct_Context) fn () void {
    const spi1 = used_mcu.spi.@"1";
    const tick = used_mcu.sys.tick;
    const nss = used_mcu.gpio.A.pin(.@"4");
    const s = spi1.reg_spi();
    const spi_dma_ch = spi1.tx_dma_ch();
    const dc_pos = comptime spi_dma_ch.get_pos();
    const d = spi_dma_ch.reg_dma();
    return struct {
        pub fn f() void {
            defer spi_dma_ch.clear_it_flag(_cctx, &rt_ctx);

            if (@field(d.ISR, "TCIF" ++ @tagName(dc_pos.ch)) == 0b1) {
                tick.wait_until(
                    _cctx,
                    &rt_ctx,
                    10_000,
                    s.SR_struct,
                    s.SR,
                    "BSY",
                    0,
                    null,
                ) catch {};
                spi1.dma_stop(_cctx, &rt_ctx);
                nss.ct_set(_cctx, &rt_ctx, 1);
            }
        }
    }.f;
}
