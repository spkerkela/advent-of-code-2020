const std = @import("std");

const expect = std.testing.expect;
const print = std.debug.print;
const Allocator = std.mem.Allocator;

pub fn run(values: []const i32) i32 {
    const pair = sums_to(values, 2020);
    return result(pair);
}

pub fn run_2(values: []const i32) i32 {
    const triumvirate = sums_to_triumvirate(values, 2020);
    return result_2(triumvirate);
}

pub fn sums_to_triumvirate(values: []const i32, sum: i32) [3]i32 {
    var arr = [_]i32{ 0, 0, 0 };
    for (values) |v, i| {
        const sub_slice = values[(i + 1)..];
        for (sub_slice) |v2, ii| {
            const subber_slice = sub_slice[(ii + 1)..];
            for (subber_slice) |v3| {
                if (v + v2 + v3 == sum) {
                    arr[0] = v;
                    arr[1] = v2;
                    arr[2] = v3;
                    return arr;
                }
            }
        }
    }
    return arr;
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

pub fn result_2(values: [3]i32) i32 {
    return values[0] * values[1] * values[2];
}

test "test finding values" {
    var array = [_]i32{
        1721, 979, 366, 299, 675, 1456,
    };
    var slice = array[0..];
    const ret = sums_to(slice, 2020);
    expect(ret[0] == 1721);
    expect(ret[1] == 299);

    const ret2 = sums_to_triumvirate(slice, 2020);
    expect(ret2[0] == 979);
    expect(ret2[1] == 366);
    expect(ret2[2] == 675);
}

test "finding result" {
    expect(result([2]i32{ 1721, 299 }) == 514579);
    expect(result_2([3]i32{ 979, 366, 675 }) == 241861950);
}
