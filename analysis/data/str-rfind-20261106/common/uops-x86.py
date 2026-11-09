from pathlib import Path
import subprocess,os,json,time,fcntl,random
r=Path(__file__).resolve().parent;assert os.uname().machine=='x86_64';lock=(r/'measurement.x86_64.lock').open('w');fcntl.flock(lock,fcntl.LOCK_EX);e=os.environ.copy();e.pop('LD_LIBRARY_PATH',None);e.pop('LD_PRELOAD',None);lib='/tmp/contains-bad-simd-20261105/sysroots/baseline/lib/rustlib/x86_64-unknown-linux-gnu/lib:/nix/store/604gsr59rj7dzd0nrhp143rpvf7gyiaz-gcc-15.3.0-lib/lib';ev=['cycles','instructions','uops_retired.slots','uops_executed.thread'];rows=[]
for trial in range(3):
 configs=[(method,n,a)for method in ['core','word']for n in [64,16384]for a in [0,8]];random.Random(961+trial).shuffle(configs)
 for method,n,a in configs:
  reps=1000000;c=['taskset','-c','12','perf','stat','-x,','-e',','.join('cpu_core/'+v+'/u'for v in ev)+',task-clock','--','env','LD_LIBRARY_PATH='+lib,'setarch','x86_64','-R',str(r/'x86_64-unknown-linux-gnu/probes-base'),'scan',method,str(n),str(a),'none','95',str(reps)];p=subprocess.run(c,env=e,text=True,capture_output=True,check=True);metrics={};running={}
  for line in p.stderr.splitlines():
   f=line.split(',')
   if len(f)<3:continue
   try:v=float(f[0])
   except ValueError:continue
   key=f[2].replace('cpu_core/','').replace('/u','');metrics[key]=v
   if key in ev:running[key]=float(f[4]);assert running[key]>=99.9,p.stderr
  rows.append(dict(trial=trial,method=method,n=n,alignment=a,reps=reps,per_call={k:metrics[k]/reps for k in ev},command=c,stdout=p.stdout,stderr=p.stderr,running=running,metrics=metrics));(r/'uops.x86_64.json').write_text(json.dumps(rows,indent=2))
 print('uops round',trial,'complete',flush=True)
