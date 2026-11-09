import pathlib,json
r=pathlib.Path(__file__).resolve().parent;a=json.loads((r/'arm-summary.json').read_text());x=json.loads((r/'summary.json').read_text());assert a['source_sha256']==x['source_sha256'];assert a['compiler_and_source']==x['compiler_and_source'];(r/'comparison.json').write_text(json.dumps({'aarch64':a,'x86_64':x},ensure_ascii=False,indent=2));ab={(v['variant'],v['bench']):v for v in a['bench']};xb={(v['variant'],v['bench']):v for v in x['bench']}
for k in sorted(k[1] for k in ab if k[0]=='baseline'):
 av=ab['baseline',k];ao=ab['optimized',k];xv=xb['baseline',k];xo=xb['optimized',k];am=av['cycles_est'];ap=ao['cycles_est'];xm=xv['cycles_est'];xp=xo['cycles_est'];print(k,'ns',*[v['ns'] for v in [av,ao,xv,xo]],'cycles',*[round(v,2) for v in [am,ap,xm,xp]],'pct',round((ap/am-1)*100,1),round((xp/xm-1)*100,1),'R',round(am/xm,3),round(ap/xp,3))
for arch,s in [('ARM',a),('x86',x)]:
 groups={}
 for v in s['matrix']:groups.setdefault((v['length'],v['offset'],v['distribution'],v['needle']),{})[v['variant']]=v
 print(arch)
 for le in [8,16]:
  vals=[(k,100*(v['optimized']['cycles']/v['baseline']['cycles']-1)) for k,v in groups.items() if k[0]>=le];print('minlen',le,'range',min(v[1] for v in vals),max(v[1] for v in vals),'wins',sum(v[1]<0 for v in vals),len(vals))
 for k in [(8,0,'absent',65),(8,0,'front',65),(128,0,'front',65),(2551,1,'absent',0),(65536,1,'absent',126)]:print(k,[(variant,round(groups[k][variant]['cycles'],2)) for variant in ['baseline','optimized']])
