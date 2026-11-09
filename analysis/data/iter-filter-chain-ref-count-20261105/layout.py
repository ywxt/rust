from pathlib import Path
import subprocess,os,platform,json
p=Path(__file__).resolve().parent;arch=platform.machine();r=Path('/tmp/xdiff/rustc.txt').read_text().strip()
e=os.environ.copy();e['LD_LIBRARY_PATH']=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+e.get('LD_LIBRARY_PATH','')
configs=[]
for off in [0,16,32,48]:
 for tag,source,args,fn in [('base','probe.rs',[],'original'),('u4','probe.rs',['-C','llvm-args=-unroll-count=4'],'original'),('source','source-probe.rs',[],'source_unroll4')]:
  name=f'layout-{tag}-{off}';cmd=[r,'--edition=2024','-O','-C','codegen-units=1',*args,'-C','link-arg=-Wl,--section-start=.text='+hex(0x10000+off),str(p/source),'-o',str(p/name)]
  subprocess.run(cmd,env=e,capture_output=True,check=True)
  subprocess.run([str(p/name),fn,'1'],env=e,check=True)
  configs.append([name,fn])
(p/'layout-configs.json').write_text(json.dumps(configs));print('layout builds ready',arch)
