from pathlib import Path
import subprocess,os,json,platform,random,statistics
p=Path(__file__).resolve().parent;arch=platform.machine();core='52'if arch=='aarch64'else'12';ld=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+os.environ.get('LD_LIBRARY_PATH','');e=os.environ.copy();e.pop('LD_LIBRARY_PATH',None)
ev=[('cpu_core/'+n+'/u'if arch=='x86_64'else n+':u')for n in ['cycles','instructions','branches','branch-misses']]+['task-clock','context-switches','cpu-migrations','minor-faults','major-faults'];tag=os.environ.get('TAG','main');rounds=int(os.environ.get('ROUNDS','5'));configs=json.loads(os.environ.get('CONFIGS','null'))or[['probe',m,30,0,0,500000]for m in ['original','chunk','vec','scalar','chunk4','chunk8','reg','even']];raw=[]
for rnd in range(rounds):
 cs=configs.copy();random.Random(1025+rnd).shuffle(cs)
 for binary,mode,n,ax,ay,reps in cs:
  c=['perf','stat','-x,','-e',','.join(ev),'--','taskset','-c',core,'env','LD_LIBRARY_PATH='+ld,str(p/binary),mode,str(reps),str(n),str(ax),str(ay)];x=subprocess.run(c,env=e,capture_output=True,text=True,timeout=55);x.check_returncode();metrics={}
  for l in x.stderr.splitlines():
   f=l.split(',')
   if len(f)<3:continue
   try:v=float(f[0])
   except ValueError:continue
   metrics[f[2].replace('cpu_core/','').replace('/u','').replace(':u','')]=v
  raw.append({'round':rnd,'binary':binary,'mode':mode,'n':n,'ax':ax,'ay':ay,'reps':reps,'swaps_per_call':1 if mode.startswith('leaf')else 32,'command':c,'stderr':x.stderr,'stdout':x.stdout,'metrics':metrics,'loop':json.loads(x.stdout)});(p/('results.'+tag+'.'+arch+'.json')).write_text(json.dumps(raw,indent=2))
out={}
for binary,mode,n,ax,ay,reps in configs:
 rs=[x for x in raw if(x['binary'],x['mode'],x['n'],x['ax'],x['ay'],x['reps'])==(binary,mode,n,ax,ay,reps)];denom=reps*rs[0]['swaps_per_call'];v={k:statistics.median(x['metrics'][k]/denom for x in rs)for k in rs[0]['metrics']};v['ns_per_swap']=statistics.median(x['loop']['elapsed_ns']/denom for x in rs);v['cycles_range']=[min(x['metrics']['cycles']/denom for x in rs),max(x['metrics']['cycles']/denom for x in rs)];v['address_pairs']=[[x['loop']['x_mod64'],x['loop']['y_mod64']]for x in rs];out[f'{binary}|{mode}|{n}|{ax}|{ay}']=v
(p/('summary.'+tag+'.'+arch+'.json')).write_text(json.dumps(out,indent=2));print(json.dumps(out,indent=2))
