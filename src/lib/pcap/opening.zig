const std = @import("std");
const testing = std.testing;

const errors = @import("errors.zig");

const pcap = @cImport({
    @cInclude("pcap/pcap.h");
});

pub fn _openLive(device: [:0]const u8) !?*pcap.pcap_t {
    var errbuf: [pcap.PCAP_ERRBUF_SIZE]u8 = undefined;

    const handle: ?*pcap.pcap_t = pcap.pcap_open_live(device, 8192, 0, 1000, &errbuf);
    if (handle == null) {
        return errors.pcapErrors.PERM_DENIED;
    }
    return handle;
}

pub fn _close(handle: ?*pcap.pcap_t) void {
    pcap.pcap_close(handle);
}

test "Missing setcap permissions" {
    const dev: [:0]const u8 = "eth0";
    _ = _openLive(dev) catch |err| {
        try testing.expect(err == errors.pcapErrors.PERM_DENIED);
    };
}
