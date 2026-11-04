#!/usr/bin/env bash
# 靜態:跑 repro.ll 的 RUN 行,並數 bench 內除法條數。量測:cycles/insert,三次取最小。
# 環境變數:LLC OPT FILECHECK RUSTC CORE
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
    o=$(env -u LD_LIBRARY_PATH perf stat -x, -e $EV -- $PIN "$T/$1" 300000 2>&1 >/dev/null)
    c=$(echo "$o" | grep cycles | cut -d, -f1); n=$(echo "$o" | grep instructions | cut -d, -f1)
    if [ -z "$best" ] || [ "$c" -lt "$best" ]; then best=$c; bi=$n; fi
  done
  awk -v b="$1" -v c="$best" -v i="$bi" -v d="$2" 'BEGIN{e=300000*100; printf "%-10s cycles/insert %.1f  instructions/insert %.0f  divides-in-iter %s\n", b, c/e, i/e, d}'
}
for v in default nolsr; do
  F=; [ $v = nolsr ] && F="-C llvm-args=-disable-lsr"
  "$RUSTC" -C opt-level=3 -C codegen-units=1 $F bench.rs -o "$T/$v"
  "$RUSTC" -C opt-level=3 -C codegen-units=1 $F --emit=asm bench.rs -o "$T/$v.s"
  d=$(awk '/^_.*4iter.*:$/{f=1} f&&/cfi_endproc/{f=0} f' "$T/$v.s" | grep -cE '^\s+(udiv|divl|divq)\s')
  m $v "$d"
done
