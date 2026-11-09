from pathlib import Path
import subprocess,os,platform,json,time,re,random,sys,hashlib
r=Path(__file__).resolve().parent;arch=platform.machine();target=arch+'-unknown-linux-gnu';core='52' if arch=='aarch64' else '12';phase=sys.argv[1];e=os.environ.copy();e.pop('LD_LIBRARY_PATH',None);lib='/tmp/contains-bad-simd-20261105/sysroots/baseline/lib/rustlib/'+target+'/lib'+('' if arch=='aarch64' else ':/nix/store/604gsr59rj7dzd0nrhp143rpvf7gyiaz-gcc-15.3.0-lib/lib');wrap=['setarch',arch,'-R'] if subprocess.run(['setarch',arch,'-R','true'],env=e,capture_output=True).returncode==0 else [];events=[('cpu_core/'+x+'/u' if arch=='x86_64' else x+':u') for x in ['cycles','instructions','branches','branch-misses']]+['task-clock','context-switches','cpu-migrations','minor-faults','major-faults'];jpath=r/('journal.'+arch+'.json');journal=json.loads(jpath.read_text()) if jpath.exists() else []
def mark(state):journal.append(dict(phase=phase,state=state,time=time.time()));jpath.write_text(json.dumps(journal,indent=2));print(phase,state,flush=True)
def child(binary,args,cache='default'):
 return ['env','LD_LIBRARY_PATH='+lib]+(['GLIBC_TUNABLES=glibc.malloc.tcache_count=0'] if cache=='off' else [])+wrap+[str(r/target/binary)]+list(map(str,args))
def measure(binary,args,cache='default'):
 c=['taskset','-c',core,'perf','stat','-x,','-e',','.join(events),'--']+child(binary,args,cache);start=time.monotonic_ns();p=subprocess.run(c,env=e,text=True,capture_output=True,timeout=90);assert p.returncode==0,p.stderr;elapsed=time.monotonic_ns()-start;metrics={};running={}
 for line in p.stderr.splitlines():
  f=line.split(',')
  if len(f)<3:continue
  try:v=float(f[0])
  except ValueError:continue
  k=f[2].replace('cpu_core/','').replace('/u','').replace(':u','');metrics[k]=v
  if k in ['cycles','instructions','branches','branch-misses']:running[k]=float(f[4]);assert running[k]>=99.9,p.stderr
 return dict(command=c,stdout=p.stdout,stderr=p.stderr,metrics=metrics,running=running,wall_ns=elapsed,cpu_wall_ratio=metrics['task-clock']*1e6/elapsed)
def save(rows): (r/(phase+'.'+arch+'.json')).write_text(json.dumps(rows,indent=2))
mark('start');rows=[];names=['vec::'+x for x in json.loads((r/'provenance.json').read_text())['benchmark_functions']]
if phase=='bench':
 variants=['base','interleave4','interleave8','nostack']+(['noldst'] if arch=='aarch64' else []);configs=[(v,n) for v in variants for n in names if v=='base' or any(x in n for x in ['from_iter','from_slice','clone_'])]
 for trial in range(3):
  order=configs.copy();random.Random(771+trial).shuffle(order)
  for v,n in order:
   d=measure('benches-'+v,['--bench','--exact','--test-threads=1',n]);m=re.search(r'bench:\s+([\d,.]+) ns/iter',d['stdout']);assert m,d['stdout'];rows.append(dict(trial=trial,variant=v,case=n,ns=float(m[1].replace(',','')),**d));save(rows)
  print('bench round',trial,'complete',flush=True)
elif phase=='counted':
 configs=[(n,actor) for n in names for actor in ['main','worker']]
 for trial in range(3):
  order=configs.copy();random.Random(922+trial).shuffle(order)
  for n,actor in order:
   reps=1000000 if n.endswith('1000') else 5000000;d=measure('counted-base',[n,reps,actor]);rows.append(dict(trial=trial,case=n,actor=actor,reps=reps,per_call={k:d['metrics'][k]/reps for k in ['cycles','instructions','branches','branch-misses']},**d));save(rows)
  print('counted round',trial,'complete',flush=True)
elif phase=='primitive':
 configs=[(size,mode,actor,cache) for size in [80,800,8000] for mode in ['alloc','copy','alloc_copy'] for actor in ['main','worker'] for cache in ['default','off']]
 for trial in range(3):
  order=configs.copy();random.Random(1113+trial).shuffle(order)
  for size,mode,actor,cache in order:
   reps=1000000 if size==8000 else 5000000;d=measure('diagnostics-base',[mode,size,reps,0,0,actor],cache);loop=json.loads(d['stdout']);rows.append(dict(trial=trial,size=size,mode=mode,actor=actor,cache=cache,reps=reps,loop=loop,per_call={k:d['metrics'][k]/reps for k in ['cycles','instructions','branches','branch-misses']},ns=loop['elapsed_ns']/reps,**d));save(rows)
  print('primitive round',trial,'complete',flush=True)
elif phase=='alignment':
 configs=[(so,do) for so in [0,1,8,16,32,48] for do in [0,1,8,16,32,48]]
 for trial in range(3):
  order=configs.copy();random.Random(1981+trial).shuffle(order)
  for so,do in order:
   reps=5000000;d=measure('diagnostics-base',['copy',800,reps,so,do,'main']);loop=json.loads(d['stdout']);rows.append(dict(trial=trial,src_offset=so,dst_offset=do,loop=loop,ns=loop['elapsed_ns']/reps,cycles=d['metrics']['cycles']/reps,**d));save(rows)
elif phase=='rawcopy':
 configs=[(v,n,so,do) for v in ['base','interleave4','interleave8'] for n in [10,100,1000] for so,do in [(0,0),(0,16),(16,0),(16,16),(0,8),(8,0),(8,8),(24,24)]]
 for trial in range(3):
  order=configs.copy();random.Random(3350+trial).shuffle(order)
  for v,n,so,do in order:
   reps=1000000 if n==1000 else 5000000;d=measure('rawcopy-'+v,[n,so,do,reps]);loop=json.loads(d['stdout']);rows.append(dict(trial=trial,variant=v,n=n,src_offset=so,dst_offset=do,reps=reps,loop=loop,ns=loop['elapsed_ns']/reps,cycles=d['metrics']['cycles']/reps,instructions=d['metrics']['instructions']/reps,branches=d['metrics']['branches']/reps,**d));save(rows)
elif phase=='profile':
 event='cycles:u' if arch=='aarch64' else 'cpu_core/cycles/u'
 for variant in ['base','interleave4','interleave8']:
  binary='benches-'+variant;data=r/('profile.'+variant+'.'+arch+'.data');c=['taskset','-c',core,'perf','record','-q','-F','1999','-e',event,'-g','-o',str(data),'--']+child(binary,['--bench','--exact','--test-threads=1','vec::bench_from_iter_0100']);p=subprocess.run(c,env=e,text=True,capture_output=True,check=True);report=['perf','report','--stdio','--no-children','--percent-limit','0.5','-i',str(data)];q=subprocess.run(report,env=e,text=True,capture_output=True,check=True);(r/('profile.'+variant+'.'+arch+'.txt')).write_text(q.stdout+q.stderr);nm=subprocess.check_output(['nm',str(r/target/binary)],env=e,text=True);sym=next(l.split()[-1] for l in nm.splitlines() if 'ns_iter_inner' in l and 'do_bench_from_iter' in l);ann=['perf','annotate','--stdio','--symbol',sym,'-i',str(data)];q=subprocess.run(ann,env=e,text=True,capture_output=True);(r/('annotate.'+variant+'.'+arch+'.txt')).write_text(q.stdout+q.stderr);rows.append(dict(variant=variant,record=c,stdout=p.stdout,stderr=p.stderr,report=report,annotate=ann));save(rows)
else:raise ValueError(phase)
mark('complete')
