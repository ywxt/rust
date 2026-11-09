
/tmp/tuple-comparison-20261105/harness-fullflags:     file format elf64-x86-64


Disassembly of section .text:

000000000001d9d0 <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_11bench_match0EBR_>:
   1d9d0:	55                   	push   %rbp
   1d9d1:	41 57                	push   %r15
   1d9d3:	41 56                	push   %r14
   1d9d5:	41 55                	push   %r13
   1d9d7:	41 54                	push   %r12
   1d9d9:	53                   	push   %rbx
   1d9da:	48 83 ec 18          	sub    $0x18,%rsp
   1d9de:	48 89 d3             	mov    %rdx,%rbx
   1d9e1:	49 89 f6             	mov    %rsi,%r14
   1d9e4:	49 89 ff             	mov    %rdi,%r15
   1d9e7:	ff 15 43 98 04 00    	call   *0x49843(%rip)        # 67230 <_RNvMNtCs9wefJfwQbYy_3std4timeNtB2_7Instant3now@Base>
   1d9ed:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
   1d9f2:	89 54 24 10          	mov    %edx,0x10(%rsp)
   1d9f6:	48 85 db             	test   %rbx,%rbx
   1d9f9:	75 64                	jne    1da5f <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_11bench_match0EBR_+0x8f>
   1d9fb:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
   1da00:	ff 15 32 98 04 00    	call   *0x49832(%rip)        # 67238 <_RNvMNtCs9wefJfwQbYy_3std4timeNtB2_7Instant7elapsed@Base>
   1da06:	48 69 c8 00 ca 9a 3b 	imul   $0x3b9aca00,%rax,%rcx
   1da0d:	89 d0                	mov    %edx,%eax
   1da0f:	48 01 c8             	add    %rcx,%rax
   1da12:	48 83 c4 18          	add    $0x18,%rsp
   1da16:	5b                   	pop    %rbx
   1da17:	41 5c                	pop    %r12
   1da19:	41 5d                	pop    %r13
   1da1b:	41 5e                	pop    %r14
   1da1d:	41 5f                	pop    %r15
   1da1f:	5d                   	pop    %rbp
   1da20:	c3                   	ret
   1da21:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   1da28:	0f 1f 84 00 00 00 00 
   1da2f:	00 
   1da30:	4b 8d 04 ef          	lea    (%r15,%r13,8),%rax
   1da34:	49 8b 4c 24 10       	mov    0x10(%r12),%rcx
   1da39:	48 3b 48 10          	cmp    0x10(%rax),%rcx
   1da3d:	0f 97 c0             	seta   %al
   1da40:	1c 00                	sbb    $0x0,%al
   1da42:	48 0f be c0          	movsbq %al,%rax
   1da46:	48 8d 0d af 11 ff ff 	lea    -0xee51(%rip),%rcx        # ebfc <__abi_tag+0xe900>
   1da4d:	8b 44 81 04          	mov    0x4(%rcx,%rax,4),%eax
   1da51:	89 44 24 04          	mov    %eax,0x4(%rsp)
   1da55:	48 8d 44 24 04       	lea    0x4(%rsp),%rax
   1da5a:	48 ff cb             	dec    %rbx
   1da5d:	74 9c                	je     1d9fb <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_11bench_match0EBR_+0x2b>
   1da5f:	41 8b 06             	mov    (%r14),%eax
   1da62:	45 8b 46 04          	mov    0x4(%r14),%r8d
   1da66:	89 c1                	mov    %eax,%ecx
   1da68:	c1 e1 0b             	shl    $0xb,%ecx
   1da6b:	31 c1                	xor    %eax,%ecx
   1da6d:	41 8b 76 08          	mov    0x8(%r14),%esi
   1da71:	41 8b 56 0c          	mov    0xc(%r14),%edx
   1da75:	89 d0                	mov    %edx,%eax
   1da77:	c1 e8 13             	shr    $0x13,%eax
   1da7a:	31 c8                	xor    %ecx,%eax
   1da7c:	c1 e9 08             	shr    $0x8,%ecx
   1da7f:	31 c1                	xor    %eax,%ecx
   1da81:	31 d1                	xor    %edx,%ecx
   1da83:	48 8d 04 09          	lea    (%rcx,%rcx,1),%rax
   1da87:	4c 8d 0c 40          	lea    (%rax,%rax,2),%r9
   1da8b:	4c 89 c8             	mov    %r9,%rax
   1da8e:	48 c1 e8 20          	shr    $0x20,%rax
   1da92:	41 83 f9 fb          	cmp    $0xfffffffb,%r9d
   1da96:	72 58                	jb     1daf0 <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_11bench_match0EBR_+0x120>
   1da98:	45 89 c2             	mov    %r8d,%r10d
   1da9b:	41 c1 e2 0b          	shl    $0xb,%r10d
   1da9f:	45 31 c2             	xor    %r8d,%r10d
   1daa2:	41 89 36             	mov    %esi,(%r14)
   1daa5:	41 89 56 04          	mov    %edx,0x4(%r14)
   1daa9:	41 89 4e 08          	mov    %ecx,0x8(%r14)
   1daad:	41 89 c8             	mov    %ecx,%r8d
   1dab0:	41 c1 e8 13          	shr    $0x13,%r8d
   1dab4:	44 89 d7             	mov    %r10d,%edi
   1dab7:	c1 ef 08             	shr    $0x8,%edi
   1daba:	44 31 d7             	xor    %r10d,%edi
   1dabd:	31 cf                	xor    %ecx,%edi
   1dabf:	44 31 c7             	xor    %r8d,%edi
   1dac2:	41 89 7e 0c          	mov    %edi,0xc(%r14)
   1dac6:	4c 8d 04 3f          	lea    (%rdi,%rdi,1),%r8
   1daca:	4f 8d 04 40          	lea    (%r8,%r8,2),%r8
   1dace:	49 c1 e8 20          	shr    $0x20,%r8
   1dad2:	45 01 c1             	add    %r8d,%r9d
   1dad5:	48 83 d0 00          	adc    $0x0,%rax
   1dad9:	48 83 f8 06          	cmp    $0x6,%rax
   1dadd:	72 1a                	jb     1daf9 <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_11bench_match0EBR_+0x129>
   1dadf:	e9 e8 00 00 00       	jmp    1dbcc <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_11bench_match0EBR_+0x1fc>
   1dae4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
   1daeb:	00 00 00 00 00 
   1daf0:	89 cf                	mov    %ecx,%edi
   1daf2:	89 d1                	mov    %edx,%ecx
   1daf4:	89 f2                	mov    %esi,%edx
   1daf6:	44 89 c6             	mov    %r8d,%esi
   1daf9:	41 89 f1             	mov    %esi,%r9d
   1dafc:	41 c1 e1 0b          	shl    $0xb,%r9d
   1db00:	41 31 f1             	xor    %esi,%r9d
   1db03:	41 89 16             	mov    %edx,(%r14)
   1db06:	41 89 4e 04          	mov    %ecx,0x4(%r14)
   1db0a:	41 89 7e 08          	mov    %edi,0x8(%r14)
   1db0e:	89 fe                	mov    %edi,%esi
   1db10:	c1 ee 13             	shr    $0x13,%esi
   1db13:	45 89 c8             	mov    %r9d,%r8d
   1db16:	41 c1 e8 08          	shr    $0x8,%r8d
   1db1a:	41 31 f8             	xor    %edi,%r8d
   1db1d:	41 31 f0             	xor    %esi,%r8d
   1db20:	45 31 c8             	xor    %r9d,%r8d
   1db23:	45 89 46 0c          	mov    %r8d,0xc(%r14)
   1db27:	4b 8d 34 00          	lea    (%r8,%r8,1),%rsi
   1db2b:	4c 8d 0c 76          	lea    (%rsi,%rsi,2),%r9
   1db2f:	4c 89 ce             	mov    %r9,%rsi
   1db32:	48 c1 ee 20          	shr    $0x20,%rsi
   1db36:	41 83 f9 fb          	cmp    $0xfffffffb,%r9d
   1db3a:	72 44                	jb     1db80 <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_11bench_match0EBR_+0x1b0>
   1db3c:	41 89 d2             	mov    %edx,%r10d
   1db3f:	41 c1 e2 0b          	shl    $0xb,%r10d
   1db43:	41 31 d2             	xor    %edx,%r10d
   1db46:	41 89 0e             	mov    %ecx,(%r14)
   1db49:	41 89 7e 04          	mov    %edi,0x4(%r14)
   1db4d:	45 89 46 08          	mov    %r8d,0x8(%r14)
   1db51:	44 89 d1             	mov    %r10d,%ecx
   1db54:	c1 e9 08             	shr    $0x8,%ecx
   1db57:	44 31 d1             	xor    %r10d,%ecx
   1db5a:	44 31 c1             	xor    %r8d,%ecx
   1db5d:	41 c1 e8 13          	shr    $0x13,%r8d
   1db61:	41 31 c8             	xor    %ecx,%r8d
   1db64:	45 89 46 0c          	mov    %r8d,0xc(%r14)
   1db68:	4d 01 c0             	add    %r8,%r8
   1db6b:	4b 8d 0c 40          	lea    (%r8,%r8,2),%rcx
   1db6f:	48 c1 e9 20          	shr    $0x20,%rcx
   1db73:	41 01 c9             	add    %ecx,%r9d
   1db76:	48 83 d6 00          	adc    $0x0,%rsi
   1db7a:	48 83 fe 06          	cmp    $0x6,%rsi
   1db7e:	73 4c                	jae    1dbcc <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_11bench_match0EBR_+0x1fc>
   1db80:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
   1db84:	4d 8d 24 c7          	lea    (%r15,%rax,8),%r12
   1db88:	4c 8d 2c 76          	lea    (%rsi,%rsi,2),%r13
   1db8c:	49 8b 3c 24          	mov    (%r12),%rdi
   1db90:	49 8b 44 24 08       	mov    0x8(%r12),%rax
   1db95:	4b 8b 34 ef          	mov    (%r15,%r13,8),%rsi
   1db99:	4b 8b 54 ef 08       	mov    0x8(%r15,%r13,8),%rdx
   1db9e:	48 89 c5             	mov    %rax,%rbp
   1dba1:	48 29 d5             	sub    %rdx,%rbp
   1dba4:	48 0f 42 d0          	cmovb  %rax,%rdx
   1dba8:	ff 15 92 96 04 00    	call   *0x49692(%rip)        # 67240 <memcmp@GLIBC_2.2.5>
   1dbae:	48 98                	cltq
   1dbb0:	85 c0                	test   %eax,%eax
   1dbb2:	48 0f 45 e8          	cmovne %rax,%rbp
   1dbb6:	48 85 ed             	test   %rbp,%rbp
   1dbb9:	0f 98 c1             	sets   %cl
   1dbbc:	0f 9f c0             	setg   %al
   1dbbf:	0f 84 6b fe ff ff    	je     1da30 <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_11bench_match0EBR_+0x60>
   1dbc5:	28 c8                	sub    %cl,%al
   1dbc7:	e9 76 fe ff ff       	jmp    1da42 <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_11bench_match0EBR_+0x72>
   1dbcc:	48 8d 15 f5 41 04 00 	lea    0x441f5(%rip),%rdx        # 61dc8 <__frame_dummy_init_array_entry+0x50>
   1dbd3:	bf 06 00 00 00       	mov    $0x6,%edi
   1dbd8:	be 06 00 00 00       	mov    $0x6,%esi
   1dbdd:	ff 15 65 96 04 00    	call   *0x49665(%rip)        # 67248 <_RNvNtCs6knCYbIatyh_4core9panicking18panic_bounds_check@Base>

Disassembly of section .init:

Disassembly of section .fini:

Disassembly of section .plt:
