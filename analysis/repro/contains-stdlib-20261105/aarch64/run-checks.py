import pathlib,subprocess,platform,os,json
r=pathlib.Path(__file__).resolve().parent;arm=platform.machine()=='aarch64';target='aarch64-unknown-linux-gnu' if arm else 'x86_64-unknown-linux-gnu'
for variant in ['baseline','optimized']:
 libs=str(r/'sysroots'/variant/'lib/rustlib'/target/'lib')+('' if arm else ':/nix/store/604gsr59rj7dzd0nrhp143rpvf7gyiaz-gcc-15.3.0-lib/lib')
 for name in ['check','custom-check']:
  p=subprocess.run(['env','LD_LIBRARY_PATH='+libs,str(r/variant/target/name)],capture_output=True,text=True);(r/variant/target/(name+'.log')).write_text(p.stdout+p.stderr);print(variant,name,p.stdout,flush=True);assert p.returncode==0,p.stderr
