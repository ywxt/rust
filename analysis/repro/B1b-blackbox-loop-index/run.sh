#!/usr/bin/env bash
# 用法:RUSTC=<rustc> CORE=<核> ./run.sh   輸出每種模式 3 次中最小的 cycles/次交換
set -e
cd "$(dirname "$0")"
RUSTC=${RUSTC:-rustc}; PERF=${PERF:-perf}
TASKSET=(); [ -n "$CORE" ] && TASKSET=(taskset -c "$CORE")
"$RUSTC" -C opt-level=3 repro.rs -o repro
echo "# $(uname -m) $(date -Iseconds) $("$RUSTC" -V)"
for m in orig reg even evenreg rot rotodd; do
  best=""
  for r in 1 2 3; do
    c=$("${TASKSET[@]}" $PERF stat -x, -e cycles ./repro $m 2>&1 >/dev/null | awk -F, '$3 ~ /cycles/ && $3 !~ /atom/ {print $1}' | head -1)
    v=$(awk -v c="$c" 'BEGIN{printf "%.2f", c/64e6}')
    [ -z "$best" ] || awk -v a="$v" -v b="$best" 'BEGIN{exit !(a<b)}' && best=$v
  done
  printf '%-8s %s cycles/swap\n' "$m" "$best"
done
