word_98B0:
		dc.w    $18
		dc.w      6
		dc.w      1
		dc.w    $1F
		dc.w  $FFFF
		dc.w    $1F
		dc.w      0
		dc.w      0
		dc.w      8
		dc.w      6
		dc.w  $FFFF
		dc.w    $1F
		dc.w  $FFFF
		dc.w    $1F
		dc.w      0
		dc.w      0
		dc.w      8
		dc.w    $1A
		dc.w  $FFFF
		dc.w    $1F
		dc.w      1
		dc.w    $1F
		dc.w      0
		dc.w      0
		dc.w    $18
		dc.w    $1A
		dc.w      1
		dc.w    $1F
		dc.w      1
		dc.w    $1F
		dc.w      0
		dc.w      0
Draw_SSSprites:
		move.b	(Special_stage_angle).w,d0
		andi.w	#$C0,d0
		lsr.w	#2,d0
		lea	word_98B0(pc,d0.w),a5
		moveq	#0,d1
		move.b	(Special_stage_X_pos).w,d1
		move.w	(Special_stage_X_pos).w,d0
		addi.w	#$100,d0
		move.w	(Special_stage_Y_pos).w,d2
		andi.w	#$100,d2
		add.w	d2,d0
		btst	#6,(Special_stage_angle).w
		bne.s	loc_9930
		move.b	(Special_stage_Y_pos).w,d1
		move.w	(Special_stage_Y_pos).w,d0
		move.w	(Special_stage_X_pos).w,d2
		andi.w	#$100,d2
		add.w	d2,d0

loc_9930:
		tst.b	(Special_stage_angle).w
		bmi.s	loc_9946
		neg.w	d0
		addi.w	#$1F,d0
		move.w	d0,d2
		andi.w	#$E0,d2
		beq.s	loc_9946
		addq.b	#1,d1

loc_9946:
		andi.w	#$1E0,d0
		lsr.w	#5,d0
		move.w	d0,(Special_stage_anim_frame).w
		move.b	d0,(Special_stage_palette_frame).w
		move.b	(Special_stage_angle).w,d0
		andi.w	#$38,d0
		beq.s	loc_9968
		lsr.w	#3,d0
		addi.w	#$F,d0
		move.w	d0,(Special_stage_anim_frame).w

loc_9968:
		lea	(Draw_SSSprite_Normal).l,a0
		tst.w	(Special_stage_clear_timer).w
		beq.s	loc_997A
		lea	(Draw_SSSprite_FlyAway).l,a0

loc_997A:
		btst	#6,(Special_stage_angle).w
		bne.w	loc_9A3C
		move.w	2(a5),d5
		add.w	d1,d5
		and.w	$A(a5),d5
		move.w	(Special_stage_anim_frame).w,d0
		add.w	d0,d0
		add.w	d0,d0
		lea	(RAM_start).l,a1
		movea.l	(a1,d0.w),a1
		lea	(SStage_layout_buffer+$100).w,a2
		lea	(SStage_extra_sprites).w,a4
		lea	(Sprite_table).w,a6
		moveq	#$50-1,d7
		moveq	#0,d6
		move.b	(Sprites_drawn).w,d6
		sub.b	d6,d7
		lsl.w	#3,d6
		adda.w	d6,a6
		moveq	#$10-1,d2

loc_99BC:
		move.w	(a5),d4
		moveq	#0,d0
		move.b	(Special_stage_X_pos).w,d0
		add.w	d0,d4
		and.w	6(a5),d4
		moveq	#$F-1,d3

loc_99CC:
		move.w	d5,d0
		lsl.w	#5,d0
		or.b	d4,d0
		move.b	(a2,d0.w),d0
		beq.s	loc_9A20
		move.w	(a1),d1
		andi.w	#$7C,d1
		beq.s	loc_9A20
		lsr.w	#2,d1
		subq.w	#6,d1
		cmpi.w	#$10,d1
		bhs.s	loc_9A20
		add.w	d1,d1
		andi.w	#$FF,d0
		lsl.w	#3,d0
		movea.l	(a4,d0.w),a3
		move.w	4(a4,d0.w),d6
		cmpi.w	#$54,(a1)
		blo.s	loc_9A04
		andi.w	#$7FFF,d6

loc_9A04:
		move.w	6(a4,d0.w),d0
		add.w	d0,d0
		bcc.s	loc_9A0E
		moveq	#0,d1

loc_9A0E:
		add.w	d0,d1
		adda.w	(a3,d1.w),a3
		move.w	(a3)+,d1
		subq.w	#1,d1
		bmi.s	loc_9A20
		jsr	(a0)
		tst.w	d7
		bmi.s	locret_9A3A

loc_9A20:
		addq.w	#6,a1
		add.w	4(a5),d4
		and.w	6(a5),d4
		dbf	d3,loc_99CC
		add.w	8(a5),d5
		and.w	$A(a5),d5
		dbf	d2,loc_99BC

locret_9A3A:
		rts
; ---------------------------------------------------------------------------

loc_9A3C:
		move.w	2(a5),d5
		add.w	d1,d5
		and.w	$A(a5),d5
		move.w	(Special_stage_anim_frame).w,d0
		add.w	d0,d0
		add.w	d0,d0
		lea	(RAM_start).l,a1
		movea.l	(a1,d0.w),a1
		lea	(SStage_layout_buffer+$100).w,a2
		lea	(SStage_extra_sprites).w,a4
		lea	(Sprite_table).w,a6
		moveq	#$50-1,d7
		moveq	#0,d6
		move.b	(Sprites_drawn).w,d6
		sub.b	d6,d7
		lsl.w	#3,d6
		adda.w	d6,a6
		moveq	#$10-1,d2

loc_9A74:
		move.w	(a5),d4
		moveq	#0,d0
		move.b	(Special_stage_Y_pos).w,d0
		add.w	d0,d4
		and.w	6(a5),d4
		moveq	#$F-1,d3

loc_9A84:
		move.w	d4,d0
		lsl.w	#5,d0
		or.b	d5,d0
		move.b	(a2,d0.w),d0
		beq.s	loc_9AD8
		move.w	(a1),d1
		andi.w	#$7C,d1
		beq.s	loc_9AD8
		lsr.w	#2,d1
		subq.w	#6,d1
		cmpi.w	#$10,d1
		bhs.s	loc_9AD8
		add.w	d1,d1
		andi.w	#$FF,d0
		lsl.w	#3,d0
		movea.l	(a4,d0.w),a3
		move.w	4(a4,d0.w),d6
		cmpi.w	#$54,(a1)
		blo.s	loc_9ABC
		andi.w	#$7FFF,d6

loc_9ABC:
		move.w	6(a4,d0.w),d0
		add.w	d0,d0
		bcc.s	loc_9AC6
		moveq	#0,d1

loc_9AC6:
		add.w	d0,d1
		adda.w	(a3,d1.w),a3
		move.w	(a3)+,d1
		subq.w	#1,d1
		bmi.s	loc_9AD8
		jsr	(a0)
		tst.w	d7
		bmi.s	locret_9AF2

loc_9AD8:
		addq.w	#6,a1
		add.w	4(a5),d4
		and.w	6(a5),d4
		dbf	d3,loc_9A84
		add.w	8(a5),d5
		and.w	$A(a5),d5
		dbf	d2,loc_9A74

locret_9AF2:
		rts
; End of function Draw_SSSprites

; ---------------------------------------------------------------------------

Draw_SSSprite_Normal:
		move.b	(a3)+,d0
		ext.w	d0
		add.w	4(a1),d0
		move.w	d0,(a6)+
		move.b	(a3)+,(a6)+
		addq.w	#1,a6
		move.w	(a3)+,d0
		add.w	d6,d0
		move.w	d0,(a6)+
		move.w	(a3)+,d0
		add.w	2(a1),d0
		move.w	d0,(a6)+
		subq.w	#1,d7
		dbmi	d1,Draw_SSSprite_Normal
		rts
; ---------------------------------------------------------------------------

Draw_SSSprite_FlyAway:
		move.b	(a3)+,d0
		ext.w	d0
		add.w	4(a1),d0
		sub.w	(Special_stage_clear_timer).w,d0
		move.w	d0,(a6)+
		move.b	(a3)+,(a6)+
		addq.w	#1,a6
		move.w	(a3)+,d0
		add.w	d6,d0
		move.w	d0,(a6)+
		move.w	(a3)+,d0
		add.w	2(a1),d0
		move.w	d1,-(sp)
		subi.w	#$120,d0
		move.w	(Special_stage_clear_timer).w,d1
		addi.w	#$100,d1
		muls.w	d1,d0
		asr.l	#8,d0
		addi.w	#$120,d0
		cmpi.w	#$1D0,d0
		blo.s	loc_9B56
		move.w	#1,d0

loc_9B56:
		move.w	(sp)+,d1
		move.w	d0,(a6)+
		subq.w	#1,d7
		dbmi	d1,Draw_SSSprite_FlyAway
		rts

; =============== S U B R O U T I N E =======================================


sub_9B62:
		move.b	(Special_stage_clear_routine).w,d1
		beq.w	locret_9D1C
		subq.b	#1,d1
		bne.w	loc_9C5C
		cmpi.w	#$100,(Special_stage_clear_timer).w
		bhs.s	loc_9BA6
		addq.w	#2,(Special_stage_clear_timer).w
		cmpi.w	#2,(Special_stage_clear_timer).w
		bne.s	loc_9B8C
		move.w	#$D3,d0
		jsr	(Play_Music).l

loc_9B8C:
		cmpi.w	#$40,(Special_stage_clear_timer).w
		blo.s	locret_9BA4
		addq.w	#1,(Special_stage_clear_timer).w
		cmpi.w	#$80,(Special_stage_clear_timer).w
		blo.s	locret_9BA4
		addq.w	#1,(Special_stage_clear_timer).w

locret_9BA4:
		rts
; ---------------------------------------------------------------------------
; Set a VRAM address via the VDP control port.
; input: 16-bit VRAM address, control port (default is (vdp_control_port).l)
; ---------------------------------------------------------------------------

locVRAM:	macro loc,controlport
;		if ("controlport"=="")
		move.l	#($40000000+(((loc)&$3FFF)<<16)+(((loc)&$C000)>>14)),(VDP_control_port).l
;		else
;		move.l	#($40000000+(((loc)&$3FFF)<<16)+(((loc)&$C000)>>14)),controlport
;		endif
		endm
; ---------------------------------------------------------------------------

loc_9BA6:
		addq.b	#1,(Special_stage_clear_routine).w
		lea	(SStage_layout_buffer+$100).w,a1
		move.w	#bytesToLcnt($400),d0

loc_9BB2:
		move.l	#0,(a1)+
		dbf	d0,loc_9BB2
		move.b	(Special_stage_angle).w,d0
		jsr	(GetSineCosine).l
		move.w	(Special_stage_X_pos).w,d2
		move.w	(Special_stage_Y_pos).w,d3
		asl.w	#3,d0
		asl.w	#3,d1
		sub.w	d0,d2
		sub.w	d1,d3
		lea	(SStage_layout_buffer+$100).w,a1
		move.w	d2,d0
		addi.w	#$80,d0
		lsr.w	#8,d0
		andi.w	#$1F,d0
		move.w	d3,d1
		addi.w	#$80,d1
		lsr.w	#8,d1
		andi.w	#$1F,d1
		lsl.w	#5,d1
		or.b	d0,d1
		move.b	#$B,(a1,d1.w)
		tst.b	(SK_special_stage_flag).w
		beq.s	loc_9C08
		move.b	#$D,(a1,d1.w)

loc_9C08:
		move.w	d1,(Special_stage_interact).w
		move.w	#$800,(Special_stage_velocity).w
		move.b	#120,(Special_stage_emerald_timer).w
		moveq	#0,d0
		move.b	(Current_special_stage).w,d0
		tst.b	(Blue_spheres_stage_flag).w
		beq.s	loc_9C28
		move.b	(Blue_spheres_current_stage+2).w,d0

loc_9C28:
		andi.w	#7,d0
		lea	(Pal_SStage_Emeralds).l,a1
		lsl.w	#3,d0
		lea	(a1,d0.w),a1
		lea	(Normal_palette_line_4+$4).w,a2
		move.l	(a1)+,(a2)+
		move.l	(a1)+,(a2)+
		locVRAM $59B*$20
;		rts
		lea	(ArtKosM_SStageChaosEmerald).l,a0;1
		tst.b	(SK_special_stage_flag).w
		beq.s	loc_9C52
		lea	(ArtKosM_SStageSuperEmerald).l,a0;1
;
loc_9C52:
;		move.w	#tiles_to_bytes($59b),d2
		jmp	(NemDec).l;Queue_Kos_Module).l
; ---------------------------------------------------------------------------

loc_9C5C:
		subq.b	#1,d1
		bne.s	loc_9C80
		tst.b	(Kos_modules_left).w
		bne.s	locret_9C7E
		move.w	#0,(Special_stage_clear_timer).w
		subq.b	#1,(Special_stage_emerald_timer).w
		bne.s	locret_9C7E
		addq.b	#1,(Special_stage_clear_routine).w
		move.w	#MusID_Emerald,d0
		jsr	(Play_Music).l

locret_9C7E:
		rts
; ---------------------------------------------------------------------------

loc_9C80:
		subq.b	#1,d1
		bne.w	locret_9D1C
		move.w	(Special_stage_X_pos).w,d0
		addi.w	#$80,d0
		lsr.w	#8,d0
		andi.w	#$1F,d0
		move.w	(Special_stage_Y_pos).w,d1
		addi.w	#$80,d1
		lsr.w	#8,d1
		andi.w	#$1F,d1
		lsl.w	#5,d1
		or.b	d0,d1
		cmp.w	(Special_stage_interact).w,d1
		bne.s	locret_9D1C
		move.w	(Special_stage_X_pos).w,d0
		or.w	(Special_stage_Y_pos).w,d0
		andi.w	#$E0,d0
		bne.s	locret_9D1C
;		tst.b	(Blue_spheres_stage_flag).w
;		bne.s	loc_9CE6
		lea	(Chaos_emerald_count).w,a2
		move.b	(SK_special_stage_flag).w,d2
		beq.s	loc_9CCE
		lea	(Super_emerald_count).w,a2

loc_9CCE:
		cmpi.b	#7,(a2)
		bhs.s	loc_9CE6
		addq.b	#1,(a2)
		lea	(Collected_emeralds_array).w,a1
		moveq	#0,d0
		move.b	(Current_special_stage).w,d0
		bset	#0,(a1,d0.w)

loc_9CE6:
		addq.b	#1,(Special_stage_clear_routine).w
		move.b	#1,(Special_stage_fade_timer).w
		move.b	#$0C,(Game_mode).w	;Special Stage Results
;		tst.b	(Blue_spheres_stage_flag).w
;		beq.s	loc_9D02 ; What if they are not even there
 ;		move.b	#$0C,(Game_mode).w	;Blue Sphere results (they are different)
;
;loc_9D02:
;		tst.b	(Special_bonus_entry_flag).w
;		beq.s	loc_9D14
;		move.w	(Saved2_zone_and_act).w,(Current_zone_and_act).w
;		ori.b	#$80,(Last_star_post_hit).w

loc_9D14:
		move.w	#SndID_Signpost2P,d0
		jsr	(Play_Music).l
		jsr	loc_852E
locret_9D1C:
		rts
; End of function sub_9B62

; ---------------------------------------------------------------------------
Pal_SStage_Emeralds:
		binclude "General/Special Stage/Palettes/Emeralds.bin"
		even

; =============== S U B R O U T I N E =======================================


sb_9D5E:
		move.w	(Special_stage_X_pos).w,d0
		sub.w	(Special_stage_prev_X_pos).w,d0
		btst	#6,(Special_stage_angle).w
		bne.s	lc_9D76
		move.w	(Special_stage_Y_pos).w,d0
		sub.w	(Special_stage_prev_Y_pos).w,d0

lc_9D76:
		tst.b	(Special_stage_angle).w
		bmi.s	lc_9D7E
		neg.w	d0

lc_9D7E:
		asr.w	#2,d0
		add.w	d0,(V_scroll_value_BG).w
		moveq	#0,d1
		move.b	(Special_stage_angle).w,d1
		asl.w	#2,d1
		move.w	d1,(H_scroll_buffer+2).w
		move.w	(Special_stage_X_pos).w,(Special_stage_prev_X_pos).w
		move.w	(Special_stage_Y_pos).w,(Special_stage_prev_Y_pos).w
		rts
; End of function sub_9D5E
