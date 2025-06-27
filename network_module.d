module network.network_module;

/**
 * Minimal networking module for anonymOS/internetcomputer.
 * Provides send and receive wrappers around kernel network
 * syscalls. This module is intended to be compiled using
 * the D cross-compiler (ldc2 targeting x86_64-unknown-elf).
 */

extern(C):
long do_syscall(ulong id, ulong a1, ulong a2, ulong a3, ulong a4, ulong a5, ulong a6);

alias ulong size_t;

enum SyscallID : ulong {
    NetSend    = 44,
    NetReceive = 45
}

struct NetPacket {
    ubyte[1500] data;
    size_t len;
}

/// Send data as a single network packet.
long netSend(const(void)* buf, size_t len) {
    NetPacket p;
    if(len > p.data.length) len = p.data.length;
    p.len = len;
    p.data[0 .. len] = (*cast(const(ubyte)[1500]*)buf)[0 .. len];
    return do_syscall(cast(ulong)SyscallID.NetSend, cast(ulong)&p, len, 0, 0, 0, 0);
}

/// Receive a network packet into the provided buffer.
/// Returns number of bytes written or 0 if none available.
size_t netReceive(void* buf, size_t buflen) {
    NetPacket p;
    auto ret = do_syscall(cast(ulong)SyscallID.NetReceive, cast(ulong)&p, p.data.length, 0, 0, 0, 0);
    if(ret <= 0) return 0;
    auto n = cast(size_t)ret;
    if(n > buflen) n = buflen;
    auto out = cast(ubyte*)buf;
    out[0 .. n] = p.data[0 .. n];
    return n;
}


