from pathlib import Path
import re,json,hashlib,difflib
p=Path(__file__).resolve().parent
original=(p/'benchmarks-conclusion.md').read_text();lines=original.splitlines(keepends=True)
def headings(text):
 out=[];fence=None
 for i,l in enumerate(text.splitlines(keepends=True)):
  m=re.match(r'^\s*(`{3,}|~{3,})',l)
  if m:
   mark=m[1][0]
   if fence is None:fence=mark
   elif fence==mark:fence=None
   continue
  if fence is None and l.startswith('# '):out.append((i,l.strip()))
 return out
heads=headings(original);parts=[]
for i,(start,title)in enumerate(heads):
 end=heads[i+1][0]if i+1<len(heads)else len(lines)
 parts.append({'title':title,'text':''.join(lines[start:end]),'start':start+1,'end':end})
assert heads[0][0]==0
mapping=[
 ('any-downcast-ref-analysis.md','any-downcast-ref','Any::downcast_ref：胖指针写入与读回不匹配，临时值复用返回栈槽'),
 ('iter-filter-chain-ref-count-analysis.md','iter-filter-chain-ref-count',None),
 ('str-debug-some-unicode-analysis.md','str-debug-some-unicode',None),
 ('kernel-file-to-file-copy-analysis.md','kernel-file-copy',None),
 ('iter-filter-map-chain-sum-analysis.md','iter-filter-map-chain-sum',None),
 ('slice-swap-usize30-analysis.md','slice-swap-usize30',None),
]
reports={};report_meta=[]
for name,anchor,title in mapping:
 s=(p/name).read_text()
 if title:s=re.sub(r'^# .*', '# '+title,s,count=1)
 s=s.replace('没有提交或推送本次新增材料。','')
 data='analysis/data/'+{
  'any-downcast-ref':'any-downcast-ref-20261104',
  'iter-filter-chain-ref-count':'iter-filter-chain-ref-count-20261105',
  'str-debug-some-unicode':'str-debug-some-unicode-20261105',
  'kernel-file-copy':'kernel-file-copy-20261105',
  'iter-filter-map-chain-sum':'iter-filter-map-chain-sum-20261105',
  'slice-swap-usize30':'slice-swap-usize30-20261105'}[anchor]
 for filename in ['scenario-results.md','scenario-results.csv','related-benchmarks.md']:
  s=s.replace('`'+filename+'`','['+filename+']('+data+'/'+filename+')')
 block='<a id="'+anchor+'"></a>\n\n'+s.rstrip()+'\n\n---\n\n'
 assert len(headings(s))==1,(name,headings(s))
 reports[anchor]=block;report_meta.append({'source':name,'anchor':anchor,'source_sha256':hashlib.sha256((p/name).read_bytes()).hexdigest()})
changes=[];out=[];counts={k:0 for k in reports}
for part in parts:
 t=part['title'];body=part['text'];action=None
 if t.startswith('# `any::bench_downcast_ref`'):
  body=reports['any-downcast-ref'];counts['any-downcast-ref']+=1;action='replace'
 elif t.startswith('# `iter::bench_filter_map_chain_ref_sum`'):
  body=reports['iter-filter-chain-ref-count']+reports['iter-filter-map-chain-sum'];counts['iter-filter-chain-ref-count']+=1;counts['iter-filter-map-chain-sum']+=1;action='replace and insert adjacent iterator analysis'
 elif t.startswith('# `iter::bench_filter_map_ref_sum`'):
  body='';action='merge duplicate mechanism into filter_map chapter'
 elif t.startswith('# `slice::swap_with_slice_usize_30`'):
  body=reports['slice-swap-usize30'];counts['slice-swap-usize30']+=1;action='replace'
 elif t.startswith('# `sys::io::kernel_copy::linux::tests::bench_socket_pipe_socket_copy`'):
  old='- 對照:`bench_file_to_file_copy` 在 x86 btrfs 上 3 428 ns(15 873 cyc/iter),比 tmpfs 快 40%。base.tsv 的 3 512 ns 是這個值。檔案系統不同,不能拿來跨平臺比。'
  new='- `bench_file_to_file_copy` 的文件系统路径、统一周期计数和双平台复测见[文件复制分析](#kernel-file-copy)。本章表格保留该轮对照样本。'
  assert body.count(old)==1;body=body.replace(old,new)
  body=body.rstrip()+'\n\n'+reports['kernel-file-copy'];counts['kernel-file-copy']+=1;action='retain socket analysis, replace file-copy cross-reference, insert file-copy chapter'
 elif t.startswith('# `str::debug::mostly_unicode`'):
  body=body.replace('## 熱點:一個字符要付四次稀疏表查找','## mostly_unicode 的四类 Unicode 属性查询')
  needle='- 分析對象:';ls=body.splitlines(keepends=True)
  for j,l in enumerate(ls):
   if l.startswith(needle):
    ls[j]=l.rstrip()+'。`some_unicode` 的四个拉丁字符只进入 Cf 与 Default_Ignorable 查询，其范围快路径和双平台验证见[常用字符的重复属性查询](#str-debug-some-unicode)。\n';break
  body=''.join(ls);action='scope four-table statement to mostly_unicode and link specific case'
 elif t.startswith('# `str::debug::mixed`'):
  old_title=t
  new_title=t.replace('`str::debug::mixed`(及同族 5 項)','`str::debug::mixed`')
  assert old_title in body;body=body.replace(old_title,new_title,1)
  old='→ 解碼一個 `char` → `escape_debug_ext`(`grapheme_extend`、`cn_planes_0_3`、`cf`、`default_ignorable` 四次稀疏表查找)→'
  new='→ 解码一个 `char` → `escape_debug_ext`（按码位范围进入 `grapheme_extend`、`cn_planes_0_3`、`cf`、`default_ignorable` 查询；`some_unicode` 每字符只进入后两类）→'
  assert old in body;body=body.replace(old,new)
  body=body.replace('- 比值隨非 ASCII 字元數單調上升:0 個(ascii_*)0.94–0.99 → 4 個(some_unicode)1.28 → 21–30 個(mixed / mostly_unicode)1.45–1.55。差距全在查表路徑。','- 上表保留该轮跨机测量。不同输入实际进入的属性表不同；`some_unicode` 的具体路径、分配影响与复测见[常用字符的重复属性查询](#str-debug-some-unicode)，不能仅按非 ASCII 字符数量解释差距。')
  body=body.rstrip()+'\n\n'+reports['str-debug-some-unicode'];counts['str-debug-some-unicode']+=1;action='scope mixed mechanism and insert some_unicode chapter'
 if action:changes.append({'old_title':t,'start':part['start'],'end':part['end'],'action':action})
 out.append(body)
merged=''.join(out)
assert all(v==1 for v in counts.values()),counts
for anchor in reports:assert merged.count('<a id="'+anchor+'"></a>')==1
# Every untouched top-level chapter must be byte-for-byte preserved.
for part,body in zip(parts,out):
 if not any(c['start']==part['start']for c in changes):assert part['text']==body
# The merged reports are full bodies, rather than links to the standalones.
for anchor,block in reports.items():assert block in merged,anchor
assert '# `iter::bench_filter_map_ref_sum`:'not in merged
assert '接口本身只差 1.12–1.14'not in merged
assert '唯一頭寸是 `TypeId` 陣列佈局導致的 sret'not in merged
(p/'benchmarks-conclusion.merged.md').write_text(merged)
manifest={'target':'benchmarks-conclusion.md','before_sha256':hashlib.sha256(original.encode()).hexdigest(),'after_sha256':hashlib.sha256(merged.encode()).hexdigest(),'sources':report_meta,'changes':changes,'before_lines':len(original.splitlines()),'after_lines':len(merged.splitlines()),'chapters_before':len(heads),'chapters_after':len(headings(merged))}
(p/'manifest.json').write_text(json.dumps(manifest,ensure_ascii=False,indent=2))
diff=''.join(difflib.unified_diff(original.splitlines(keepends=True),merged.splitlines(keepends=True),fromfile='benchmarks-conclusion.md.before',tofile='benchmarks-conclusion.md.after'))
(p/'merge.diff').write_text(diff)
print(json.dumps(manifest,ensure_ascii=False,indent=2))
