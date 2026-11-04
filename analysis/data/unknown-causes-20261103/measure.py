from pathlib import Path
import os,subprocess,json,platform,sys
root=Path(__file__).resolve().parent
arch=platform.machine();core='12' if arch=='x86_64' else '52'
env=os.environ.copy();env.pop('LD_LIBRARY_PATH',None)
lib=Path('/tmp/xdiff/libdir.txt').read_text().strip()
events=['cpu_core/cycles/u','cpu_core/instructions/u','cpu_core/branch-misses/u','cpu_core/idq_bubbles.cycles_0_uops_deliv.core/u'] if arch=='x86_64' else ['cycles:u','instructions:u','branch-misses:u','stalled-cycles-frontend:u']
rows=[]
for args,den in json.loads(sys.argv[1]):
 runs=[]
 for rep in range(3):
  cmd=['perf','stat','-x,','-e',','.join(events),'--','taskset','-c',core,'env','LD_LIBRARY_PATH='+lib]+args
  p=subprocess.run(cmd,env=env,text=True,capture_output=True)
  if p.returncode: raise RuntimeError(str(cmd)+p.stderr)
  vals=[]
  for l in p.stderr.splitlines():
   z=l.split(',')
   if len(z)>2 and z[2] in events: vals.append(float(z[0]))
  if len(vals)!=len(events): raise RuntimeError(p.stderr)
  runs.append([v/den for v in vals])
 best=min(runs,key=lambda x:x[0]); row={'arch':arch,'args':args,'denominator':den,'cycles':best[0],'instructions':best[1],'misses':best[2],'fe':best[3],'all_runs':runs};rows.append(row);print(json.dumps(row),flush=True)
(root/(sys.argv[2]+'.'+arch+'.json')).write_text(json.dumps(rows,indent=2))
