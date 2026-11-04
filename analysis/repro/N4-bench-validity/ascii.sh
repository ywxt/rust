#!/usr/bin/env bash
# ascii LONG 第一個非 ASCII 位元組的偏移:is_ascii 遇到它即返回,只掃了前綴
# ASCII_RS=library/coretests/benches/ascii.rs 的路徑
python3 -I - "${ASCII_RS:?設 ASCII_RS}" <<'PY'
import re, sys
s = open(sys.argv[1], encoding="utf-8").read()
body = re.search(r'const LONG: &str = repeat!\(\s*r#"(.*?)"#', s, re.S).group(1).encode() * 10  # repeat! 為 10 份
i = next(k for k, c in enumerate(body) if c >= 0x80)
print(f"LONG {len(body)} B,首個非 ASCII 位元組偏移 {i}({body[i:i+3].decode()!r}),is_ascii 只掃 {100*i/len(body):.1f}%")
PY
