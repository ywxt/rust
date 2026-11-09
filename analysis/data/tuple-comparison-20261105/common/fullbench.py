from pathlib import Path
import subprocess,os,platform,json,random,re,time,statistics
p=Path(__file__).resolve().parent;arch=platform.machine();core='52'if arch=='aarch64'else'12';r=Path('/tmp/xdiff/rustc.txt').read_text().strip();ld=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+os.environ.get('LD_LIBRARY_PATH','');e=os.environ.copy();e['LD_LIBRARY_PATH']=ld;flags=json.loads((p/'dependency-flags.json').read_text());cmd=[r,'--test','--edition=2024','-O','-C','codegen-units=1','--emit=link,asm,llvm-ir']+flags+[str(p/'harness.rs'),'-o',str(p/'harness')];subprocess.run(cmd,env=e,check=True);e.pop('LD_LIBRARY_PATH',None);b=next(x.strip()for x in Path('/tmp/xdiff/bins.txt').read_text().splitlines()if '/corebenches-'in x);cs=[('prebuilt',b,'tuple::bench_tuple_comparison')]+[(m,str(p/'harness'),'bench_'+m)for m in ['original','fused','two','pointer','match']];raw=[]
for rnd in range(5):
 cases=cs.copy();random.Random(417+rnd).shuffle(cases)
 for mode,binary,bench in cases:
  c=['perf','stat','-x,','-e','task-clock,context-switches,cpu-migrations','--','taskset','-c',core,'env','LD_LIBRARY_PATH='+ld,binary,'--bench','--exact','--test-threads=1',bench];t=time.monotonic_ns();x=subprocess.run(c,env=e,text=True,capture_output=True,timeout=55);elapsed=time.monotonic_ns()-t;x.check_returncode();m=re.search(r'bench:\s+([\d,.]+) ns/iter',x.stdout);assert m,x.stdout;v={}
  for line in x.stderr.splitlines():
   f=line.split(',')
   if len(f)>2:
    try:v[f[2]]=float(f[0])
    except ValueError:pass
  raw.append({'round':rnd,'mode':mode,'command':c,'stdout':x.stdout,'stderr':x.stderr,'metrics':v,'wall_ns':elapsed,'ns_per_call':float(m[1].replace(',',''))});(p/('fullbench.'+arch+'.json')).write_text(json.dumps({'build':cmd,'raw':raw},indent=2))
print({m:statistics.median(x['ns_per_call']for x in raw if x['mode']==m)for m,_,_ in cs})
