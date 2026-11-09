import pathlib,platform,subprocess,json,time,hashlib
r=pathlib.Path(__file__).resolve().parent;arm=platform.machine()=='aarch64';core='52' if arm else '12';libs=pathlib.Path('/tmp/xdiff/libdir.txt').read_text().strip();rows=[]
cases=[(le,off,dist,needle) for le in [8,16,32,64,128,256,2551,65536] for off in [0,1] for dist in ['absent','front','last'] for needle in [0,65,126]]
start=time.time()
for trial in range(3):
 for le,off,dist,needle in cases if trial%2==0 else cases[::-1]:
  n=min(3000000,max(10000,256000000//le));n=3000000 if dist=='front' else n
  for mode in ['main','optimized'] if trial%2==0 else ['optimized','main']:
   p=subprocess.run(['taskset','-c',core,'env','-u','LD_LIBRARY_PATH','perf','stat','-x',',','-e','cycles:u,instructions:u,branches:u,branch-misses:u,task-clock,context-switches,cpu-migrations','--','env','LD_LIBRARY_PATH='+libs,str(r/'matrix'),mode,str(le),str(off),dist,str(needle),str(n)],capture_output=True,text=True)
   (r/f'matrix-{trial}-{le}-{off}-{dist}-{needle}-{mode}.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stderr
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
   rows.append({'trial':trial,'length':le,'offset':off,'distribution':dist,'needle':needle,'mode':mode,'n':n,'cycles':ev['cycles']/n,'instructions':ev['instructions']/n,'branches':ev['branches']/n,'branch_misses':ev['branch-misses']/n,'ns_cpu':ev['task-clock']*1e6/n,'events':ev,'running_percent':running})
  (r/'matrix-results.json').write_text(json.dumps(rows,indent=2))
 print('matrix trial',trial,'complete',len(rows),flush=True)
(r/'matrix-complete.json').write_text(json.dumps({'start':start,'end':time.time(),'rows':len(rows),'source_sha256':hashlib.sha256((r/'contains_impl.rs').read_bytes()).hexdigest()}))
