#!/bin/sh
# 一鍵編譯並以 perf 量每個模式的 cycles/單位(3 次取最小)。
# 環境變數:RUSTC(預設 rustc)、PERF(預設 perf)、CORE(綁核,預設不綁)
set -e
cd "$(dirname "$0")"
RUSTC=${RUSTC:-rustc}; PERF=${PERF:-perf}
B=$(mktemp -d); trap 'rm -rf "$B"' EXIT
$RUSTC -C opt-level=3 repro.rs -o "$B/repro"
echo "date: $(date -u '+%F %T UTC')  host: $(uname -m)"
echo "rustc: $($RUSTC -V)"
grep -m1 -E 'model name' /proc/cpuinfo || true
run1() {
  if [ -n "$CORE" ]; then set -- taskset -c "$CORE" "$@"; fi
  env -u LD_LIBRARY_PATH $PERF stat -x, -e cycles:u -o "$B/st" -- "$@" > "$B/out"
  # x86 混合核會拆成 cpu_core/cpu_atom 兩行,相加
  awk -F, -v u="$(cat "$B/out")" '/cycles/ && $1 ~ /^[0-9]+$/ {s+=$1} END {printf "%.3f\n", s/u}' "$B/st"
}
for m in ld8 ld16 ldr2 ldp ldr2_x ldp_x; do
  best=$( (run1 "$B/repro" $m; run1 "$B/repro" $m; run1 "$B/repro" $m) | sort -g | head -1)
  printf '%-14s %8s cycles/unit\n' "$m" "$best"
done
