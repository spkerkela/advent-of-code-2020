const std = @import("std");
const day1 = @import("day1.zig");
const process = std.process;
const Allocator = std.mem.Allocator;
const ArrayList = std.ArrayList;

pub fn main() anyerror!void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    var arg_it = process.args();
    _ = arg_it.skip();

    const a = &arena.allocator;

    const inputFileName = try (arg_it.next(a) orelse {
        std.debug.warn("File name expected \n", .{});
        return error.InvalidArgs;
    });

    const file_contents = try std.fs.cwd().readFileAlloc(a, inputFileName, 1024);
    defer a.free(file_contents);

    var number_list = ArrayList(i32).init(a);
    defer number_list.deinit();

    var lines = std.mem.split(file_contents, "\n");
    while (lines.next()) |s| {
        const val = try std.fmt.parseInt(i32, s, 10);
        try number_list.append(val);
    }

    const result = day1.run(a, number_list.items);
    std.debug.print("{}\n", .{result});
}
