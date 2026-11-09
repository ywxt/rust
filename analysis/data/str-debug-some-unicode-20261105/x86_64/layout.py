from pathlib import Path
import os,platform,subprocess,json
p=Path(__file__).resolve().parent;r=Path('/tmp/xdiff/rustc.txt').read_text().strip();e=os.environ.copy();e['LD_LIBRARY_PATH']=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+e.get('LD_LIBRARY_PATH','');configs=[]
for off in [0,16,32,48]:
 for typ in ['candidate','range']:
  tag=f'{typ}-layout-{off}'
  x=subprocess.run([r,'--edition=2024','-O','-C','codegen-units=1','-C','link-arg=-Wl,--section-start=.text='+hex(0x10000+off),str(p/(typ+'.rs')),'-o',str(p/tag)],env=e,capture_output=True);x.check_returncode()
  subprocess.run([str(p/tag),'fast','1'],env=e,check=True)
  configs.extend([[tag,'count_copy'],[tag,'count_fast']])
(p/'layout-configs.json').write_text(json.dumps(configs));print('layout builds ready',platform.machine())
