from pathlib import Path
import subprocess,os,json,platform
p=Path(__file__).resolve().parent;r=Path('/tmp/xdiff/rustc.txt').read_text().strip();e=os.environ.copy();e['LD_LIBRARY_PATH']=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+e.get('LD_LIBRARY_PATH','');cases=[];out=[]
for off in [0,16,32,48]:
 for tag,flags in [('base',[]),('u4',['-C','llvm-args=-unroll-count=4'])]:
  binary=f'layout-{tag}-{off}';cmd=[r,'--edition=2024','-O','-C','codegen-units=1','-C',f'link-arg=-Wl,-Ttext={0x10000+off}']+flags+[str(p/'probe.rs'),'-o',str(p/binary)];subprocess.run(cmd,env=e,check=True);x=subprocess.check_output([str(p/binary),'check','1'],env=e,text=True);out.append({'command':cmd,'check':x});cases+=[[binary,m,0,1000000,'all_valid',60]for m in (['original','guarded']if tag=='base'else['original'])]
(p/('layout-build.'+platform.machine()+'.json')).write_text(json.dumps(out,indent=2));(p/'layout-configs.json').write_text(json.dumps(cases));print('layout builds done')
