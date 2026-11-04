#!/bin/sh
# 用法:CORE=<核> CC=gcc ./run.sh
cd "$(dirname "$0")"; CC=${CC:-gcc}; PIN=${CORE:+taskset -c $CORE}
$CC -O2 -o repro repro.c || exit 1
$PIN ./repro
