from pathlib import Path
import json,platform,subprocess,statistics,sys,time
r=Path(__file__).parent;arm=platform.machine()=='aarch64';t='aarch64-unknown-linux-gnu' if arm else 'x86_64-unknown-linux-gnu';core='52' if arm else '12'
configs=json.loads((r/'retest-cases.json').read_text());rows=[]
for trial in range(9):
 for j,c in (list(enumerate(configs)) if trial%2==0 else list(enumerate(configs))[::-1]):
  for v,alias in ([('baseline','v0'),('optimized','v1')] if trial%2==0 else [('optimized','v1'),('baseline','v0')]):
   n=c['n'];suite=c['suite'];args=[]
   if suite in ['matrix','boundary','index']:
    program='index-matrix' if suite=='index' else 'matrix';args=['main',str(c['length']),str(c['offset']),c['distribution'],str(c['needle']),str(n),c['pattern']]
   elif suite=='byte':program='byte-matrix';args=[c['type'],str(c['length']),str(c['offset']),c['distribution'],str(n)]
   elif suite in ['counted','split']:program='counted' if suite=='counted' else 'split-counted';args=[c['case'],str(n)]
   else:raise ValueError(suite)
   libs=str(r/'sysroots'/alias/'lib/rustlib'/t/'lib')+('' if arm else ':/nix/store/604gsr59rj7dzd0nrhp143rpvf7gyiaz-gcc-15.3.0-lib/lib')
   cmd=['taskset','-c',core,'env','-u','LD_LIBRARY_PATH','perf','stat','-x',',','-e','cycles:u,instructions:u,branches:u,branch-misses:u,task-clock,context-switches,cpu-migrations','--','env','LD_LIBRARY_PATH='+libs,'setarch',platform.machine(),'-R',str(r/alias/t/program)]+args
   p=subprocess.run(cmd,capture_output=True,text=True);(r/f'retest-{j}-{trial}-{v}.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stderr
   ev={};running=[]
   for line in p.stderr.splitlines():
    f=line.split(',')
    if len(f)<3 or 'cpu_atom' in f[2]:continue
    try:value=float(f[0])
    except ValueError:continue
    k=f[2].replace('cpu_core/','').replace('/u','').replace(':u','').rstrip('/');ev[k]=value
    if k in ['cycles','instructions','branches','branch-misses'] and len(f)>4:running.append(float(f[4]))
   assert len(running)==4 and min(running)==100
   rows.append(dict(c,trial=trial,variant=v,cycles=ev['cycles']/n,instructions=ev['instructions']/n,branches=ev['branches']/n,branch_misses=ev['branch-misses']/n,ns_cpu=ev['task-clock']*1e6/n,events=ev,running_percent=running))
 (r/'retest-results.json').write_text(json.dumps(rows,indent=2));print('retest',trial,len(rows),flush=True)
for c in configs:
 samples={v:[x['cycles'] for x in rows if x['variant']==v and all(x.get(k)==y for k,y in c.items())] for v in ['baseline','optimized']}
 b=statistics.median(samples['baseline']);o=statistics.median(samples['optimized']);print(c,b,o,100*(o/b-1),samples,flush=True)
