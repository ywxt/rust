from pathlib import Path
import json,re,subprocess,os
r=Path('/tmp/sort-small-random-20261106');commands=json.loads((r/'build-commands.json').read_text());e=os.environ.copy();e['LD_LIBRARY_PATH']='/home/wheel/c00936152/rust-analysis/build/aarch64-unknown-linux-gnu/stage1/lib';saved=[]
for target in ['aarch64-unknown-linux-gnu','x86_64-unknown-linux-gnu']:
 p=r/target;text=(p/'probes-base.s').read_text();symbol=next(l[:-1]for l in text.splitlines()if l.endswith(':')and'insertion_sort_shift_left' in l)
 c=next(c.copy()for c in commands if c[-1]==str(p/'probes-base'));c[c.index('-o')+1]=str(p/'probes-lsr-trace');c[c.index('--emit=link,asm,llvm-ir')]='--emit=asm';c+=['-Cllvm-args=-print-before=loop-reduce','-Cllvm-args=-print-after=loop-reduce','-Cllvm-args=-filter-print-funcs='+symbol];q=subprocess.run(c,env=e,text=True,capture_output=True);(p/'lsr-stage-ir.txt').write_text(q.stdout+q.stderr);assert q.returncode==0,q.stderr;assert 'IR Dump' in q.stderr,'No stage output';saved.append(c)
(r/'lsr-trace-commands.json').write_text(json.dumps(saved,indent=2))
