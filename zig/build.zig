const std = @import("std");

pub fn build(b: *std.Build) void {
    // Define the src package for library files
    const src_mod = b.addModule("src", .{ .root_source_file = .{ .path = "src/hello_world.zig" } });

    // Define and add tests, including the src package
    const test_runner = b.addTest("tests/linked_list.zig");
    test_runner.addImport(src_pkg); // Use the src package in your tests
    b.default_step.dependOn(&test_runner.step);
}
