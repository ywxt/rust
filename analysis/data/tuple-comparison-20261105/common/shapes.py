from pathlib import Path
import subprocess,os,json,platform,re,time,statistics,random
p=Path(__file__).resolve().parent;arch=platform.machine();core='52'if arch=='aarch64'else'12';r=Path('/tmp/xdiff/rustc.txt').read_text().strip();ld=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+os.environ.get('LD_LIBRARY_PATH','');e=os.environ.copy();e['LD_LIBRARY_PATH']=ld;deps=json.loads((p/'dependency-flags.json').read_text());build=[]
for cgu in [1,16]:
 c=[r,'--test','--edition=2024','-O','-C','codegen-units='+str(cgu),'--emit=link']+deps+[str(p/'harness-exact.rs'),'-o',str(p/('harness-exact'+str(cgu)))];subprocess.run(c,env=e,check=True);build.append(c)
e.pop('LD_LIBRARY_PATH',None);cases=[(str(cgu),mode)for cgu in [1,16]for mode in ['original','two','match']];raw=[]
for rnd in range(3):
 cs=cases.copy();random.Random(773+rnd).shuffle(cs)
 for cgu,mode in cs:
  c=['perf','stat','-x,','-e','task-clock,context-switches,cpu-migrations','--','taskset','-c',core,'env','LD_LIBRARY_PATH='+ld,str(p/('harness-exact'+cgu)),'--bench','--exact','--test-threads=1','bench_'+mode];t=time.monotonic_ns();x=subprocess.run(c,env=e,capture_output=True,text=True,check=True,timeout=55);elapsed=time.monotonic_ns()-t;m=re.search(r'bench:\s+([\d,.]+) ns/iter',x.stdout);assert m,x.stdout;raw.append({'round':rnd,'cgu':cgu,'mode':mode,'command':c,'stdout':x.stdout,'stderr':x.stderr,'wall_ns':elapsed,'ns_per_call':float(m[1].replace(',',''))});(p/('shapes.'+arch+'.json')).write_text(json.dumps({'build':build,'raw':raw},indent=2))
print({cgu+'|'+mode:statistics.median(x['ns_per_call']for x in raw if x['cgu']==cgu and x['mode']==mode)for cgu,mode in cases})
