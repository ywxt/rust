from pathlib import Path
import subprocess,os,platform,json,random,statistics,hashlib
p=Path(__file__).resolve().parent
arch=platform.machine();core='52' if arch=='aarch64' else '12'
ld=Path('/tmp/xdiff/libdir.txt').read_text().strip()
prefix='cpu_core/' if arch=='x86_64' else ''
def ev(n):return prefix+n+'/u' if prefix else n+':u'
events=','.join([*[ev(x) for x in ['cycles','instructions','branches','branch-misses']],'task-clock','context-switches','cpu-migrations','minor-faults','major-faults'])
e=os.environ.copy();e.pop('LD_LIBRARY_PATH',None)
reps=int(os.environ.get('REPS','80'));rounds=int(os.environ.get('ROUNDS','5'))
configs=json.loads(os.environ.get('CONFIGS','[["normal","original"],["normal","owned"],["normal","split"],["normal","manual"],["normal","unsigned"],["normal","no_modulus"]]'))
raw=[]
for rnd in range(rounds):
 order=configs.copy();random.Random(781+rnd).shuffle(order)
 for binary,name in order:
  cmd=['perf','stat','-x,','-e',events,'--','taskset','-c',core,'env','LD_LIBRARY_PATH='+ld,str(p/binary),name,str(reps)]
  x=subprocess.run(cmd,capture_output=True,text=True,env=e,timeout=60);x.check_returncode()
  src='repro.ll' if binary.startswith('ir-') else ('source-probe.rs' if binary=='source' or binary.startswith('layout-source-') else 'probe.rs')
  record={'source':src,'source_sha256':hashlib.sha256((p/src).read_bytes()).hexdigest(),'round':rnd,'binary':binary,'case':name,'command':cmd,'stderr':x.stderr,'stdout':x.stdout,'metrics':{}}
  for line in x.stderr.splitlines():
   f=line.split(',')
   if len(f)<3:continue
   try:value=float(f[0])
   except ValueError:continue
   key=f[2].replace('cpu_core/','').replace('/u','').replace(':u','')
   record['metrics'][key]=value
  for n in ['cycles','instructions','branches','branch-misses']:assert n in record['metrics'],record
  raw.append(record)
  (p/('results.'+os.environ.get('TAG','current')+'.'+arch+'.json')).write_text(json.dumps({'arch':arch,'core':core,'rounds':rounds,'reps':reps,'elements_per_call':2000000,'calls_per_process':reps+1,'source_sha256':hashlib.sha256((p/'probe.rs').read_bytes()).hexdigest(),'raw':raw},indent=2))
summary={}
for binary,name in configs:
 r=[x['metrics'] for x in raw if x['binary']==binary and x['case']==name]
 summary[binary+'/'+name]={k:statistics.median(x[k] for x in r)/((reps+1)*2000000) for k in ['cycles','instructions','branches','branch-misses']}
 summary[binary+'/'+name]['cycles_range']=[min(x['cycles'] for x in r)/((reps+1)*2000000),max(x['cycles'] for x in r)/((reps+1)*2000000)]
(p/('summary.'+os.environ.get('TAG','current')+'.'+arch+'.json')).write_text(json.dumps(summary,indent=2));print(json.dumps(summary,indent=2))
