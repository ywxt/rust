#!/usr/bin/env bash
# 三種拷貝實作 × 三個總量(8 064 / 16 256 / 32 640 B)每輪的 cycles 與 L1 載入未命中;CORE 指定核
cd "$(dirname "$0")"
echo "== $(date -Is) $(uname -m) $(ldd --version | head -1)"
XEV=cpu_core/L1-dcache-load-misses/u; AEV=L1-dcache-load-misses
# meas <標籤> <單位數> <命令...>:3 次取最小 cycles,印 cycles/單位、指令/單位
if [ "$(uname -m)" = x86_64 ]; then PERF="env -u LD_LIBRARY_PATH perf"; EV=cpu_core/cycles/u,cpu_core/instructions/u${XEV:+,$XEV}
else PERF=perf; EV=cycles,instructions${AEV:+,$AEV}; fi
TS=; [ -n "$CORE" ] && TS="taskset -c $CORE"
meas() { local tag=$1 n=$2; shift 2; local best= line=
  for i in 1 2 3; do
    local o; o=$($TS $PERF stat -x, -e $EV "$@" 2>&1 >/dev/null | grep -v -e cpu_atom -e '^#' -e '^$')
    local c; c=$(echo "$o" | grep -m1 cycles | cut -d, -f1)
    if [ -z "$best" ] || [ "$c" -lt "$best" ]; then best=$c; line=$o; fi
  done
  echo "$line" | awk -F, -v t="$tag" -v n="$n" '{ v=$1; e=$3; sub(/^cpu_core\//,"",e); sub(/\/u?$/,"",e); sub(/:u$/,"",e); s=s sprintf("  %s/單位=%.3f", e, v/n) } END { printf "%-14s%s\n", t, s }'
}
CC=${CC:-gcc}; $CC --version | head -1; IT=100000
W=$(mktemp -d); trap 'rm -rf "$W"' EXIT
$CC -O2 repro.c -o $W/repro || exit 1
echo "== repro.c($CC -O2,IT=$IT,每輪 = 拷一次全部段)"
modes="libc loop"; [ "$(uname -m)" = x86_64 ] && modes="$modes erms"
for m in $modes; do for c in 8192:8064 16384:16256 32768:32640; do
  meas "$m ${c#*:}B" $IT $W/repro $m ${c%:*} $IT
done; done
