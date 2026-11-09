from pathlib import Path
import subprocess,os,json,platform,hashlib
p=Path(__file__).resolve().parent;r=Path('/tmp/xdiff/rustc.txt').read_text().strip();e=os.environ.copy();e['LD_LIBRARY_PATH']=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+e.get('LD_LIBRARY_PATH','');arch=platform.machine();triple='aarch64-unknown-linux-gnu'if arch=='aarch64'else'x86_64-unknown-linux-gnu';base=Path('/tmp/xdiff-src/build')/triple/'stage1-std'/triple/'dist/build';deps=sorted({str(f.parent)for f in base.glob('*/*/out/*.rlib')});rands=list(base.glob('rand/*/out/librand-*.rmeta'));xors=list(base.glob('rand_xorshift/*/out/librand_xorshift-*.rmeta'));attempts=[]
for rd in rands:
 for xr in xors:
  flags=sum([['-L','dependency='+v]for v in deps],[])+['--extern','rand='+str(rd),'--extern','rand='+str(rd.with_suffix('.rlib')),'--extern','rand_xorshift='+str(xr),'--extern','rand_xorshift='+str(xr.with_suffix('.rlib'))];cmd=[r,'--edition=2024','-O','-C','codegen-units=1','--emit=link,asm,llvm-ir']+flags+[str(p/'probe.rs'),'-o',str(p/'probe')];x=subprocess.run(cmd,env=e,capture_output=True,text=True);attempts.append({'command':cmd,'exit_code':x.returncode,'stderr':x.stderr})
  if not x.returncode:
   (p/'dependency-flags.json').write_text(json.dumps(flags));(p/('build.'+arch+'.json')).write_text(json.dumps({'compiler':subprocess.check_output([r,'-vV'],env=e,text=True),'attempts':attempts,'sources':{f.name:hashlib.sha256(f.read_bytes()).hexdigest()for f in p.glob('*.rs')},'extern_sha256':{str(f):hashlib.sha256(f.read_bytes()).hexdigest()for f in [rd,xr]}},indent=2));print('built with',rd.name,xr.name);raise SystemExit(0)
(p/('build-failed.'+arch+'.json')).write_text(json.dumps(attempts,indent=2));raise RuntimeError(attempts[-1]['stderr'])
