const std = @import("std");
const testing = std.testing;

const errors = @import("errors.zig");

const pcap = @cImport({
    @cInclude("pcap/pcap.h");
});

pub fn _dispatch(handle: ?*pcap.pcap_t, packets: c_int, comptime callback: (fn (args: [*c]u8, headers: [*c]const pcap.pcap_pkthdr, packet: [*c]const u8) callconv(.C) void)) !void {
    pcap.pcap_dispatch(handle, packets, callback, null);
}

pub fn _loop(handle: ?*pcap.pcap_t, packets: c_int, comptime callback: (fn (args: [*c]u8, headers: [*c]const pcap.pcap_pkthdr, packet: [*c]const u8) callconv(.C) void)) !void {
    _ = pcap.pcap_loop(handle, packets, callback, null);
}
