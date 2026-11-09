from pathlib import Path
import platform,subprocess,json,time,os,statistics
r=Path(__file__).resolve().parent;arm=platform.machine()=='aarch64';target='aarch64-unknown-linux-gnu' if arm else 'x86_64-unknown-linux-gnu';core='52' if arm else '12'
lib=r/'sysroot/lib/rustlib'/target/'lib';libs=str(lib)+('' if arm else ':/nix/store/604gsr59rj7dzd0nrhp143rpvf7gyiaz-gcc-15.3.0-lib/lib')
env=os.environ.copy();env['LD_LIBRARY_PATH']=libs
for cfg in ['default','core']:
 p=subprocess.run([str(r/target/('driver-'+cfg)),'check'],env=env,capture_output=True,text=True);(r/(cfg+'-check.log')).write_text(p.stdout+p.stderr);assert p.returncode==0,p.stderr;print(cfg,p.stdout,flush=True)
cases=[(n,o,d) for n in [0,1,8,15,16,17,31,32,33,63,64,65,127,128,129,2551,65536] for o in [0,1] for d in (['absent'] if n==0 else ['absent','front','middle','last'])]
(r/'scenarios.json').write_text(json.dumps(cases));rows=[]
for trial in range(5):
 for le,off,dist in cases if trial%2==0 else cases[::-1]:
  n=3000000 if dist=='front' or le<=129 else max(5000,128000000//le)
  for cfg in ['default','core'] if trial%2==0 else ['core','default']:
   for mode in ['std','crate'] if trial%2==0 else ['crate','std']:
    cmd=['taskset','-c',core,'env','-u','LD_LIBRARY_PATH','perf','stat','-x',',','-e','cycles:u,instructions:u,branches:u,branch-misses:u,task-clock,context-switches,cpu-migrations','--','env','LD_LIBRARY_PATH='+libs,'setarch',platform.machine(),'-R',str(r/target/('driver-'+cfg)),mode,str(le),str(off),dist,str(n)]
    p=subprocess.run(cmd,capture_output=True,text=True);assert p.returncode==0,p.stderr
    (r/f'perf-{trial}-{cfg}-{mode}-{le}-{off}-{dist}.log').write_text(p.stdout+p.stderr)
    events={};running=[]
    for line in p.stderr.splitlines():
     f=line.split(',')
     if len(f)<3 or 'cpu_atom' in f[2]:continue
     try:value=float(f[0])
     except ValueError:continue
     k=f[2].replace('cpu_core/','').replace('/u','').replace(':u','').rstrip('/');events[k]=value
     if k in ['cycles','instructions','branches','branch-misses'] and len(f)>4:running.append(float(f[4]))
    assert len(running)==4 and min(running)==100,running
    rows.append(dict(trial=trial,config=cfg,mode=mode,length=le,offset=off,distribution=dist,n=n,cycles=events['cycles']/n,instructions=events['instructions']/n,branches=events['branches']/n,branch_misses=events['branch-misses']/n,ns_cpu=events['task-clock']*1e6/n,events=events,running_percent=running))
    if len(rows)%64==0:(r/'results.json').write_text(json.dumps(rows,indent=2))
 print('trial',trial,'complete',len(rows),flush=True)
(r/'results.json').write_text(json.dumps(rows,indent=2));(r/'complete.json').write_text(json.dumps({'rows':len(rows),'cases':len(cases),'rounds':5,'time':time.time()}))
