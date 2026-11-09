from pathlib import Path
import subprocess,os,platform
p=Path(__file__).resolve().parent;arch=platform.machine();core='52' if arch=='aarch64' else '12';ld=Path('/tmp/xdiff/libdir.txt').read_text().strip();e=os.environ.copy();e.pop('LD_LIBRARY_PATH',None)
for mode in ['format','count','raw']:
 out=p/(f'perf-{mode}.{arch}.data');cmd=['perf','record','-F','997','-e','cpu_core/cycles/u' if arch=='x86_64' else 'cycles:u','-o',str(out),'--','taskset','-c',core,'env','LD_LIBRARY_PATH='+ld,str(p/'probe'),mode,'5000000']
 x=subprocess.run(cmd,env=e,capture_output=True,text=True);x.check_returncode()
 x=subprocess.run(['perf','report','--stdio','--no-children','--percent-limit','1','--sort','symbol','-i',str(out)],env=e,capture_output=True,text=True);x.check_returncode();(p/(f'profile-{mode}.{arch}.txt')).write_text(x.stdout)
 print(mode,'\n'+'\n'.join(v for v in x.stdout.splitlines() if '%' in v)[:2200])
