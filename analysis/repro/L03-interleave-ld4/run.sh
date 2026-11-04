#!/usr/bin/env bash
# 靜態:跑 repro.ll 的 RUN 行。量測:cycles/B,三次取最小。環境變數:LLC OPT FILECHECK RUSTC CORE
cd "$(dirname "$0")"; LLC=${LLC:-llc}; OPT=${OPT:-opt}; FILECHECK=${FILECHECK:-FileCheck}; RUSTC=${RUSTC:-rustc}
T=$(mktemp -d); trap 'rm -rf "$T"' EXIT
date; uname -m; "$RUSTC" --version; "$LLC" --version | grep 'LLVM version'
sed -n 's/^; RUN: //p' repro.ll | while IFS= read -r l; do
  c=${l//%s/repro.ll}; c=${c/opt /$OPT }; c=${c/llc /$LLC }; c=${c/FileCheck/$FILECHECK}
  if eval "$c"; then echo "PASS: $l"; else echo "FAIL: $l"; fi
done
PIN=${CORE:+taskset -c $CORE}
if [ -d /sys/devices/cpu_core ]; then EV=cpu_core/cycles/u,cpu_core/instructions/u; else EV=cycles,instructions; fi
m() { local best= bi= c i o n
  for i in 1 2 3; do
    o=$(env -u LD_LIBRARY_PATH perf stat -x, -e $EV -- $PIN "$T/$1" 3000 2>&1 >/dev/null)
    c=$(echo "$o" | grep cycles | cut -d, -f1); n=$(echo "$o" | grep instructions | cut -d, -f1)
    if [ -z "$best" ] || [ "$c" -lt "$best" ]; then best=$c; bi=$n; fi
  done
  awk -v n="$1" -v c="$best" -v i="$bi" 'BEGIN{b=344576*3000; printf "%-10s cycles/B %.4f  instructions/B %.3f\n", n, c/b, i/b}'
}
"$RUSTC" -C opt-level=3 -C codegen-units=1 bench.rs -o "$T/default"; L=default
if [ "$(uname -m)" = aarch64 ]; then
  "$RUSTC" -C opt-level=3 -C codegen-units=1 -C llvm-args=-enable-interleaved-mem-accesses=false bench.rs -o "$T/nointerleave"; L="default nointerleave"
fi
for b in $L; do m $b; done
