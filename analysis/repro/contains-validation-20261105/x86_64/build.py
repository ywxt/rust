import pathlib,platform,subprocess,os
r=pathlib.Path(__file__).resolve().parent;libs=pathlib.Path('/tmp/xdiff/libdir.txt').read_text().strip();compiler=pathlib.Path('/tmp/xdiff/rustc.txt').read_text().strip()
e=os.environ.copy();e['LD_LIBRARY_PATH']=libs+(':/nix/store/604gsr59rj7dzd0nrhp143rpvf7gyiaz-gcc-15.3.0-lib/lib' if platform.machine()!='aarch64' else '')
cmd=[compiler,str(r/'matrix.rs'),'-O','--edition=2024','-Cprefer-dynamic','-Zinline-mir','-Cllvm-args=-import-instr-limit=10','--emit=link,llvm-ir,asm','-o',str(r/'matrix')]
p=subprocess.run(cmd,env=e,capture_output=True,text=True);(r/'build.log').write_text(str(cmd)+'\n'+p.stdout+p.stderr);assert p.returncode==0,p.stderr
p=subprocess.run([str(r/'matrix'),'check'],env=e,capture_output=True,text=True);(r/'check.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stderr;print(p.stdout)
