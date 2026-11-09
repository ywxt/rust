from pathlib import Path
import subprocess,platform,json
r=Path('/tmp/contains-portable-simd64-20261105');old=Path('/tmp/contains-portable-simd-20261105');arm=platform.machine()=='aarch64';target='aarch64-unknown-linux-gnu' if arm else 'x86_64-unknown-linux-gnu';core='52' if arm else '12'
for label,root,variant in [('intrinsics',r,'baseline'),('portable16',old,'optimized'),('portable64',r,'optimized')]:
 lib=str(root/'sysroots'/variant/'lib/rustlib'/target/'lib')+('' if arm else ':/nix/store/604gsr59rj7dzd0nrhp143rpvf7gyiaz-gcc-15.3.0-lib/lib')
 stem=r/('profile-'+label);data=str(stem)+'.data'
 p=subprocess.run(['taskset','-c',core,'env','-u','LD_LIBRARY_PATH','perf','record','-o',data,'-e','cycles:u','-c','500003','--','env','LD_LIBRARY_PATH='+lib,str(root/variant/target/'counted'),'str::contains_bang_str_long_lorem_ipsum','10000000'],capture_output=True,text=True)
 Path(str(stem)+'-record.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stderr
 for tool in ['report','annotate']:
  p=subprocess.run(['env','-u','LD_LIBRARY_PATH','perf',tool,'-i',data,'--stdio'],capture_output=True,text=True);Path(str(stem)+'-'+tool+'.txt').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stderr
 print('profiled',label,flush=True)
