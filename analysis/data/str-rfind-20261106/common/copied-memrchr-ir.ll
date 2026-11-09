define dso_local { i64, i64 } @copied_memrchr(i8 noundef %0, ptr noalias nofree noundef nonnull readonly captures(address, read_provenance) %text.0, i64 noundef range(i64 0, -9223372036854775808) %text.1) unnamed_addr #2 personality ptr @rust_eh_personality !guid !338 {
start:
  %addr.i.i = ptrtoint ptr %text.0 to i64
  %_9.i.i = add i64 %addr.i.i, 7
  %aligned_address.i.i = and i64 %_9.i.i, -8
  %byte_offset.i.i = sub i64 %aligned_address.i.i, %addr.i.i
  %_12.i.i = icmp ult i64 %byte_offset.i.i, 8
  tail call void @llvm.assume(i1 %_12.i.i)
  %_6.i = icmp samesign ugt i64 %byte_offset.i.i, %text.1
  br i1 %_6.i, label %bb14, label %_RINvMNtCshp6Wxz1DwXO_4core5sliceSh8align_toTjjEECsc0zNMb1uo1d_6probes.exit

_RINvMNtCshp6Wxz1DwXO_4core5sliceSh8align_toTjjEECsc0zNMb1uo1d_6probes.exit: ; preds = %start
  %len.i.i.i = sub nuw nsw i64 %text.1, %byte_offset.i.i
  %ts_len.i.i = and i64 %len.i.i.i, 15
  %1 = sub nsw i64 %text.1, %ts_len.i.i
  %_43 = icmp samesign ugt i64 %ts_len.i.i, %text.1
  br i1 %_43, label %bb13, label %bb14, !prof !339

bb14:                                             ; preds = %start, %_RINvMNtCshp6Wxz1DwXO_4core5sliceSh8align_toTjjEECsc0zNMb1uo1d_6probes.exit
  %2 = phi i64 [ %1, %_RINvMNtCshp6Wxz1DwXO_4core5sliceSh8align_toTjjEECsc0zNMb1uo1d_6probes.exit ], [ %text.1, %start ]
  %byte_offset.i.sink.i31 = phi i64 [ %byte_offset.i.i, %_RINvMNtCshp6Wxz1DwXO_4core5sliceSh8align_toTjjEECsc0zNMb1uo1d_6probes.exit ], [ %text.1, %start ]
  %_49 = getelementptr inbounds nuw i8, ptr %text.0, i64 %2
  %gepdiff = sub nuw nsw i64 %text.1, %2
  %3 = icmp samesign eq i64 %2, %text.1
  br i1 %3, label %bb4, label %bb6.i.lr.ph

bb6.i.lr.ph:                                      ; preds = %bb14
  %_53 = getelementptr inbounds nuw i8, ptr %text.0, i64 %text.1
  br label %bb6.i

bb4.i:                                            ; preds = %bb6.i
  %4 = icmp eq ptr %_49, %_23.i.i
  br i1 %4, label %bb4, label %bb6.i

bb6.i:                                            ; preds = %bb6.i.lr.ph, %bb4.i
  %i.sroa.0.0.i40 = phi i64 [ %gepdiff, %bb6.i.lr.ph ], [ %5, %bb4.i ]
  %_6.i6.i39 = phi ptr [ %_53, %bb6.i.lr.ph ], [ %_23.i.i, %bb4.i ]
  %_23.i.i = getelementptr inbounds i8, ptr %_6.i6.i39, i64 -1
  %5 = add i64 %i.sroa.0.0.i40, -1
  %.val.i = load i8, ptr %_23.i.i, align 1, !noalias !340, !noundef !70
  %_0.i.i = icmp eq i8 %.val.i, %0
  br i1 %_0.i.i, label %bb3, label %bb4.i

bb13:                                             ; preds = %_RINvMNtCshp6Wxz1DwXO_4core5sliceSh8align_toTjjEECsc0zNMb1uo1d_6probes.exit
; call core::slice::index::slice_index_fail
  tail call void @_RNvNtNtCshp6Wxz1DwXO_4core5slice5index16slice_index_fail(i64 noundef %1, i64 noundef %text.1, i64 noundef %text.1, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(24) @alloc_3d26d86a09d4c08e50f7e3a9c381d0f1) #29
  unreachable

bb3:                                              ; preds = %bb6.i
  %cond.i = icmp ult i64 %5, %gepdiff
  tail call void @llvm.assume(i1 %cond.i)
  %_19 = add i64 %5, %2
  br label %bb12

bb4:                                              ; preds = %bb4.i, %bb14
  %_21 = zext i8 %0 to i64
  %repeated_x = mul nuw i64 %_21, 72340172838076673
  br label %bb5

bb12:                                             ; preds = %_RINvXs2J_NtNtCshp6Wxz1DwXO_4core5slice4iterINtB7_4IterhENtNtNtNtBb_4iter6traits8iterator8Iterator9rpositionNCNvNtCsc0zNMb1uo1d_6probes4word14copied_memrchrs_0EB1N_.exit, %bb3
  %.pn = phi { i64, i64 } [ { i64 1, i64 poison }, %bb3 ], [ %16, %_RINvXs2J_NtNtCshp6Wxz1DwXO_4core5slice4iterINtB7_4IterhENtNtNtNtBb_4iter6traits8iterator8Iterator9rpositionNCNvNtCsc0zNMb1uo1d_6probes4word14copied_memrchrs_0EB1N_.exit ]
  %_19.pn = phi i64 [ %_19, %bb3 ], [ %_0.sroa.3.0.i25, %_RINvXs2J_NtNtCshp6Wxz1DwXO_4core5slice4iterINtB7_4IterhENtNtNtNtBb_4iter6traits8iterator8Iterator9rpositionNCNvNtCsc0zNMb1uo1d_6probes4word14copied_memrchrs_0EB1N_.exit ]
  %.merged = insertvalue { i64, i64 } %.pn, i64 %_19.pn, 1
  ret { i64, i64 } %.merged

bb5:                                              ; preds = %bb6, %bb4
  %max_aligned_offset.sroa.0.0 = phi i64 [ %2, %bb4 ], [ %_27, %bb6 ]
  %_22 = icmp ugt i64 %max_aligned_offset.sroa.0.0, %byte_offset.i.sink.i31
  br i1 %_22, label %bb6, label %bb10

bb6:                                              ; preds = %bb5
  %_27 = add i64 %max_aligned_offset.sroa.0.0, -16
  %_26 = getelementptr inbounds nuw i8, ptr %text.0, i64 %_27
  %u = load i64, ptr %_26, align 8, !noundef !70
  %6 = getelementptr i8, ptr %text.0, i64 %max_aligned_offset.sroa.0.0
  %_31 = getelementptr i8, ptr %6, i64 -8
  %v = load i64, ptr %_31, align 8, !noundef !70
  %_35 = xor i64 %u, %repeated_x
  %7 = sub i64 72340172838076672, %_35
  %8 = or i64 %7, %_35
  %_37 = xor i64 %v, %repeated_x
  %9 = sub i64 72340172838076672, %_37
  %10 = or i64 %9, %_37
  %11 = and i64 %8, -9187201950435737472
  %12 = and i64 %11, %10
  %brmerge.not = icmp eq i64 %12, -9187201950435737472
  br i1 %brmerge.not, label %bb5, label %bb10

bb10:                                             ; preds = %bb6, %bb5
  %_66.not = icmp ugt i64 %max_aligned_offset.sroa.0.0, %text.1
  br i1 %_66.not, label %bb16, label %bb15, !prof !300

bb16:                                             ; preds = %bb10
; call core::slice::index::slice_index_fail
  tail call void @_RNvNtNtCshp6Wxz1DwXO_4core5slice5index16slice_index_fail(i64 noundef 0, i64 noundef %max_aligned_offset.sroa.0.0, i64 noundef %text.1, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(24) @alloc_f77b16add3c824dd405a5b8eb5c54c47) #29
  unreachable

bb15:                                             ; preds = %bb10
  %13 = icmp samesign eq i64 %max_aligned_offset.sroa.0.0, 0
  br i1 %13, label %_RINvXs2J_NtNtCshp6Wxz1DwXO_4core5slice4iterINtB7_4IterhENtNtNtNtBb_4iter6traits8iterator8Iterator9rpositionNCNvNtCsc0zNMb1uo1d_6probes4word14copied_memrchrs_0EB1N_.exit, label %bb6.i19.lr.ph

bb6.i19.lr.ph:                                    ; preds = %bb15
  %_75 = getelementptr inbounds nuw i8, ptr %text.0, i64 %max_aligned_offset.sroa.0.0
  br label %bb6.i19

bb4.i16:                                          ; preds = %bb6.i19
  %14 = icmp eq ptr %text.0, %_23.i.i20
  br i1 %14, label %_RINvXs2J_NtNtCshp6Wxz1DwXO_4core5slice4iterINtB7_4IterhENtNtNtNtBb_4iter6traits8iterator8Iterator9rpositionNCNvNtCsc0zNMb1uo1d_6probes4word14copied_memrchrs_0EB1N_.exit, label %bb6.i19

bb6.i19:                                          ; preds = %bb6.i19.lr.ph, %bb4.i16
  %i.sroa.0.0.i1842 = phi i64 [ %max_aligned_offset.sroa.0.0, %bb6.i19.lr.ph ], [ %15, %bb4.i16 ]
  %_6.i6.i1741 = phi ptr [ %_75, %bb6.i19.lr.ph ], [ %_23.i.i20, %bb4.i16 ]
  %_23.i.i20 = getelementptr inbounds i8, ptr %_6.i6.i1741, i64 -1
  %15 = add i64 %i.sroa.0.0.i1842, -1
  %.val.i21 = load i8, ptr %_23.i.i20, align 1, !noalias !344, !noundef !70
  %_0.i.i22 = icmp eq i8 %.val.i21, %0
  br i1 %_0.i.i22, label %bb8.i23, label %bb4.i16

bb8.i23:                                          ; preds = %bb6.i19
  %cond.i24 = icmp ult i64 %15, %max_aligned_offset.sroa.0.0
  tail call void @llvm.assume(i1 %cond.i24)
  br label %_RINvXs2J_NtNtCshp6Wxz1DwXO_4core5slice4iterINtB7_4IterhENtNtNtNtBb_4iter6traits8iterator8Iterator9rpositionNCNvNtCsc0zNMb1uo1d_6probes4word14copied_memrchrs_0EB1N_.exit

_RINvXs2J_NtNtCshp6Wxz1DwXO_4core5slice4iterINtB7_4IterhENtNtNtNtBb_4iter6traits8iterator8Iterator9rpositionNCNvNtCsc0zNMb1uo1d_6probes4word14copied_memrchrs_0EB1N_.exit: ; preds = %bb4.i16, %bb15, %bb8.i23
  %_0.sroa.3.0.i25 = phi i64 [ %15, %bb8.i23 ], [ undef, %bb15 ], [ undef, %bb4.i16 ]
  %_0.sroa.0.0.i26 = phi i64 [ 1, %bb8.i23 ], [ 0, %bb15 ], [ 0, %bb4.i16 ]
  %16 = insertvalue { i64, i64 } poison, i64 %_0.sroa.0.0.i26, 0
  br label %bb12
}