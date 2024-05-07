pub const ChessboardError = error{IndexOutOfBounds};

pub fn square(index: usize) ChessboardError!u64 {
    if (index == 0 or index > 64) return ChessboardError.IndexOutOfBounds;
    return @as(u64, 1) << @as(u6, @truncate(index - 1));
}

pub fn total() u64 {
    // in the spirit of the question we compute the answer using `square`
    const result: u64 = comptime blk: {
        var sum: u64 = 0;
        for (1..65) |i| {
            sum += square(i) catch unreachable;
        }
        break :blk sum;
    };

    return result;
}
