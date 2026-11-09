from pathlib import Path
import subprocess,os,platform,json,hashlib
p=Path(__file__).resolve().parent;r=Path('/tmp/xdiff/rustc.txt').read_text().strip();e=os.environ.copy();e['LD_LIBRARY_PATH']=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+e.get('LD_LIBRARY_PATH','')
cmd=[r,'--edition=2024','-O','-C','codegen-units=1','--emit=link,asm,llvm-ir',str(p/'leaf.rs'),'-o',str(p/'leaf')]
subprocess.run(cmd,env=e,check=True);subprocess.run([str(p/'leaf'),'slow','1'],env=e,check=True);subprocess.run([str(p/'leaf'),'fast','1'],env=e,check=True)
(p/('leaf-build.'+platform.machine()+'.json')).write_text(json.dumps({'command':cmd,'source_sha256':hashlib.sha256((p/'leaf.rs').read_bytes()).hexdigest()},indent=2))
