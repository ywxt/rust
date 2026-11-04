#!/usr/bin/env bash
# 一鍵編譯執行。CORE=核號(預設不綁);CC、RUSTC 可覆寫
set -e; cd "$(dirname "$0")"
CC=${CC:-gcc}; RUSTC=${RUSTC:-rustc}
T=${CORE:+taskset -c $CORE}
if [ -d /sys/bus/event_source/devices/cpu_core ]; then X=cpu_core/; E="${X}cycles/u,${X}instructions/u,${X}branch-misses/u"
else X=; E=cycles:u,instructions:u,branch-misses:u; fi
echo "# $(date -Is) $(uname -m) $(lscpu | sed -n 's/^Model name: *//p' | head -1) | $(ldd --version | head -1)"
st(){ env -u LD_LIBRARY_PATH $T perf stat -x, -o .perf -e "$E" ./repro "$@" >/dev/null; awk -F, '!/^#/&&NF>2{printf "%s ",$1}' .perf; }
# m 每輪單位數 N1 N2 模式 [參數…]:兩次 N 的計數差 ÷ (ΔN×單位數),三次取 cycles 最小,印每單位計數
m(){ local u=$1 a=$2 b=$3 mo=$4; shift 4
  for r in 1 2 3; do echo $(st $mo $a "$@") $(st $mo $b "$@"); done |
  awk -v u=$u -v n=$((b-a)) -v l="$mo $*" -v e="$E" 'BEGIN{split(e,ev,",")}
   {c=($4-$1)/n/u; if(NR==1||c<bc){bc=c;x=($5-$2)/n/u;y=($6-$3)/n/u}}
   END{printf "%-20s %s %.2f  %s %.2f  %s %.3f\n",l,ev[1],bc,ev[2],x,ev[3],y}'; }
$CC --version | head -1; $CC -O2 -fno-builtin -fno-tree-loop-distribute-patterns -o repro repro.c
# 每單位 = 一次 8000 B 拷貝;B/cycle = 8000 / cycles
for mo in libc hand $([ $(uname -m) = x86_64 ] && echo movsb); do m 1 100000 600000 $mo 8000; done
# 源偏移改變相對位置:16 = 不同 mod 64;4032 = 目的比源多 64 mod 4096(4K 別名);2048 = 同 mod 64、無別名
for off in 16 4032 2048; do for mo in libc hand $([ $(uname -m) = x86_64 ] && echo movsb); do m 1 100000 600000 $mo 8000 $off; done; done
