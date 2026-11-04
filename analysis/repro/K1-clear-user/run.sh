#!/usr/bin/env bash
# 一鍵編譯執行。CORE=核號(預設不綁);CC、RUSTC 可覆寫
set -e; cd "$(dirname "$0")"
CC=${CC:-gcc}; RUSTC=${RUSTC:-rustc}
T=${CORE:+taskset -c $CORE}
if [ -d /sys/bus/event_source/devices/cpu_core ]; then X=cpu_core/; E="${X}cycles/u,${X}instructions/u,${X}branch-misses/u"
else X=; E=cycles:u,instructions:u,branch-misses:u; fi
echo "# $(date -Is) $(uname -m) $(lscpu | sed -n 's/^Model name: *//p' | head -1) | $(ldd --version | head -1)"
# K1:read(/dev/zero) 由核心 clear_user 清零使用者緩衝;dd 兩個 count 的差值 ÷ 位元組數
# 含核心的 cycles(不加 :u)、只計核心的 cycles 與指令
if [ -n "$X" ]; then E=${X}cycles/,${X}cycles/k,${X}instructions/k; else E=cycles,cycles:k,instructions:k; fi; BS=${BS:-262144}
st(){ env -u LD_LIBRARY_PATH $T perf stat -x, -o .perf -e "$E" dd if=/dev/zero of=/dev/null bs=$BS count=$1 2>/dev/null; awk -F, '!/^#/&&NF>2{printf "%s ",$1}' .perf; }
for r in 1 2 3; do echo $(st 2000) $(st 20000); done | awk -v by=$((18000*BS)) -v bs=$BS '
 {c=$4-$1; if(NR==1||c<bc){bc=c;k=$5-$2;i=$6-$3}}
 END{printf "bs=%d  B/cycle(全部) %.2f  B/cycle(核心) %.2f  核心指令/8B %.3f\n",bs,by/bc,by/k,i/(by/8)}'
