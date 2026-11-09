from pathlib import Path
import subprocess,os,platform,json,time,re,random,sys
r=Path(__file__).resolve().parent;arch=platform.machine();target=arch+'-unknown-linux-gnu';core='52' if arch=='aarch64' else '12';phase=sys.argv[1];e=os.environ.copy();e.pop('LD_LIBRARY_PATH',None);lib='/tmp/contains-bad-simd-20261105/sysroots/baseline/lib/rustlib/'+target+'/lib'+('' if arch=='aarch64' else ':/nix/store/604gsr59rj7dzd0nrhp143rpvf7gyiaz-gcc-15.3.0-lib/lib');events=[('cpu_core/'+x+'/u'if arch=='x86_64'else x+':u')for x in ['cycles','instructions','branches','branch-misses']]+['task-clock','context-switches','cpu-migrations','minor-faults','major-faults'];variants=['base','nostack','nounroll']+(['noselect','noifcvt','noldst']if arch=='aarch64'else[])
def child(binary,args):return ['env','LD_LIBRARY_PATH='+lib,'setarch',arch,'-R',str(r/target/binary)]+list(map(str,args))
def measure(binary,args):
 c=['taskset','-c',core,'perf','stat','-x,','-e',','.join(events),'--']+child(binary,args);start=time.monotonic_ns();p=subprocess.run(c,env=e,text=True,capture_output=True,timeout=120);assert p.returncode==0,p.stderr;elapsed=time.monotonic_ns()-start;metrics={};running={}
 for line in p.stderr.splitlines():
  f=line.split(',')
  if len(f)<3:continue
  try:v=float(f[0])
  except ValueError:continue
  k=f[2].replace('cpu_core/','').replace('/u','').replace(':u','');metrics[k]=v
  if k in ['cycles','instructions','branches','branch-misses']:running[k]=float(f[4]);assert running[k]>=99.9,p.stderr
 return dict(command=c,stdout=p.stdout,stderr=p.stderr,metrics=metrics,running=running,wall_ns=elapsed,cpu_wall_ratio=metrics['task-clock']*1e6/elapsed)
def save(rows):(r/(phase+'.'+arch+'.json')).write_text(json.dumps(rows,indent=2))
rows=[];print(phase,'start',flush=True)
if phase in ['target','nolsr']:
 if phase=='nolsr':variants=['base','nolsr']
 if sys.argv[2:]:variants=sys.argv[2:]
 for trial in range(5):
  vs=variants.copy();random.Random(882+trial).shuffle(vs)
  for v in vs:
   case='slice::sort_unstable_small_random';d=measure('benches-'+v,['--bench','--exact','--test-threads=1',case]);m=re.search(r'bench:\s+([\d,.]+) ns/iter',d['stdout']);assert m,d['stdout'];rows.append(dict(trial=trial,variant=v,mode='libtest',case=case,ns=float(m[1].replace(',','')),**d));save(rows)
   n=10000000;d=measure('counted-'+v,[case,n]);rows.append(dict(trial=trial,variant=v,mode='counted',case=case,reps=n,ns=int(d['stdout'].strip())/n,per_call={k:d['metrics'][k]/n for k in ['cycles','instructions','branches','branch-misses']},**d));save(rows)
  print(phase,'round',trial,'complete',flush=True)
elif phase=='related':
 names=['slice::'+n for n in json.loads((r/'provenance.json').read_text())['benchmarks']];vs=sys.argv[2:] or ['base'];configs=[(v,n)for v in vs for n in names]
 for trial in range(3):
  cs=configs.copy();random.Random(4671+trial).shuffle(cs)
  for v,case in cs:
   d=measure('benches-'+v,['--bench','--exact','--test-threads=1',case]);m=re.search(r'bench:\s+([\d,.]+) ns/iter',d['stdout']);assert m,d['stdout'];rows.append(dict(trial=trial,variant=v,case=case,ns=float(m[1].replace(',','')),**d));save(rows)
  print(phase,'round',trial,'complete',flush=True)
elif phase in ['probes','nolsr-probes']:
 if phase=='nolsr-probes':variants=['base','nolsr']
 if sys.argv[2:]:variants=sys.argv[2:]
 for v in variants:
  p=subprocess.run(['taskset','-c',core]+child('probes-'+v,['check']),env=e,text=True,capture_output=True);assert p.returncode==0,p.stderr;(r/('check.'+v+'.'+arch+'.txt')).write_text(p.stdout+p.stderr)
 configs=[(v,mode,n,p)for v in variants for mode in ['sort','full'] for n in [0,1,2,5,10,16,20,21,32] for p in ['original','ascending','descending','equal','few']]+[('base',m,10,'original')for m in ['clone','reset','vary']]
 for trial in range(3):
  cs=configs.copy();random.Random(1348+trial).shuffle(cs)
  for v,mode,n,p in cs:
   reps=1000000;d=measure('probes-'+v,[mode,n,p,reps]);rows.append(dict(trial=trial,variant=v,mode=mode,n=n,pattern=p,reps=reps,ns=int(d['stdout'].strip())/reps,per_call={k:d['metrics'][k]/reps for k in ['cycles','instructions','branches','branch-misses']},**d));save(rows)
  print(phase,'round',trial,'complete',flush=True)
elif phase=='profile':
 for v in ['base']:
  data=r/('profile.'+v+'.'+arch+'.data');event='cpu_core/cycles/u'if arch=='x86_64'else'cycles:u';c=['taskset','-c',core,'perf','record','-q','-F','1999','-e',event,'-g','-o',str(data),'--']+child('benches-'+v,['--bench','--exact','--test-threads=1','slice::sort_unstable_small_random']);p=subprocess.run(c,env=e,text=True,capture_output=True,check=True);q=subprocess.run(['perf','report','--stdio','--no-children','--percent-limit','0.5','-i',str(data)],env=e,text=True,capture_output=True,check=True);(r/('profile.'+v+'.'+arch+'.txt')).write_text(q.stdout+q.stderr);rows.append(dict(variant=v,command=c,stdout=p.stdout,stderr=p.stderr));save(rows)
elif phase=='layout':
 for trial in range(3):
  offsets=list(range(0,256,16));random.Random(7590+trial).shuffle(offsets)
  for offset in offsets:
   v=f'layout{offset:03}';case='slice::sort_unstable_small_random';d=measure('benches-'+v,['--bench','--exact','--test-threads=1',case]);m=re.search(r'bench:\s+([\d,.]+) ns/iter',d['stdout']);assert m,d['stdout'];rows.append(dict(trial=trial,variant=v,offset=offset,mode='libtest',case=case,ns=float(m[1].replace(',','')),**d));save(rows)
   n=10000000;d=measure('counted-'+v,[case,n]);rows.append(dict(trial=trial,variant=v,offset=offset,mode='counted',case=case,reps=n,ns=int(d['stdout'].strip())/n,per_call={k:d['metrics'][k]/n for k in ['cycles','instructions','branches','branch-misses']},**d));save(rows)
  print(phase,'round',trial,'complete',flush=True)
else:raise ValueError(phase)
print(phase,'complete',flush=True)
