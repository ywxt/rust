from pathlib import Path
import subprocess,os,platform,json,re,time,statistics,random,sys,hashlib
r=Path(__file__).resolve().parent;arch=platform.machine();target=arch+'-unknown-linux-gnu';core='52'if arch=='aarch64'else'12';phase=sys.argv[1];variants=[('v0','baseline'),('v1','candidate'),('v2','mask'),('v3','combined')];e=os.environ.copy();e.pop('LD_LIBRARY_PATH',None);journal=r/('full-journal.'+arch+'.json');j=json.loads(journal.read_text())if journal.exists()else[]
def mark(state):
 j.append(dict(phase=phase,state=state,time=time.time()));journal.write_text(json.dumps(j,indent=2));print(phase,state,flush=True)
def libs(v):return str(r/'sysroots'/v/'lib/rustlib'/target/'lib')+(''if arch=='aarch64'else':/nix/store/604gsr59rj7dzd0nrhp143rpvf7gyiaz-gcc-15.3.0-lib/lib')
for alias,v in variants:
 for base in [r,r/'sysroots']:
  p=base/alias
  if not p.exists():p.symlink_to(v,target_is_directory=True)
  assert p.resolve()==(base/v).resolve()
no_aslr=subprocess.run(['setarch',arch,'-R','true'],env=e,capture_output=True).returncode==0
wrap=['setarch',arch,'-R']if no_aslr else[]
def cmd(v,name,args):return ['taskset','-c',core,'env','LD_LIBRARY_PATH='+libs(v)]+wrap+[str(r/v/target/name)]+args
mark('start')
if phase=='check':
 for v in [v for _,v in variants]:
  manifest=json.loads((r/(v+'-sysroot-manifest.json')).read_text())[target];lib=r/'sysroots'/v/'lib/rustlib'/target/'lib'
  for f in lib.glob('*.so'):assert hashlib.sha256(f.read_bytes()).hexdigest()==manifest[f.name],f
  c=cmd(v,'scenarios',['check']);p=subprocess.run(c,env=e,text=True,capture_output=True,check=True);(r/('full-check.'+v+'.'+arch+'.log')).write_text(p.stdout+p.stderr);print(v,p.stdout,flush=True)
elif phase=='matrix':
 for alias,v in variants:
  c=cmd(alias,'scenarios',['matrix']);p=subprocess.run(c,env=e,text=True,capture_output=True,check=True,timeout=300);d=json.loads(p.stdout);assert len(d['samples'])==d['cases']*3;(r/('full-matrix.'+v+'.'+arch+'.json')).write_text(json.dumps(dict(command=c,no_aslr=no_aslr,stderr=p.stderr,**d),indent=2));print(v,'matrix cases',d['cases'],flush=True)
elif phase in ['benches','counted']:
 names=["str::"+x for x in re.findall(r'pub fn (\w+)\(b: &mut Bencher\)',(r/'counted.rs').read_text())];assert len(names)==28;rows=[];events=[('cpu_core/'+k+'/u'if arch=='x86_64'else k+':u')for k in ['cycles','instructions','branches','branch-misses']]+['task-clock','context-switches','cpu-migrations','minor-faults','major-faults']
 for trial in range(3):
  order=names.copy();random.Random(6601+trial).shuffle(order)
  for name in order:
   for alias,v in (variants if trial%2==0 else variants[::-1]):
    n=5000000 if any(t in name for t in ['long','bad_simd','extra_ascii','unicode_char_miss','unicode_str_miss','extra_nul']) else 10000000
    c=['taskset','-c',core,'perf','stat','-x,','-e',','.join(events),'--']+cmd(alias,'benches'if phase=='benches'else'counted',['--bench','--exact','--test-threads=1',name]if phase=='benches'else[name,str(n)]);start=time.monotonic_ns();p=subprocess.run(c,env=e,text=True,capture_output=True,check=True,timeout=90);elapsed=time.monotonic_ns()-start;metrics={};percent={}
    for line in p.stderr.splitlines():
     f=line.split(',')
     if len(f)<3:continue
     try:vnum=float(f[0])
     except ValueError:continue
     k=f[2].replace('cpu_core/','').replace('/u','').replace(':u','');metrics[k]=vnum
     if k in ['cycles','instructions','branches','branch-misses']:percent[k]=float(f[4]);assert percent[k]>=99.9, p.stderr
    row=dict(trial=trial,variant=v,case=name,command=c,stdout=p.stdout,stderr=p.stderr,metrics=metrics,running_percent=percent,wall_ns=elapsed,no_aslr=no_aslr,cpu_wall_ratio=metrics['task-clock']*1e6/elapsed)
    if phase=='benches':
     m=re.search(r'bench:\s+([\d,.]+) ns/iter',p.stdout);assert m,p.stdout;row['ns']=float(m[1].replace(',',''))
    else:
     row['n']=n;row['per_call']={k:metrics[k]/n for k in ['cycles','instructions','branches','branch-misses']}
    rows.append(row);(r/('full-'+phase+'.'+arch+'.json')).write_text(json.dumps(rows,indent=2))
  print(phase,'round',trial,'complete',flush=True)
elif phase=='profile':
 event='cycles:u'if arch=='aarch64'else'cpu_core/cycles/u'
 for v in [v for _,v in variants]:
  data=r/('full-profile.'+v+'.'+arch+'.data');c=['perf','record','-q','-F','997','-e',event,'-g','-o',str(data),'--']+cmd(v,'counted',['str::bench_contains_bad_simd','10000000']);p=subprocess.run(c,env=e,text=True,capture_output=True,check=True);report=['perf','report','--stdio','--no-children','--percent-limit','0.5','-i',str(data)];x=subprocess.run(report,env=e,text=True,capture_output=True,check=True);(r/('full-profile.'+v+'.'+arch+'.txt')).write_text(x.stdout+x.stderr);binary=r/v/target/'counted';nm=subprocess.check_output(['nm',str(binary)],env=e,text=True);sym=next(l.split()[-1]for l in nm.splitlines()if '15is_contained_in'in l);ann=['perf','annotate','--stdio','--symbol',sym,'-i',str(data)];x=subprocess.run(ann,env=e,text=True,capture_output=True);(r/('full-annotate.'+v+'.'+arch+'.txt')).write_text(x.stdout+x.stderr);(r/('full-profile.'+v+'.'+arch+'.json')).write_text(json.dumps(dict(record=c,stdout=p.stdout,stderr=p.stderr,report=report,annotate=ann),indent=2))
else:raise ValueError(phase)
mark('complete')
