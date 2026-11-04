#!/usr/bin/env bash
# repro.c 各模式 cycles/迭代;x86 另計 resource_stalls.sb(store buffer 滿的週期)
cd "$(dirname "$0")"
echo "== $(date -Is) $(uname -m)"
XEV=cpu_core/resource_stalls.sb/u
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
CC=${CC:-gcc}; $CC --version | head -1; N=100000000
W=$(mktemp -d); trap 'rm -rf "$W"' EXIT
$CC -O2 repro.c -o $W/repro || exit 1
echo "== repro.c($CC -O2,N=$N,每迭代)"
for m in line1 line2 mix same drop; do meas $m $N $W/repro $m $N; done
