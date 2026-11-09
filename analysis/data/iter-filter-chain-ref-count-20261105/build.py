from pathlib import Path
import os,subprocess,platform,json,hashlib
p=Path(__file__).resolve().parent
r=Path('/tmp/xdiff/rustc.txt').read_text().strip()
e=os.environ.copy();e['LD_LIBRARY_PATH']=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+e.get('LD_LIBRARY_PATH','')
cmd=[r,'--edition=2024','-C','opt-level=3','-C','codegen-units=1','--emit=link,asm,llvm-ir',str(p/'probe.rs'),'-o',str(p/'normal')]
x=subprocess.run(cmd,env=e,capture_output=True,text=True);print(x.stderr);x.check_returncode()
for name in ['original','owned','split','manual','unsigned','no_modulus']:subprocess.run([str(p/'normal'),name,'1'],env=e,check=True)
meta={'arch':platform.machine(),'source_sha256':hashlib.sha256((p/'probe.rs').read_bytes()).hexdigest(),'compiler':subprocess.check_output([r,'-vV'],env=e,text=True),'command':cmd,'ld_library_path':e['LD_LIBRARY_PATH']}
(p/('build.'+platform.machine()+'.json')).write_text(json.dumps(meta,indent=2));print(json.dumps(meta))
