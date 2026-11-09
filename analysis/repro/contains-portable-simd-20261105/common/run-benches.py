import pathlib,platform,subprocess,json,re,time,os
r=pathlib.Path(__file__).resolve().parent;arm=platform.machine()=='aarch64';target='aarch64-unknown-linux-gnu' if arm else 'x86_64-unknown-linux-gnu';core='52' if arm else '12';rows=[]
def libs(variant):
 return str(r/'sysroots'/variant/'lib/rustlib'/target/'lib')+('' if arm else ':/nix/store/604gsr59rj7dzd0nrhp143rpvf7gyiaz-gcc-15.3.0-lib/lib')
def binary(v):return r/v/target/'benches'
p=subprocess.run(['env','LD_LIBRARY_PATH='+libs('baseline'),str(binary('baseline')),'--list'],capture_output=True,text=True);assert p.returncode==0,p.stderr
names=sorted(x.split(': benchmark')[0] for x in p.stdout.splitlines() if x.endswith(': benchmark'));assert len(names)==28,p.stdout
start=time.time()
for trial in range(3):
 for name in names if trial%2==0 else names[::-1]:
  for variant in ['baseline','optimized'] if trial%2==0 else ['optimized','baseline']:
   p=subprocess.run(['taskset','-c',core,'env','-u','LD_LIBRARY_PATH','perf','stat','-x',',','-e','cycles:u,instructions:u,branches:u,branch-misses:u,task-clock,context-switches,cpu-migrations','--','env','LD_LIBRARY_PATH='+libs(variant),str(binary(variant)),'--bench',name,'--exact','--format=terse'],capture_output=True,text=True)
   (r/f'bench-{trial}-{variant}-{name}.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stderr
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
   rows.append({'trial':trial,'variant':variant,'bench':name,'ns':ns,'cycles_est':c,'instructions_est':c*ev['instructions']/ev['cycles'],'events':ev,'running_percent':running});(r/'bench-results.json').write_text(json.dumps(rows,indent=2))
 print('bench trial',trial,'complete',len(rows),flush=True)
(r/'bench-complete.json').write_text(json.dumps({'start':start,'end':time.time(),'rows':len(rows)}))
