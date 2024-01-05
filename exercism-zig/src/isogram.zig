const std = @import("std");

pub fn isIsogram(str: []const u8) bool {
    // the maximum allocation size is 26 (as the isogram is case agnostic)
    // hence we can just use a fixed buffer allocator:
    //  - entry size: key + val + 1 = 1 + 0 + 1 = 2
    //  - max entries: 26
    //  - load factor: 0.8 (default)
    //  -> total alloc buffer size: ceilPowerOfTwo(2 * 26 / 0.8) = 128 bytes
    //  - fixed hashmap data: 8 * 3 = 24 bytes
    //  -> total buffer size: 128 + 24 = 152 bytes
    var buffer: [152]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    var map = std.AutoHashMap(u8, void).init(fba.allocator());
    defer map.deinit();

    // ensure the hashmap grows to the required capacity
    map.ensureTotalCapacity(26) catch unreachable;

    for (str) |c_| {
        const c = std.ascii.toLower(c_);

        if (!std.ascii.isAlphabetic(c)) {
            continue;
        }

        if (map.contains(c)) {
            return false;
        } else {
            map.put(c, {}) catch unreachable;
        }
    }
    return true;
}
