const std = @import("std");

// pub fn build(b: *std.Build) void {
//     // const windows = b.option(bool, "windows", "Target Microsoft Windows") orelse false;

//     const exe_mod = b.createModule(.{
//         .root_source_file = b.path("hello.zig"),
//         // .target = b.resolveTargetQuery(.{
//         //     .os_tag = if (windows) .windows else null,
//         // }),
//         .target = b.standardTargetOptions(.{}),
//         .optimize = b.standardOptimizeOption(.{}),
//     });

//     const exe = b.addExecutable(.{
//         .name = "hello",
//         .root_module = exe_mod,
//     });

//     b.installArtifact(exe);

//     const run_exe = b.addRunArtifact(exe);

//     const run_step = b.step("run", "Run the application");
//     run_step.dependOn(&run_exe.step);
// }

// -----------------------------------
// ----- example: static library -----
// -----------------------------------

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const libfizzbuzz_mod = b.createModule(.{
        .root_source_file = b.path("fizzbuzz.zig"),
        .target = target,
        .optimize = optimize,
    });
    const libfizzbuzz = b.addStaticLibrary(.{
        .name = "fizzbuzz",
        .root_module = libfizzbuzz_mod,
    });
    b.installArtifact(libfizzbuzz);

    const exe_mod = b.createModule(.{
        .root_source_file = b.path("demo.zig"),
        .target = target,
        .optimize = optimize,
    });
    const exe = b.addExecutable(.{
        .name = "demo",
        .root_module = exe_mod,
    });

    exe.linkLibrary(libfizzbuzz);

    if (b.option(bool, "enable-demo", "install the demo too") orelse false) {
        b.installArtifact(exe);
    }
}
