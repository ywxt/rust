from pathlib import Path
import subprocess,os,platform,json
p=Path(__file__).resolve().parent;arch=platform.machine();r=Path('/tmp/xdiff/rustc.txt').read_text().strip();d=Path(r).parents[2]/'ci-llvm/bin'
e=os.environ.copy();e['LD_LIBRARY_PATH']=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+e.get('LD_LIBRARY_PATH','')
for tag,args in [('base',[]),('unroll4',['-unroll-count=4'])]:
 name='ir-'+tag
 subprocess.run([str(d/'opt'),'-O3','-mtriple='+arch+'-unknown-linux-gnu',*args,'-S',str(p/'repro.ll'),'-o',str(p/(name+'.ll'))],env=e,check=True)
 subprocess.run([str(d/'llc'),'-O3','-filetype=obj','-relocation-model=pic',str(p/(name+'.ll')),'-o',str(p/(name+'.o'))],env=e,check=True)
 subprocess.run([str(d/'llc'),'-O3',str(p/(name+'.ll')),'-o',str(p/(name+'.s'))],env=e,check=True)
 subprocess.run([r,'--edition=2024','-O',str(p/'ir-driver.rs'),'-C','link-arg='+str(p/(name+'.o')),'-o',str(p/name)],env=e,check=True)
 subprocess.run([str(p/name),'1'],env=e,check=True)
print('IR correctness passed',arch)
