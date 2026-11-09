from pathlib import Path
import subprocess,shlex
code=r"""
from pathlib import Path
import subprocess,difflib
r=Path('/tmp/contains-bad-simd-20261105');source=Path('/tmp/contains-bad-simd-source');g=r/'gather-build.py';s=g.read_text().replace("assert v in ['baseline','candidate']","assert v in ['baseline','candidate','mask','combined']");g.write_text(s)
def change(s):
 a='    let test_chunk = |idx| -> u16 {';assert s.count(a)==1;s=s.replace(a,'    let test_chunk = |idx| -> Mask {')
 a='''        let mask = both.to_bitmask() as u16;

        mask''';assert s.count(a)==1;s=s.replace(a,'        both')
 a='''        let mut masks = [0u16; UNROLL];
        for j in 0..UNROLL {
            masks[j] = test_chunk(i + j * Block::LEN);
        }
        for j in 0..UNROLL {
            let mask = masks[j];
            if mask != 0 {
                result |= check_mask(i + j * Block::LEN, mask, result);
            }
        }'''
 b='''        let mut masks = [Mask::splat(false); UNROLL];
        for j in 0..UNROLL {
            masks[j] = test_chunk(i + j * Block::LEN);
        }
        if (masks[0] | masks[1] | masks[2] | masks[3]).any() {
            for j in 0..UNROLL {
                let mask = masks[j].to_bitmask() as u16;
                if mask != 0 {
                    result |= check_mask(i + j * Block::LEN, mask, result);
                }
            }
        }''';assert s.count(a)==1;s=s.replace(a,b)
 a='''        let mask = test_chunk(i);
        if mask != 0 {
            result |= check_mask(i, mask, result);
        }''';b='''        let mask = test_chunk(i);
        if mask.any() {
            result |= check_mask(i, mask.to_bitmask() as u16, result);
        }''';assert s.count(a)==1;s=s.replace(a,b)
 a='''    let mask = test_chunk(i);
    if mask != 0 {
        result |= check_mask(i, mask, result);
    }''';b='''    let mask = test_chunk(i);
    if mask.any() {
        result |= check_mask(i, mask.to_bitmask() as u16, result);
    }''';assert s.count(a)==1;s=s.replace(a,b);return s
for variant,base in [('mask','baseline'),('combined','candidate')]:
 old=(r/('pattern.'+base+'.rs')).read_text();new=change(old);(source/'library/core/src/str/pattern.rs').write_text(new);(r/('pattern.'+variant+'.rs')).write_text(new);(r/('interface.'+variant+'.patch')).write_text(''.join(difflib.unified_diff((r/'pattern.baseline.rs').read_text().splitlines(True),new.splitlines(True),fromfile='a/library/core/src/str/pattern.rs',tofile='b/library/core/src/str/pattern.rs')))
 with(r/(variant+'-stdlib-build.log')).open('w')as out:x=subprocess.run(['./x','build','--stage','0','library/std','library/test','--target','aarch64-unknown-linux-gnu,x86_64-unknown-linux-gnu'],cwd=source,stdout=out,stderr=subprocess.STDOUT)
 assert x.returncode==0,variant+' build failed';print(variant,'stdlib built',flush=True);subprocess.run(['python3',str(g),variant],check=True)
"""
subprocess.run(['ssh','-F','/run/secrets/rendered/univpn-ssh.conf','-o','BatchMode=yes','-o','ConnectTimeout=15','univpn-work-1','python3 -c '+shlex.quote(code)],check=True)
