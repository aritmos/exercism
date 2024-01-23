const std = @import("std");
const EnumField = std.builtin.Type.EnumField;

// I wanted to try out comptime type generation for this exercise,
// deriving all of the necessary functionality from a single variable
// (`color_band_vals`).

const ColorVal = struct { []const u8, usize };
const color_band_vals: []const ColorVal = &.{
    .{ "black", 0 },
    .{ "brown", 1 },
    .{ "red", 2 },
    .{ "orange", 3 },
    .{ "yellow", 4 },
    .{ "green", 5 },
    .{ "blue", 6 },
    .{ "violet", 7 },
    .{ "grey", 8 },
    .{ "white", 9 },
};

pub const ColorBand = init: {
    var color_band_fields: [color_band_vals.len]EnumField = undefined;
    for (color_band_vals, 0..) |band, i| {
        color_band_fields[i] = EnumField{ .name = band[0], .value = band[1] };
    }
    break :init @Type(.{ .Enum = .{
        .tag_type = u8,
        .fields = &color_band_fields,
        .decls = &.{},
        .is_exhaustive = true,
    } });
};

pub fn colorCode(color: ColorBand) usize {
    return @intFromEnum(color);
}

pub fn colors() []const ColorBand {
    return std.enums.values(ColorBand);
}
