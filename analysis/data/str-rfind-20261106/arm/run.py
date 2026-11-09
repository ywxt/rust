from pathlib import Path
import subprocess,os,platform,json,time,re,random,sys,fcntl
r=Path(__file__).resolve().parent;arch=platform.machine();target=arch+'-unknown-linux-gnu';core='52'if arch=='aarch64'else'12';phase=sys.argv[1];e=os.environ.copy();e.pop('LD_LIBRARY_PATH',None);lib='/tmp/contains-bad-simd-20261105/sysroots/baseline/lib/rustlib/'+target+'/lib'+(''if arch=='aarch64'else':/nix/store/604gsr59rj7dzd0nrhp143rpvf7gyiaz-gcc-15.3.0-lib/lib');events=[('cpu_core/'+x+'/u'if arch=='x86_64'else x+':u')for x in ['cycles','instructions','branches','branch-misses']]+['task-clock','context-switches','cpu-migrations','minor-faults','major-faults'];lock=(r/('measurement.'+arch+'.lock')).open('w');fcntl.flock(lock,fcntl.LOCK_EX);rows=[]
def child(binary,args,preload=None):return ['env','LD_LIBRARY_PATH='+lib]+(['LD_PRELOAD='+str(r/target/preload)]if preload else[])+['setarch',arch,'-R',str(r/target/binary)]+list(map(str,args))
def measure(binary,args,preload=None):
 c=['taskset','-c',core,'perf','stat','-x,','-e',','.join(events),'--']+child(binary,args,preload);started=time.time();t=time.monotonic_ns();p=subprocess.run(c,env=e,text=True,capture_output=True,timeout=90);assert p.returncode==0,p.stderr;elapsed=time.monotonic_ns()-t;metrics={};running={}
 for line in p.stderr.splitlines():
  f=line.split(',')
  if len(f)<3:continue
  try:v=float(f[0])
  except ValueError:continue
  k=f[2].replace('cpu_core/','').replace('/u','').replace(':u','');metrics[k]=v
  if k in ['cycles','instructions','branches','branch-misses']:running[k]=float(f[4]);assert running[k]>=99.9,p.stderr
 return dict(command=c,started=started,stdout=p.stdout,stderr=p.stderr,metrics=metrics,running=running,wall_ns=elapsed,cpu_wall_ratio=metrics['task-clock']*1e6/elapsed)
def save(): (r/(phase+'.'+arch+'.json')).write_text(json.dumps(rows,indent=2))
def add(d):
 rows.append(d)
 if len(rows)%20==0:save()
def per(d,n):return {k:d['metrics'][k]/n for k in ['cycles','instructions','branches','branch-misses']}
print(phase,'start',flush=True)
if phase=='bench':
 names=json.loads((r/'provenance.json').read_text())['benchmarks']
 for trial in range(3):
  ns=names.copy();random.Random(1490+trial).shuffle(ns)
  for case in ns:
   d=measure('benches-base',['--bench','--exact','--test-threads=1',case]);m=re.search(r'bench:\s+([\d,.]+) ns/iter',d['stdout']);assert m,d['stdout'];add(dict(trial=trial,mode='libtest',case=case,ns=float(m[1].replace(',','')),**d))
   n=500000 if case.endswith('long_lorem_ipsum')else 5000000;d=measure('counted-base',[case,n]);add(dict(trial=trial,mode='counted',case=case,reps=n,ns=int(d['stdout'].strip())/n,per_call=per(d,n),**d))
  save();print(phase,'round',trial,'complete',flush=True)
elif phase=='cases':
 configs=[(name,method,b)for name in ['short_ascii','short_mixed','short_pile_of_poo','long_lorem_ipsum']for method in ['core','word','crate','v16','libc']for b in [95,164]]
 for trial in range(3):
  cs=configs.copy();random.Random(951+trial).shuffle(cs)
  for name,method,b in cs:
   n=300000 if name=='long_lorem_ipsum'else 5000000;d=measure('probes-base',['case',method,name,b,n]);loop=json.loads(d['stdout']);add(dict(trial=trial,case=name,method=method,needle=b,reps=n,ns=loop['elapsed_ns']/n,loop=loop,per_call=per(d,n),**d))
  save();print(phase,'round',trial,'complete',flush=True)
elif phase in ['matrix','flags']:
 if phase=='matrix':configs=[('base',m,n,a,p)for m in ['core','crate','v16']for n in [0,1,7,8,15,16,17,31,32,63,64,65,2551]for a in [0,1,8,15]for p in ['none','first','middle','last']]
 else:
  vs=['base','nolsr','unroll4']+(['noldst','both']if arch=='aarch64'else[]);configs=[(v,'word',n,a,p)for v in vs for n in [65,2551,16384]for a in [0,1,8,15]for p in ['none','first','last']]
 for trial in range(3):
  cs=configs.copy();random.Random(6671+trial).shuffle(cs)
  for v,m,n,a,p in cs:
   reps=1000000 if n<=65 else(100000 if n<=2551 else 20000);d=measure('probes-'+v,['scan',m,n,a,p,95,reps]);loop=json.loads(d['stdout']);assert loop['ptr_mod64']==a;add(dict(trial=trial,variant=v,method=m,n=n,alignment=a,pattern=p,needle=95,reps=reps,ns=loop['elapsed_ns']/reps,loop=loop,per_call=per(d,reps),**d))
  save();print(phase,'round',trial,'complete',flush=True)
elif phase=='check':
 vs=['base','nolsr','unroll4']+(['noldst','both']if arch=='aarch64'else[])
 for v in vs:
  c=['taskset','-c',core]+child('probes-'+v,['check']);p=subprocess.run(c,env=e,text=True,capture_output=True);(r/('check.'+v+'.'+arch+'.txt')).write_text(p.stdout+p.stderr);assert p.returncode==0,p.stderr;assert'CHECK_OK'in p.stdout;rows.append(dict(variant=v,command=c,stdout=p.stdout,stderr=p.stderr))
elif phase=='shim':
 for v in ['0000','0016']:
  for binary in ['probes-aligned','char-check']:
   c=['taskset','-c',core]+child(binary,['check']if binary=='probes-aligned'else[],preload='shim-'+v+'.so');q=subprocess.run(c,env=e,text=True,capture_output=True);(r/('check.shim-'+v+'.'+binary+'.'+arch+'.txt')).write_text(q.stdout+q.stderr);assert q.returncode==0 and 'CHECK_OK'in q.stdout,q.stdout+q.stderr
 names=[n for n in json.loads((r/'provenance.json').read_text())['benchmarks']if 'rfind_'in n];configs=[(v,case)for v in ['0000','0016']for case in names]
 for trial in range(3):
  cs=configs.copy();random.Random(5512+trial).shuffle(cs)
  for v,case in cs:
   preload='shim-'+v+'.so';d=measure('benches-base',['--bench','--exact','--test-threads=1',case],preload);m=re.search(r'bench:\s+([\d,.]+) ns/iter',d['stdout']);assert m,d['stdout'];add(dict(trial=trial,variant=v,case=case,mode='libtest',ns=float(m[1].replace(',','')),**d));n=500000 if case.endswith('long_lorem_ipsum')else 5000000;d=measure('counted-base',[case,n],preload);add(dict(trial=trial,variant=v,case=case,mode='counted',reps=n,ns=int(d['stdout'].strip())/n,per_call=per(d,n),**d))
  save();print(phase,'round',trial,'complete',flush=True)
elif phase=='align16':
 c=['taskset','-c',core]+child('probes-aligned',['check']);q=subprocess.run(c,env=e,text=True,capture_output=True);(r/('check.align16.'+arch+'.txt')).write_text(q.stdout+q.stderr);assert q.returncode==0 and 'CHECK_OK'in q.stdout,q.stdout+q.stderr
 configs=[(m,n,a,p)for m in ['core','align16']for n in [0,1,7,8,15,16,17,31,32,63,64,65,2551]for a in [0,1,8,15]for p in ['none','first','middle','last']]
 for trial in range(3):
  cs=configs.copy();random.Random(7101+trial).shuffle(cs)
  for m,n,a,p in cs:
   reps=1000000 if n<=65 else 100000;d=measure('probes-aligned',['scan',m,n,a,p,95,reps]);loop=json.loads(d['stdout']);assert loop['ptr_mod64']==a;add(dict(trial=trial,method=m,n=n,alignment=a,pattern=p,reps=reps,ns=loop['elapsed_ns']/reps,loop=loop,per_call=per(d,reps),**d))
  save();print(phase,'round',trial,'complete',flush=True)
elif phase=='load':
 modes=['ldp','ldr','ldp-chain','ldr-chain']if arch=='aarch64'else['mov','mov-chain'];configs=[(m,a)for m in modes for a in range(0,64,8)]
 for trial in range(3):
  cs=configs.copy();random.Random(4452+trial).shuffle(cs)
  for m,a in cs:
   n=20000000;d=measure('load',[m,a,n]);loop=json.loads(d['stdout']);ops=loop['ops'];add(dict(trial=trial,mode=m,alignment=a,ops=ops,ns=loop['elapsed_ns']/ops,loop=loop,per_call=per(d,ops),**d))
  save();print(phase,'round',trial,'complete',flush=True)
elif phase=='alu':
 for trial in range(5):
  modes=['alu','nop'];random.Random(777+trial).shuffle(modes)
  for mode in modes:
   n=100000000;d=measure('alu',[mode,n]);add(dict(trial=trial,mode=mode,reps=n,ns=int(d['stdout'].strip())/n,per_call=per(d,n),**d))
elif phase=='profile':
 std=next(Path(lib.split(':')[0]).glob('libstd-*.so'));symbols=subprocess.check_output(['nm','-D',str(std)],env=e,text=True);sym=next(l.split()[-1]for l in symbols.splitlines()if 'core5slice6memchr7memrchr'in l);p=subprocess.run(['objdump','-d','--disassemble='+sym,str(std)],env=e,text=True,capture_output=True,check=True);(r/('core-memrchr.'+arch+'.s')).write_text(p.stdout+p.stderr)
 for case in ['str::rfind_zzz_char::long_lorem_ipsum','str::rfind_zzz_char::short_mixed']:
  suffix=case.replace('::','-');data=r/('profile.'+suffix+'.'+arch+'.data');event='cpu_core/cycles/u'if arch=='x86_64'else'cycles:u';c=['taskset','-c',core,'perf','record','-q','-F','1999','-e',event,'-g','-o',str(data),'--']+child('benches-base',['--bench','--exact','--test-threads=1',case]);p=subprocess.run(c,env=e,text=True,capture_output=True,check=True);q=subprocess.run(['perf','report','--stdio','--no-children','--percent-limit','0.5','-i',str(data)],env=e,text=True,capture_output=True,check=True);(r/('profile.'+suffix+'.'+arch+'.txt')).write_text(q.stdout+q.stderr);q=subprocess.run(['perf','annotate','--stdio','--symbol',sym,'-i',str(data)],env=e,text=True,capture_output=True);(r/('annotate.'+suffix+'.'+arch+'.txt')).write_text(q.stdout+q.stderr);rows.append(dict(case=case,command=c,stdout=p.stdout,stderr=p.stderr,symbol=sym))
else:raise ValueError(phase)
save();print(phase,'complete',flush=True)
