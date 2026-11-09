from pathlib import Path
import platform,subprocess,os,json,re,random
r=Path(__file__).resolve().parent;arch=platform.machine();target=arch+'-unknown-linux-gnu';core='52'if arch=='aarch64'else'12';libs=str(r/'sysroots/candidate/lib/rustlib'/target/'lib')+(''if arch=='aarch64'else':/nix/store/604gsr59rj7dzd0nrhp143rpvf7gyiaz-gcc-15.3.0-lib/lib');e=os.environ.copy();e.pop('LD_LIBRARY_PATH',None);ev=[('cpu_core/'+x+'/u'if arch=='x86_64'else x+':u')for x in ['cycles','instructions']]+['task-clock','context-switches','cpu-migrations'];out=[]
configs=[('stack',str(off),mode)for off in range(0,64,8)for mode in ['pair','split']]
for rnd in range(5):
 cs=configs.copy();random.Random(9970+rnd).shuffle(cs)
 for kind,off,mode in cs:
  if kind=='stack':binary=r/'diagnostics'/target/'stack-probe';args=[off,mode,'10000000']
  else:binary=r/'candidate'/target/'benches'if mode=='default'else r/'diagnostics'/target/('benches-'+mode);args=['--bench','--exact','--test-threads=1','str::bench_contains_bad_simd']
  c=['taskset','-c',core,'perf','stat','-x,','-e',','.join(ev),'--','env','LD_LIBRARY_PATH='+libs,'setarch',arch,'-R',str(binary)]+args;p=subprocess.run(c,env=e,text=True,capture_output=True,check=True,timeout=90);metrics={}
  for l in p.stderr.splitlines():
   f=l.split(',')
   if len(f)<3:continue
   try:v=float(f[0])
   except ValueError:continue
   k=f[2].replace('cpu_core/','').replace('/u','').replace(':u','');metrics[k]=v
  row=dict(round=rnd,kind=kind,offset=off,mode=mode,command=c,stdout=p.stdout,stderr=p.stderr,metrics=metrics)
  if kind=='bench':row['ns']=float(re.search(r'bench:\s+([\d,.]+) ns/iter',p.stdout)[1].replace(',',''))
  else:row['cycles_per_iteration']=metrics['cycles']/10000000
  out.append(row);(r/('stackscan.'+arch+'.json')).write_text(json.dumps(out,indent=2))
print('diagnostics complete',arch,flush=True)
