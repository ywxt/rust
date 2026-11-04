#!/usr/bin/env bash
# 1) repro.ll 的 FileCheck;2) bench.rs 每次呼叫 cycles/指令(CORE 指定核)
cd "$(dirname "$0")"
# 逐行執行 repro.ll 的 RUN 行(%s → repro.ll),通過印 PASS
LLC=${LLC:-llc}; OPT=${OPT:-opt}; FILECHECK=${FILECHECK:-FileCheck}
echo "== $(date -Is) $(uname -m) $($LLC --version | grep -io 'llvm version.*')"
grep '^; RUN:' repro.ll | sed 's/^; RUN: //' | while IFS= read -r l; do
  l=${l//%s/repro.ll}; l=${l/#llc /$LLC }; l=${l/#opt /$OPT }; l=${l/FileCheck /$FILECHECK }
  if eval "$l"; then echo "PASS: ${l##*check-prefix=}"; else echo "FAIL: $l"; fi
done
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
RUSTC=${RUSTC:-rustc}; $RUSTC -vV | grep -E "^rustc|^LLVM" | tr "\n" " "; echo
W=$(mktemp -d); trap 'rm -rf "$W"' EXIT
$RUSTC -C opt-level=3 bench.rs -o $W/bench || exit 1
$RUSTC -C opt-level=3 --cfg solo bench.rs -o $W/solo || exit 1
N=20000000
echo "== bench.rs(opt-level=3,N=$N,每次呼叫,輸入 ≤ 255)"
for m in u128 u64; do meas $m $N $W/bench $m $N; done
meas u128-solo $N $W/solo u128 $N
for b in bench solo; do
  echo "== $b:sq128 入口(反組譯前 8 條)"
  objdump -d --no-show-raw-insn $W/$b | awk '/sq128.*>:$/{f=1;next} f&&NF{print; if(++k==8) exit}'
done
