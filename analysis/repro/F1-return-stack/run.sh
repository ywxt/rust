#!/bin/sh
# 用法:CORE=<核> CC=gcc ./run.sh
cd "$(dirname "$0")"; CC=${CC:-gcc}; PIN=${CORE:+taskset -c $CORE}
$CC -O2 -o repro repro.c || exit 1
for m in near far; do $PIN ./repro $m 1 4 8 12 14 16 18 20 22 24 26 28 30 32 36 40 48 64; done
