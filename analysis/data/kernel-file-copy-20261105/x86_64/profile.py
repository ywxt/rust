from pathlib import Path
import subprocess,os,platform,json
p=Path(__file__).resolve().parent;arch=platform.machine();core='52' if arch=='aarch64' else '12';ld=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+os.environ.get('LD_LIBRARY_PATH','');e=os.environ.copy();e.pop('LD_LIBRARY_PATH',None);roots=['/tmp','/home/wheel/copy-bench-20261105']if arch=='aarch64' else ['/tmp','/dev/shm/kernel-file-copy-20261105'];out=[]
for i,root in enumerate(roots):
 data=p/('profile-'+str(i)+'.'+arch+'.data');event='cycles'if arch=='aarch64'else'cpu_core/cycles/'
 cmd=['perf','record','-q','-F','997','-e',event,'-g','-o',str(data),'--','taskset','-c',core,'env','LD_LIBRARY_PATH='+ld,str(p/'probe'),'std','131072','200000',root];x=subprocess.run(cmd,env=e,text=True,capture_output=True);x.check_returncode();cmd2=['perf','report','--stdio','--no-children','--percent-limit','0.5','-i',str(data)];y=subprocess.run(cmd2,env=e,text=True,capture_output=True);(p/('profile-'+str(i)+'.'+arch+'.txt')).write_text(y.stdout+'\n'+y.stderr);out.append({'root':root,'record':cmd,'report':cmd2,'stdout':x.stdout,'stderr':x.stderr,'report_stderr':y.stderr})
(p/('profiles.'+arch+'.json')).write_text(json.dumps(out,indent=2));print('profiles saved')
