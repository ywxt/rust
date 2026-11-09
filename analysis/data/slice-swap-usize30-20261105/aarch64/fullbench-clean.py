from pathlib import Path
import subprocess,os,json,platform,random,re,time,statistics
p=Path(__file__).resolve().parent;arch=platform.machine();core='52'if arch=='aarch64'else'12';r=Path('/tmp/xdiff/rustc.txt').read_text().strip();ld=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+os.environ.get('LD_LIBRARY_PATH','');e=os.environ.copy();e.pop('LD_LIBRARY_PATH',None);cs=[];build=[]
if arch=='aarch64':
 eb=e.copy();eb['LD_LIBRARY_PATH']=ld;c=[r,'--test','--edition=2024','-O','-C','codegen-units=1','-C','llvm-args=-aarch64-enable-ldst-opt=false','--emit=link,asm,llvm-ir',str(p/'harness.rs'),'-o',str(p/'harness-noldst')];subprocess.run(c,env=eb,check=True);build.append(c)
b=next(x.strip()for x in Path('/tmp/xdiff/bins.txt').read_text().splitlines()if '/corebenches-'in x)
for n in [30,3000]:
 name='swap_with_slice_usize_'+str(n);cs.append(('prebuilt',b,'slice::'+name,name))
 for m in ['original','vec','chunk4','chunk8']:cs.append((m,str(p/'harness'),m+'_'+name,name))
 if arch=='aarch64':cs.append(('noldst',str(p/'harness-noldst'),'original_'+name,name))
raw=[]
for rnd in range(3):
 cases=cs.copy();random.Random(112+rnd).shuffle(cases)
 for method,binary,bench,name in cases:
  c=['perf','stat','-x,','-e','task-clock,context-switches,cpu-migrations','--','taskset','-c',core,'env','LD_LIBRARY_PATH='+ld,binary,'--bench','--exact','--test-threads=1',bench];start=time.monotonic_ns();x=subprocess.run(c,env=e,capture_output=True,text=True,timeout=55);elapsed=time.monotonic_ns()-start;x.check_returncode();m=re.search(r'bench:\s+([\d,.]+) ns/iter',x.stdout);assert m,x.stdout;v={}
  for l in x.stderr.splitlines():
   f=l.split(',')
   if len(f)<3:continue
   try:v[f[2]]=float(f[0])
   except ValueError:pass
  raw.append({'round':rnd,'method':method,'name':name,'command':c,'stdout':x.stdout,'stderr':x.stderr,'process_wall_ns':elapsed,'metrics':v,'cpu_wall_ratio':v.get('task-clock',0)*1e6/elapsed,'ns_per_call':float(m[1].replace(',',''))});(p/('fullbench-clean.'+arch+'.json')).write_text(json.dumps({'build':build,'raw':raw},indent=2))
print({name+'|'+method:statistics.median(x['ns_per_call']for x in raw if x['method']==method and x['name']==name)for method,_,_,name in cs})
