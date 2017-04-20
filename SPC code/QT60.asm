
_RestoreDefaultQtSetup:

;QT60.c,60 :: 		void RestoreDefaultQtSetup ( void )
;QT60.c,65 :: 		for (i = 0; i < 24; i++)             //NUM_QT_KEYS
	CLRF        RestoreDefaultQtSetup_i_L0+0 
L_RestoreDefaultQtSetup0:
	MOVLW       24
	SUBWF       RestoreDefaultQtSetup_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_RestoreDefaultQtSetup1
;QT60.c,67 :: 		QtSetupBlock[i]      = QT_DEF_NTHR + (QT_DEF_NDRIFT << 4);
	MOVLW       _QtSetupBlock+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_QtSetupBlock+0)
	MOVWF       FSR1H 
	MOVF        RestoreDefaultQtSetup_i_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       166
	MOVWF       POSTINC1+0 
;QT60.c,68 :: 		QtSetupBlock[i + 24] = QT_DEF_PDRIFT;
	MOVLW       24
	ADDWF       RestoreDefaultQtSetup_i_L0+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _QtSetupBlock+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_QtSetupBlock+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       4
	MOVWF       POSTINC1+0 
;QT60.c,69 :: 		QtSetupBlock[i + 48] = QT_DEF_NDIL + (QT_DEF_FDIL << 4);
	MOVLW       48
	ADDWF       RestoreDefaultQtSetup_i_L0+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _QtSetupBlock+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_QtSetupBlock+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       82
	MOVWF       POSTINC1+0 
;QT60.c,70 :: 		QtSetupBlock[i + 72] = QT_DEF_NRD;
	MOVLW       72
	ADDWF       RestoreDefaultQtSetup_i_L0+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _QtSetupBlock+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_QtSetupBlock+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       20
	MOVWF       POSTINC1+0 
;QT60.c,71 :: 		QtSetupBlock[i + 96] = QT_DEF_BL << 4;
	MOVLW       96
	ADDWF       RestoreDefaultQtSetup_i_L0+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _QtSetupBlock+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_QtSetupBlock+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       32
	MOVWF       POSTINC1+0 
;QT60.c,65 :: 		for (i = 0; i < 24; i++)             //NUM_QT_KEYS
	INCF        RestoreDefaultQtSetup_i_L0+0, 1 
;QT60.c,72 :: 		}
	GOTO        L_RestoreDefaultQtSetup0
L_RestoreDefaultQtSetup1:
;QT60.c,75 :: 		QtSetupBlock[120] = QT_DEF_SLEEP;
	MOVLW       3
	MOVWF       _QtSetupBlock+120 
;QT60.c,76 :: 		QtSetupBlock[121] = QT_DEF_AWAKE;
	MOVLW       255
	MOVWF       _QtSetupBlock+121 
;QT60.c,81 :: 		I2C_write (QtAddress,
	MOVF        _QtAddress+0, 0 
	MOVWF       FARG_I2C_write_QTAddress+0 
;QT60.c,82 :: 		QT_UNLOCK_OFFSET,
	MOVLW       130
	MOVWF       FARG_I2C_write_QTRegister+0 
;QT60.c,83 :: 		&QtCommand,
	MOVLW       _QtCommand+0
	MOVWF       FARG_I2C_write_Keystate+0 
	MOVLW       hi_addr(_QtCommand+0)
	MOVWF       FARG_I2C_write_Keystate+1 
;QT60.c,84 :: 		1);
	MOVLW       1
	MOVWF       FARG_I2C_write_Length+0 
	CALL        _I2C_write+0, 0
;QT60.c,85 :: 		I2C_write (QtAddress,
	MOVF        _QtAddress+0, 0 
	MOVWF       FARG_I2C_write_QTAddress+0 
;QT60.c,86 :: 		131,
	MOVLW       131
	MOVWF       FARG_I2C_write_QTRegister+0 
;QT60.c,87 :: 		QtSetupBlock,
	MOVLW       _QtSetupBlock+0
	MOVWF       FARG_I2C_write_Keystate+0 
	MOVLW       hi_addr(_QtSetupBlock+0)
	MOVWF       FARG_I2C_write_Keystate+1 
;QT60.c,88 :: 		122);
	MOVLW       122
	MOVWF       FARG_I2C_write_Length+0 
	CALL        _I2C_write+0, 0
;QT60.c,90 :: 		}
L_end_RestoreDefaultQtSetup:
	RETURN      0
; end of _RestoreDefaultQtSetup

_SetQtSetup:

;QT60.c,97 :: 		UCHAR SetQtSetup ( UCHAR Key, UCHAR Param, UCHAR Value, UCHAR WriteFlag )
;QT60.c,99 :: 		UCHAR RetVal = TRUE; /* function return value */
	MOVLW       1
	MOVWF       SetQtSetup_RetVal_L0+0 
;QT60.c,104 :: 		Index = ParamDef[Param].Offset;
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        FARG_SetQtSetup_Param+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       _ParamDef+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_ParamDef+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(_ParamDef+0)
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, SetQtSetup_Index_L0+0
;QT60.c,105 :: 		if ( Param <= QT_PARAM_SSYNC )
	MOVF        FARG_SetQtSetup_Param+0, 0 
	SUBLW       9
	BTFSS       STATUS+0, 0 
	GOTO        L_SetQtSetup3
;QT60.c,106 :: 		Index += Key;
	MOVF        FARG_SetQtSetup_Key+0, 0 
	ADDWF       SetQtSetup_Index_L0+0, 1 
L_SetQtSetup3:
;QT60.c,109 :: 		if ( (Index < LEN_QT_SETUP) && (Key < NUM_QT_KEYS) )
	MOVLW       123
	SUBWF       SetQtSetup_Index_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SetQtSetup6
	MOVLW       9
	SUBWF       FARG_SetQtSetup_Key+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SetQtSetup6
L__SetQtSetup16:
;QT60.c,112 :: 		Temp = (Value & ParamDef[Param].Mask) << ParamDef[Param].Position;
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        FARG_SetQtSetup_Param+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       _ParamDef+0
	ADDWF       R0, 0 
	MOVWF       R4 
	MOVLW       hi_addr(_ParamDef+0)
	ADDWFC      R1, 0 
	MOVWF       R5 
	MOVLW       higher_addr(_ParamDef+0)
	ADDWFC      R2, 0 
	MOVWF       R6 
	MOVLW       2
	ADDWF       R4, 0 
	MOVWF       R7 
	MOVLW       0
	ADDWFC      R5, 0 
	MOVWF       R8 
	MOVLW       0
	ADDWFC      R6, 0 
	MOVWF       R9 
	MOVF        R7, 0 
	MOVWF       TBLPTRL 
	MOVF        R8, 0 
	MOVWF       TBLPTRH 
	MOVF        R9, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	ANDWF       FARG_SetQtSetup_Value+0, 0 
	MOVWF       SetQtSetup_Temp_L0+0 
	MOVLW       1
	ADDWF       R4, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      R5, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R6, 0 
	MOVWF       R3 
	MOVF        R1, 0 
	MOVWF       TBLPTRL 
	MOVF        R2, 0 
	MOVWF       TBLPTRH 
	MOVF        R3, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
L__SetQtSetup19:
	BZ          L__SetQtSetup20
	RLCF        SetQtSetup_Temp_L0+0, 1 
	BCF         SetQtSetup_Temp_L0+0, 0 
	ADDLW       255
	GOTO        L__SetQtSetup19
L__SetQtSetup20:
;QT60.c,113 :: 		QtSetupBlock[Index] &= ~(ParamDef[Param].Mask << ParamDef[Param].Position);
	MOVLW       _QtSetupBlock+0
	MOVWF       R5 
	MOVLW       hi_addr(_QtSetupBlock+0)
	MOVWF       R6 
	MOVF        SetQtSetup_Index_L0+0, 0 
	ADDWF       R5, 1 
	BTFSC       STATUS+0, 0 
	INCF        R6, 1 
	MOVF        R7, 0 
	MOVWF       TBLPTRL 
	MOVF        R8, 0 
	MOVWF       TBLPTRH 
	MOVF        R9, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R4
	MOVF        R1, 0 
	MOVWF       TBLPTRL 
	MOVF        R2, 0 
	MOVWF       TBLPTRH 
	MOVF        R3, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	MOVWF       R1 
	MOVF        R4, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__SetQtSetup21:
	BZ          L__SetQtSetup22
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__SetQtSetup21
L__SetQtSetup22:
	COMF        R0, 0 
	MOVWF       R1 
	MOVFF       R5, FSR0
	MOVFF       R6, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	MOVFF       R5, FSR1
	MOVFF       R6, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;QT60.c,114 :: 		QtSetupBlock[Index] += Temp;
	MOVLW       _QtSetupBlock+0
	MOVWF       R1 
	MOVLW       hi_addr(_QtSetupBlock+0)
	MOVWF       R2 
	MOVF        SetQtSetup_Index_L0+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        SetQtSetup_Temp_L0+0, 0 
	ADDWF       R0, 1 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;QT60.c,116 :: 		if ( WriteFlag )        /* if required, write complete Setup image to QT device */
	MOVF        FARG_SetQtSetup_WriteFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SetQtSetup7
;QT60.c,118 :: 		I2C_write (QtAddress, QT_UNLOCK_OFFSET, &QtCommand, 1);
	MOVF        _QtAddress+0, 0 
	MOVWF       FARG_I2C_write_QTAddress+0 
	MOVLW       130
	MOVWF       FARG_I2C_write_QTRegister+0 
	MOVLW       _QtCommand+0
	MOVWF       FARG_I2C_write_Keystate+0 
	MOVLW       hi_addr(_QtCommand+0)
	MOVWF       FARG_I2C_write_Keystate+1 
	MOVLW       1
	MOVWF       FARG_I2C_write_Length+0 
	CALL        _I2C_write+0, 0
;QT60.c,119 :: 		I2C_write (QtAddress, QT_SETUP_OFFSET, QtSetupBlock, LEN_QT_SETUP);
	MOVF        _QtAddress+0, 0 
	MOVWF       FARG_I2C_write_QTAddress+0 
	MOVLW       131
	MOVWF       FARG_I2C_write_QTRegister+0 
	MOVLW       _QtSetupBlock+0
	MOVWF       FARG_I2C_write_Keystate+0 
	MOVLW       hi_addr(_QtSetupBlock+0)
	MOVWF       FARG_I2C_write_Keystate+1 
	MOVLW       123
	MOVWF       FARG_I2C_write_Length+0 
	CALL        _I2C_write+0, 0
;QT60.c,120 :: 		}
L_SetQtSetup7:
;QT60.c,121 :: 		}
	GOTO        L_SetQtSetup8
L_SetQtSetup6:
;QT60.c,123 :: 		RetVal = FALSE; /* fail if illegal parameter was specified */
	CLRF        SetQtSetup_RetVal_L0+0 
L_SetQtSetup8:
;QT60.c,125 :: 		return RetVal; /* completed */
	MOVF        SetQtSetup_RetVal_L0+0, 0 
	MOVWF       R0 
;QT60.c,126 :: 		}
L_end_SetQtSetup:
	RETURN      0
; end of _SetQtSetup

_ReadQtSetup:

;QT60.c,133 :: 		void ReadQtSetup ( void )
;QT60.c,135 :: 		I2C_get( QtAddress, 131, TestBuff, 123);
	MOVF        _QtAddress+0, 0 
	MOVWF       FARG_I2C_get_QTAddress+0 
	MOVLW       131
	MOVWF       FARG_I2C_get_QTRegister+0 
	MOVLW       _TestBuff+0
	MOVWF       FARG_I2C_get_Keystate+0 
	MOVLW       hi_addr(_TestBuff+0)
	MOVWF       FARG_I2C_get_Keystate+1 
	MOVLW       123
	MOVWF       FARG_I2C_get_Length+0 
	CALL        _I2C_get+0, 0
;QT60.c,136 :: 		}
L_end_ReadQtSetup:
	RETURN      0
; end of _ReadQtSetup

_ReadQtKeys:

;QT60.c,143 :: 		void ReadQtKeys ( void )
;QT60.c,145 :: 		I2C_get( QtAddress, QT_KEYS_OFFSET, QtKeys, NUM_QT_KEY_BYTES);
	MOVF        _QtAddress+0, 0 
	MOVWF       FARG_I2C_get_QTAddress+0 
	MOVLW       1
	MOVWF       FARG_I2C_get_QTRegister+0 
	MOVLW       _QtKeys+0
	MOVWF       FARG_I2C_get_Keystate+0 
	MOVLW       hi_addr(_QtKeys+0)
	MOVWF       FARG_I2C_get_Keystate+1 
	MOVLW       3
	MOVWF       FARG_I2C_get_Length+0 
	CALL        _I2C_get+0, 0
;QT60.c,146 :: 		}
L_end_ReadQtKeys:
	RETURN      0
; end of _ReadQtKeys

_GetQtKeys:

;QT60.c,153 :: 		UCHAR GetQtKeys(UCHAR Index)
;QT60.c,155 :: 		return QtKeys[Index];
	MOVLW       _QtKeys+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_QtKeys+0)
	MOVWF       FSR0H 
	MOVF        FARG_GetQtKeys_Index+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
;QT60.c,156 :: 		}
L_end_GetQtKeys:
	RETURN      0
; end of _GetQtKeys

_setkeyhold:

;QT60.c,163 :: 		void setkeyhold()
;QT60.c,165 :: 		MemeSet(QtSetupBlock, QT_HOLD_NRD, NUM_QT_KEYS);
	MOVLW       _QtSetupBlock+0
	MOVWF       FARG_MemeSet_target+0 
	MOVLW       hi_addr(_QtSetupBlock+0)
	MOVWF       FARG_MemeSet_target+1 
	CLRF        FARG_MemeSet_Transdata+0 
	MOVLW       9
	MOVWF       FARG_MemeSet_len+0 
	MOVLW       0
	MOVWF       FARG_MemeSet_len+1 
	CALL        _MemeSet+0, 0
;QT60.c,166 :: 		asm nop;
	NOP
;QT60.c,168 :: 		I2C_write (QtAddress,
	MOVF        _QtAddress+0, 0 
	MOVWF       FARG_I2C_write_QTAddress+0 
;QT60.c,169 :: 		QT_UNLOCK_OFFSET,
	MOVLW       130
	MOVWF       FARG_I2C_write_QTRegister+0 
;QT60.c,170 :: 		&QtCommand,
	MOVLW       _QtCommand+0
	MOVWF       FARG_I2C_write_Keystate+0 
	MOVLW       hi_addr(_QtCommand+0)
	MOVWF       FARG_I2C_write_Keystate+1 
;QT60.c,171 :: 		1);
	MOVLW       1
	MOVWF       FARG_I2C_write_Length+0 
	CALL        _I2C_write+0, 0
;QT60.c,172 :: 		I2C_write (QtAddress,
	MOVF        _QtAddress+0, 0 
	MOVWF       FARG_I2C_write_QTAddress+0 
;QT60.c,173 :: 		QT_SETUP_OFFSET+ParamDef[QT_PARAM_NRD].Offset,
	MOVLW       203
	MOVWF       FARG_I2C_write_QTRegister+0 
;QT60.c,174 :: 		QtSetupBlock,
	MOVLW       _QtSetupBlock+0
	MOVWF       FARG_I2C_write_Keystate+0 
	MOVLW       hi_addr(_QtSetupBlock+0)
	MOVWF       FARG_I2C_write_Keystate+1 
;QT60.c,175 :: 		NUM_QT_KEYS);
	MOVLW       9
	MOVWF       FARG_I2C_write_Length+0 
	CALL        _I2C_write+0, 0
;QT60.c,180 :: 		asm nop;
	NOP
;QT60.c,181 :: 		}
L_end_setkeyhold:
	RETURN      0
; end of _setkeyhold

_setkeysence:

;QT60.c,188 :: 		void setkeysence()
;QT60.c,192 :: 		bufer = QT_SENS_NTHR + (QT_DEF_NDRIFT << 4);
	MOVLW       175
	MOVWF       setkeysence_bufer_L0+0 
;QT60.c,193 :: 		MemeSet(QtSetupBlock, bufer, NUM_QT_KEYS);
	MOVLW       _QtSetupBlock+0
	MOVWF       FARG_MemeSet_target+0 
	MOVLW       hi_addr(_QtSetupBlock+0)
	MOVWF       FARG_MemeSet_target+1 
	MOVF        setkeysence_bufer_L0+0, 0 
	MOVWF       FARG_MemeSet_Transdata+0 
	MOVLW       9
	MOVWF       FARG_MemeSet_len+0 
	MOVLW       0
	MOVWF       FARG_MemeSet_len+1 
	CALL        _MemeSet+0, 0
;QT60.c,194 :: 		asm nop;
	NOP
;QT60.c,196 :: 		I2C_write (QtAddress,
	MOVF        _QtAddress+0, 0 
	MOVWF       FARG_I2C_write_QTAddress+0 
;QT60.c,197 :: 		QT_UNLOCK_OFFSET,
	MOVLW       130
	MOVWF       FARG_I2C_write_QTRegister+0 
;QT60.c,198 :: 		&QtCommand,
	MOVLW       _QtCommand+0
	MOVWF       FARG_I2C_write_Keystate+0 
	MOVLW       hi_addr(_QtCommand+0)
	MOVWF       FARG_I2C_write_Keystate+1 
;QT60.c,199 :: 		1);
	MOVLW       1
	MOVWF       FARG_I2C_write_Length+0 
	CALL        _I2C_write+0, 0
;QT60.c,200 :: 		I2C_write (QtAddress,
	MOVF        _QtAddress+0, 0 
	MOVWF       FARG_I2C_write_QTAddress+0 
;QT60.c,201 :: 		QT_SETUP_OFFSET+ParamDef[QT_PARAM_NTHR].Offset,
	MOVLW       131
	MOVWF       FARG_I2C_write_QTRegister+0 
;QT60.c,202 :: 		QtSetupBlock,
	MOVLW       _QtSetupBlock+0
	MOVWF       FARG_I2C_write_Keystate+0 
	MOVLW       hi_addr(_QtSetupBlock+0)
	MOVWF       FARG_I2C_write_Keystate+1 
;QT60.c,203 :: 		NUM_QT_KEYS);
	MOVLW       9
	MOVWF       FARG_I2C_write_Length+0 
	CALL        _I2C_write+0, 0
;QT60.c,208 :: 		asm nop;
	NOP
;QT60.c,209 :: 		}
L_end_setkeysence:
	RETURN      0
; end of _setkeysence

_setkeysenceaks:

;QT60.c,216 :: 		void setkeysenceaks()
;QT60.c,220 :: 		bufer = (QT_SENS_AKS << 6) + (1 << 4);
	MOVLW       80
	MOVWF       setkeysenceaks_bufer_L0+0 
;QT60.c,221 :: 		MemeSet(QtSetupBlock, bufer, NUM_QT_KEYS);
	MOVLW       _QtSetupBlock+0
	MOVWF       FARG_MemeSet_target+0 
	MOVLW       hi_addr(_QtSetupBlock+0)
	MOVWF       FARG_MemeSet_target+1 
	MOVF        setkeysenceaks_bufer_L0+0, 0 
	MOVWF       FARG_MemeSet_Transdata+0 
	MOVLW       9
	MOVWF       FARG_MemeSet_len+0 
	MOVLW       0
	MOVWF       FARG_MemeSet_len+1 
	CALL        _MemeSet+0, 0
;QT60.c,224 :: 		asm nop;
	NOP
;QT60.c,226 :: 		I2C_write (QtAddress,
	MOVF        _QtAddress+0, 0 
	MOVWF       FARG_I2C_write_QTAddress+0 
;QT60.c,227 :: 		QT_UNLOCK_OFFSET,
	MOVLW       130
	MOVWF       FARG_I2C_write_QTRegister+0 
;QT60.c,228 :: 		&QtCommand,
	MOVLW       _QtCommand+0
	MOVWF       FARG_I2C_write_Keystate+0 
	MOVLW       hi_addr(_QtCommand+0)
	MOVWF       FARG_I2C_write_Keystate+1 
;QT60.c,229 :: 		1);
	MOVLW       1
	MOVWF       FARG_I2C_write_Length+0 
	CALL        _I2C_write+0, 0
;QT60.c,230 :: 		I2C_write (QtAddress,
	MOVF        _QtAddress+0, 0 
	MOVWF       FARG_I2C_write_QTAddress+0 
;QT60.c,231 :: 		QT_SETUP_OFFSET+ParamDef[QT_PARAM_AKS].Offset,
	MOVLW       227
	MOVWF       FARG_I2C_write_QTRegister+0 
;QT60.c,232 :: 		QtSetupBlock,
	MOVLW       _QtSetupBlock+0
	MOVWF       FARG_I2C_write_Keystate+0 
	MOVLW       hi_addr(_QtSetupBlock+0)
	MOVWF       FARG_I2C_write_Keystate+1 
;QT60.c,233 :: 		NUM_QT_KEYS);
	MOVLW       9
	MOVWF       FARG_I2C_write_Length+0 
	CALL        _I2C_write+0, 0
;QT60.c,238 :: 		asm nop;
	NOP
;QT60.c,239 :: 		}
L_end_setkeysenceaks:
	RETURN      0
; end of _setkeysenceaks

_enablekeys:

;QT60.c,246 :: 		void enablekeys()
;QT60.c,251 :: 		bufer = QT_DEF_NDIL + (QT_DEF_FDIL << 4);
	MOVLW       82
	MOVWF       enablekeys_bufer_L0+0 
;QT60.c,252 :: 		for(i=0;i<NUM_QT_KEYS;i++)
	CLRF        enablekeys_i_L0+0 
L_enablekeys9:
	MOVLW       9
	SUBWF       enablekeys_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_enablekeys10
;QT60.c,254 :: 		QtSetupBlock[i] = bufer;
	MOVLW       _QtSetupBlock+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_QtSetupBlock+0)
	MOVWF       FSR1H 
	MOVF        enablekeys_i_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVF        enablekeys_bufer_L0+0, 0 
	MOVWF       POSTINC1+0 
;QT60.c,252 :: 		for(i=0;i<NUM_QT_KEYS;i++)
	INCF        enablekeys_i_L0+0, 1 
;QT60.c,255 :: 		}
	GOTO        L_enablekeys9
L_enablekeys10:
;QT60.c,256 :: 		bufer = 0 + (QT_DEF_FDIL << 4);
	MOVLW       80
	MOVWF       enablekeys_bufer_L0+0 
;QT60.c,257 :: 		for(;i<24;i++)
L_enablekeys12:
	MOVLW       24
	SUBWF       enablekeys_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_enablekeys13
;QT60.c,259 :: 		QtSetupBlock[i] = bufer;
	MOVLW       _QtSetupBlock+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_QtSetupBlock+0)
	MOVWF       FSR1H 
	MOVF        enablekeys_i_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVF        enablekeys_bufer_L0+0, 0 
	MOVWF       POSTINC1+0 
;QT60.c,257 :: 		for(;i<24;i++)
	INCF        enablekeys_i_L0+0, 1 
;QT60.c,260 :: 		}
	GOTO        L_enablekeys12
L_enablekeys13:
;QT60.c,261 :: 		asm nop;
	NOP
;QT60.c,263 :: 		I2C_write (QtAddress,
	MOVF        _QtAddress+0, 0 
	MOVWF       FARG_I2C_write_QTAddress+0 
;QT60.c,264 :: 		QT_UNLOCK_OFFSET,
	MOVLW       130
	MOVWF       FARG_I2C_write_QTRegister+0 
;QT60.c,265 :: 		&QtCommand,
	MOVLW       _QtCommand+0
	MOVWF       FARG_I2C_write_Keystate+0 
	MOVLW       hi_addr(_QtCommand+0)
	MOVWF       FARG_I2C_write_Keystate+1 
;QT60.c,266 :: 		1);
	MOVLW       1
	MOVWF       FARG_I2C_write_Length+0 
	CALL        _I2C_write+0, 0
;QT60.c,267 :: 		I2C_write (QtAddress,
	MOVF        _QtAddress+0, 0 
	MOVWF       FARG_I2C_write_QTAddress+0 
;QT60.c,268 :: 		QT_SETUP_OFFSET+ParamDef[QT_PARAM_NDIL].Offset,
	MOVLW       179
	MOVWF       FARG_I2C_write_QTRegister+0 
;QT60.c,269 :: 		QtSetupBlock,
	MOVLW       _QtSetupBlock+0
	MOVWF       FARG_I2C_write_Keystate+0 
	MOVLW       hi_addr(_QtSetupBlock+0)
	MOVWF       FARG_I2C_write_Keystate+1 
;QT60.c,270 :: 		24);
	MOVLW       24
	MOVWF       FARG_I2C_write_Length+0 
	CALL        _I2C_write+0, 0
;QT60.c,275 :: 		asm nop;
	NOP
;QT60.c,276 :: 		}
L_end_enablekeys:
	RETURN      0
; end of _enablekeys

_calikey:

;QT60.c,283 :: 		void calikey()
;QT60.c,285 :: 		calibufer = 0x55;
	MOVLW       85
	MOVWF       _calibufer+0 
;QT60.c,286 :: 		asm nop;
	NOP
;QT60.c,288 :: 		I2C_write (QtAddress,
	MOVF        _QtAddress+0, 0 
	MOVWF       FARG_I2C_write_QTAddress+0 
;QT60.c,289 :: 		QT_UNLOCK_OFFSET,
	MOVLW       130
	MOVWF       FARG_I2C_write_QTRegister+0 
;QT60.c,290 :: 		&QtCommand,
	MOVLW       _QtCommand+0
	MOVWF       FARG_I2C_write_Keystate+0 
	MOVLW       hi_addr(_QtCommand+0)
	MOVWF       FARG_I2C_write_Keystate+1 
;QT60.c,291 :: 		1);
	MOVLW       1
	MOVWF       FARG_I2C_write_Length+0 
	CALL        _I2C_write+0, 0
;QT60.c,292 :: 		I2C_write (QtAddress,
	MOVF        _QtAddress+0, 0 
	MOVWF       FARG_I2C_write_QTAddress+0 
;QT60.c,293 :: 		125,
	MOVLW       125
	MOVWF       FARG_I2C_write_QTRegister+0 
;QT60.c,294 :: 		&calibufer,
	MOVLW       _calibufer+0
	MOVWF       FARG_I2C_write_Keystate+0 
	MOVLW       hi_addr(_calibufer+0)
	MOVWF       FARG_I2C_write_Keystate+1 
;QT60.c,295 :: 		1);
	MOVLW       1
	MOVWF       FARG_I2C_write_Length+0 
	CALL        _I2C_write+0, 0
;QT60.c,296 :: 		Delay_ms(500);
	MOVLW       13
	MOVWF       R11, 0
	MOVLW       175
	MOVWF       R12, 0
	MOVLW       182
	MOVWF       R13, 0
L_calikey15:
	DECFSZ      R13, 1, 1
	BRA         L_calikey15
	DECFSZ      R12, 1, 1
	BRA         L_calikey15
	DECFSZ      R11, 1, 1
	BRA         L_calikey15
	NOP
;QT60.c,297 :: 		asm nop;
	NOP
;QT60.c,298 :: 		}
L_end_calikey:
	RETURN      0
; end of _calikey
