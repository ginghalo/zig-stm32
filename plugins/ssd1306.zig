const std = @import("std");
const mem = std.mem;
const io = std.io;
const memcpy = std.mem.copyForwards;
const zeroes = std.mem.zeroes;

const font = @import("ssd1306/font.zig");
// TODO debug: when rolling up the content, it still remains something

pub const Size = enum { @"0.91inch", @"0.96inch", @"1.3inch", @"1.5inch" };
pub inline fn get_pages(comptime _size: Size) comptime_int {
    return switch (_size) {
        .@"0.91inch" => 4,
        .@"0.96inch" => 8,
        .@"1.3inch" => 8,
        .@"1.5inch" => 16,
    };
}
pub inline fn get_cols(comptime _size: Size) comptime_int {
    return switch (_size) {
        .@"0.91inch" => 128,
        .@"0.96inch" => 144,
        .@"1.3inch" => 144,
        .@"1.5inch" => 144,
    };
}

/// Ensure that the i2c has been configured
///
/// Usage:
///
/// const o = ssd1306.I2c(using_mcu,.@"1",.@"0.91inch");
///
/// comptime o.use(&ctx);
///
/// try o.init(ctx);
///
/// var oled_ctx = o.Ct_Context{};
///
/// const logger = o.writer(ctx,&oled_ctx);
///
/// try logger.print("Hello World!\n", .{});
///
pub fn I2c(comptime _mcu: type, comptime _no: _mcu.i2c.No, comptime _size: Size) type {
    const tick = _mcu.sys.tick;
    const MAX_PAGES = get_pages(_size);
    const MAX_COLS = get_cols(_size);
    const i2c = @field(_mcu.i2c, @tagName(_no));
    const Ct_Context = _mcu.ctx.Ct_Context;
    return struct {
        const This = @This();

        pub const OLED_Context = struct {
            rt_ctx: *_mcu.ctx.Rt_Context,

            fontT: font.FontType = .ascii6x8,
            record_page: ?u8 = null,
            record_column: ?u8 = null,
            page: u8 = 0,
            column: u8 = 0,
            buffer: [MAX_PAGES][MAX_COLS]u8 = zeroes([MAX_PAGES][MAX_COLS]u8),
            end: [MAX_PAGES]u8 = zeroes([MAX_PAGES]u8),
        };
        pub const Error = error{Buff_Out_Of_Range};

        pub fn write_data(comptime _cctx: Ct_Context, _rctx: *_mcu.ctx.Rt_Context, _data: []const u8) !void {
            try i2c.mem_write(_cctx, _rctx, .@"7bit", 0x3C, .@"8bit", 0x40, u8, _data);
        }
        pub fn write_data_Ntimes(comptime _cctx: Ct_Context, _rctx: *_mcu.ctx.Rt_Context, _value: u8, _times: usize) !void {
            try i2c.mem_write_Ntimes(_cctx, _rctx, .@"7bit", 0x3C, .@"8bit", 0x40, u8, @as([*]const u8, @ptrCast(&_value))[0..1], _times);
        }
        pub fn write_cmd(comptime _cctx: Ct_Context, _rctx: *_mcu.ctx.Rt_Context, _cmd: []const u8) !void {
            try i2c.mem_write(_cctx, _rctx, .@"7bit", 0x3C, .@"8bit", 0x0, u8, _cmd);
        }
        pub fn display_off(comptime _cctx: Ct_Context, _rctx: *_mcu.ctx.Rt_Context) !void {
            const cmd = [_]u8{ 0x8D, 0x10, 0xAE };
            try write_cmd(_cctx, _rctx, &cmd);
        }
        pub fn display_on(comptime _cctx: Ct_Context, _rctx: *_mcu.ctx.Rt_Context) !void {
            const cmd = [_]u8{ 0x8D, 0x14, 0xAF };
            try write_cmd(_cctx, _rctx, &cmd);
        }
        pub fn raw_set_pos(comptime _cctx: Ct_Context, _rctx: *_mcu.ctx.Rt_Context, _page: u8, _column: u8) !void {
            const cmd = [_]u8{ _column & 0xF, 0x10 | ((_column & 0xF0) >> 4), 0xB0 + _page };
            try write_cmd(_cctx, _rctx, &cmd);
        }
        pub fn raw_fill_line_zero(comptime _cctx: Ct_Context, _rctx: *_mcu.ctx.Rt_Context, _line: u8) !void {
            try raw_set_pos(_cctx, _rctx, _line, 0);
            try write_data_Ntimes(_cctx, _rctx, 0, MAX_COLS);
        }
        pub fn raw_fill_zero(comptime _cctx: Ct_Context, _rctx: *_mcu.ctx.Rt_Context) !void {
            for (0..MAX_PAGES) |i| {
                try raw_fill_line_zero(_cctx, _rctx, @truncate(i));
            }
        }
        pub fn raw_fill(comptime _cctx: Ct_Context, _rctx: *_mcu.ctx.Rt_Context, _map: [MAX_PAGES][MAX_COLS]u8) !void {
            inline for (0..MAX_PAGES) |i| {
                try raw_set_pos(_cctx, _rctx, i, 0);
                try write_data(_cctx, _rctx, &_map[i]);
            }
        }

        /// Usage:
        ///
        /// const o = ssd1306.I2c(_mcu,.@"1",.@"0.91inch");
        ///
        /// const cfg = o.get_i2c_config();
        pub fn get_i2c_config() _mcu.i2c.I2c_Ct_Config {
            return .{};
        }
        pub fn use(_cctx: *Ct_Context) void {
            if (@field(&_cctx.i2c, "cfg" ++ @tagName(_no)) == null) {
                @field(&_cctx.i2c, "cfg" ++ @tagName(_no)) = get_i2c_config();
            }
            i2c.use(_cctx);
        }
        pub fn init(comptime _cctx: Ct_Context, _rctx: *_mcu.ctx.Rt_Context) !void {
            try i2c.config(_cctx, _rctx);
            try display_off(_cctx, _rctx);
            tick.delay_us(_cctx, _rctx, 2_000);

            const cmd = [_]u8{
                0x00, 0x10, 0x00, 0xB0, 0x81, 0x8F, 0xA1, 0xA8,
                0x1F, 0xC8, 0xD3, 0x00, 0xD5, 0x80, 0xD9, 0x1F,
                0xDA, 0x00, 0xDB, 0x40,
            };
            try write_cmd(_cctx, _rctx, &cmd);

            try raw_fill_zero(_cctx, _rctx);

            try display_on(_cctx, _rctx);
            tick.delay_us(_cctx, _rctx, 2_000);
        }

        pub fn raw_draw_line_zero(comptime _cctx: Ct_Context, _oled_ctx: *OLED_Context) !void {
            _oled_ctx.end[_oled_ctx.page] = _oled_ctx.column;
            try raw_set_pos(_cctx, _oled_ctx.rt_ctx, _oled_ctx.page, _oled_ctx.column);
            @memset(_oled_ctx.buffer[_oled_ctx.page][_oled_ctx.column..], 0);
            try write_data_Ntimes(_cctx, _oled_ctx.rt_ctx, 0, MAX_COLS - _oled_ctx.column);
        }
        pub fn raw_draw_x8(comptime _cctx: Ct_Context, _oled_ctx: *OLED_Context, _data: []const u8) !void {
            const expected_end_cols = _oled_ctx.column + _data.len;
            const end_data_index: u8 = if (expected_end_cols <= MAX_COLS) @truncate(_data.len) else MAX_COLS - _oled_ctx.column;

            _oled_ctx.end[_oled_ctx.page] = @max(_oled_ctx.end[_oled_ctx.page], end_data_index + _oled_ctx.column);
            try raw_set_pos(_cctx, _oled_ctx.rt_ctx, _oled_ctx.page, _oled_ctx.column);

            memcpy(u8, _oled_ctx.buffer[_oled_ctx.page][_oled_ctx.column..], _data[0..end_data_index]);
            try write_data(_cctx, _oled_ctx.rt_ctx, _data[0..end_data_index]);
        }
        pub fn raw_draw_x16(comptime _cctx: Ct_Context, _oled_ctx: *OLED_Context, _data: []const u8) !void {
            var oled_ctx = _oled_ctx.*; // to keep the page not change
            try raw_draw_x8(_cctx, &oled_ctx, _data[0 .. _data.len / 2]);
            oled_ctx.page += 1;
            try raw_draw_x8(_cctx, &oled_ctx, _data[_data.len / 2 ..]);
        }
        pub fn raw_draw_buff(comptime _cctx: Ct_Context, _oled_ctx: *OLED_Context, start: u8, delta: u8) anyerror!void {
            try raw_fill_zero(_cctx, _oled_ctx.rt_ctx);
            const before_page = _oled_ctx.page;
            const before_column = _oled_ctx.column;

            for (0..delta) |i| {
                if (start + i >= MAX_PAGES) return Error.Buff_Out_Of_Range;
                _oled_ctx.page = @truncate(i);
                _oled_ctx.column = 0;
                try raw_draw_x8(_cctx, _oled_ctx, _oled_ctx.buffer[start + i][0.._oled_ctx.end[start + i]]);
            }

            _oled_ctx.page = before_page;
            _oled_ctx.column = before_column;
        }

        pub fn raw_draw_font(comptime _cctx: Ct_Context, _oled_ctx: *OLED_Context, _index: u8) !void {
            switch (_oled_ctx.fontT) {
                .ascii6x8 => try raw_draw_x8(_cctx, _oled_ctx, &font.ascii.@"6x8"[_index]),
                .ascii16x8 => try raw_draw_x16(_cctx, _oled_ctx, &font.ascii.@"16x8"[_index]),
                .alician16x16 => try raw_draw_x16(_cctx, _oled_ctx, &font.alician.@"16x16"[_index]),
            }
        }

        pub fn raw_draw_char(comptime _cctx: Ct_Context, _oled_ctx: *OLED_Context, _char: u8) !void {
            const index = switch (_oled_ctx.fontT) {
                .ascii16x8, .ascii6x8 => if (_char < ' ' or _char > '~') 0 else if (_char < 'A') _char - ' ' else if (_char < 'a') _char - 'A' + 33 else _char - 'a' + 65,
                .alician16x16 => if (_char == '!') 1 else if (_char == '?') 2 else if ('a' < _char and _char < 'z') _char - 'a' else if ('A' < _char and _char < 'Z') _char - 'A' else 0,
            };
            try raw_draw_font(_cctx, _oled_ctx, index);
        }

        pub fn raw_draw_string(comptime _cctx: Ct_Context, _oled_ctx: *OLED_Context, _str: []const u8) !void {
            const width: u8 = switch (_oled_ctx.fontT) {
                .ascii6x8 => 6,
                .ascii16x8 => 8,
                .alician16x16 => 16,
            };
            const height: u8 = switch (_oled_ctx.fontT) {
                .ascii6x8 => 8 / 8,
                .ascii16x8 => 8 / 8,
                .alician16x16 => 16 / 8,
            };

            for (0.._str.len) |i| {
                if (_oled_ctx.column + width >= MAX_COLS or _str[i] == '\n') {
                    _oled_ctx.page += height;
                    _oled_ctx.column = 0;
                    try raw_draw_line_zero(_cctx, _oled_ctx);
                    if (_str[i] == '\n') continue;
                }
                if (_oled_ctx.page + height > MAX_PAGES) {
                    try raw_draw_buff(_cctx, _oled_ctx, height, MAX_PAGES - height);
                    _oled_ctx.page = MAX_PAGES - height;
                }
                if (_str[i] == '\r') {
                    _oled_ctx.column = 0;
                    continue;
                }
                if (_str[i] == '\x00') {
                    if (_oled_ctx.record_column == null) {
                        _oled_ctx.record_column = _oled_ctx.column;
                    } else {
                        _oled_ctx.column = _oled_ctx.record_column.?;
                        _oled_ctx.record_column = null;
                    }

                    if (_oled_ctx.record_page == null) {
                        _oled_ctx.record_page = _oled_ctx.page;
                    } else {
                        _oled_ctx.page = _oled_ctx.record_page.?;
                        _oled_ctx.record_page = null;
                    }
                    continue;
                }

                try raw_draw_char(_cctx, _oled_ctx, _str[i]);

                _oled_ctx.column += width;
            }
            //try raw_draw_char(_cctx,_rctx, '_');
        }

        pub fn generate_write_fn(comptime _cctx: Ct_Context) type {
            return struct {
                pub fn raw_write(_oled_ctx: *OLED_Context, _str: []const u8) anyerror!usize {
                    try raw_draw_string(_cctx, _oled_ctx, _str);
                    return _str.len;
                }
            };
        }

        pub fn writer(
            comptime _cctx: Ct_Context,
            _oled_ctx: *OLED_Context,
        ) io.GenericWriter(
            *OLED_Context,
            anyerror,
            generate_write_fn(_cctx).raw_write,
        ) {
            return io.GenericWriter(*OLED_Context, anyerror, generate_write_fn(_cctx).raw_write){ .context = _oled_ctx };
        }
    };
}

/// Ensure that the i2c has been configured
///
/// Usage:
///
/// const o = ssd1306.Spi(using_mcu,.@"1",.@"0.96inch",.{.port = .A,.pin = @"0"},.{.port = .A,.pin = @"1"},null);
///
/// comptime o.use(&ctx);
///
/// try o.init(ctx);
///
/// var oled_ctx = o.Ct_Context{};
///
/// const logger = o.writer(ctx,&oled_ctx);
///
/// try logger.print("Hello World!\n", .{});
///
pub fn Spi(
    comptime _mcu: type,
    comptime _no: _mcu.spi.No,
    comptime _size: Size,
    comptime _nss_pos: _mcu.gpio.Pos,
    comptime _dc_pos: _mcu.gpio.Pos,
    comptime _res_pos: _mcu.gpio.Pos,
) type {
    const tick = _mcu.sys.tick;
    const MAX_PAGES = get_pages(_size);
    const MAX_COLS = get_cols(_size);
    const spi = @field(_mcu.spi, @tagName(_no));
    const Ct_Context = _mcu.ctx.Ct_Context;
    const nss = _mcu.gpio.Pin(_nss_pos);
    const dc = _mcu.gpio.Pin(_dc_pos);
    const res = _mcu.gpio.Pin(_res_pos);
    return struct {
        pub const OLED_Context = struct {
            rt_ctx: *_mcu.ctx.Rt_Context,

            fontT: font.FontType = .ascii6x8,
            record_page: ?u8 = null,
            record_column: ?u8 = null,
            page: u8 = 0,
            column: u8 = 0,
            buffer: [MAX_PAGES][MAX_COLS]u8 = zeroes([MAX_PAGES][MAX_COLS]u8),
            end: [MAX_PAGES]u8 = zeroes([MAX_PAGES]u8),
        };
        pub const Error = error{Buff_Out_Of_Range};

        pub fn write_data(comptime _cctx: Ct_Context, _rctx: *_mcu.ctx.Rt_Context, _data: []const u8) !void {
            dc.ct_set(_cctx, _rctx, 1);

            nss.ct_set(_cctx, _rctx, 0);
            try spi.write(_cctx, _rctx, u8, _data);
            nss.ct_set(_cctx, _rctx, 1);
        }
        pub fn write_data_Ntimes(comptime _cctx: Ct_Context, _rctx: *_mcu.ctx.Rt_Context, _value: u8, _times: usize) !void {
            dc.ct_set(_cctx, _rctx, 1);

            nss.ct_set(_cctx, _rctx, 0);
            try spi.write_Ntimes(_cctx, _rctx, u8, @as([*]const u8, @ptrCast(&_value))[0..1], _times);
            nss.ct_set(_cctx, _rctx, 1);
        }
        pub fn write_cmd(comptime _cctx: Ct_Context, _rctx: *_mcu.ctx.Rt_Context, _cmd: []const u8) !void {
            dc.ct_set(_cctx, _rctx, 0);

            nss.ct_set(_cctx, _rctx, 0);
            try spi.write(_cctx, _rctx, u8, _cmd);
            nss.ct_set(_cctx, _rctx, 1);
        }
        pub fn display_off(comptime _cctx: Ct_Context, _rctx: *_mcu.ctx.Rt_Context) !void {
            const cmd = [_]u8{ 0x8D, 0x10, 0xAE };
            try write_cmd(_cctx, _rctx, &cmd);
        }
        pub fn display_on(comptime _cctx: Ct_Context, _rctx: *_mcu.ctx.Rt_Context) !void {
            const cmd = [_]u8{ 0x8D, 0x14, 0xAF };
            try write_cmd(_cctx, _rctx, &cmd);
        }
        pub fn raw_set_pos(comptime _cctx: Ct_Context, _rctx: *_mcu.ctx.Rt_Context, _page: u8, _column: u8) !void {
            const cmd = [_]u8{ _column & 0xF, 0x10 | ((_column & 0xF0) >> 4), 0xB0 + _page };
            try write_cmd(_cctx, _rctx, &cmd);
        }
        pub fn raw_fill_line_zero(comptime _cctx: Ct_Context, _rctx: *_mcu.ctx.Rt_Context, _line: u8) !void {
            try raw_set_pos(_cctx, _rctx, _line, 0);
            try write_data_Ntimes(_cctx, _rctx, 0, MAX_COLS);
        }
        pub fn raw_fill_zero(comptime _cctx: Ct_Context, _rctx: *_mcu.ctx.Rt_Context) !void {
            for (0..MAX_PAGES) |i| {
                try raw_fill_line_zero(_cctx, _rctx, @truncate(i));
            }
        }
        pub fn raw_fill(comptime _cctx: Ct_Context, _rctx: *_mcu.ctx.Rt_Context, _map: [MAX_PAGES][MAX_COLS]u8) !void {
            for (0..MAX_PAGES) |i| {
                try raw_set_pos(_cctx, _rctx, i, 0);
                try write_data(_cctx, _rctx, &_map[i]);
            }
        }

        /// Usage:
        ///
        /// const o = ssd1306.Spi(_mcu,.@"1",.@"0.91inch",.{.port = .A,.pin = .@"0"},.{.port = .A,.pin = .@"1"},.{.port = .A,.pin = .@"2"});
        ///
        /// const cfg = o.get_spi_config();
        pub fn get_spi_config() _mcu.spi.Spi_Ct_Config {
            return comptime .{
                .mstr = .master,
                .cpol = .high,
                .cpha = .second,
                .ssm = .enable,
                .ssi = .high,
                .ssoe = .disable,
            };
        }
        pub fn get_pin_config() _mcu.gpio.Pin_Ct_Config {
            return comptime .{ .Output = .{ .mode = .PP, .speed = .@"50MHz", .level = .high } };
        }
        pub fn use(_cctx: *Ct_Context) void {
            const spi_cfg = get_spi_config();
            const pin_cfg = get_pin_config();
            if (@field(&_cctx.spi, "cfg" ++ @tagName(_no)) == null) {
                @field(&_cctx.spi, "cfg" ++ @tagName(_no)) = spi_cfg;
            }
            spi.use(_cctx);
            nss.use(_cctx, pin_cfg);
            dc.use(_cctx, pin_cfg);
            res.use(_cctx, pin_cfg);
        }
        pub fn init(comptime _cctx: Ct_Context, _rctx: *_mcu.ctx.Rt_Context) !void {
            const pin_cfg = comptime get_pin_config();
            try nss.config(_cctx, _rctx, pin_cfg);
            try dc.config(_cctx, _rctx, pin_cfg);
            try res.config(_cctx, _rctx, pin_cfg);
            try spi.config(_cctx, _rctx);

            res.ct_set(_cctx, _rctx, 1);
            tick.delay_us(_cctx, _rctx, 100_000);
            res.ct_set(_cctx, _rctx, 0);
            tick.delay_us(_cctx, _rctx, 200_000);
            res.ct_set(_cctx, _rctx, 1);

            try display_off(_cctx, _rctx);

            const cmd = [_]u8{
                0x00, 0x10, 0x40, 0x81, 0xCF, 0xA1, 0xC8, 0xA6,
                0xA8, 0x3f, 0xD3, 0x00, 0xD5, 0x80, 0xD9, 0xF1,
                0xDA, 0x12, 0xDB, 0x40, 0x20, 0x02, 0x8D, 0x14,
                0xA4, 0xA6,
            };
            try write_cmd(_cctx, _rctx, &cmd);

            try raw_fill_zero(_cctx, _rctx);

            try display_on(_cctx, _rctx);
        }

        pub fn raw_draw_line_zero(comptime _cctx: Ct_Context, _oled_ctx: *OLED_Context) !void {
            _oled_ctx.end[_oled_ctx.page] = _oled_ctx.column;
            try raw_set_pos(_cctx, _oled_ctx.rt_ctx, _oled_ctx.page, _oled_ctx.column);
            @memset(_oled_ctx.buffer[_oled_ctx.page][_oled_ctx.column..], 0);
            try write_data_Ntimes(_cctx, _oled_ctx.rt_ctx, 0, MAX_COLS - _oled_ctx.column);
        }
        pub fn raw_draw_x8(comptime _cctx: Ct_Context, _oled_ctx: *OLED_Context, _data: []const u8) !void {
            const expected_end_cols = _oled_ctx.column + _data.len;
            const end_data_index: u8 = if (expected_end_cols <= MAX_COLS) @truncate(_data.len) else MAX_COLS - _oled_ctx.column;

            _oled_ctx.end[_oled_ctx.page] = @max(_oled_ctx.end[_oled_ctx.page], end_data_index + _oled_ctx.column);
            try raw_set_pos(_cctx, _oled_ctx.rt_ctx, _oled_ctx.page, _oled_ctx.column);

            memcpy(u8, _oled_ctx.buffer[_oled_ctx.page][_oled_ctx.column..], _data[0..end_data_index]);
            try write_data(_cctx, _oled_ctx.rt_ctx, _data[0..end_data_index]);
        }
        pub fn raw_draw_x16(comptime _cctx: Ct_Context, _oled_ctx: *OLED_Context, _data: []const u8) !void {
            var oled_ctx = _oled_ctx.*; // to keep the page not change
            try raw_draw_x8(_cctx, &oled_ctx, _data[0 .. _data.len / 2]);
            oled_ctx.page += 1;
            try raw_draw_x8(_cctx, &oled_ctx, _data[_data.len / 2 ..]);
        }
        pub fn raw_draw_buff(comptime _cctx: Ct_Context, _oled_ctx: *OLED_Context, start: u8, delta: u8) anyerror!void {
            try raw_fill_zero(_cctx, _oled_ctx.rt_ctx);
            const before_page = _oled_ctx.page;
            const before_column = _oled_ctx.column;

            for (0..delta) |i| {
                if (start + i >= MAX_PAGES) return Error.Buff_Out_Of_Range;
                _oled_ctx.page = @truncate(i);
                _oled_ctx.column = 0;
                try raw_draw_x8(_cctx, _oled_ctx, _oled_ctx.buffer[start + i][0.._oled_ctx.end[start + i]]);
            }

            _oled_ctx.page = before_page;
            _oled_ctx.column = before_column;
        }

        pub fn raw_draw_font(comptime _cctx: Ct_Context, _oled_ctx: *OLED_Context, _index: u8) !void {
            switch (_oled_ctx.fontT) {
                .ascii6x8 => try raw_draw_x8(_cctx, _oled_ctx, &font.ascii.@"6x8"[_index]),
                .ascii16x8 => try raw_draw_x16(_cctx, _oled_ctx, &font.ascii.@"16x8"[_index]),
                .alician16x16 => try raw_draw_x16(_cctx, _oled_ctx, &font.alician.@"16x16"[_index]),
            }
        }

        pub fn raw_draw_char(comptime _cctx: Ct_Context, _oled_ctx: *OLED_Context, _char: u8) !void {
            const index = switch (_oled_ctx.fontT) {
                .ascii16x8, .ascii6x8 => if (_char < ' ' or _char > '~') 0 else if (_char < 'A') _char - ' ' else if (_char < 'a') _char - 'A' + 33 else _char - 'a' + 65,
                .alician16x16 => if (_char == '!') 1 else if (_char == '?') 2 else if ('a' < _char and _char < 'z') _char - 'a' else if ('A' < _char and _char < 'Z') _char - 'A' else 0,
            };
            try raw_draw_font(_cctx, _oled_ctx, index);
        }

        pub fn raw_draw_string(comptime _cctx: Ct_Context, _oled_ctx: *OLED_Context, _str: []const u8) !void {
            const width: u8 = switch (_oled_ctx.fontT) {
                .ascii6x8 => 6,
                .ascii16x8 => 8,
                .alician16x16 => 16,
            };
            const height: u8 = switch (_oled_ctx.fontT) {
                .ascii6x8 => 8 / 8,
                .ascii16x8 => 8 / 8,
                .alician16x16 => 16 / 8,
            };

            for (0.._str.len) |i| {
                if (_oled_ctx.column + width >= MAX_COLS or _str[i] == '\n') {
                    if (_str[i] == '\n') try raw_draw_line_zero(_cctx, _oled_ctx);

                    _oled_ctx.page += height;
                    _oled_ctx.column = 0;

                    if (_str[i] == '\n') continue;
                }
                if (_oled_ctx.page + height > MAX_PAGES) {
                    try raw_draw_buff(_cctx, _oled_ctx, height, MAX_PAGES - height);
                    _oled_ctx.page = MAX_PAGES - height;
                }
                if (_str[i] == '\r') {
                    _oled_ctx.column = 0;
                    continue;
                }
                if (_str[i] == '\x00') {
                    if (_oled_ctx.record_column == null) {
                        _oled_ctx.record_column = _oled_ctx.column;
                    } else {
                        _oled_ctx.column = _oled_ctx.record_column.?;
                        _oled_ctx.record_column = null;
                    }

                    if (_oled_ctx.record_page == null) {
                        _oled_ctx.record_page = _oled_ctx.page;
                    } else {
                        _oled_ctx.page = _oled_ctx.record_page.?;
                        _oled_ctx.record_page = null;
                    }
                    continue;
                }

                try raw_draw_char(_cctx, _oled_ctx, _str[i]);

                _oled_ctx.column += width;
            }
            //try raw_draw_char(_cctx,_rctx, '_');
        }

        pub fn generate_write_fn(comptime _cctx: Ct_Context) type {
            return struct {
                pub fn raw_write(_oled_ctx: *OLED_Context, _str: []const u8) anyerror!usize {
                    try raw_draw_string(_cctx, _oled_ctx, _str);
                    return _str.len;
                }
            };
        }

        pub fn writer(
            comptime _cctx: Ct_Context,
            _oled_ctx: *OLED_Context,
        ) io.GenericWriter(
            *OLED_Context,
            anyerror,
            generate_write_fn(_cctx).raw_write,
        ) {
            return io.GenericWriter(*OLED_Context, anyerror, generate_write_fn(_cctx).raw_write){ .context = _oled_ctx };
        }
    };
}

pub fn I2c_Dma(
    comptime _mcu: type,
    comptime _no: _mcu.i2c.No,
    comptime _size: Size,
    _rctx: *_mcu.ctx.Rt_Context,
) type {
    const tick = _mcu.sys.tick;
    const MAX_PAGES = get_pages(_size);
    const MAX_COLS = get_cols(_size);
    const i2c = @field(_mcu.i2c, @tagName(_no));
    const i2c_reg = i2c.reg_i2c();
    const Ct_Context = _mcu.ctx.Ct_Context;
    return struct {
        pub const OLED_Context = struct {
            fontT: font.FontType = .ascii6x8,
            record_page: ?u8 = null,
            record_column: ?u8 = null,
            page: u8 = 0,
            column: u8 = 0,
            buffer: [MAX_PAGES][MAX_COLS]u8 = zeroes([MAX_PAGES][MAX_COLS]u8),
            end: [MAX_PAGES]u8 = zeroes([MAX_PAGES]u8),
        };
        pub const Error = error{ Buff_Out_Of_Range, Wait_Tx_Finished_Time_Out };

        var tx_finished: bool = true;
        inline fn wait_tx_finished(comptime _cctx: Ct_Context) Error!void {
            tick.start(_cctx, _rctx, 100_000);
            defer tick.stop(_cctx, _rctx);

            while (@atomicLoad(bool, &tx_finished, .acquire) != true) {
                if (tick.finished(_cctx, _rctx) == true) return Error.Wait_Tx_Finished_Time_Out;
            }
        }
        pub fn write_data(comptime _cctx: Ct_Context, _data: []const u8) !void {
            @field(_rctx.i2c, "cfg" ++ @tagName(_no)) = get_i2c_rt_config(_data);

            try wait_tx_finished(_cctx);

            @atomicStore(bool, &tx_finished, false, .release);
            try i2c.mem_dma_start(_cctx, _rctx, .@"7bit", 0x3C, .@"8bit", 0x40);
        }
        pub fn write_data_Ntimes(comptime _cctx: Ct_Context, _value: u8, _times: u16) !void {
            @field(_rctx.i2c, "cfg" ++ @tagName(_no)) = get_Ntimes_i2c_rt_config(_value, _times);

            try wait_tx_finished(_cctx);

            @atomicStore(bool, &tx_finished, false, .release);
            try i2c.mem_dma_start(_cctx, _rctx, .@"7bit", 0x3C, .@"8bit", 0x40);
        }
        pub fn write_cmd(comptime _cctx: Ct_Context, _cmd: []const u8) !void {
            @field(_rctx.i2c, "cfg" ++ @tagName(_no)) = get_i2c_rt_config(_cmd);

            try wait_tx_finished(_cctx);

            @atomicStore(bool, &tx_finished, false, .release);
            try i2c.mem_dma_start(_cctx, _rctx, .@"7bit", 0x3C, .@"8bit", 0);
        }

        var tmp_cmd_buff: [32]u8 = undefined;
        pub fn display_off(comptime _cctx: Ct_Context) !void {
            const cmd = [_]u8{ 0x8D, 0x10, 0xAE };
            memcpy(u8, &tmp_cmd_buff, &cmd);
            try write_cmd(_cctx, tmp_cmd_buff[0..cmd.len]);
        }
        pub fn display_on(comptime _cctx: Ct_Context) !void {
            const cmd = [_]u8{ 0x8D, 0x14, 0xAF };
            memcpy(u8, &tmp_cmd_buff, &cmd);
            try write_cmd(_cctx, tmp_cmd_buff[0..cmd.len]);
        }
        pub fn raw_set_pos(comptime _cctx: Ct_Context, _page: u8, _column: u8) !void {
            const cmd = [_]u8{ _column & 0xF, 0x10 | ((_column & 0xF0) >> 4), 0xB0 + _page };
            memcpy(u8, &tmp_cmd_buff, &cmd);
            try write_cmd(_cctx, tmp_cmd_buff[0..cmd.len]);
        }
        pub fn raw_fill_line_zero(comptime _cctx: Ct_Context, _line: u8) !void {
            try raw_set_pos(_cctx, _line, 0);
            try write_data_Ntimes(_cctx, 0, MAX_COLS);
        }
        pub fn raw_fill_zero(
            comptime _cctx: Ct_Context,
        ) !void {
            for (0..MAX_PAGES) |i| {
                try raw_fill_line_zero(_cctx, @truncate(i));
            }
        }
        pub fn raw_fill(comptime _cctx: Ct_Context, _map: [MAX_PAGES][MAX_COLS]u8) !void {
            for (0..MAX_PAGES) |i| {
                try raw_set_pos(_cctx, i, 0);
                try write_data(_cctx, &_map[i]);
            }
        }

        fn i2c_tx_dma_it_gf(comptime _cctx: Ct_Context) fn () void {
            const i2c_dma_ch = i2c.tx_dma_ch();
            const dc_pos = comptime i2c_dma_ch.get_pos();
            const d = i2c_dma_ch.reg_dma();
            return struct {
                pub fn f() void {
                    defer i2c_dma_ch.clear_it_flag(_cctx, _rctx);
                    if (@field(d.ISR, "TCIF" ++ @tagName(dc_pos.ch)) == 0b1) {
                        tick.wait_until(
                            _cctx,
                            _rctx,
                            10_000,
                            i2c_reg.SR1_struct,
                            i2c_reg.SR1,
                            "BTF",
                            0b1,
                            null,
                        ) catch return;

                        i2c.dma_stop(_cctx, _rctx);
                        @atomicStore(bool, &tx_finished, true, .release);
                    }
                }
            }.f;
        }
        /// Usage:
        ///
        /// const o = ssd1306.Spi(_mcu,.@"1",.@"0.91inch",.{.port = .A,.pin = .@"0"},.{.port = .A,.pin = .@"1"},.{.port = .A,.pin = .@"2"});
        ///
        /// const cfg = o.get_spi_ct_config();
        pub fn get_i2c_ct_config() _mcu.i2c.I2c_Ct_Config {
            return comptime .{
                .i2c_dma = .{
                    .tx_cfg = .{
                        .it = .{
                            .gf = i2c_tx_dma_it_gf,
                            .htie = .disable,
                            .tcie = .enable,
                        },
                    },
                },
            };
        }
        pub fn get_i2c_rt_config(_data: []const u8) _mcu.i2c.I2c_Rt_Config {
            return .{
                .tx_cfg = .{
                    .ma = @intFromPtr(_data.ptr),
                    .ndt = @truncate(_data.len),
                    .circ = .disable,
                    .minc = .enable,
                },
            };
        }
        var global_value: u8 = 0;
        pub fn get_Ntimes_i2c_rt_config(_value: u8, _times: u16) _mcu.i2c.I2c_Rt_Config {
            global_value = _value;
            return .{
                .tx_cfg = .{
                    .ma = @intFromPtr(&global_value),
                    .ndt = _times,
                    .circ = .disable,
                    .minc = .disable,
                },
            };
        }
        pub fn get_pin_config() _mcu.gpio.Pin_Ct_Config {
            return comptime .{ .Output = .{ .mode = .PP, .speed = .@"50MHz", .level = .high } };
        }
        pub fn use(_cctx: *Ct_Context) void {
            const i2c_cfg = get_i2c_ct_config();
            if (@field(&_cctx.i2c, "cfg" ++ @tagName(_no)) == null) {
                @field(&_cctx.i2c, "cfg" ++ @tagName(_no)) = i2c_cfg;
            }
            i2c.use(_cctx);
        }
        pub fn init(comptime _cctx: Ct_Context) !void {
            try i2c.config(_cctx, _rctx);

            try display_off(_cctx);

            const cmd = [_]u8{
                0x00, 0x10, 0x00, 0xB0, 0x81, 0x8F, 0xA1, 0xA8,
                0x1F, 0xC8, 0xD3, 0x00, 0xD5, 0x80, 0xD9, 0x1F,
                0xDA, 0x00, 0xDB, 0x40,
            };
            memcpy(u8, &tmp_cmd_buff, &cmd);
            try write_cmd(_cctx, tmp_cmd_buff[0..cmd.len]);

            try raw_fill_zero(_cctx);

            try display_on(_cctx);
        }

        pub fn raw_draw_line_zero(comptime _cctx: Ct_Context, _oled_ctx: *OLED_Context) !void {
            _oled_ctx.end[_oled_ctx.page] = _oled_ctx.column;
            try raw_set_pos(_cctx, _oled_ctx.page, _oled_ctx.column);
            @memset(_oled_ctx.buffer[_oled_ctx.page][_oled_ctx.column..], 0);
            try write_data_Ntimes(_cctx, 0, MAX_COLS - _oled_ctx.column);
        }
        pub fn raw_draw_x8(comptime _cctx: Ct_Context, _oled_ctx: *OLED_Context, _data: []const u8) !void {
            const expected_end_cols = _oled_ctx.column + _data.len;
            const end_data_index: u8 = if (expected_end_cols <= MAX_COLS) @truncate(_data.len) else MAX_COLS - _oled_ctx.column;

            _oled_ctx.end[_oled_ctx.page] = @max(_oled_ctx.end[_oled_ctx.page], end_data_index + _oled_ctx.column);
            memcpy(u8, _oled_ctx.buffer[_oled_ctx.page][_oled_ctx.column..], _data[0..end_data_index]);

            try raw_set_pos(_cctx, _oled_ctx.page, _oled_ctx.column);
            try write_data(_cctx, _oled_ctx.buffer[_oled_ctx.page][_oled_ctx.column..][0..end_data_index]);
        }
        pub fn raw_draw_x16(comptime _cctx: Ct_Context, _oled_ctx: *OLED_Context, _data: []const u8) !void {
            var oled_ctx = _oled_ctx.*; // to keep the page not change
            try raw_draw_x8(_cctx, &oled_ctx, _data[0 .. _data.len / 2]);
            oled_ctx.page += 1;
            try raw_draw_x8(_cctx, &oled_ctx, _data[_data.len / 2 ..]);
        }
        pub fn raw_draw_buff(comptime _cctx: Ct_Context, _oled_ctx: *OLED_Context, start: u8, delta: u8) anyerror!void {
            try raw_fill_zero(_cctx);
            const before_page = _oled_ctx.page;
            const before_column = _oled_ctx.column;

            for (0..delta) |i| {
                if (start + i >= MAX_PAGES) return Error.Buff_Out_Of_Range;
                _oled_ctx.page = @truncate(i);
                _oled_ctx.column = 0;
                try raw_draw_x8(_cctx, _oled_ctx, _oled_ctx.buffer[start + i][0.._oled_ctx.end[start + i]]);
            }

            _oled_ctx.page = before_page;
            _oled_ctx.column = before_column;
        }

        pub fn raw_draw_font(comptime _cctx: Ct_Context, _oled_ctx: *OLED_Context, _index: u8) !void {
            switch (_oled_ctx.fontT) {
                .ascii6x8 => try raw_draw_x8(_cctx, _oled_ctx, &font.ascii.@"6x8"[_index]),
                .ascii16x8 => try raw_draw_x16(_cctx, _oled_ctx, &font.ascii.@"16x8"[_index]),
                .alician16x16 => try raw_draw_x16(_cctx, _oled_ctx, &font.alician.@"16x16"[_index]),
            }
        }

        pub fn raw_draw_char(comptime _cctx: Ct_Context, _oled_ctx: *OLED_Context, _char: u8) !void {
            const index = switch (_oled_ctx.fontT) {
                .ascii16x8, .ascii6x8 => if (_char < ' ' or _char > '~') 0 else if (_char < 'A') _char - ' ' else if (_char < 'a') _char - 'A' + 33 else _char - 'a' + 65,
                .alician16x16 => if (_char == '!') 1 else if (_char == '?') 2 else if ('a' < _char and _char < 'z') _char - 'a' else if ('A' < _char and _char < 'Z') _char - 'A' else 0,
            };
            try raw_draw_font(_cctx, _oled_ctx, index);
        }

        inline fn get_data_from_char(_oled_ctx: *OLED_Context, _char: u8) []const u8 {
            const index = switch (_oled_ctx.fontT) {
                .ascii16x8, .ascii6x8 => if (_char < ' ' or _char > '~') 0 else if (_char < 'A') _char - ' ' else if (_char < 'a') _char - 'A' + 33 else _char - 'a' + 65,
                .alician16x16 => if (_char == '!') 1 else if (_char == '?') 2 else if ('a' < _char and _char < 'z') _char - 'a' else if ('A' < _char and _char < 'Z') _char - 'A' else 0,
            };
            return switch (_oled_ctx.fontT) {
                .ascii6x8 => &font.ascii.@"6x8"[index],
                .ascii16x8 => &font.ascii.@"16x8"[index],
                .alician16x16 => &font.alician.@"16x16"[index],
            };
        }
        inline fn exp_raw_draw_string_line(comptime _cctx: Ct_Context, _oled_ctx: *OLED_Context, _line_char: []const u8) !void {
            if (_line_char.len == 0) return;
            const width: u8 = switch (_oled_ctx.fontT) {
                .ascii6x8 => 6,
                .ascii16x8 => 8,
                .alician16x16 => 16,
            };

            for (_line_char, 0..) |c, i| {
                const data = get_data_from_char(_oled_ctx, c);
                switch (_oled_ctx.fontT) {
                    .ascii6x8 => {
                        memcpy(u8, _oled_ctx.buffer[_oled_ctx.page][_oled_ctx.column + i * width ..], data);
                    },
                    .ascii16x8, .alician16x16 => {
                        memcpy(u8, _oled_ctx.buffer[_oled_ctx.page][_oled_ctx.column + i * width ..], data[0 .. data.len / 2]);
                        memcpy(u8, _oled_ctx.buffer[_oled_ctx.page + 1][_oled_ctx.column + i * width ..], data[data.len / 2 ..]);
                    },
                }
            }
            switch (_oled_ctx.fontT) {
                .ascii6x8 => {
                    _oled_ctx.end[_oled_ctx.page] = @truncate(@max(_oled_ctx.end[_oled_ctx.page], _oled_ctx.column + width * _line_char.len));
                    try raw_set_pos(_cctx, _oled_ctx.page, _oled_ctx.column);
                    try write_data(_cctx, _oled_ctx.buffer[_oled_ctx.page][_oled_ctx.column.._oled_ctx.end[_oled_ctx.page]]);
                },
                .ascii16x8, .alician16x16 => {
                    _oled_ctx.end[_oled_ctx.page] = @truncate(@max(_oled_ctx.end[_oled_ctx.page], _oled_ctx.column + width * _line_char.len));
                    _oled_ctx.end[_oled_ctx.page + 1] = @truncate(@max(_oled_ctx.end[_oled_ctx.page + 1], _oled_ctx.column + width * _line_char.len));
                    try raw_set_pos(_cctx, _oled_ctx.page, _oled_ctx.column);
                    try write_data(_cctx, _oled_ctx.buffer[_oled_ctx.page][_oled_ctx.column.._oled_ctx.end[_oled_ctx.page]]);
                    try raw_set_pos(_cctx, _oled_ctx.page + 1, _oled_ctx.column);
                    try write_data(_cctx, _oled_ctx.buffer[_oled_ctx.page + 1][_oled_ctx.column.._oled_ctx.end[_oled_ctx.page + 1]]);
                },
            }
            _oled_ctx.column += width * @as(u8, @truncate(_line_char.len));
        }
        inline fn split_use_line(comptime _cctx: Ct_Context, _oled_ctx: *OLED_Context, _substr: []const u8) !void {
            const width: u8 = switch (_oled_ctx.fontT) {
                .ascii6x8 => 6,
                .ascii16x8 => 8,
                .alician16x16 => 16,
            };
            const height: u8 = switch (_oled_ctx.fontT) {
                .ascii6x8 => 8 / 8,
                .ascii16x8 => 16 / 8,
                .alician16x16 => 16 / 8,
            };
            var char_len: u8 = 0;
            var max_char_in_line: u8 = (MAX_COLS - _oled_ctx.column) / width;
            while (max_char_in_line + char_len <= _substr.len) : (max_char_in_line = MAX_COLS / width) {
                try exp_raw_draw_string_line(_cctx, _oled_ctx, _substr[char_len .. char_len + max_char_in_line]);
                _oled_ctx.column = 0;
                _oled_ctx.page += height;
                char_len += max_char_in_line;
                if (_oled_ctx.page >= MAX_PAGES) try special_page_over(_cctx, _oled_ctx);
            }
            if (_substr.len - char_len > 0) {
                try exp_raw_draw_string_line(_cctx, _oled_ctx, _substr[char_len..]);
            }
        }

        inline fn special_page_over(comptime _cctx: Ct_Context, _oled_ctx: *OLED_Context) !void {
            const height: u8 = switch (_oled_ctx.fontT) {
                .ascii6x8 => 8 / 8,
                .ascii16x8 => 16 / 8,
                .alician16x16 => 16 / 8,
            };
            try raw_draw_buff(_cctx, _oled_ctx, height, MAX_PAGES - height);
            _oled_ctx.page = MAX_PAGES - height;
            _oled_ctx.record_page = if (_oled_ctx.record_page) |rp| (if (rp < height) 0 else rp - height) else null;
        }
        inline fn special_char_r(_oled_ctx: *OLED_Context) void {
            _oled_ctx.column = 0;
        }
        inline fn special_char_n(comptime _cctx: Ct_Context, _oled_ctx: *OLED_Context) !void {
            const height: u8 = switch (_oled_ctx.fontT) {
                .ascii6x8 => 8 / 8,
                .ascii16x8 => 16 / 8,
                .alician16x16 => 16 / 8,
            };
            // try raw_draw_line_zero(_cctx, _oled_ctx); TODO different font,different line
            _oled_ctx.page += height;
            _oled_ctx.column = 0;

            if (_oled_ctx.page >= MAX_PAGES) try special_page_over(_cctx, _oled_ctx);
        }
        inline fn special_char_0(_oled_ctx: *OLED_Context) void {
            if (_oled_ctx.record_column) |rc| {
                _oled_ctx.column = rc;
            } else {
                _oled_ctx.record_column = _oled_ctx.column;
            }
            if (_oled_ctx.record_page) |rp| {
                _oled_ctx.page = rp;
            } else {
                _oled_ctx.record_page = _oled_ctx.page;
            }
        }
        pub fn raw_draw_string(comptime _cctx: Ct_Context, _oled_ctx: *OLED_Context, _str: []const u8) !void {
            var split_iter = mem.splitAny(u8, _str, "\x00\n\r");
            const first = split_iter.first();
            if (first.len != 0)
                try split_use_line(_cctx, _oled_ctx, first);
            if (_str.len > first.len) {
                if (_str[first.len] == '\x00') special_char_0(_oled_ctx);
                if (_str[first.len] == '\n') try special_char_n(_cctx, _oled_ctx);
                if (_str[first.len] == '\r') special_char_r(_oled_ctx);
            }

            while (split_iter.next()) |substr| {
                if (substr.len != 0)
                    try split_use_line(_cctx, _oled_ctx, substr);
                if (split_iter.index) |index| {
                    if (_str[index] == '\x00') special_char_0(_oled_ctx);
                    if (_str[index] == '\n') try special_char_n(_cctx, _oled_ctx);
                    if (_str[index] == '\r') special_char_r(_oled_ctx);
                }
            }
        }

        pub fn generate_write_fn(comptime _cctx: Ct_Context) type {
            return struct {
                pub fn raw_write(_oled_ctx: *OLED_Context, _str: []const u8) anyerror!usize {
                    try raw_draw_string(_cctx, _oled_ctx, _str);
                    return _str.len;
                }
            };
        }

        pub fn writer(
            comptime _cctx: Ct_Context,
            _oled_ctx: *OLED_Context,
        ) io.GenericWriter(
            *OLED_Context,
            anyerror,
            generate_write_fn(_cctx).raw_write,
        ) {
            return io.GenericWriter(*OLED_Context, anyerror, generate_write_fn(_cctx).raw_write){ .context = _oled_ctx };
        }
    };
}

pub fn Spi_Dma(
    comptime _mcu: type,
    comptime _no: _mcu.spi.No,
    comptime _size: Size,
    comptime _nss_pos: _mcu.gpio.Pos,
    comptime _dc_pos: _mcu.gpio.Pos,
    comptime _res_pos: _mcu.gpio.Pos,
    _rctx: *_mcu.ctx.Rt_Context,
) type {
    const tick = _mcu.sys.tick;
    const MAX_PAGES = get_pages(_size);
    const MAX_COLS = get_cols(_size);
    const spi = @field(_mcu.spi, @tagName(_no));
    const Ct_Context = _mcu.ctx.Ct_Context;
    const spi_reg = spi.reg_spi();
    const nss = _mcu.gpio.Pin(_nss_pos);
    const dc = _mcu.gpio.Pin(_dc_pos);
    const res = _mcu.gpio.Pin(_res_pos);
    return struct {
        pub const OLED_Context = struct {
            fontT: font.FontType = .ascii6x8,
            record_page: ?u8 = null,
            record_column: ?u8 = null,
            page: u8 = 0,
            column: u8 = 0,
            buffer: [MAX_PAGES][MAX_COLS]u8 = zeroes([MAX_PAGES][MAX_COLS]u8),
            end: [MAX_PAGES]u8 = zeroes([MAX_PAGES]u8),
        };
        pub const Error = error{Buff_Out_Of_Range};

        pub fn write_data(comptime _cctx: Ct_Context, _data: []const u8) !void {
            @field(_rctx.spi, "cfg" ++ @tagName(_no)) = get_spi_rt_config(_data);

            try tick.wait_until(
                _cctx,
                _rctx,
                10_000,
                spi_reg.SR_struct,
                spi_reg.SR,
                "BSY",
                0,
                null,
            );

            nss.ct_set(_cctx, _rctx, 1);
            dc.ct_set(_cctx, _rctx, 1);

            nss.ct_set(_cctx, _rctx, 0);
            try spi.dma_start(_cctx, _rctx);
        }
        pub fn write_data_Ntimes(comptime _cctx: Ct_Context, _value: u8, _times: u16) !void {
            @field(_rctx.spi, "cfg" ++ @tagName(_no)) = get_Ntimes_spi_rt_config(_value, _times);

            try tick.wait_until(
                _cctx,
                _rctx,
                10_000,
                spi_reg.SR_struct,
                spi_reg.SR,
                "BSY",
                0,
                null,
            );

            nss.ct_set(_cctx, _rctx, 1);
            dc.ct_set(_cctx, _rctx, 1);

            nss.ct_set(_cctx, _rctx, 0);
            try spi.dma_start(_cctx, _rctx);
        }
        var tmp_cmd_buff: [32]u8 = undefined;
        pub fn write_cmd(comptime _cctx: Ct_Context, _cmd: []const u8) !void {
            memcpy(u8, &tmp_cmd_buff, _cmd);
            @field(_rctx.spi, "cfg" ++ @tagName(_no)) = get_spi_rt_config(tmp_cmd_buff[0..@min(tmp_cmd_buff.len, _cmd.len)]);

            try tick.wait_until(
                _cctx,
                _rctx,
                10_000,
                spi_reg.SR_struct,
                spi_reg.SR,
                "BSY",
                0,
                null,
            );

            nss.ct_set(_cctx, _rctx, 1);
            dc.ct_set(_cctx, _rctx, 0);

            nss.ct_set(_cctx, _rctx, 0);
            try spi.dma_start(_cctx, _rctx);
        }
        pub fn display_off(comptime _cctx: Ct_Context) !void {
            const cmd = [_]u8{ 0x8D, 0x10, 0xAE };
            try write_cmd(_cctx, &cmd);
        }
        pub fn display_on(comptime _cctx: Ct_Context) !void {
            const cmd = [_]u8{ 0x8D, 0x14, 0xAF };
            try write_cmd(_cctx, &cmd);
        }
        pub fn raw_set_pos(comptime _cctx: Ct_Context, _page: u8, _column: u8) !void {
            const cmd = [_]u8{ _column & 0xF, 0x10 | ((_column & 0xF0) >> 4), 0xB0 + _page };
            try write_cmd(_cctx, &cmd);
        }
        pub fn raw_fill_line_zero(comptime _cctx: Ct_Context, _line: u8) !void {
            try raw_set_pos(_cctx, _line, 0);
            try write_data_Ntimes(_cctx, 0, MAX_COLS);
        }
        pub fn raw_fill_zero(
            comptime _cctx: Ct_Context,
        ) !void {
            for (0..MAX_PAGES) |i| {
                try raw_fill_line_zero(_cctx, @truncate(i));
            }
        }
        pub fn raw_fill(comptime _cctx: Ct_Context, _map: [MAX_PAGES][MAX_COLS]u8) !void {
            for (0..MAX_PAGES) |i| {
                try raw_set_pos(_cctx, i, 0);
                try write_data(_cctx, &_map[i]);
            }
        }

        fn spi_tx_dma_it_gf(comptime _cctx: Ct_Context) fn () void {
            const spi_dma_ch = spi.tx_dma_ch();
            const dc_pos = comptime spi_dma_ch.get_pos();
            const d = spi_dma_ch.reg_dma();
            return struct {
                pub fn f() void {
                    defer spi_dma_ch.clear_it_flag(_cctx, _rctx);

                    if (@field(d.ISR, "TCIF" ++ @tagName(dc_pos.ch)) == 0b1) {
                        tick.wait_until(
                            _cctx,
                            _rctx,
                            10_000,
                            spi_reg.SR_struct,
                            spi_reg.SR,
                            "BSY",
                            0,
                            null,
                        ) catch {};
                        spi.dma_stop(_cctx, _rctx);
                        nss.ct_set(_cctx, _rctx, 1);
                    }
                }
            }.f;
        }
        /// Usage:
        ///
        /// const o = ssd1306.Spi(_mcu,.@"1",.@"0.91inch",.{.port = .A,.pin = .@"0"},.{.port = .A,.pin = .@"1"},.{.port = .A,.pin = .@"2"});
        ///
        /// const cfg = o.get_spi_ct_config();
        pub fn get_spi_ct_config() _mcu.spi.Spi_Ct_Config {
            return comptime .{
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
            };
        }
        pub fn get_spi_rt_config(_data: []const u8) _mcu.spi.Spi_Rt_Config {
            return .{
                .tx_cfg = .{
                    .ma = @intFromPtr(_data.ptr),
                    .ndt = @truncate(_data.len),
                    .circ = .disable,
                    .minc = .enable,
                },
            };
        }
        var global_value: u8 = 0;
        pub fn get_Ntimes_spi_rt_config(_value: u8, _times: u16) _mcu.spi.Spi_Rt_Config {
            global_value = _value;
            return .{
                .tx_cfg = .{
                    .ma = @intFromPtr(&global_value),
                    .ndt = _times,
                    .circ = .disable,
                    .minc = .disable,
                },
            };
        }
        pub fn get_pin_config() _mcu.gpio.Pin_Ct_Config {
            return comptime .{ .Output = .{ .mode = .PP, .speed = .@"50MHz", .level = .high } };
        }
        pub fn use(_cctx: *Ct_Context) void {
            const spi_cfg = get_spi_ct_config();
            const pin_cfg = get_pin_config();
            if (@field(&_cctx.spi, "cfg" ++ @tagName(_no)) == null) {
                @field(&_cctx.spi, "cfg" ++ @tagName(_no)) = spi_cfg;
            }
            spi.use(_cctx);
            nss.use(_cctx, pin_cfg);
            dc.use(_cctx, pin_cfg);
            res.use(_cctx, pin_cfg);
        }
        pub fn init(comptime _cctx: Ct_Context) !void {
            const pin_cfg = comptime get_pin_config();
            try nss.config(_cctx, _rctx, pin_cfg);
            try dc.config(_cctx, _rctx, pin_cfg);
            try res.config(_cctx, _rctx, pin_cfg);
            try spi.config(_cctx, _rctx);

            res.ct_set(_cctx, _rctx, 1);
            tick.delay_us(_cctx, _rctx, 100_000);
            res.ct_set(_cctx, _rctx, 0);
            tick.delay_us(_cctx, _rctx, 200_000);
            res.ct_set(_cctx, _rctx, 1);

            try display_off(_cctx);

            const cmd = [_]u8{
                0x00, 0x10, 0x40, 0x81, 0xCF, 0xA1, 0xC8, 0xA6,
                0xA8, 0x3f, 0xD3, 0x00, 0xD5, 0x80, 0xD9, 0xF1,
                0xDA, 0x12, 0xDB, 0x40, 0x20, 0x02, 0x8D, 0x14,
                0xA4, 0xA6,
            };
            try write_cmd(_cctx, &cmd);

            try raw_fill_zero(_cctx);

            try display_on(_cctx);
        }

        pub fn raw_draw_line_zero(comptime _cctx: Ct_Context, _oled_ctx: *OLED_Context) !void {
            _oled_ctx.end[_oled_ctx.page] = _oled_ctx.column;
            try raw_set_pos(_cctx, _oled_ctx.page, _oled_ctx.column);
            @memset(_oled_ctx.buffer[_oled_ctx.page][_oled_ctx.column..], 0);
            try write_data_Ntimes(_cctx, 0, MAX_COLS - _oled_ctx.column);
        }
        pub fn raw_draw_x8(comptime _cctx: Ct_Context, _oled_ctx: *OLED_Context, _data: []const u8) !void {
            const expected_end_cols = _oled_ctx.column + _data.len;
            const end_data_index: u8 = if (expected_end_cols <= MAX_COLS) @truncate(_data.len) else MAX_COLS - _oled_ctx.column;

            _oled_ctx.end[_oled_ctx.page] = @max(_oled_ctx.end[_oled_ctx.page], end_data_index + _oled_ctx.column);
            memcpy(u8, _oled_ctx.buffer[_oled_ctx.page][_oled_ctx.column..], _data[0..end_data_index]);

            try raw_set_pos(_cctx, _oled_ctx.page, _oled_ctx.column);
            try write_data(_cctx, _oled_ctx.buffer[_oled_ctx.page][_oled_ctx.column..][0..end_data_index]);
        }
        pub fn raw_draw_x16(comptime _cctx: Ct_Context, _oled_ctx: *OLED_Context, _data: []const u8) !void {
            var oled_ctx = _oled_ctx.*; // to keep the page not change
            try raw_draw_x8(_cctx, &oled_ctx, _data[0 .. _data.len / 2]);
            oled_ctx.page += 1;
            try raw_draw_x8(_cctx, &oled_ctx, _data[_data.len / 2 ..]);
        }
        pub fn raw_draw_buff(comptime _cctx: Ct_Context, _oled_ctx: *OLED_Context, start: u8, delta: u8) anyerror!void {
            try raw_fill_zero(_cctx);
            const before_page = _oled_ctx.page;
            const before_column = _oled_ctx.column;

            for (0..delta) |i| {
                if (start + i >= MAX_PAGES) return Error.Buff_Out_Of_Range;
                _oled_ctx.page = @truncate(i);
                _oled_ctx.column = 0;
                try raw_draw_x8(_cctx, _oled_ctx, _oled_ctx.buffer[start + i][0.._oled_ctx.end[start + i]]);
            }

            _oled_ctx.page = before_page;
            _oled_ctx.column = before_column;
        }

        pub fn raw_draw_font(comptime _cctx: Ct_Context, _oled_ctx: *OLED_Context, _index: u8) !void {
            switch (_oled_ctx.fontT) {
                .ascii6x8 => try raw_draw_x8(_cctx, _oled_ctx, &font.ascii.@"6x8"[_index]),
                .ascii16x8 => try raw_draw_x16(_cctx, _oled_ctx, &font.ascii.@"16x8"[_index]),
                .alician16x16 => try raw_draw_x16(_cctx, _oled_ctx, &font.alician.@"16x16"[_index]),
            }
        }

        pub fn raw_draw_char(comptime _cctx: Ct_Context, _oled_ctx: *OLED_Context, _char: u8) !void {
            const index = switch (_oled_ctx.fontT) {
                .ascii16x8, .ascii6x8 => if (_char < ' ' or _char > '~') 0 else if (_char < 'A') _char - ' ' else if (_char < 'a') _char - 'A' + 33 else _char - 'a' + 65,
                .alician16x16 => if (_char == '!') 1 else if (_char == '?') 2 else if ('a' < _char and _char < 'z') _char - 'a' else if ('A' < _char and _char < 'Z') _char - 'A' else 0,
            };
            try raw_draw_font(_cctx, _oled_ctx, index);
        }

        inline fn get_data_from_char(_oled_ctx: *OLED_Context, _char: u8) []const u8 {
            const index = switch (_oled_ctx.fontT) {
                .ascii16x8, .ascii6x8 => if (_char < ' ' or _char > '~') 0 else if (_char < 'A') _char - ' ' else if (_char < 'a') _char - 'A' + 33 else _char - 'a' + 65,
                .alician16x16 => if (_char == '!') 1 else if (_char == '?') 2 else if ('a' < _char and _char < 'z') _char - 'a' else if ('A' < _char and _char < 'Z') _char - 'A' else 0,
            };
            return switch (_oled_ctx.fontT) {
                .ascii6x8 => &font.ascii.@"6x8"[index],
                .ascii16x8 => &font.ascii.@"16x8"[index],
                .alician16x16 => &font.alician.@"16x16"[index],
            };
        }
        inline fn exp_raw_draw_string_line(comptime _cctx: Ct_Context, _oled_ctx: *OLED_Context, _line_char: []const u8) !void {
            if (_line_char.len == 0) return;
            const width: u8 = switch (_oled_ctx.fontT) {
                .ascii6x8 => 6,
                .ascii16x8 => 8,
                .alician16x16 => 16,
            };

            for (_line_char, 0..) |c, i| {
                const data = get_data_from_char(_oled_ctx, c);
                switch (_oled_ctx.fontT) {
                    .ascii6x8 => {
                        memcpy(u8, _oled_ctx.buffer[_oled_ctx.page][_oled_ctx.column + i * width ..], data);
                    },
                    .ascii16x8, .alician16x16 => {
                        memcpy(u8, _oled_ctx.buffer[_oled_ctx.page][_oled_ctx.column + i * width ..], data[0 .. data.len / 2]);
                        memcpy(u8, _oled_ctx.buffer[_oled_ctx.page + 1][_oled_ctx.column + i * width ..], data[data.len / 2 ..]);
                    },
                }
            }
            const data_len: u32 = width * _line_char.len;
            switch (_oled_ctx.fontT) {
                .ascii6x8 => {
                    _oled_ctx.end[_oled_ctx.page] = @truncate(@max(_oled_ctx.end[_oled_ctx.page], _oled_ctx.column + data_len));
                    try raw_set_pos(_cctx, _oled_ctx.page, _oled_ctx.column);
                    try write_data(_cctx, _oled_ctx.buffer[_oled_ctx.page][_oled_ctx.column..][0..data_len]);
                    _oled_ctx.column = _oled_ctx.end[_oled_ctx.page];
                },
                .ascii16x8, .alician16x16 => {
                    _oled_ctx.end[_oled_ctx.page] = @truncate(@max(_oled_ctx.end[_oled_ctx.page], _oled_ctx.column + data_len));
                    _oled_ctx.end[_oled_ctx.page + 1] = @truncate(@max(_oled_ctx.end[_oled_ctx.page + 1], _oled_ctx.column + data_len));
                    try raw_set_pos(_cctx, _oled_ctx.page, _oled_ctx.column);
                    try write_data(_cctx, _oled_ctx.buffer[_oled_ctx.page][_oled_ctx.column..][0..data_len]);
                    try raw_set_pos(_cctx, _oled_ctx.page + 1, _oled_ctx.column);
                    try write_data(_cctx, _oled_ctx.buffer[_oled_ctx.page + 1][_oled_ctx.column..][0..data_len]);
                },
            }
            _oled_ctx.column += @as(u8, @truncate(data_len));
        }
        inline fn split_use_line(comptime _cctx: Ct_Context, _oled_ctx: *OLED_Context, _substr: []const u8) !void {
            const width: u8 = switch (_oled_ctx.fontT) {
                .ascii6x8 => 6,
                .ascii16x8 => 8,
                .alician16x16 => 16,
            };
            const height: u8 = switch (_oled_ctx.fontT) {
                .ascii6x8 => 8 / 8,
                .ascii16x8 => 16 / 8,
                .alician16x16 => 16 / 8,
            };
            var char_len: u8 = 0;
            var max_char_in_line: u8 = (MAX_COLS - _oled_ctx.column) / width;
            while (max_char_in_line + char_len <= _substr.len) : (max_char_in_line = MAX_COLS / width) {
                try exp_raw_draw_string_line(_cctx, _oled_ctx, _substr[char_len .. char_len + max_char_in_line]);
                _oled_ctx.column = 0;
                _oled_ctx.page += height;
                char_len += max_char_in_line;
                if (_oled_ctx.page >= MAX_PAGES) try special_page_over(_cctx, _oled_ctx);
            }
            if (_substr.len > char_len) {
                try exp_raw_draw_string_line(_cctx, _oled_ctx, _substr[char_len..]);
            }
        }

        inline fn special_page_over(comptime _cctx: Ct_Context, _oled_ctx: *OLED_Context) !void {
            const height: u8 = switch (_oled_ctx.fontT) {
                .ascii6x8 => 8 / 8,
                .ascii16x8 => 16 / 8,
                .alician16x16 => 16 / 8,
            };
            try raw_draw_buff(_cctx, _oled_ctx, height, MAX_PAGES - height);
            _oled_ctx.page = MAX_PAGES - height;
            _oled_ctx.record_page = if (_oled_ctx.record_page) |rp| (if (rp < height) 0 else rp - height) else null;
        }
        inline fn special_char_r(_oled_ctx: *OLED_Context) void {
            _oled_ctx.column = 0;
        }
        inline fn special_char_n(comptime _cctx: Ct_Context, _oled_ctx: *OLED_Context) !void {
            const height: u8 = switch (_oled_ctx.fontT) {
                .ascii6x8 => 8 / 8,
                .ascii16x8 => 16 / 8,
                .alician16x16 => 16 / 8,
            };
            // try raw_draw_line_zero(_cctx, _oled_ctx); TODO different font,different line
            _oled_ctx.page += height;
            _oled_ctx.column = 0;

            if (_oled_ctx.page >= MAX_PAGES) try special_page_over(_cctx, _oled_ctx);
        }
        inline fn special_char_0(_oled_ctx: *OLED_Context) void {
            if (_oled_ctx.record_column) |rc| {
                _oled_ctx.column = rc;
            } else {
                _oled_ctx.record_column = _oled_ctx.column;
            }
            if (_oled_ctx.record_page) |rp| {
                _oled_ctx.page = rp;
            } else {
                _oled_ctx.record_page = _oled_ctx.page;
            }
        }
        pub fn raw_draw_string(comptime _cctx: Ct_Context, _oled_ctx: *OLED_Context, _str: []const u8) !void {
            var split_iter = mem.splitAny(u8, _str, "\x00\n\r");
            const first = split_iter.first();
            if (first.len != 0)
                try split_use_line(_cctx, _oled_ctx, first);
            if (_str.len > first.len) {
                if (_str[first.len] == '\x00') special_char_0(_oled_ctx);
                if (_str[first.len] == '\n') try special_char_n(_cctx, _oled_ctx);
                if (_str[first.len] == '\r') special_char_r(_oled_ctx);
            }

            while (split_iter.next()) |substr| {
                if (substr.len != 0)
                    try split_use_line(_cctx, _oled_ctx, substr);
                if (split_iter.index) |index| {
                    if (_str[index] == '\x00') special_char_0(_oled_ctx);
                    if (_str[index] == '\n') try special_char_n(_cctx, _oled_ctx);
                    if (_str[index] == '\r') special_char_r(_oled_ctx);
                }
            }
        }

        pub fn generate_write_fn(comptime _cctx: Ct_Context) type {
            return struct {
                pub fn raw_write(_oled_ctx: *OLED_Context, _str: []const u8) anyerror!usize {
                    try raw_draw_string(_cctx, _oled_ctx, _str);
                    return _str.len;
                }
            };
        }

        pub fn writer(
            comptime _cctx: Ct_Context,
            _oled_ctx: *OLED_Context,
        ) io.GenericWriter(
            *OLED_Context,
            anyerror,
            generate_write_fn(_cctx).raw_write,
        ) {
            return io.GenericWriter(*OLED_Context, anyerror, generate_write_fn(_cctx).raw_write){ .context = _oled_ctx };
        }
    };
}
