import pathlib,subprocess,os,platform,sys
root=pathlib.Path(__file__).resolve().parent
arm=platform.machine()=="aarch64"
core="52" if arm else "12"
libs=pathlib.Path("/tmp/xdiff/libdir.txt").read_text().strip()
compiler=pathlib.Path("/tmp/xdiff/rustc.txt").read_text().strip()
def binary(name):
    p=root/"rebuilt"/name
    return p if p.exists() else root/name
def perf_command(program,args):
    return ["taskset","-c",core,"env","-u","LD_LIBRARY_PATH","perf","stat","-e","cycles:u,instructions:u,branches:u,branch-misses:u,task-clock","--","env","LD_LIBRARY_PATH="+libs,str(program)]+args
action=sys.argv[1]
if action=="build":
    name=sys.argv[2] if len(sys.argv)>2 else "bang-probe-v7"
    assert name in ["bang-probe-v3","bang-probe-v5","bang-probe-v7","bang-benches-v3","bang-benches-guarded","bang-benches-v8"]
    dest=root/"rebuilt";dest.mkdir(exist_ok=True)
    cmd=[compiler,str(root/(name+".rs")),"-O","--edition=2024","-Cprefer-dynamic","-Zinline-mir","-Cllvm-args=-import-instr-limit=10"]
    if "benches" in name:cmd.append("--test")
    cmd+=["--emit=link,llvm-ir,asm","-o",str(dest/name)]
    env=os.environ.copy()
    env["LD_LIBRARY_PATH"]=libs+(":/nix/store/604gsr59rj7dzd0nrhp143rpvf7gyiaz-gcc-15.3.0-lib/lib" if not arm else "")
    subprocess.run(cmd,env=env,check=True)
    print(dest/name)
elif action in ["check","metadata"]:
    env=os.environ.copy();env["LD_LIBRARY_PATH"]=libs
    subprocess.run([str(binary("bang-probe-v7")),action],env=env,check=True)
elif action=="perf":
    case=sys.argv[2] if len(sys.argv)>2 else "str::align64_str::long_lorem_ipsum"
    subprocess.run(perf_command(binary("bang-benches-v8"),["--bench",case,"--exact","--format=terse"]),check=True)
elif action=="probe":
    mode=sys.argv[2];index=sys.argv[3] if len(sys.argv)>3 else "3"
    offset=sys.argv[4] if len(sys.argv)>4 else "0"
    distribution=sys.argv[5] if len(sys.argv)>5 else "original"
    assert distribution=="original" or index in ["0","3"]
    n="10000000" if distribution=="front" else "1000000"
    subprocess.run(perf_command(binary("bang-probe-v7"),[mode,index,n,offset,distribution]),check=True)
else:raise SystemExit("actions: build [program], check, metadata, perf [exact-bench], probe mode [index [offset [original|absent|front]]]")
