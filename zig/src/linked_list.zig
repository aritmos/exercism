const std = @import("std");

pub fn LinkedList(comptime T: type) type {
    return struct {
        const Self = @This();

        pub const Node = struct {
            const NSelf = @This();

            prev: ?*Node = null,
            next: ?*Node = null,
            data: T,
        };

        first: ?*Node = null,
        last: ?*Node = null,
        len: usize = 0,

        pub fn push(self: *Self, node: *Node) void {
            node.prev = self.last;
            node.next = null;

            if (self.first == null) self.first = node;
            if (self.last != null) self.last.?.next = node;

            self.last = node;
            self.len += 1;
        }

        pub fn pop(self: *Self) ?*Node {
            if (self.len == 0) return null;

            const node = self.last.?;
            self.last = node.prev;

            if (self.first == node) self.first = null;
            self.len -= 1;

            return node;
        }

        // pop front
        pub fn shift(self: *Self) ?*Node {
            if (self.len == 0) return null;
            const node = self.first.?;
            self.first = node.next;

            if (self.last == node) self.last = null;

            self.len -= 1;
            return node;
        }

        pub fn unshift(self: *Self, node: *Node) void {
            node.prev = null;
            node.next = self.first;

            if (self.first) |first| first.prev = node else self.last = node;
            self.first = node;

            self.len += 1;
        }

        // removes the first node holding the `data` value (if it exists).
        pub fn delete(self: *Self, node: *Node) void {
            const data = node.data;
            var current = self.first;
            while (current) |curr| : (current = curr.next) {
                if (current.?.data != data) continue;
                if (curr.prev) |prev| prev.next = curr.next else self.first = curr.next;
                if (curr.next) |next| next.prev = curr.prev else self.last = curr.prev;
                self.len -= 1;
                return;
            }
        }
    };
}

/// Proper allocator-backed implementation
pub fn ManagedLinkedList(comptime T: type, _: std.mem.Allocator) type {
    return struct {
        const Self = @This();

        pub const Node = struct {
            const NSelf = @This();

            prev: ?*Node = null,
            next: ?*Node = null,
            data: T,
        };

        first: ?*Node = null,
        last: ?*Node = null,
        len: usize = 0,

        pub fn push(self: *Self, node: *Node) void {
            node.prev = self.last;
            node.next = null;

            if (self.first == null) self.first = node;
            if (self.last != null) self.last.?.next = node;

            self.last = node;
            self.len += 1;
        }

        pub fn pop(self: *Self) ?*Node {
            if (self.len == 0) return null;

            const node = self.last.?;
            self.last = node.prev;

            if (self.first == node) self.first = null;
            self.len -= 1;

            return node;
        }

        // pop front
        pub fn shift(self: *Self) ?*Node {
            if (self.len == 0) return null;

            self.first = self.first.?.next;
            if (self.first) |first| first.prev = null else self.last = null;

            self.len -= 1;
            return self.first;
        }

        pub fn unshift(self: *Self, node: *Node) void {
            node.prev = null;
            node.next = self.first;

            if (self.last == null) {
                self.last = node;
            }
            self.first = node;
            self.len += 1;
        }

        // removes the first node holding the `data` value (if it exists).
        pub fn delete(self: *Self, node: *Node) void {
            const data = node.data;
            var current = self.first;
            while (current) |curr| : (current = curr.next) {
                if (current.?.data != data) continue;
                if (curr.prev) |prev| prev.next = curr.next else self.first = curr.next;
                if (curr.next) |next| next.prev = curr.prev else self.last = curr.prev;
                self.len -= 1;
                return;
            }
        }
    };
}
