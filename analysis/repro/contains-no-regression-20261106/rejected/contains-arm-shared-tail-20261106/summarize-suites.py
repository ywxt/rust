from pathlib import Path
import json,statistics,sys
r=Path(sys.argv[1]) if len(sys.argv)>1 else Path(__file__).parent
keys={'counted':['case'],'matrix':['length','offset','distribution','needle','pattern'],'byte':['type','length','offset','distribution'],'index':['length','offset','distribution','needle','pattern'],'boundary':['length','offset','distribution','needle','pattern'],'split':['case'],'split-long':['case']}
report={}
for suite,fields in keys.items():
 p=r/(suite+'-results.json')
 if not p.exists():continue
 try:rows=json.loads(p.read_text())
 except json.JSONDecodeError:continue
 groups={}
 for x in rows:
  key=tuple(x.get(f) for f in fields);groups.setdefault(key,{}).setdefault(x['variant'],[]).append(x)
 result=[]
 for key,v in groups.items():
  if not all(k in v and len(v[k])>=3 for k in ['baseline','optimized']):continue
  row=dict(zip(fields,key));row['samples']={k:len(x) for k,x in v.items()}
  for metric in ['cycles','instructions','branches','branch_misses','ns_cpu']:
   values={k:[x[metric] for x in vs] for k,vs in v.items()}
   b=statistics.median(values['baseline']);o=statistics.median(values['optimized'])
   row[metric]={'baseline':b,'optimized':o,'change_pct':100*(o/b-1) if b else None,'range':{k:[min(vs),max(vs)] for k,vs in values.items()}}
  result.append(row)
 report[suite]={'rows':len(rows),'cases_complete':len(result),'cases':result}
 print('\n',suite,len(rows),'rows',len(result),'cases')
 for row in sorted(result,key=lambda x:x['cycles']['change_pct'],reverse=True)[:8]:
  print({k:row[k] for k in fields},row['cycles'])
(r/'all-suite-summary.json').write_text(json.dumps(report,indent=2))
