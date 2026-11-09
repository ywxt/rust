import pathlib,shutil,hashlib,json,subprocess,os
r=pathlib.Path('/tmp/contains-arm-word4-exit-20261106')
targets=['aarch64-unknown-linux-gnu','x86_64-unknown-linux-gnu']
for t in targets:
 out=r/'sysroots/optimized/lib/rustlib'/t/'lib';out.mkdir(parents=True,exist_ok=True)
 root=pathlib.Path('/tmp/contains-stdlib-build/aarch64-unknown-linux-gnu/stage0-std')/t/'dist/build'
 files={}
 for p in root.glob('*/*/out/lib*'):
  if p.is_file() and not p.is_symlink() and p.suffix in ['.rlib','.rmeta','.so','.o','.a']:
   if p.name in files:assert p.read_bytes()==files[p.name].read_bytes(),p
   files[p.name]=p
 for p in files.values():shutil.copy2(p,out/p.name)
 for pattern in ['libcore-*.rlib','libstd-*.rlib','libstd-*.so','libtest-*.rlib']:
  assert len(list(out.glob(pattern)))==1,(t,pattern)
manifest={}
for v in ['baseline','optimized']:
 manifest[v]={}
 for t in targets:
  lib=r/'sysroots'/v/'lib/rustlib'/t/'lib'
  manifest[v][t]={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in lib.iterdir() if p.is_file()}
(r/'sysroot-manifests.json').write_text(json.dumps(manifest,indent=2))
p=json.loads((r/'provenance.json').read_text());p.pop('tail_change',None);p['tail_change']='original word and scalar hit/tail paths; SIMD restricted to long body';(r/'provenance.json').write_text(json.dumps(p,indent=2))
names=['check','custom-check','counted','matrix','byte-check','byte-matrix','index-check','memchr-index-check','index-matrix','split-counted']
for v in ['baseline','optimized']:
 subprocess.run(['python3',str(r/'build-harness.py'),v]+names,check=True)
 lib=r/'sysroots'/v/'lib/rustlib'/targets[0]/'lib'
 for name in ['byte-check','index-check','memchr-index-check']:
  out=r/v/targets[0];env=os.environ.copy();env['LD_LIBRARY_PATH']=str(lib)
  result=subprocess.run([str(out/name)],env=env,capture_output=True,text=True)
  (out/(name+'.log')).write_text(result.stdout+result.stderr);assert result.returncode==0,result.stderr
  print(v,name,result.stdout,flush=True)
print('PREPARE COMPLETE',flush=True)

