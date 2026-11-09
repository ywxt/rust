; ModuleID = 'shape.dc6e593b42efc4fc-cgu.0'
source_filename = "shape.dc6e593b42efc4fc-cgu.0"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind nonlazybind uwtable
define noundef i64 @chained() unnamed_addr #0 personality ptr @_RNvCsbOwsw4zHH1Z_7___rustc19rust_eh_personality !guid !4 {
bb1.i:
  %_0.i.i.i.i.i.i = alloca [8 x i8], align 8
  %_0.i.i.i.i.i.i.i = alloca [8 x i8], align 8
  br label %bb3.i.i

bb3.i.i:                                          ; preds = %bb1.i, %_RNvXs1_NtNtNtCs6knCYbIatyh_4core3ops8function5implsQNCINvNtNtNtBb_4iter8adapters10filter_map15filter_map_foldxxxNCNvCsiVlEIo5dfo6_5shape7chained0NCINvNtBV_3map8map_foldxxxINvNtBb_4hint9black_boxxENCINvXse_NtNtBX_6traits5accumxNtB3h_3Sum3sumINtB2o_3MapINtBT_9FilterMapINtNtBV_5chain5ChainINtNtB9_5range5RangexEB4B_EB1M_EB2J_EE0E0E0INtB7_5FnMutTxxEE8call_mutB1Q_.exit.i.i
  %accum.sroa.0.09.i.i = phi i64 [ %_0.sroa.0.0.i.i3.i.i, %_RNvXs1_NtNtNtCs6knCYbIatyh_4core3ops8function5implsQNCINvNtNtNtBb_4iter8adapters10filter_map15filter_map_foldxxxNCNvCsiVlEIo5dfo6_5shape7chained0NCINvNtBV_3map8map_foldxxxINvNtBb_4hint9black_boxxENCINvXse_NtNtBX_6traits5accumxNtB3h_3Sum3sumINtB2o_3MapINtBT_9FilterMapINtNtBV_5chain5ChainINtNtB9_5range5RangexEB4B_EB1M_EB2J_EE0E0E0INtB7_5FnMutTxxEE8call_mutB1Q_.exit.i.i ], [ 0, %bb1.i ]
  %self.sroa.0.08.i.i = phi i64 [ %0, %_RNvXs1_NtNtNtCs6knCYbIatyh_4core3ops8function5implsQNCINvNtNtNtBb_4iter8adapters10filter_map15filter_map_foldxxxNCNvCsiVlEIo5dfo6_5shape7chained0NCINvNtBV_3map8map_foldxxxINvNtBb_4hint9black_boxxENCINvXse_NtNtBX_6traits5accumxNtB3h_3Sum3sumINtB2o_3MapINtBT_9FilterMapINtNtBV_5chain5ChainINtNtB9_5range5RangexEB4B_EB1M_EB2J_EE0E0E0INtB7_5FnMutTxxEE8call_mutB1Q_.exit.i.i ], [ 0, %bb1.i ]
  %0 = add nuw nsw i64 %self.sroa.0.08.i.i, 1
  %1 = call { i64, i1 } @llvm.smul.with.overflow.i64(i64 %self.sroa.0.08.i.i, i64 %self.sroa.0.08.i.i)
  %_5.1.i.i.i.i.i = extractvalue { i64, i1 } %1, 1
  br i1 %_5.1.i.i.i.i.i, label %_RNvXs1_NtNtNtCs6knCYbIatyh_4core3ops8function5implsQNCINvNtNtNtBb_4iter8adapters10filter_map15filter_map_foldxxxNCNvCsiVlEIo5dfo6_5shape7chained0NCINvNtBV_3map8map_foldxxxINvNtBb_4hint9black_boxxENCINvXse_NtNtBX_6traits5accumxNtB3h_3Sum3sumINtB2o_3MapINtBT_9FilterMapINtNtBV_5chain5ChainINtNtB9_5range5RangexEB4B_EB1M_EB2J_EE0E0E0INtB7_5FnMutTxxEE8call_mutB1Q_.exit.i.i, label %bb4.i.i.i.i

bb4.i.i.i.i:                                      ; preds = %bb3.i.i
  %_5.0.i.i.i.i.i = extractvalue { i64, i1 } %1, 0
  call void @llvm.lifetime.start.p0(ptr nonnull %_0.i.i.i.i.i.i.i), !noalias !5
  store i64 %_5.0.i.i.i.i.i, ptr %_0.i.i.i.i.i.i.i, align 8, !noalias !5
  call void asm sideeffect "", "r,~{memory}"(ptr nonnull %_0.i.i.i.i.i.i.i) #4, !noalias !5, !srcloc !8
  %2 = load i64, ptr %_0.i.i.i.i.i.i.i, align 8, !noalias !5, !noundef !9
  call void @llvm.lifetime.end.p0(ptr nonnull %_0.i.i.i.i.i.i.i), !noalias !5
  %_4.0.i.i.i.i.i.i = add i64 %2, %accum.sroa.0.09.i.i
  br label %_RNvXs1_NtNtNtCs6knCYbIatyh_4core3ops8function5implsQNCINvNtNtNtBb_4iter8adapters10filter_map15filter_map_foldxxxNCNvCsiVlEIo5dfo6_5shape7chained0NCINvNtBV_3map8map_foldxxxINvNtBb_4hint9black_boxxENCINvXse_NtNtBX_6traits5accumxNtB3h_3Sum3sumINtB2o_3MapINtBT_9FilterMapINtNtBV_5chain5ChainINtNtB9_5range5RangexEB4B_EB1M_EB2J_EE0E0E0INtB7_5FnMutTxxEE8call_mutB1Q_.exit.i.i

_RNvXs1_NtNtNtCs6knCYbIatyh_4core3ops8function5implsQNCINvNtNtNtBb_4iter8adapters10filter_map15filter_map_foldxxxNCNvCsiVlEIo5dfo6_5shape7chained0NCINvNtBV_3map8map_foldxxxINvNtBb_4hint9black_boxxENCINvXse_NtNtBX_6traits5accumxNtB3h_3Sum3sumINtB2o_3MapINtBT_9FilterMapINtNtBV_5chain5ChainINtNtB9_5range5RangexEB4B_EB1M_EB2J_EE0E0E0INtB7_5FnMutTxxEE8call_mutB1Q_.exit.i.i: ; preds = %bb4.i.i.i.i, %bb3.i.i
  %_0.sroa.0.0.i.i3.i.i = phi i64 [ %_4.0.i.i.i.i.i.i, %bb4.i.i.i.i ], [ %accum.sroa.0.09.i.i, %bb3.i.i ]
  %exitcond.not.i.i = icmp eq i64 %0, 1000000
  br i1 %exitcond.not.i.i, label %bb3.i5.i, label %bb3.i.i

bb3.i5.i:                                         ; preds = %_RNvXs1_NtNtNtCs6knCYbIatyh_4core3ops8function5implsQNCINvNtNtNtBb_4iter8adapters10filter_map15filter_map_foldxxxNCNvCsiVlEIo5dfo6_5shape7chained0NCINvNtBV_3map8map_foldxxxINvNtBb_4hint9black_boxxENCINvXse_NtNtBX_6traits5accumxNtB3h_3Sum3sumINtB2o_3MapINtBT_9FilterMapINtNtBV_5chain5ChainINtNtB9_5range5RangexEB4B_EB1M_EB2J_EE0E0E0INtB7_5FnMutTxxEE8call_mutB1Q_.exit.i.i, %_RNCINvNtNtNtCs6knCYbIatyh_4core4iter8adapters10filter_map15filter_map_foldxxxNCNvCsiVlEIo5dfo6_5shape7chained0NCINvNtB6_3map8map_foldxxxINvNtBa_4hint9black_boxxENCINvXse_NtNtB8_6traits5accumxNtB2I_3Sum3sumINtB1P_3MapINtB4_9FilterMapINtNtB6_5chain5ChainINtNtNtBa_3ops5range5RangexEB42_EB1d_EB2a_EE0E0E0B1h_.exit.i.i
  %accum.sroa.0.08.i.i = phi i64 [ %_0.sroa.0.0.i.i.i, %_RNCINvNtNtNtCs6knCYbIatyh_4core4iter8adapters10filter_map15filter_map_foldxxxNCNvCsiVlEIo5dfo6_5shape7chained0NCINvNtB6_3map8map_foldxxxINvNtBa_4hint9black_boxxENCINvXse_NtNtB8_6traits5accumxNtB2I_3Sum3sumINtB1P_3MapINtB4_9FilterMapINtNtB6_5chain5ChainINtNtNtBa_3ops5range5RangexEB42_EB1d_EB2a_EE0E0E0B1h_.exit.i.i ], [ %_0.sroa.0.0.i.i3.i.i, %_RNvXs1_NtNtNtCs6knCYbIatyh_4core3ops8function5implsQNCINvNtNtNtBb_4iter8adapters10filter_map15filter_map_foldxxxNCNvCsiVlEIo5dfo6_5shape7chained0NCINvNtBV_3map8map_foldxxxINvNtBb_4hint9black_boxxENCINvXse_NtNtBX_6traits5accumxNtB3h_3Sum3sumINtB2o_3MapINtBT_9FilterMapINtNtBV_5chain5ChainINtNtB9_5range5RangexEB4B_EB1M_EB2J_EE0E0E0INtB7_5FnMutTxxEE8call_mutB1Q_.exit.i.i ]
  %self.sroa.0.07.i.i = phi i64 [ %3, %_RNCINvNtNtNtCs6knCYbIatyh_4core4iter8adapters10filter_map15filter_map_foldxxxNCNvCsiVlEIo5dfo6_5shape7chained0NCINvNtB6_3map8map_foldxxxINvNtBa_4hint9black_boxxENCINvXse_NtNtB8_6traits5accumxNtB2I_3Sum3sumINtB1P_3MapINtB4_9FilterMapINtNtB6_5chain5ChainINtNtNtBa_3ops5range5RangexEB42_EB1d_EB2a_EE0E0E0B1h_.exit.i.i ], [ 0, %_RNvXs1_NtNtNtCs6knCYbIatyh_4core3ops8function5implsQNCINvNtNtNtBb_4iter8adapters10filter_map15filter_map_foldxxxNCNvCsiVlEIo5dfo6_5shape7chained0NCINvNtBV_3map8map_foldxxxINvNtBb_4hint9black_boxxENCINvXse_NtNtBX_6traits5accumxNtB3h_3Sum3sumINtB2o_3MapINtBT_9FilterMapINtNtBV_5chain5ChainINtNtB9_5range5RangexEB4B_EB1M_EB2J_EE0E0E0INtB7_5FnMutTxxEE8call_mutB1Q_.exit.i.i ]
  %3 = add nuw nsw i64 %self.sroa.0.07.i.i, 1
  %4 = call { i64, i1 } @llvm.smul.with.overflow.i64(i64 %self.sroa.0.07.i.i, i64 %self.sroa.0.07.i.i)
  %_5.1.i.i.i.i = extractvalue { i64, i1 } %4, 1
  br i1 %_5.1.i.i.i.i, label %_RNCINvNtNtNtCs6knCYbIatyh_4core4iter8adapters10filter_map15filter_map_foldxxxNCNvCsiVlEIo5dfo6_5shape7chained0NCINvNtB6_3map8map_foldxxxINvNtBa_4hint9black_boxxENCINvXse_NtNtB8_6traits5accumxNtB2I_3Sum3sumINtB1P_3MapINtB4_9FilterMapINtNtB6_5chain5ChainINtNtNtBa_3ops5range5RangexEB42_EB1d_EB2a_EE0E0E0B1h_.exit.i.i, label %bb4.i.i.i

bb4.i.i.i:                                        ; preds = %bb3.i5.i
  %_5.0.i.i.i.i = extractvalue { i64, i1 } %4, 0
  call void @llvm.lifetime.start.p0(ptr nonnull %_0.i.i.i.i.i.i), !noalias !5
  store i64 %_5.0.i.i.i.i, ptr %_0.i.i.i.i.i.i, align 8, !noalias !5
  call void asm sideeffect "", "r,~{memory}"(ptr nonnull %_0.i.i.i.i.i.i) #4, !noalias !5, !srcloc !8
  %5 = load i64, ptr %_0.i.i.i.i.i.i, align 8, !noalias !5, !noundef !9
  call void @llvm.lifetime.end.p0(ptr nonnull %_0.i.i.i.i.i.i), !noalias !5
  %_4.0.i.i.i.i.i = add i64 %5, %accum.sroa.0.08.i.i
  br label %_RNCINvNtNtNtCs6knCYbIatyh_4core4iter8adapters10filter_map15filter_map_foldxxxNCNvCsiVlEIo5dfo6_5shape7chained0NCINvNtB6_3map8map_foldxxxINvNtBa_4hint9black_boxxENCINvXse_NtNtB8_6traits5accumxNtB2I_3Sum3sumINtB1P_3MapINtB4_9FilterMapINtNtB6_5chain5ChainINtNtNtBa_3ops5range5RangexEB42_EB1d_EB2a_EE0E0E0B1h_.exit.i.i

_RNCINvNtNtNtCs6knCYbIatyh_4core4iter8adapters10filter_map15filter_map_foldxxxNCNvCsiVlEIo5dfo6_5shape7chained0NCINvNtB6_3map8map_foldxxxINvNtBa_4hint9black_boxxENCINvXse_NtNtB8_6traits5accumxNtB2I_3Sum3sumINtB1P_3MapINtB4_9FilterMapINtNtB6_5chain5ChainINtNtNtBa_3ops5range5RangexEB42_EB1d_EB2a_EE0E0E0B1h_.exit.i.i: ; preds = %bb4.i.i.i, %bb3.i5.i
  %_0.sroa.0.0.i.i.i = phi i64 [ %_4.0.i.i.i.i.i, %bb4.i.i.i ], [ %accum.sroa.0.08.i.i, %bb3.i5.i ]
  %exitcond.not.i6.i = icmp eq i64 %3, 1000000
  br i1 %exitcond.not.i6.i, label %_RINvXs_NtNtNtCs6knCYbIatyh_4core4iter8adapters5chainINtB5_5ChainINtNtNtBb_3ops5range5RangexEB10_ENtNtNtB9_6traits8iterator8Iterator4foldxNCINvNtB7_10filter_map15filter_map_foldxxxNCNvCsiVlEIo5dfo6_5shape7chained0NCINvNtB7_3map8map_foldxxxINvNtBb_4hint9black_boxxENCINvXse_NtB1B_5accumxNtB4m_3Sum3sumINtB3t_3MapINtB2g_9FilterMapBO_B2R_EB3O_EE0E0E0EB2V_.exit, label %bb3.i5.i

_RINvXs_NtNtNtCs6knCYbIatyh_4core4iter8adapters5chainINtB5_5ChainINtNtNtBb_3ops5range5RangexEB10_ENtNtNtB9_6traits8iterator8Iterator4foldxNCINvNtB7_10filter_map15filter_map_foldxxxNCNvCsiVlEIo5dfo6_5shape7chained0NCINvNtB7_3map8map_foldxxxINvNtBb_4hint9black_boxxENCINvXse_NtB1B_5accumxNtB4m_3Sum3sumINtB3t_3MapINtB2g_9FilterMapBO_B2R_EB3O_EE0E0E0EB2V_.exit: ; preds = %_RNCINvNtNtNtCs6knCYbIatyh_4core4iter8adapters10filter_map15filter_map_foldxxxNCNvCsiVlEIo5dfo6_5shape7chained0NCINvNtB6_3map8map_foldxxxINvNtBa_4hint9black_boxxENCINvXse_NtNtB8_6traits5accumxNtB2I_3Sum3sumINtB1P_3MapINtB4_9FilterMapINtNtB6_5chain5ChainINtNtNtBa_3ops5range5RangexEB42_EB1d_EB2a_EE0E0E0B1h_.exit.i.i
  ret i64 %_0.sroa.0.0.i.i.i
}

; Function Attrs: noinline nounwind nonlazybind uwtable
define noundef i64 @single() unnamed_addr #0 personality ptr @_RNvCsbOwsw4zHH1Z_7___rustc19rust_eh_personality !guid !10 {
start:
  %_0.i.i.i.i.i = alloca [8 x i8], align 8
  br label %bb3.i

bb3.i:                                            ; preds = %bb3.i, %start
  %accum.sroa.0.07.i = phi i64 [ 0, %start ], [ %_4.0.i.i.i.i, %bb3.i ]
  %self.sroa.0.06.i = phi i64 [ 0, %start ], [ %0, %bb3.i ]
  %0 = add nuw nsw i64 %self.sroa.0.06.i, 1
  %1 = mul nuw nsw i64 %self.sroa.0.06.i, %self.sroa.0.06.i
  call void @llvm.lifetime.start.p0(ptr nonnull %_0.i.i.i.i.i)
  store i64 %1, ptr %_0.i.i.i.i.i, align 8
  call void asm sideeffect "", "r,~{memory}"(ptr nonnull %_0.i.i.i.i.i) #4, !srcloc !8
  %2 = load i64, ptr %_0.i.i.i.i.i, align 8, !noundef !9
  call void @llvm.lifetime.end.p0(ptr nonnull %_0.i.i.i.i.i)
  %_4.0.i.i.i.i = add i64 %2, %accum.sroa.0.07.i
  %exitcond.not.i = icmp eq i64 %0, 1000000
  br i1 %exitcond.not.i, label %_RINvYINtNtNtCs6knCYbIatyh_4core3ops5range5RangexENtNtNtNtBa_4iter6traits8iterator8Iterator4foldxNCINvNtNtBR_8adapters10filter_map15filter_map_foldxxxNCNvCsiVlEIo5dfo6_5shape6single0NCINvNtB1D_3map8map_foldxxxINvNtBa_4hint9black_boxxENCINvXse_NtBP_5accumxNtB3S_3Sum3sumINtB2Y_3MapINtB1B_9FilterMapB3_B2n_EB3k_EE0E0E0EB2r_.exit, label %bb3.i

_RINvYINtNtNtCs6knCYbIatyh_4core3ops5range5RangexENtNtNtNtBa_4iter6traits8iterator8Iterator4foldxNCINvNtNtBR_8adapters10filter_map15filter_map_foldxxxNCNvCsiVlEIo5dfo6_5shape6single0NCINvNtB1D_3map8map_foldxxxINvNtBa_4hint9black_boxxENCINvXse_NtBP_5accumxNtB3S_3Sum3sumINtB2Y_3MapINtB1B_9FilterMapB3_B2n_EB3k_EE0E0E0EB2r_.exit: ; preds = %bb3.i
  ret i64 %_4.0.i.i.i.i
}

; Function Attrs: noinline nounwind nonlazybind uwtable
define noundef i64 @single_ref() unnamed_addr #0 personality ptr @_RNvCsbOwsw4zHH1Z_7___rustc19rust_eh_personality !guid !11 {
start:
  %_0.i.i.i.i.i = alloca [8 x i8], align 8
  br label %bb3.i

bb3.i:                                            ; preds = %start, %_RNCINvNtNtNtCs6knCYbIatyh_4core4iter8adapters10filter_map19filter_map_try_foldxxxINtNtNtBa_3ops9try_trait17NeverShortCircuitxENCNvCsiVlEIo5dfo6_5shape10single_ref0NCINvNtB6_3map12map_try_foldxxxB1h_INvNtBa_4hint9black_boxxENCINvMB1k_B1h_10wrap_mut_2xxNCINvXse_NtNtB8_6traits5accumxNtB4a_3Sum3sumQINtB2G_3MapINtB4_9FilterMapINtNtB1m_5range5RangexEB20_EB3a_EE0E0E0E0B24_.exit.i
  %accum.sroa.0.06.i = phi i64 [ %_0.sroa.0.0.i.i, %_RNCINvNtNtNtCs6knCYbIatyh_4core4iter8adapters10filter_map19filter_map_try_foldxxxINtNtNtBa_3ops9try_trait17NeverShortCircuitxENCNvCsiVlEIo5dfo6_5shape10single_ref0NCINvNtB6_3map12map_try_foldxxxB1h_INvNtBa_4hint9black_boxxENCINvMB1k_B1h_10wrap_mut_2xxNCINvXse_NtNtB8_6traits5accumxNtB4a_3Sum3sumQINtB2G_3MapINtB4_9FilterMapINtNtB1m_5range5RangexEB20_EB3a_EE0E0E0E0B24_.exit.i ], [ 0, %start ]
  %0 = phi i64 [ %1, %_RNCINvNtNtNtCs6knCYbIatyh_4core4iter8adapters10filter_map19filter_map_try_foldxxxINtNtNtBa_3ops9try_trait17NeverShortCircuitxENCNvCsiVlEIo5dfo6_5shape10single_ref0NCINvNtB6_3map12map_try_foldxxxB1h_INvNtBa_4hint9black_boxxENCINvMB1k_B1h_10wrap_mut_2xxNCINvXse_NtNtB8_6traits5accumxNtB4a_3Sum3sumQINtB2G_3MapINtB4_9FilterMapINtNtB1m_5range5RangexEB20_EB3a_EE0E0E0E0B24_.exit.i ], [ 0, %start ]
  %1 = add nuw nsw i64 %0, 1
  %2 = call { i64, i1 } @llvm.smul.with.overflow.i64(i64 %0, i64 %0)
  %_5.1.i.i.i = extractvalue { i64, i1 } %2, 1
  br i1 %_5.1.i.i.i, label %_RNCINvNtNtNtCs6knCYbIatyh_4core4iter8adapters10filter_map19filter_map_try_foldxxxINtNtNtBa_3ops9try_trait17NeverShortCircuitxENCNvCsiVlEIo5dfo6_5shape10single_ref0NCINvNtB6_3map12map_try_foldxxxB1h_INvNtBa_4hint9black_boxxENCINvMB1k_B1h_10wrap_mut_2xxNCINvXse_NtNtB8_6traits5accumxNtB4a_3Sum3sumQINtB2G_3MapINtB4_9FilterMapINtNtB1m_5range5RangexEB20_EB3a_EE0E0E0E0B24_.exit.i, label %bb4.i.i

bb4.i.i:                                          ; preds = %bb3.i
  %_5.0.i.i.i = extractvalue { i64, i1 } %2, 0
  call void @llvm.lifetime.start.p0(ptr nonnull %_0.i.i.i.i.i), !noalias !12
  store i64 %_5.0.i.i.i, ptr %_0.i.i.i.i.i, align 8, !noalias !12
  call void asm sideeffect "", "r,~{memory}"(ptr nonnull %_0.i.i.i.i.i) #4, !noalias !12, !srcloc !8
  %3 = load i64, ptr %_0.i.i.i.i.i, align 8, !noalias !12, !noundef !9
  call void @llvm.lifetime.end.p0(ptr nonnull %_0.i.i.i.i.i), !noalias !12
  %_4.0.i.i.i.i.i = add i64 %3, %accum.sroa.0.06.i
  br label %_RNCINvNtNtNtCs6knCYbIatyh_4core4iter8adapters10filter_map19filter_map_try_foldxxxINtNtNtBa_3ops9try_trait17NeverShortCircuitxENCNvCsiVlEIo5dfo6_5shape10single_ref0NCINvNtB6_3map12map_try_foldxxxB1h_INvNtBa_4hint9black_boxxENCINvMB1k_B1h_10wrap_mut_2xxNCINvXse_NtNtB8_6traits5accumxNtB4a_3Sum3sumQINtB2G_3MapINtB4_9FilterMapINtNtB1m_5range5RangexEB20_EB3a_EE0E0E0E0B24_.exit.i

_RNCINvNtNtNtCs6knCYbIatyh_4core4iter8adapters10filter_map19filter_map_try_foldxxxINtNtNtBa_3ops9try_trait17NeverShortCircuitxENCNvCsiVlEIo5dfo6_5shape10single_ref0NCINvNtB6_3map12map_try_foldxxxB1h_INvNtBa_4hint9black_boxxENCINvMB1k_B1h_10wrap_mut_2xxNCINvXse_NtNtB8_6traits5accumxNtB4a_3Sum3sumQINtB2G_3MapINtB4_9FilterMapINtNtB1m_5range5RangexEB20_EB3a_EE0E0E0E0B24_.exit.i: ; preds = %bb4.i.i, %bb3.i
  %_0.sroa.0.0.i.i = phi i64 [ %_4.0.i.i.i.i.i, %bb4.i.i ], [ %accum.sroa.0.06.i, %bb3.i ]
  %exitcond.not.i = icmp eq i64 %1, 1000000
  br i1 %exitcond.not.i, label %_RINvYINtNtNtCs6knCYbIatyh_4core3ops5range5RangexENtNtNtNtBa_4iter6traits8iterator8Iterator8try_foldxNCINvNtNtBR_8adapters10filter_map19filter_map_try_foldxxxINtNtB8_9try_trait17NeverShortCircuitxENCNvCsiVlEIo5dfo6_5shape10single_ref0NCINvNtB1H_3map12map_try_foldxxxB2v_INvNtBa_4hint9black_boxxENCINvMB2y_B2v_10wrap_mut_2xxNCINvXse_NtBP_5accumxNtB5j_3Sum3sumQINtB3O_3MapINtB1F_9FilterMapB3_B38_EB4j_EE0E0E0E0B2v_EB3c_.exit, label %bb3.i

_RINvYINtNtNtCs6knCYbIatyh_4core3ops5range5RangexENtNtNtNtBa_4iter6traits8iterator8Iterator8try_foldxNCINvNtNtBR_8adapters10filter_map19filter_map_try_foldxxxINtNtB8_9try_trait17NeverShortCircuitxENCNvCsiVlEIo5dfo6_5shape10single_ref0NCINvNtB1H_3map12map_try_foldxxxB2v_INvNtBa_4hint9black_boxxENCINvMB2y_B2v_10wrap_mut_2xxNCINvXse_NtBP_5accumxNtB5j_3Sum3sumQINtB3O_3MapINtB1F_9FilterMapB3_B38_EB4j_EE0E0E0E0B2v_EB3c_.exit: ; preds = %_RNCINvNtNtNtCs6knCYbIatyh_4core4iter8adapters10filter_map19filter_map_try_foldxxxINtNtNtBa_3ops9try_trait17NeverShortCircuitxENCNvCsiVlEIo5dfo6_5shape10single_ref0NCINvNtB6_3map12map_try_foldxxxB1h_INvNtBa_4hint9black_boxxENCINvMB1k_B1h_10wrap_mut_2xxNCINvXse_NtNtB8_6traits5accumxNtB4a_3Sum3sumQINtB2G_3MapINtB4_9FilterMapINtNtB1m_5range5RangexEB20_EB3a_EE0E0E0E0B24_.exit.i
  ret i64 %_0.sroa.0.0.i.i
}

; __rustc::rust_eh_personality
; Function Attrs: nounwind nonlazybind uwtable
declare noundef range(i32 0, 10) i32 @_RNvCsbOwsw4zHH1Z_7___rustc19rust_eh_personality(i32 noundef, i32 noundef, i64 noundef, ptr noundef, ptr noundef) unnamed_addr #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(ptr captures(none)) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(ptr captures(none)) #2

; Function Attrs: mustprogress nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare { i64, i1 } @llvm.smul.with.overflow.i64(i64, i64) #3

attributes #0 = { noinline nounwind nonlazybind uwtable "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #1 = { nounwind nonlazybind uwtable "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #2 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #3 = { mustprogress nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nounwind }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 8, !"PIC Level", i32 2}
!1 = !{i32 2, !"RtLibUseGOT", i32 1}
!2 = !{i32 7, !"uwtable", i32 2}
!3 = !{!"rustc version 1.101.0-dev"}
!4 = !{i64 1519261260266597599}
!5 = !{!6}
!6 = distinct !{!6, !7, !"_RINvXs_NtNtNtCs6knCYbIatyh_4core4iter8adapters5chainINtB5_5ChainINtNtNtBb_3ops5range5RangexEB10_ENtNtNtB9_6traits8iterator8Iterator4foldxNCINvNtB7_10filter_map15filter_map_foldxxxNCNvCsiVlEIo5dfo6_5shape7chained0NCINvNtB7_3map8map_foldxxxINvNtBb_4hint9black_boxxENCINvXse_NtB1B_5accumxNtB4m_3Sum3sumINtB3t_3MapINtB2g_9FilterMapBO_B2R_EB3O_EE0E0E0EB2V_: %self"}
!7 = distinct !{!7, !"_RINvXs_NtNtNtCs6knCYbIatyh_4core4iter8adapters5chainINtB5_5ChainINtNtNtBb_3ops5range5RangexEB10_ENtNtNtB9_6traits8iterator8Iterator4foldxNCINvNtB7_10filter_map15filter_map_foldxxxNCNvCsiVlEIo5dfo6_5shape7chained0NCINvNtB7_3map8map_foldxxxINvNtBb_4hint9black_boxxENCINvXse_NtB1B_5accumxNtB4m_3Sum3sumINtB3t_3MapINtB2g_9FilterMapBO_B2R_EB3O_EE0E0E0EB2V_"}
!8 = !{i64 1360980647138731}
!9 = !{}
!10 = !{i64 -39079464993858339}
!11 = !{i64 5011988553785990342}
!12 = !{!13}
!13 = distinct !{!13, !14, !"_RINvYINtNtNtCs6knCYbIatyh_4core3ops5range5RangexENtNtNtNtBa_4iter6traits8iterator8Iterator8try_foldxNCINvNtNtBR_8adapters10filter_map19filter_map_try_foldxxxINtNtB8_9try_trait17NeverShortCircuitxENCNvCsiVlEIo5dfo6_5shape10single_ref0NCINvNtB1H_3map12map_try_foldxxxB2v_INvNtBa_4hint9black_boxxENCINvMB2y_B2v_10wrap_mut_2xxNCINvXse_NtBP_5accumxNtB5j_3Sum3sumQINtB3O_3MapINtB1F_9FilterMapB3_B38_EB4j_EE0E0E0E0B2v_EB3c_: %self"}
!14 = distinct !{!14, !"_RINvYINtNtNtCs6knCYbIatyh_4core3ops5range5RangexENtNtNtNtBa_4iter6traits8iterator8Iterator8try_foldxNCINvNtNtBR_8adapters10filter_map19filter_map_try_foldxxxINtNtB8_9try_trait17NeverShortCircuitxENCNvCsiVlEIo5dfo6_5shape10single_ref0NCINvNtB1H_3map12map_try_foldxxxB2v_INvNtBa_4hint9black_boxxENCINvMB2y_B2v_10wrap_mut_2xxNCINvXse_NtBP_5accumxNtB5j_3Sum3sumQINtB3O_3MapINtB1F_9FilterMapB3_B38_EB4j_EE0E0E0E0B2v_EB3c_"}
