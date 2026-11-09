from pathlib import Path
import subprocess,os,platform,json
p=Path(__file__).resolve().parent;arch=platform.machine();r=Path('/tmp/xdiff/rustc.txt').read_text().strip();e=os.environ.copy();e['LD_LIBRARY_PATH']=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+e.get('LD_LIBRARY_PATH','');cases={'u4':['-unroll-count=4'],'u8':['-unroll-count=8'],'nolsr':['-disable-lsr'],'nohoist':['-disable-constant-hoisting'],'nosched':['-enable-misched=false']}
if arch=='aarch64':cases.update(noselect=['-aarch64-select-opt=false'],noifcvt=['-aarch64-enable-early-ifcvt=false'])
out=[]
for name,flags in cases.items():
 cmd=[r,'--edition=2024','-O','-C','codegen-units=1','--emit=link,asm,llvm-ir']+sum([['-C','llvm-args='+v]for v in flags],[])+[str(p/'probe.rs'),'-o',str(p/name)];x=subprocess.run(cmd,env=e,capture_output=True,text=True);x.check_returncode();y=subprocess.run([str(p/name),'check','1'],env=e,capture_output=True,text=True);y.check_returncode();out.append({'name':name,'command':cmd,'checks':y.stdout,'stderr':x.stderr})
(p/('options.'+arch+'.json')).write_text(json.dumps(out,indent=2));print('built',list(cases))
