from pathlib import Path
import subprocess,os,platform,json,re,statistics
p=Path(__file__).resolve().parent;arch=platform.machine();core='52' if arch=='aarch64' else '12';r=Path('/tmp/xdiff/rustc.txt').read_text().strip();ld=Path('/tmp/xdiff/libdir.txt').read_text().strip();e=os.environ.copy();e['LD_LIBRARY_PATH']=ld+':'+e.get('LD_LIBRARY_PATH','')
subprocess.run([r,'--test','--edition=2024','-O','-C','codegen-units=1',str(p/'harness.rs'),'-o',str(p/'harness')],env=e,check=True)
original=next(x.strip() for x in Path('/tmp/xdiff/bins.txt').read_text().splitlines() if '/corebenches-' in x)
cases=[('prebuilt',original,'str::debug::some_unicode'),('original',str(p/'harness'),'some_unicode'),('copy',str(p/'harness'),'some_unicode_copy'),('fast',str(p/'harness'),'some_unicode_fast')];raw=[]
for rnd in range(3):
 for tag,binary,bench in cases:
  cmd=['taskset','-c',core,binary,'--bench','--exact','--test-threads=1',bench];x=subprocess.run(cmd,env=e,capture_output=True,text=True,timeout=60);x.check_returncode()
  m=re.search(r'bench:\s+([\d,\.]+) ns/iter',x.stdout);assert m,x.stdout
  raw.append({'round':rnd,'name':tag,'ns_per_call':float(m.group(1).replace(',','')),'stdout':x.stdout,'stderr':x.stderr,'command':cmd});(p/('fullbench.'+arch+'.json')).write_text(json.dumps(raw,indent=2))
print(json.dumps({name:statistics.median(v['ns_per_call'] for v in raw if v['name']==name) for name,_,_ in cases},indent=2))
