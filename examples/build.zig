const std = @import("std");
const Build = std.Build;
const ChildProcess = std.process.Child;

const log = std.log.scoped(.For_F103C);

pub fn build(b: *Build) void {
    // Target STM32F103C8T6
    const target = b.standardTargetOptions(.{ .default_target = .{
        .cpu_arch = .thumb,
        .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m3 },
        .os_tag = .freestanding,
        .abi = .none,
    } });

    const optimize = b.standardOptimizeOption(.{});

    var lazy_path = b.path(".");

    const full_path = lazy_path.getPath(b);

    // open dir
    var dir = std.fs.openDirAbsolute(full_path, .{ .iterate = true }) catch |err| {
        log.err("open path failed, err is {}", .{err});
        std.process.exit(1);
    };
    defer dir.close();

    // make a iterate for release ath
    var iterate = dir.iterate();

    while (iterate.next()) |val| {
        if (val) |entry| {
            // get the entry name, entry can be file or directory
            const name = entry.name;
            if (entry.kind == .directory) {

                // build cwd
                const cwd = std.fs.path.join(b.allocator, &[_][]const u8{
                    full_path,
                    name,
                }) catch |err| {
                    log.err("fmt path for examples failed, err is {}", .{err});
                    std.process.exit(1);
                };
                defer b.allocator.free(cwd);

                // open entry dir
                const entry_dir = std.fs.openDirAbsolute(cwd, .{}) catch unreachable;
                entry_dir.access("main.zig", .{}) catch {
                    log.warn("not found main.zig in path {s}", .{cwd});
                    continue;
                };

                const elf_file_name = std.mem.concat(b.allocator, u8, &[_][]const u8{ "f103.", name, ".elf" }) catch |err| {
                    log.err("create elf file failed, err is {}", .{err});
                    std.process.exit(1);
                };
                defer b.allocator.free(elf_file_name);
                const source_file = b.pathJoin(&[_][]const u8{ name, "main.zig" });
                const exe = b.addExecutable(.{
                    .name = elf_file_name,
                    .root_source_file = b.path(source_file),
                    .optimize = optimize,
                    .target = target,
                });
                exe.root_module.addAnonymousImport("stm32", .{
                    .root_source_file = b.path("../stm32/stm32.zig"),
                    .target = target,
                    .optimize = optimize,
                });
                exe.root_module.addAnonymousImport("plugins", .{
                    .root_source_file = b.path("../plugins/plugins.zig"),
                    .target = target,
                    .optimize = optimize,
                });
                exe.setLinkerScriptPath(b.path("l.ld"));

                b.installArtifact(exe);
            }
        } else {
            // Stop endless loop
            break;
        }
    } else |err| {
        log.err("iterate examples_path failed, err is {}", .{err});
        std.process.exit(1);
    }
}
