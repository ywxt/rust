#!/usr/bin/env bash
# 1) repro.ll 的 FileCheck;2) bench.c 各模式 cycles/迭代(CORE 指定核)
cd "$(dirname "$0")"
# 逐行執行 repro.ll 的 RUN 行(%s → repro.ll),通過印 PASS
LLC=${LLC:-llc}; OPT=${OPT:-opt}; FILECHECK=${FILECHECK:-FileCheck}
echo "== $(date -Is) $(uname -m) $($LLC --version | grep -io 'llvm version.*')"
grep '^; RUN:' repro.ll | sed 's/^; RUN: //' | while IFS= read -r l; do
  l=${l//%s/repro.ll}; l=${l/#llc /$LLC }; l=${l/#opt /$OPT }; l=${l/FileCheck /$FILECHECK }
  if eval "$l"; then echo "PASS: ${l##*check-prefix=}"; else echo "FAIL: $l"; fi
done
XEV=cpu_core/ld_blocks.store_forward/u
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
CC=${CC:-gcc}; N=100000000
W=$(mktemp -d); trap 'rm -rf "$W"' EXIT
$CC -O2 bench.c -o $W/bench || exit 1
echo "== bench.c($CC -O2,N=$N,cycles/迭代)"
for m in split_dep whole_dep split_ind whole_ind; do meas $m $N $W/bench $m $N; done
