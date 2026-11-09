from pathlib import Path
import os,subprocess,json,platform
r=Path(__file__).resolve().parent;arch=platform.machine();target=arch+'-unknown-linux-gnu';core='52'if arch=='aarch64'else'12';lib='/tmp/contains-bad-simd-20261105/sysroots/baseline/lib/rustlib/'+target+'/lib'+(''if arch=='aarch64'else':/nix/store/604gsr59rj7dzd0nrhp143rpvf7gyiaz-gcc-15.3.0-lib/lib');e=os.environ.copy();e.pop('LD_LIBRARY_PATH',None);e.pop('LD_PRELOAD',None);rows=[]
for variant in ['0000','0016']:
 binary=r/target/'benches-base';shim=r/target/('shim-'+variant+'.so');cmd=['taskset','-c',core,'setarch',arch,'-R','env','LD_DEBUG=bindings','LD_LIBRARY_PATH='+lib,'LD_PRELOAD='+str(shim),str(binary),'--list'];p=subprocess.run(cmd,env=e,text=True,capture_output=True,check=True);matches=[l for l in p.stderr.splitlines()if 'core5slice6memchr7memrchr'in l];assert any(str(binary)in l and str(shim)in l for l in matches),matches;(r/('bindings.'+variant+'.'+arch+'.txt')).write_text('\n'.join(matches)+'\n');rows.append(dict(variant=variant,command=cmd,bindings=matches))
(r/('binding-check.'+arch+'.json')).write_text(json.dumps(rows,indent=2));print('BINDING_CHECK_OK')
