import pathlib,json,statistics,collections
r=pathlib.Path(__file__).resolve().parent
out={}
for arch,f in [('aarch64','arm-matrix-results.json'),('x86_64','matrix-results.json')]:
 rows=json.loads((r/f).read_text()); groups=collections.defaultdict(list)
 for v in rows:groups[(v['length'],v['offset'],v['distribution'],v['mode'])].append(v)
 agg={k:{m:statistics.median(v[m] for v in vs) for m in ['cycles','instructions','branches','branch_misses','ns_cpu']}|{'cycles_min':min(v['cycles'] for v in vs),'cycles_max':max(v['cycles'] for v in vs)} for k,vs in groups.items()}; assert all(len(v)==3 for v in groups.values())
 comparisons=[]
 for le,off,dist,mode in agg:
  if mode!='std_str':continue
  base=agg[(le,off,dist,'std_str')];simd=agg[(le,off,dist,'simd64')];align=agg[(le,off,dist,'align64')]
  comparisons.append({'length':le,'offset':off,'distribution':dist,'std':base,'simd':simd,'align':align,'align_vs_std_pct':100*(1-align['cycles']/base['cycles']),'align_vs_simd_pct':100*(1-align['cycles']/simd['cycles'])})
 out[arch]=comparisons
 print(arch,'PMU',min(z for v in rows for z in v['running_percent']))
 for dist in ['front','middle','last','absent']:
  cases=[v for v in comparisons if v['distribution']==dist]; print(dist,'vsstd',round(min(v['align_vs_std_pct'] for v in cases),1),round(max(v['align_vs_std_pct'] for v in cases),1),'wins',sum(v['align_vs_std_pct']>0 for v in cases),'/',len(cases))
 print('worst vsstd')
 for v in sorted(comparisons,key=lambda v:v['align_vs_std_pct'])[:5]: print(v['length'],v['offset'],v['distribution'],*(round(v[m]['cycles'],2) for m in ['std','simd','align']),round(v['align_vs_std_pct'],1))
 print('selected')
 for v in comparisons:
  if v['offset']==0 and v['length'] in [8,32,64,65,128,256,2551,65536]: print(v['length'],v['distribution'],*(round(v[m]['cycles'],2) for m in ['std','simd','align']))
(r/'comparison.json').write_text(json.dumps(out,indent=2))
