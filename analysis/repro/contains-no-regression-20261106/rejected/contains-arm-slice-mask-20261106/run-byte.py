from pathlib import Path
import platform,subprocess,json,time
r=Path(__file__).parent;arm=platform.machine()=='aarch64';target='aarch64-unknown-linux-gnu' if arm else 'x86_64-unknown-linux-gnu';core='52' if arm else '12'
cases=[(ty,le,off,dist) for ty in ['u8','i8','bool','nonzero','option','ascii'] for le in [8,16,17,31,32,33,63,64,65,2551] for off in [0,1] for dist in ['absent','front','middle','last']]
(r/'byte-scenarios.json').write_text(json.dumps(cases));rows=[];start=time.time()
for trial in range(3):
 for ty,le,off,dist in cases if trial%2==0 else cases[::-1]:
  n=min(3000000,max(10000,128000000//le));n=3000000 if dist=='front' else n
  for variant in ['baseline','optimized'] if trial%2==0 else ['optimized','baseline']:
   alias={'baseline':'v0','optimized':'v1'}[variant]
   libs=str(r/'sysroots'/alias/'lib/rustlib'/target/'lib')+('' if arm else ':/nix/store/604gsr59rj7dzd0nrhp143rpvf7gyiaz-gcc-15.3.0-lib/lib')
   cmd=['taskset','-c',core,'env','-u','LD_LIBRARY_PATH','perf','stat','-x',',','-e','cycles:u,instructions:u,branches:u,branch-misses:u,task-clock,context-switches,cpu-migrations','--','env','LD_LIBRARY_PATH='+libs,'setarch',platform.machine(),'-R',str(r/alias/target/'byte-matrix'),ty,str(le),str(off),dist,str(n)]
   p=subprocess.run(cmd,capture_output=True,text=True);assert p.returncode==0,p.stderr
   (r/f'byte-{trial}-{ty}-{le}-{off}-{dist}-{variant}.log').write_text(p.stdout+p.stderr);ev={};running=[]
   for line in p.stderr.splitlines():
    f=line.split(',')
    if len(f)<3 or 'cpu_atom' in f[2]:continue
    try:value=float(f[0])
    except ValueError:continue
    k=f[2].replace('cpu_core/','').replace('/u','').replace(':u','').rstrip('/');ev[k]=value
    if k in ['cycles','instructions','branches','branch-misses'] and len(f)>4:running.append(float(f[4]))
   assert len(running)==4 and min(running)==100
   rows.append({'type':ty,'length':le,'offset':off,'distribution':dist,'variant':variant,'trial':trial,'n':n,'cycles':ev['cycles']/n,'instructions':ev['instructions']/n,'branches':ev['branches']/n,'branch_misses':ev['branch-misses']/n,'ns_cpu':ev['task-clock']*1e6/n,'events':ev,'running_percent':running})
   (r/'byte-results.json').write_text(json.dumps(rows,indent=2)) if len(rows)%32==0 else None
 print('byte trial',trial,'complete',len(rows),flush=True)
(r/'byte-complete.json').write_text(json.dumps({'start':start,'end':time.time(),'rows':len(rows)}))

(r/'byte-results.json').write_text(json.dumps(rows,indent=2))
