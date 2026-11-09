
/nix/store/lm3pknxi0ipypy3lxh1wmm8wvvavdwrn-glibc-2.42-84/lib/libc.so.6:     file format elf64-x86-64


Disassembly of section .plt:

Disassembly of section .plt.got:

Disassembly of section .plt.sec:

Disassembly of section .text:

00000000000aeed0 <__libc_free>:
   aeed0:	f3 0f 1e fa          	endbr64
   aeed4:	48 85 ff             	test   %rdi,%rdi
   aeed7:	0f 84 9b 01 00 00    	je     af078 <__libc_free+0x1a8>
   aeedd:	40 f6 c7 0f          	test   $0xf,%dil
   aeee1:	0f 85 81 01 00 00    	jne    af068 <__libc_free+0x198>
   aeee7:	4c 8b 57 f8          	mov    -0x8(%rdi),%r10
   aeeeb:	4d 89 d1             	mov    %r10,%r9
   aeeee:	49 83 e1 f8          	and    $0xfffffffffffffff8,%r9
   aeef2:	4c 3b 0d f7 b2 14 00 	cmp    0x14b2f7(%rip),%r9        # 1fa1f0 <mp_+0x70>
   aeef9:	0f 83 81 00 00 00    	jae    aef80 <__libc_free+0xb0>
   aeeff:	48 8b 05 7a ae 14 00 	mov    0x14ae7a(%rip),%rax        # 1f9d80 <_GLOBAL_OFFSET_TABLE_+0x220>
   aef06:	64 48 8b 00          	mov    %fs:(%rax),%rax
   aef0a:	48 85 c0             	test   %rax,%rax
   aef0d:	74 71                	je     aef80 <__libc_free+0xb0>
   aef0f:	4c 8b 05 ea 22 15 00 	mov    0x1522ea(%rip),%r8        # 201200 <tcache_key>
   aef16:	4c 39 47 08          	cmp    %r8,0x8(%rdi)
   aef1a:	0f 84 70 01 00 00    	je     af090 <__libc_free+0x1c0>
   aef20:	49 8d 51 e0          	lea    -0x20(%r9),%rdx
   aef24:	48 89 d1             	mov    %rdx,%rcx
   aef27:	48 c1 e9 04          	shr    $0x4,%rcx
   aef2b:	48 81 fa ff 03 00 00 	cmp    $0x3ff,%rdx
   aef32:	0f 87 80 00 00 00    	ja     aefb8 <__libc_free+0xe8>
   aef38:	0f b7 34 48          	movzwl (%rax,%rcx,2),%esi
   aef3c:	66 85 f6             	test   %si,%si
   aef3f:	74 43                	je     aef84 <__libc_free+0xb4>
   aef41:	48 89 fa             	mov    %rdi,%rdx
   aef44:	83 ee 01             	sub    $0x1,%esi
   aef47:	4c 89 47 08          	mov    %r8,0x8(%rdi)
   aef4b:	48 c1 ea 0c          	shr    $0xc,%rdx
   aef4f:	48 33 94 c8 98 00 00 	xor    0x98(%rax,%rcx,8),%rdx
   aef56:	00 
   aef57:	48 89 17             	mov    %rdx,(%rdi)
   aef5a:	48 89 bc c8 98 00 00 	mov    %rdi,0x98(%rax,%rcx,8)
   aef61:	00 
   aef62:	66 89 34 48          	mov    %si,(%rax,%rcx,2)
   aef66:	31 c0                	xor    %eax,%eax
   aef68:	31 d2                	xor    %edx,%edx
   aef6a:	31 c9                	xor    %ecx,%ecx
   aef6c:	31 f6                	xor    %esi,%esi
   aef6e:	31 ff                	xor    %edi,%edi
   aef70:	45 31 c0             	xor    %r8d,%r8d
   aef73:	45 31 c9             	xor    %r9d,%r9d
   aef76:	45 31 d2             	xor    %r10d,%r10d
   aef79:	45 31 db             	xor    %r11d,%r11d
   aef7c:	c3                   	ret
   aef7d:	0f 1f 00             	nopl   (%rax)
   aef80:	49 8d 51 e0          	lea    -0x20(%r9),%rdx
   aef84:	48 8d 77 f0          	lea    -0x10(%rdi),%rsi
   aef88:	48 01 f2             	add    %rsi,%rdx
   aef8b:	0f 82 37 01 00 00    	jb     af0c8 <__libc_free+0x1f8>
   aef91:	41 83 e2 04          	and    $0x4,%r10d
   aef95:	48 8d 3d 24 bb 14 00 	lea    0x14bb24(%rip),%rdi        # 1faac0 <main_arena>
   aef9c:	74 0c                	je     aefaa <__libc_free+0xda>
   aef9e:	48 89 f0             	mov    %rsi,%rax
   aefa1:	48 25 00 00 00 fc    	and    $0xfffffffffc000000,%rax
   aefa7:	48 8b 38             	mov    (%rax),%rdi
   aefaa:	31 c9                	xor    %ecx,%ecx
   aefac:	4c 89 ca             	mov    %r9,%rdx
   aefaf:	e9 ec cc ff ff       	jmp    abca0 <_int_free_chunk>
   aefb4:	0f 1f 40 00          	nopl   0x0(%rax)
   aefb8:	4c 89 d1             	mov    %r10,%rcx
   aefbb:	48 d1 e9             	shr    $1,%rcx
   aefbe:	49 83 f9 1f          	cmp    $0x1f,%r9
   aefc2:	f7 d1                	not    %ecx
   aefc4:	40 0f 97 c6          	seta   %sil
   aefc8:	40 20 f1             	and    %sil,%cl
   aefcb:	74 b7                	je     aef84 <__libc_free+0xb4>
   aefcd:	41 0f bd f1          	bsr    %r9d,%esi
   aefd1:	83 c6 36             	add    $0x36,%esi
   aefd4:	48 63 f6             	movslq %esi,%rsi
   aefd7:	44 0f b7 1c 70       	movzwl (%rax,%rsi,2),%r11d
   aefdc:	66 45 85 db          	test   %r11w,%r11w
   aefe0:	74 a2                	je     aef84 <__libc_free+0xb4>
   aefe2:	55                   	push   %rbp
   aefe3:	4c 8d 94 f0 98 00 00 	lea    0x98(%rax,%rsi,8),%r10
   aefea:	00 
   aefeb:	48 89 e5             	mov    %rsp,%rbp
   aefee:	41 56                	push   %r14
   aeff0:	45 31 f6             	xor    %r14d,%r14d
   aeff3:	53                   	push   %rbx
   aeff4:	48 8b 94 f0 98 00 00 	mov    0x98(%rax,%rsi,8),%rdx
   aeffb:	00 
   aeffc:	48 85 d2             	test   %rdx,%rdx
   aefff:	0f 84 90 00 00 00    	je     af095 <__libc_free+0x1c5>
   af005:	48 8b 5a f8          	mov    -0x8(%rdx),%rbx
   af009:	48 83 e3 f8          	and    $0xfffffffffffffff8,%rbx
   af00d:	4c 39 cb             	cmp    %r9,%rbx
   af010:	0f 82 95 00 00 00    	jb     af0ab <__libc_free+0x1db>
   af016:	4c 89 47 08          	mov    %r8,0x8(%rdi)
   af01a:	45 84 f6             	test   %r14b,%r14b
   af01d:	74 7a                	je     af099 <__libc_free+0x1c9>
   af01f:	49 8b 0a             	mov    (%r10),%rcx
   af022:	4c 89 d2             	mov    %r10,%rdx
   af025:	49 89 f8             	mov    %rdi,%r8
   af028:	48 c1 ea 0c          	shr    $0xc,%rdx
   af02c:	49 c1 e8 0c          	shr    $0xc,%r8
   af030:	48 31 d1             	xor    %rdx,%rcx
   af033:	48 31 fa             	xor    %rdi,%rdx
   af036:	4c 31 c1             	xor    %r8,%rcx
   af039:	48 89 0f             	mov    %rcx,(%rdi)
   af03c:	49 89 12             	mov    %rdx,(%r10)
   af03f:	41 83 eb 01          	sub    $0x1,%r11d
   af043:	66 44 89 1c 70       	mov    %r11w,(%rax,%rsi,2)
   af048:	5b                   	pop    %rbx
   af049:	41 5e                	pop    %r14
   af04b:	5d                   	pop    %rbp
   af04c:	31 c0                	xor    %eax,%eax
   af04e:	31 d2                	xor    %edx,%edx
   af050:	31 c9                	xor    %ecx,%ecx
   af052:	31 f6                	xor    %esi,%esi
   af054:	31 ff                	xor    %edi,%edi
   af056:	45 31 c0             	xor    %r8d,%r8d
   af059:	45 31 c9             	xor    %r9d,%r9d
   af05c:	45 31 d2             	xor    %r10d,%r10d
   af05f:	45 31 db             	xor    %r11d,%r11d
   af062:	c3                   	ret
   af063:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   af068:	48 8d 3d ca 41 11 00 	lea    0x1141ca(%rip),%rdi        # 1c3239 <null+0x1093>
   af06f:	e9 ac aa ff ff       	jmp    a9b20 <malloc_printerr_tail>
   af074:	0f 1f 40 00          	nopl   0x0(%rax)
   af078:	31 c0                	xor    %eax,%eax
   af07a:	31 d2                	xor    %edx,%edx
   af07c:	31 c9                	xor    %ecx,%ecx
   af07e:	31 f6                	xor    %esi,%esi
   af080:	31 ff                	xor    %edi,%edi
   af082:	45 31 c0             	xor    %r8d,%r8d
   af085:	45 31 c9             	xor    %r9d,%r9d
   af088:	45 31 d2             	xor    %r10d,%r10d
   af08b:	45 31 db             	xor    %r11d,%r11d
   af08e:	c3                   	ret
   af08f:	90                   	nop
   af090:	e9 ab 01 00 00       	jmp    af240 <tcache_double_free_verify>
   af095:	4c 89 47 08          	mov    %r8,0x8(%rdi)
   af099:	48 89 fa             	mov    %rdi,%rdx
   af09c:	48 c1 ea 0c          	shr    $0xc,%rdx
   af0a0:	49 33 12             	xor    (%r10),%rdx
   af0a3:	48 89 17             	mov    %rdx,(%rdi)
   af0a6:	49 89 3a             	mov    %rdi,(%r10)
   af0a9:	eb 94                	jmp    af03f <__libc_free+0x16f>
   af0ab:	48 89 d3             	mov    %rdx,%rbx
   af0ae:	49 89 d2             	mov    %rdx,%r10
   af0b1:	48 8b 12             	mov    (%rdx),%rdx
   af0b4:	48 c1 eb 0c          	shr    $0xc,%rbx
   af0b8:	48 31 da             	xor    %rbx,%rdx
   af0bb:	49 3b 1a             	cmp    (%r10),%rbx
   af0be:	74 14                	je     af0d4 <__libc_free+0x204>
   af0c0:	41 89 ce             	mov    %ecx,%r14d
   af0c3:	e9 3d ff ff ff       	jmp    af005 <__libc_free+0x135>
   af0c8:	48 8d 3d 82 41 11 00 	lea    0x114182(%rip),%rdi        # 1c3251 <null+0x10ab>
   af0cf:	e9 4c aa ff ff       	jmp    a9b20 <malloc_printerr_tail>
   af0d4:	4c 89 47 08          	mov    %r8,0x8(%rdi)
   af0d8:	e9 42 ff ff ff       	jmp    af01f <__libc_free+0x14f>

/nix/store/n2ngn7laslhjp3s4ndd795spmnfc2wm3-glibc-2.42-84/lib/libc.so.6:     file format elf32-i386


Disassembly of section .plt:

Disassembly of section .plt.got:

Disassembly of section .text:

000a6880 <__libc_free>:
   a6880:	e8 a8 ed 0d 00       	call   18562d <__x86.get_pc_thunk.dx>
   a6885:	81 c2 8f 35 19 00    	add    $0x19358f,%edx
   a688b:	55                   	push   %ebp
   a688c:	57                   	push   %edi
   a688d:	56                   	push   %esi
   a688e:	53                   	push   %ebx
   a688f:	83 ec 1c             	sub    $0x1c,%esp
   a6892:	8b 44 24 30          	mov    0x30(%esp),%eax
   a6896:	85 c0                	test   %eax,%eax
   a6898:	74 7b                	je     a6915 <__libc_free+0x95>
   a689a:	a8 0f                	test   $0xf,%al
   a689c:	0f 85 ee 00 00 00    	jne    a6990 <__libc_free+0x110>
   a68a2:	8b 58 fc             	mov    -0x4(%eax),%ebx
   a68a5:	89 dd                	mov    %ebx,%ebp
   a68a7:	89 1c 24             	mov    %ebx,(%esp)
   a68aa:	83 e5 f8             	and    $0xfffffff8,%ebp
   a68ad:	3b aa 8c 03 00 00    	cmp    0x38c(%edx),%ebp
   a68b3:	0f 83 ef 00 00 00    	jae    a69a8 <__libc_free+0x128>
   a68b9:	8b 8a 7c 00 00 00    	mov    0x7c(%edx),%ecx
   a68bf:	65 8b 09             	mov    %gs:(%ecx),%ecx
   a68c2:	85 c9                	test   %ecx,%ecx
   a68c4:	0f 84 e6 00 00 00    	je     a69b0 <__libc_free+0x130>
   a68ca:	8b ba 60 3c 00 00    	mov    0x3c60(%edx),%edi
   a68d0:	39 78 04             	cmp    %edi,0x4(%eax)
   a68d3:	0f 84 e7 00 00 00    	je     a69c0 <__libc_free+0x140>
   a68d9:	8d 5d f0             	lea    -0x10(%ebp),%ebx
   a68dc:	89 de                	mov    %ebx,%esi
   a68de:	89 5c 24 04          	mov    %ebx,0x4(%esp)
   a68e2:	c1 ee 04             	shr    $0x4,%esi
   a68e5:	81 fb ff 03 00 00    	cmp    $0x3ff,%ebx
   a68eb:	77 3b                	ja     a6928 <__libc_free+0xa8>
   a68ed:	0f b7 1c 71          	movzwl (%ecx,%esi,2),%ebx
   a68f1:	66 85 db             	test   %bx,%bx
   a68f4:	74 4d                	je     a6943 <__libc_free+0xc3>
   a68f6:	89 c2                	mov    %eax,%edx
   a68f8:	89 78 04             	mov    %edi,0x4(%eax)
   a68fb:	8d 7b ff             	lea    -0x1(%ebx),%edi
   a68fe:	c1 ea 0c             	shr    $0xc,%edx
   a6901:	33 94 b1 98 00 00 00 	xor    0x98(%ecx,%esi,4),%edx
   a6908:	89 10                	mov    %edx,(%eax)
   a690a:	89 84 b1 98 00 00 00 	mov    %eax,0x98(%ecx,%esi,4)
   a6911:	66 89 3c 71          	mov    %di,(%ecx,%esi,2)
   a6915:	83 c4 1c             	add    $0x1c,%esp
   a6918:	5b                   	pop    %ebx
   a6919:	5e                   	pop    %esi
   a691a:	5f                   	pop    %edi
   a691b:	5d                   	pop    %ebp
   a691c:	31 c0                	xor    %eax,%eax
   a691e:	31 d2                	xor    %edx,%edx
   a6920:	31 c9                	xor    %ecx,%ecx
   a6922:	c3                   	ret
   a6923:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
   a6928:	8b 34 24             	mov    (%esp),%esi
   a692b:	d1 ee                	shr    $1,%esi
   a692d:	83 fd 0f             	cmp    $0xf,%ebp
   a6930:	f7 d6                	not    %esi
   a6932:	0f 97 44 24 0d       	seta   0xd(%esp)
   a6937:	89 f3                	mov    %esi,%ebx
   a6939:	20 5c 24 0d          	and    %bl,0xd(%esp)
   a693d:	0f 85 8d 00 00 00    	jne    a69d0 <__libc_free+0x150>
   a6943:	8b 5c 24 04          	mov    0x4(%esp),%ebx
   a6947:	83 e8 08             	sub    $0x8,%eax
   a694a:	01 c3                	add    %eax,%ebx
   a694c:	0f 82 30 01 00 00    	jb     a6a82 <__libc_free+0x202>
   a6952:	f6 04 24 04          	testb  $0x4,(%esp)
   a6956:	74 28                	je     a6980 <__libc_free+0x100>
   a6958:	89 c2                	mov    %eax,%edx
   a695a:	81 e2 00 00 f0 ff    	and    $0xfff00000,%edx
   a6960:	8b 1a                	mov    (%edx),%ebx
   a6962:	c7 44 24 30 00 00 00 	movl   $0x0,0x30(%esp)
   a6969:	00 
   a696a:	83 c4 1c             	add    $0x1c,%esp
   a696d:	89 e9                	mov    %ebp,%ecx
   a696f:	89 c2                	mov    %eax,%edx
   a6971:	89 d8                	mov    %ebx,%eax
   a6973:	5b                   	pop    %ebx
   a6974:	5e                   	pop    %esi
   a6975:	5f                   	pop    %edi
   a6976:	5d                   	pop    %ebp
   a6977:	e9 44 d1 ff ff       	jmp    a3ac0 <_int_free_chunk>
   a697c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
   a6980:	8d 9a 4c 09 00 00    	lea    0x94c(%edx),%ebx
   a6986:	eb da                	jmp    a6962 <__libc_free+0xe2>
   a6988:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
   a698f:	00 
   a6990:	8d 82 af 53 f9 ff    	lea    -0x6ac51(%edx),%eax
   a6996:	83 c4 1c             	add    $0x1c,%esp
   a6999:	5b                   	pop    %ebx
   a699a:	5e                   	pop    %esi
   a699b:	5f                   	pop    %edi
   a699c:	5d                   	pop    %ebp
   a699d:	e9 ce b1 ff ff       	jmp    a1b70 <malloc_printerr_tail>
   a69a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
   a69a8:	8d 5d f0             	lea    -0x10(%ebp),%ebx
   a69ab:	eb 9a                	jmp    a6947 <__libc_free+0xc7>
   a69ad:	8d 76 00             	lea    0x0(%esi),%esi
   a69b0:	8d 7d f0             	lea    -0x10(%ebp),%edi
   a69b3:	89 7c 24 04          	mov    %edi,0x4(%esp)
   a69b7:	eb 8a                	jmp    a6943 <__libc_free+0xc3>
   a69b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
   a69c0:	83 c4 1c             	add    $0x1c,%esp
   a69c3:	5b                   	pop    %ebx
   a69c4:	5e                   	pop    %esi
   a69c5:	5f                   	pop    %edi
   a69c6:	5d                   	pop    %ebp
   a69c7:	e9 14 02 00 00       	jmp    a6be0 <tcache_double_free_verify>
   a69cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
   a69d0:	0f bd f5             	bsr    %ebp,%esi
   a69d3:	83 f6 1f             	xor    $0x1f,%esi
   a69d6:	89 f3                	mov    %esi,%ebx
   a69d8:	be 55 00 00 00       	mov    $0x55,%esi
   a69dd:	29 de                	sub    %ebx,%esi
   a69df:	89 5c 24 08          	mov    %ebx,0x8(%esp)
   a69e3:	0f b7 1c 71          	movzwl (%ecx,%esi,2),%ebx
   a69e7:	66 89 5c 24 0e       	mov    %bx,0xe(%esp)
   a69ec:	66 85 db             	test   %bx,%bx
   a69ef:	0f 84 4e ff ff ff    	je     a6943 <__libc_free+0xc3>
   a69f5:	ba 7b 00 00 00       	mov    $0x7b,%edx
   a69fa:	8b 9c b1 98 00 00 00 	mov    0x98(%ecx,%esi,4),%ebx
   a6a01:	2b 54 24 08          	sub    0x8(%esp),%edx
   a6a05:	8d 14 91             	lea    (%ecx,%edx,4),%edx
   a6a08:	89 14 24             	mov    %edx,(%esp)
   a6a0b:	31 d2                	xor    %edx,%edx
   a6a0d:	85 db                	test   %ebx,%ebx
   a6a0f:	74 45                	je     a6a56 <__libc_free+0x1d6>
   a6a11:	89 44 24 04          	mov    %eax,0x4(%esp)
   a6a15:	8b 43 fc             	mov    -0x4(%ebx),%eax
   a6a18:	83 e0 f8             	and    $0xfffffff8,%eax
   a6a1b:	39 e8                	cmp    %ebp,%eax
   a6a1d:	72 4a                	jb     a6a69 <__libc_free+0x1e9>
   a6a1f:	8b 44 24 04          	mov    0x4(%esp),%eax
   a6a23:	89 78 04             	mov    %edi,0x4(%eax)
   a6a26:	84 d2                	test   %dl,%dl
   a6a28:	74 2f                	je     a6a59 <__libc_free+0x1d9>
   a6a2a:	8b 2c 24             	mov    (%esp),%ebp
   a6a2d:	89 c7                	mov    %eax,%edi
   a6a2f:	c1 ef 0c             	shr    $0xc,%edi
   a6a32:	8b 5d 00             	mov    0x0(%ebp),%ebx
   a6a35:	89 ea                	mov    %ebp,%edx
   a6a37:	c1 ea 0c             	shr    $0xc,%edx
   a6a3a:	31 d3                	xor    %edx,%ebx
   a6a3c:	31 c2                	xor    %eax,%edx
   a6a3e:	31 fb                	xor    %edi,%ebx
   a6a40:	89 18                	mov    %ebx,(%eax)
   a6a42:	89 55 00             	mov    %edx,0x0(%ebp)
   a6a45:	0f b7 44 24 0e       	movzwl 0xe(%esp),%eax
   a6a4a:	83 e8 01             	sub    $0x1,%eax
   a6a4d:	66 89 04 71          	mov    %ax,(%ecx,%esi,2)
   a6a51:	e9 bf fe ff ff       	jmp    a6915 <__libc_free+0x95>
   a6a56:	89 78 04             	mov    %edi,0x4(%eax)
   a6a59:	8b 3c 24             	mov    (%esp),%edi
   a6a5c:	89 c2                	mov    %eax,%edx
   a6a5e:	c1 ea 0c             	shr    $0xc,%edx
   a6a61:	33 17                	xor    (%edi),%edx
   a6a63:	89 10                	mov    %edx,(%eax)
   a6a65:	89 07                	mov    %eax,(%edi)
   a6a67:	eb dc                	jmp    a6a45 <__libc_free+0x1c5>
   a6a69:	8b 03                	mov    (%ebx),%eax
   a6a6b:	89 da                	mov    %ebx,%edx
   a6a6d:	89 1c 24             	mov    %ebx,(%esp)
   a6a70:	c1 ea 0c             	shr    $0xc,%edx
   a6a73:	89 c3                	mov    %eax,%ebx
   a6a75:	31 d3                	xor    %edx,%ebx
   a6a77:	39 c2                	cmp    %eax,%edx
   a6a79:	74 12                	je     a6a8d <__libc_free+0x20d>
   a6a7b:	0f b6 54 24 0d       	movzbl 0xd(%esp),%edx
   a6a80:	eb 93                	jmp    a6a15 <__libc_free+0x195>
   a6a82:	8d 82 c7 53 f9 ff    	lea    -0x6ac39(%edx),%eax
   a6a88:	e9 09 ff ff ff       	jmp    a6996 <__libc_free+0x116>
   a6a8d:	8b 44 24 04          	mov    0x4(%esp),%eax
   a6a91:	89 78 04             	mov    %edi,0x4(%eax)
   a6a94:	eb 94                	jmp    a6a2a <__libc_free+0x1aa>
