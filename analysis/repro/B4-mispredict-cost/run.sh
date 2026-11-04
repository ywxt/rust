#!/bin/sh
# 用法:CORE=<核> CC=gcc ./run.sh
cd "$(dirname "$0")"; CC=${CC:-gcc}; PIN=${CORE:+taskset -c $CORE}
$CC -O2 -o repro repro.c || exit 1
$PIN ./repro alt > .alt; $PIN ./repro rand > .rand; cat .alt .rand
awk '{c[NR]=$3; m[NR]=$7} END {printf "penalty cyc/miss %.1f\n", (c[2]-c[1])/(m[2]-m[1])}' .alt .rand; rm -f .alt .rand
