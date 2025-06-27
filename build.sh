#!/bin/sh
# Simple build script using ldc2 cross compiler.
# Targets x86_64-unknown-elf as used by anonymOS/internetcomputer.
ldc2 -betterC -O1 -mtriple=x86_64-unknown-elf -c network_module.d -of=network_module.o
ldc2 -betterC -O1 -mtriple=x86_64-unknown-elf network_module.o -of=network_module.bin

