from pathlib import Path
import json,statistics as st,csv
r=Path(__file__).resolve().parent;d=r/'delivery';d.mkdir(exist_ok=True);expect={'bench':(96,96),'cases':(120,120),'matrix':(1872,1872),'flags':(540,324),'alu':(10,10),'load':(96,48),'align16':(1248,1248),'shim':(96,96)};validation={}
for phase,counts in expect.items():
 summary=[]
 for i,(arch,p)in enumerate([('aarch64',r/'arm-final'),('x86_64',r)]):
  rows=json.loads((p/f'{phase}.{arch}.json').read_text());assert len(rows)==counts[i],(phase,arch,len(rows));assert all(min(x['running'].values())>=99.9 for x in rows);assert all(x['metrics']['cpu-migrations']==0 for x in rows)
  validation[phase+'.'+arch]=dict(rows=len(rows),min_running=min(min(x['running'].values())for x in rows),major_faults=sum(x['metrics'].get('major-faults',0)for x in rows),max_context_switches=max(x['metrics'].get('context-switches',0)for x in rows),migrations=0)
  keys=[k for k in ['variant','case','mode','method','n','alignment','pattern','needle']if k in rows[0]]
  for group in sorted({tuple(x[k]for k in keys)for x in rows}):
   rs=[x for x in rows if tuple(x[k]for k in keys)==group];v=dict(arch=arch,**dict(zip(keys,group)),trials=len(rs),ns=st.median(x['ns']for x in rs),min_ns=min(x['ns']for x in rs),max_ns=max(x['ns']for x in rs))
   if'per_call'in rs[0]:v.update({k:st.median(x['per_call'][k]for x in rs)for k in ['cycles','instructions','branches','branch-misses']})
   v['cycles_per_task_ns']=st.median(x['metrics']['cycles']/x['metrics']['task-clock']/1e6 for x in rs);summary.append(v)
 (d/f'{phase}-summary.json').write_text(json.dumps(summary,indent=2));fields=list(dict.fromkeys(k for x in summary for k in x))
 with(d/f'{phase}-summary.csv').open('w')as f:w=csv.DictWriter(f,fields);w.writeheader();w.writerows(summary)
for phase,methods in [('matrix',['v16','crate']),('align16',['align16'])]:
 rs=json.loads((d/f'{phase}-summary.json').read_text());out=[]
 for x in rs:
  if x['method']not in methods:continue
  b=next(y for y in rs if y['method']=='core'and all(y[k]==x[k]for k in ['arch','n','alignment','pattern']));out.append(dict(**x,base_ns=b['ns'],base_cycles=b['cycles'],delta_ns_percent=100*(x['ns']/b['ns']-1),delta_cycles_percent=100*(x['cycles']/b['cycles']-1)))
 (d/f'{phase}-comparison.json').write_text(json.dumps(out,indent=2));fields=list(out[0])
 with(d/f'{phase}-comparison.csv').open('w')as f:w=csv.DictWriter(f,fields);w.writeheader();w.writerows(out)
(d/'validation.json').write_text(json.dumps(validation,indent=2))
rows=json.loads((d/'bench-summary.json').read_text());lines=['| 原 benchmark | ARM ns | x86 ns |','|---|---:|---:|']
for case in sorted({x['case']for x in rows}):
 vals={x['arch']:x['ns']for x in rows if x['case']==case and x['mode']=='libtest'};lines.append(f"| `{case}` | {vals['aarch64']:.2f} | {vals['x86_64']:.2f} |")
(d/'all-original-benchmarks.md').write_text('\n'.join(lines)+'\n')
