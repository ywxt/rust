from pathlib import Path
import os,subprocess,json,platform,statistics,random
p=Path(__file__).resolve().parent;arch=platform.machine();core='52'if arch=='aarch64'else'12';r=Path('/tmp/xdiff/rustc.txt').read_text().strip();e=os.environ.copy();ld=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+e.get('LD_LIBRARY_PATH','');e['LD_LIBRARY_PATH']=ld;cs={'distance':[]}
if arch=='aarch64':cs['distance_noldst']=['-aarch64-enable-ldst-opt=false']
commands=[]
for name,flags in cs.items():
 c=[r,'--edition=2024','-O','-C','codegen-units=1','--emit=link,asm,llvm-ir']+sum([['-C','llvm-args='+v]for v in flags],[])+[str(p/'distance-probe.rs'),'-o',str(p/name)];subprocess.run(c,env=e,check=True);commands.append(c)
(p/('distance-build.'+arch+'.json')).write_text(json.dumps(commands,indent=2));ev=[('cpu_core/'+n+'/u'if arch=='x86_64'else n+':u')for n in ['cycles','instructions','branches','branch-misses']]+['task-clock','context-switches','cpu-migrations','minor-faults','major-faults'];e.pop('LD_LIBRARY_PATH',None);raw=[];configs=[(b,m,gap,ax,ay)for b in cs for m in ['original','vec']for gap in [256,320,384,448,512,1024,2048,4096]for ax,ay in [(0,0),(0,2),(1,0)]];reps=150000
for rnd in range(3):
 cases=configs.copy();random.Random(333+rnd).shuffle(cases)
 for b,m,gap,ax,ay in cases:
  c=['perf','stat','-x,','-e',','.join(ev),'--','taskset','-c',core,'env','LD_LIBRARY_PATH='+ld,str(p/b),m,str(reps),'30',str(ax),str(ay),str(gap)];x=subprocess.run(c,env=e,capture_output=True,text=True,check=True,timeout=55);metrics={}
  for l in x.stderr.splitlines():
   f=l.split(',')
   if len(f)<3:continue
   try:v=float(f[0])
   except ValueError:continue
   metrics[f[2].replace('cpu_core/','').replace('/u','').replace(':u','')]=v
  raw.append({'round':rnd,'binary':b,'mode':m,'gap':gap,'ax':ax,'ay':ay,'reps':reps,'command':c,'stdout':x.stdout,'stderr':x.stderr,'loop':json.loads(x.stdout),'metrics':metrics});(p/('results.distance.'+arch+'.json')).write_text(json.dumps(raw,indent=2))
out={}
for b,m,gap,ax,ay in configs:
 rs=[x for x in raw if(x['binary'],x['mode'],x['gap'],x['ax'],x['ay'])==(b,m,gap,ax,ay)];out[f'{b}|{m}|{gap}|{ax}|{ay}']={**{k:statistics.median(x['metrics'][k]/reps/32 for x in rs)for k in rs[0]['metrics']},'ns_per_swap':statistics.median(x['loop']['elapsed_ns']/reps/32 for x in rs),'addresses':rs[0]['loop']}
(p/('summary.distance.'+arch+'.json')).write_text(json.dumps(out,indent=2));print('distance matrix done')
