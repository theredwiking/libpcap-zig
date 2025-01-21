const std = @import("std");
const testing = std.testing;

const errors = @import("errors.zig");

const pcap = @cImport({
    @cInclude("pcap/pcap.h");
});

pub fn _lookupnet(device: [:0]const u8) !struct { net: pcap.bpf_u_int32, mask: pcap.bpf_u_int32 } {
    var errbuf: [pcap.PCAP_ERRBUF_SIZE]u8 = undefined;
    var mask: pcap.bpf_u_int32 = undefined;
    var net: pcap.bpf_u_int32 = undefined;
    // bpf_u_int32 = u_int = system defined
    if (pcap.pcap_lookupnet(device, &net, &mask, &errbuf) == -1) {
        return errors.pcapErrors.SIOCGIFADDR;
    }

    return .{ .net = net, .mask = mask };
}

//test "Missing setcap permissions" {
//    const dev: [:0]const u8 = "eth0";
//    _ = _openLive(dev) catch |err| {
//        try testing.expect(err == errors.pcapErrors.PERM_DENIED);
//    };
//}
