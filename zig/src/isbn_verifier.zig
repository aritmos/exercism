const std = @import("std");

// Validates an ISBN10 string.
// If there are hyphens, only allows for `0-000-00000-0` pattern.
// Any error in the ISBN10's representation returns false.
pub fn isValidIsbn10(s: []const u8) bool {
    const digits: [10]u8 = blk: {
        const isbn_kind = enum { Short, Long };
        const kind: isbn_kind = switch (s.len) {
            10 => isbn_kind.Short,
            13 => isbn_kind.Long,
            else => return false,
        };

        var digits: [10]u8 = undefined;
        switch (kind) {
            isbn_kind.Short => {
                // no hyphens
                inline for (0..9) |i| {
                    const b = s[i];
                    if (!std.ascii.isDigit(b)) return false;
                    digits[i] = b - '0';
                }
            },
            isbn_kind.Long => {
                // hyphen case
                inline for ([_]u8{ 1, 5, 11 }) |i| {
                    if (s[i] != '-') return false;
                }
                inline for ([_]u8{ 0, 2, 3, 4, 6, 7, 8, 9, 10 }, 0..) |ptr, i| {
                    const b = s[ptr];
                    if (!std.ascii.isDigit(b)) return false;
                    digits[i] = b - '0';
                }
            },
        }

        const b = s[s.len - 1];
        digits[9] = switch (b) {
            '0'...'9' => b - '0',
            'X' => 10,
            else => return false,
        };

        break :blk digits;
    };

    var sum: usize = 0;
    for (digits, 0..) |d, i| {
        sum += d * (10 - i);
    }

    return sum % 11 == 0;
}
