from pathlib import Path
import subprocess,os,json,platform,random,re,statistics
p=Path(__file__).resolve().parent;arch=platform.machine();core='52'if arch=='aarch64'else'12';r=Path('/tmp/xdiff/rustc.txt').read_text().strip();e=os.environ.copy();e['LD_LIBRARY_PATH']=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+e.get('LD_LIBRARY_PATH','');c=[r,'--test','--edition=2024','-O','-C','codegen-units=1','--emit=link,asm,llvm-ir',str(p/'harness.rs'),'-o',str(p/'harness')];subprocess.run(c,env=e,check=True);b=next(x.strip()for x in Path('/tmp/xdiff/bins.txt').read_text().splitlines()if '/corebenches-'in x);cs=[]
for ty in ['u8','rgb','usize','4x_usize','5x_usize']:
 for n in [30,3000]:
  name=f'swap_with_slice_{ty}_{n}';cs.append(('prebuilt',b,'slice::'+name,name))
  for method in ['original','chunk4','chunk8']+(['vec']if ty=='usize'else[]):cs.append((method,str(p/'harness'),method+'_'+name,name))
raw=[]
for rnd in range(3):
 cases=cs.copy();random.Random(551+rnd).shuffle(cases)
 for method,binary,bench,name in cases:
  c=['taskset','-c',core,binary,'--bench','--exact','--test-threads=1',bench];x=subprocess.run(c,env=e,capture_output=True,text=True,timeout=55);x.check_returncode();m=re.search(r'bench:\s+([\d,.]+) ns/iter',x.stdout);assert m,x.stdout;raw.append({'round':rnd,'method':method,'name':name,'command':c,'stdout':x.stdout,'stderr':x.stderr,'ns_per_call':float(m[1].replace(',',''))});(p/('fullbench.'+arch+'.json')).write_text(json.dumps(raw,indent=2))
print({name+'|'+method:statistics.median(x['ns_per_call']for x in raw if x['method']==method and x['name']==name)for method,_,_,name in cs})
