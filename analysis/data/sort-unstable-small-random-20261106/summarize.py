from pathlib import Path
import json,statistics as st,csv
r=Path(__file__).resolve().parent;out=r/'delivery';out.mkdir(exist_ok=True);expected=dict(target=lambda a:60 if a=='aarch64'else 30,related=lambda a:66,probes=lambda a:549,layout=lambda a:96,nolsr=lambda a:20,**{'nolsr-probes':lambda a:549});validation={}
for phase in expected:
 combined=[]
 for arch,p in [('aarch64',r/'arm-final'),('x86_64',r)]:
  rows=json.loads((p/f'{phase}.{arch}.json').read_text());assert len(rows)==expected[phase](arch),(phase,arch,len(rows));validation[phase+'.'+arch]=dict(rows=len(rows),min_running=min(min(x['running'].values())for x in rows),major_faults=sum(x['metrics'].get('major-faults',0)for x in rows),migrations=sum(x['metrics'].get('cpu-migrations',0)for x in rows));assert validation[phase+'.'+arch]['min_running']>=99.9
  fields=[f for f in ['variant','case','mode','n','pattern','offset']if f in rows[0]]
  keys=sorted({tuple(x[f]for f in fields)for x in rows})
  for key in keys:
   ds=[x for x in rows if tuple(x[f]for f in fields)==key];d=dict(arch=arch,**dict(zip(fields,key)),trials=len(ds),ns=st.median(x['ns']for x in ds),min_ns=min(x['ns']for x in ds),max_ns=max(x['ns']for x in ds))
   if 'per_call'in ds[0]:d.update({k:st.median(x['per_call'][k]for x in ds)for k in ['cycles','instructions','branches','branch-misses']})
   d['GHz']=st.median(x['metrics']['cycles']/x['metrics']['task-clock']/1e6 for x in ds);combined.append(d)
 (out/(phase+'-summary.json')).write_text(json.dumps(combined,indent=2))
 names=list(dict.fromkeys(k for x in combined for k in x))
 with (out/(phase+'-summary.csv')).open('w')as f:w=csv.DictWriter(f,names);w.writeheader();w.writerows(combined)
lines=['| 原 benchmark | ARM ns | x86 ns |','|---|---:|---:|']
rows=json.loads((out/'related-summary.json').read_text())
for case in sorted({x['case']for x in rows}):
 vals={x['arch']:x['ns']for x in rows if x['case']==case};lines.append(f"| `{case}` | {vals['aarch64']:.2f} | {vals['x86_64']:.2f} |")
(out/'related-benchmarks.md').write_text('\n'.join(lines)+'\n');(out/'validation.json').write_text(json.dumps(validation,indent=2))
