from pathlib import Path
import os,platform,subprocess,json,random,statistics,hashlib,fcntl
p=Path(__file__).resolve().parent;arch=platform.machine();core='12' if arch=='x86_64' else '52';n=20000000
lock=open('/tmp/xdiff/core'+core+'.lock','a');fcntl.flock(lock,fcntl.LOCK_EX|fcntl.LOCK_NB)
env=os.environ.copy();env['LD_LIBRARY_PATH']=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+env.get('LD_LIBRARY_PATH','')
prefix='cpu_core/' if arch=='x86_64' else ''
events=['cpu_core/cycles/u','cpu_core/instructions/u','cpu_core/branch-misses/u'] if arch=='x86_64' else ['cycles:u','instructions:u','branch-misses:u']
tags=['normal','no-color','no-ldst','sret_both','sret_pair','sret_bothpair','sret_pairclean','sret_bothpairclean']
cases=[(tag,'base') for tag in tags]
runs={tag+'/'+mode:[] for tag,mode in cases};rng=random.Random(20261104)
for rep in range(5):
 order=cases[:];rng.shuffle(order)
 for tag,mode in order:
  cmd=['perf','stat','-x,','-e',','.join(events),'--','taskset','-c',core,'env','LD_LIBRARY_PATH='+env['LD_LIBRARY_PATH'],str(p/tag),mode,str(n)]
  perf_env=os.environ.copy();perf_env.pop('LD_LIBRARY_PATH',None)
  r=subprocess.run(cmd,env=perf_env,text=True,capture_output=True)
  if r.returncode:raise RuntimeError(r.stderr)
  values={}
  for line in r.stderr.splitlines():
   z=line.split(',')
   if len(z)>2 and z[2] in events:values[z[2]]=float(z[0])/n
  assert len(values)==3,r.stderr
  runs[tag+'/'+mode].append([values[e] for e in events])
 print('round',rep+1,'done',flush=True)
rows=[]
for key,rr in runs.items():
 med=statistics.median(r[0] for r in rr);best=min(rr,key=lambda x:x[0]);row={'case':key,'median_cycles':med,'min_cycles':best[0],'instructions':statistics.median(r[1] for r in rr),'branch_misses':statistics.median(r[2] for r in rr),'runs':rr};rows.append(row)
 print(key,round(med,3),'cycles',round(row['instructions'],3),'instructions',flush=True)
rustc=Path('/tmp/xdiff/rustc.txt').read_text().strip()
result={'arch':arch,'core':core,'n':n,'reps':5,'source_sha256':hashlib.sha256((p/'probe.rs').read_bytes()).hexdigest(),'compiler':subprocess.check_output([rustc,'-vV'],env=env,text=True),'events':events,'rows':rows}
(p/('fixed-address.'+arch+'.json')).write_text(json.dumps(result,indent=2))
for tag in tags:
 lines=subprocess.check_output(['objdump','-d','-C',str(p/tag)],text=True).splitlines();keep=False;out=[]
 for line in lines:
  if line and not line[0].isspace() and line.endswith('>:'):keep='<probe::' in line or '<std::any' in line
  if keep:out.append(line)
 (p/(tag+'.'+arch+'.asm')).write_text('\n'.join(out)+'\n')
