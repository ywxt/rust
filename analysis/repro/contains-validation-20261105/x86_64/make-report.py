import json,pathlib,statistics
r=pathlib.Path(__file__).resolve().parent;d=json.loads((r/'comparison.json').read_text())
s='''

# `contains` 优化适用范围复验：其他基准、长度与命中分布（2026-11-05）

这是上一节77.6%结果的扩展验证，仍为个人实验，未修改生产标准库、未添加 inline 属性。77.6%仅属于原始2551 B长串末尾命中及相应构建条件，不应作为 contains 的普遍收益。

## 其他现有 benchmark：先确认是否适用

另测缓存 alloсtests str.rs 中8个 `bench_contains_*`，每个原始 libtest benchmark在两端各跑三次，绑核与工具链同上一节。它们的 needle 均为多字节子串，前一节固定 ASCII `!` 的布尔扫描原型不能保持其语义，故不将这些基准的结果计为原型收益，也没有伪造“修改后”对照。

| benchmark 后缀 | needle | ARM ns | x86 ns | ARM cycles估计 | x86 cycles估计 | ARM/x86 cycles |
| --- | --- | ---: | ---: | ---: | ---: | ---: |
'''
needles={'short_short':'sit','2b_repeated_long':'::','short_long':'english','16b_in_long':'english language','32b_in_long':'the english language sample text','bad_naive':'aaaaaaaab','bad_simd':'aaabaaaa','equal':'与haystack相同'}
a=json.loads((r/'arm-existing-results.json').read_text());x=json.loads((r/'existing-results.json').read_text())
for k in needles:
 av=[v for v in a if v['bench']==k];xv=[v for v in x if v['bench']==k];an=statistics.median(v['ns'] for v in av);xn=statistics.median(v['ns'] for v in xv);ac=statistics.median(v['cycles_est'] for v in av);xc=statistics.median(v['cycles_est'] for v in xv)
 s+=f'| {k} | `{needles[k]}` | {an:.2f} | {xn:.2f} | {ac:.2f} | {xc:.2f} | {ac/xc:.3f} |\n'
s+='''
这些 cycles 仍用 libtest ns×perf cycles/task-clock 估算，原始输出全部保留。长串多字节未命中的 cycles 比约2.02–2.08，其差距尚未由本次原型解决。源码的多字节路径已有 NEON/SSE2 的 simd_contains，并有退化检查和其他搜索分支；不能把前节单字节 SWAR 的归因直接套用到这里。本次未对这8项提出已验证修改方法。

## 同一单字节语义的扩展性能矩阵

独立完整源码 matrix.rs 保留前节 std_str、simd64、align64_scan64 的函数体，增加控制输入。长度为8、16、32、63、64、65、127、128、256、2551、65536 B；地址 mod64为0/1/16；命中位置为首、中、尾或不命中。共132个场景，三个方法交错测量，每项三轮，每台1188条 perf 记录。

输入为ASCII x填充并按位置插入唯一 `!`，不是原始 lorem 文本；每次查询统一 black_box 输入和输出，运行时选择函数指针，结果累计并校验。输入准备、UTF-8校验、分配在查询循环外，但PMU统计整个子进程，再除以已知N，因此仍包含少量一次性准备成本与调用/屏障成本。N按长度变化，短串最高300万次，长串最低1万次；详细N记录于JSON。对同一场景三方法使用相同N。仅为热缓存、固定重复输入；未测随机交替命中、流式冷数据、多字节needle或非ASCII needle。

两端汇编保留每次查询的间接调用与输入/结果屏障，无常数结果提升；此前 hoisting 问题未复现。所有实际计数的PMU事件运行比例100%，原始输出含context-switches/cpu-migrations。统计为三轮中位数，同时归档min/max，未将该探针的绝对cycles与上一节libtest估计值混用。

以下为代表场景，cycles/调用（三轮中位数）：

| 长度/偏移/分布 | ARM 标准 | ARM SIMD | ARM 对齐SIMD | x86 标准 | x86 SIMD | x86 对齐SIMD |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
'''
selected=[(8,0,'absent'),(8,0,'front'),(32,0,'last'),(128,0,'front'),(128,1,'last'),(2551,1,'absent'),(65536,1,'absent')]
for le,off,dist in selected:
 vals=[]
 for arch in ['aarch64','x86_64']:
  v=next(v for v in d[arch] if (v['length'],v['offset'],v['distribution'])==(le,off,dist));vals.extend(f"{v[m]['cycles']:.2f}" for m in ['std','simd','align'])
 s+=f'| {le}/{off}/{dist} | '+' | '.join(vals)+' |\n'
s+='''
验证后的边界：

- 8 B不能保证收益：ARM最差14.24→19.21 cycles（慢34.9%），x86最差7.57→9.41（慢24.3%）。此时长度<128，根本不执行主体对齐；回退属于原型短串路径和入口成本，不能归因于64 B对齐。ARM该8 B未命中原型三轮范围17.67–19.21，基线14.24–14.35，回退方向明确；x86短串离散程度更高，保留范围而不把小差异当作机制证据。
- 本矩阵16 B及以上共120个场景，align64原型均快于标准路径：ARM cycles降33.3%–81.5%，x86降44.3%–85.5%。这是已测固定输入矩阵的范围，不能扩写为任意16 B以上输入都有该收益。
- 与直接SIMD比较，对齐的收益有条件。128 B、偏移1、末尾命中时，ARM直接SIMD10.59→对齐15.69 cycles，慢约48.2%；额外前缀/对齐成本占比很大。2551 B、偏移1、未命中时，ARM190.74→150.20（降21.3%），但x86 134.87→147.30（慢9.2%）。64 KiB、偏移1、未命中时两端对齐均改善，见上表。
- 首字节命中要说明比较对象：128 B、偏移0时ARM对齐8.24比直接SIMD7.24慢，但仍比标准13.25快；x86同样是9.13比6.96慢、比标准17.77快。“对齐回退”不等于“相对标准contains一定回退”。

因此，已验证的是“布尔SIMD在本次多数单字节场景有效”，不是“64 B对齐总是最好”。若后续尝试通用实现，应单独验证更短输入保留标准路径、对齐阈值与前缀策略；本次没有测试这些新修改，不将它们写成已验证方案。多字节子串需要独立分析和实现。

正确性：最终 matrix.rs 在两端各通过204,288次对照，覆盖0..260及511/512/513/2551/65536长度、64种偏移及未命中/首/中/尾，对三个方法逐项比对标准结果。前节Unicode正确性结果仍单独保留；本次性能矩阵均为ASCII。

## 复现与证据

两端 `/tmp/contains-validation-20261105/` 为运行目录；持久归档在远程仓库 `analysis/repro/contains-validation-20261105/{aarch64,x86_64}/`。双平台汇总为comparison.json，132个场景均有三方法中位数、min/max及其他计数；原始1188个perf日志和8个现有benchmark三轮日志全部保存。

```sh
python3 build.py                 # 同一工具链构建，输出IR/汇编并跑正确性检查
python3 run-existing.py          # 8个原始libtest，三轮
python3 run-matrix.py            # 132场景×3方法×3轮；与上一命令串行运行
```

脚本自动绑ARM核52/x86 P核12，为perf清除外层LD_LIBRARY_PATH，为子进程设置对应动态库；依赖两端既有 `/tmp/xdiff/{rustc,libdir,bins}.txt` 与缓存工具链。编译参数与上一节相同，未指定target-cpu、未新增inline属性。每台environment.json引用紧邻的前节同机同工具链环境记录，build.log保存实际编译命令。source SHA与原始bench源码存于provenance.json；matrix.rs、matrix.ll、matrix.s、check.log、matrix-config.json、matrix-complete.json和全部原始测量可复核。此次未修改生产源码、未提交或推送。
'''
(r/'report-section.md').write_text(s.replace('alloсtests','alloctests'))
print('report lines',len(s.splitlines()))
