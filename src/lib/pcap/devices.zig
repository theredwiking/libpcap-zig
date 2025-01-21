const std = @import("std");
const testing = std.testing;

const errors = @import("errors.zig");

const pcap = @cImport({
    @cInclude("pcap/pcap.h");
});

pub fn _findalldevs() !void {
    var errbuf: [pcap.PCAP_ERRBUF_SIZE]u8 = undefined;
    var devs: [*c]pcap.pcap_if_t = undefined;

    const result: c_int = pcap.pcap_findalldevs(&devs, &errbuf);
    if (result == -1) {
        std.debug.print("Find devices failed: {any}", .{errbuf});
        pcap.pcap_freealldevs(devs);
        return errors.pcapErrors.NO_IFACES_FOUND;
    }

    //TODO: Check if next exist, to stop it from breaking and exit loop
    while (true) {
        //TODO: Print the whole name of the device instead of the first char
        std.debug.print("Device: {c}\n", .{devs.*.name.*});
        devs = devs.*.next;
    }

    pcap.pcap_freealldevs(devs);

    return;
}
