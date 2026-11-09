from pathlib import Path
import json, statistics as st, csv
r = Path(__file__).resolve().parent
out = r / 'delivery'
out.mkdir(exist_ok=True)
records = []
for arch, p in [('aarch64', r / 'arm-final'), ('x86_64', r)]:
    rows = json.loads((p / f'bench.{arch}.json').read_text())
    for case, variant in sorted({(x['case'], x['variant']) for x in rows}):
        ds = [x for x in rows if x['case'] == case and x['variant'] == variant]
        vals = [x['ns'] for x in ds]
        base = st.median(x['ns'] for x in rows if x['case'] == case and x['variant'] == 'base')
        records.append(dict(arch=arch, case=case, variant=variant, median_ns=st.median(vals), min_ns=min(vals), max_ns=max(vals), delta_percent=100*(st.median(vals)/base-1), trials=len(vals)))
with (out / 'bench-summary.csv').open('w') as f:
    w = csv.DictWriter(f, records[0].keys()); w.writeheader(); w.writerows(records)
(out / 'bench-summary.json').write_text(json.dumps(records, indent=2))
lines = ['| 接口及元素数 | ARM ns | x86 ns | ARM/x86 |', '|---|---:|---:|---:|']
for case in sorted({x['case'] for x in records}):
    get = lambda a: next(x['median_ns'] for x in records if x['arch']==a and x['case']==case and x['variant']=='base')
    a, x = get('aarch64'), get('x86_64')
    lines.append(f'| `{case}` | {a:.2f} | {x:.2f} | {a/x:.3f} |')
(out / 'related-benchmarks.md').write_text('\n'.join(lines)+'\n')
lines = ['| benchmark | 配置 | ARM 变化 | x86 变化 |', '|---|---|---:|---:|']
for case in sorted({x['case'] for x in records if x['variant']!='base'}):
    for v in ['interleave4', 'interleave8', 'nostack', 'noldst']:
        ds = [x for x in records if x['case']==case and x['variant']==v]
        vals = {x['arch']:f"{x['delta_percent']:+.1f}%" for x in ds}
        lines.append(f"| `{case}` | {v} | {vals.get('aarch64','未测')} | {vals.get('x86_64','不适用')} |")
(out / 'option-scenes.md').write_text('\n'.join(lines)+'\n')
