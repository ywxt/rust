#!/bin/sh
# 用法:CORE=<核> CC=gcc ./run.sh
cd "$(dirname "$0")"; CC=${CC:-gcc}; PIN=${CORE:+taskset -c $CORE}
$CC -O2 -o repro repro.c || exit 1
for t in 0 1 2 4 8; do for l in 16 64 256 1024 4096 16384; do $PIN ./repro pat $l $t; done; done
for t in 0 1 2 4 8; do for r in 8 16 24 32 48 64 96 128 192 256; do $PIN ./repro loop $r $t; done; done
