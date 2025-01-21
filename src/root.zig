const pcap = @cImport({
    @cInclude("pcap/pcap.h");
});

const errors = @import("errors.zig");
const opening = @import("opening.zig");
const dataLink = @import("datalink.zig");
const lookupNet = @import("lookupnet.zig");
const devices = @import("devices.zig");
const capture = @import("capture.zig");

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
