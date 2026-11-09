from pathlib import Path
import subprocess,os,platform,hashlib,json
p=Path(__file__).resolve().parent;r=Path('/tmp/xdiff/rustc.txt').read_text().strip();e=os.environ.copy();e['LD_LIBRARY_PATH']=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+e.get('LD_LIBRARY_PATH','')
cmd=[r,'--edition=2024','-O','-C','codegen-units=1','-C','debuginfo=1','--emit=link,asm,llvm-ir',str(p/'candidate.rs'),'-o',str(p/'candidate')]
x=subprocess.run(cmd,env=e,capture_output=True,text=True);print(x.stderr);x.check_returncode()
subprocess.run([str(p/'candidate'),'check','1'],env=e,check=True)
(p/('candidate-build.'+platform.machine()+'.json')).write_text(json.dumps({'arch':platform.machine(),'command':cmd,'compiler':subprocess.check_output([r,'-vV'],env=e,text=True),'source_sha256':hashlib.sha256((p/'candidate.rs').read_bytes()).hexdigest()},indent=2));print('ready',platform.machine())
