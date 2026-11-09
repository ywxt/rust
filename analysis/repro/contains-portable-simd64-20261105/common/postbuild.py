from pathlib import Path
import subprocess,shutil,json,hashlib,os
r=Path(__file__).parent;w=Path("/home/wheel/c00936152/rust-contains-stdlib");actual=Path("/home/wheel/c00936152/rust-analysis/library/core/src/str/pattern.rs");p=Path("library/core/src/str/pattern.rs")
saved={}
for raw in subprocess.check_output(["git","ls-files","-z","*.rs"],cwd=w).split(b"\0"):
 if not raw:continue
 f=w/os.fsdecode(raw)
 if f.is_file() and f!=w/p:saved[f]=(f.read_bytes(),f.stat())
before=actual.read_bytes()
a=subprocess.run(["./x","fmt"],cwd=w,stdout=(r/"fmt.log").open("w"),stderr=subprocess.STDOUT)
for f,(data,st) in saved.items():
 if f.read_bytes()!=data:f.write_bytes(data);os.utime(f,ns=(st.st_atime_ns,st.st_mtime_ns))
assert a.returncode==0
assert actual.read_bytes()==before
actual.write_bytes((w/p).read_bytes());shutil.copy2(actual,r/"pattern.portable.rs")
subprocess.run(["diff","-u",str(r/"pattern.intrinsics.rs"),str(r/"pattern.portable.rs")],stdout=(r/"portable.patch").open("w"))
build=Path("/tmp/contains-stdlib-build/aarch64-unknown-linux-gnu/stage0-std");manifest={}
for target in ["aarch64-unknown-linux-gnu","x86_64-unknown-linux-gnu"]:
 dest=r/"sysroots/optimized/lib/rustlib"/target/"lib";dest.mkdir(parents=True)
 for f in (build/target/"dist/build").glob("*/*/out/lib*"):
  if f.is_file() and not f.is_symlink() and f.suffix in [".rlib",".rmeta",".so",".a",".o"]:shutil.copy2(f,dest/f.name)
 for pattern in ["libcore-*.rlib","libstd-*.rlib","libstd-*.so","libtest-*.rlib"]:assert len(list(dest.glob(pattern)))==1,(target,pattern)
 manifest[target]={f.name:hashlib.sha256(f.read_bytes()).hexdigest() for f in dest.iterdir() if f.is_file()}
(r/"optimized-sysroot-manifest.json").write_text(json.dumps(manifest,indent=2))
subprocess.run(["python3",str(r/"build-harness.py"),"optimized","check","custom-check","benches","matrix","counted"],check=True)
a=subprocess.run(["./x","test","--stage","0","--set","build.compiletest-allow-stage0=true","library/coretests","library/alloctests","--target","aarch64-unknown-linux-gnu","--test-args","str::"],cwd=w,stdout=(r/"in-tree-tests.log").open("w"),stderr=subprocess.STDOUT);assert a.returncode==0
print("postbuild complete",flush=True)
