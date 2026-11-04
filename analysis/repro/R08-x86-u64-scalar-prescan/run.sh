#!/usr/bin/env bash
# repro.ll 的 opt/llc + FileCheck(靜態,無量測)
cd "$(dirname "$0")"
# 逐行執行 repro.ll 的 RUN 行(%s → repro.ll),通過印 PASS
LLC=${LLC:-llc}; OPT=${OPT:-opt}; FILECHECK=${FILECHECK:-FileCheck}
echo "== $(date -Is) $(uname -m) $($LLC --version | grep -io 'llvm version.*')"
grep '^; RUN:' repro.ll | sed 's/^; RUN: //' | while IFS= read -r l; do
  l=${l//%s/repro.ll}; l=${l/#llc /$LLC }; l=${l/#opt /$OPT }; l=${l/FileCheck /$FILECHECK }
  if eval "$l"; then echo "PASS: ${l##*check-prefix=}"; else echo "FAIL: $l"; fi
done
