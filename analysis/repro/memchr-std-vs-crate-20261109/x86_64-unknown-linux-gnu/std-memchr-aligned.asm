
/tmp/memchr-std-crate-20261109/sysroot/lib/rustlib/x86_64-unknown-linux-gnu/lib/libstd-320fe7036dd8354d.so:     file format elf64-x86-64


Disassembly of section .text:

00000000001148e0 <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14memchr_aligned>:
  1148e0:	41 56                	push   %r14
  1148e2:	53                   	push   %rbx
  1148e3:	48 89 d1             	mov    %rdx,%rcx
  1148e6:	48 8d 56 07          	lea    0x7(%rsi),%rdx
  1148ea:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
  1148ee:	48 29 f2             	sub    %rsi,%rdx
  1148f1:	75 08                	jne    1148fb <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14memchr_aligned+0x1b>
  1148f3:	48 8d 41 f0          	lea    -0x10(%rcx),%rax
  1148f7:	31 d2                	xor    %edx,%edx
  1148f9:	eb 30                	jmp    11492b <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14memchr_aligned+0x4b>
  1148fb:	48 39 d1             	cmp    %rdx,%rcx
  1148fe:	48 0f 42 d1          	cmovb  %rcx,%rdx
  114902:	48 85 c9             	test   %rcx,%rcx
  114905:	74 1b                	je     114922 <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14memchr_aligned+0x42>
  114907:	45 31 c0             	xor    %r8d,%r8d
  11490a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  114910:	42 38 3c 06          	cmp    %dil,(%rsi,%r8,1)
  114914:	0f 84 91 00 00 00    	je     1149ab <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14memchr_aligned+0xcb>
  11491a:	49 ff c0             	inc    %r8
  11491d:	4c 39 c2             	cmp    %r8,%rdx
  114920:	75 ee                	jne    114910 <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14memchr_aligned+0x30>
  114922:	48 8d 41 f0          	lea    -0x10(%rcx),%rax
  114926:	48 39 c2             	cmp    %rax,%rdx
  114929:	77 5a                	ja     114985 <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14memchr_aligned+0xa5>
  11492b:	49 b8 80 80 80 80 80 	movabs $0x8080808080808080,%r8
  114932:	80 80 80 
  114935:	49 b9 00 01 01 01 01 	movabs $0x101010101010100,%r9
  11493c:	01 01 01 
  11493f:	44 0f b6 df          	movzbl %dil,%r11d
  114943:	4d 8d 51 01          	lea    0x1(%r9),%r10
  114947:	4d 0f af d3          	imul   %r11,%r10
  11494b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  114950:	4c 8b 1c 16          	mov    (%rsi,%rdx,1),%r11
  114954:	4d 31 d3             	xor    %r10,%r11
  114957:	4c 89 cb             	mov    %r9,%rbx
  11495a:	4c 29 db             	sub    %r11,%rbx
  11495d:	4c 09 db             	or     %r11,%rbx
  114960:	4c 8b 5c 16 08       	mov    0x8(%rsi,%rdx,1),%r11
  114965:	4d 31 d3             	xor    %r10,%r11
  114968:	4d 89 ce             	mov    %r9,%r14
  11496b:	4d 29 de             	sub    %r11,%r14
  11496e:	4d 09 de             	or     %r11,%r14
  114971:	4c 21 c3             	and    %r8,%rbx
  114974:	4c 21 f3             	and    %r14,%rbx
  114977:	4c 39 c3             	cmp    %r8,%rbx
  11497a:	75 09                	jne    114985 <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14memchr_aligned+0xa5>
  11497c:	48 83 c2 10          	add    $0x10,%rdx
  114980:	48 39 c2             	cmp    %rax,%rdx
  114983:	76 cb                	jbe    114950 <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14memchr_aligned+0x70>
  114985:	31 c0                	xor    %eax,%eax
  114987:	48 39 d1             	cmp    %rdx,%rcx
  11498a:	74 12                	je     11499e <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14memchr_aligned+0xbe>
  11498c:	0f 1f 40 00          	nopl   0x0(%rax)
  114990:	40 38 3c 16          	cmp    %dil,(%rsi,%rdx,1)
  114994:	74 0c                	je     1149a2 <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14memchr_aligned+0xc2>
  114996:	48 ff c2             	inc    %rdx
  114999:	48 39 d1             	cmp    %rdx,%rcx
  11499c:	75 f2                	jne    114990 <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14memchr_aligned+0xb0>
  11499e:	5b                   	pop    %rbx
  11499f:	41 5e                	pop    %r14
  1149a1:	c3                   	ret
  1149a2:	b8 01 00 00 00       	mov    $0x1,%eax
  1149a7:	5b                   	pop    %rbx
  1149a8:	41 5e                	pop    %r14
  1149aa:	c3                   	ret
  1149ab:	b8 01 00 00 00       	mov    $0x1,%eax
  1149b0:	4c 89 c2             	mov    %r8,%rdx
  1149b3:	5b                   	pop    %rbx
  1149b4:	41 5e                	pop    %r14
  1149b6:	c3                   	ret

Disassembly of section .init:

Disassembly of section .fini:

Disassembly of section .plt:
