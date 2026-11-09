from pathlib import Path
import json,csv,statistics,shutil,tarfile,hashlib
r=Path('/tmp/contains-both-mask-20261106');out=Path('/tmp/contains-both-results-20261106')
arm=json.loads(Path('/tmp/contains-both-arm-focused-results.json').read_text());x86=json.loads((r/'focused-results.json').read_text());rows=[]
doc='## 長輸入九輪加長復測（兩平台本次重跑）\n\n每個樣本1000萬次迭代。以下 cycles/op 為九輪中位數。R=ARM cycles/x86 cycles；ΔR負值表示相對週期成本改善。x86各輪範圍仍寬，R變化是觀測值，不能當成已排除測量／代碼布局影響的穩定硬體優勢。\n\n| 場景 | ARM main → SIMD | ARM Δ | x86 main → SIMD | x86 Δ | R 前 → 後 | ΔR |\n|---|---:|---:|---:|---:|---:|---:|\n'
for k in dict.fromkeys(x['case'] for x in arm):
 row={'case':k};m={}
 for arch,xs in [('arm',arm),('x86',x86)]:
  for v in ['baseline','optimized']:
   vals=[x for x in xs if x['case']==k and x['variant']==v]
   for metric in ['cycles','ns_cpu','instructions','branches','branch_misses']:
    q=[x[metric] for x in vals]
    for n,f in [('median',statistics.median),('min',min),('max',max)]:row[f'{arch}_{v}_{metric}_{n}']=f(q)
   m[arch,v]=row[f'{arch}_{v}_cycles_median']
  row[arch+'_delta_pct']=100*(m[arch,'optimized']/m[arch,'baseline']-1)
 rb=m['arm','baseline']/m['x86','baseline'];ro=m['arm','optimized']/m['x86','optimized'];row.update(R_before=rb,R_after=ro,R_delta_pct=100*(ro/rb-1));rows.append(row)
 doc+=f"| {k.removeprefix('str::')} | {m['arm','baseline']:.2f} → {m['arm','optimized']:.2f} | {row['arm_delta_pct']:+.2f}% | {m['x86','baseline']:.2f} → {m['x86','optimized']:.2f} | {row['x86_delta_pct']:+.2f}% | {rb:.3f} → {ro:.3f} | {row['R_delta_pct']:+.2f}% |\n"
doc+='\nx86九輪 cycles/op 範圍：\n\n'
for q in rows:doc+=f"- {q['case']}: main [{q['x86_baseline_cycles_min']:.2f}, {q['x86_baseline_cycles_max']:.2f}]，SIMD [{q['x86_optimized_cycles_min']:.2f}, {q['x86_optimized_cycles_max']:.2f}]。\n"
doc+='\n## 短輸入九輪復測\n\n每樣本1000萬次迭代，off=0。控制路徑也出現差異，不能將全部差值歸因於 SIMD 演算法；代碼布局、調度等具體因素尚未排除。原始差值照列，尚未通過不回退條件。\n\n| 場景 | x86 main → SIMD cycles/op | Δ |\n|---|---:|---:|\n'
xs=json.loads((r/'focused-byte-results.json').read_text());short=[]
for k in dict.fromkeys(tuple(x[f] for f in ['type','length','offset','distribution']) for x in xs):
 vals=[[x['cycles'] for x in xs if tuple(x[f] for f in ['type','length','offset','distribution'])==k and x['variant']==v] for v in ['baseline','optimized']];b,o=map(statistics.median,vals);d=100*(o/b-1)
 short.append(dict(type=k[0],length=k[1],offset=k[2],distribution=k[3],main=b,candidate=o,delta_pct=d,main_min=min(vals[0]),main_max=max(vals[0]),candidate_min=min(vals[1]),candidate_max=max(vals[1])))
 doc+=f'| {k[0]} len={k[1]} {k[3]} | {b:.3f} → {o:.3f} | {d:+.2f}% |\n'
doc+='\n`i8`未啟用新函式；bool 8 B仍走原有memchr掃描，但呼叫端分派／二進位布局可能改變。這些是控制項，不能宣稱它們完全不受生成程式改動影響。要可靠區分演算法成本與布局成本，仍需進一步控制實驗。\n\n正確性檢查：5573952次contains/訪問順序、Pattern override/drop、5339152次slice、9617552次首索引／匹配順序、5505024次直接memchr（全部256針值）全部通過。既有check程序不是本次重新執行的完整coretests/alloctests套件。\n\n結論：同一候選在x86長單位元組掃描也有大幅收益；先前ARM專用結果不能作為兩平台同時優化後的相對優勢。當前未證明所有場景不回退，也未排除x86波動／代碼布局對相對收益的影響。沒有將候選留在遠端源碼中。\n'
def csvout(p,rows):
 with p.open('w',newline='') as f:
  w=csv.DictWriter(f,fieldnames=list(rows[0]));w.writeheader();w.writerows(rows)
csvout(out/'focused-long.csv',rows);csvout(out/'focused-byte.csv',short)
(out/'focused-results.md').write_text(doc)
with (out/'contains-both-all-1601.md').open('a') as f:f.write('\n'+doc)
(out/'report-section.md').write_text('\n\n# 同一 portable SIMD contains 候選補齊 x86 啟用結果（2026-11-06）\n\n'+doc+'\n完整1601條三輪資料與各輪範圍見本節對應歸檔 contains-both-all-1601.md / contains-mask-all-1601.csv；ARM完整表沿用先前凍結資料，只有上方長輸入九輪是兩平台本次重跑。\n')
shutil.copy2('/tmp/contains-both-arm-focused-results.json',out/'arm-focused-results.json')
for f in ['focused-results.json','focused-byte-results.json','optimized-contains-match.asm','sysroot-manifests.json','source-restored.json','memchr.candidate.rs','cmp.candidate.rs']:shutil.copy2(r/f,out/f)
shutil.copy2('/tmp/contains-both-report.py',out/'build-report.py');shutil.copy2('/tmp/contains-both-finish.py',out/'finish-report.py')
with tarfile.open(out/'raw-evidence.tar.gz','w:gz') as tar:
 for arch,root in [('arm',Path('/tmp/contains-mask-full-results-20261106/arm')),('x86',r)]:
  for suite in ['counted','matrix','byte','index','boundary','split','split-long']:tar.add(root/(suite+'-results.json'),arcname=arch+'/'+suite+'-results.json')
 for p in r.iterdir():
  if p.is_file() and (p.suffix in ['.rs','.py'] or p.name.endswith('-build.log') or p.name.startswith('optimized-') and p.suffix=='.log' or p.name.startswith('focused')):tar.add(p,arcname='x86/'+p.name)
 tar.add(out/'arm-focused-results.json',arcname='arm/focused-results.json')
manifest={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in out.iterdir() if p.is_file() and p.name!='sha256.json'}
(out/'sha256.json').write_text(json.dumps(manifest,indent=2))
with tarfile.open('/tmp/contains-both-results-upload.tar.gz','w:gz') as tar:
 for p in out.iterdir():tar.add(p,arcname=p.name)
print(doc)
