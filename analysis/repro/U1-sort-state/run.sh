#!/bin/sh
# 用法:CORE=<核> RUSTC=rustc ./run.sh
cd "$(dirname "$0")"; RUSTC=${RUSTC:-rustc}; PIN=${CORE:+taskset -c $CORE}
$RUSTC -C opt-level=3 -o repro repro.rs || exit 1
for m in small part both whole; do $PIN ./repro $m; done > .out; cat .out
awk '{c[$1]=$3} END {x=c["both"]-c["part"]-c["small"]; printf "interaction cyc/iter %.1f (%.1f%% of both)\n", x, 100*x/c["both"]}' .out; rm -f .out
