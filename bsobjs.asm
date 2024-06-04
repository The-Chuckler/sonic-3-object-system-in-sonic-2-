Obj_SStage_8DF8:
		move.b	#$80,width_pixels(a0)
		move.b	#$80,height_pixels(a0)
		move.w	#0,priority(a0)
		move.l	#Map_SSIcons,mappings(a0)
		move.w	#make_art_tile($589,2,1),art_tile(a0)
		move.w	#$120,x_pos(a0)
		move.w	#$94,y_pos(a0)
		move.l	#loc_8E2A,(a0)

loc_8E2A:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
Map_SSIcons:
		include "General/Special Stage/Map - Icons.asm"
Obj_SStage_8E40:
		jsr	(AllocateObjectAfterCurrent_SpecialStage).l
		bne.w	loc_8E5C
		move.l	#loc_8E5C,(a1)
		bset	#0,status(a1)
		move.b	#1,mapping_frame(a1)

loc_8E5C:
		move.b	#$80,width_pixels(a0)
		move.b	#$80,height_pixels(a0)
		move.w	#0,priority(a0)
		move.l	#Map_GetBlueSpheres,mappings(a0)
		move.w	#make_art_tile($573,1,1),art_tile(a0)
		move.w	#$120,x_pos(a0)
		move.w	#$E8,y_pos(a0)
		move.w	#3*60,move_lock(a0)
		move.l	#loc_8E94,(a0)

loc_8E94:
		tst.w	move_lock(a0)
		beq.s	loc_8EA4
		subq.w	#1,move_lock(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_8EA4:
		cmpi.w	#$C0,flips_remaining(a0)
		blo.s	loc_8ECA
		move.l	#loc_8EEC,(a0)
		addq.b	#2,mapping_frame(a0)
		tst.w	(Special_stage_velocity).w
		bne.s	loc_8ED0
		move.b	#1,(Special_stage_advancing).w
		move.b	#1,(Special_stage_started).w
		bra.s	loc_8ED0
; ---------------------------------------------------------------------------

loc_8ECA:
		addi.w	#$10,flips_remaining(a0)

loc_8ED0:
		move.w	flips_remaining(a0),d0
		btst	#0,status(a0)
		bne.s	loc_8EDE
		neg.w	d0

loc_8EDE:
		addi.w	#$120,d0
		move.w	d0,x_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_8EEC:
		tst.w	(Special_stage_rings_left).w
		beq.s	loc_8EF4
		rts
; ---------------------------------------------------------------------------

loc_8EF4:
		subi.w	#$10,flips_remaining(a0)
		bne.s	loc_8F08
		move.l	#loc_8F24,(a0)
		move.w	#180,move_lock(a0)

loc_8F08:
		move.w	flips_remaining(a0),d0
		btst	#0,status(a0)
		bne.s	loc_8F16
		neg.w	d0

loc_8F16:
		addi.w	#$120,d0
		move.w	d0,x_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_8F24:
		tst.w	move_lock(a0)
		beq.s	loc_8F34
		subq.w	#1,move_lock(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_8F34:
		cmpi.w	#$C0,flips_remaining(a0)
		bhs.s	loc_8F42
		addi.w	#$10,flips_remaining(a0)

loc_8F42:
		move.w	flips_remaining(a0),d0
		btst	#0,status(a0)
		bne.s	loc_8F50
		neg.w	d0

loc_8F50:
		addi.w	#$120,d0
		move.w	d0,x_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
Map_GetBlueSpheres:
		include "General/Special Stage/Map - Get Blue Spheres.asm"
; ---------------------------------------------------------------------------
Obj_SStage_8FAA:
;		cmpi.w	#2,(Player_mode).w
;		bne.s	+
;		move.l	#Map_SStageTails,mappings(a0)
;		move.w	#make_art_tile($7A0,1,1),art_tile(a0)
;		jsr	(AllocateObjectAfterCurrent_SpecialStage).l
;		bne.w	loc_8FFA
;		move.l	#Obj_SStage_9444,(a1)
;		move.w	a0,$3E(a1)
;		bra.s	loc_8FFA
;		jmp	loc_8FFA
;+
;		move.l	#Map_SStageSonic,mappings(a0)
;		move.w	#make_art_tile($7A0,0,1),art_tile(a0)


;loc_8FFA:
		move.b	#4,render_flags(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$10,height_pixels(a0)
		move.w	#$200,priority(a0)
		move.l	#Map_SStageSonic,mappings(a0)
		move.w	#make_art_tile($7A0,0,1),art_tile(a0);7D4,0,1),art_tile(a0)
		cmpi.w	#2,(Player_mode).w
		bne.s	loc_8FFA
		move.l	#Map_SStageTails,mappings(a0)
		move.w	#make_art_tile($7A0,1,1),art_tile(a0)
		jsr	(AllocateObjectAfterCurrent_SpecialStage).l
		bne.w	loc_8FFA
		move.l	#Obj_SStage_9444,(a1)
		move.w	a0,$3E(a1)
loc_8FFA:
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_9010
		move.l	#Map_SStageKnuckles,mappings(a0)
		move.w	#make_art_tile($7D4,0,1),art_tile(a0)

;loc_9010:
loc_9010:
		move.w	#$A0,flips_remaining(a0)
		move.w	#$70,move_lock(a0)
		move.w	#0,LastLoadedDPLC(a0)
		move.w	#$F800,speed_shoes_timer(a0)
		jsr	sub_950C
		move.b	#$FF,next_tilt(a0)
		move.l	#loc_903E,(a0)

loc_903E:
		tst.w	(Special_stage_rate_timer).w
		beq.s	loc_907E
		subq.w	#1,(Special_stage_rate_timer).w
		bne.s	loc_907E
		move.w	#30*60,(Special_stage_rate_timer).w
		tst.b	(Blue_spheres_stage_flag).w
		beq.s	loc_905C
		move.w	#45*60,(Special_stage_rate_timer).w

loc_905C:
		cmpi.w	#$2000,(Special_stage_rate).w
		beq.s	loc_907E
		addi.w	#$400,(Special_stage_rate).w
		move.b	(Special_stage_rate).w,d0
		subi.b	#$20,d0
		neg.b	d0
		add.b	d0,d0
		addq.b	#8,d0
		jsr	(Change_Music_Tempo).l

loc_907E:
		jsr	sub_9580
		moveq	#$C,d0
		move.w	(Special_stage_velocity).w,d1
		beq.s	loc_90A8
		asr.w	#5,d1
		add.w	d1,anim_frame_timer(a0)
		moveq	#0,d0
		move.b	anim_frame_timer(a0),d0
		bpl.s	loc_909E
		addi.b	#$C,d0
		bra.s	loc_90A8
; ---------------------------------------------------------------------------

loc_909E:
		cmpi.b	#$C,d0
		blo.s	loc_90A8
		subi.b	#$C,d0

loc_90A8:
		move.b	d0,anim_frame_timer(a0)
		lea	(byte_91E8).l,a1
		tst.b	(Special_stage_jumping).w
		bpl.s	loc_90CC
		lea	(byte_91F6).l,a1
		move.w	(Special_stage_velocity).w,d1
		bne.s	loc_90CC
		move.b	(Level_frame_counter+1).w,d0
		andi.w	#3,d0

loc_90CC:
		move.b	(a1,d0.w),mapping_frame(a0)
		tst.b	(Special_stage_clear_routine).w
		bne.s	loc_90EE
		move.w	(Ctrl_1).w,d0
		andi.w	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.s	loc_90EE
		tst.b	(Special_stage_jumping).w
		bmi.s	loc_90EE
		move.b	#1,(Special_stage_jumping).w

loc_90EE:
		move.b	(Special_stage_angle).w,d0
		andi.b	#$3F,d0
		bne.w	loc_9152
		cmpi.b	#1,(Special_stage_jumping).w
		bne.s	loc_911E
		move.l	#-$100000,jumping(a0)
		move.b	#$80,(Special_stage_jumping).w
		move.b	#0,(Special_stage_turning).w
		move.b	#SndID_Jump,d0;q	#signextendB(sfx_Jump),d0
		jsr	(PlaySound).l;(Play_SFX).l

loc_911E:
		tst.b	(Special_stage_jumping).w
		bpl.s	loc_9152
		move.l	routine_secondary(a0),d0
		add.l	jumping(a0),d0
		bmi.s	loc_9138
		moveq	#0,d0
		move.l	d0,jumping(a0)
		move.b	d0,(Special_stage_jumping).w

loc_9138:
		move.w	(Special_stage_rate).w,d1
		ext.l	d1
		lsl.l	#4,d1
		add.l	d1,jumping(a0)
		move.l	d0,routine_secondary(a0)
		swap	d0
		addi.w	#-$800,d0
		move.w	d0,speed_shoes_timer(a0)

loc_9152:
		jsr	sub_950C
		jsr	sub_953E
		jsr	(Draw_Sprite).l

		cmpi.w	#2,(Player_mode).w
		bne.s	loc_918A
		lea	(PLC_SStageTails).l,a2
		move.l	#ArtUnc_SStageTails,d6
		move.w	#tiles_to_bytes($7A0),d4
		bra.s	SStage_PLCLoad_91A2;jmp		SStage_PLCLoad_91A2
; ---------------------------------------------------------------------------
;
loc_918A:
		lea	(PLC_SStageSonic).l,a2
		move.l	#ArtUnc_SStageSonic,d6
		move.w	#tiles_to_bytes($7A0),d4
;		cmpi.w	#3,(Player_mode).w
;		bne.s	SStage_PLCLoad_91A2
;		lea	(PLC_SStageKnuckles).l,a2
;		move.l	#ArtUnc_SStageKnuckles,d6
;		move.w	#tiles_to_bytes($7D4),d4

SStage_PLCLoad_91A2:
		moveq	#0,d0
		move.b	mapping_frame(a0),d0
		cmp.b	next_tilt(a0),d0
		beq.s	locret_91E6
		move.b	d0,next_tilt(a0)
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	locret_91E6

loc_91BE:
		moveq	#0,d1
		move.w	(a2)+,d1
		move.w	d1,d3
		lsr.w	#8,d3
		andi.w	#$F0,d3
		addi.w	#$10,d3
		andi.w	#$FFF,d1
		lsl.l	#5,d1
		add.l	d6,d1
		move.w	d4,d2
		add.w	d3,d4
		add.w	d3,d4
		jsr	(Add_To_DMA_Queue).l
		dbf	d5,loc_91BE

locret_91E6:
		rts
; ---------------------------------------------------------------------------
byte_91E8:
		dc.b    2,   6,   7,   8,   7,   6,   2,   3,   4,   5,   4,   3,   1,   0
byte_91F6:
		dc.b    9,  $B,  $A,  $B,   9,  $B,  $A,  $B,   9,  $B,  $A,  $B,  $B,   0
byte_9204:
		dc.b    9,  $A,  $B,   9,  $A,  $B,   9,  $A,  $B,   9,  $A,  $B,  $B,   0
		even
AllocateObjectAfterCurrent_SpecialStage:
		movea.l	a0,a1
		move.w	#Object_RAM_End-object_size,d0
		sub.w	a0,d0
		lsr.w	#6,d0
		move.b	.lookup(pc,d0.w),d0
		bmi.s	.return

.loop:
		lea	next_object(a1),a1
		tst.l	(a1)
		dbeq	d0,.loop

.return:
		rts

.lookup:
.a		set	Object_RAM-object_size*2	; Oddly, this does too many object slots.
.b		set	Object_RAM_End-object_size
.c		set	.b				; begin from bottom of array and decrease backwards
		; There's a mistake here: this division should be rounded up,
		; otherwise the first object slot might not get an entry.
		; In this case, the aforementioned surplus entries counteract this problem.
		rept	(.b-.a)/$40			; repeat for all slots, minus exception
.c		set	.c-$40				; address for previous $40 (also skip last part);
		dc.b	(.b-.c-1)/object_size-1		; write possible slots according to object_size division + hack + dbf hack
		endm
		even
Draw_SSShadows:
		lea	(word_94FC).l,a3
		move.w	(a3)+,(a6)+
		move.b	(a3)+,(a6)+
		addq.w	#1,a3
		addq.w	#1,a6
		move.w	(a3)+,(a6)+
		move.w	(a3)+,(a6)+
		tst.w	(Player_mode).w
		bne.s	locret_94FA
		move.w	(a3)+,(a6)+
		move.b	(a3)+,(a6)+
		addq.w	#1,a3
		addq.w	#1,a6
		move.w	(a3)+,(a6)+
		move.w	(a3)+,(a6)+

locret_94FA:
		rts
; End of function Draw_SSShadows

; ---------------------------------------------------------------------------
word_94FC:

		dc.w $116, $F0A, make_art_tile($66F,3,1), $110;7e1,3,1), $110
		dc.w $127, $F0B, make_art_tile($66F,3,1), $110;7e1,3,1), $110

sub_950C:
		move.w	(SStage_scalar_index_2).w,d0
		lea	(SStage_scalar_result_2).w,a1
		jsr	GetScalars2
		move.w	(SStage_scalar_index_1).w,d0
		lea	(SStage_scalar_result_1).w,a1
		jsr	GetScalars2
		move.w	(SStage_scalar_index_0).w,d0
		lea	(SStage_scalar_result_0).w,a1
		jsr	GetScalars2
		move.w	#$E0,d0
		lea	(SStage_scalar_result_3).w,a1
		jsr	GetScalars2
		rts
; End of function sub_950C


; =============== S U B R O U T I N E =======================================


sub_953E:
		move.w	$34(a0),d1
		move.w	$36(a0),d2
		move.w	$38(a0),d0
		jsr	sub_A1DC
		jsr	sub_A1B2
		jsr	sub_A188
		addi.w	#$100,d0
		addi.w	#$980,d2
		jsr	sub_A206
		ext.l	d1
		lsl.l	#8,d1
		divs.w	d0,d1
		ext.l	d2
		lsl.l	#8,d2
		divs.w	d0,d2
		add.w	flips_remaining(a0),d1
		move.w	d1,x_pos(a0)
		add.w	move_lock(a0),d2
		move.w	d2,y_pos(a0)
		rts
; End of function sub_953E


; =============== S U B R O U T I N E =======================================


sub_9580:
		tst.b	(Special_stage_fade_timer).w
		beq.s	loc_95AE
		cmpi.b	#$61,(Special_stage_fade_timer).w
		bhs.s	loc_959A
		moveq	#8,d1
		add.b	d1,(Special_stage_angle).w
		addq.b	#1,(Special_stage_fade_timer).w
		rts
; ---------------------------------------------------------------------------

loc_959A:
		move.w	(Special_stage_X_pos).w,d0
		or.w	(Special_stage_Y_pos).w,d0
		andi.w	#$E0,d0
		beq.s	loc_95AE
		move.b	#0,(Special_stage_fade_timer).w

loc_95AE:
		move.w	(Special_stage_X_pos).w,d3
		btst	#6,(Special_stage_angle).w
		bne.s	loc_95BE
		move.w	(Special_stage_Y_pos).w,d3

loc_95BE:
		moveq	#0,d2
		move.b	(Special_stage_turning).w,d1
		beq.s	loc_95F4
		andi.w	#$E0,d3
		bne.s	loc_95F4
		tst.b	(Special_stage_jumping).w
		bmi.s	loc_9600
		add.b	d1,(Special_stage_angle).w
		move.b	(Special_stage_angle).w,d0
		andi.b	#$3F,d0
		bne.w	locret_972C
		move.b	#0,(Special_stage_turning).w
		tst.w	(Special_stage_velocity).w
		beq.s	loc_95F4
		move.b	#1,(Special_stage_turn_lock).w

loc_95F4:
		andi.w	#$E0,d3
		beq.s	loc_9600
		move.b	#0,(Special_stage_turn_lock).w

loc_9600:
		move.b	(Ctrl_1).w,d1
		move.w	(Special_stage_velocity).w,d2
		tst.b	(Special_stage_clear_routine).w
		bne.w	loc_96FA
		tst.b	(Special_stage_bumper_lock).w
		bne.s	loc_9658
		btst	#0,d1
		beq.s	loc_9628
		move.b	#1,(Special_stage_advancing).w
		move.b	#1,(Special_stage_started).w

loc_9628:
		tst.b	(Special_stage_advancing).w
		bne.s	loc_964A
		tst.b	(Special_stage_started).w
		beq.s	loc_9658
		tst.w	d2
		bpl.s	loc_964A
		move.w	(Special_stage_rate).w,d3
		neg.w	d3
		subi.w	#$200,d2
		cmp.w	d3,d2
		bgt.s	loc_9658
		move.w	d3,d2
		bra.s	loc_9658
; ---------------------------------------------------------------------------

loc_964A:
		move.w	(Special_stage_rate).w,d3
		addi.w	#$200,d2
		cmp.w	d3,d2
		blt.s	loc_9658
		move.w	d3,d2

loc_9658:
		tst.b	(Special_stage_turn_lock).w
		bne.s	loc_9676
		btst	#2,d1
		beq.s	loc_966A
		move.b	#4,(Special_stage_turning).w

loc_966A:
		btst	#3,d1
		beq.s	loc_9676
		move.b	#-4,(Special_stage_turning).w

loc_9676:
		move.w	d2,(Special_stage_velocity).w
		tst.b	(Special_stage_bumper_lock).w
		beq.s	loc_96FA
		move.w	(Special_stage_X_pos).w,d0
		btst	#6,(Special_stage_angle).w
		bne.s	loc_9690
		move.w	(Special_stage_Y_pos).w,d0

loc_9690:
		andi.w	#$E0,d0
		bne.s	loc_96D4
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
		beq.s	loc_96D4
		move.b	#0,(Special_stage_bumper_lock).w
		move.w	(Special_stage_rate).w,d2
		tst.w	(Special_stage_velocity).w
		bmi.s	loc_96CE
		neg.w	d2

loc_96CE:
		move.w	d2,(Special_stage_velocity).w
		rts
; ---------------------------------------------------------------------------

loc_96D4:
		move.w	(Special_stage_velocity).w,d2
		bne.s	loc_96F8
		move.b	#0,(Special_stage_bumper_lock).w
		move.b	#1,(Special_stage_advancing).w
		move.w	(Special_stage_rate).w,d2
		tst.w	(Special_stage_velocity).w
		bmi.s	loc_96F2
		neg.w	d2

loc_96F2:
		move.w	d2,(Special_stage_velocity).w
		bra.s	loc_96FA
; ---------------------------------------------------------------------------

loc_96F8:
		neg.w	d2

loc_96FA:
		cmpi.b	#$81,(Special_stage_jumping).w
		bne.s	loc_9704
		add.w	d2,d2

loc_9704:
		move.b	(Special_stage_angle).w,d0
		jsr	(GetSineCosine).l
		muls.w	d2,d0
		muls.w	d2,d1
		swap	d0
		sub.w	d0,(Special_stage_X_pos).w
		swap	d1
		sub.w	d1,(Special_stage_Y_pos).w
		tst.b	(Special_stage_jumping).w
		bmi.s	locret_972C
		tst.b	(Special_stage_clear_routine).w
		bne.s	locret_972C
		bsr.s	sub_972E

locret_972C:
		rts
; End of function sub_9580


; =============== S U B R O U T I N E =======================================


sub_972E:
		lea	(SStage_layout_buffer+$100).w,a1
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
		lea	(a1,d1.w),a1
		move.b	(a1),d2
		beq.w	locret_98AE
		cmpi.b	#1,d2
		bne.s	loc_97AA
		move.w	(Special_stage_X_pos).w,d0
		or.w	(Special_stage_Y_pos).w,d0
		andi.w	#$E0,d0
		bne.s	locret_97A8
		tst.b	(Special_stage_fade_timer).w
		bne.s	locret_97A8

		move.b	#1,(Special_stage_fade_timer).w

		move.b	#$48,(Game_mode).w
		tst.b	(Blue_spheres_stage_flag).w
		beq.s	loc_978E
		move.b	#$2C,(Game_mode).w

loc_978E:
;		tst.b	(Special_bonus_entry_flag).w
;		beq.s	loc_97A0
;		move.w	(Saved2_zone_and_act).w,(Current_zone_and_act).w
;		ori.b	#$80,(Last_star_post_hit).w

loc_97A0:
		move.w	#SndID_Signpost2P,d0
		jsr	(Play_Music).l
		jsr	loc_852E
locret_97A8:
		rts
; ---------------------------------------------------------------------------

loc_97AA:
		cmpi.b	#2,d2
		bne.s	loc_97C8
		jsr	Find_SStageCollisionResponseSlot
		bne.s	loc_97BE
		move.b	#2,(a2)
		move.l	a1,4(a2)

loc_97BE:
	move.w	#$D2,d0	; Blue Sphere SFX goes here btw
	jsr	(Play_Music).l
		rts
; ---------------------------------------------------------------------------

loc_97C8:
		cmpi.b	#3,d2
		bne.s	loc_97EE
		tst.b	(Special_stage_bumper_lock).w
		bne.s	loc_97EE
		move.w	d1,(Special_stage_interact).w
		move.b	#1,(Special_stage_bumper_lock).w
		move.b	#0,(Special_stage_advancing).w
		move.b	#SndID_Bumper,d0
		jmp	(Play_Music).l
		rts
; ---------------------------------------------------------------------------

loc_97EE:
		cmpi.b	#5,d2
		bne.s	loc_9822
		tst.b	(Special_stage_clear_routine).w
		bne.s	loc_9822
		tst.b	(Special_stage_jumping).w
		bmi.s	loc_9822
		move.b	(Special_stage_angle).w,d0
		andi.b	#$3F,d0
		bne.w	loc_9822
		move.l	#$FFE80000,$40(a0)
		move.b	#$81,(Special_stage_jumping).w
		move.b	#SndID_Spring,d0
		jsr	(Play_Music).l


loc_9822:
		cmpi.b	#4,d2
		bne.w	locret_98AE
		jsr	Find_SStageCollisionResponseSlot
		bne.s	loc_9838
		move.b	#1,(a2)
		move.l	a1,4(a2)

loc_9838:
		tst.w	(Special_stage_rings_left).w
		beq.s	loc_984C
		subq.w	#1,(Special_stage_rings_left).w
		bne.s	loc_984C
		move.w	#SndID_Bonus,d0
		jsr	(Play_Music).l

loc_984C:
		addi.w	#1,(Special_stage_ring_count).w
		bset	#7,(Special_stage_extra_life_flags).w
		move.b	#SndID_Ring,d0
		tst.b	(Blue_spheres_stage_flag).w
		bne.s	loc_98A6
		cmpi.w	#50,(Special_stage_ring_count).w
		blo.s	loc_987E
		bset	#0,(Special_stage_extra_life_flags).w
		bne.s	loc_987E
		addq.b	#1,(Continue_count).w
		move.b	#SndID_ContinueJingle,d0
		jmp	(Play_Music).l
; ---------------------------------------------------------------------------

loc_987E:
		move.b	#SndID_Ring,d0
		cmpi.w	#100,(Special_stage_ring_count).w
		blo.s	loc_98A6
		bset	#1,(Special_stage_extra_life_flags).w
		beq.s	loc_98A0
		cmpi.w	#200,(Special_stage_ring_count).w
		blo.s	loc_98A6
		bset	#2,(Special_stage_extra_life_flags).w
		bne.s	loc_98A6

loc_98A0:
		addq.b	#1,(Life_count).w
		move.b	#SndID_RingSpill,d0

loc_98A6:
		jsr	(Play_Sound).l
		rts
; ---------------------------------------------------------------------------

locret_98AE:
		rts
; End of function sub_972E

; ---------------------------------------------------------------------------
GetScalars2:
		add.w	d0,d0
		andi.w	#$1FE,d0
		move.w	ScalarTable2(pc,d0.w),(a1)+
		addi.w	#$80,d0
		andi.w	#$1FE,d0
		move.w	ScalarTable2(pc,d0.w),(a1)+
		rts
; End of function GetScalars2

; ---------------------------------------------------------------------------
ScalarTable2:
		binclude "General/Special Stage/Scalars.bin"
		even
		include	"moress.asm"
Obj_SStage_9212:
		tst.w	(Player_mode).w
		bne.w	locret_98AE
		move.b	#4,render_flags(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$10,height_pixels(a0)
		move.w	#$180,priority(a0)
		move.l	#Map_SStageTails,mappings(a0)
		move.w	#make_art_tile($55F,1,1),art_tile(a0)
		move.w	#$A0,$30(a0)
		move.w	#$70,$32(a0)
		move.w	#0,$34(a0)
		move.w	#-$800,$36(a0)
		move.w	#-$20,$38(a0)
		move.b	#$FF,$3A(a0)
		jsr	sub_93E2
		jsr	(AllocateObjectAfterCurrent_SpecialStage).l
		bne.w	loc_9274; sonic has $12 bytes of art
		move.l	#Obj_SStage_9444,(a1); i have found $10 bytes for tails
		move.w	a0,$3E(a1);but that's probably not enough

loc_9274:
		move.l	#loc_927A,(a0)

loc_927A:
		moveq	#$C,d0
		move.w	(Special_stage_velocity).w,d1
		beq.s	loc_92A0
		asr.w	#5,d1
		add.w	d1,anim_frame_timer(a0)
		moveq	#0,d0
		move.b	anim_frame_timer(a0),d0
		bpl.s	loc_9296
		addi.b	#$C,d0
		bra.s	loc_92A0
; ---------------------------------------------------------------------------

loc_9296:
		cmpi.b	#$C,d0
		blo.s	loc_92A0
		subi.b	#$C,d0

loc_92A0:
		move.b	d0,anim_frame_timer(a0)
		lea	(byte_91E8).l,a1
		tst.b	(Special_stage_jumping_P2).w
		beq.s	loc_92C4
		lea	(byte_9204).l,a1
		move.w	(Special_stage_velocity).w,d1
		bne.s	loc_92C4
		move.b	(Level_frame_counter+1).w,d0
		andi.w	#3,d0

loc_92C4:
		move.b	(a1,d0.w),mapping_frame(a0)
		jsr	sub_9402
		cmpi.b	#5,$44(a0)
		bne.s	loc_9304
		tst.b	(Special_stage_clear_routine).w
		bne.s	loc_9304
		tst.b	(Special_stage_jumping_P2).w
		bmi.s	loc_9304
		move.b	(Special_stage_angle).w,d0
		andi.b	#$3F,d0
		bne.w	loc_9304
		move.l	#$FFE80000,$40(a0)
		move.b	#$81,(Special_stage_jumping_P2).w
		move.b	#SndID_Spring,d0
		jsr	(Play_Music).l

loc_9304:
		jsr	sub_937C
		andi.w	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.s	loc_932A
		tst.b	(Special_stage_jumping_P2).w
		bne.s	loc_932A
		move.l	#$FFF00000,$40(a0)
		move.b	#$80,(Special_stage_jumping_P2).w
		move.b	#SndID_Jump,d0
		jsr	(Play_Music).l

loc_932A:
		tst.b	(Special_stage_jumping_P2).w
		bpl.s	loc_935E
		move.l	$3C(a0),d0
		add.l	$40(a0),d0
		bmi.s	loc_9344
		moveq	#0,d0
		move.l	d0,$40(a0)
		move.b	d0,(Special_stage_jumping_P2).w

loc_9344:
		move.w	(Special_stage_rate).w,d1
		ext.l	d1
		lsl.l	#4,d1
		add.l	d1,$40(a0)
		move.l	d0,$3C(a0)
		swap	d0
		addi.w	#-$800,d0
		move.w	d0,$36(a0)

loc_935E:
		jsr	sub_953E
		jsr	(Draw_Sprite).l
		lea	(PLC_SStageTails).l,a2
		move.l	#ArtUnc_SStageTails,d6
		move.w	#tiles_to_bytes($55F),d4
		bra.w	SStage_PLCLoad_91A2

; =============== S U B R O U T I N E =======================================


sub_937C:
		move.w	(Pos_table_index).w,d0
		lea	(Pos_table).w,a1
		lea	(a1,d0.w),a1
		move.w	(Ctrl_1).w,(a1)
		move.b	(Special_stage_jumping).w,2(a1)
		addq.b	#4,(Pos_table_index+1).w
		move.b	(Ctrl_2_held).w,d0
		andi.b	#$7F,d0
		beq.s	loc_93A6
		move.w	#600,(Tails_CPU_idle_timer).w

loc_93A6:
		tst.w	(Tails_CPU_idle_timer).w
		beq.s	loc_93B6
		subq.w	#1,(Tails_CPU_idle_timer).w
		move.w	(Ctrl_2).w,d0
		rts
; ---------------------------------------------------------------------------

loc_93B6:
		lea	(Pos_table).w,a1
		move.w	#4,d1
		lsl.b	#2,d1
		move.w	(Pos_table_index).w,d0
		sub.b	d1,d0
		move.b	2(a1,d0.w),d2
		subq.b	#4,d0
		move.b	2(a1,d0.w),d1
		moveq	#0,d0
		cmpi.b	#-$7F,d2
		beq.s	locret_93E0
		tst.b	d1
		bpl.s	locret_93E0
		move.w	#$70,d0

locret_93E0:
		rts
; End of function sub_937C


; =============== S U B R O U T I N E =======================================


sub_93E2:
		lea	(Pos_table).w,a2
		move.w	#bytesToLcnt($100),d0

loc_93EA:
		move.l	#0,(a2)+
		dbf	d0,loc_93EA
		move.w	#0,(Pos_table_index).w
		move.w	#0,(Tails_CPU_idle_timer).w
		rts
; End of function sub_93E2


; =============== S U B R O U T I N E =======================================


sub_9402:
		lea	(SStage_layout_buffer+$100).w,a1
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
		lea	(a1,d1.w),a1
		lea	$44(a0),a2
		move.b	1(a2),(a2)
		move.b	2(a2),1(a2)
		move.b	3(a2),2(a2)
		move.b	(a1),3(a2)
		rts
; End of function sub_9402
Obj_SStage_9444:

		move.b	#4,render_flags(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$10,height_pixels(a0)
		move.w	#$100,priority(a0)
		move.l	#Map_SStageTailstails,mappings(a0)
		move.w	#make_art_tile($7b7,1,1),art_tile(a0)
		move.w	#$A0,$30(a0)
		move.w	#$70,$32(a0)
		move.b	#-1,$3A(a0)
		move.b	#1,mapping_frame(a0)
		move.l	#loc_9488,(a0)

loc_9488:
		movea.w	$3E(a0),a1
		move.w	x_pos(a1),x_pos(a0)
		move.w	y_pos(a1),y_pos(a0)
		move.w	#$2AAA,d0
		move.w	(Special_stage_velocity).w,d1
		bmi.s	loc_94A4
		add.w	d1,d0

loc_94A4:
		add.w	d0,anim_frame_timer(a0)
		bcc.s	loc_94BC
		move.b	mapping_frame(a0),d0
		addq.b	#1,d0
		cmpi.b	#$F,d0
		blo.s	loc_94B8
		moveq	#1,d0

loc_94B8:
		move.b	d0,mapping_frame(a0)

loc_94BC:
		jsr	(Draw_Sprite).l
		lea	(PLC_SStageTailstails).l,a2
		move.l	#ArtUnc_SStageTailstails,d6
		move.w	#tiles_to_bytes($7b7),d4
		bra.w	SStage_PLCLoad_91A2
