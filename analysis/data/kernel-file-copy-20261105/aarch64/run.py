from pathlib import Path
import subprocess,os,json,platform,random,statistics
p=Path(__file__).resolve().parent;arch=platform.machine();core='52' if arch=='aarch64' else '12';ld=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+os.environ.get('LD_LIBRARY_PATH','');e=os.environ.copy();e.pop('LD_LIBRARY_PATH',None)
roots=['/tmp','/home/wheel/copy-bench-20261105'] if arch=='aarch64' else ['/tmp','/dev/shm/kernel-file-copy-20261105'];main=['cycles','instructions','branches','branch-misses'];scope=['cycles:u','cycles:k','instructions:u','instructions:k'];mode=os.environ.get('TAG','main');rounds=int(os.environ.get('ROUNDS','5'));reps=int(os.environ.get('REPS','20000'))
events=main if mode!='scope' else scope
if arch=='x86_64':events=['cpu_core/'+x.split(':')[0]+'/'+(x.split(':')[1] if ':' in x else '') for x in events]
events+=['task-clock','context-switches','cpu-migrations','minor-faults','major-faults']
configs=json.loads(os.environ.get('CONFIGS','null')) or [(root,m,131072)for root in roots for m in ['std','take','cfr','cfr_limited','rw8','rw128','seeks','metadata']]
raw=[]
for rnd in range(rounds):
 cs=configs.copy();random.Random(901+rnd).shuffle(cs)
 for root,m,n in cs:
  cmd=['perf','stat','-x,','-e',','.join(events),'--','taskset','-c',core,'env','LD_LIBRARY_PATH='+ld,str(p/'probe'),m,str(n),str(reps),root]
  x=subprocess.run(cmd,env=e,text=True,capture_output=True,timeout=45);metrics={}
  for l in x.stderr.splitlines():
   f=l.split(',')
   if len(f)>3:
    try:metrics[f[2]]=float(f[0])
    except ValueError:pass
  rec={'round':rnd,'root':root,'mode':m,'size':n,'reps':reps,'command':cmd,'stdout':x.stdout,'stderr':x.stderr,'exit_code':x.returncode,'metrics':metrics}
  if x.returncode==0:rec['loop']=json.loads(x.stdout)
  raw.append(rec);(p/('results.'+mode+'.'+arch+'.json')).write_text(json.dumps(raw,indent=2))
  if x.returncode:raise RuntimeError(x.stderr)
out={}
for root,m,n in configs:
 rs=[x for x in raw if(x['root'],x['mode'],x['size'])==(root,m,n)];v={k:statistics.median(x['metrics'][k]/reps for x in rs)for k in rs[0]['metrics']};v['ns_per_call']=statistics.median(x['loop']['ns_per_call']for x in rs);v['ns_range']=[min(x['loop']['ns_per_call']for x in rs),max(x['loop']['ns_per_call']for x in rs)];out[root+'|'+m+'|'+str(n)]=v
(p/('summary.'+mode+'.'+arch+'.json')).write_text(json.dumps(out,indent=2));print(json.dumps(out,indent=2))
