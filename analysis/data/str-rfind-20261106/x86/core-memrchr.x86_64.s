
/tmp/contains-bad-simd-20261105/sysroots/baseline/lib/rustlib/x86_64-unknown-linux-gnu/lib/libstd-320fe7036dd8354d.so:     file format elf64-x86-64


Disassembly of section .text:

0000000000114bf0 <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr7memrchr>:
  114bf0:	55                   	push   %rbp
  114bf1:	48 89 e5             	mov    %rsp,%rbp
  114bf4:	41 57                	push   %r15
  114bf6:	41 56                	push   %r14
  114bf8:	53                   	push   %rbx
  114bf9:	50                   	push   %rax
  114bfa:	4c 8d 46 07          	lea    0x7(%rsi),%r8
  114bfe:	49 83 e0 f8          	and    $0xfffffffffffffff8,%r8
  114c02:	49 29 f0             	sub    %rsi,%r8
  114c05:	48 89 d0             	mov    %rdx,%rax
  114c08:	48 89 d1             	mov    %rdx,%rcx
  114c0b:	4c 39 c2             	cmp    %r8,%rdx
  114c0e:	72 17                	jb     114c27 <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr7memrchr+0x37>
  114c10:	89 d1                	mov    %edx,%ecx
  114c12:	44 29 c1             	sub    %r8d,%ecx
  114c15:	83 e1 0f             	and    $0xf,%ecx
  114c18:	48 89 d0             	mov    %rdx,%rax
  114c1b:	48 29 c8             	sub    %rcx,%rax
  114c1e:	0f 82 e3 00 00 00    	jb     114d07 <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr7memrchr+0x117>
  114c24:	4c 89 c1             	mov    %r8,%rcx
  114c27:	48 39 d0             	cmp    %rdx,%rax
  114c2a:	74 2e                	je     114c5a <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr7memrchr+0x6a>
  114c2c:	4c 8d 42 ff          	lea    -0x1(%rdx),%r8
  114c30:	49 89 c1             	mov    %rax,%r9
  114c33:	49 f7 d9             	neg    %r9
  114c36:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  114c3d:	00 00 00 
  114c40:	42 38 3c 06          	cmp    %dil,(%rsi,%r8,1)
  114c44:	0f 84 94 00 00 00    	je     114cde <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr7memrchr+0xee>
  114c4a:	4f 8d 14 01          	lea    (%r9,%r8,1),%r10
  114c4e:	49 ff ca             	dec    %r10
  114c51:	49 ff c8             	dec    %r8
  114c54:	49 83 fa ff          	cmp    $0xffffffffffffffff,%r10
  114c58:	75 e6                	jne    114c40 <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr7memrchr+0x50>
  114c5a:	49 b9 80 80 80 80 80 	movabs $0x8080808080808080,%r9
  114c61:	80 80 80 
  114c64:	49 ba 00 01 01 01 01 	movabs $0x101010101010100,%r10
  114c6b:	01 01 01 
  114c6e:	44 0f b6 c7          	movzbl %dil,%r8d
  114c72:	4d 8d 5a 01          	lea    0x1(%r10),%r11
  114c76:	4d 0f af d8          	imul   %r8,%r11
  114c7a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  114c80:	49 89 c0             	mov    %rax,%r8
  114c83:	48 39 c8             	cmp    %rcx,%rax
  114c86:	76 31                	jbe    114cb9 <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr7memrchr+0xc9>
  114c88:	49 8d 40 f0          	lea    -0x10(%r8),%rax
  114c8c:	4a 8b 5c 06 f0       	mov    -0x10(%rsi,%r8,1),%rbx
  114c91:	4c 31 db             	xor    %r11,%rbx
  114c94:	4d 89 d6             	mov    %r10,%r14
  114c97:	49 29 de             	sub    %rbx,%r14
  114c9a:	49 09 de             	or     %rbx,%r14
  114c9d:	4a 8b 5c 06 f8       	mov    -0x8(%rsi,%r8,1),%rbx
  114ca2:	4c 31 db             	xor    %r11,%rbx
  114ca5:	4d 89 d7             	mov    %r10,%r15
  114ca8:	49 29 df             	sub    %rbx,%r15
  114cab:	49 09 df             	or     %rbx,%r15
  114cae:	4d 21 ce             	and    %r9,%r14
  114cb1:	4d 21 fe             	and    %r15,%r14
  114cb4:	4d 39 ce             	cmp    %r9,%r14
  114cb7:	74 c7                	je     114c80 <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr7memrchr+0x90>
  114cb9:	49 39 d0             	cmp    %rdx,%r8
  114cbc:	77 37                	ja     114cf5 <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr7memrchr+0x105>
  114cbe:	4d 85 c0             	test   %r8,%r8
  114cc1:	74 22                	je     114ce5 <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr7memrchr+0xf5>
  114cc3:	49 ff c8             	dec    %r8
  114cc6:	31 c0                	xor    %eax,%eax
  114cc8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  114ccf:	00 
  114cd0:	42 38 3c 06          	cmp    %dil,(%rsi,%r8,1)
  114cd4:	74 08                	je     114cde <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr7memrchr+0xee>
  114cd6:	49 83 c0 ff          	add    $0xffffffffffffffff,%r8
  114cda:	72 f4                	jb     114cd0 <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr7memrchr+0xe0>
  114cdc:	eb 09                	jmp    114ce7 <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr7memrchr+0xf7>
  114cde:	b8 01 00 00 00       	mov    $0x1,%eax
  114ce3:	eb 02                	jmp    114ce7 <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr7memrchr+0xf7>
  114ce5:	31 c0                	xor    %eax,%eax
  114ce7:	4c 89 c2             	mov    %r8,%rdx
  114cea:	48 83 c4 08          	add    $0x8,%rsp
  114cee:	5b                   	pop    %rbx
  114cef:	41 5e                	pop    %r14
  114cf1:	41 5f                	pop    %r15
  114cf3:	5d                   	pop    %rbp
  114cf4:	c3                   	ret
  114cf5:	48 8d 0d d4 b0 01 00 	lea    0x1b0d4(%rip),%rcx        # 12fdd0 <_RNvNtCs341anU20NIK_3std9panicking11EMPTY_PANIC+0x5b40>
  114cfc:	31 ff                	xor    %edi,%edi
  114cfe:	4c 89 c6             	mov    %r8,%rsi
  114d01:	ff 15 99 c4 01 00    	call   *0x1c499(%rip)        # 1311a0 <_RNvNtNtCsc9NCSoc2doQ_4core5slice5index16slice_index_fail@@Base+0x1c760>
  114d07:	48 8d 0d da b0 01 00 	lea    0x1b0da(%rip),%rcx        # 12fde8 <_RNvNtCs341anU20NIK_3std9panicking11EMPTY_PANIC+0x5b58>
  114d0e:	48 89 c7             	mov    %rax,%rdi
  114d11:	48 89 d6             	mov    %rdx,%rsi
  114d14:	ff 15 86 c4 01 00    	call   *0x1c486(%rip)        # 1311a0 <_RNvNtNtCsc9NCSoc2doQ_4core5slice5index16slice_index_fail@@Base+0x1c760>

Disassembly of section .init:

Disassembly of section .fini:

Disassembly of section .plt:
