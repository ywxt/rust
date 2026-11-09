import pathlib,platform,subprocess,json,re,time
r=pathlib.Path(__file__).resolve().parent;arm=platform.machine()=='aarch64';core='52' if arm else '12';libs=pathlib.Path('/tmp/xdiff/libdir.txt').read_text().strip();env=['env','LD_LIBRARY_PATH='+libs]
p=subprocess.run(env+[str(r/'benches'),'--list'],capture_output=True,text=True);assert p.returncode==0,p.stderr
names=sorted(x.split(': benchmark')[0] for x in p.stdout.splitlines() if x.endswith(': benchmark') and x.startswith('main::'));assert len(names)==28,p.stdout
rows=[];start=time.time()
for trial in range(3):
 for name in names if trial%2==0 else names[::-1]:
  pair=[name,name.replace('main::','optimized::')]
  for case in pair if trial%2==0 else pair[::-1]:
   p=subprocess.run(['taskset','-c',core,'env','-u','LD_LIBRARY_PATH','perf','stat','-x',',','-e','cycles:u,instructions:u,branches:u,branch-misses:u,task-clock,context-switches,cpu-migrations','--']+env+[str(r/'benches'),'--bench',case,'--exact','--format=terse'],capture_output=True,text=True)
   (r/f'bench-{trial}-{case}.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stderr
   m=re.search(r'([\d,.]+)ns/iter',p.stdout) or re.search(r'bench:\s+([\d,.]+) ns/iter',p.stdout);assert m,p.stdout
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
   ns=float(m[1].replace(',',''));c=ns*ev['cycles']/ev['task-clock']/1e6
   rows.append({'trial':trial,'bench':case,'ns':ns,'cycles_est':c,'instructions_est':c*ev['instructions']/ev['cycles'],'events':ev,'running_percent':running})
   (r/'bench-results.json').write_text(json.dumps(rows,indent=2))
 print('bench trial',trial,'complete',len(rows),flush=True)
(r/'bench-complete.json').write_text(json.dumps({'start':start,'end':time.time(),'rows':len(rows)}))
