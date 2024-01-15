const std = @import("std");

pub fn isArmstrongNumber(num: u128) bool {
    if (num == 0) {
        return true;
    }

    const digits: usize = blk: {
        var digits = std.math.log10_int(num);
        const is_pow10 = num - std.math.pow(u128, 10, digits) == 0;
        digits += @intFromBool(!is_pow10);
        break :blk digits;
    };

    var sum: u128 = 0;
    var n = num;
    for (0..digits) |_| {
        sum += std.math.powi(u128, n % 10, digits) catch unreachable;
        n /= 10;
    }
    return sum == num;
}

// tests
const testing = std.testing;

test "zero is an armstrong number" {
    try testing.expect(isArmstrongNumber(0));
}

test "single-digit numbers are armstrong numbers" {
    try testing.expect(isArmstrongNumber(5));
}

test "there are no two-digit armstrong numbers" {
    try testing.expect(!isArmstrongNumber(10));
}

test "three-digit number that is an armstrong number" {
    try testing.expect(isArmstrongNumber(153));
}

test "three-digit number that is not an armstrong number" {
    try testing.expect(!isArmstrongNumber(100));
}

test "four-digit number that is an armstrong number" {
    try testing.expect(isArmstrongNumber(9_474));
}

test "four-digit number that is not an armstrong number" {
    try testing.expect(!isArmstrongNumber(9_475));
}

test "seven-digit number that is an armstrong number" {
    try testing.expect(isArmstrongNumber(9_926_315));
}

test "seven-digit number that is not an armstrong number" {
    try testing.expect(!isArmstrongNumber(9_926_314));
}

test "33-digit number that is an armstrong number" {
    try testing.expect(isArmstrongNumber(186_709_961_001_538_790_100_634_132_976_990));
}

test "38-digit number that is not an armstrong number" {
    try testing.expect(!isArmstrongNumber(99_999_999_999_999_999_999_999_999_999_999_999_999));
}

test "the largest and last armstrong number" {
    try testing.expect(isArmstrongNumber(115_132_219_018_763_992_565_095_597_973_971_522_401));
}

test "the largest 128-bit unsigned integer value is not an armstrong number" {
    try testing.expect(!isArmstrongNumber(340_282_366_920_938_463_463_374_607_431_768_211_455));
}
