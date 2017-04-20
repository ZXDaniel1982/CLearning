
_manual:

;manual.c,10 :: 		void manual(char ChannelNum)
;manual.c,14 :: 		if(ChannelNum == CHANNEL1)
	MOVF        FARG_manual_ChannelNum+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_manual0
;manual.c,15 :: 		ManualInput = RB3_bit;
	MOVLW       0
	BTFSC       RB3_bit+0, BitPos(RB3_bit+0) 
	MOVLW       1
	MOVWF       manual_ManualInput_L0+0 
	GOTO        L_manual1
L_manual0:
;manual.c,16 :: 		else if(ChannelNum == CHANNEL2)
	MOVF        FARG_manual_ChannelNum+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_manual2
;manual.c,17 :: 		ManualInput = RD7_bit;
	MOVLW       0
	BTFSC       RD7_bit+0, BitPos(RD7_bit+0) 
	MOVLW       1
	MOVWF       manual_ManualInput_L0+0 
L_manual2:
L_manual1:
;manual.c,19 :: 		if(pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.man_on)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_manual_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       54
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       84
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	BTFSS       R0, 2 
	GOTO        L_manual3
;manual.c,21 :: 		if(ManualInput)     //forceon1 ¶Ë¿Ú
	MOVF        manual_ManualInput_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_manual4
;manual.c,23 :: 		ForceSSROFFCondition[ChannelNum] &= ~MANUALFORCEOFF;
	MOVLW       _ForceSSROFFCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSROFFCondition+0)
	MOVWF       R2 
	MOVF        FARG_manual_ChannelNum+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVLW       247
	ANDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;manual.c,24 :: 		}
	GOTO        L_manual5
L_manual4:
;manual.c,27 :: 		ForceSSROFFCondition[ChannelNum] |= MANUALFORCEOFF;
	MOVLW       _ForceSSROFFCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSROFFCondition+0)
	MOVWF       R2 
	MOVF        FARG_manual_ChannelNum+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVLW       8
	IORWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;manual.c,28 :: 		}
L_manual5:
;manual.c,29 :: 		}
	GOTO        L_manual6
L_manual3:
;manual.c,32 :: 		ForceSSROFFCondition[ChannelNum] &= ~MANUALFORCEOFF;
	MOVLW       _ForceSSROFFCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSROFFCondition+0)
	MOVWF       R2 
	MOVF        FARG_manual_ChannelNum+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVLW       247
	ANDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;manual.c,33 :: 		}
L_manual6:
;manual.c,34 :: 		}
L_end_manual:
	RETURN      0
; end of _manual
