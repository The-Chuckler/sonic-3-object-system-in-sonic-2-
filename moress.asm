Sonic3_Complete	=	1
; ---------------------------------------------------------------------------

; ---------------------------------------------------------------------------

; ---------------------------------------------------------------------------

;locret_98AE:
;		rts
; End of function sub_972E
Find_SStageCollisionResponseSlot:
		lea	(SStage_collision_response_list).l,a2
		move.w	#$20-1,d0

loc_9DD2:
		tst.b	(a2)
		beq.s	locret_9DDC
		addq.w	#8,a2
		dbf	d0,loc_9DD2

locret_9DDC:
		rts
; End of function Find_SStageCollisionResponseSlot
sub_A188:
		swap	d0
		move.w	d1,d3
		move.w	d2,d4
		move.w	(SStage_scalar_result_2).l,d0
		muls.w	d0,d3
		muls.w	d0,d4
		move.w	(SStage_scalar_result_2+2).l,d0
		muls.w	d0,d1
		muls.w	d0,d2
		sub.l	d4,d1
		add.l	d1,d1
		add.l	d1,d1
		swap	d1
		add.l	d3,d2
		add.l	d2,d2
		add.l	d2,d2
		swap	d2
		swap	d0
		rts
; End of function sub_A188


; =============== S U B R O U T I N E =======================================


sub_A1B2:
		swap	d2
		move.w	d0,d3
		move.w	d1,d4
		move.w	(SStage_scalar_result_1).l,d2
		muls.w	d2,d3
		muls.w	d2,d4
		move.w	(SStage_scalar_result_1+2).l,d2
		muls.w	d2,d0
		muls.w	d2,d1
		sub.l	d4,d0
		add.l	d0,d0
		add.l	d0,d0
		swap	d0
		add.l	d3,d1
		add.l	d1,d1
		add.l	d1,d1
		swap	d1
		swap	d2
		rts
; End of function sub_A1B2


; =============== S U B R O U T I N E =======================================


sub_A1DC:
		swap	d1
		move.w	d0,d3
		move.w	d2,d4
		move.w	(SStage_scalar_result_0).l,d1
		muls.w	d1,d3
		muls.w	d1,d4
		move.w	(SStage_scalar_result_0+2).l,d1
		muls.w	d1,d0
		muls.w	d1,d2
		sub.l	d4,d0
		add.l	d0,d0
		add.l	d0,d0
		swap	d0
		add.l	d3,d2
		add.l	d2,d2
		add.l	d2,d2
		swap	d2
		swap	d1
		rts
; End of function sub_A1DC


; =============== S U B R O U T I N E =======================================


sub_A206:
		swap	d1
		move.w	d0,d3
		move.w	d2,d4
		move.w	(SStage_scalar_result_3).l,d1
		muls.w	d1,d3
		muls.w	d1,d4
		move.w	(SStage_scalar_result_3+2).l,d1
		muls.w	d1,d0
		muls.w	d1,d2
		sub.l	d4,d0
		add.l	d0,d0
		add.l	d0,d0
		swap	d0
		add.l	d3,d2
		add.l	d2,d2
		add.l	d2,d2
		swap	d2
		swap	d1
		rts
; End of function sub_A206
Rotate_SSPal:
		tst.b	(Special_stage_fade_timer).w
		bne.s	locret_8818
		move.w	(Special_stage_anim_frame).w,d0
		cmpi.w	#$10,d0
		blo.s	loc_87F8
		tst.b	(Special_stage_turning).w
		bpl.s	locret_8818
		move.b	(Special_stage_palette_frame).w,d0
		andi.w	#$F,d0

loc_87F8:
		andi.w	#$E,d0
		neg.w	d0
		addi.w	#$10,d0
		movea.l	(Special_stage_palette_addr).w,a1
		lea	(a1,d0.w),a1
		lea	(Normal_palette_line_4+$10).w,a2
		move.w	#bytesToWcnt($10),d0

loc_8812:
		move.w	(a1)+,(a2)+
		dbf	d0,loc_8812

locret_8818:
		rts
; End of function Rotate_SSPal


; =============== S U B R O U T I N E =======================================


Update_SSMap:
		lea	(VDP_data_port).l,a6
		lea	(SS_Pal_Map_Ptrs).l,a1
		move.w	(Special_stage_anim_frame).w,d0
		cmp.b	(Special_stage_prev_anim_frame).w,d0
		beq.s	loc_8876
		move.b	d0,(Special_stage_prev_anim_frame).w
		lsl.w	#3,d0
		movea.l	(a1,d0.w),a3
		lea	$10E(a3),a1
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$19E,VRAM,WRITE),(VDP_control_port).l	; VRAM write $C19E
		moveq	#$A-1,d1

loc_884A:
		move.w	(a1)+,(a6)
		dbf	d1,loc_884A
		lea	$140(a3),a3
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$200,VRAM,WRITE),d0		; VRAM write $C200
		moveq	#$28-1,d1
		moveq	#$18-1,d2
		move.l	#$80<<16,d4

loc_8864:
		move.l	d0,VDP_control_port-VDP_data_port(a6)
		move.w	d1,d3

loc_886A:
		move.w	(a3)+,(a6)
		dbf	d3,loc_886A
		add.l	d4,d0
		dbf	d2,loc_8864

loc_8876:
		tst.b	(Special_stage_sphere_HUD_flag).w
		beq.s	loc_8890
		move.b	#0,(Special_stage_sphere_HUD_flag).w
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$086,VRAM,WRITE),d0	; VRAM write $C086
		move.w	(Special_stage_spheres_left).w,d1
		jsr	Draw_SSNum

loc_8890:
		tst.b	(Special_stage_extra_life_flags).w
		bpl.s	locret_88B4
		bclr	#7,(Special_stage_extra_life_flags).w
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$0BE,VRAM,WRITE),d0	; VRAM write $C0BE
		move.w	(Special_stage_ring_count).w,d1
		tst.b	(Blue_spheres_stage_flag).w
		beq.s	loc_88B0
		move.w	(Special_stage_rings_left).w,d1

loc_88B0:
		jsr	Draw_SSNum

locret_88B4:
		rts
; End of function Update_SSMap

; ---------------------------------------------------------------------------
SS_Pal_Map_Ptrs:
		dc.l RAM_start+$5500
		dc.l Pal_SStage_3_1
		dc.l RAM_start+$5DC0
		dc.l Pal_SStage_3_1
		dc.l RAM_start+$5500
		dc.l Pal_SStage_3_2
		dc.l RAM_start+$5DC0
		dc.l Pal_SStage_3_2
		dc.l RAM_start+$5500
		dc.l Pal_SStage_3_3
		dc.l RAM_start+$5DC0
		dc.l Pal_SStage_3_3
		dc.l RAM_start+$5500
		dc.l Pal_SStage_3_4
		dc.l RAM_start+$5DC0
		dc.l Pal_SStage_3_4
		dc.l RAM_start+$5500
		dc.l Pal_SStage_3_5
		dc.l RAM_start+$5DC0
		dc.l Pal_SStage_3_5
		dc.l RAM_start+$5500
		dc.l Pal_SStage_3_6
		dc.l RAM_start+$5DC0
		dc.l Pal_SStage_3_6
		dc.l RAM_start+$5500
		dc.l Pal_SStage_3_7
		dc.l RAM_start+$5DC0
		dc.l Pal_SStage_3_7
		dc.l RAM_start+$5500
		dc.l Pal_SStage_3_8
		dc.l RAM_start+$5DC0
		dc.l Pal_SStage_3_8
		dc.l RAM_start+$9B00
		dc.l Pal_SStage_3_1
		dc.l RAM_start+$9240
		dc.l Pal_SStage_3_1
		dc.l RAM_start+$8980
		dc.l Pal_SStage_3_1
		dc.l RAM_start+$80C0
		dc.l Pal_SStage_3_1
		dc.l RAM_start+$7800
		dc.l Pal_SStage_3_1
		dc.l RAM_start+$6F40
		dc.l Pal_SStage_3_1
		dc.l RAM_start+$6680
		dc.l Pal_SStage_3_1
;Pal_SStage_Main:
;		binclude "General/Special Stage/Palettes/Main.bin"
;		even
Pal_SStage_Knux:
		binclude "General/Special Stage/Palettes/Knux Patch.bin"
		even
Pal_SStage_3_1:
		binclude "General/Special Stage/Palettes/3-1.bin"
		even
Pal_SStage_3_2:
		binclude "General/Special Stage/Palettes/3-2.bin"
		even
Pal_SStage_3_3:
		binclude "General/Special Stage/Palettes/3-3.bin"
		even
Pal_SStage_3_4:
		binclude "General/Special Stage/Palettes/3-4.bin"
		even
Pal_SStage_3_5:
		binclude "General/Special Stage/Palettes/3-5.bin"
		even
Pal_SStage_3_6:
		binclude "General/Special Stage/Palettes/3-6.bin"
		even
Pal_SStage_3_7:
		binclude "General/Special Stage/Palettes/3-7.bin"
		even
Pal_SStage_3_8:
		binclude "General/Special Stage/Palettes/3-8.bin"
		even
Pal_SStage_K_1:
		binclude "General/Special Stage/Palettes/K-1.bin"
		even
Pal_SStage_K_2:
		binclude "General/Special Stage/Palettes/K-2.bin"
		even
Pal_SStage_K_3:
		binclude "General/Special Stage/Palettes/K-3.bin"
		even
Pal_SStage_K_4:
		binclude "General/Special Stage/Palettes/K-4.bin"
		even
Pal_SStage_K_5:
		binclude "General/Special Stage/Palettes/K-5.bin"
		even
Pal_SStage_K_6:
		binclude "General/Special Stage/Palettes/K-6.bin"
		even
Pal_SStage_K_7:
		binclude "General/Special Stage/Palettes/K-7.bin"
		even
Pal_SStage_K_8:
		binclude "General/Special Stage/Palettes/K-8.bin"
		even

; =============== S U B R O U T I N E =======================================


Draw_SSNum:
		lea	(SSNum_Precision).l,a2
		moveq	#3-1,d6
		lea	MapUnc_SSNum(pc),a1

loc_8C6A:
		moveq	#0,d2
		move.w	(a2)+,d3

loc_8C6E:
		sub.w	d3,d1
		bcs.s	loc_8C76
		addq.w	#1,d2
		bra.s	loc_8C6E
; ---------------------------------------------------------------------------

loc_8C76:
		add.w	d3,d1
		move.l	d0,VDP_control_port-VDP_data_port(a6)
		add.w	d2,d2
		add.w	d2,d2
		lea	(a1,d2.w),a3
		move.l	(a3),(a6)
		addi.l	#$80<<16,d0
		move.l	d0,VDP_control_port-VDP_data_port(a6)
		move.l	$28(a3),(a6)
		addi.l	#$80<<16,d0
		move.l	d0,VDP_control_port-VDP_data_port(a6)
		move.l	$50(a3),(a6)
		subi.l	#$FC<<16,d0
		dbf	d6,loc_8C6A
		rts
; End of function Draw_SSNum

; ---------------------------------------------------------------------------
SSNum_Precision:
		dc.w 100
		dc.w 10
		dc.w 1
MapUnc_SSNum:
		binclude "General/Special Stage/Uncompressed Map/HUD Numbers.bin"
		even
; Create_New_Sprite2:
;AllocateObjectAfterCurrent_SpecialStage:
;		movea.l	a0,a1
;		move.w	#Object_RAM_end-object_size,d0
;		sub.w	a0,d0
;		lsr.w	#6,d0
;		move.b	.lookup(pc,d0.w),d0
;		bmi.s	.return
;
;.loop:
;		lea	next_object(a1),a1
;		tst.l	(a1)
;		dbeq	d0,.loop
;
;.return:
;		rts
;
;.lookup:
;.a		set	Object_RAM-object_size*2	; Oddly, this does too many object slots.
;.b		set	Object_RAM_end-object_size
;.c		set	.b				; begin from bottom of array and decrease backwards
		; There's a mistake here: this division should be rounded up,
		; otherwise the first object slot might not get an entry.
		; In this case, the aforementioned surplus entries counteract this problem.
;		rept	(.b-.a)/$40			; repeat for all slots, minus exception
;.c		set	.c-$40				; address for previous $40 (also skip last part)
;		dc.b	(.b-.c-1)/object_size-1		; write possible slots according to object_size division + hack + dbf hack
;		endm
;		even
; End of function AllocateObjectAfterCurrent_SpecialStage
SSLayoutOffs_RAM:
		dc.l RAM_start+$0000
		dc.l RAM_start+$0408
		dc.l RAM_start+$0810
		dc.l RAM_start+$0C18
		dc.l RAM_start+$1020
		dc.l RAM_start+$1428
		dc.l RAM_start+$1830
		dc.l RAM_start+$1C38

; =============== S U B R O U T I N E =======================================


sub_85B0:
		tst.b	(Blue_spheres_stage_flag).w
		bne.w	loc_86C8
		lea	(SSCompressedLayoutPtrs).l,a0
		movea.l	(a0),a0
		lea	(RAM_start).l,a1
		jsr	J_Kos_Decomp
		lea	(SStageLayoutPtrs).l,a2
		move.b	(Chaos_emerald_count).w,d3
		tst.w	(SK_alone_flag).w
		beq.s	loc_85E4
		lea	(SSLayoutOffs_RAM).l,a2
		moveq	#0,d2
		bra.s	loc_85F4
; ---------------------------------------------------------------------------

loc_85E4:
		move.b	(SK_special_stage_flag).w,d2
		beq.s	loc_85F4
		lea	(SSLayoutOffs_RAM).l,a2
		move.b	(Super_emerald_count).w,d3

loc_85F4:
		tst.b	(Debug_options_flag).w
		beq.s	loc_8606
		move.w	(Sound_test_sound).w,d0
		btst	#button_A,(Ctrl_1).w
		bne.s	loc_8630

loc_8606:
		moveq	#0,d0
		move.b	(Current_special_stage).w,d0
		cmpi.b	#7,d3
		bhs.s	loc_8630
		moveq	#5,d1
		lea	(Collected_emeralds_array).w,a1
		add.b	d2,d2

loc_861A:
		cmp.b	(a1,d0.w),d2
		beq.s	loc_8630
		addq.w	#1,d0
		cmpi.w	#7,d0
		blo.s	loc_861A
		moveq	#0,d0
		dbf	d1,loc_861A
		moveq	#7,d0

loc_8630:
		andi.w	#7,d0
		move.b	d0,(Current_special_stage).w
		move.w	d0,d1
		lsl.w	#2,d0
		movea.l	(a2,d0.w),a2
		lea	(SStage_layout_buffer).w,a3
		moveq	#0,d2
		move.w	#bytesToLcnt($100),d0

loc_865C:
		move.l	d2,(a3)+
		dbf	d0,loc_865C
		move.w	#bytesToLcnt($400),d0

loc_8666:
		move.l	(a2)+,(a3)+
		dbf	d0,loc_8666
		move.w	#bytesToLcnt($100),d0

loc_8670:
		move.l	d2,(a3)+
		dbf	d0,loc_8670
		move.w	(a2)+,(Special_stage_angle).w
		move.w	(a2)+,(Special_stage_X_pos).w
		move.w	(a2)+,(Special_stage_Y_pos).w
		move.w	(a2)+,(Special_stage_rings_left).w
		lsl.w	#4,d1
		lea	(SS_Pal_Map_Ptrs).l,a1
		lea	(Target_palette).w,a2
		movea.l	4(a1,d1.w),a1
		tst.w	(SK_alone_flag).w
		bne.s	loc_86A2
		tst.b	(SK_special_stage_flag).w
		beq.s	loc_86A6

loc_86A2:
		lea	$130(a1),a1

loc_86A6:
		move.l	a1,(Special_stage_palette_addr).w
		move.l	(a1)+,$70(a2)
		move.l	(a1)+,$74(a2)
		move.l	(a1)+,$78(a2)
		move.l	(a1)+,$7C(a2)
		move.l	$10(a1),$50(a2)
		move.w	$14(a1),$54(a2)
		rts
; ---------------------------------------------------------------------------

loc_86C8:
		lea	(SSCompressedLayoutPtrs).l,a0
		movea.l	4(a0),a0
		lea	(RAM_start).l,a1
		jsr	J_Kos_Decomp
		lea	(SStage_layout_buffer).w,a3
		moveq	#0,d2
		move.w	#bytesToLcnt($600),d0

loc_86E6:
		move.l	d2,(a3)+
		dbf	d0,loc_86E6
		move.b	#0,(Current_special_stage).w
		move.w	#$4000,(Special_stage_angle).w
		move.w	#$1000,(Special_stage_X_pos).w
		move.w	#$300,(Special_stage_Y_pos).w
		clr.w	(Special_stage_rings_left).w
		clr.w	(Blue_spheres_difficulty).w
		lea	(Blue_spheres_current_stage).w,a4
		lea	word_87BA(pc),a1
		moveq	#4-1,d7

loc_8716:
		lea	(RAM_start).l,a2
		move.b	(a4)+,d0
		andi.w	#$7F,d0
		moveq	#0,d1
		move.b	(a2,d0.w),d1
		add.w	d1,(Special_stage_rings_left).w
		lea	$80(a2),a2
		moveq	#0,d1
		move.b	(a2,d0.w),d1
		add.w	d1,(Blue_spheres_difficulty).w
		lea	$80(a2),a2
		lsl.w	#8,d0
		lea	(a2,d0.w),a2
		move.w	(a1)+,d3
		move.w	(a1)+,d4
		move.w	(a1)+,d5
		move.w	(a1)+,d0
		lea	(SStage_layout_buffer+$100).w,a3
		lea	(a3,d0.w),a3
		moveq	#$F,d0

loc_8756:
		move.w	d4,d2
		moveq	#$10-1,d1

loc_875A:
		move.b	(a2,d2.w),(a3)+
		add.w	d3,d2
		dbf	d1,loc_875A
		lea	$10(a3),a3
		add.w	d5,d4
		dbf	d0,loc_8756
		dbf	d7,loc_8716
		moveq	#0,d1
		move.b	(Blue_spheres_current_stage+2).w,d1
		move.w	d1,d2
		andi.w	#7,d1
		lsl.w	#4,d1
		lea	(SS_Pal_Map_Ptrs).l,a1
		lea	(Target_palette).w,a2
		movea.l	4(a1,d1.w),a1
		andi.w	#8,d2
		beq.s	loc_8798
		lea	$130(a1),a1

loc_8798:
		move.l	a1,(Special_stage_palette_addr).w
		move.l	(a1)+,$70(a2)
		move.l	(a1)+,$74(a2)
		move.l	(a1)+,$78(a2)
		move.l	(a1)+,$7C(a2)
		move.l	$10(a1),$50(a2)
		move.w	$14(a1),$54(a2)
		rts
; End of function sub_85B0
; End of function sub_85B0
SSCompressedLayoutPtrs:
		dc.l SSLayoutData1_Kos
		dc.l SSLayoutData2_Kos
SSLayoutData1_Kos:
		binclude "General/Special Stage/Layout/SK Set 1.bin"
		even
SSLayoutData2_Kos:
		binclude "General/Special Stage/Layout/SK Set 2.bin"
		even
SStageLayoutPtrs:
		dc.l SStage1_Layout
		dc.l SStage2_Layout
		dc.l SStage3_Layout
		dc.l SStage4_Layout
		dc.l SStage5_Layout
		dc.l SStage6_Layout
		dc.l SStage7_Layout
		dc.l SStage8_Layout
SStage1_Layout:	binclude "General/Special Stage/Layout/S3 1.bin"
		even
SStage2_Layout:	binclude "General/Special Stage/Layout/S3 2.bin"
		even
SStage3_Layout:	binclude "General/Special Stage/Layout/S3 3.bin"
		even
SStage4_Layout:	binclude "General/Special Stage/Layout/S3 4.bin"
		even
SStage5_Layout:	binclude "General/Special Stage/Layout/S3 5.bin"
		even
SStage6_Layout:	binclude "General/Special Stage/Layout/S3 6.bin"
		even
SStage7_Layout:	binclude "General/Special Stage/Layout/S3 7.bin"
		even
SStage8_Layout:	binclude "General/Special Stage/Layout/S3 8.bin"
		even
word_87BA:
		dc.w      1
		dc.w      0
		dc.w    $10
		dc.w      0
		dc.w  $FFFF
		dc.w     $F
		dc.w    $10
		dc.w    $10
		dc.w      1
		dc.w    $F0
		dc.w  $FFF0
		dc.w   $200
		dc.w  $FFFF
		dc.w    $FF
		dc.w  $FFF0
		dc.w   $210
