from pathlib import Path
import subprocess,os,json,platform
p=Path(__file__).resolve().parent;r=Path('/tmp/xdiff/rustc.txt').read_text().strip();e=os.environ.copy();e['LD_LIBRARY_PATH']=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+e.get('LD_LIBRARY_PATH','');cmd=[r,'--edition=2024','-O','-C','codegen-units=1','--emit=link,asm,llvm-ir',str(p/'leaf.rs'),'-o',str(p/'leaf')];subprocess.run(cmd,env=e,check=True);(p/('leaf-build.'+platform.machine()+'.json')).write_text(json.dumps({'command':cmd,'compiler':subprocess.check_output([r,'-vV'],env=e,text=True)},indent=2))
