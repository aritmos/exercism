const std = @import("std");

pub fn isPangram(str: []const u8) bool {
    var seen = std.bit_set.IntegerBitSet(26).initEmpty();
    for (str) |char| {
        const c = std.ascii.toLower(char);
        if (!std.ascii.isAlphabetic(c)) continue;
        seen.set(std.ascii.toLower(c) - 'a');
    }
    return seen.count() == 26;
}
