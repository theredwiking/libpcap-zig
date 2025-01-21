const std = @import("std");

const pcap = @import("lib/pcap.zig");

const assert = std.debug.assert;

fn callbackFn(args: [*c]u8, headers: [*c]const pcap.pcap_pkthdr, packet: [*c]const u8) callconv(.C) void {
    _ = args;
    _ = packet;
    std.debug.print("Capture lenght: {any}\n", .{headers.*.caplen});
    std.debug.print("Packet lenght: {any}\n", .{headers.*.len});
    std.debug.print("Captured at lenght: {any}\n", .{headers.*.ts.tv_sec});
}

//TODO: Add ctr+c to close correctly
pub fn main() !void {
    const stdout_file = std.io.getStdOut().writer();
    const stderr_file = std.io.getStdErr().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    var bew = std.io.bufferedWriter(stderr_file);
    const stdout = bw.writer();
    const stderr = bew.writer();

    const devs: [:0]const u8 = "wlp0s20f3";

    const handle = pcap.openLive(devs) catch |err| {
        assert(err == pcap.Errors.PERM_DENIED);
        try stderr.print("Device: {s}, Either missing setcap or missing permissions\n", .{devs});
        try bew.flush();
        return;
    };

    defer pcap.close(handle);

    if (pcap.datalink(handle) != pcap.DLT.EN10MB) {
        try stderr.print("Device {s} does not provide Ethernet headers - Not supported\n", .{devs});
        try bew.flush();
        return;
    }

    try pcap.loop(handle, -1, callbackFn);

    try stdout.print("Success\n", .{});
    try bw.flush();
}
