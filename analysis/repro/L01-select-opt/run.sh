#!/usr/bin/env bash
# 靜態:跑 repro.ll 的 RUN 行。量測:cycles/誤預測 每迭代,三次取最小。
# 環境變數:LLC FILECHECK RUSTC CORE
cd "$(dirname "$0")"; LLC=${LLC:-llc}; FILECHECK=${FILECHECK:-FileCheck}; RUSTC=${RUSTC:-rustc}
T=$(mktemp -d); trap 'rm -rf "$T"' EXIT
date; uname -m; "$RUSTC" --version; "$LLC" --version | grep 'LLVM version'
sed -n 's/^; RUN: //p' repro.ll | while IFS= read -r l; do
  c=${l//%s/repro.ll}; c=${c/llc /$LLC }; c=${c/FileCheck/$FILECHECK}
  if eval "$c"; then echo "PASS: $l"; else echo "FAIL: $l"; fi
done
[ "${STATIC_ONLY:-}" = 1 ] && exit 0
PIN=${CORE:+taskset -c $CORE}
if [ -d /sys/devices/cpu_core ]; then EV=cpu_core/cycles/u,cpu_core/branch-misses/u; else EV=cycles,branch-misses; fi
m() { # bin mode reps
  local best= bb= c b i o; for i in 1 2 3; do
    o=$(env -u LD_LIBRARY_PATH perf stat -x, -e $EV -- $PIN "$T/$1" "$2" "$3" 2>&1 >/dev/null)
    c=$(echo "$o" | grep cycles | cut -d, -f1); b=$(echo "$o" | grep branch-misses | cut -d, -f1)
    if [ -z "$best" ] || [ "$c" -lt "$best" ]; then best=$c; bb=$b; fi
  done
  awk -v n="$1" -v m="$2" -v c="$best" -v b="$bb" -v r="$3" 'BEGIN{printf "%-10s %-5s cycles/iter %.0f  branch-misses/iter %.0f\n", n, m, c/r, b/r}'
}
"$RUSTC" -C opt-level=3 -C codegen-units=1 bench.rs -o "$T/default"
B=default
if [ "$(uname -m)" = aarch64 ]; then
  "$RUSTC" -C opt-level=3 -C codegen-units=1 -C llvm-args=-aarch64-select-opt=false bench.rs -o "$T/nosel"; B="default nosel"
fi
for b in $B; do m $b rand 300; m $b asc 1000; done
