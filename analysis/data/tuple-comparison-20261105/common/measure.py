from pathlib import Path
import subprocess,os,json,platform,random,statistics
p=Path(__file__).resolve().parent;arch=platform.machine();core='52'if arch=='aarch64'else'12';ld=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+os.environ.get('LD_LIBRARY_PATH','');e=os.environ.copy();e.pop('LD_LIBRARY_PATH',None);ev=[('cpu_core/'+n+'/u'if arch=='x86_64'else n+':u')for n in ['cycles','instructions','branches','branch-misses']]+['task-clock','context-switches','cpu-migrations','minor-faults','major-faults'];tag=os.environ.get('TAG','main');rounds=int(os.environ.get('ROUNDS','5'));configs=json.loads(os.environ.get('CONFIGS','null'))or[['probe',m,10000000]for m in ['original','fused','two','pointer','rng']];raw=[]
for rnd in range(rounds):
 cs=configs.copy();random.Random(907+rnd).shuffle(cs)
 for binary,mode,reps in cs:
  c=['perf','stat','-x,','-e',','.join(ev),'--','taskset','-c',core,'env','LD_LIBRARY_PATH='+ld,str(p/binary),mode,str(reps)];x=subprocess.run(c,env=e,capture_output=True,text=True,timeout=55);x.check_returncode();v={}
  for l in x.stderr.splitlines():
   f=l.split(',')
   if len(f)<3:continue
   try:z=float(f[0])
   except ValueError:continue
   v[f[2].replace('cpu_core/','').replace('/u','').replace(':u','')]=z
  raw.append({'round':rnd,'binary':binary,'mode':mode,'reps':reps,'command':c,'stdout':x.stdout,'stderr':x.stderr,'metrics':v,'loop':json.loads(x.stdout)});(p/('results.'+tag+'.'+arch+'.json')).write_text(json.dumps(raw,indent=2))
out={}
for binary,mode,reps in configs:
 rs=[x for x in raw if(x['binary'],x['mode'],x['reps'])==(binary,mode,reps)];out[binary+'|'+mode]={**{k:statistics.median(x['metrics'][k]/reps for x in rs)for k in rs[0]['metrics']},'ns_per_call':statistics.median(x['loop']['elapsed_ns']/reps for x in rs),'cycles_range':[min(x['metrics']['cycles']/reps for x in rs),max(x['metrics']['cycles']/reps for x in rs)]}
(p/('summary.'+tag+'.'+arch+'.json')).write_text(json.dumps(out,indent=2));print(json.dumps(out,indent=2))
