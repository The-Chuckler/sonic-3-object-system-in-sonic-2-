; --------------------------------------------------------------------------------
; Sprite mappings - output from SonMapEd - Sonic 2 format
; --------------------------------------------------------------------------------

SME_XnzKm:	
		dc.w SME_XnzKm_18-SME_XnzKm, SME_XnzKm_1A-SME_XnzKm	
		dc.w SME_XnzKm_2C-SME_XnzKm, SME_XnzKm_3E-SME_XnzKm	
		dc.w SME_XnzKm_58-SME_XnzKm, SME_XnzKm_72-SME_XnzKm	
		dc.w SME_XnzKm_8C-SME_XnzKm, SME_XnzKm_A6-SME_XnzKm	
		dc.w SME_XnzKm_C0-SME_XnzKm, SME_XnzKm_DA-SME_XnzKm	
		dc.w SME_XnzKm_E4-SME_XnzKm, SME_XnzKm_EE-SME_XnzKm	
PLC_SStageSonic:dc.w word_ABE2C-PLC_SStageSonic
		dc.w word_ABEDA-PLC_SStageSonic
		dc.w word_ABEE0-PLC_SStageSonic
		dc.w word_ABEE6-PLC_SStageSonic
		dc.w word_ABEEE-PLC_SStageSonic
		dc.w word_ABEF6-PLC_SStageSonic
		dc.w word_ABEFE-PLC_SStageSonic
		dc.w word_ABF06-PLC_SStageSonic
		dc.w word_ABF0E-PLC_SStageSonic
		dc.w word_ABF16-PLC_SStageSonic
		dc.w word_ABF1A-PLC_SStageSonic
		dc.w word_ABF1E-PLC_SStageSonic
word_ABE2C:	dc.w 0
SME_XnzKm_18:	dc.b 0, 0	
SME_XnzKm_1A:	dc.b 0, 2	
		dc.b $DD, $F, 0, 0, 0, 0, $FF, $F0	
		dc.b $FD, 8, 0, $10, 0, 8, $FF, $F2	
SME_XnzKm_2C:	dc.b 0, 2	
		dc.b $D5, $F, 0, 0, 0, 0, $FF, $F0	
		dc.b $F5, 9, 0, $10, 0, 8, $FF, $F1	
SME_XnzKm_3E:	dc.b 0, 3	
		dc.b $D5, $F, 0, 0, 0, 0, $FF, $F0	
		dc.b $F5, 8, 0, $10, 0, 8, $FF, $F2	
		dc.b $FD, 5, 0, $13, 0, 9, $FF, $F2	
SME_XnzKm_58:	dc.b 0, 3	
		dc.b $D5, $F, 0, 0, 0, 0, $FF, $F0	
		dc.b $F5, 8, 0, $10, 0, 8, $FF, $F2	
		dc.b $FD, 5, 0, $13, 0, 9, $FF, $F2	
SME_XnzKm_72:	dc.b 0, 3	
		dc.b $D5, $F, 0, 0, 0, 0, $FF, $EE	
		dc.b $F5, 8, 0, $10, 0, 8, $FF, $F6	
		dc.b $FD, 1, 0, $13, 0, 9, $FF, $F6	
SME_XnzKm_8C:	dc.b 0, 3	
		dc.b $D5, $F, 8, 0, 8, 0, $FF, $EF	
		dc.b $F5, 8, 8, $10, 8, 8, $FF, $F7	
		dc.b $FD, 5, 8, $13, 8, 9, $FF, $FF	
SME_XnzKm_A6:	dc.b 0, 3	
		dc.b $D5, $F, 8, 0, 8, 0, $FF, $EF	
		dc.b $F5, 8, 8, $10, 8, 8, $FF, $F7	
		dc.b $FD, 5, 8, $13, 8, 9, $FF, $FF	
SME_XnzKm_C0:	dc.b 0, 3	
		dc.b $D5, $F, 8, 0, 8, 0, $FF, $F0	
		dc.b $F5, 8, 8, $10, 8, 8, $FF, $F0	
		dc.b $FD, 1, 8, $13, 8, 9, 0, 0	
SME_XnzKm_DA:	dc.b 0, 1	
		dc.b $DA, $F, 0, 0, 0, 0, $FF, $F0	
SME_XnzKm_E4:	dc.b 0, 1	
		dc.b $DA, $F, 0, 0, 0, 0, $FF, $F0	
SME_XnzKm_EE:	dc.b 0, 1	
		dc.b $DA, $F, 0, 0, 0, 0, $FF, $F0	
		even
word_ABEDA:	dc.w 2
		dc.w $F000
		dc.w $2010
word_ABEE0:	dc.w 2
		dc.w $F013
		dc.w $5023
word_ABEE6:	dc.w 3
		dc.w $F029
		dc.w $2039
		dc.w $303C
word_ABEEE:	dc.w 3
		dc.w $F040
		dc.w $2050
		dc.w $3053
word_ABEF6:	dc.w 3
		dc.w $F057
		dc.w $2067
		dc.w $106A
word_ABEFE:	dc.w 3
		dc.w $F029
		dc.w $2039
		dc.w $303C
word_ABF06:	dc.w 3
		dc.w $F040
		dc.w $2050
		dc.w $3053
word_ABF0E:	dc.w 3
		dc.w $F057
		dc.w $2067
		dc.w $106A
word_ABF16:	dc.w 1
		dc.w $F06C
word_ABF1A:	dc.w 1
		dc.w $F07C
word_ABF1E:	dc.w 1
		dc.w $F08C
		even