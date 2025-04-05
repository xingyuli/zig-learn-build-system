const std = @import("std");

pub fn build(b: *std.Build) void {
    const exe_mod = b.createModule(.{
        .root_source_file = b.path("hello.zig"),
        .target = b.standardTargetOptions(.{}),
        // .optimize = b.standardOptimizeOption(.{}),
    });

    const exe = b.addExecutable(.{
        .name = "hello",
        .root_module = exe_mod,
    });

    b.installArtifact(exe);

    const run_exe = b.addRunArtifact(exe);

    const run_step = b.step("run", "Run the application");
    run_step.dependOn(&run_exe.step);
}
