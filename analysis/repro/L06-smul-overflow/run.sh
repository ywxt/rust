#!/usr/bin/env bash
# 靜態:跑 repro.ll 的 RUN 行。量測:cycles/元素,三次取最小。環境變數:LLC FILECHECK RUSTC CORE
cd "$(dirname "$0")"; LLC=${LLC:-llc}; FILECHECK=${FILECHECK:-FileCheck}; RUSTC=${RUSTC:-rustc}
T=$(mktemp -d); trap 'rm -rf "$T"' EXIT
date; uname -m; "$RUSTC" --version; "$LLC" --version | grep 'LLVM version'
sed -n 's/^; RUN: //p' repro.ll | while IFS= read -r l; do
  c=${l//%s/repro.ll}; c=${c/llc /$LLC }; c=${c/FileCheck/$FILECHECK}
  if eval "$c"; then echo "PASS: $l"; else echo "FAIL: $l"; fi
done
PIN=${CORE:+taskset -c $CORE}
if [ -d /sys/devices/cpu_core ]; then EV=cpu_core/cycles/u,cpu_core/instructions/u; else EV=cycles,instructions; fi
"$RUSTC" -C opt-level=3 bench.rs -o "$T/bench"
for v in fm base; do
  best=; for i in 1 2 3; do
    o=$(env -u LD_LIBRARY_PATH perf stat -x, -e $EV -- $PIN "$T/bench" $v 2>&1 >/dev/null)
    c=$(echo "$o" | grep cycles | cut -d, -f1); n=$(echo "$o" | grep instructions | cut -d, -f1)
    if [ -z "$best" ] || [ "$c" -lt "$best" ]; then best=$c; bi=$n; fi
  done
  awk -v m=$v -v c="$best" -v i="$bi" 'BEGIN{printf "%-5s cycles/elem %.3f  instructions/elem %.2f\n", m, c/2e8, i/2e8}'
done
