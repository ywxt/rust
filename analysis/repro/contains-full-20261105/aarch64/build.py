import pathlib,platform,subprocess,os,sys
r=pathlib.Path(__file__).resolve().parent;libs=pathlib.Path('/tmp/xdiff/libdir.txt').read_text().strip();compiler=pathlib.Path('/tmp/xdiff/rustc.txt').read_text().strip();arm=platform.machine()=='aarch64'
e=os.environ.copy();e['LD_LIBRARY_PATH']=libs+('' if arm else ':/nix/store/604gsr59rj7dzd0nrhp143rpvf7gyiaz-gcc-15.3.0-lib/lib')
for name in (sys.argv[1:] or ['check']):
 cmd=[compiler,str(r/(name+'.rs')),'-O','--edition=2024','-Cprefer-dynamic','-Zinline-mir','-Cllvm-args=-import-instr-limit=10','--emit=link,llvm-ir,asm','-o',str(r/name)]
 if name=='benches':cmd+=['--test']
 p=subprocess.run(cmd,env=e,capture_output=True,text=True);(r/(name+'-build.log')).write_text(str(cmd)+'\n'+p.stdout+p.stderr);assert p.returncode==0,p.stderr
 if name in ['check','custom-check']:
  p=subprocess.run([str(r/name)],env=e,capture_output=True,text=True);(r/(name+'.log')).write_text(p.stdout+p.stderr);assert p.returncode==0,p.stderr;print(p.stdout,flush=True)
