from pathlib import Path
import subprocess,json,statistics,collections,platform
assert platform.machine()=='x86_64'
r=Path(__file__).parent;rows=[]
for trial in range(9):
 for le,off,dist,needle,n in [(8,1,'front',0,3000000),(256,1,'last',126,1000000)]:
  for off_aslr in ([False,True] if trial%2==0 else [True,False]):
   for v in (['v0','v1'] if trial%2==0 else ['v1','v0']):
    libs=str(r/'sysroots'/v/'lib/rustlib/x86_64-unknown-linux-gnu/lib')+':/nix/store/604gsr59rj7dzd0nrhp143rpvf7gyiaz-gcc-15.3.0-lib/lib'
    cmd=['taskset','-c','12','env','-u','LD_LIBRARY_PATH','perf','stat','-x',',','-e','cycles:u,instructions:u,branches:u,branch-misses:u,task-clock,context-switches,cpu-migrations','--','env','LD_LIBRARY_PATH='+libs]+(['setarch','x86_64','-R'] if off_aslr else [])+[str(r/v/'x86_64-unknown-linux-gnu/matrix'),'main',str(le),str(off),dist,str(needle),str(n),'str']
    p=subprocess.run(cmd,capture_output=True,text=True);assert p.returncode==0,p.stderr
    (r/f'layout-control-{trial}-{le}-{off_aslr}-{v}.log').write_text(p.stdout+p.stderr)
    ev={}
    for line in p.stderr.splitlines():
     f=line.split(',')
     if len(f)<3 or 'cpu_atom' in f[2]:continue
     try:value=float(f[0])
     except ValueError:continue
     key=f[2].replace('cpu_core/','').replace('/u','').replace(':u','').rstrip('/');ev[key]=value
    rows.append({'trial':trial,'length':le,'offset':off,'distribution':dist,'needle':needle,'aslr_disabled':off_aslr,'variant':v,'cycles':ev['cycles']/n,'instructions':ev['instructions']/n,'events':ev,'command':cmd})
(r/'layout-control-results.json').write_text(json.dumps(rows,indent=2));out=[]
for le in [8,256]:
 for off_aslr in [False,True]:
  item={'length':le,'aslr_disabled':off_aslr}
  for v in ['v0','v1']:
   vals=[x['cycles'] for x in rows if x['length']==le and x['aslr_disabled']==off_aslr and x['variant']==v];item[v]=statistics.median(vals);item[v+'_range']=[min(vals),max(vals)]
  item['delta_percent']=(item['v1']/item['v0']-1)*100;out.append(item)
(r/'layout-control-summary.json').write_text(json.dumps(out,indent=2));print(json.dumps(out,indent=2))
