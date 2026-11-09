from pathlib import Path
import subprocess,os,platform,json,re,random,statistics
p=Path(__file__).resolve().parent;arch=platform.machine();core='52'if arch=='aarch64'else'12';r=Path('/tmp/xdiff/rustc.txt').read_text().strip();e=os.environ.copy();e['LD_LIBRARY_PATH']=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+e.get('LD_LIBRARY_PATH','');build=[]
for tag,extra in [('base',[]),('u4',['-C','llvm-args=-unroll-count=4'])]:
 cmd=[r,'--test','--edition=2024','-O','-C','codegen-units=1','--emit=link,asm,llvm-ir']+extra+[str(p/'harness.rs'),'-o',str(p/('harness-'+tag))];subprocess.run(cmd,env=e,check=True);build.append(cmd)
b=next(x.strip()for x in Path('/tmp/xdiff/bins.txt').read_text().splitlines()if '/corebenches-'in x);names=['bench_filter_map_sum','bench_filter_map_ref_sum','bench_filter_map_chain_sum','bench_filter_map_chain_ref_sum'];cases=[]
for n in names:cases += [('prebuilt',b,'iter::'+n,n),('original',str(p/'harness-base'),'original_'+n,n),('guarded',str(p/'harness-base'),'guarded_'+n,n),('u4',str(p/'harness-u4'),'original_'+n,n)]
raw=[]
for rnd in range(3):
 cs=cases.copy();random.Random(639+rnd).shuffle(cs)
 for tag,binary,bench,n in cs:
  cmd=['taskset','-c',core,binary,'--bench','--exact','--test-threads=1',bench];x=subprocess.run(cmd,env=e,capture_output=True,text=True,timeout=55);x.check_returncode();m=re.search(r'bench:\s+([\d,.]+) ns/iter',x.stdout);assert m,x.stdout;raw.append({'round':rnd,'method':tag,'name':n,'command':cmd,'stdout':x.stdout,'stderr':x.stderr,'ns_per_call':float(m[1].replace(',',''))});(p/('fullbench.'+arch+'.json')).write_text(json.dumps({'build':build,'raw':raw},indent=2))
print({n+'|'+tag:statistics.median(x['ns_per_call']for x in raw if x['method']==tag and x['name']==n)for n in names for tag in ['prebuilt','original','guarded','u4']})
