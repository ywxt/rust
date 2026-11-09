from pathlib import Path
import csv, json, statistics, hashlib, tarfile, shutil, argparse

parser=argparse.ArgumentParser()
parser.add_argument('--arm-root',required=True)
parser.add_argument('--x86-root',required=True)
parser.add_argument('--output-dir',required=True)
args=parser.parse_args()
r=Path(args.output_dir);r.mkdir(parents=True,exist_ok=True)
roots={'arm':Path(args.arm_root),'x86':Path(args.x86_root)}
assert roots['arm'].resolve()!=roots['x86'].resolve()
groups={'counted':(['case'],28),'matrix':(['length','offset','distribution','needle','pattern'],288),'byte':(['type','length','offset','distribution'],480),'index':(['length','offset','distribution','needle','pattern'],224),'boundary':(['length','offset','distribution','needle','pattern'],576),'split':(['case'],5),'split-long':(['case'],5)}
titles={'counted':'主要與補充 contains benchmarks','matrix':'contains 輸入矩陣','byte':'byte slice 矩陣','index':'find 索引矩陣','boundary':'邊界與對齊矩陣','split':'分隔 benchmarks','split-long':'分隔 benchmarks 九輪加長復測'}
metrics=['cycles','ns_cpu','instructions','branches','branch_misses']
samples={}; raw=[]; allrows=[]; repeat=[]
for suite,(fields,count) in groups.items():
    rounds=9 if suite=='split-long' else 3
    byarch={}
    for arch,root in roots.items():
        rows=json.loads((root/(suite+'-results.json')).read_text())
        assert len(rows)==count*rounds*2,(arch,suite,len(rows))
        sets={}
        for x in rows:
            assert len(x['running_percent'])==4 and min(x['running_percent'])==100
            key=tuple(x.get(f) for f in fields)
            sets.setdefault(key,{}).setdefault(x['variant'],[]).append(x)
            raw.append(dict(arch=arch,suite=suite,scenario=json.dumps(dict(zip(fields,key)),sort_keys=True),**{k:v for k,v in x.items() if k not in ['events','running_percent','suite']},running_percent=json.dumps(x['running_percent']),context_switches=x['events'].get('context-switches'),cpu_migrations=x['events'].get('cpu-migrations')))
        assert len(sets)==count
        for key,vs in sets.items():
            assert set(vs)=={'baseline','optimized'}
            assert all(len(v)==rounds for v in vs.values())
        byarch[arch]=sets
    assert set(byarch['arm'])==set(byarch['x86'])
    for key in byarch['arm']:
        row={'suite':suite,**dict(zip(fields,key)),'rounds_per_variant':rounds}
        ns={x['n'] for a in byarch.values() for v in a[key].values() for x in v}
        assert len(ns)==1,(suite,key,ns)
        row['iterations_per_sample']=next(iter(ns))
        for arch in ['arm','x86']:
            for variant,label in [('baseline','main'),('optimized','candidate')]:
                for metric in metrics:
                    values=[x[metric] for x in byarch[arch][key][variant]]
                    for stat,fn in [('median',statistics.median),('min',min),('max',max)]:
                        row[f'{arch}_{label}_{metric}_{stat}']=fn(values)
            for metric in metrics:
                b=row[f'{arch}_main_{metric}_median'];o=row[f'{arch}_candidate_{metric}_median']
                row[f'{arch}_{metric}_delta_pct']=100*(o/b-1) if b else None
        for metric in ['cycles','ns_cpu']:
            ab=row[f'arm_main_{metric}_median'];ao=row[f'arm_candidate_{metric}_median'];xb=row[f'x86_main_{metric}_median'];xo=row[f'x86_candidate_{metric}_median']
            row[f'{metric}_arm_x86_ratio_before']=ab/xb
            row[f'{metric}_arm_x86_ratio_after_observed']=ao/xo
            row[f'{metric}_arm_x86_ratio_after_fixed_x86_main']=ao/xb
            row[f'{metric}_ratio_delta_pct_observed']=100*((ao/xo)/(ab/xb)-1)
        (repeat if suite=='split-long' else allrows).append(row)
assert len(allrows)==1601 and len(repeat)==5 and len(raw)==19392
grid_fields=['length','offset','distribution','needle','pattern']
grid_main={tuple(x[k] for k in grid_fields) for x in allrows if x['suite']=='matrix'}
grid_boundary={tuple(x[k] for k in grid_fields) for x in allrows if x['suite']=='boundary'}
grid_overlap=grid_main & grid_boundary
assert len(grid_overlap)==16 and len(grid_main | grid_boundary)==848

def writecsv(path,rows):
    columns=list(dict.fromkeys(k for x in rows for k in x))
    with path.open('w',newline='',encoding='utf-8-sig') as f:
        w=csv.DictWriter(f,fieldnames=columns);w.writeheader();w.writerows(rows)
writecsv(r/'contains-mask-all-1601.csv',allrows)
writecsv(r/'contains-mask-split-long-5.csv',repeat)
writecsv(r/'contains-mask-raw-19392.csv',raw)
writecsv(r/'contains-mask-overlapping-grid-inputs.csv',[dict(zip(grid_fields,k)) for k in sorted(grid_overlap)])

def label(x):
    if 'case' in x:return x['case'].removeprefix('str::')
    if x['suite']=='byte':
        needle={'u8':'255','i8':'-1','bool':'true','nonzero':'255','option':'Some(255)','ascii':'NUL'}[x['type']]
        return f"{x['type']} len={x['length']} off={x['offset']} needle={needle} {x['distribution']}"
    return f"{x['pattern']} len={x['length']} off={x['offset']} needle=0x{x['needle']:02X} {x['distribution']}"

def table(rows,ranges=False):
    out='| 場景 | ARM main → 方案 | ARM Δ | x86 main → 方案 | x86 Δ | ARM/x86 前 → 後 |\n|---|---:|---:|---:|---:|---:|\n'
    for x in rows:
        vals=[]
        for arch in ['arm','x86']:
            a=x[f'{arch}_main_cycles_median'];b=x[f'{arch}_candidate_cycles_median']
            if ranges:
                s=f"{a:.3f} [{x[f'{arch}_main_cycles_min']:.3f}, {x[f'{arch}_main_cycles_max']:.3f}] → {b:.3f} [{x[f'{arch}_candidate_cycles_min']:.3f}, {x[f'{arch}_candidate_cycles_max']:.3f}]"
            else:s=f'{a:.2f} → {b:.2f}'
            vals.extend([s,f"{x[f'{arch}_cycles_delta_pct']:+.2f}%"])
        out+='| '+label(x)+' | '+' | '.join(vals)+f" | {x['cycles_arm_x86_ratio_before']:.3f} → {x['cycles_arm_x86_ratio_after_observed']:.3f} |\n"
    return out

summary='| 分組 | 測量條目 | ARM Δ 範圍 | x86 Δ 範圍 |\n|---|---:|---:|---:|\n'
for suite in groups:
    if suite=='split-long':continue
    rows=[x for x in allrows if x['suite']==suite]
    summary+=f"| {titles[suite]} | {len(rows)} | {min(x['arm_cycles_delta_pct'] for x in rows):+.2f}% ～ {max(x['arm_cycles_delta_pct'] for x in rows):+.2f}% | {min(x['x86_cycles_delta_pct'] for x in rows):+.2f}% ～ {max(x['x86_cycles_delta_pct'] for x in rows):+.2f}% |\n"


head="""# 同一份 portable SIMD contains 候選：補齊 x86 啟用結果

x86_64/SSE2 啟用與 ARM 相同的四組 u8x16／64 B 掃描，16 B 以下保持原路徑，回傳 usize 0/1。只擴展 cfg，沒有新 inline 屬性，也沒有使用 AVX2/native 編譯。x86 為本次新構建與新測量；ARM 沿用先前凍結的 contains-arm-mask-abi-20261106 數據，並非同期重跑。

920B 固定 CPU52；x86 i7-12700 固定 CPU12。Rust 1.99.0-dev/LLVM23.1.0、預設目標 CPU、相同編譯參數。每項三輪 main/candidate 交錯測量，分隔加長測試九輪。cycles/op 為進程用戶態 perf cycles 除以迭代次數，包含初始化；ns_cpu 為 task-clock 換算，並非牆鐘延遲。全部四項硬體事件運行比例100%。

ARM/x86 前後比值分別使用兩平台各自 main／實際啟用 SIMD 的 candidate。比值不是實際耗時比；舊報告中 x86 候選未啟用的數值不再用於這個對比。main 指凍結 contains/memchr 實作，無關既有改動固定，並非完整 clean-main 構建。

共1601條測量條目，其中 contains 與 boundary 網格有16組相同輸入；另5項九輪加長測量，原始資料19392條。兩平台所有結果與各輪範圍保留於 CSV。正差表示較慢；僅有三輪中位數正差不足以證明可重現回退。

"""
doc=head+summary+'\n'
for suite in groups:
 rows=repeat if suite=='split-long' else [x for x in allrows if x['suite']==suite]
 doc+='\n## '+titles[suite]+'\n\n'+table(rows,True)+'\n'
(r/'contains-both-all-1601.md').write_text(doc)
(r/'counted-table.md').write_text(head+table([x for x in allrows if x['suite']=='counted']))
(r/'summary-table.md').write_text(summary)
print(summary)
print(table([x for x in allrows if x['suite']=='counted']))
