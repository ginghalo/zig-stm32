const std = @import("std");

pub inline fn modify_1b1(comptime _T: type, comptime _ptr: *volatile _T, comptime _value: anytype) _T {
    const v_info = @typeInfo(@TypeOf(_value));

    comptime for (v_info.Struct.fields) |field| {
        if (@hasField(_T, field.name) == false) @compileError("Field name `" ++ field.name ++ "` does not exsits in " ++ @typeName(_T));
    };
    if (v_info != .Struct) @compileError("Not the type of struct!");

    inline for (v_info.Struct.fields) |field| {
        const item = @field(_value, field.name);
        @field(_ptr, field.name) = item;
    }

    return _ptr.*;
}

pub inline fn modify(comptime _T: type, comptime _ptr: *volatile _T, comptime _value: anytype) _T {
    const v_info = @typeInfo(@TypeOf(_value));

    var tmp = _ptr.*;

    comptime for (v_info.Struct.fields) |field| {
        if (@hasField(_T, field.name) == false) @compileError("Field name `" ++ field.name ++ "` does not exsits in " ++ @typeName(_T));
    };
    if (v_info != .Struct) @compileError("Not the type of struct!");

    inline for (v_info.Struct.fields) |field| {
        const item = @field(_value, field.name);
        @field(tmp, field.name) = item;
    }

    _ptr.* = tmp;

    return tmp;
}
pub inline fn rt_modify(comptime _T: type, comptime _ptr: *volatile _T, _value: anytype) _T {
    const v_info = @typeInfo(@TypeOf(_value));

    var tmp = _ptr.*;

    comptime for (v_info.Struct.fields) |field| {
        if (@hasField(_T, field.name) == false) @compileError("Field name `" ++ field.name ++ "` does not exsits in " ++ @typeName(_T));
    };
    if (v_info != .Struct) @compileError("Not the type of struct!");

    inline for (v_info.Struct.fields) |field| {
        const item = @field(_value, field.name);
        @field(tmp, field.name) = item;
    }

    _ptr.* = tmp;

    return tmp;
}

pub inline fn u_bit(comptime _T: type) type {
    return @Type(.{ .Int = .{
        .signedness = .unsigned,
        .bits = @bitSizeOf(_T),
    } });
}
pub inline fn type2uint(_v: anytype) u_bit(@TypeOf(_v)) {
    return @bitCast(_v);
}

pub inline fn eql(
    _a: anytype,
    _b: anytype,
    comptime _names: [][]const u8,
) bool {
    const a_info = @typeInfo(@TypeOf(_a));
    const b_info = @typeInfo(@TypeOf(_b));
    if (_names.len == 0) {
        inline for (if (a_info.Struct.fields.len < b_info.Struct.fields.len) a_info.Struct.fields else b_info.Struct.fields) |field|
            if (type2uint(@field(_a, field.name)) != type2uint(@field(_b, field.name)))
                return false;
    } else {
        inline for (_names) |name| {
            if (type2uint(@field(_a, name)) != type2uint(@field(_b, name)))
                return false;
        }
    }
    return true;
}

pub fn assert_difference(comptime _a: anytype, comptime _b: anytype) void {
    const a_info = @typeInfo(@TypeOf(_a));
    inline for (a_info.Struct.fields) |field| {
        if (@hasField(@TypeOf(_b), field.name) == true)
            if (std.meta.eql(@field(_a, field.name), @field(_b, field.name)) == false)
                @compileError("Field name `" ++ field.name ++ "` is not equal");
    }
}
