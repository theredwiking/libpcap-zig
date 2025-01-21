const pcap = @cImport({
    @cInclude("pcap/pcap.h");
});

const errors = @import("pcap/errors.zig");
const opening = @import("pcap/opening.zig");
const dataLink = @import("pcap/datalink.zig");
const lookupNet = @import("pcap/lookupnet.zig");
const devices = @import("pcap/devices.zig");
const capture = @import("pcap/capture.zig");

// Exports funtions
pub const openLive = opening._openLive;
pub const close = opening._close;
pub const datalink = dataLink._datalink;
pub const lookupnet = lookupNet._lookupnet;
pub const findalldevs = devices._findalldevs;
pub const dispatch = capture._dispatch;
pub const loop = capture._loop;

// Exports Structs, Unions and Enums
pub const Errors = errors.pcapErrors;
pub const DLT = dataLink._DLT;

// Exports libpcap struct
pub const pcap_pkthdr = pcap.pcap_pkthdr;
