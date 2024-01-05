pub const DnaError = error{ UnequalDnaStrands, EmptyDnaStrands };

pub fn compute(first: []const u8, second: []const u8) DnaError!usize {
    if (first.len == 0 or second.len == 0) return DnaError.EmptyDnaStrands;
    if (first.len != second.len) return DnaError.UnequalDnaStrands;

    var hamming_distance: usize = 0;
    for (first, second) |a, b| {
        hamming_distance += @intFromBool(a != b);
    }

    return hamming_distance;
}
