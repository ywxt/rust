from pathlib import Path
import subprocess,os,platform,json,re,statistics
p=Path(__file__).resolve().parent;arch=platform.machine();core='52' if arch=='aarch64' else '12'
r=Path('/tmp/xdiff/rustc.txt').read_text().strip();ld=Path('/tmp/xdiff/libdir.txt').read_text().strip();env=os.environ.copy();env['LD_LIBRARY_PATH']=ld+':'+env.get('LD_LIBRARY_PATH','')
configs=[('harness',[]),('harness-unroll4',['-C','llvm-args=-unroll-count=4']),('harness-unroll8',['-C','llvm-args=-unroll-count=8'])]
for tag,flags in configs:subprocess.run([r,'--test','-O','-C','codegen-units=1',*flags,str(p/'harness.rs'),'-o',str(p/tag)],env=env,check=True)
original=next(x.strip() for x in Path('/tmp/xdiff/bins.txt').read_text().splitlines() if '/corebenches-' in x)
cases=[('prebuilt',original,'iter::bench_filter_chain_ref_count')]+[(tag,str(p/tag),'bench_filter_chain_ref_count') for tag,_ in configs]+[('source',str(p/'harness'),'bench_source_unroll4')]
raw=[]
for rnd in range(3):
 for name,binary,bench in cases:
  cmd=['taskset','-c',core,binary,'--bench',bench,'--exact'];x=subprocess.run(cmd,env=env,capture_output=True,text=True,timeout=60);x.check_returncode()
  m=re.search(r'bench:\s+([\d,\.]+) ns/iter',x.stdout);assert m,x.stdout
  raw.append({'round':rnd,'name':name,'ns_per_call':float(m.group(1).replace(',','')),'stdout':x.stdout,'stderr':x.stderr,'cmd':cmd})
  (p/('fullbench.'+arch+'.json')).write_text(json.dumps(raw,indent=2))
print(json.dumps({name:statistics.median(x['ns_per_call'] for x in raw if x['name']==name) for name,_,_ in cases},indent=2))
