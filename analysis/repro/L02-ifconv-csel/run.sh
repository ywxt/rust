#!/usr/bin/env bash
# 靜態:跑 repro.ll 的 RUN 行。量測:cycles/char,以及 aarch64 chain 的 cycles/環。三次取最小。
# 環境變數:LLC FILECHECK RUSTC CORE
cd "$(dirname "$0")"; LLC=${LLC:-llc}; FILECHECK=${FILECHECK:-FileCheck}; RUSTC=${RUSTC:-rustc}
T=$(mktemp -d); trap 'rm -rf "$T"' EXIT
date; uname -m; "$RUSTC" --version; "$LLC" --version | grep 'LLVM version'
sed -n 's/^; RUN: //p' repro.ll | while IFS= read -r l; do
  c=${l//%s/repro.ll}; c=${c/llc /$LLC }; c=${c/FileCheck/$FILECHECK}
  if eval "$c"; then echo "PASS: $l"; else echo "FAIL: $l"; fi
done
PIN=${CORE:+taskset -c $CORE}
if [ -d /sys/devices/cpu_core ]; then EV=cpu_core/cycles/u; else EV=cycles; fi
cyc() { env -u LD_LIBRARY_PATH perf stat -x, -e $EV -o "$T/st" -- $PIN "$@" > "$T/out" 2>/dev/null; grep cycles "$T/st" | cut -d, -f1; }
m() { local best= c i
  for i in 1 2 3; do c=$(cyc "$T/$1" "$2" "$3"); if [ -z "$best" ] || [ "$c" -lt "$best" ]; then best=$c; fi; done
  awk -v n="$1" -v m="$2" -v c="$best" -v r="$3" -v k="$(cat "$T/out")" 'BEGIN{ if (k=="") { printf "%-10s %-8s cycles/link %.3f\n", n, m, c/r } else { printf "%-10s %-8s cycles/char %.3f\n", n, m, c/(r*k) } }'
}
"$RUSTC" -C opt-level=3 -C codegen-units=1 bench.rs -o "$T/default"; L=default
if [ "$(uname -m)" = aarch64 ]; then
  "$RUSTC" -C opt-level=3 -C codegen-units=1 -C llvm-args=-aarch64-enable-early-ifcvt=false bench.rs -o "$T/noifcvt"; L="default noifcvt"
fi
for b in $L; do for c in en ru zh emoji; do m $b $c 2000; done; done
if [ "$(uname -m)" = aarch64 ]; then for c in chain8 chain9 chain10; do m default $c 200000000; done; fi
