# Networking Module

This repository contains a simple networking module designed for the
[anonymOS](https://github.com/Jonathan-R-Anderson/internetcomputer)
project.  The module exposes minimal wrappers for sending and receiving
network packets using system calls only.  It is intended to be compiled
with the `ldc2` cross‑compiler targeting `x86_64-unknown-elf`.

## Building

Use the provided `build.sh` script. It relies solely on `ldc2` and does
not require any external libraries:

```bash
./build.sh
```

This produces `network_module.bin`, which can be linked into the OS or
used by other components.
