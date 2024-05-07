const std = @import("std");
const List = @import("src/linked_list.zig").LinkedList(usize);
const Node = List.Node;

pub fn main() void {
    var list = List{};
    std.debug.print("{}\n", .{list});
    var a: Node = .{ .data = 23 };
    var b: Node = .{ .data = 5 };
    list.push(&a);
    std.debug.print("{any}\n", .{list});
    list.push(&b);
    std.debug.print("{any}\n", .{list});
    std.debug.print("---\n", .{});
    std.debug.print("{any}\n", .{list.shift()});
    std.debug.print("{any}\n", .{list});
    std.debug.print("{any}\n", .{list.shift()});
}
