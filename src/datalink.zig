const std = @import("std");
const testing = std.testing;

const errors = @import("errors.zig");

const pcap = @cImport({
    @cInclude("pcap/pcap.h");
});

pub const _DLT = enum {
    NULL,
    EN10MB,
    EN3MB,
    AX25,
    PRONET,
    CHAOS,
    IEEE802,
    ARCNET,
    SLIP,
    PPP,
    FDDI,
};

// TODO: Change to check an runtime instead for compile time
pub fn _datalink(handle: ?*pcap.pcap_t) _DLT {
    return @enumFromInt(pcap.pcap_datalink(handle));
}
