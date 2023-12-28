pub fn isLeapYear(year: u32) bool {
    // true return conditions:
    // 1 0 0
    // 1 1 1
    // 1 0 1 (cannot exist)
    return (year % 4 == 0) and ((year % 100 == 0) == (year % 400 == 0));
}
