import json,pathlib
r=pathlib.Path(__file__).resolve().parent;a=json.loads((r/'arm-summary.json').read_text());x=json.loads((r/'summary.json').read_text());assert a['source_sha256']==x['source_sha256'];out={'aarch64':a,'x86_64':x};(r/'comparison.json').write_text(json.dumps(out,ensure_ascii=False,indent=2))
ab={v['bench']:v for v in a['bench']};xb={v['bench']:v for v in x['bench']}
for k in sorted(k[6:] for k in ab if k.startswith('main::')):
 av=ab['main::'+k];ao=ab['optimized::'+k];xv=xb['main::'+k];xo=xb['optimized::'+k];print(k,'ns',*[v['ns'] for v in [av,ao,xv,xo]],'cycles',*[round(v['cycles_est'],2) for v in [av,ao,xv,xo]],'pct',round(100*(ao['cycles_est']/av['cycles_est']-1),1),round(100*(xo['cycles_est']/xv['cycles_est']-1),1),'R',round(av['cycles_est']/xv['cycles_est'],3),round(ao['cycles_est']/xo['cycles_est'],3))
for arch,s in [('aarch64',a),('x86_64',x)]:
 groups={}
 for v in s['matrix']:groups.setdefault((v['length'],v['offset'],v['distribution'],v['needle']),{})[v['mode']]=v
 print(arch,'matrix')
 for minimum in [8,16]:
  vs=[(k,100*(v['optimized']['cycles']/v['main']['cycles']-1)) for k,v in groups.items() if k[0]>=minimum]
  print('minlen',minimum,'range',min(v[1] for v in vs),max(v[1] for v in vs),'wins',sum(v[1]<0 for v in vs),len(vs))
 for k in [(8,0,'absent',65),(8,0,'front',65),(2551,1,'absent',0),(2551,1,'last',65),(65536,1,'absent',126)]:
  v=groups[k];print(k,[(m,round(v[m]['cycles'],2)) for m in ['main','optimized']])
