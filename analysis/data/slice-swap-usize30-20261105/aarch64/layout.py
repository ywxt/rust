from pathlib import Path
import subprocess,os,json,platform
p=Path(__file__).resolve().parent;r=Path('/tmp/xdiff/rustc.txt').read_text().strip();e=os.environ.copy();e['LD_LIBRARY_PATH']=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+e.get('LD_LIBRARY_PATH','');arch=platform.machine();cases=[];out=[]
for off in [0,16,32,48]:
 for tag,flags in [('base',[])]+([('noldst',['-aarch64-enable-ldst-opt=false'])]if arch=='aarch64'else[]):
  name=f'layout-{tag}-{off}';cmd=[r,'--edition=2024','-O','-C','codegen-units=1','-C',f'link-arg=-Wl,-Ttext={0x10000+off}']+sum([['-C','llvm-args='+v]for v in flags],[])+[str(p/'aligned-probe.rs'),'-o',str(p/name)];subprocess.run(cmd,env=e,check=True);out.append(cmd);cases+=[[name,m,30,0,0,250000]for m in ['original','vec']]
(p/('layout-build.'+arch+'.json')).write_text(json.dumps(out,indent=2));(p/'layout-configs.json').write_text(json.dumps(cases))
