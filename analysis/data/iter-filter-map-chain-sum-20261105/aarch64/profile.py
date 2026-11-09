from pathlib import Path
import subprocess,os,json,platform
p=Path(__file__).resolve().parent;arch=platform.machine();core='52'if arch=='aarch64'else'12';ld=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+os.environ.get('LD_LIBRARY_PATH','');e=os.environ.copy();e.pop('LD_LIBRARY_PATH',None);ev='cpu_core/cycles/u'if arch=='x86_64'else'cycles:u';out=[]
for mode in ['original','guarded']:
 data=p/('profile-'+mode+'.'+arch+'.data');cmd=['perf','record','-q','-F','997','-e',ev,'-o',str(data),'--','taskset','-c',core,'env','LD_LIBRARY_PATH='+ld,str(p/'probe'),mode,'1000'];x=subprocess.run(cmd,env=e,capture_output=True,text=True,check=True);cmd2=['perf','report','--stdio','--no-children','--percent-limit','1','-i',str(data)];y=subprocess.run(cmd2,env=e,capture_output=True,text=True,check=True);(p/('profile-'+mode+'.'+arch+'.txt')).write_text(y.stdout+'\n'+y.stderr);out.append({'mode':mode,'command':cmd,'stdout':x.stdout,'stderr':x.stderr,'report':cmd2})
(p/('profiles.'+arch+'.json')).write_text(json.dumps(out,indent=2));print('profiles saved')
