from pathlib import Path
import subprocess,os,platform
p=Path(__file__).resolve().parent;arch=platform.machine();r=Path('/tmp/xdiff/rustc.txt').read_text().strip()
env=os.environ.copy();env['LD_LIBRARY_PATH']=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+env.get('LD_LIBRARY_PATH','')
tags=['normal','no-color']+(['no-ldst'] if arch=='aarch64' else [])
names=[]
for tag in tags:
 extra=[] if tag=='normal' else ['-C','llvm-args='+('-no-stack-coloring' if tag=='no-color' else '-aarch64-enable-ldst-opt=false')]
 for off in [0,16,32,48]:
  name=tag+'-layout-'+str(off);names.append(name)
  subprocess.run([r,'--edition=2021','-C','opt-level=3','-C','debuginfo=1',*extra,'-C','link-arg=-Wl,--section-start=.text='+hex(0x10000+off),str(p/'probe.rs'),'-o',str(p/name)],env=env,check=True)
  subprocess.run([str(p/name),'check'],env=env,check=True,stdout=subprocess.DEVNULL)
s=(p/'measure.py').read_text();start=s.index("tags=['normal'");end=s.index('\nruns=',start)
s=s[:start]+'tags='+repr(names)+"\ncases=[(tag,'base') for tag in tags]"+s[end:]
s=s.replace("'results.'+arch+'.json'","'layout.'+arch+'.json'")
(p/'measure-layout.py').write_text(s)
subprocess.run(['python3',str(p/'measure-layout.py')],check=True)
