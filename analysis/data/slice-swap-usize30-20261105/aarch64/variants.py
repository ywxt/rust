from pathlib import Path
import subprocess,os,json,platform
p=Path(__file__).resolve().parent;arch=platform.machine();r=Path('/tmp/xdiff/rustc.txt').read_text().strip();e=os.environ.copy();e['LD_LIBRARY_PATH']=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+e.get('LD_LIBRARY_PATH','');cs={'interleave1':['-force-vector-interleave=1'],'interleave4':['-force-vector-interleave=4'],'u4':['-unroll-count=4'],'nosched':['-enable-misched=false']}
if arch=='aarch64':cs.update(noldst=['-aarch64-enable-ldst-opt=false'])
out=[]
for name,flags in cs.items():
 c=[r,'--edition=2024','-O','-C','codegen-units=1','--emit=link,asm,llvm-ir']+sum([['-C','llvm-args='+v]for v in flags],[])+[str(p/'probe.rs'),'-o',str(p/name)];x=subprocess.run(c,env=e,capture_output=True,text=True,check=True);y=subprocess.run([str(p/name),'check','1'],env=e,capture_output=True,text=True,check=True);out.append({'name':name,'command':c,'check':y.stdout,'stderr':x.stderr})
(p/('options.'+arch+'.json')).write_text(json.dumps(out,indent=2));print('built',list(cs))
