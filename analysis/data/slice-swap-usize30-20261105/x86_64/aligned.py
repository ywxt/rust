from pathlib import Path
import os,subprocess,json,platform
p=Path(__file__).resolve().parent;s=(p/'probe.rs').read_text();s=s.replace('let ax:usize=','let mut ax:usize=').replace('let ay:usize=','let mut ay:usize=').replace('0..n+ax+8','0..n+ax+24').replace('0..n+ay+8','0..n+ay+24');needle='let mut skip=0;';s=s.replace(needle,'ax+=((64-(x.as_ptr()as usize%64))%64)/8;ay+=((64-(y.as_ptr()as usize%64))%64)/8;'+needle);(p/'aligned-probe.rs').write_text(s)
r=Path('/tmp/xdiff/rustc.txt').read_text().strip();e=os.environ.copy();e['LD_LIBRARY_PATH']=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+e.get('LD_LIBRARY_PATH','');arch=platform.machine();cs={'aligned':[]}
if arch=='aarch64':cs.update(aligned_noldst=['-aarch64-enable-ldst-opt=false'])
else:cs.update(aligned_interleave1=['-force-vector-interleave=1'])
out=[]
for name,flags in cs.items():
 c=[r,'--edition=2024','-O','-C','codegen-units=1','--emit=link,asm,llvm-ir']+sum([['-C','llvm-args='+v]for v in flags],[])+[str(p/'aligned-probe.rs'),'-o',str(p/name)];subprocess.run(c,env=e,check=True);out.append(c)
(p/('aligned-build.'+arch+'.json')).write_text(json.dumps(out,indent=2));cs=[[b,m,30,ax,ay,250000]for b in ['aligned']+(['aligned_noldst']if arch=='aarch64'else['aligned_interleave1'])for m in ['original','vec','reg','even']for ax,ay in [(0,0),(0,2),(2,0),(2,2)]];(p/'aligned-configs.json').write_text(json.dumps(cs));print('aligned builds ready')
