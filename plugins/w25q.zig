const std = @import("std");
pub const Size = enum(u16) { @"16" = 0xEF13, @"32" = 0xEF14, @"64" = 0xEF15, @"80" = 0xEF16, @"128" = 0xEF17, @"256" = 0xEF18 };

pub fn @"64"(
    comptime _mcu: type,
    comptime _no: _mcu.spi.No,
    comptime _nss_pos: _mcu.gpio.A.Pos,
) type {
    const spi = @field(_mcu.spi, @tagName(_no));
    const nss = _mcu.gpio.Pin(_nss_pos);
    const tick = _mcu.sys.tick;
    return struct {
        pub const fR = 33_000_000;
        pub const FR = 80_000_000;

        pub const StatusRegister1 = packed struct {
            BUSY: u1,
            WEL: u1,
            BP0: u1,
            BP1: u1,
            BP2: u1,
            TB: u1,
            SEC: u1,
            SRP0: u1,
        };
        pub const StatusRegister2 = packed struct {
            SRP1: u1,
            QE: u1,
            __unused: u6,
        };

        pub const Cmd_tablet = struct {
            pub fn write_enable() [1]u8 {
                return .{0x6};
            }
            pub fn write_disable() [1]u8 {
                return .{0x4};
            }
            pub fn read_sr1() [1]u8 {
                return .{0x5};
            }
            pub fn read_sr2() [1]u8 {
                return .{0x35};
            }
            pub fn read(_addr: u24) [4]u8 {
                var cmd: [4]u8 = undefined;
                cmd[0] = 0x3;
                inline for (1..cmd.len) |i| cmd[i] = @truncate(_addr >> (24 - i * 8));

                return cmd;
            }
        };

        /// Usage:
        ///
        /// const w = w25q.@"64"(_mcu,.@"1",.{.port = .A,.pin = .@"0"});
        ///
        /// const cfg = w.get_spi_config();
        pub fn get_spi_config() _mcu.spi.Spi_Ct_Config {
            return comptime .{
                .mstr = .master,
                .cpol = .high,
                .cpha = .second,
                .ssm = .enable,
                .ssi = .high,
            };
        }
        pub fn get_pin_config() _mcu.gpio.Pin_Ct_Config {
            return comptime .{ .Output = .{ .mode = .PP, .speed = .@"50MHz", .level = .high } };
        }
        pub fn use(_cctx: *_mcu.ctx.Ct_Context) void {
            const spi_cfg = get_spi_config();
            const pin_cfg = get_pin_config();
            @field(&_cctx.spi, "cfg" ++ @tagName(_no)) = spi_cfg;
            spi.use(_cctx);
            nss.use(_cctx, pin_cfg);
        }

        pub fn init(comptime _cctx: _mcu.ctx.Ct_Context, _rctx: *_mcu.ctx.Rt_Context) !void {
            const pin_cfg = comptime get_pin_config();
            try nss.config(_cctx, _rctx, pin_cfg);
            try spi.config(_cctx, _rctx);
        }

        pub fn write_enable(comptime _cctx: _mcu.ctx.Ct_Context, _rctx: *_mcu.ctx.Rt_Context) !void {
            const freq = spi.get_freq(_cctx, _rctx);
            if (freq > FR) @compileError("Frequency is more than the max fR!");

            nss.ct_set(_cctx, _rctx, 0);
            try spi.write(_cctx, _rctx, u8, &Cmd_tablet.write_enable());
            nss.ct_set(_cctx, _rctx, 1);
        }
        pub fn write_disable(comptime _cctx: _mcu.ctx.Ct_Context, _rctx: *_mcu.ctx.Rt_Context) !void {
            const freq = spi.get_freq(_cctx, _rctx);
            if (freq > FR) @compileError("Frequency is more than the max fR!");

            nss.ct_set(_cctx, _rctx, 0);
            try spi.write(_cctx, _rctx, u8, &Cmd_tablet.write_disable());
            nss.ct_set(_cctx, _rctx, 1);
        }
        pub fn read_sr1(comptime _cctx: _mcu.ctx.Ct_Context, _rctx: *_mcu.ctx.Rt_Context) !StatusRegister1 {
            const freq = spi.get_freq(_cctx, _rctx);
            if (freq > FR) @compileError("Frequency is more than the max fR!");

            var sr1: [1]StatusRegister1 = undefined;

            nss.ct_set(_cctx, _rctx, 0);
            try spi.write(_cctx, _rctx, u8, &Cmd_tablet.read_sr1());
            try spi.read(_cctx, _rctx, StatusRegister1, &sr1);
            nss.ct_set(_cctx, _rctx, 1);

            return sr1[0];
        }
        pub fn read_sr2(comptime _cctx: _mcu.ctx.Ct_Context, _rctx: *_mcu.ctx.Rt_Context) !StatusRegister2 {
            const freq = spi.get_freq(_cctx, _rctx);
            if (freq > FR) @compileError("Frequency is more than the max fR!");

            var sr2: [1]StatusRegister1 = undefined;

            nss.ct_set(_cctx, _rctx, 0);
            try spi.write(_cctx, _rctx, u8, &Cmd_tablet.read_sr2());
            try spi.read(_cctx, _rctx, StatusRegister2, &sr2);
            nss.ct_set(_cctx, _rctx, 1);

            return sr2[0];
        }
        pub fn read(comptime _cctx: _mcu.ctx.Ct_Context, _rctx: *_mcu.ctx.Rt_Context, _addr: u24, _data: []u8) !void {
            const freq = spi.get_freq(_cctx, _rctx);
            if (freq > fR) @compileError("Frequency is more than the max fR!");

            if ((try read_sr1(_cctx, _rctx)).BUSY == 0b1) {
                tick.start(_cctx, _rctx, 10_000);
                while ((try read_sr1(_cctx, _rctx)).BUSY == 0b1) {
                    if (tick.finished(_cctx, _rctx) == true) return error.Time_Out;
                }
            }

            nss.ct_set(_cctx, _rctx, 0);
            try spi.write(_cctx, _rctx, u8, &Cmd_tablet.read(_addr));
            try spi.read(_cctx, _rctx, u8, _data);
            nss.ct_set(_cctx, _rctx, 1);
        }
    };
}
