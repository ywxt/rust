
/tmp/xdiff-src/build/x86_64-unknown-linux-gnu/stage1-std/x86_64-unknown-linux-gnu/dist/build/coretests/d6382d1542e5d229/out/corebenches-d6382d1542e5d229:	file format elf64-x86-64

Disassembly of section .text:

000000000021bbe0 <_RNvYNCNvNtCsjC2aHCArQCR_11corebenches5tuple22bench_tuple_comparison0INtNtNtCs6knCYbIatyh_4core3ops8function6FnOnceTQNtNtCsbvh2iR3x0la_4test5bench7BencherEE9call_onceB8_>:
  21bbe0: 55                           	pushq	%rbp
  21bbe1: 48 89 e5                     	movq	%rsp, %rbp
  21bbe4: 41 57                        	pushq	%r15
  21bbe6: 41 56                        	pushq	%r14
  21bbe8: 41 55                        	pushq	%r13
  21bbea: 41 54                        	pushq	%r12
  21bbec: 53                           	pushq	%rbx
  21bbed: 48 81 ec 68 03 00 00         	subq	$0x368, %rsp            # imm = 0x368
  21bbf4: 49 89 f7                     	movq	%rsi, %r15
  21bbf7: 49 89 fe                     	movq	%rdi, %r14
  21bbfa: 66 0f 10 05 7e e9 df ff      	movupd	-0x201682(%rip), %xmm0  # 0x1a580 <memset+0x1a580>
  21bc02: 66 0f 29 85 e0 fc ff ff      	movapd	%xmm0, -0x320(%rbp)
  21bc0a: 48 8d 5d 88                  	leaq	-0x78(%rbp), %rbx
  21bc0e: 48 8d b5 e0 fc ff ff         	leaq	-0x320(%rbp), %rsi
  21bc15: 48 89 df                     	movq	%rbx, %rdi
  21bc18: ff 15 0a 82 10 00            	callq	*0x10820a(%rip)         # 0x323e28 <memset+0x323e28>
  21bc1e: 48 8d 05 42 8f e0 ff         	leaq	-0x1f70be(%rip), %rax   # 0x24b67 <memset+0x24b67>
  21bc25: 48 89 85 e8 fe ff ff         	movq	%rax, -0x118(%rbp)
  21bc2c: 48 c7 85 f0 fe ff ff 1b 00 00 00     	movq	$0x1b, -0x110(%rbp)
  21bc37: 48 c7 85 f8 fe ff ff 7b 00 00 00     	movq	$0x7b, -0x108(%rbp)
  21bc42: 48 8d 05 39 8f e0 ff         	leaq	-0x1f70c7(%rip), %rax   # 0x24b82 <memset+0x24b82>
  21bc49: 48 89 85 00 ff ff ff         	movq	%rax, -0x100(%rbp)
  21bc50: 48 c7 85 08 ff ff ff 1b 00 00 00     	movq	$0x1b, -0xf8(%rbp)
  21bc5b: 48 c7 85 10 ff ff ff c8 01 00 00     	movq	$0x1c8, -0xf0(%rbp) # imm = 0x1C8
  21bc66: 48 8d 05 30 8f e0 ff         	leaq	-0x1f70d0(%rip), %rax   # 0x24b9d <memset+0x24b9d>
  21bc6d: 48 89 85 18 ff ff ff         	movq	%rax, -0xe8(%rbp)
  21bc74: 48 c7 85 20 ff ff ff 1b 00 00 00     	movq	$0x1b, -0xe0(%rbp)
  21bc7f: 48 c7 85 28 ff ff ff 15 03 00 00     	movq	$0x315, -0xd8(%rbp) # imm = 0x315
  21bc8a: 48 8d 05 27 8f e0 ff         	leaq	-0x1f70d9(%rip), %rax   # 0x24bb8 <memset+0x24bb8>
  21bc91: 48 89 85 30 ff ff ff         	movq	%rax, -0xd0(%rbp)
  21bc98: 48 c7 85 38 ff ff ff 1b 00 00 00     	movq	$0x1b, -0xc8(%rbp)
  21bca3: 48 c7 85 40 ff ff ff 7b 00 00 00     	movq	$0x7b, -0xc0(%rbp)
  21bcae: 48 8d 05 1e 8f e0 ff         	leaq	-0x1f70e2(%rip), %rax   # 0x24bd3 <memset+0x24bd3>
  21bcb5: 48 89 85 48 ff ff ff         	movq	%rax, -0xb8(%rbp)
  21bcbc: 48 c7 85 50 ff ff ff 1b 00 00 00     	movq	$0x1b, -0xb0(%rbp)
  21bcc7: 48 c7 85 58 ff ff ff c8 01 00 00     	movq	$0x1c8, -0xa8(%rbp) # imm = 0x1C8
  21bcd2: 48 8d 05 15 8f e0 ff         	leaq	-0x1f70eb(%rip), %rax   # 0x24bee <memset+0x24bee>
  21bcd9: 48 89 85 60 ff ff ff         	movq	%rax, -0xa0(%rbp)
  21bce0: 48 c7 85 68 ff ff ff 1b 00 00 00     	movq	$0x1b, -0x98(%rbp)
  21bceb: 48 c7 85 70 ff ff ff 15 03 00 00     	movq	$0x315, -0x90(%rbp) # imm = 0x315
  21bcf6: 48 8d 85 e8 fe ff ff         	leaq	-0x118(%rbp), %rax
  21bcfd: 41 80 bf 80 00 00 00 00      	cmpb	$0x0, 0x80(%r15)
  21bd05: 74 1a                        	je	0x21bd21 <_RNvYNCNvNtCsjC2aHCArQCR_11corebenches5tuple22bench_tuple_comparison0INtNtNtCs6knCYbIatyh_4core3ops8function6FnOnceTQNtNtCsbvh2iR3x0la_4test5bench7BencherEE9call_onceB8_+0x141>
  21bd07: 48 8d bd e8 fe ff ff         	leaq	-0x118(%rbp), %rdi
  21bd0e: 48 8d 75 88                  	leaq	-0x78(%rbp), %rsi
  21bd12: ba 01 00 00 00               	movl	$0x1, %edx
  21bd17: e8 34 6a f7 ff               	callq	0x192750 <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvNtCsjC2aHCArQCR_11corebenches5tuples_22bench_tuple_comparison0EBT_>
  21bd1c: e9 72 03 00 00               	jmp	0x21c093 <_RNvYNCNvNtCsjC2aHCArQCR_11corebenches5tuple22bench_tuple_comparison0INtNtNtCs6knCYbIatyh_4core3ops8function6FnOnceTQNtNtCsbvh2iR3x0la_4test5bench7BencherEE9call_onceB8_+0x4b3>
  21bd21: 48 8d bd e8 fe ff ff         	leaq	-0x118(%rbp), %rdi
  21bd28: 48 8d 75 88                  	leaq	-0x78(%rbp), %rsi
  21bd2c: ba 01 00 00 00               	movl	$0x1, %edx
  21bd31: e8 1a 6a f7 ff               	callq	0x192750 <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvNtCsjC2aHCArQCR_11corebenches5tuples_22bench_tuple_comparison0EBT_>
  21bd36: 48 89 c3                     	movq	%rax, %rbx
  21bd39: 48 8d bd e0 fc ff ff         	leaq	-0x320(%rbp), %rdi
  21bd40: 48 c7 45 c8 00 00 00 00      	movq	$0x0, -0x38(%rbp)
  21bd48: ba 90 01 00 00               	movl	$0x190, %edx            # imm = 0x190
  21bd4d: 31 f6                        	xorl	%esi, %esi
  21bd4f: ff 15 5b 80 10 00            	callq	*0x10805b(%rip)         # 0x323db0 <memset+0x323db0>
  21bd55: 48 83 fb 01                  	cmpq	$0x1, %rbx
  21bd59: 48 83 d3 00                  	adcq	$0x0, %rbx
  21bd5d: 48 81 fb 40 42 0f 00         	cmpq	$0xf4240, %rbx          # imm = 0xF4240
  21bd64: 4c 89 75 a0                  	movq	%r14, -0x60(%rbp)
  21bd68: 4c 89 7d a8                  	movq	%r15, -0x58(%rbp)
  21bd6c: 77 0e                        	ja	0x21bd7c <_RNvYNCNvNtCsjC2aHCArQCR_11corebenches5tuple22bench_tuple_comparison0INtNtNtCs6knCYbIatyh_4core3ops8function6FnOnceTQNtNtCsbvh2iR3x0la_4test5bench7BencherEE9call_onceB8_+0x19c>
  21bd6e: b8 40 42 0f 00               	movl	$0xf4240, %eax          # imm = 0xF4240
  21bd73: 31 d2                        	xorl	%edx, %edx
  21bd75: f7 f3                        	divl	%ebx
  21bd77: 41 89 c7                     	movl	%eax, %r15d
  21bd7a: eb 03                        	jmp	0x21bd7f <_RNvYNCNvNtCsjC2aHCArQCR_11corebenches5tuple22bench_tuple_comparison0INtNtNtCs6knCYbIatyh_4core3ops8function6FnOnceTQNtNtCsbvh2iR3x0la_4test5bench7BencherEE9call_onceB8_+0x19f>
  21bd7c: 45 31 ff                     	xorl	%r15d, %r15d
  21bd7f: 49 83 ff 01                  	cmpq	$0x1, %r15
  21bd83: 49 83 d7 00                  	adcq	$0x0, %r15
  21bd87: 48 8b 05 ba 7e 10 00         	movq	0x107eba(%rip), %rax    # 0x323c48 <memset+0x323c48>
  21bd8e: 4c 8d a5 e8 fe ff ff         	leaq	-0x118(%rbp), %r12
  21bd95: 4c 8d 6d 88                  	leaq	-0x78(%rbp), %r13
  21bd99: 48 c7 45 d0 00 00 00 00      	movq	$0x0, -0x30(%rbp)
  21bda1: ff d0                        	callq	*%rax
  21bda3: 48 89 85 78 ff ff ff         	movq	%rax, -0x88(%rbp)
  21bdaa: 89 55 80                     	movl	%edx, -0x80(%rbp)
  21bdad: 0f 57 c0                     	xorps	%xmm0, %xmm0
  21bdb0: f2 49 0f 2a c7               	cvtsi2sd	%r15, %xmm0
  21bdb5: f2 0f 11 45 b0               	movsd	%xmm0, -0x50(%rbp)
  21bdba: 31 db                        	xorl	%ebx, %ebx
  21bdbc: 0f 1f 40 00                  	nopl	(%rax)
  21bdc0: 4c 8d 73 08                  	leaq	0x8(%rbx), %r14
  21bdc4: 4c 89 e7                     	movq	%r12, %rdi
  21bdc7: 4c 89 ee                     	movq	%r13, %rsi
  21bdca: 4c 89 fa                     	movq	%r15, %rdx
  21bdcd: e8 7e 69 f7 ff               	callq	0x192750 <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvNtCsjC2aHCArQCR_11corebenches5tuples_22bench_tuple_comparison0EBT_>
  21bdd2: 66 48 0f 6e c0               	movq	%rax, %xmm0
  21bdd7: 66 0f 62 05 81 dd df ff      	punpckldq	-0x20227f(%rip), %xmm0 # xmm0 = xmm0[0],mem[0],xmm0[1],mem[1]
                                                                        # 0x19b60 <memset+0x19b60>
  21bddf: 66 0f 5c 05 89 db df ff      	subpd	-0x202477(%rip), %xmm0  # 0x19970 <memset+0x19970>
  21bde7: 66 0f 28 c8                  	movapd	%xmm0, %xmm1
  21bdeb: 66 0f 15 c8                  	unpckhpd	%xmm0, %xmm1            # xmm1 = xmm1[1],xmm0[1]
  21bdef: f2 0f 58 c8                  	addsd	%xmm0, %xmm1
  21bdf3: f2 0f 5e 4d b0               	divsd	-0x50(%rbp), %xmm1
  21bdf8: f2 0f 11 8c 1d e0 fc ff ff   	movsd	%xmm1, -0x320(%rbp,%rbx)
  21be01: 4c 89 f3                     	movq	%r14, %rbx
  21be04: 49 81 fe 90 01 00 00         	cmpq	$0x190, %r14            # imm = 0x190
  21be0b: 75 b3                        	jne	0x21bdc0 <_RNvYNCNvNtCsjC2aHCArQCR_11corebenches5tuple22bench_tuple_comparison0INtNtNtCs6knCYbIatyh_4core3ops8function6FnOnceTQNtNtCsbvh2iR3x0la_4test5bench7BencherEE9call_onceB8_+0x1e0>
  21be0d: be 32 00 00 00               	movl	$0x32, %esi
  21be12: 48 8d 9d e0 fc ff ff         	leaq	-0x320(%rbp), %rbx
  21be19: 48 89 df                     	movq	%rbx, %rdi
  21be1c: f2 0f 10 05 cc e8 df ff      	movsd	-0x201734(%rip), %xmm0  # 0x1a6f0 <memset+0x1a6f0>
  21be24: ff 15 8e 7f 10 00            	callq	*0x107f8e(%rip)         # 0x323db8 <memset+0x323db8>
  21be2a: ba 32 00 00 00               	movl	$0x32, %edx
  21be2f: 48 8d bd 70 fc ff ff         	leaq	-0x390(%rbp), %rdi
  21be36: 48 89 de                     	movq	%rbx, %rsi
  21be39: ff 15 81 7f 10 00            	callq	*0x107f81(%rip)         # 0x323dc0 <memset+0x323dc0>
  21be3f: 4c 89 7d 98                  	movq	%r15, -0x68(%rbp)
  21be43: 4b 8d 1c bf                  	leaq	(%r15,%r15,4), %rbx
  21be47: 66 48 0f 6e c3               	movq	%rbx, %xmm0
  21be4c: 66 0f 62 05 0c dd df ff      	punpckldq	-0x2022f4(%rip), %xmm0 # xmm0 = xmm0[0],mem[0],xmm0[1],mem[1]
                                                                        # 0x19b60 <memset+0x19b60>
  21be54: 66 0f 5c 05 14 db df ff      	subpd	-0x2024ec(%rip), %xmm0  # 0x19970 <memset+0x19970>
  21be5c: 66 0f 28 c8                  	movapd	%xmm0, %xmm1
  21be60: 66 0f 15 c8                  	unpckhpd	%xmm0, %xmm1            # xmm1 = xmm1[1],xmm0[1]
  21be64: f2 0f 58 c8                  	addsd	%xmm0, %xmm1
  21be68: 66 0f 29 4d b0               	movapd	%xmm1, -0x50(%rbp)
  21be6d: 45 31 f6                     	xorl	%r14d, %r14d
  21be70: 4d 89 ef                     	movq	%r13, %r15
  21be73: 4d 89 e5                     	movq	%r12, %r13
  21be76: 66 2e 0f 1f 84 00 00 00 00 00	nopw	%cs:(%rax,%rax)
  21be80: 4d 8d 66 08                  	leaq	0x8(%r14), %r12
  21be84: 4c 89 ef                     	movq	%r13, %rdi
  21be87: 4c 89 fe                     	movq	%r15, %rsi
  21be8a: 48 89 da                     	movq	%rbx, %rdx
  21be8d: e8 be 68 f7 ff               	callq	0x192750 <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvNtCsjC2aHCArQCR_11corebenches5tuples_22bench_tuple_comparison0EBT_>
  21be92: 66 48 0f 6e c0               	movq	%rax, %xmm0
  21be97: 66 0f 62 05 c1 dc df ff      	punpckldq	-0x20233f(%rip), %xmm0 # xmm0 = xmm0[0],mem[0],xmm0[1],mem[1]
                                                                        # 0x19b60 <memset+0x19b60>
  21be9f: 66 0f 5c 05 c9 da df ff      	subpd	-0x202537(%rip), %xmm0  # 0x19970 <memset+0x19970>
  21bea7: 66 0f 28 c8                  	movapd	%xmm0, %xmm1
  21beab: 66 0f 15 c8                  	unpckhpd	%xmm0, %xmm1            # xmm1 = xmm1[1],xmm0[1]
  21beaf: f2 0f 58 c8                  	addsd	%xmm0, %xmm1
  21beb3: f2 0f 5e 4d b0               	divsd	-0x50(%rbp), %xmm1
  21beb8: f2 42 0f 11 8c 35 e0 fc ff ff	movsd	%xmm1, -0x320(%rbp,%r14)
  21bec2: 4d 89 e6                     	movq	%r12, %r14
  21bec5: 49 81 fc 90 01 00 00         	cmpq	$0x190, %r12            # imm = 0x190
  21becc: 75 b2                        	jne	0x21be80 <_RNvYNCNvNtCsjC2aHCArQCR_11corebenches5tuple22bench_tuple_comparison0INtNtNtCs6knCYbIatyh_4core3ops8function6FnOnceTQNtNtCsbvh2iR3x0la_4test5bench7BencherEE9call_onceB8_+0x2a0>
  21bece: be 32 00 00 00               	movl	$0x32, %esi
  21bed3: 48 8d 9d e0 fc ff ff         	leaq	-0x320(%rbp), %rbx
  21beda: 48 89 df                     	movq	%rbx, %rdi
  21bedd: f2 0f 10 05 0b e8 df ff      	movsd	-0x2017f5(%rip), %xmm0  # 0x1a6f0 <memset+0x1a6f0>
  21bee5: ff 15 cd 7e 10 00            	callq	*0x107ecd(%rip)         # 0x323db8 <memset+0x323db8>
  21beeb: ba 32 00 00 00               	movl	$0x32, %edx
  21bef0: 48 8d bd 78 fe ff ff         	leaq	-0x188(%rbp), %rdi
  21bef7: 48 89 de                     	movq	%rbx, %rsi
  21befa: ff 15 c0 7e 10 00            	callq	*0x107ec0(%rip)         # 0x323dc0 <memset+0x323dc0>
  21bf00: 48 8d bd 78 ff ff ff         	leaq	-0x88(%rbp), %rdi
  21bf07: ff 15 43 7d 10 00            	callq	*0x107d43(%rip)         # 0x323c50 <memset+0x323c50>
  21bf0d: 31 c9                        	xorl	%ecx, %ecx
  21bf0f: 81 fa 01 e1 f5 05            	cmpl	$0x5f5e101, %edx        # imm = 0x5F5E101
  21bf15: 0f 93 c1                     	setae	%cl
  21bf18: 31 f6                        	xorl	%esi, %esi
  21bf1a: 48 85 c0                     	testq	%rax, %rax
  21bf1d: 40 0f 95 c6                  	setne	%sil
  21bf21: 0f 44 f1                     	cmovel	%ecx, %esi
  21bf24: 40 80 fe 01                  	cmpb	$0x1, %sil
  21bf28: 48 8b 75 c8                  	movq	-0x38(%rbp), %rsi
  21bf2c: 4d 89 ec                     	movq	%r13, %r12
  21bf2f: 4d 89 fd                     	movq	%r15, %r13
  21bf32: 4c 8b 7d 98                  	movq	-0x68(%rbp), %r15
  21bf36: 48 8b 7d d0                  	movq	-0x30(%rbp), %rdi
  21bf3a: 75 30                        	jne	0x21bf6c <_RNvYNCNvNtCsjC2aHCArQCR_11corebenches5tuple22bench_tuple_comparison0INtNtNtCs6knCYbIatyh_4core3ops8function6FnOnceTQNtNtCsbvh2iR3x0la_4test5bench7BencherEE9call_onceB8_+0x38c>
  21bf3c: f2 0f 10 05 8c e7 df ff      	movsd	-0x201874(%rip), %xmm0  # 0x1a6d0 <memset+0x1a6d0>
  21bf44: 66 0f 2e 85 b8 fc ff ff      	ucomisd	-0x348(%rbp), %xmm0
  21bf4c: 76 1e                        	jbe	0x21bf6c <_RNvYNCNvNtCsjC2aHCArQCR_11corebenches5tuple22bench_tuple_comparison0INtNtNtCs6knCYbIatyh_4core3ops8function6FnOnceTQNtNtCsbvh2iR3x0la_4test5bench7BencherEE9call_onceB8_+0x38c>
  21bf4e: f2 0f 10 85 90 fc ff ff      	movsd	-0x370(%rbp), %xmm0
  21bf56: f2 0f 5c 85 98 fe ff ff      	subsd	-0x168(%rbp), %xmm0
  21bf5e: f2 0f 10 8d b8 fe ff ff      	movsd	-0x148(%rbp), %xmm1
  21bf66: 66 0f 2e c8                  	ucomisd	%xmm0, %xmm1
  21bf6a: 77 67                        	ja	0x21bfd3 <_RNvYNCNvNtCsjC2aHCArQCR_11corebenches5tuple22bench_tuple_comparison0INtNtNtCs6knCYbIatyh_4core3ops8function6FnOnceTQNtNtCsbvh2iR3x0la_4test5bench7BencherEE9call_onceB8_+0x3f3>
  21bf6c: 48 01 c7                     	addq	%rax, %rdi
  21bf6f: 0f 82 3a 01 00 00            	jb	0x21c0af <_RNvYNCNvNtCsjC2aHCArQCR_11corebenches5tuple22bench_tuple_comparison0INtNtNtCs6knCYbIatyh_4core3ops8function6FnOnceTQNtNtCsbvh2iR3x0la_4test5bench7BencherEE9call_onceB8_+0x4cf>
  21bf75: 01 d6                        	addl	%edx, %esi
  21bf77: 81 fe 00 ca 9a 3b            	cmpl	$0x3b9aca00, %esi       # imm = 0x3B9ACA00
  21bf7d: 72 13                        	jb	0x21bf92 <_RNvYNCNvNtCsjC2aHCArQCR_11corebenches5tuple22bench_tuple_comparison0INtNtNtCs6knCYbIatyh_4core3ops8function6FnOnceTQNtNtCsbvh2iR3x0la_4test5bench7BencherEE9call_onceB8_+0x3b2>
  21bf7f: 48 83 ff ff                  	cmpq	$-0x1, %rdi
  21bf83: 0f 84 26 01 00 00            	je	0x21c0af <_RNvYNCNvNtCsjC2aHCArQCR_11corebenches5tuple22bench_tuple_comparison0INtNtNtCs6knCYbIatyh_4core3ops8function6FnOnceTQNtNtCsbvh2iR3x0la_4test5bench7BencherEE9call_onceB8_+0x4cf>
  21bf89: 48 ff c7                     	incq	%rdi
  21bf8c: 81 c6 00 36 65 c4            	addl	$0xc4653600, %esi       # imm = 0xC4653600
  21bf92: 31 c0                        	xorl	%eax, %eax
  21bf94: 48 83 ff 04                  	cmpq	$0x4, %rdi
  21bf98: 0f 93 c0                     	setae	%al
  21bf9b: 31 c9                        	xorl	%ecx, %ecx
  21bf9d: 85 f6                        	testl	%esi, %esi
  21bf9f: 0f 95 c1                     	setne	%cl
  21bfa2: 48 83 ff 03                  	cmpq	$0x3, %rdi
  21bfa6: 0f 44 c1                     	cmovel	%ecx, %eax
  21bfa9: 84 c0                        	testb	%al, %al
  21bfab: 75 26                        	jne	0x21bfd3 <_RNvYNCNvNtCsjC2aHCArQCR_11corebenches5tuple22bench_tuple_comparison0INtNtNtCs6knCYbIatyh_4core3ops8function6FnOnceTQNtNtCsbvh2iR3x0la_4test5bench7BencherEE9call_onceB8_+0x3f3>
  21bfad: 48 b8 99 99 99 99 99 99 99 19	movabsq	$0x1999999999999999, %rax # imm = 0x1999999999999999
  21bfb7: 49 39 c7                     	cmpq	%rax, %r15
  21bfba: 77 17                        	ja	0x21bfd3 <_RNvYNCNvNtCsjC2aHCArQCR_11corebenches5tuple22bench_tuple_comparison0INtNtNtCs6knCYbIatyh_4core3ops8function6FnOnceTQNtNtCsbvh2iR3x0la_4test5bench7BencherEE9call_onceB8_+0x3f3>
  21bfbc: 48 89 7d d0                  	movq	%rdi, -0x30(%rbp)
  21bfc0: 48 89 75 c8                  	movq	%rsi, -0x38(%rbp)
  21bfc4: 4d 01 ff                     	addq	%r15, %r15
  21bfc7: 48 8b 05 7a 7c 10 00         	movq	0x107c7a(%rip), %rax    # 0x323c48 <memset+0x323c48>
  21bfce: e9 ce fd ff ff               	jmp	0x21bda1 <_RNvYNCNvNtCsjC2aHCArQCR_11corebenches5tuple22bench_tuple_comparison0INtNtNtCs6knCYbIatyh_4core3ops8function6FnOnceTQNtNtCsbvh2iR3x0la_4test5bench7BencherEE9call_onceB8_+0x1c1>
  21bfd3: 0f 10 85 78 fe ff ff         	movups	-0x188(%rbp), %xmm0
  21bfda: 0f 10 8d 88 fe ff ff         	movups	-0x178(%rbp), %xmm1
  21bfe1: 0f 10 95 98 fe ff ff         	movups	-0x168(%rbp), %xmm2
  21bfe8: 0f 10 9d a8 fe ff ff         	movups	-0x158(%rbp), %xmm3
  21bfef: 0f 29 85 e0 fc ff ff         	movaps	%xmm0, -0x320(%rbp)
  21bff6: 0f 29 8d f0 fc ff ff         	movaps	%xmm1, -0x310(%rbp)
  21bffd: 0f 29 95 00 fd ff ff         	movaps	%xmm2, -0x300(%rbp)
  21c004: 0f 29 9d 10 fd ff ff         	movaps	%xmm3, -0x2f0(%rbp)
  21c00b: 0f 10 85 b8 fe ff ff         	movups	-0x148(%rbp), %xmm0
  21c012: 0f 29 85 20 fd ff ff         	movaps	%xmm0, -0x2e0(%rbp)
  21c019: 0f 10 85 c8 fe ff ff         	movups	-0x138(%rbp), %xmm0
  21c020: 0f 29 85 30 fd ff ff         	movaps	%xmm0, -0x2d0(%rbp)
  21c027: 0f 10 85 d8 fe ff ff         	movups	-0x128(%rbp), %xmm0
  21c02e: 0f 29 85 40 fd ff ff         	movaps	%xmm0, -0x2c0(%rbp)
  21c035: 48 8b 45 a8                  	movq	-0x58(%rbp), %rax
  21c039: 48 c7 00 01 00 00 00         	movq	$0x1, (%rax)
  21c040: 0f 28 85 e0 fc ff ff         	movaps	-0x320(%rbp), %xmm0
  21c047: 0f 28 8d f0 fc ff ff         	movaps	-0x310(%rbp), %xmm1
  21c04e: 0f 28 95 00 fd ff ff         	movaps	-0x300(%rbp), %xmm2
  21c055: 0f 28 9d 10 fd ff ff         	movaps	-0x2f0(%rbp), %xmm3
  21c05c: 0f 11 40 08                  	movups	%xmm0, 0x8(%rax)
  21c060: 0f 11 48 18                  	movups	%xmm1, 0x18(%rax)
  21c064: 0f 11 50 28                  	movups	%xmm2, 0x28(%rax)
  21c068: 0f 11 58 38                  	movups	%xmm3, 0x38(%rax)
  21c06c: 0f 28 85 20 fd ff ff         	movaps	-0x2e0(%rbp), %xmm0
  21c073: 0f 11 40 48                  	movups	%xmm0, 0x48(%rax)
  21c077: 0f 28 85 30 fd ff ff         	movaps	-0x2d0(%rbp), %xmm0
  21c07e: 0f 11 40 58                  	movups	%xmm0, 0x58(%rax)
  21c082: 66 0f 28 85 40 fd ff ff      	movapd	-0x2c0(%rbp), %xmm0
  21c08a: 66 0f 11 40 68               	movupd	%xmm0, 0x68(%rax)
  21c08f: 4c 8b 75 a0                  	movq	-0x60(%rbp), %r14
  21c093: 49 c7 06 ff ff ff ff         	movq	$-0x1, (%r14)
  21c09a: 4c 89 f0                     	movq	%r14, %rax
  21c09d: 48 81 c4 68 03 00 00         	addq	$0x368, %rsp            # imm = 0x368
  21c0a4: 5b                           	popq	%rbx
  21c0a5: 41 5c                        	popq	%r12
  21c0a7: 41 5d                        	popq	%r13
  21c0a9: 41 5e                        	popq	%r14
  21c0ab: 41 5f                        	popq	%r15
  21c0ad: 5d                           	popq	%rbp
  21c0ae: c3                           	retq
  21c0af: 48 8d 3d 6c 01 e0 ff         	leaq	-0x1ffe94(%rip), %rdi   # 0x1c222 <memset+0x1c222>
  21c0b6: 48 8d 15 2b b8 0e 00         	leaq	0xeb82b(%rip), %rdx     # 0x3078e8 <memset+0x3078e8>
  21c0bd: be 2b 00 00 00               	movl	$0x2b, %esi
  21c0c2: ff 15 d0 7c 10 00            	callq	*0x107cd0(%rip)         # 0x323d98 <memset+0x323d98>
  21c0c8: cc                           	int3
  21c0c9: cc                           	int3
  21c0ca: cc                           	int3
  21c0cb: cc                           	int3
  21c0cc: cc                           	int3
  21c0cd: cc                           	int3
  21c0ce: cc                           	int3
  21c0cf: cc                           	int3
