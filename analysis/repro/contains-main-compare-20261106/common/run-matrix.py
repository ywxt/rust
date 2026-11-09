import pathlib,platform,subprocess,json,time
r=pathlib.Path(__file__).resolve().parent;arm=platform.machine()=='aarch64';target='aarch64-unknown-linux-gnu' if arm else 'x86_64-unknown-linux-gnu';core='52' if arm else '12';rows=[]
cases=[(le,off,dist,needle,"str") for le in [8,16,32,64,128,256,2551,65536] for off in [0,1] for dist in ['absent','front','last'] for needle in [0,65,126]];start=time.time()
cases += [(le,off,dist,65,pattern) for le in [1,15,17,31,33,63,65,127,129] for off in [0,63] for dist in ["absent","middle"] for pattern in ["str","char"]]
cases += [(le,off,dist,126,pattern) for le in [64,128,2551] for off in [15,16,31,32] for dist in ["absent","middle","last"] for pattern in ["str","char"]]
(r/"matrix-scenarios.json").write_text(json.dumps(cases))
for trial in range(3):
 for le,off,dist,needle,pattern in cases if trial%2==0 else cases[::-1]:
  n=min(3000000,max(10000,256000000//le));n=3000000 if dist=='front' else n
  for variant in ['main','manual','simd16','simd64'] if trial%2==0 else ['simd64','simd16','manual','main']:
   alias={'main':'v0','manual':'v1','simd16':'v2','simd64':'v3'}[variant]
   libs=str(r/'sysroots'/alias/'lib/rustlib'/target/'lib')+('' if arm else ':/nix/store/604gsr59rj7dzd0nrhp143rpvf7gyiaz-gcc-15.3.0-lib/lib')
   p=subprocess.run(['taskset','-c',core,'env','-u','LD_LIBRARY_PATH','perf','stat','-x',',','-e','cycles:u,instructions:u,branches:u,branch-misses:u,task-clock,context-switches,cpu-migrations','--','env','LD_LIBRARY_PATH='+libs,'setarch',platform.machine(),'-R',str(r/alias/target/'matrix'),'main',str(le),str(off),dist,str(needle),str(n),pattern],capture_output=True,text=True)
   (r/f'matrix-{trial}-{le}-{off}-{dist}-{needle}-{pattern}-{variant}.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stderr
   ev={};running=[]
   for line in p.stderr.splitlines():
    f=line.split(',')
    if len(f)<3 or 'cpu_atom' in f[2]:continue
    try:v=float(f[0])
    except ValueError:continue
    k=f[2].replace('cpu_core/','').replace('/u','').replace(':u','').rstrip('/');ev[k]=v
    if k in ['cycles','instructions','branches','branch-misses'] and len(f)>4:
     try:running.append(float(f[4]))
     except ValueError:pass
   rows.append({'trial':trial,'length':le,'offset':off,'distribution':dist,'needle':needle,'variant':variant,'pattern':pattern,'n':n,'cycles':ev['cycles']/n,'instructions':ev['instructions']/n,'branches':ev['branches']/n,'branch_misses':ev['branch-misses']/n,'ns_cpu':ev['task-clock']*1e6/n,'events':ev,'running_percent':running});(r/'matrix-results.json').write_text(json.dumps(rows,indent=2))
 print('matrix trial',trial,'complete',len(rows),flush=True)
(r/'matrix-complete.json').write_text(json.dumps({'start':start,'end':time.time(),'rows':len(rows)}))
