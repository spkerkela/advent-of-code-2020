const std = @import("std");

const expect = std.testing.expect;
const print = std.debug.print;
const Allocator = std.mem.Allocator;

pub fn run(allocator: *Allocator, values: []const i32) i32 {
    const pair = sums_to(values, 2020);
    return result(pair);
}

pub fn sums_to(values: []const i32, sum: i32) [2]i32 {
    var arr = [_]i32{ 0, 0 };
    for (values) |v, i| {
        const sub_slice = values[(i + 1)..];
        for (sub_slice) |v2| {
            if (v + v2 == sum) {
                arr[0] = v;
                arr[1] = v2;
                return arr;
            }
        }
    }
    return arr;
}

pub fn result(values: [2]i32) i32 {
    return values[0] * values[1];
}

test "does not crash" {
    try run(std.testing.allocator);
}

test "test finding values" {
    var array = [_]i32{
        1721, 979, 366, 299, 675, 1456,
    };
    var slice = array[0..];
    const ret = sums_to(slice, 2020);
    expect(ret[0] == 1721);
    expect(ret[1] == 299);
}

test "finding result" {
    expect(result([2]i32{ 1721, 299 }) == 514579);
}
