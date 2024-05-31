;SpecialStage:
		move.b	#MusID_Stop,d0
		bsr.w	Play_Music
		clr.w	(Kos_decomp_queue_count).w
		clearRAM	Kos_decomp_stored_registers,$6C
		jsr		ClearPLC;bsr.w	ClearPLC;_Nem_Queue
		jsr		Pal_FadeToWhite;bsr.w	Pal_FadeToWhite
		move	#$2700,sr
		lea	(VDP_control_port).l,a6
		move.w	#$8004,(a6)
		move.w	#$8230,(a6)
		move.w	#$8407,(a6)
		move.w	#$9001,(a6)
		move.w	#$9200,(a6)
		move.w	#$8B00,(a6)
		move.w	#$8720,(a6)
		clr.b	(Water_fullscreen_flag).w
		move.w	#$8C81,(a6)
		jsr		Clear_DisplayData;bsr.w	Clear_DisplayData
		clearRAM	Sprite_Table_Input,Sprite_Table_Input_End;$400
		clearRAM	Object_RAM,(Kos_decomp_buffer-Object_RAM)
		clearRAM	Oscillating_Numbers,Oscillating_Numbers_End;Oscillating_table,(AIZ_vine_angle-Oscillating_table)
		clearRAM	Sonic_Stat_Record_Buf,Sonic_Stat_Record_Buf_End;Stat_table,$100
		jsr	(Init_SpriteTable).l
		clr.w	(VDP_Command_Buffer).w
		move.l	#VDP_Command_Buffer,(VDP_Command_Buffer_Slot).w
		clr.w	(DMA_queue).w
		move.l	#DMA_queue,(DMA_queue_slot).w

		moveq	#PalID_SS,d0;PalID_SS1,d0
		jsr		PalLoad_ForFade;Now;bsr.w	PalLoad_Now;ForFade
;		lea	(Pal_SStage_Main).l,a1
;		lea	(Target_palette).w,a2
;		move.w	#bytesToWcnt($80),d0
;
;loc_8284:
;		move.w	(a1)+,(a2)+
;		dbf	d0,loc_8284
;		cmpi.w	#3,(Player_mode).w
;		bne.s	loc_82A6
;;		lea	(Pal_SStage_Knux).l,a1
;		lea	(Target_palette+$10).w,a2
;		move.w	#bytesToWcnt($10),d0
;
;loc_82A0:
;		move.w	(a1)+,(a2)+
;		dbf	d0,loc_82A0
H_scroll_buffer	=	Horiz_Scroll_Buf
loc_82A6:
		move.l	#vdpComm(tiles_to_bytes($000),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_SStageLayout).l,a0
		bsr.w	J_Nem_Decomp
		bsr.w	sub_85B0;layout identifier
		lea	(RAM_start+$5500).l,a1
		lea	(MapEni_SStageLayout).l,a0
		move.w	#make_art_tile($000,0,0),d0
		bsr.w	J_Eni_Decomp
		lea	(RAM_start+$5500).l,a1
		move.l	#vdpComm(VRAM_Plane_A_Name_Table,VRAM,WRITE),d0
		moveq	#$28-1,d1
		moveq	#$1C-1,d2
		jsr	(Plane_Map_To_VRAM).l
		move.l	#vdpComm(tiles_to_bytes($680),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_SStageSphere).l,a0
		bsr.w	J_Nem_Decomp
		move.l	#vdpComm(tiles_to_bytes($5A7),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_SStageRing).l,a0
		bsr.w	J_Nem_Decomp
		move.l	#vdpComm(tiles_to_bytes($59B),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_SStageBG).l,a0
		bsr.w	J_Nem_Decomp
		move.l	#vdpComm(tiles_to_bytes($55F),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_GetBlueSpheres).l,a0
		bsr.w	J_Nem_Decomp
		move.l	#vdpComm(tiles_to_bytes($6F8),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_GBSArrow).l,a0
		bsr.w	J_Nem_Decomp
		move.l	#vdpComm(tiles_to_bytes($781),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_SStageDigits).l,a0
		bsr.w	J_Nem_Decomp
		lea	(ArtNem_SStageShadow).l,a0
		lea	(H_scroll_buffer+$20).w,a4
		bsr.w	J_Nem_Decomp_To_RAM
		move.l	#vdpComm(tiles_to_bytes($589),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_SStageIcons).l,a0
		bsr.w	J_Nem_Decomp
		move.l	#vdpComm(tiles_to_bytes($7e1),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_SStageShadow).l,a0
		bsr.w	J_Nem_Decomp
		lea	(MapUnc_SSNum000).l,a1
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$084,VRAM,WRITE),d0
		moveq	#8-1,d1
		moveq	#3-1,d2
		jsr	(Plane_Map_To_VRAM).l
		lea	(MapUnc_SSNum000).l,a1
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$0BC,VRAM,WRITE),d0
		moveq	#8-1,d1
		moveq	#3-1,d2
		jsr	(Plane_Map_To_VRAM).l
		lea	(RAM_start).l,a1
		lea	(MapEni_SStageBG).l,a0
		move.w	#make_art_tile($59B,2,0),d0
		bsr.w	J_Eni_Decomp
		lea	(RAM_start).l,a1
		move.l	#vdpComm(VRAM_Plane_B_Name_Table,VRAM,WRITE),d0
		moveq	#$40-1,d1
		moveq	#$20-1,d2
		jsr	(Plane_Map_To_VRAM).l
		lea	(SStageKos_PerspectiveMaps).l,a0
		lea	(RAM_start).l,a1
		bsr.w	J_Kos_Decomp
		bsr.w	sub_9EA0
		bsr.w	Load_SSSprite_Mappings
		clr.b	(Level_started_flag).w
		move.b	#$FF,(Special_stage_sphere_HUD_flag).w;l;w
		move.b	#$80,(Special_stage_extra_life_flags).w;l;w
		move.w	#$1000,(Special_stage_rate).w;l;w
		move.w	#30*60,(Special_stage_rate_timer).w;l;w
loc_842C:
		move.w	#0,(Camera_X_pos_copy).w
		move.w	#0,(Camera_Y_pos_copy).w
		move.w	#-1,(Screen_Y_wrap_value).w
		move.l	#Obj_SStage_8FAA,(Player_1).w
;		tst.w	(Player_mode).w
;		bne.s	loc_8454
;		move.l	#Obj_SStage_9212,(Player_2).w
Demo_timer	=	Demo_Time_left
loc_8454:
		move.l	#Obj_SStage_8DF8,(Reserved_object_3).w
		move.l	#Obj_SStage_8E40,(Dynamic_Object_RAM).w
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		jsr	Draw_SSSprites(pc)
		bsr.w	sub_9D5E
		move.b	#1,(Special_stage_fade_timer).w;l;w
		move.b	#$1C,(V_int_routine).w
		jsr		Wait_VSync;bsr.w	Wait_VSync
		move.b	#0,(Special_stage_fade_timer).w;l;w
		move.w	#$8C89,(VDP_control_port).l
		move.w	#30*60,(Demo_timer).w
;		jsr	(GetDemoPtr).l
		move.b	#MusID_SpecStage,d0;q	#;signextendB(mus_SpecialStage),d0
		bsr.w	Play_Music
		move.w	(VDP_reg_1_command).w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_control_port).l
		jsr		Pal_FadeFromWhite;bsr.w	Pal_FadeFromWhite
loc_84C2:
		jsr	PauseGame;bsr.w	Pause_Game
		move.b	#$1C,(V_int_routine).w
		jsr	(Process_Kos_Queue).l
		jsr		Wait_VSync;bsr.w	Wait_VSync
		addq.w	#1,(Level_frame_counter).w
;		jsr	(Demo_PlayRecord).l
		jsr	(Process_Sprites).l
		bsr.w	Animate_SSRings
		bsr.w	Touch_SSSprites
		jsr	(Render_Sprites).l
		jsr	Draw_SSSprites(pc)
		bsr.w	Draw_SSShadows
		bsr.w	sub_9D5E
		bsr.w	sub_9B62
		jsr		Process_Nem_Queue_Init;bsr.w	Process_Nem_Queue_Init
		jsr	(Process_Kos_Module_Queue).l
;		tst.w	(Demo_mode_flag).w
;		beq.s	loc_851A
;		tst.w	(Demo_timer).w
;		beq.s	loc_8522

loc_851A:
		bra.s	loc_84C2
;		cmpi.b	#GameModeID_BLSPHRSStage,(Game_mode).w;$30,(Game_mode).w
;		beq.s	loc_84C2
;		jmp	TitleScreen
loc_8522:
		tst.w	(Demo_mode_flag).w
		beq.s	loc_852E
		move.b	#0,(Game_mode).w
Palette_fade_info	=	Palette_fade_range
Palette_fade_index	=	Palette_fade_start
Palette_fade_count	=	Palette_fade_length
Pal_fade_delay		=	PalChangeSpeed
loc_852E:
		move.w	#60,(Demo_timer).w
		move.w	#$40-1,(Palette_fade_info).w
		clr.w	(Pal_fade_delay).w
		
loc_853E:
		move.b	#$1C,(V_int_routine).w
		jsr		Wait_VSync;bsr.w	Wait_VSync
;		jsr	(Demo_PlayRecord).l
		jsr	(Process_Sprites).l
		bsr.w	Animate_SSRings
		bsr.w	Touch_SSSprites
		jsr	(Render_Sprites).l
		jsr	Draw_SSSprites(pc)
		bsr.w	sub_9D5E
		bsr.w	sub_9B62
		jsr		Process_Nem_Queue_Init;bsr.w	Process_Nem_Queue_Init
		jsr	(Process_Kos_Module_Queue).l
		subq.w	#1,(Pal_fade_delay).w
		bpl.s	loc_8588
		move.w	#2,(Pal_fade_delay).w
		jsr		Pal_ToWhite;bsr.w	Pal_ToWhite

loc_8588:
		bra.s	loc_853E
		tst.w	(Demo_timer).w
		bne.s	loc_853E
		rts
;		rts
sub_9EA0:
		lea	(SStage_layout_buffer+$100).w,a3
		moveq	#0,d1
		move.w	#$400-1,d0

loc_9EAA:
		cmpi.b	#2,(a3)+
		bne.s	loc_9EB2
		addq.w	#1,d1

loc_9EB2:
		dbf	d0,loc_9EAA
		move.w	d1,(Special_stage_spheres_left).w;l;w
		rts
; End of function sub_9EA0
Touch_SSSprites:
		lea	(SStage_collision_response_list).w,a0;l,a0;w,a0
		move.w	#$20-1,d7

loc_9DE6:
		moveq	#0,d0
		move.b	(a0),d0
		beq.s	loc_9DF4
		lsl.w	#2,d0
		movea.l	off_9DFC-4(pc,d0.w),a1
		jsr	(a1)

loc_9DF4:
		addq.w	#8,a0
		dbf	d7,loc_9DE6
		rts
; End of function Touch_SSSprites

; ---------------------------------------------------------------------------
off_9DFC:
		dc.l Touch_SSSprites_Ring
		dc.l Touch_SSSprites_BlueSphere
; ---------------------------------------------------------------------------

Touch_SSSprites_Ring:
		subq.b	#1,2(a0)
		bpl.s	locret_9E2C
		move.b	#5,2(a0)
		moveq	#0,d0
		move.b	3(a0),d0
		addq.b	#1,3(a0)
		movea.l	4(a0),a1
		move.b	byte_9E2E(pc,d0.w),d0
		move.b	d0,(a1)
		bne.s	locret_9E2C
		clr.l	(a0)
		clr.l	4(a0)

locret_9E2C:
		rts
; ---------------------------------------------------------------------------
byte_9E2E:
		dc.b    6,   7,   8,   9,   0
		even
; ---------------------------------------------------------------------------

Touch_SSSprites_BlueSphere:
		subq.b	#1,2(a0)
		bpl.s	locret_9E86
		move.b	#9,2(a0)
		movea.l	4(a0),a1
		cmpi.b	#2,(a1)
		bne.s	loc_9E62
		bsr.w	sub_9E88
		move.b	#$A,(a1)
		bsr.s	sub_9EBC
		beq.s	locret_9E60
		move.b	#4,(a1)
		clr.l	(a0)
		clr.l	4(a0)

locret_9E60:
		rts
; ---------------------------------------------------------------------------

loc_9E62:
		move.b	#0,2(a0)
		move.w	(Special_stage_X_pos).w,d0;l,d0;w,d0
		or.w	(Special_stage_Y_pos).w,d0;l,d0;w,d0
		andi.w	#$E0,d0
		beq.s	locret_9E86
		cmpi.b	#$A,(a1)
		bne.s	loc_9E80
		move.b	#1,(a1)

loc_9E80:
		clr.l	(a0)
		clr.l	4(a0)

locret_9E86:
		rts

; =============== S U B R O U T I N E =======================================


sub_9E88:
		move.w	d0,-(sp)
		move.b	#-1,(Special_stage_sphere_HUD_flag).w;l;w
		subq.w	#1,(Special_stage_spheres_left).w;l;w
		bne.s	loc_9E9C
		move.b	#1,(Special_stage_clear_routine).w;l;w

loc_9E9C:
		move.w	(sp)+,d0
		rts
; End of function sub_9E88
sub_9EBC:
		lea	(SStage_layout_buffer+$100).w,a2
		move.l	a1,d5
		sub.l	a2,d5
		bsr.w	sub_9F44
		moveq	#0,d6
		move.l	a5,d1
		lea	(SStage_unkA500).w,a4;l,a4;w,a4
		sub.l	a4,d1
		beq.s	locret_9F42

loc_9ED2:
		move.w	(a4)+,d5
		lea	(word_A0CA).l,a3
		move.w	#8-1,d0

loc_9EDE:
		move.w	(a3)+,d2
		add.w	d5,d2
		andi.w	#$3FF,d2
		cmpi.b	#2,(a2,d2.w)
		bne.s	loc_9EFC
		bsr.w	sub_9E88
		move.b	#4,(a2,d2.w)
		move.w	d2,(a5)+
		addq.w	#2,d1

loc_9EFC:
		dbf	d0,loc_9EDE
		subq.w	#2,d1
		bne.s	loc_9ED2
		move.l	a5,d1
		lea	(SStage_unkA500).w,a4;l,a4;w,a4
		sub.l	a4,d1
		beq.s	locret_9F42

loc_9F0E:
		move.w	(a4)+,d5
		lea	(word_A0CA).l,a3
		move.w	#8-1,d0

loc_9F1A:
		move.w	(a3)+,d2
		add.w	d5,d2
		andi.w	#$3FF,d2
		cmpi.b	#1,(a2,d2.w)
		bne.s	loc_9F30
		move.b	#4,(a2,d2.w)

loc_9F30:
		dbf	d0,loc_9F1A
		subq.w	#2,d1
		bne.s	loc_9F0E
		move.w	#SndID_RingSpill,d0
		jsr	(Play_Music).l
		moveq	#1,d1

locret_9F42:
		rts
; End of function sub_9EBC
sub_9F44:
		lea	(SStage_unkA500).w,a5;l,a5;w,a5
		lea	(word_A0CA).l,a3
		moveq	#0,d2
		move.w	#8-1,d0

loc_9F54:
		move.w	(a3)+,d1
		add.w	d5,d1
		andi.w	#$3FF,d1
		cmpi.b	#$A,(a2,d1.w)
		bne.s	loc_9F6A
		move.b	#1,(a2,d1.w)

loc_9F6A:
		cmpi.b	#2,(a2,d1.w)
		bne.s	loc_9F74
		addq.w	#1,d2

loc_9F74:
		dbf	d0,loc_9F54
		tst.w	d2
		beq.w	locret_A076
		moveq	#0,d2
		move.w	d5,d1
		moveq	#$10-1,d3

loc_9F84:
		addq.w	#1,d2
		addi.w	#-1,d1
		tst.b	(a2,d1.w)
		beq.s	loc_9F94
		dbf	d3,loc_9F84

loc_9F94:
		move.w	d5,d1
		moveq	#$10-1,d3

loc_9F98:
		addq.w	#1,d2
		addi.w	#1,d1
		tst.b	(a2,d1.w)
		beq.s	loc_9FA8
		dbf	d3,loc_9F98

loc_9FA8:
		cmpi.w	#4,d2
		blo.w	locret_A076
		moveq	#0,d2
		move.w	d5,d1
		moveq	#$10-1,d3

loc_9FB6:
		addq.w	#1,d2
		addi.w	#$FFE0,d1
		tst.b	(a2,d1.w)
		beq.s	loc_9FC6
		dbf	d3,loc_9FB6

loc_9FC6:
		move.w	d5,d1
		moveq	#$10-1,d3

loc_9FCA:
		addq.w	#1,d2
		addi.w	#$20,d1
		tst.b	(a2,d1.w)
		beq.s	loc_9FDA
		dbf	d3,loc_9FCA

loc_9FDA:
		cmpi.w	#4,d2
		blo.w	locret_A076
		lea	(SStage_unkA600).w,a4;l,a4;w,a4
		lea	(word_A0DA).l,a3
		moveq	#0,d6
		moveq	#0,d3
		moveq	#6,d4
		add.w	d3,d4
		move.w	d5,d0

loc_9FF6:
		move.w	(a3,d4.w),d1
		add.w	d0,d1
		andi.w	#$3FF,d1
		move.b	(a2,d1.w),d2
		cmpi.b	#$8A,d2
		beq.s	loc_A078
		cmpi.b	#1,d2
		bne.s	loc_A054
		cmpi.w	#2,d6
		blo.s	loc_A034
		move.w	d1,d2
		sub.w	-6(a4),d2
		cmpi.w	#-1,d2
		beq.s	loc_A054
		cmpi.w	#1,d2
		beq.s	loc_A054
		cmpi.w	#$20,d2
		beq.s	loc_A054
		cmpi.w	#-$20,d2
		beq.s	loc_A054

loc_A034:
		ori.b	#$80,(a2,d0.w)
		move.b	d3,(a4)+
		move.b	d4,(a4)+
		move.w	d0,(a4)+
		addq.w	#1,d6
		move.w	d4,d3
		subq.w	#2,d3
		andi.w	#6,d3
		move.w	#4,d4
		add.w	d3,d4
		move.w	d1,d0
		bra.s	loc_9FF6
; ---------------------------------------------------------------------------

loc_A054:
		subq.w	#2,d4
		cmp.w	d3,d4
		bge.s	loc_9FF6

loc_A05A:
		moveq	#0,d3
		moveq	#0,d4
		move.w	-(a4),d0
		move.b	-(a4),d4
		move.b	-(a4),d3
		subq.w	#1,d6
		bcs.s	locret_A076
		andi.b	#$7F,(a2,d0.w)
		subq.w	#2,d4
		cmp.w	d3,d4
		bge.s	loc_9FF6
		bra.s	loc_A05A
; ---------------------------------------------------------------------------

locret_A076:
		rts
; ---------------------------------------------------------------------------

loc_A078:
		movem.l	d0/d3-d4/d6/a4,-(sp)
		sub.w	d5,d0
		move.w	d0,d4
		neg.w	d4
		lea	(SStage_unkA600+6).w,a4;l,a4;w,a4
		move.w	(a4),d2
		sub.w	d5,d2
		move.w	d5,d3

loc_A08C:
		move.w	(a4)+,d0
		addq.w	#2,a4
		sub.w	d3,d0
		cmp.w	d2,d0
		bne.s	loc_A09A
		add.w	d0,d3
		bra.s	loc_A08C
; ---------------------------------------------------------------------------

loc_A09A:
		cmp.w	d4,d0
		beq.s	loc_A0A4
		cmp.w	d4,d2
		beq.s	loc_A0A4
		add.w	d2,d0

loc_A0A4:
		add.w	d5,d0
		cmpi.b	#2,(a2,d0.w)
		beq.s	loc_A0B8
		cmpi.b	#4,(a2,d0.w)
		beq.s	loc_A0C4
		bra.s	loc_A0C4
; ---------------------------------------------------------------------------

loc_A0B8:
		bsr.w	sub_9E88
		move.b	#4,(a2,d0.w)
		move.w	d0,(a5)+

loc_A0C4:
		movem.l	(sp)+,d0/d3-d4/d6/a4
		bra.s	loc_A054
; End of function sub_9F44

; ---------------------------------------------------------------------------
word_A0CA:
		dc.w   -$21
		dc.w   -$20
		dc.w   -$1F
		dc.w     -1
		dc.w      1
		dc.w    $1F
		dc.w    $20
		dc.w    $21
word_A0DA:
		dc.w     -1
		dc.w   -$20
		dc.w      1
		dc.w    $20
		dc.w     -1
		dc.w   -$20
sub_9D5E:
		move.w	(Special_stage_X_pos).w,d0
		sub.w	(Special_stage_prev_X_pos).w,d0
		btst	#6,(Special_stage_angle).w
		bne.s	loc_9D76
		move.w	(Special_stage_Y_pos).w,d0
		sub.w	(Special_stage_prev_Y_pos).w,d0

loc_9D76:
		tst.b	(Special_stage_angle).w
		bmi.s	loc_9D7E
		neg.w	d0

loc_9D7E:
		asr.w	#2,d0
		add.w	d0,(Vscroll_Factor_BG).w;V_scroll_value_BG).w
		moveq	#0,d1
		move.b	(Special_stage_angle).w,d1
		asl.w	#2,d1
		move.w	d1,(H_scroll_buffer+2).w
		move.w	(Special_stage_X_pos).w,(Special_stage_prev_X_pos).w
		move.w	(Special_stage_Y_pos).w,(Special_stage_prev_Y_pos).w
		rts
; End of function sub_9D5E
Rings_frame_timer	=	Rings_anim_counter
Rings_frame	=	Rings_anim_frame
Animate_SSRings:

		lea	(SStage_extra_sprites+$07).w,a1
		subq.b	#1,(Rings_frame_timer).w
		bpl.s	loc_9DC2
		move.b	#7,(Rings_frame_timer).w
		addi.b	#$10,(Rings_frame).w
		cmpi.b	#$30,(Rings_frame).w
		blo.s	loc_9DC2
		move.b	#0,(Rings_frame).w

loc_9DC2:
		move.b	(Rings_frame).w,anim(a1)
		rts
; End of function Animate_SSRings
		include	"blsphrdispspr.asm"
Load_SSSprite_Mappings:
		lea	(SStage_extra_sprites).w,a1
		lea	(MapPtr_A10A).l,a0
		moveq	#$E-1,d1

loc_A0F2:
		move.l	(a0)+,(a1)+
		move.l	(a0)+,(a1)+
		dbf	d1,loc_A0F2
		lea	(SStage_collision_response_list).w,a1
		move.w	#$40-1,d1

loc_A102:
		clr.l	(a1)+
		dbf	d1,loc_A102
		rts
; End of function Load_SSSprite_Mappings

; ---------------------------------------------------------------------------
MapPtr_A10A:
		dc.l Map_SStageSphere
		dc.w make_art_tile($680,0,1), $0000
		dc.l Map_SStageSphere
		dc.w make_art_tile($680,0,1), $0000
		dc.l Map_SStageSphere
		dc.w make_art_tile($680,2,1), $0000
		dc.l Map_SStageSphere
		dc.w make_art_tile($680,1,1), $0000
		dc.l Map_SStageRing
		dc.w make_art_tile($5A7,2,1), $0000
		dc.l Map_SStageSphere
		dc.w make_art_tile($680,3,1), $0000
		dc.l Map_SStageRing
		dc.w make_art_tile($5A7,2,1), $8030
		dc.l Map_SStageRing
		dc.w make_art_tile($5A7,2,1), $8031
		dc.l Map_SStageRing
		dc.w make_art_tile($5A7,2,1), $8032
		dc.l Map_SStageRing
		dc.w make_art_tile($5A7,2,1), $8033
		dc.l Map_SStageSphere
		dc.w make_art_tile($680,2,1), $0000
		dc.l Map_SStageChaosEmerald
		dc.w make_art_tile($5A7,3,1), $0000
		dc.l Map_SStageSphere
		dc.w make_art_tile($680,2,1), $0000
		dc.l Map_SStageSuperEmerald
		dc.w make_art_tile($5A7,3,1), $0000
Play_Music:
	jmp	PlaySound
J_Nem_Decomp:
	jmp	Nem_Decomp
J_Kos_Decomp:
	jmp	Kos_Decomp
J_Eni_Decomp:
	jmp	Eni_Decomp
J_Nem_Decomp_To_RAM:
	jmp	Nem_Decomp_To_RAM
Bs_OBJ:
	include	"bsobjs.asm"
	even


ArtUnc_SStageKnuckles:
		binclude "General/Sprites/Knuckles/Art/SStage Knuckles.bin"
		even
Map_SStageKnuckles:
		include "General/Sprites/Knuckles/Map - SStage Knuckles.asm"
Pal_SStage_Main:
		binclude "General/Special Stage/Palettes/Main.bin"
		even
Pal_SStage_Main_End:
		even
Map_SStageSphere:
		include "General/Special Stage/Map - Sphere.asm"
		even
Map_SStageRing:
		include "General/Special Stage/Map - Ring.asm"
		even
Map_SStageChaosEmerald:
		include "General/Special Stage/Map - Chaos Emerald.asm"
		even
Map_SStageSuperEmerald:
		include "General/Special Stage/Map - Super Emerald.asm"
		even
ArtNem_SStageShadow:
		binclude "General/Special Stage/Nemesis Art/Shadow.bin"
		even
ArtNem_GetBlueSpheres:
		binclude "General/Special Stage/Nemesis Art/Get Blue Spheres.bin"
		even
ArtNem_GBSArrow:
		binclude "General/Special Stage/Nemesis Art/Get Blue Spheres Arrow.bin"
		even
ArtNem_SStageDigits:
		binclude "General/Special Stage/Nemesis Art/Digits.bin"
		even
ArtNem_SStageIcons:
		binclude "General/Special Stage/Nemesis Art/Icons.bin"
		even
ArtNem_SStageSphere:
		binclude "General/Special Stage/Nemesis Art/Sphere.bin"
		even
ArtNem_SStageRing:
		binclude "General/Special Stage/Nemesis Art/Ring.bin"
		even
ArtKosM_SStageChaosEmerald:
		binclude "General/Special Stage/KosinskiM Art/Special Stage Chaos Emerald.bin"
		even
ArtKosM_SStageSuperEmerald:
		binclude "General/Special Stage/KosinskiM Art/Special Stage Super Emerald.bin"
		even
MapEni_SStageBG:
		binclude "General/Special Stage/Enigma Map/BG.bin"
		even
ArtNem_SStageBG:
		binclude "General/Special Stage/Nemesis Art/BG.bin"
		even
MapEni_SStageLayout:
		binclude "General/Special Stage/Enigma Map/Layout.bin"
		even
ArtNem_SStageLayout:
		binclude "General/Special Stage/Nemesis Art/Layout.bin"
		even
SStageKos_PerspectiveMaps:
		binclude "General/Special Stage/Layout/Perspective Maps.bin"
		even
MapUnc_SSNum000:
		binclude "General/Special Stage/Uncompressed Map/HUD.bin"
		even
PLC_SStageSonic:
		include "General/Sprites/Sonic/DPLC - SStage Sonic.asm"
		even
Map_SStageSonic:
		include "General/Sprites/Sonic/Map - SStage Sonic.asm"
		even
ArtUnc_SStageSonic:
		align 2
		binclude "General/Sprites/Sonic/Art/SStage Sonic.bin"
		even
PLC_SStageTails:
		include "General/Sprites/Tails/DPLC - SStage Tails.asm"
		even
ArtUnc_SStageTails:
		binclude "General/Sprites/Tails/Art/SStage Tails.bin"
		even
Map_SStageTails:
		include "General/Sprites/Tails/Map - SStage Tails.asm"
		even
