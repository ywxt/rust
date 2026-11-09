from pathlib import Path
import subprocess,os,platform,json
p=Path(__file__).resolve().parent
r=Path('/tmp/xdiff/rustc.txt').read_text().strip()
e=os.environ.copy();e['LD_LIBRARY_PATH']=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+e.get('LD_LIBRARY_PATH','')
cases=[('unroll4',['-unroll-count=4']),('unroll8',['-unroll-count=8']),('nohoist',['-disable-constant-hoisting']),('nolsr',['-disable-lsr']),('nosched',['-enable-misched=false'])]
if platform.machine()=='aarch64':cases.extend([('nocsel',['-aarch64-enable-early-ifcvt=false']),('noselect',['-aarch64-select-opt=false'])])
for name,args in cases:
 cmd=[r,'--edition=2024','-O','-C','codegen-units=1','--emit=link,asm,llvm-ir',*[a for arg in args for a in ['-C','llvm-args='+arg]],str(p/'probe.rs'),'-o',str(p/name)]
 x=subprocess.run(cmd,env=e,capture_output=True,text=True)
 if x.returncode:print(name,x.stderr);continue
 subprocess.run([str(p/name),'original','1'],env=e,check=True)
 print(name,'ready')
(p/'variant-options.json').write_text(json.dumps(cases,indent=2))
