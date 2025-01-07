const std = @import("std");
const Build = std.Build;
const ChildProcess = std.process.Child;

pub fn build(b: *Build) void {
    _ = b.addModule("stm32", .{
        .root_source_file = b.path("stm32/stm32.zig"),
    });
    _ = b.addModule("plugins", .{
        .root_source_file = b.path("plugins/plugins.zig"),
    });
}
