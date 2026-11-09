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

head='''# contains-arm-mask-abi-20261106：完整雙平台 benchmark 結果

這是四個 u8x16 掃描 64 B、回傳 0/1 存在掩碼的候選，沒有混入後續 word／尾部修改版。ARM 專用分支使用 core::simd；原始小於 16 B 的標量分支保留。此候選仍未通過「不回退」門檻；本次只整理凍結數據，沒有套用補丁。

共有 1,601 個性能測量條目，兩平台各三輪、每輪 main／candidate 成對測量；另有 5 項分隔測試各九輪加長復測，共 19,392 次記錄。其中普通 contains 矩陣與邊界補測有 16 個相同參數組合，兩矩陣共 848 種輸入組合；若僅合併這 16 項重複參數，條目數為 1,585。表格保留兩批獨立測量，不混為更多輪。表格數值為 cycles/op 中位數，Δ = (candidate/main − 1) × 100%，負數表示 cycles 減少。範圍表示各輪最小值至最大值，不是信賴區間。

ARM/x86 比值大於 1 表示 ARM 消耗較多 cycles；它不是實際耗時比。完整 CSV 另列 task-clock 換算的 ns/op、兩種跨架構分母、指令數、分支數、分支失誤及所有輪次範圍。進程 perf 計數包含初始化，再除以固定迭代次數，不等同完全隔離初始化的純接口延遲。

x86 的候選分支沿用 main。兩組標準庫及測試驅動的 .text 相同，counted 驅動的完整 ELF 也相同。此批 x86 同碼測量存在較大波動，因此照列原始差值與範圍，不把它們當成補丁造成的加速或退化。最後一欄使用實測 x86 candidate 分母；CSV 另提供固定 x86-main 分母的比值，避免混淆。

環境：920B（使用者指定，MIDR 0x00000000480fd020）固定 CPU 52；i7-12700 固定 CPU 12；同一 Rust 1.99.0-dev / LLVM 23.1.0 編譯器產出兩個 GNU target，預設目標 CPU，關閉 ASLR。四個硬體事件計數運行比例全部為 100%。沒有新增 inline 屬性；兩組沿用相同的既有編譯參數，包括 -Zinline-mir。

主要測試使用固定次數驅動復用原 benchmark 的核心操作，另加補充輸入；輸入黑盒與迭代方式以封裝內 counted.rs 等檔案為準。op 指一次驅動迭代，分隔測試是整次 split/count，不是每個字元或分隔符。這不是 libtest 校準後的原始 ns/iter 輸出，ns_cpu 也不是牆鐘延遲。

main 是凍結的 contains/memchr 實作對照（main ref 811367e98c08549865a32553076d617fb63154ef），建置源 HEAD 為 dc55da5cca14a0aa773ecb7a0459756260b2ee5c；無關既有變更在兩組間固定，並非整個倉庫 clean-main 重建。

檔案：[1601 條目詳細 CSV](contains-mask-all-1601.csv)、[19392 次原始量測 CSV](contains-mask-raw-19392.csv)、[九輪加長復測 CSV](contains-mask-split-long-5.csv)、[重複參數清單](contains-mask-overlapping-grid-inputs.csv)、[原始 JSON 與測試輸入封裝](contains-mask-raw-json.tar.gz)。CSV 的每個場景均列出樣本迭代次數，沒有以零值填補未測格。

以下先列分組範圍，再列每一個場景。範圍端點及中位數正差不自動等同「已確認回退」；需要對照每輪數值及同碼控制。16 B 對齊 byte slice 未命中的約 8.9% 正差則是本候選的明確失敗項。

'''
doc=head+summary+'\n'
for suite in groups:
    rows=repeat if suite=='split-long' else [x for x in allrows if x['suite']==suite]
    doc+='\n## '+titles[suite]+f'（{len(rows)} 項）\n\n'
    if suite=='byte':doc+='u8／nonzero 的填充值為 128、needle 為 255；i8 為 -128／-1；bool 為 false／true；option 為 None／Some(255)；ASCII 為 x／NUL。offset 是輸入位址模 64 的值。\n\n'
    doc+=table(rows,True)+'\n'
(r/'contains-mask-all-1601.md').write_text(doc)
(r/'contains-mask-counted-28.md').write_text(head+table([x for x in allrows if x['suite']=='counted']))
(r/'summary-table.md').write_text(summary)
(r/'counted-table-for-chat.md').write_text(table([x for x in allrows if x['suite']=='counted']))

for name in ['counted.rs','fixtures.rs','matrix.rs','byte-matrix.rs','index-matrix.rs','split-counted.rs']:
    shutil.copy2(roots['x86']/name,r/name)
with tarfile.open(r/'contains-mask-raw-json.tar.gz','w:gz') as t:
    for arch,root in roots.items():
        for suite in groups:t.add(root/(suite+'-results.json'),arcname=arch+'/'+suite+'-results.json')
    for name in ['counted.rs','fixtures.rs','matrix.rs','byte-matrix.rs','index-matrix.rs','split-counted.rs']:
        t.add(r/name,arcname='inputs/'+name)
    for name in ['code-audit.json','provenance.json','full-tests-exit.json']:
        p=roots['arm']/name
        if p.exists():t.add(p,arcname='metadata/'+name)
meta={'candidate':'contains-arm-mask-abi-20261106','measurement_entries':1601,'overlapping_contains_grid_inputs':16,'distinct_combined_contains_grid_inputs':848,'entries_after_deduplicating_the_two_contains_grids':1585,'rounds_per_variant':3,'long_split_retests':5,'long_split_rounds':9,'raw_measurements':len(raw),'hardware_events_running_percent':100,'data_source':'existing frozen cohort; no rerun or mixing other candidates','input_roots':{a:str(p) for a,p in roots.items()},'implementation':'ARM-only byte SliceContains >=16B: SIMD64 body, SIMD16 remainder and overlapping SIMD16 final load, integer0/1 existence result; original <16B scalar branch unchanged','groups':{k:v[1] for k,v in groups.items()},'source_change_applied':False}
(r/'contains-mask-metadata.json').write_text(json.dumps(meta,ensure_ascii=False,indent=2))
outputnames=['contains-mask-all-1601.csv','contains-mask-all-1601.md','contains-mask-counted-28.md','contains-mask-split-long-5.csv','contains-mask-raw-19392.csv','contains-mask-raw-json.tar.gz','contains-mask-metadata.json','contains-mask-overlapping-grid-inputs.csv','summary-table.md','counted-table-for-chat.md']
manifest={n:hashlib.sha256((r/n).read_bytes()).hexdigest() for n in outputnames}
(r/'sha256.json').write_text(json.dumps(manifest,indent=2))
print(json.dumps(meta,ensure_ascii=False));print(summary)
