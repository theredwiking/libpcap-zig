const std = @import("std");
const testing = std.testing;

const errors = @import("errors.zig");

const pcap = @cImport({
    @cInclude("pcap/pcap.h");
});

pub fn _compile(handle: ?*pcap.pcap_t, filter: u8, optimize: c_int, net: pcap.bpf_u_int32) !*pcap.struct_bpf_program {
    var fp: pcap.struct_bpf_program = undefined;
    const reuslt: c_int = pcap.pcap_compile(handle, &fp, &filter, optimize, net);

    if (reuslt == -1) {
        return errors.pcapErrors.FAILED_FILTER_PARSE;
    }

    return &fp;
}

pub fn _setfilter(handle: ?*pcap.pcap_t, fp: *pcap.struct_bpf_program) !void {
    const result: c_int = pcap.pcap_setfilter(handle, fp);

    if (result == -1) {
        return errors.pcapErrors.APPLYING_FILTER_FAILED;
    }

    return;
}
