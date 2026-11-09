from pathlib import Path
import subprocess,os,platform,json,random,statistics,hashlib
p=Path(__file__).resolve().parent;arch=platform.machine();core='52'if arch=='aarch64'else'12';ld=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+os.environ.get('LD_LIBRARY_PATH','');e=os.environ.copy();e.pop('LD_LIBRARY_PATH',None)
def event(n):return 'cpu_core/'+n+'/u'if arch=='x86_64'else n+':u'
ev=','.join([event(n)for n in ['cycles','instructions','branches','branch-misses']]+['task-clock','context-switches','cpu-migrations','minor-faults','major-faults']);tag=os.environ.get('TAG','main');rounds=int(os.environ.get('ROUNDS','5'));configs=json.loads(os.environ.get('CONFIGS','null'))or[["probe",m,0,1000000,"all_valid",80]for m in ['original','map','guarded','dynamic','guarded_dynamic','unrolled_dynamic']];raw=[]
for rnd in range(rounds):
 cs=configs.copy();random.Random(518+rnd).shuffle(cs)
 for binary,mode,start,end,kind,reps in cs:
  cmd=['perf','stat','-x,','-e',ev,'--','taskset','-c',core,'env','LD_LIBRARY_PATH='+ld,str(p/binary),mode,str(reps),str(start),str(end),kind];x=subprocess.run(cmd,env=e,capture_output=True,text=True,timeout=55);x.check_returncode();metrics={}
  for line in x.stderr.splitlines():
   f=line.split(',')
   if len(f)<3:continue
   try:value=float(f[0])
   except ValueError:continue
   key=f[2].replace('cpu_core/','').replace('/u','').replace(':u','');metrics[key]=value
  n=1000000 if binary.startswith('ir-') else 2*end if mode.endswith('slice')else(2000000 if mode in ['original','map','guarded','no_blackbox']else 2*max(0,end-start));rec={'round':rnd,'binary':binary,'mode':mode,'start':start,'end':end,'kind':kind,'reps':reps,'input_elements_per_call':n,'command':cmd,'stdout':x.stdout,'stderr':x.stderr,'metrics':metrics,'loop':json.loads(x.stdout)};raw.append(rec);(p/('results.'+tag+'.'+arch+'.json')).write_text(json.dumps(raw,indent=2))
out={}
for binary,mode,start,end,kind,reps in configs:
 rs=[x for x in raw if(x['binary'],x['mode'],x['start'],x['end'],x['kind'],x['reps'])==(binary,mode,start,end,kind,reps)];n=rs[0]['input_elements_per_call'];key=f'{binary}|{mode}|{start}|{end}|{kind}';v={k:statistics.median(x['metrics'][k]/reps for x in rs)for k in rs[0]['metrics']};v['ns_per_call']=statistics.median(x['loop']['elapsed_ns']/reps for x in rs);v['ns_range']=[min(x['loop']['elapsed_ns']/reps for x in rs),max(x['loop']['elapsed_ns']/reps for x in rs)];v['cycles_range']=[min(x['metrics']['cycles']/reps for x in rs),max(x['metrics']['cycles']/reps for x in rs)];v['elements_per_call']=n;v['cycles_per_element']=v['cycles']/n if n else None;out[key]=v
(p/('summary.'+tag+'.'+arch+'.json')).write_text(json.dumps(out,indent=2));print(json.dumps(out,indent=2))
