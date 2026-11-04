#!/usr/bin/env bash
# L12:靜態 FileCheck + iter().all(is_ascii) bench(cycles/B),預設 vs 反向開關
cd "$(dirname "$0")"; set -e
# 共用:跑 repro.ll 的 RUN 行、量 cycles
: "${LLC:=llc}" "${OPT:=opt}" "${FILECHECK:=FileCheck}" "${RUSTC:=rustc}" "${REPS:=3}"
run_lit() { # run_lit file.ll:逐條執行 RUN 行
  local f=$1 n=0 bad=0 t; t=$(mktemp)
  while IFS= read -r l; do
    n=$((n+1))
    c=$(printf '%s' "$l" | sed -E "s/^; RUN: //; s#%s#$f#g; s#(^|[ |])llc #\1$LLC #g; s#(^|[ |])opt #\1$OPT #g; s#FileCheck #$FILECHECK #g")
    if bash -o pipefail -c "$c" >/dev/null 2>$t; then echo "RUN $n PASS"; else echo "RUN $n FAIL: $l"; cat $t; bad=1; fi
  done < <(grep '^; RUN: ' "$f")
  rm -f $t; return $bad
}
cyc() { # cyc <標籤> <單位數> <命令...>:取 REPS 次最小 cycles
  local lab=$1 u=$2; shift 2
  local ev=cycles; [ -e /sys/bus/event_source/devices/cpu_core ] && ev=cpu_core/cycles/u
  local pin=(); [ -n "$CORE" ] && pin=(taskset -c "$CORE")
  local best= c i
  for ((i=0;i<REPS;i++)); do
    c=$(env -u LD_LIBRARY_PATH "${pin[@]}" perf stat -x, -e "$ev" "$@" 2>&1 >/dev/null | awk -F, '/cycles/{print $1}')
    [ -z "$best" ] || [ "$c" -lt "$best" ] && best=$c
  done
  awk -v l="$lab" -v c="$best" -v u="$u" 'BEGIN{printf "%-16s cycles=%d  cyc/unit=%.3f\n", l, c, c/u}'
}
banner() { echo "date: $(date -Is)  host: $(uname -m)"; "$RUSTC" --version 2>/dev/null; "$LLC" --version 2>/dev/null | grep -m1 'LLVM version'; }
banner
run_lit repro.ll || true
"$RUSTC" -C opt-level=3 bench.rs -o bench
if [ "$(uname -m)" = aarch64 ]; then alt="-unroll-runtime-multi-exit=false"; else alt="-unroll-runtime -unroll-runtime-multi-exit -unroll-count=4"; fi
"$RUSTC" -C opt-level=3 -C llvm-args="$alt" bench.rs -o bench_alt
IT=100000
cyc default $((7000*IT)) ./bench $IT
cyc "alt($alt)" $((7000*IT)) ./bench_alt $IT
