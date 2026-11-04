#!/usr/bin/env bash
# 一鍵編譯執行。CORE=核號(預設不綁);CC、RUSTC 可覆寫
set -e; cd "$(dirname "$0")"
CC=${CC:-gcc}; RUSTC=${RUSTC:-rustc}
T=${CORE:+taskset -c $CORE}
if [ -d /sys/bus/event_source/devices/cpu_core ]; then X=cpu_core/; E="${X}cycles/u,${X}instructions/u,${X}branch-misses/u"
else X=; E=cycles:u,instructions:u,branch-misses:u; fi
echo "# $(date -Is) $(uname -m) $(lscpu | sed -n 's/^Model name: *//p' | head -1) | $(ldd --version | head -1)"
st(){ env -u LD_LIBRARY_PATH $T perf stat -x, -o .perf -e "$E" ./$BIN "$@" >/dev/null; awk -F, '!/^#/&&NF>2{printf "%s ",$1}' .perf; }
# m 每輪單位數 N1 N2 模式 [參數…]:兩次 N 的計數差 ÷ (ΔN×單位數),三次取 cycles 最小,印每單位計數
m(){ local u=$1 a=$2 b=$3 mo=$4; shift 4
  for r in 1 2 3; do echo $(st $mo $a "$@") $(st $mo $b "$@"); done |
  awk -v u=$u -v n=$((b-a)) -v l="$mo $*" -v e="$E" 'BEGIN{split(e,ev,",")}
   {c=($4-$1)/n/u; if(NR==1||c<bc){bc=c;x=($5-$2)/n/u;y=($6-$3)/n/u}}
   END{printf "%-20s %s %.2f  %s %.2f  %s %.3f\n",l,ev[1],bc,ev[2],x,ev[3],y}'; }
$RUSTC --version
echo "== ascii"; ./ascii.sh
echo "== peek_mut_deref_mut:每單位 = 一次外層迭代(內層 100 萬元素)"
$RUSTC -C opt-level=3 -o peek peek.rs; BIN=peek
m 1 1000000 6000000 bench; m 1 20 120 keep
echo "== slice::push:單次 1 億次 push(400 MB),總計數;核心佔比 = 1 - cycles:u / cycles"
$RUSTC -C opt-level=3 -o push push.rs
[ -n "$X" ] && E=${X}cycles/,${X}cycles/u,page-faults || E=cycles,cycles:u,page-faults
grep -h -o '\[[a-z+]*\]' /sys/kernel/mm/transparent_hugepage/enabled | sed 's/^/THP /'
env -u LD_LIBRARY_PATH $T perf stat -x, -o .perf -e "$E" ./push 100000000
awk -F, '!/^#/&&NF>2{v[++k]=$1} END{printf "cycles %d  cycles:u %d  核心佔比 %.1f%%  page-faults %d\n",v[1],v[2],100*(1-v[2]/v[1]),v[3]}' .perf
