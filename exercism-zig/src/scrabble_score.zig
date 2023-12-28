const ascii = @import("std").ascii;

/// Computes the score of a word in Scrabble
/// Safety: strings with non ascii alphabet characters result in undefined behaviour
pub fn score(s: []const u8) u32 {
    // create letter-value array for both lowercase and uppercase letters
    // (contains undefined values for symbols between 'Z' and 'a')
    const letter_values = comptime blk: {
        const LetterGroup = struct { []const u8, u8 }; // (letters, value)
        // zig fmt: off
        const letter_groups: []const LetterGroup = &.{ 
            .{ "AEIOULNRST", 1 },
            .{ "DG", 2 },
            .{ "BCMP", 3 },
            .{ "FHVWY", 4 },
            .{ "K", 5 },
            .{ "JX", 8 },
            .{ "QZ", 10 }
        };
        // zig fmt: on
        const arr_len = 'z' - 'A' + 1;
        var arr: [arr_len]u8 = undefined;
        for (letter_groups) |group| {
            for (group[0]) |letter| {
                arr[letter - 'A'] = group[1];
                arr[ascii.toLower(letter) - 'A'] = group[1];
            }
        }
        break :blk arr;
    };

    var sum: u32 = 0;
    for (s) |letter| {
        sum += letter_values[letter - 'A'];
    }
    return sum;
}
