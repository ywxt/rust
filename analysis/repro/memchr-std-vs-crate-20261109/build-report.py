from pathlib import Path
import json,csv,statistics,hashlib,tarfile
r=Path('/tmp/memchr-std-crate-20261109');roots={'arm':r/'arm-results','x86':r};raw=[];rows=[]
data={a:json.loads((p/'results.json').read_text()) for a,p in roots.items()}
keys=list(dict.fromkeys((x['config'],x['length'],x['offset'],x['distribution']) for x in data['arm']))
assert len(keys)==260 and all(len(xs)==2600 for xs in data.values())
for arch,xs in data.items():
 for x in xs:
  assert len(x['running_percent'])==4 and min(x['running_percent'])==100
  raw.append({'arch':arch,**{k:v for k,v in x.items() if k not in ['events','running_percent']},'running_percent':100,'context_switches':x['events']['context-switches'],'cpu_migrations':x['events']['cpu-migrations']})
for cfg,le,off,dist in keys:
 q=dict(config=cfg,length=le,offset=off,distribution=dist)
 ns=set()
 for arch,xs in data.items():
  for mode in ['std','crate']:
   vals=[x for x in xs if (x['config'],x['length'],x['offset'],x['distribution'],x['mode'])==(cfg,le,off,dist,mode)];assert len(vals)==5;ns.update(x['n'] for x in vals)
   for met in ['cycles','instructions','branches','branch_misses','ns_cpu']:
    a=[x[met] for x in vals]
    for stat,f in [('median',statistics.median),('min',min),('max',max)]:q[f'{arch}_{mode}_{met}_{stat}']=f(a)
  for met in ['cycles','instructions','branches','branch_misses','ns_cpu']:
   q[f'{arch}_{met}_delta_pct']=100*(q[f'{arch}_crate_{met}_median']/q[f'{arch}_std_{met}_median']-1)
 assert len(ns)==1;q['iterations']=ns.pop();q['warmup_calls']=1000
 for met in ['cycles','ns_cpu']:
  before=q[f'arm_std_{met}_median']/q[f'x86_std_{met}_median'];after=q[f'arm_crate_{met}_median']/q[f'x86_crate_{met}_median'];q[f'{met}_R_std']=before;q[f'{met}_R_crate']=after;q[f'{met}_R_delta_pct']=100*(after/before-1)
 rows.append(q)
def csvout(name,rs):
 with (r/name).open('w',newline='',encoding='utf-8-sig') as f:
  w=csv.DictWriter(f,fieldnames=list(rs[0]));w.writeheader();w.writerows(rs)
csvout('all-260.csv',rows);csvout('raw-5200.csv',raw)
def table(rs,full=False):
 s='| 長度 / offset / 分布 | ARM std → crate | ARM Δ | x86 std → crate | x86 Δ | ARM/x86 std → crate | 相對變化 |\n|---|---:|---:|---:|---:|---:|---:|\n'
 for q in rs:
  parts=[]
  for a in ['arm','x86']:
   b=q[f'{a}_std_cycles_median'];o=q[f'{a}_crate_cycles_median'];text=f'{b:.2f} → {o:.2f}'
   if full:text+=f"；範圍 [{q[f'{a}_std_cycles_min']:.2f}, {q[f'{a}_std_cycles_max']:.2f}] → [{q[f'{a}_crate_cycles_min']:.2f}, {q[f'{a}_crate_cycles_max']:.2f}]"
   parts+=[text,f"{q[f'{a}_cycles_delta_pct']:+.2f}%"]
  s+=f"| {q['length']} / {q['offset']} / {q['distribution']} | "+' | '.join(parts)+f" | {q['cycles_R_std']:.3f} → {q['cycles_R_crate']:.3f} | {q['cycles_R_delta_pct']:+.2f}% |\n"
 return s
selected=[(8,0,'absent'),(15,0,'absent'),(16,0,'absent'),(17,0,'absent'),(64,0,'absent'),(2551,0,'absent'),(2551,1,'absent'),(2551,0,'front'),(2551,0,'last'),(65536,0,'absent')]
def select(cfg):return [next(q for q in rows if (q['config'],q['length'],q['offset'],q['distribution'])==(cfg,*k)) for k in selected]
head='''# 標準庫 memchr 與 memchr crate 2.8.3 比較（2026-11-09）

對象是遠端 /home/wheel/c00936152/rust-analysis，HEAD dc55da5cca14a0aa773ecb7a0459756260b2ee5c。標準庫 memchr.rs 已核對與先前 main 凍結檔相同（SHA256 c2bc761de734a9e25e02b45b199be8ec4cf3d8730da70b0d6847e4a02745eae7），不含 contains 實驗補丁。這不是對所有已發布 Rust 標準庫版本的宣稱。

crate 使用遠端 registry 的原始 memchr 2.8.3，沒有修改 crate 或標準庫，也沒有新增 inline 屬性。crate 既有 inline / target_feature 屬性保持原樣。直接 rustc 構建原 crate，預設配置啟用 std、alloc；core-only 配置兩者都關閉。沒有啟用 native / AVX2 的全域編譯選項。Rust 1.99.0-dev / LLVM 23.1.0，同一 ARM-host 編譯器產出兩平台程式；其餘參數與先前實驗相同，包括 -O、prefer-dynamic、inline-mir、import-instr-limit=10。

## 源碼差異

| 項目 | 遠端標準庫 | memchr 2.8.3 |
|---|---|---|
| 單位元組搜尋返回值 | 第一個匹配位置 Option<usize> | 同樣返回第一個位置 |
| ARM 主迴圈 | 兩個 usize；64-bit 每輪16 B，零位元組偵測 | NEON，4×16 B，每輪64 B |
| x86 主迴圈 | 同樣兩個 usize，每輪16 B | SSE2 每輪64 B；AVX2 每輪128 B |
| 開頭 | 逐位元組掃描到 usize 對齊 | 先非對齊向量掃描，再進對齊迴圈 |
| 命中定位 | 發現可能命中後逐位元組搜尋 | 按順序檢查各向量 mask，取第一個匹配位置 |
| 最後不足一個向量 | 標量收尾 | 在切片內重疊讀取末尾向量 |
| 小於16 B | 標量 | NEON/SSE2 路徑同樣標量；x86 預設 public API 另有分派成本 |
| const | memchr 為 const fn，以 const_eval_select 分離運行期 | 公開 memchr 不是 const fn |
| x86 平台選擇 | 無專用 SIMD 分派 | std 功能允許運行期偵測並快取函式指標；core-only 本次為 SSE2 |

NEON 實際生成 CMEQ、ORR、UMAXP 合併判斷；命中後 SHRN / RBIT / CLZ 定位。x86 預設生成 AVX2 並在 perf 熱點確認 find_avx2；core-only 的二進位沒有 find_avx2。crate 的設計本身已展示：維持第一個索引語義仍能進行批次 SIMD 掃描，並不必須新增只返回 bool 的函式。

標準庫的 const 與運行期已經分開，所以 const 能力本身不強迫運行期保持字組掃描。core-only 也不排除 NEON/SSE2；不能用不依賴 std 來解釋完全沒有 SIMD。這不表示可以直接把 crate 作為 core 的依賴，整合方式仍需另外設計。

crate 證據：[2.8.3 文件](https://docs.rs/memchr/2.8.3/memchr/)、[通用向量掃描源碼](https://github.com/BurntSushi/memchr/blob/2.8.3/src/arch/generic/memchr.rs)。本歸檔另保留實際 registry 源碼、IR、匯編與指令計數。

## 測量範圍與方法

920B（使用者命名；MIDR 0x00000000480fd020）CPU52；i7-12700 CPU12。主機細節見 arm-results/arm-host.json、x86-host.json。綁核、關閉 ASLR、每輪 std/crate 交錯，五輪取中位數。兩配置各130種場景，共260行雙平台比較、5200條perf記錄；所有四個硬體事件運行比例100%。

長度0、1、8、15、16、17、31、32、33、63、64、65、127、128、129、2551、65536；offset模64為0或1；未命中／首部／中部／尾部命中。性能測試填充值128、needle255，以 black_box 傳入，完整使用返回索引。正確性另外驗證全部256種needle，每個實作每種配置每平台各1638400案例，包括多匹配時返回首個位置。

這是直接單位元組 memchr 對照，不是前一批 str::contains benchmarks，不包含 memchr2/3、memrchr、memmem 或完整子字串算法測量。固定資料反覆查找，主要測熱資料；沒有覆蓋冷快取、隨機分布或超過快取容量的串流。

std 內部 memchr 不是穩定公開 API。驅動保留原始小於16 B的逐位元組 guard，16 B以上通過精確 Rust 符號呼叫原標準庫 memchr_aligned；不是以 iter().position() 或 libc memchr 冒充標準庫。兩種實作都經相同型別的黑盒函式指標呼叫。這個驅動的結果不等同標準庫內所有呼叫點的內聯表現。

表內為進程用戶態 perf cycles / N，計入初始化、首個驗證呼叫及1000次預熱。短場景N=3000000；2551 B非首命中N=50176；65536 B非首命中N=5000。因此預熱掃描佔比在後者達20%，這些不是排除預熱與初始化後的純接口延遲；所有平台、實作使用相同N。原始N、全部事件與五輪範圍列於CSV。task-clock換算的ns_cpu計入內核CPU時間，與cycles:u範圍不同，也不是牆鐘延遲。

Δ=(crate/std−1)×100%，負值表示crate較少cycles。R=ARM/x86週期比，ΔR=(Rcrate/Rstd−1)×100%，負值表示ARM相對改善；它不是耗時比或吞吐提升百分比。std與core配置生成不同二進位，不能把配置間短輸入差值全歸於AVX2：如x86標準庫8 B路徑本身也有布局敏感差異。

## 預設配置：ARM NEON 對 x86 AVX2

'''
body=head+table(select('default'))+'\n## core-only 配置：ARM NEON 對 x86 SSE2\n\n'+table(select('core'))
body+='''
## 結論與限制

長掃描的主要已確認差異是掃描單位與向量化路徑。2551 B對齊未命中，ARM指令數約2389→811、分支354→99；x86預設指令約2905→446、分支359→66。動態計數與生成程式均支持批次掃描減少每位元組工作量的解釋。它不是犧牲索引語義得到的加速。

同一場景預設配置ARM cycles降低73.21%、x86降低74.60%，R由1.107變1.167，ARM相對反而變差約5.46%。core-only配置ARM降低73.20%、x86降低67.00%，R由1.101變0.895，ARM相對改善約18.78%。後者僅比較NEON/SSE2，不能代替預設AVX2結果。

短輸入存在明確不利項：預設8 B對齊未命中，ARM約+10.39%、x86約+69.43%；15 B對齊未命中ARM約+20.04%、x86約+43.85%。x86 17 B對齊未命中也有約+7.67%正差。不能把整個crate稱為所有場景都更快。

較好的後續方向是保留短輸入路徑，在std memchr運行期路徑評估crate的批次掃描、向量尾部及命中後定位策略；這只是待實作與完整驗證的方法，不是已驗證的標準庫補丁。沒有改動標準庫或crate實作，沒有把先前contains候選的收益轉記到此處。

以下保留全部場景及五輪範圍；範圍不是信賴區間。個別中位數正差需結合範圍與布局控制再歸因。
'''
for cfg in ['default','core']:
 body+='\n## 全部場景：'+cfg+'\n\n'+table([x for x in rows if x['config']==cfg],True)
(r/'report.md').write_text(body)
(r/'summary-tables.md').write_text(table(select('default'))+'\n'+table(select('core')))
(r/'report-section.md').write_text('\n\n'+body[:body.index('\n## 全部場景：')]+ '\n完整表與原始證據：analysis/repro/memchr-std-vs-crate-20261109/。\n')
(r/'metadata.json').write_text(json.dumps({'comparison_rows':260,'input_scenarios':130,'configurations':['default','core'],'trials':5,'raw_measurements':5200,'source_modified':False,'new_inline_attributes':0,'warmup_calls_included_in_process_counters':1000,'std_internal_symbol_with_original_short_guard':True},indent=2))
print((r/'summary-tables.md').read_text())
