#!/usr/bin/env bash
# 靜態 vs .so、函數起點平移 PAD(0..60,步長 4)下的 cycles/B;CORE 指定核
cd "$(dirname "$0")"
echo "== $(date -Is) $(uname -m)"
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
CC=${CC:-gcc}; $CC --version | head -1; N=1000000; B=$((N * 139))
W=$(mktemp -d); trap 'rm -rf "$W"' EXIT
echo "== repro.c($CC -O2,N=$N 次呼叫 × 139 B,每字節)"
for pad in $(seq 0 4 60); do
  $CC -O2 -DPAD=$pad repro.c -o $W/st || exit 1
  $CC -O2 -fPIC -shared -DPAD=$pad -DLIB repro.c -o $W/libscan$pad.so || exit 1
  $CC -O2 -DUSE_LIB repro.c $W/libscan$pad.so -o $W/dy || exit 1
  meas "static PAD=$pad" $B $W/st $N
  meas "shared PAD=$pad" $B $W/dy $N
done
