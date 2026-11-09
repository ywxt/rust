from pathlib import Path
import subprocess,os,platform,json,statistics,re
p=Path(__file__).resolve().parent;arch=platform.machine();core='52'if arch=='aarch64'else'12';r=Path('/tmp/xdiff/rustc.txt').read_text().strip();e=os.environ.copy();e['LD_LIBRARY_PATH']=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+e.get('LD_LIBRARY_PATH','');cmd=[r,'--test','--edition=2024','-O','-C','codegen-units=1','--emit=link,asm,llvm-ir',str(p/'harness.rs'),'-o',str(p/'harness')];subprocess.run(cmd,env=e,check=True);roots=['/tmp','/home/wheel/copy-bench-20261105']if arch=='aarch64'else['/tmp','/dev/shm/kernel-file-copy-20261105'];raw=[]
for rnd in range(3):
 for root in roots:
  for mode in ['original','limited','buffered']:
   e['TMPDIR']=root;c=['taskset','-c',core,str(p/'harness'),'--bench','--exact','--test-threads=1',mode];x=subprocess.run(c,env=e,text=True,capture_output=True,timeout=55);x.check_returncode();m=re.search(r'bench:\s+([\d,.]+) ns/iter',x.stdout);assert m,x.stdout
   raw.append({'round':rnd,'root':root,'mode':mode,'build':cmd,'command':c,'stdout':x.stdout,'stderr':x.stderr,'ns_per_call':float(m[1].replace(',',''))});(p/('fullbench-variants.'+arch+'.json')).write_text(json.dumps(raw,indent=2))
print({root+'|'+mode:statistics.median(x['ns_per_call']for x in raw if x['root']==root and x['mode']==mode)for root in roots for mode in ['original','limited','buffered']})
