from pathlib import Path
import subprocess,os,platform,json
p=Path(__file__).resolve().parent;arch=platform.machine();r=Path('/tmp/xdiff/rustc.txt').read_text().strip();e=os.environ.copy();e['LD_LIBRARY_PATH']=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+e.get('LD_LIBRARY_PATH','')
cases=[('candidate-unroll4','-unroll-count=4'),('candidate-nosched','-enable-misched=false')]
if arch=='aarch64':cases.extend([('candidate-noifcvt','-aarch64-enable-early-ifcvt=false'),('candidate-noselect','-aarch64-select-opt=false')])
for tag,arg in cases:
 x=subprocess.run([r,'--edition=2024','-O','-C','codegen-units=1','-C','llvm-args='+arg,'--emit=link,asm,llvm-ir',str(p/'candidate.rs'),'-o',str(p/tag)],env=e,capture_output=True);x.check_returncode()
 subprocess.run([str(p/tag),'fast','1'],env=e,check=True)
(p/('options.'+arch+'.json')).write_text(json.dumps(cases,indent=2));print('option variants ready',arch)
