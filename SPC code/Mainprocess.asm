
_VTProcess:

;Mainprocess.c,41 :: 		void VTProcess()
;Mainprocess.c,46 :: 		if(spc_system_flag.bite.meas_VT_reach & 0x01)
	MOVLW       6
	ANDWF       _spc_system_flag+0, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	BCF         R1, 7 
	BTFSS       R1, 0 
	GOTO        L_VTProcess0
;Mainprocess.c,47 :: 		Voltprocess();
	CALL        _Voltprocess+0, 0
L_VTProcess0:
;Mainprocess.c,50 :: 		if(spc_system_flag.bite.meas_VT_reach & 0x02)
	MOVLW       6
	ANDWF       _spc_system_flag+0, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	BCF         R1, 7 
	BTFSS       R1, 1 
	GOTO        L_VTProcess1
;Mainprocess.c,53 :: 		if(TempChannel1_Finish == 0)
	MOVF        VTProcess_TempChannel1_Finish_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_VTProcess2
;Mainprocess.c,55 :: 		if(pSPCValue[CHANNEL1].SPCSetPoints.MaintainTemp.Temperature_C != SPC_SYSTEMVALUE_OFF)
	MOVF        _pSPCValue+57, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__VTProcess331
	MOVLW       255
	XORWF       _pSPCValue+56, 0 
L__VTProcess331:
	BTFSC       STATUS+0, 2 
	GOTO        L_VTProcess3
;Mainprocess.c,56 :: 		TempChannel1_Finish = Tempprocess(CHANNEL1);
	CLRF        FARG_Tempprocess_ChannelNum+0 
	CALL        _Tempprocess+0, 0
	MOVF        R0, 0 
	MOVWF       VTProcess_TempChannel1_Finish_L0+0 
	GOTO        L_VTProcess4
L_VTProcess3:
;Mainprocess.c,59 :: 		asm nop;
	NOP
;Mainprocess.c,60 :: 		Spcssr[CHANNEL1].SSR_cmd = 0;
	CLRF        _Spcssr+0 
;Mainprocess.c,61 :: 		ADC_busy[CHANNEL1] = ADC_FREE;
	CLRF        _ADC_busy+0 
;Mainprocess.c,62 :: 		TempChannel1_Finish = 1;
	MOVLW       1
	MOVWF       VTProcess_TempChannel1_Finish_L0+0 
;Mainprocess.c,64 :: 		}
L_VTProcess4:
;Mainprocess.c,65 :: 		}
L_VTProcess2:
;Mainprocess.c,67 :: 		if(TempChannel2_Finish == 0)
	MOVF        VTProcess_TempChannel2_Finish_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_VTProcess5
;Mainprocess.c,69 :: 		if(pSPCValue[CHANNEL2].SPCSetPoints.MaintainTemp.Temperature_C != SPC_SYSTEMVALUE_OFF)
	MOVF        _pSPCValue+199, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__VTProcess332
	MOVLW       255
	XORWF       _pSPCValue+198, 0 
L__VTProcess332:
	BTFSC       STATUS+0, 2 
	GOTO        L_VTProcess6
;Mainprocess.c,70 :: 		TempChannel2_Finish = Tempprocess(CHANNEL2);
	MOVLW       1
	MOVWF       FARG_Tempprocess_ChannelNum+0 
	CALL        _Tempprocess+0, 0
	MOVF        R0, 0 
	MOVWF       VTProcess_TempChannel2_Finish_L0+0 
	GOTO        L_VTProcess7
L_VTProcess6:
;Mainprocess.c,73 :: 		asm nop;
	NOP
;Mainprocess.c,74 :: 		Spcssr[CHANNEL2].SSR_cmd = 0;
	CLRF        _Spcssr+3 
;Mainprocess.c,75 :: 		ADC_busy[CHANNEL2] = ADC_FREE;
	CLRF        _ADC_busy+1 
;Mainprocess.c,76 :: 		TempChannel2_Finish = 1;
	MOVLW       1
	MOVWF       VTProcess_TempChannel2_Finish_L0+0 
;Mainprocess.c,78 :: 		}
L_VTProcess7:
;Mainprocess.c,79 :: 		}
L_VTProcess5:
;Mainprocess.c,81 :: 		if((TempChannel1_Finish) && (TempChannel2_Finish))
	MOVF        VTProcess_TempChannel1_Finish_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_VTProcess10
	MOVF        VTProcess_TempChannel2_Finish_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_VTProcess10
L__VTProcess313:
;Mainprocess.c,83 :: 		TempChannel1_Finish = 0;
	CLRF        VTProcess_TempChannel1_Finish_L0+0 
;Mainprocess.c,84 :: 		TempChannel2_Finish = 0;
	CLRF        VTProcess_TempChannel2_Finish_L0+0 
;Mainprocess.c,85 :: 		spc_system_flag.bite.meas_VT_reach &= 0xfd;
	MOVLW       6
	ANDWF       _spc_system_flag+0, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	BCF         R1, 7 
	MOVLW       253
	ANDWF       R1, 0 
	MOVWF       R2 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       R1 
	MOVF        R2, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__VTProcess333:
	BZ          L__VTProcess334
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__VTProcess333
L__VTProcess334:
	MOVF        _spc_system_flag+0, 0 
	XORWF       R0, 1 
	MOVLW       6
	ANDWF       R0, 1 
	MOVF        _spc_system_flag+0, 0 
	XORWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _spc_system_flag+0 
;Mainprocess.c,86 :: 		}
L_VTProcess10:
;Mainprocess.c,87 :: 		}
L_VTProcess1:
;Mainprocess.c,88 :: 		}
L_end_VTProcess:
	RETURN      0
; end of _VTProcess

_CGProcess:

;Mainprocess.c,95 :: 		void CGProcess(char ChannelNum)
;Mainprocess.c,99 :: 		if(Spcpwm[ChannelNum].meas_cmd == START_MEASUREMENT)
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_CGProcess11
;Mainprocess.c,101 :: 		if((ADC_busy[ChannelNum] == GETING_TEMP) || (ADC_busy[ChannelNum] == GETING_TEMP_REQ))
	MOVLW       _ADC_busy+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_ADC_busy+0)
	MOVWF       FSR0H 
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__CGProcess314
	MOVLW       _ADC_busy+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_ADC_busy+0)
	MOVWF       FSR0H 
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__CGProcess314
	GOTO        L_CGProcess14
L__CGProcess314:
;Mainprocess.c,102 :: 		return;
	GOTO        L_end_CGProcess
L_CGProcess14:
;Mainprocess.c,105 :: 		ADC_busy[ChannelNum] = GETING_GFI_CURRENT;
	MOVLW       _ADC_busy+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_ADC_busy+0)
	MOVWF       FSR1H 
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       2
	MOVWF       POSTINC1+0 
;Mainprocess.c,106 :: 		spc_count.meas_CG_count[ChannelNum] = 0;
	MOVLW       _spc_count+11
	MOVWF       FSR1 
	MOVLW       hi_addr(_spc_count+11)
	MOVWF       FSR1H 
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;Mainprocess.c,107 :: 		SpcAcc[ChannelNum].Current_acc = 0;
	MOVLW       12
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _SpcAcc+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_SpcAcc+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;Mainprocess.c,108 :: 		SpcAcc[ChannelNum].GFI_acc = 0;
	MOVLW       12
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _SpcAcc+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_SpcAcc+0)
	ADDWFC      R1, 1 
	MOVLW       4
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;Mainprocess.c,109 :: 		Spcpwm[ChannelNum].meas_cmd = RUNING_MEASUREMENT;
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       3
	MOVWF       POSTINC1+0 
;Mainprocess.c,110 :: 		while(Spcpwm[ChannelNum].meas_cmd == RUNING_MEASUREMENT)
L_CGProcess16:
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_CGProcess17
;Mainprocess.c,112 :: 		SpcAcc[ChannelNum].Current_acc += GetGFI(ADC_Channel[ChannelNum], CURRENT_AD_COMMND);
	MOVLW       12
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _SpcAcc+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_SpcAcc+0)
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       FLOC__CGProcess+0 
	MOVF        R1, 0 
	MOVWF       FLOC__CGProcess+1 
	MOVLW       Mainprocess_ADC_Channel+0
	ADDWF       FARG_CGProcess_ChannelNum+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(Mainprocess_ADC_Channel+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(Mainprocess_ADC_Channel+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_GetGFI_ChannelSelect+0
	MOVLW       160
	MOVWF       FARG_GetGFI_cmd+0 
	CALL        _GetGFI+0, 0
	MOVFF       FLOC__CGProcess+0, FSR0
	MOVFF       FLOC__CGProcess+1, FSR0H
	MOVLW       0
	MOVWF       R2 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	ADDWF       R0, 1 
	MOVF        POSTINC0+0, 0 
	ADDWFC      R1, 1 
	MOVF        POSTINC0+0, 0 
	ADDWFC      R2, 1 
	MOVF        POSTINC0+0, 0 
	ADDWFC      R3, 1 
	MOVFF       FLOC__CGProcess+0, FSR1
	MOVFF       FLOC__CGProcess+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,113 :: 		SpcAcc[ChannelNum].GFI_acc += GetGFI(ADC_Channel[ChannelNum], GFI_AD_COMMND);
	MOVLW       12
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _SpcAcc+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_SpcAcc+0)
	ADDWFC      R1, 1 
	MOVLW       4
	ADDWF       R0, 0 
	MOVWF       FLOC__CGProcess+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__CGProcess+1 
	MOVLW       Mainprocess_ADC_Channel+0
	ADDWF       FARG_CGProcess_ChannelNum+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(Mainprocess_ADC_Channel+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(Mainprocess_ADC_Channel+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_GetGFI_ChannelSelect+0
	MOVLW       224
	MOVWF       FARG_GetGFI_cmd+0 
	CALL        _GetGFI+0, 0
	MOVFF       FLOC__CGProcess+0, FSR0
	MOVFF       FLOC__CGProcess+1, FSR0H
	MOVLW       0
	MOVWF       R2 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	ADDWF       R0, 1 
	MOVF        POSTINC0+0, 0 
	ADDWFC      R1, 1 
	MOVF        POSTINC0+0, 0 
	ADDWFC      R2, 1 
	MOVF        POSTINC0+0, 0 
	ADDWFC      R3, 1 
	MOVFF       FLOC__CGProcess+0, FSR1
	MOVFF       FLOC__CGProcess+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,114 :: 		spc_count.meas_CG_count[ChannelNum]++;
	MOVLW       _spc_count+11
	MOVWF       R1 
	MOVLW       hi_addr(_spc_count+11)
	MOVWF       R2 
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVF        POSTINC0+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,115 :: 		}
	GOTO        L_CGProcess16
L_CGProcess17:
;Mainprocess.c,117 :: 		}
	GOTO        L_CGProcess18
L_CGProcess11:
;Mainprocess.c,118 :: 		else if(Spcpwm[ChannelNum].meas_cmd == FINISH_MEASUREMENT)
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_CGProcess19
;Mainprocess.c,120 :: 		if(SpcAcc[ChannelNum].Current_acc == 0)
	MOVLW       12
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _SpcAcc+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_SpcAcc+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	XORWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__CGProcess336
	MOVF        R0, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__CGProcess336
	MOVF        R0, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__CGProcess336
	MOVF        R1, 0 
	XORLW       0
L__CGProcess336:
	BTFSS       STATUS+0, 2 
	GOTO        L_CGProcess20
;Mainprocess.c,121 :: 		CurrentBuff = 0;
	CLRF        CGProcess_CurrentBuff_L0+0 
	CLRF        CGProcess_CurrentBuff_L0+1 
	GOTO        L_CGProcess21
L_CGProcess20:
;Mainprocess.c,123 :: 		CurrentBuff = SpcAcc[ChannelNum].Current_acc/spc_count.meas_CG_count[ChannelNum];
	MOVLW       12
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _SpcAcc+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_SpcAcc+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVLW       _spc_count+11
	MOVWF       FSR2 
	MOVLW       hi_addr(_spc_count+11)
	MOVWF       FSR2H 
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	ADDWF       FSR2, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR2H, 1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Div_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       CGProcess_CurrentBuff_L0+0 
	MOVF        R1, 0 
	MOVWF       CGProcess_CurrentBuff_L0+1 
L_CGProcess21:
;Mainprocess.c,125 :: 		if(SpcAcc[ChannelNum].GFI_acc == 0)
	MOVLW       12
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _SpcAcc+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_SpcAcc+0)
	ADDWFC      R1, 1 
	MOVLW       4
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	XORWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__CGProcess337
	MOVF        R0, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__CGProcess337
	MOVF        R0, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__CGProcess337
	MOVF        R1, 0 
	XORLW       0
L__CGProcess337:
	BTFSS       STATUS+0, 2 
	GOTO        L_CGProcess22
;Mainprocess.c,126 :: 		GFIBuff = 0;
	CLRF        CGProcess_GFIBuff_L0+0 
	CLRF        CGProcess_GFIBuff_L0+1 
	GOTO        L_CGProcess23
L_CGProcess22:
;Mainprocess.c,128 :: 		GFIBuff = SpcAcc[ChannelNum].GFI_acc/spc_count.meas_CG_count[ChannelNum];
	MOVLW       12
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _SpcAcc+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_SpcAcc+0)
	ADDWFC      R1, 1 
	MOVLW       4
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVLW       _spc_count+11
	MOVWF       FSR2 
	MOVLW       hi_addr(_spc_count+11)
	MOVWF       FSR2H 
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	ADDWF       FSR2, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR2H, 1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Div_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       CGProcess_GFIBuff_L0+0 
	MOVF        R1, 0 
	MOVWF       CGProcess_GFIBuff_L0+1 
L_CGProcess23:
;Mainprocess.c,130 :: 		pSPCValue[ChannelNum].SPCActual.Current = ConvertADtoCurrent(CurrentBuff, ChannelNum);
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       14
	ADDWF       R0, 0 
	MOVWF       FLOC__CGProcess+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__CGProcess+1 
	MOVF        CGProcess_CurrentBuff_L0+0, 0 
	MOVWF       FARG_ConvertADtoCurrent_ADcurrent+0 
	MOVF        CGProcess_CurrentBuff_L0+1, 0 
	MOVWF       FARG_ConvertADtoCurrent_ADcurrent+1 
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	MOVWF       FARG_ConvertADtoCurrent_ChannelNum+0 
	CALL        _ConvertADtoCurrent+0, 0
	MOVFF       FLOC__CGProcess+0, FSR1
	MOVFF       FLOC__CGProcess+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,131 :: 		pSPCValue[ChannelNum].SPCActual.GFICurrent = ConvertADtoGFI(GFIBuff, ChannelNum);
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       18
	ADDWF       R0, 0 
	MOVWF       FLOC__CGProcess+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__CGProcess+1 
	MOVF        CGProcess_GFIBuff_L0+0, 0 
	MOVWF       FARG_ConvertADtoGFI_ADcurrent+0 
	MOVF        CGProcess_GFIBuff_L0+1, 0 
	MOVWF       FARG_ConvertADtoGFI_ADcurrent+1 
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	MOVWF       FARG_ConvertADtoGFI_ChannelNum+0 
	CALL        _ConvertADtoGFI+0, 0
	MOVFF       FLOC__CGProcess+0, FSR1
	MOVFF       FLOC__CGProcess+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,134 :: 		if(pSPCValue[ChannelNum].SPCActual.Current > MAX_SPCCURRENT)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       14
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORLW       1
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__CGProcess338
	MOVF        R1, 0 
	SUBLW       44
L__CGProcess338:
	BTFSC       STATUS+0, 0 
	GOTO        L_CGProcess24
;Mainprocess.c,136 :: 		pSPCValue[ChannelNum].SPCActual.Current = OUTOFRANGE;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       14
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       254
	MOVWF       POSTINC1+0 
	MOVLW       127
	MOVWF       POSTINC1+0 
;Mainprocess.c,137 :: 		}
	GOTO        L_CGProcess25
L_CGProcess24:
;Mainprocess.c,140 :: 		if(duty_index[ChannelNum] == 0)
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _duty_index+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_duty_index+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__CGProcess339
	MOVLW       0
	XORWF       R1, 0 
L__CGProcess339:
	BTFSS       STATUS+0, 2 
	GOTO        L_CGProcess26
;Mainprocess.c,141 :: 		pSPCValue[ChannelNum].SPCActual.Current_RMS = pSPCValue[ChannelNum].SPCActual.Current;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       16
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       14
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	GOTO        L_CGProcess27
L_CGProcess26:
;Mainprocess.c,143 :: 		pSPCValue[ChannelNum].SPCActual.Current_RMS = pSPCValue[ChannelNum].SPCActual.Current*duty_index[ChannelNum]/10;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       16
	ADDWF       R0, 0 
	MOVWF       FLOC__CGProcess+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__CGProcess+1 
	MOVLW       14
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        POSTINC0+0, 0 
	MOVWF       R5 
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _duty_index+0
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       hi_addr(_duty_index+0)
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R0 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVFF       FLOC__CGProcess+0, FSR1
	MOVFF       FLOC__CGProcess+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
L_CGProcess27:
;Mainprocess.c,144 :: 		}
L_CGProcess25:
;Mainprocess.c,146 :: 		if(pSPCValue[ChannelNum].SPCActual.GFICurrent > MAX_SPCGFIALARM)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       18
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORLW       1
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__CGProcess340
	MOVF        R1, 0 
	SUBLW       244
L__CGProcess340:
	BTFSC       STATUS+0, 0 
	GOTO        L_CGProcess28
;Mainprocess.c,147 :: 		pSPCValue[ChannelNum].SPCActual.GFICurrent = OUTOFRANGE;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       18
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       254
	MOVWF       POSTINC1+0 
	MOVLW       127
	MOVWF       POSTINC1+0 
L_CGProcess28:
;Mainprocess.c,149 :: 		SystemUpdate |= (CH1_CURRENT_GFI_UPDATE_REQ << ChannelNum);
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       16
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__CGProcess341:
	BZ          L__CGProcess342
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__CGProcess341
L__CGProcess342:
	MOVF        R0, 0 
	IORWF       _SystemUpdate+0, 1 
	MOVF        R1, 0 
	IORWF       _SystemUpdate+1, 1 
	MOVF        R2, 0 
	IORWF       _SystemUpdate+2, 1 
	MOVF        R3, 0 
	IORWF       _SystemUpdate+3, 1 
;Mainprocess.c,150 :: 		SetIntStr((int*)&pSPCValue[ChannelNum].SPCActual.GFICurrent, CH1_ACTURAL_GFI+ChannelNum, UNIT_MILIAMPER, 2);
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 0 
	MOVWF       FARG_SetIntStr_ptr+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_SetIntStr_ptr+1 
	MOVLW       18
	ADDWF       FARG_SetIntStr_ptr+0, 1 
	MOVLW       0
	ADDWFC      FARG_SetIntStr_ptr+1, 1 
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	ADDLW       2
	MOVWF       FARG_SetIntStr_strlocat+0 
	MOVLW       5
	MOVWF       FARG_SetIntStr_unitlocar+0 
	MOVLW       2
	MOVWF       FARG_SetIntStr_len+0 
	CALL        _SetIntStr+0, 0
;Mainprocess.c,151 :: 		SetCurrentStr((int*)&pSPCValue[ChannelNum].SPCActual.Current_RMS, CH1_ACTURAL_CURRENT+ChannelNum, UNIT_AMPER, 1);
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 0 
	MOVWF       FARG_SetCurrentStr_ptr+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_SetCurrentStr_ptr+1 
	MOVLW       16
	ADDWF       FARG_SetCurrentStr_ptr+0, 1 
	MOVLW       0
	ADDWFC      FARG_SetCurrentStr_ptr+1, 1 
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	ADDLW       4
	MOVWF       FARG_SetCurrentStr_strlocat+0 
	MOVLW       4
	MOVWF       FARG_SetCurrentStr_unitlocar+0 
	MOVLW       1
	MOVWF       FARG_SetCurrentStr_len+0 
	CALL        _SetCurrentStr+0, 0
;Mainprocess.c,153 :: 		Currentprocess(ChannelNum);
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	MOVWF       FARG_Currentprocess_ChannelNum+0 
	CALL        _Currentprocess+0, 0
;Mainprocess.c,155 :: 		ADC_busy[ChannelNum] = ADC_FREE;
	MOVLW       _ADC_busy+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_ADC_busy+0)
	MOVWF       FSR1H 
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;Mainprocess.c,156 :: 		Spcpwm[ChannelNum].meas_cmd = IDEL_MEASUREMENT;
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_CGProcess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       5
	MOVWF       POSTINC1+0 
;Mainprocess.c,157 :: 		}
L_CGProcess19:
L_CGProcess18:
;Mainprocess.c,158 :: 		}
L_end_CGProcess:
	RETURN      0
; end of _CGProcess

_TempErrorAction:

;Mainprocess.c,165 :: 		void TempErrorAction(char ChannelNum, char ActionCmd)
;Mainprocess.c,167 :: 		if(ActionCmd)
	MOVF        FARG_TempErrorAction_ActionCmd+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_TempErrorAction29
;Mainprocess.c,169 :: 		if(pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.rtd_fail_mod)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_TempErrorAction_ChannelNum+0, 0 
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
	BTFSS       R0, 7 
	GOTO        L_TempErrorAction30
;Mainprocess.c,171 :: 		ForceSSRONCondition[ChannelNum] |= FAILUREMODEFORCEON;
	MOVLW       _ForceSSRONCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSRONCondition+0)
	MOVWF       R2 
	MOVF        FARG_TempErrorAction_ChannelNum+0, 0 
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
;Mainprocess.c,172 :: 		ForceSSROFFCondition[ChannelNum] &= ~FAILUREMODEFORCEOFF;
	MOVLW       _ForceSSROFFCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSROFFCondition+0)
	MOVWF       R2 
	MOVF        FARG_TempErrorAction_ChannelNum+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVLW       251
	ANDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,173 :: 		}
	GOTO        L_TempErrorAction31
L_TempErrorAction30:
;Mainprocess.c,176 :: 		ForceSSRONCondition[ChannelNum] &= ~FAILUREMODEFORCEON;
	MOVLW       _ForceSSRONCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSRONCondition+0)
	MOVWF       R2 
	MOVF        FARG_TempErrorAction_ChannelNum+0, 0 
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
;Mainprocess.c,177 :: 		ForceSSROFFCondition[ChannelNum] |= FAILUREMODEFORCEOFF;
	MOVLW       _ForceSSROFFCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSROFFCondition+0)
	MOVWF       R2 
	MOVF        FARG_TempErrorAction_ChannelNum+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVLW       4
	IORWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,178 :: 		}
L_TempErrorAction31:
;Mainprocess.c,179 :: 		}
	GOTO        L_TempErrorAction32
L_TempErrorAction29:
;Mainprocess.c,182 :: 		ForceSSRONCondition[ChannelNum] &= ~FAILUREMODEFORCEON;
	MOVLW       _ForceSSRONCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSRONCondition+0)
	MOVWF       R2 
	MOVF        FARG_TempErrorAction_ChannelNum+0, 0 
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
;Mainprocess.c,183 :: 		ForceSSROFFCondition[ChannelNum] &= ~FAILUREMODEFORCEOFF;
	MOVLW       _ForceSSROFFCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSROFFCondition+0)
	MOVWF       R2 
	MOVF        FARG_TempErrorAction_ChannelNum+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVLW       251
	ANDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,184 :: 		}
L_TempErrorAction32:
;Mainprocess.c,185 :: 		}
L_end_TempErrorAction:
	RETURN      0
; end of _TempErrorAction

_TempStatistics:

;Mainprocess.c,187 :: 		void TempStatistics(char ChannelNum, char HighMode, char LowMode)
;Mainprocess.c,190 :: 		char StaticsChange=0,units;
	CLRF        TempStatistics_StaticsChange_L0+0 
;Mainprocess.c,193 :: 		StaticticsT = &pSPCValue[ChannelNum].SPCActual.TemperatureA+HighMode;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 0 
	MOVWF       TempStatistics_StaticticsT_L0+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       TempStatistics_StaticticsT_L0+1 
	MOVLW       4
	ADDWF       TempStatistics_StaticticsT_L0+0, 1 
	MOVLW       0
	ADDWFC      TempStatistics_StaticticsT_L0+1, 1 
	MOVF        FARG_TempStatistics_HighMode+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       TempStatistics_StaticticsT_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      TempStatistics_StaticticsT_L0+1, 1 
;Mainprocess.c,194 :: 		units = pSPCValue[0].SPCSetPoints.system_valueb.bite.spc_units_c;
	MOVLW       0
	BTFSC       _pSPCValue+138, 0 
	MOVLW       1
	MOVWF       TempStatistics_units_L0+0 
;Mainprocess.c,195 :: 		if(Statis_flag[ChannelNum] & STATIS_MAX_TEMP)
	MOVLW       _Statis_flag+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_Statis_flag+0)
	MOVWF       FSR0H 
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	BTFSS       R1, 0 
	GOTO        L_TempStatistics33
;Mainprocess.c,197 :: 		Statis_flag[ChannelNum] &= ~STATIS_MAX_TEMP;
	MOVLW       _Statis_flag+0
	MOVWF       R1 
	MOVLW       hi_addr(_Statis_flag+0)
	MOVWF       R2 
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVLW       254
	ANDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,199 :: 		pSPCValue[ChannelNum].SPCStatistics.MaximumTemp.Temperature_C
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       24
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
;Mainprocess.c,200 :: 		= StaticticsT->Temperature_C;
	MOVLW       2
	ADDWF       TempStatistics_StaticticsT_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      TempStatistics_StaticticsT_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,201 :: 		pSPCValue[ChannelNum].SPCStatistics.MaximumTemp.Temperature_F
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       24
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
;Mainprocess.c,202 :: 		= StaticticsT->Temperature_F;
	MOVFF       TempStatistics_StaticticsT_L0+0, FSR0
	MOVFF       TempStatistics_StaticticsT_L0+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,204 :: 		SystemUpdate |= (CH1_TEMP_MAX_UPDATE_REQ << ChannelNum);
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	MOVLW       16
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__TempStatistics345:
	BZ          L__TempStatistics346
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__TempStatistics345
L__TempStatistics346:
	MOVF        R0, 0 
	IORWF       _SystemUpdate+0, 1 
	MOVF        R1, 0 
	IORWF       _SystemUpdate+1, 1 
	MOVF        R2, 0 
	IORWF       _SystemUpdate+2, 1 
	MOVF        R3, 0 
	IORWF       _SystemUpdate+3, 1 
;Mainprocess.c,205 :: 		temp_ptr = (signed int *)(&pSPCValue[ChannelNum].SPCStatistics.MaximumTemp) + units;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 0 
	MOVWF       FARG_SetTempStatStr_temp+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_SetTempStatStr_temp+1 
	MOVLW       24
	ADDWF       FARG_SetTempStatStr_temp+0, 1 
	MOVLW       0
	ADDWFC      FARG_SetTempStatStr_temp+1, 1 
	MOVF        TempStatistics_units_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_SetTempStatStr_temp+0, 1 
	MOVF        R1, 0 
	ADDWFC      FARG_SetTempStatStr_temp+1, 1 
;Mainprocess.c,206 :: 		SetTempStatStr(temp_ptr, CH1_ACTURAL_MAX, ChannelNum);
	MOVLW       12
	MOVWF       FARG_SetTempStatStr_strlocat+0 
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	MOVWF       FARG_SetTempStatStr_ChannelNum+0 
	CALL        _SetTempStatStr+0, 0
;Mainprocess.c,207 :: 		StaticsChange = 1;
	MOVLW       1
	MOVWF       TempStatistics_StaticsChange_L0+0 
;Mainprocess.c,208 :: 		}
L_TempStatistics33:
;Mainprocess.c,210 :: 		if(StaticticsT->Temperature_C != RTD_SHORT)
	MOVLW       2
	ADDWF       TempStatistics_StaticticsT_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      TempStatistics_StaticticsT_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__TempStatistics347
	MOVLW       255
	XORWF       R1, 0 
L__TempStatistics347:
	BTFSC       STATUS+0, 2 
	GOTO        L_TempStatistics34
;Mainprocess.c,212 :: 		if((pSPCValue[ChannelNum].SPCStatistics.MaximumTemp.Temperature_C == RTD_SHORT) ||
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       24
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
;Mainprocess.c,213 :: 		(StaticticsT->Temperature_C > pSPCValue[ChannelNum].SPCStatistics.MaximumTemp.Temperature_C))
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__TempStatistics348
	MOVLW       255
	XORWF       R1, 0 
L__TempStatistics348:
	BTFSC       STATUS+0, 2 
	GOTO        L__TempStatistics316
	MOVLW       2
	ADDWF       TempStatistics_StaticticsT_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      TempStatistics_StaticticsT_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__TempStatistics+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__TempStatistics+1 
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       24
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FLOC__TempStatistics+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__TempStatistics349
	MOVF        FLOC__TempStatistics+0, 0 
	SUBWF       R1, 0 
L__TempStatistics349:
	BTFSS       STATUS+0, 0 
	GOTO        L__TempStatistics316
	GOTO        L_TempStatistics37
L__TempStatistics316:
;Mainprocess.c,215 :: 		pSPCValue[ChannelNum].SPCStatistics.MaximumTemp.Temperature_C =
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       24
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
;Mainprocess.c,216 :: 		StaticticsT->Temperature_C;
	MOVLW       2
	ADDWF       TempStatistics_StaticticsT_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      TempStatistics_StaticticsT_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,217 :: 		pSPCValue[ChannelNum].SPCStatistics.MaximumTemp.Temperature_F =
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       24
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
;Mainprocess.c,218 :: 		StaticticsT->Temperature_F;
	MOVFF       TempStatistics_StaticticsT_L0+0, FSR0
	MOVFF       TempStatistics_StaticticsT_L0+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,220 :: 		SystemUpdate |= (CH1_TEMP_MAX_UPDATE_REQ << ChannelNum);
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	MOVLW       16
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__TempStatistics350:
	BZ          L__TempStatistics351
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__TempStatistics350
L__TempStatistics351:
	MOVF        R0, 0 
	IORWF       _SystemUpdate+0, 1 
	MOVF        R1, 0 
	IORWF       _SystemUpdate+1, 1 
	MOVF        R2, 0 
	IORWF       _SystemUpdate+2, 1 
	MOVF        R3, 0 
	IORWF       _SystemUpdate+3, 1 
;Mainprocess.c,221 :: 		temp_ptr = (signed int *)(&pSPCValue[ChannelNum].SPCStatistics.MaximumTemp) + units;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 0 
	MOVWF       FARG_SetTempStatStr_temp+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_SetTempStatStr_temp+1 
	MOVLW       24
	ADDWF       FARG_SetTempStatStr_temp+0, 1 
	MOVLW       0
	ADDWFC      FARG_SetTempStatStr_temp+1, 1 
	MOVF        TempStatistics_units_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_SetTempStatStr_temp+0, 1 
	MOVF        R1, 0 
	ADDWFC      FARG_SetTempStatStr_temp+1, 1 
;Mainprocess.c,222 :: 		SetTempStatStr(temp_ptr, CH1_ACTURAL_MAX, ChannelNum);
	MOVLW       12
	MOVWF       FARG_SetTempStatStr_strlocat+0 
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	MOVWF       FARG_SetTempStatStr_ChannelNum+0 
	CALL        _SetTempStatStr+0, 0
;Mainprocess.c,223 :: 		StaticsChange = 1;
	MOVLW       1
	MOVWF       TempStatistics_StaticsChange_L0+0 
;Mainprocess.c,224 :: 		}
L_TempStatistics37:
;Mainprocess.c,225 :: 		}
L_TempStatistics34:
;Mainprocess.c,227 :: 		StaticticsT = &pSPCValue[ChannelNum].SPCActual.TemperatureA+LowMode;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 0 
	MOVWF       TempStatistics_StaticticsT_L0+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       TempStatistics_StaticticsT_L0+1 
	MOVLW       4
	ADDWF       TempStatistics_StaticticsT_L0+0, 1 
	MOVLW       0
	ADDWFC      TempStatistics_StaticticsT_L0+1, 1 
	MOVF        FARG_TempStatistics_LowMode+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       TempStatistics_StaticticsT_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      TempStatistics_StaticticsT_L0+1, 1 
;Mainprocess.c,228 :: 		if(Statis_flag[ChannelNum] & STATIS_MIN_TEMP)
	MOVLW       _Statis_flag+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_Statis_flag+0)
	MOVWF       FSR0H 
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	BTFSS       R1, 1 
	GOTO        L_TempStatistics38
;Mainprocess.c,230 :: 		Statis_flag[ChannelNum] &= ~STATIS_MIN_TEMP;
	MOVLW       _Statis_flag+0
	MOVWF       R1 
	MOVLW       hi_addr(_Statis_flag+0)
	MOVWF       R2 
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVLW       253
	ANDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,232 :: 		pSPCValue[ChannelNum].SPCStatistics.MinimumTemp.Temperature_C
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       24
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       4
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
;Mainprocess.c,233 :: 		= StaticticsT->Temperature_C;
	MOVLW       2
	ADDWF       TempStatistics_StaticticsT_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      TempStatistics_StaticticsT_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,234 :: 		pSPCValue[ChannelNum].SPCStatistics.MinimumTemp.Temperature_F
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       24
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       4
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
;Mainprocess.c,235 :: 		= StaticticsT->Temperature_F;
	MOVFF       TempStatistics_StaticticsT_L0+0, FSR0
	MOVFF       TempStatistics_StaticticsT_L0+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,237 :: 		SystemUpdate |= (CH1_TEMP_MIN_UPDATE_REQ << ChannelNum);
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	MOVLW       64
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__TempStatistics352:
	BZ          L__TempStatistics353
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__TempStatistics352
L__TempStatistics353:
	MOVF        R0, 0 
	IORWF       _SystemUpdate+0, 1 
	MOVF        R1, 0 
	IORWF       _SystemUpdate+1, 1 
	MOVF        R2, 0 
	IORWF       _SystemUpdate+2, 1 
	MOVF        R3, 0 
	IORWF       _SystemUpdate+3, 1 
;Mainprocess.c,238 :: 		temp_ptr = (signed int *)(&pSPCValue[ChannelNum].SPCStatistics.MinimumTemp) + units;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 0 
	MOVWF       FARG_SetTempStatStr_temp+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_SetTempStatStr_temp+1 
	MOVLW       24
	ADDWF       FARG_SetTempStatStr_temp+0, 1 
	MOVLW       0
	ADDWFC      FARG_SetTempStatStr_temp+1, 1 
	MOVLW       4
	ADDWF       FARG_SetTempStatStr_temp+0, 1 
	MOVLW       0
	ADDWFC      FARG_SetTempStatStr_temp+1, 1 
	MOVF        TempStatistics_units_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_SetTempStatStr_temp+0, 1 
	MOVF        R1, 0 
	ADDWFC      FARG_SetTempStatStr_temp+1, 1 
;Mainprocess.c,239 :: 		SetTempStatStr(temp_ptr,CH1_ACTURAL_MIN, ChannelNum);
	MOVLW       14
	MOVWF       FARG_SetTempStatStr_strlocat+0 
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	MOVWF       FARG_SetTempStatStr_ChannelNum+0 
	CALL        _SetTempStatStr+0, 0
;Mainprocess.c,240 :: 		StaticsChange = 1;
	MOVLW       1
	MOVWF       TempStatistics_StaticsChange_L0+0 
;Mainprocess.c,241 :: 		}
L_TempStatistics38:
;Mainprocess.c,243 :: 		if(StaticticsT->Temperature_C != RTD_OPNE)
	MOVLW       2
	ADDWF       TempStatistics_StaticticsT_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      TempStatistics_StaticticsT_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__TempStatistics354
	MOVLW       253
	XORWF       R1, 0 
L__TempStatistics354:
	BTFSC       STATUS+0, 2 
	GOTO        L_TempStatistics39
;Mainprocess.c,245 :: 		if(StaticticsT->Temperature_C == RTD_SHORT)
	MOVLW       2
	ADDWF       TempStatistics_StaticticsT_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      TempStatistics_StaticticsT_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__TempStatistics355
	MOVLW       255
	XORWF       R1, 0 
L__TempStatistics355:
	BTFSS       STATUS+0, 2 
	GOTO        L_TempStatistics40
;Mainprocess.c,247 :: 		if(pSPCValue[ChannelNum].SPCStatistics.MinimumTemp.Temperature_C != RTD_SHORT)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       24
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       4
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__TempStatistics356
	MOVLW       255
	XORWF       R1, 0 
L__TempStatistics356:
	BTFSC       STATUS+0, 2 
	GOTO        L_TempStatistics41
;Mainprocess.c,249 :: 		pSPCValue[ChannelNum].SPCStatistics.MinimumTemp.Temperature_C = RTD_SHORT;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       24
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       4
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       255
	MOVWF       POSTINC1+0 
	MOVLW       127
	MOVWF       POSTINC1+0 
;Mainprocess.c,250 :: 		pSPCValue[ChannelNum].SPCStatistics.MinimumTemp.Temperature_F = RTD_SHORT;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       24
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       4
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       255
	MOVWF       POSTINC1+0 
	MOVLW       127
	MOVWF       POSTINC1+0 
;Mainprocess.c,251 :: 		SystemUpdate |= (CH1_TEMP_MIN_UPDATE_REQ << ChannelNum);
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	MOVLW       64
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__TempStatistics357:
	BZ          L__TempStatistics358
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__TempStatistics357
L__TempStatistics358:
	MOVF        R0, 0 
	IORWF       _SystemUpdate+0, 1 
	MOVF        R1, 0 
	IORWF       _SystemUpdate+1, 1 
	MOVF        R2, 0 
	IORWF       _SystemUpdate+2, 1 
	MOVF        R3, 0 
	IORWF       _SystemUpdate+3, 1 
;Mainprocess.c,252 :: 		temp_ptr = (signed int *)(&pSPCValue[ChannelNum].SPCStatistics.MinimumTemp) + units;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 0 
	MOVWF       FARG_SetTempStatStr_temp+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_SetTempStatStr_temp+1 
	MOVLW       24
	ADDWF       FARG_SetTempStatStr_temp+0, 1 
	MOVLW       0
	ADDWFC      FARG_SetTempStatStr_temp+1, 1 
	MOVLW       4
	ADDWF       FARG_SetTempStatStr_temp+0, 1 
	MOVLW       0
	ADDWFC      FARG_SetTempStatStr_temp+1, 1 
	MOVF        TempStatistics_units_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_SetTempStatStr_temp+0, 1 
	MOVF        R1, 0 
	ADDWFC      FARG_SetTempStatStr_temp+1, 1 
;Mainprocess.c,253 :: 		SetTempStatStr(temp_ptr,CH1_ACTURAL_MIN, ChannelNum);
	MOVLW       14
	MOVWF       FARG_SetTempStatStr_strlocat+0 
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	MOVWF       FARG_SetTempStatStr_ChannelNum+0 
	CALL        _SetTempStatStr+0, 0
;Mainprocess.c,254 :: 		StaticsChange = 1;
	MOVLW       1
	MOVWF       TempStatistics_StaticsChange_L0+0 
;Mainprocess.c,255 :: 		}
L_TempStatistics41:
;Mainprocess.c,256 :: 		}
	GOTO        L_TempStatistics42
L_TempStatistics40:
;Mainprocess.c,259 :: 		if((pSPCValue[ChannelNum].SPCStatistics.MinimumTemp.Temperature_C != RTD_SHORT) &&
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       24
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       4
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
;Mainprocess.c,260 :: 		(StaticticsT->Temperature_C < pSPCValue[ChannelNum].SPCStatistics.MinimumTemp.Temperature_C))
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__TempStatistics359
	MOVLW       255
	XORWF       R1, 0 
L__TempStatistics359:
	BTFSC       STATUS+0, 2 
	GOTO        L_TempStatistics45
	MOVLW       2
	ADDWF       TempStatistics_StaticticsT_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      TempStatistics_StaticticsT_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__TempStatistics+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__TempStatistics+1 
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       24
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       4
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       FLOC__TempStatistics+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__TempStatistics360
	MOVF        R1, 0 
	SUBWF       FLOC__TempStatistics+0, 0 
L__TempStatistics360:
	BTFSC       STATUS+0, 0 
	GOTO        L_TempStatistics45
L__TempStatistics315:
;Mainprocess.c,262 :: 		pSPCValue[ChannelNum].SPCStatistics.MinimumTemp.Temperature_C = StaticticsT->Temperature_C;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       24
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       4
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       2
	ADDWF       TempStatistics_StaticticsT_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      TempStatistics_StaticticsT_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,263 :: 		pSPCValue[ChannelNum].SPCStatistics.MinimumTemp.Temperature_F = StaticticsT->Temperature_F;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       24
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       4
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVFF       TempStatistics_StaticticsT_L0+0, FSR0
	MOVFF       TempStatistics_StaticticsT_L0+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,264 :: 		SystemUpdate |= (CH1_TEMP_MIN_UPDATE_REQ << ChannelNum);
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	MOVLW       64
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__TempStatistics361:
	BZ          L__TempStatistics362
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__TempStatistics361
L__TempStatistics362:
	MOVF        R0, 0 
	IORWF       _SystemUpdate+0, 1 
	MOVF        R1, 0 
	IORWF       _SystemUpdate+1, 1 
	MOVF        R2, 0 
	IORWF       _SystemUpdate+2, 1 
	MOVF        R3, 0 
	IORWF       _SystemUpdate+3, 1 
;Mainprocess.c,265 :: 		temp_ptr = (signed int *)(&pSPCValue[ChannelNum].SPCStatistics.MinimumTemp) + units;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 0 
	MOVWF       FARG_SetTempStatStr_temp+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_SetTempStatStr_temp+1 
	MOVLW       24
	ADDWF       FARG_SetTempStatStr_temp+0, 1 
	MOVLW       0
	ADDWFC      FARG_SetTempStatStr_temp+1, 1 
	MOVLW       4
	ADDWF       FARG_SetTempStatStr_temp+0, 1 
	MOVLW       0
	ADDWFC      FARG_SetTempStatStr_temp+1, 1 
	MOVF        TempStatistics_units_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_SetTempStatStr_temp+0, 1 
	MOVF        R1, 0 
	ADDWFC      FARG_SetTempStatStr_temp+1, 1 
;Mainprocess.c,266 :: 		SetTempStatStr(temp_ptr,CH1_ACTURAL_MIN, ChannelNum);
	MOVLW       14
	MOVWF       FARG_SetTempStatStr_strlocat+0 
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	MOVWF       FARG_SetTempStatStr_ChannelNum+0 
	CALL        _SetTempStatStr+0, 0
;Mainprocess.c,267 :: 		StaticsChange = 1;
	MOVLW       1
	MOVWF       TempStatistics_StaticsChange_L0+0 
;Mainprocess.c,268 :: 		}
L_TempStatistics45:
;Mainprocess.c,269 :: 		}
L_TempStatistics42:
;Mainprocess.c,270 :: 		}
L_TempStatistics39:
;Mainprocess.c,272 :: 		if(StaticsChange)
	MOVF        TempStatistics_StaticsChange_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_TempStatistics46
;Mainprocess.c,273 :: 		EEPROM_set(0x01+2*sizeof(SPCSETPIONTS)+ChannelNum*sizeof(STATISTICS),sizeof(STATISTICS),(UCHAR*)(&pSPCValue[ChannelNum].SPCStatistics));
	MOVLW       30
	MULWF       FARG_TempStatistics_ChannelNum+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVLW       177
	ADDWF       R0, 0 
	MOVWF       FARG_EEPROM_set_EEPROM_WRITE_ADDRESS+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FARG_EEPROM_set_EEPROM_WRITE_ADDRESS+1 
	MOVLW       30
	MOVWF       FARG_EEPROM_set_Len+0 
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_TempStatistics_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 0 
	MOVWF       FARG_EEPROM_set_writebuffer+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_EEPROM_set_writebuffer+1 
	MOVLW       24
	ADDWF       FARG_EEPROM_set_writebuffer+0, 1 
	MOVLW       0
	ADDWFC      FARG_EEPROM_set_writebuffer+1, 1 
	CALL        _EEPROM_set+0, 0
L_TempStatistics46:
;Mainprocess.c,274 :: 		}
L_end_TempStatistics:
	RETURN      0
; end of _TempStatistics

_Tempprocess:

;Mainprocess.c,276 :: 		char Tempprocess(char ChannelNum)
;Mainprocess.c,278 :: 		char duty_val, units, RTD_stat=RTD_OK;
	CLRF        Tempprocess_RTD_stat_L0+0 
;Mainprocess.c,284 :: 		dispmodetemp = pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.rtd_opr;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
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
	MOVLW       112
	ANDWF       R0, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	MOVF        R1, 0 
	MOVWF       Tempprocess_dispmodetemp_L0+0 
;Mainprocess.c,287 :: 		if(ADC_busy[ChannelNum] == GETING_GFI_CURRENT)
	MOVLW       _ADC_busy+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_ADC_busy+0)
	MOVWF       FSR0H 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Tempprocess47
;Mainprocess.c,289 :: 		ADC_busy[ChannelNum] = GETING_TEMP_REQ;
	MOVLW       _ADC_busy+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_ADC_busy+0)
	MOVWF       FSR1H 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       3
	MOVWF       POSTINC1+0 
;Mainprocess.c,290 :: 		return 0;
	CLRF        R0 
	GOTO        L_end_Tempprocess
;Mainprocess.c,291 :: 		}
L_Tempprocess47:
;Mainprocess.c,293 :: 		ADC_busy[ChannelNum] = GETING_TEMP;
	MOVLW       _ADC_busy+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_ADC_busy+0)
	MOVWF       FSR1H 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       1
	MOVWF       POSTINC1+0 
;Mainprocess.c,295 :: 		units = pSPCValue[0].SPCSetPoints.system_valueb.bite.spc_units_c;
	MOVLW       0
	BTFSC       _pSPCValue+138, 0 
	MOVLW       1
	MOVWF       Tempprocess_units_L0+0 
;Mainprocess.c,296 :: 		tempa_ptr = (signed int *)(&pSPCValue[ChannelNum].SPCActual.TemperatureA) + units;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 0 
	MOVWF       R5 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       R6 
	MOVLW       4
	ADDWF       R5, 0 
	MOVWF       R3 
	MOVLW       0
	ADDWFC      R6, 0 
	MOVWF       R4 
	MOVF        Tempprocess_units_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       R3, 0 
	MOVWF       Tempprocess_tempa_ptr_L0+0 
	MOVF        R1, 0 
	ADDWFC      R4, 0 
	MOVWF       Tempprocess_tempa_ptr_L0+1 
;Mainprocess.c,297 :: 		tempb_ptr = (signed int *)(&pSPCValue[ChannelNum].SPCActual.TemperatureB) + units;
	MOVLW       8
	ADDWF       R5, 0 
	MOVWF       Tempprocess_tempb_ptr_L0+0 
	MOVLW       0
	ADDWFC      R6, 0 
	MOVWF       Tempprocess_tempb_ptr_L0+1 
	MOVF        R0, 0 
	ADDWF       Tempprocess_tempb_ptr_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      Tempprocess_tempb_ptr_L0+1, 1 
;Mainprocess.c,298 :: 		temp_ptr = (signed int *)(&pSPCValue[ChannelNum].SPCActual.Temperature) + units;
	MOVF        R0, 0 
	ADDWF       R5, 0 
	MOVWF       Tempprocess_temp_ptr_L0+0 
	MOVF        R1, 0 
	ADDWFC      R6, 0 
	MOVWF       Tempprocess_temp_ptr_L0+1 
;Mainprocess.c,300 :: 		spc_system_flag.bite.temp_err = 0;
	BCF         _spc_system_flag+2, 2 
;Mainprocess.c,302 :: 		GetTemperature(&pSPCValue[ChannelNum].SPCActual.TemperatureA, ChannelNum);
	MOVF        R3, 0 
	MOVWF       FARG_GetTemperature_RTDA_ptr+0 
	MOVF        R4, 0 
	MOVWF       FARG_GetTemperature_RTDA_ptr+1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       FARG_GetTemperature_ChannelNum+0 
	CALL        _GetTemperature+0, 0
;Mainprocess.c,304 :: 		if(dispmodetemp == ONE_RTD_MOD)
	MOVF        Tempprocess_dispmodetemp_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Tempprocess49
;Mainprocess.c,306 :: 		if(ActivedAlarms & (CH1_RTDBOPENALARM << ChannelNum))
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       64
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Tempprocess364:
	BZ          L__Tempprocess365
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Tempprocess364
L__Tempprocess365:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_Tempprocess50
;Mainprocess.c,307 :: 		alarmoperate(CH1_RTDBOPENALARM << ChannelNum,DISALARM);
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       64
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Tempprocess366:
	BZ          L__Tempprocess367
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Tempprocess366
L__Tempprocess367:
	CLRF        FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Tempprocess50:
;Mainprocess.c,308 :: 		if(ActivedAlarms & (CH1_RTDBSHORTALARM << ChannelNum))
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       1
	MOVWF       R3 
	MOVF        R4, 0 
L__Tempprocess368:
	BZ          L__Tempprocess369
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Tempprocess368
L__Tempprocess369:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_Tempprocess51
;Mainprocess.c,309 :: 		alarmoperate(CH1_RTDBSHORTALARM << ChannelNum,DISALARM);
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       1
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Tempprocess370:
	BZ          L__Tempprocess371
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Tempprocess370
L__Tempprocess371:
	CLRF        FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Tempprocess51:
;Mainprocess.c,310 :: 		}
	GOTO        L_Tempprocess52
L_Tempprocess49:
;Mainprocess.c,313 :: 		if(*tempb_ptr == RTD_SHORT)
	MOVFF       Tempprocess_tempb_ptr_L0+0, FSR0
	MOVFF       Tempprocess_tempb_ptr_L0+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__Tempprocess372
	MOVLW       255
	XORWF       R1, 0 
L__Tempprocess372:
	BTFSS       STATUS+0, 2 
	GOTO        L_Tempprocess53
;Mainprocess.c,315 :: 		RTD_stat |= RTDB_ERR;
	BSF         Tempprocess_RTD_stat_L0+0, 1 
;Mainprocess.c,316 :: 		if(ActivedAlarms & (CH1_RTDBOPENALARM << ChannelNum))
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       64
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Tempprocess373:
	BZ          L__Tempprocess374
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Tempprocess373
L__Tempprocess374:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_Tempprocess54
;Mainprocess.c,317 :: 		alarmoperate(CH1_RTDBOPENALARM << ChannelNum,DISALARM);
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       64
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Tempprocess375:
	BZ          L__Tempprocess376
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Tempprocess375
L__Tempprocess376:
	CLRF        FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Tempprocess54:
;Mainprocess.c,318 :: 		if(!(ActivedAlarms & (CH1_RTDBSHORTALARM << ChannelNum)))
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       1
	MOVWF       R3 
	MOVF        R4, 0 
L__Tempprocess377:
	BZ          L__Tempprocess378
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Tempprocess377
L__Tempprocess378:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_Tempprocess55
;Mainprocess.c,319 :: 		alarmoperate(CH1_RTDBSHORTALARM << ChannelNum,ENALARM);
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       1
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Tempprocess379:
	BZ          L__Tempprocess380
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Tempprocess379
L__Tempprocess380:
	MOVLW       1
	MOVWF       FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Tempprocess55:
;Mainprocess.c,320 :: 		}
	GOTO        L_Tempprocess56
L_Tempprocess53:
;Mainprocess.c,321 :: 		else if(*tempb_ptr == RTD_OPNE)
	MOVFF       Tempprocess_tempb_ptr_L0+0, FSR0
	MOVFF       Tempprocess_tempb_ptr_L0+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__Tempprocess381
	MOVLW       253
	XORWF       R1, 0 
L__Tempprocess381:
	BTFSS       STATUS+0, 2 
	GOTO        L_Tempprocess57
;Mainprocess.c,323 :: 		RTD_stat |= RTDB_ERR;
	BSF         Tempprocess_RTD_stat_L0+0, 1 
;Mainprocess.c,324 :: 		if(ActivedAlarms & (CH1_RTDBSHORTALARM << ChannelNum))
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       1
	MOVWF       R3 
	MOVF        R4, 0 
L__Tempprocess382:
	BZ          L__Tempprocess383
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Tempprocess382
L__Tempprocess383:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_Tempprocess58
;Mainprocess.c,325 :: 		alarmoperate(CH1_RTDBSHORTALARM << ChannelNum,DISALARM);
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       1
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Tempprocess384:
	BZ          L__Tempprocess385
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Tempprocess384
L__Tempprocess385:
	CLRF        FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Tempprocess58:
;Mainprocess.c,326 :: 		if(!(ActivedAlarms & (CH1_RTDBOPENALARM << ChannelNum)))
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       64
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Tempprocess386:
	BZ          L__Tempprocess387
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Tempprocess386
L__Tempprocess387:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_Tempprocess59
;Mainprocess.c,327 :: 		alarmoperate(CH1_RTDBOPENALARM << ChannelNum,ENALARM);
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       64
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Tempprocess388:
	BZ          L__Tempprocess389
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Tempprocess388
L__Tempprocess389:
	MOVLW       1
	MOVWF       FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Tempprocess59:
;Mainprocess.c,328 :: 		}
	GOTO        L_Tempprocess60
L_Tempprocess57:
;Mainprocess.c,331 :: 		if(ActivedAlarms & (CH1_RTDBOPENALARM << ChannelNum))
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       64
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Tempprocess390:
	BZ          L__Tempprocess391
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Tempprocess390
L__Tempprocess391:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_Tempprocess61
;Mainprocess.c,332 :: 		alarmoperate(CH1_RTDBOPENALARM << ChannelNum,DISALARM);
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       64
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Tempprocess392:
	BZ          L__Tempprocess393
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Tempprocess392
L__Tempprocess393:
	CLRF        FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Tempprocess61:
;Mainprocess.c,333 :: 		if(ActivedAlarms & (CH1_RTDBSHORTALARM << ChannelNum))
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       1
	MOVWF       R3 
	MOVF        R4, 0 
L__Tempprocess394:
	BZ          L__Tempprocess395
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Tempprocess394
L__Tempprocess395:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_Tempprocess62
;Mainprocess.c,334 :: 		alarmoperate(CH1_RTDBSHORTALARM << ChannelNum,DISALARM);
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       1
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Tempprocess396:
	BZ          L__Tempprocess397
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Tempprocess396
L__Tempprocess397:
	CLRF        FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Tempprocess62:
;Mainprocess.c,335 :: 		}
L_Tempprocess60:
L_Tempprocess56:
;Mainprocess.c,336 :: 		}
L_Tempprocess52:
;Mainprocess.c,337 :: 		if(*tempa_ptr == RTD_SHORT)
	MOVFF       Tempprocess_tempa_ptr_L0+0, FSR0
	MOVFF       Tempprocess_tempa_ptr_L0+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__Tempprocess398
	MOVLW       255
	XORWF       R1, 0 
L__Tempprocess398:
	BTFSS       STATUS+0, 2 
	GOTO        L_Tempprocess63
;Mainprocess.c,339 :: 		RTD_stat |= RTDA_ERR;
	BSF         Tempprocess_RTD_stat_L0+0, 0 
;Mainprocess.c,340 :: 		if(!(ActivedAlarms & (CH1_RTDASHORTALARM << ChannelNum)))
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       16
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Tempprocess399:
	BZ          L__Tempprocess400
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Tempprocess399
L__Tempprocess400:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_Tempprocess64
;Mainprocess.c,341 :: 		alarmoperate(CH1_RTDASHORTALARM << ChannelNum,ENALARM);
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       16
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Tempprocess401:
	BZ          L__Tempprocess402
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Tempprocess401
L__Tempprocess402:
	MOVLW       1
	MOVWF       FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Tempprocess64:
;Mainprocess.c,342 :: 		if(ActivedAlarms & (CH1_RTDAOPENALARM << ChannelNum))
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       4
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Tempprocess403:
	BZ          L__Tempprocess404
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Tempprocess403
L__Tempprocess404:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_Tempprocess65
;Mainprocess.c,343 :: 		alarmoperate(CH1_RTDAOPENALARM << ChannelNum,DISALARM);
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       4
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Tempprocess405:
	BZ          L__Tempprocess406
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Tempprocess405
L__Tempprocess406:
	CLRF        FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Tempprocess65:
;Mainprocess.c,344 :: 		}
	GOTO        L_Tempprocess66
L_Tempprocess63:
;Mainprocess.c,345 :: 		else if(*tempa_ptr == RTD_OPNE)
	MOVFF       Tempprocess_tempa_ptr_L0+0, FSR0
	MOVFF       Tempprocess_tempa_ptr_L0+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__Tempprocess407
	MOVLW       253
	XORWF       R1, 0 
L__Tempprocess407:
	BTFSS       STATUS+0, 2 
	GOTO        L_Tempprocess67
;Mainprocess.c,347 :: 		RTD_stat |= RTDA_ERR;
	BSF         Tempprocess_RTD_stat_L0+0, 0 
;Mainprocess.c,348 :: 		if(!(ActivedAlarms & (CH1_RTDAOPENALARM << ChannelNum)))
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       4
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Tempprocess408:
	BZ          L__Tempprocess409
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Tempprocess408
L__Tempprocess409:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_Tempprocess68
;Mainprocess.c,349 :: 		alarmoperate(CH1_RTDAOPENALARM << ChannelNum,ENALARM);
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       4
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Tempprocess410:
	BZ          L__Tempprocess411
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Tempprocess410
L__Tempprocess411:
	MOVLW       1
	MOVWF       FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Tempprocess68:
;Mainprocess.c,350 :: 		if(ActivedAlarms & (CH1_RTDASHORTALARM << ChannelNum))
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       16
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Tempprocess412:
	BZ          L__Tempprocess413
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Tempprocess412
L__Tempprocess413:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_Tempprocess69
;Mainprocess.c,351 :: 		alarmoperate(CH1_RTDASHORTALARM << ChannelNum,DISALARM);
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       16
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Tempprocess414:
	BZ          L__Tempprocess415
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Tempprocess414
L__Tempprocess415:
	CLRF        FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Tempprocess69:
;Mainprocess.c,352 :: 		}
	GOTO        L_Tempprocess70
L_Tempprocess67:
;Mainprocess.c,355 :: 		if(ActivedAlarms & (CH1_RTDAOPENALARM << ChannelNum))
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       4
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Tempprocess416:
	BZ          L__Tempprocess417
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Tempprocess416
L__Tempprocess417:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_Tempprocess71
;Mainprocess.c,356 :: 		alarmoperate(CH1_RTDAOPENALARM << ChannelNum,DISALARM);
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       4
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Tempprocess418:
	BZ          L__Tempprocess419
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Tempprocess418
L__Tempprocess419:
	CLRF        FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Tempprocess71:
;Mainprocess.c,357 :: 		if(ActivedAlarms & (CH1_RTDASHORTALARM << ChannelNum))
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       16
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Tempprocess420:
	BZ          L__Tempprocess421
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Tempprocess420
L__Tempprocess421:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_Tempprocess72
;Mainprocess.c,358 :: 		alarmoperate(CH1_RTDASHORTALARM << ChannelNum,DISALARM);
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       16
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Tempprocess422:
	BZ          L__Tempprocess423
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Tempprocess422
L__Tempprocess423:
	CLRF        FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Tempprocess72:
;Mainprocess.c,359 :: 		}
L_Tempprocess70:
L_Tempprocess66:
;Mainprocess.c,361 :: 		if(RTD_stat & RTDA_ERR)
	BTFSS       Tempprocess_RTD_stat_L0+0, 0 
	GOTO        L_Tempprocess73
;Mainprocess.c,363 :: 		if((RTD_stat & RTDB_ERR) || (pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.rtd_opr == ONE_RTD_MOD))
	BTFSC       Tempprocess_RTD_stat_L0+0, 1 
	GOTO        L__Tempprocess322
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
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
	MOVLW       112
	ANDWF       R0, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	MOVF        R1, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__Tempprocess322
	GOTO        L_Tempprocess76
L__Tempprocess322:
;Mainprocess.c,365 :: 		RTD_stat |= RTDS_ERR;
	BSF         Tempprocess_RTD_stat_L0+0, 2 
;Mainprocess.c,366 :: 		spc_system_flag.bite.temp_err = 1;
	BSF         _spc_system_flag+2, 2 
;Mainprocess.c,367 :: 		}
L_Tempprocess76:
;Mainprocess.c,368 :: 		}
L_Tempprocess73:
;Mainprocess.c,370 :: 		if(pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.rtd_opr == ONE_RTD_MOD)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
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
	MOVLW       112
	ANDWF       R0, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Tempprocess77
;Mainprocess.c,372 :: 		StatisticsTempHigh = STATICTEMPHIGHA;
	CLRF        Tempprocess_StatisticsTempHigh_L0+0 
	CLRF        Tempprocess_StatisticsTempHigh_L0+1 
;Mainprocess.c,373 :: 		StatisticsTempLow = STATICTEMPLOWA;
	CLRF        Tempprocess_StatisticsTempLow_L0+0 
	CLRF        Tempprocess_StatisticsTempLow_L0+1 
;Mainprocess.c,374 :: 		}
	GOTO        L_Tempprocess78
L_Tempprocess77:
;Mainprocess.c,377 :: 		if((*tempa_ptr == RTD_SHORT) || (*tempb_ptr == RTD_SHORT))
	MOVFF       Tempprocess_tempa_ptr_L0+0, FSR0
	MOVFF       Tempprocess_tempa_ptr_L0+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__Tempprocess424
	MOVLW       255
	XORWF       R1, 0 
L__Tempprocess424:
	BTFSC       STATUS+0, 2 
	GOTO        L__Tempprocess321
	MOVFF       Tempprocess_tempb_ptr_L0+0, FSR0
	MOVFF       Tempprocess_tempb_ptr_L0+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__Tempprocess425
	MOVLW       255
	XORWF       R1, 0 
L__Tempprocess425:
	BTFSC       STATUS+0, 2 
	GOTO        L__Tempprocess321
	GOTO        L_Tempprocess81
L__Tempprocess321:
;Mainprocess.c,379 :: 		StatisticsTempLow = STATICTEMPLOWA;
	CLRF        Tempprocess_StatisticsTempLow_L0+0 
	CLRF        Tempprocess_StatisticsTempLow_L0+1 
;Mainprocess.c,380 :: 		}
	GOTO        L_Tempprocess82
L_Tempprocess81:
;Mainprocess.c,383 :: 		if(*tempa_ptr > *tempb_ptr)
	MOVFF       Tempprocess_tempa_ptr_L0+0, FSR0
	MOVFF       Tempprocess_tempa_ptr_L0+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVFF       Tempprocess_tempb_ptr_L0+0, FSR0
	MOVFF       Tempprocess_tempb_ptr_L0+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R4, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Tempprocess426
	MOVF        R3, 0 
	SUBWF       R1, 0 
L__Tempprocess426:
	BTFSC       STATUS+0, 0 
	GOTO        L_Tempprocess83
;Mainprocess.c,384 :: 		StatisticsTempLow = STATICTEMPLOWB;
	MOVLW       1
	MOVWF       Tempprocess_StatisticsTempLow_L0+0 
	MOVLW       0
	MOVWF       Tempprocess_StatisticsTempLow_L0+1 
	GOTO        L_Tempprocess84
L_Tempprocess83:
;Mainprocess.c,386 :: 		StatisticsTempLow = STATICTEMPLOWA;
	CLRF        Tempprocess_StatisticsTempLow_L0+0 
	CLRF        Tempprocess_StatisticsTempLow_L0+1 
L_Tempprocess84:
;Mainprocess.c,387 :: 		}
L_Tempprocess82:
;Mainprocess.c,389 :: 		if((*tempa_ptr == RTD_OPNE) || (*tempb_ptr == RTD_OPNE))
	MOVFF       Tempprocess_tempa_ptr_L0+0, FSR0
	MOVFF       Tempprocess_tempa_ptr_L0+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__Tempprocess427
	MOVLW       253
	XORWF       R1, 0 
L__Tempprocess427:
	BTFSC       STATUS+0, 2 
	GOTO        L__Tempprocess320
	MOVFF       Tempprocess_tempb_ptr_L0+0, FSR0
	MOVFF       Tempprocess_tempb_ptr_L0+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__Tempprocess428
	MOVLW       253
	XORWF       R1, 0 
L__Tempprocess428:
	BTFSC       STATUS+0, 2 
	GOTO        L__Tempprocess320
	GOTO        L_Tempprocess87
L__Tempprocess320:
;Mainprocess.c,391 :: 		StatisticsTempHigh = STATICTEMPHIGHA;
	CLRF        Tempprocess_StatisticsTempHigh_L0+0 
	CLRF        Tempprocess_StatisticsTempHigh_L0+1 
;Mainprocess.c,392 :: 		}
	GOTO        L_Tempprocess88
L_Tempprocess87:
;Mainprocess.c,395 :: 		if(*tempa_ptr == RTD_SHORT)
	MOVFF       Tempprocess_tempa_ptr_L0+0, FSR0
	MOVFF       Tempprocess_tempa_ptr_L0+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__Tempprocess429
	MOVLW       255
	XORWF       R1, 0 
L__Tempprocess429:
	BTFSS       STATUS+0, 2 
	GOTO        L_Tempprocess89
;Mainprocess.c,397 :: 		if(*tempb_ptr == RTD_SHORT)
	MOVFF       Tempprocess_tempb_ptr_L0+0, FSR0
	MOVFF       Tempprocess_tempb_ptr_L0+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__Tempprocess430
	MOVLW       255
	XORWF       R1, 0 
L__Tempprocess430:
	BTFSS       STATUS+0, 2 
	GOTO        L_Tempprocess90
;Mainprocess.c,398 :: 		StatisticsTempHigh = STATICTEMPHIGHA;
	CLRF        Tempprocess_StatisticsTempHigh_L0+0 
	CLRF        Tempprocess_StatisticsTempHigh_L0+1 
	GOTO        L_Tempprocess91
L_Tempprocess90:
;Mainprocess.c,400 :: 		StatisticsTempHigh = STATICTEMPHIGHB;
	MOVLW       1
	MOVWF       Tempprocess_StatisticsTempHigh_L0+0 
	MOVLW       0
	MOVWF       Tempprocess_StatisticsTempHigh_L0+1 
L_Tempprocess91:
;Mainprocess.c,401 :: 		}
	GOTO        L_Tempprocess92
L_Tempprocess89:
;Mainprocess.c,404 :: 		if(*tempb_ptr == RTD_SHORT)
	MOVFF       Tempprocess_tempb_ptr_L0+0, FSR0
	MOVFF       Tempprocess_tempb_ptr_L0+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__Tempprocess431
	MOVLW       255
	XORWF       R1, 0 
L__Tempprocess431:
	BTFSS       STATUS+0, 2 
	GOTO        L_Tempprocess93
;Mainprocess.c,405 :: 		StatisticsTempHigh = STATICTEMPHIGHA;
	CLRF        Tempprocess_StatisticsTempHigh_L0+0 
	CLRF        Tempprocess_StatisticsTempHigh_L0+1 
	GOTO        L_Tempprocess94
L_Tempprocess93:
;Mainprocess.c,408 :: 		if(*tempa_ptr > *tempb_ptr)
	MOVFF       Tempprocess_tempa_ptr_L0+0, FSR0
	MOVFF       Tempprocess_tempa_ptr_L0+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVFF       Tempprocess_tempb_ptr_L0+0, FSR0
	MOVFF       Tempprocess_tempb_ptr_L0+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R4, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Tempprocess432
	MOVF        R3, 0 
	SUBWF       R1, 0 
L__Tempprocess432:
	BTFSC       STATUS+0, 0 
	GOTO        L_Tempprocess95
;Mainprocess.c,409 :: 		StatisticsTempHigh = STATICTEMPHIGHA;
	CLRF        Tempprocess_StatisticsTempHigh_L0+0 
	CLRF        Tempprocess_StatisticsTempHigh_L0+1 
	GOTO        L_Tempprocess96
L_Tempprocess95:
;Mainprocess.c,411 :: 		StatisticsTempHigh = STATICTEMPHIGHB;
	MOVLW       1
	MOVWF       Tempprocess_StatisticsTempHigh_L0+0 
	MOVLW       0
	MOVWF       Tempprocess_StatisticsTempHigh_L0+1 
L_Tempprocess96:
;Mainprocess.c,412 :: 		}
L_Tempprocess94:
;Mainprocess.c,413 :: 		}
L_Tempprocess92:
;Mainprocess.c,414 :: 		}
L_Tempprocess88:
;Mainprocess.c,415 :: 		}
L_Tempprocess78:
;Mainprocess.c,417 :: 		TempStatistics(ChannelNum, StatisticsTempHigh, StatisticsTempLow);
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       FARG_TempStatistics_ChannelNum+0 
	MOVF        Tempprocess_StatisticsTempHigh_L0+0, 0 
	MOVWF       FARG_TempStatistics_HighMode+0 
	MOVF        Tempprocess_StatisticsTempLow_L0+0, 0 
	MOVWF       FARG_TempStatistics_LowMode+0 
	CALL        _TempStatistics+0, 0
;Mainprocess.c,419 :: 		if(spc_system_flag.bite.temp_err)
	BTFSS       _spc_system_flag+2, 2 
	GOTO        L_Tempprocess97
;Mainprocess.c,421 :: 		TempErrorAction(ChannelNum, 1);
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       FARG_TempErrorAction_ChannelNum+0 
	MOVLW       1
	MOVWF       FARG_TempErrorAction_ActionCmd+0 
	CALL        _TempErrorAction+0, 0
;Mainprocess.c,423 :: 		spc_system_flag.bite.temp_update = 1;
	BSF         _spc_system_flag+2, 3 
;Mainprocess.c,424 :: 		CopyTemp(&(pSPCValue[ChannelNum].SPCActual.TemperatureA),
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       4
	ADDWF       R0, 0 
	MOVWF       FARG_CopyTemp_tempsource+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FARG_CopyTemp_tempsource+1 
;Mainprocess.c,425 :: 		&(pSPCValue[ChannelNum].SPCActual.Temperature));
	MOVF        R0, 0 
	MOVWF       FARG_CopyTemp_temptarget+0 
	MOVF        R1, 0 
	MOVWF       FARG_CopyTemp_temptarget+1 
	CALL        _CopyTemp+0, 0
;Mainprocess.c,426 :: 		SystemUpdate |= (CH1_TEMP_UPDATE_REQ << ChannelNum);
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	MOVLW       4
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Tempprocess433:
	BZ          L__Tempprocess434
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Tempprocess433
L__Tempprocess434:
	MOVF        R0, 0 
	IORWF       _SystemUpdate+0, 1 
	MOVF        R1, 0 
	IORWF       _SystemUpdate+1, 1 
	MOVF        R2, 0 
	IORWF       _SystemUpdate+2, 1 
	MOVF        R3, 0 
	IORWF       _SystemUpdate+3, 1 
;Mainprocess.c,427 :: 		SetTempStatStr(temp_ptr, CH1_ACTURAL_ALL, ChannelNum);
	MOVF        Tempprocess_temp_ptr_L0+0, 0 
	MOVWF       FARG_SetTempStatStr_temp+0 
	MOVF        Tempprocess_temp_ptr_L0+1, 0 
	MOVWF       FARG_SetTempStatStr_temp+1 
	MOVLW       6
	MOVWF       FARG_SetTempStatStr_strlocat+0 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       FARG_SetTempStatStr_ChannelNum+0 
	CALL        _SetTempStatStr+0, 0
;Mainprocess.c,428 :: 		SetTempStatStr(tempa_ptr, CH1_ACTURAL_A, ChannelNum);
	MOVF        Tempprocess_tempa_ptr_L0+0, 0 
	MOVWF       FARG_SetTempStatStr_temp+0 
	MOVF        Tempprocess_tempa_ptr_L0+1, 0 
	MOVWF       FARG_SetTempStatStr_temp+1 
	MOVLW       8
	MOVWF       FARG_SetTempStatStr_strlocat+0 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       FARG_SetTempStatStr_ChannelNum+0 
	CALL        _SetTempStatStr+0, 0
;Mainprocess.c,429 :: 		SetTempStatStr(tempb_ptr, CH1_ACTURAL_B, ChannelNum);
	MOVF        Tempprocess_tempb_ptr_L0+0, 0 
	MOVWF       FARG_SetTempStatStr_temp+0 
	MOVF        Tempprocess_tempb_ptr_L0+1, 0 
	MOVWF       FARG_SetTempStatStr_temp+1 
	MOVLW       10
	MOVWF       FARG_SetTempStatStr_strlocat+0 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       FARG_SetTempStatStr_ChannelNum+0 
	CALL        _SetTempStatStr+0, 0
;Mainprocess.c,431 :: 		HighTempCutoffEn[ChannelNum] = 0;
	MOVLW       _HighTempCutoffEn+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_HighTempCutoffEn+0)
	MOVWF       FSR1H 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;Mainprocess.c,432 :: 		ForceSSROFFCondition[ChannelNum] &= ~HIGHTEMPCUTOFFFORCEOFF;
	MOVLW       _ForceSSROFFCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSROFFCondition+0)
	MOVWF       R2 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVLW       253
	ANDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,434 :: 		ADC_busy[ChannelNum] = ADC_FREE;
	MOVLW       _ADC_busy+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_ADC_busy+0)
	MOVWF       FSR1H 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;Mainprocess.c,436 :: 		if(ActivedAlarms & (CH1_LOWTEMPALARM << ChannelNum))
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Tempprocess435:
	BZ          L__Tempprocess436
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Tempprocess435
L__Tempprocess436:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_Tempprocess98
;Mainprocess.c,437 :: 		alarmoperate(CH1_LOWTEMPALARM << ChannelNum,DISALARM);
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       1
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Tempprocess437:
	BZ          L__Tempprocess438
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Tempprocess437
L__Tempprocess438:
	CLRF        FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Tempprocess98:
;Mainprocess.c,439 :: 		if(ActivedAlarms & (CH1_HIGHTEMPALARM << ChannelNum))
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       4
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Tempprocess439:
	BZ          L__Tempprocess440
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Tempprocess439
L__Tempprocess440:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_Tempprocess99
;Mainprocess.c,440 :: 		alarmoperate(CH1_HIGHTEMPALARM << ChannelNum,DISALARM);
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       4
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Tempprocess441:
	BZ          L__Tempprocess442
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Tempprocess441
L__Tempprocess442:
	CLRF        FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Tempprocess99:
;Mainprocess.c,441 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_Tempprocess
;Mainprocess.c,442 :: 		}
L_Tempprocess97:
;Mainprocess.c,445 :: 		TempErrorAction(ChannelNum, 0);
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       FARG_TempErrorAction_ChannelNum+0 
	CLRF        FARG_TempErrorAction_ActionCmd+0 
	CALL        _TempErrorAction+0, 0
;Mainprocess.c,448 :: 		CalSystemTemp(ChannelNum, RTD_stat);
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       FARG_CalSystemTemp_ChannelNum+0 
	MOVF        Tempprocess_RTD_stat_L0+0, 0 
	MOVWF       FARG_CalSystemTemp_RTDstat+0 
	CALL        _CalSystemTemp+0, 0
;Mainprocess.c,449 :: 		SystemUpdate |= (CH1_TEMP_UPDATE_REQ << ChannelNum);
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	MOVLW       4
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Tempprocess443:
	BZ          L__Tempprocess444
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Tempprocess443
L__Tempprocess444:
	MOVF        R0, 0 
	IORWF       _SystemUpdate+0, 1 
	MOVF        R1, 0 
	IORWF       _SystemUpdate+1, 1 
	MOVF        R2, 0 
	IORWF       _SystemUpdate+2, 1 
	MOVF        R3, 0 
	IORWF       _SystemUpdate+3, 1 
;Mainprocess.c,450 :: 		SetTempStatStr(temp_ptr, CH1_ACTURAL_ALL, ChannelNum);
	MOVF        Tempprocess_temp_ptr_L0+0, 0 
	MOVWF       FARG_SetTempStatStr_temp+0 
	MOVF        Tempprocess_temp_ptr_L0+1, 0 
	MOVWF       FARG_SetTempStatStr_temp+1 
	MOVLW       6
	MOVWF       FARG_SetTempStatStr_strlocat+0 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       FARG_SetTempStatStr_ChannelNum+0 
	CALL        _SetTempStatStr+0, 0
;Mainprocess.c,451 :: 		SetTempStatStr(tempa_ptr, CH1_ACTURAL_A, ChannelNum);
	MOVF        Tempprocess_tempa_ptr_L0+0, 0 
	MOVWF       FARG_SetTempStatStr_temp+0 
	MOVF        Tempprocess_tempa_ptr_L0+1, 0 
	MOVWF       FARG_SetTempStatStr_temp+1 
	MOVLW       8
	MOVWF       FARG_SetTempStatStr_strlocat+0 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       FARG_SetTempStatStr_ChannelNum+0 
	CALL        _SetTempStatStr+0, 0
;Mainprocess.c,452 :: 		SetTempStatStr(tempb_ptr, CH1_ACTURAL_B, ChannelNum);
	MOVF        Tempprocess_tempb_ptr_L0+0, 0 
	MOVWF       FARG_SetTempStatStr_temp+0 
	MOVF        Tempprocess_tempb_ptr_L0+1, 0 
	MOVWF       FARG_SetTempStatStr_temp+1 
	MOVLW       10
	MOVWF       FARG_SetTempStatStr_strlocat+0 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       FARG_SetTempStatStr_ChannelNum+0 
	CALL        _SetTempStatStr+0, 0
;Mainprocess.c,457 :: 		if((pSPCValue[ChannelNum].SPCActual.Temperature.Temperature_C == RTD_SHORT) ||
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
;Mainprocess.c,458 :: 		(pSPCValue[ChannelNum].SPCActual.Temperature.Temperature_C == RTD_OPNE))
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__Tempprocess445
	MOVLW       255
	XORWF       R1, 0 
L__Tempprocess445:
	BTFSC       STATUS+0, 2 
	GOTO        L__Tempprocess319
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__Tempprocess446
	MOVLW       253
	XORWF       R1, 0 
L__Tempprocess446:
	BTFSC       STATUS+0, 2 
	GOTO        L__Tempprocess319
	GOTO        L_Tempprocess103
L__Tempprocess319:
;Mainprocess.c,460 :: 		ADC_busy[ChannelNum] = ADC_FREE;
	MOVLW       _ADC_busy+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_ADC_busy+0)
	MOVWF       FSR1H 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;Mainprocess.c,461 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_Tempprocess
;Mainprocess.c,462 :: 		}
L_Tempprocess103:
;Mainprocess.c,464 :: 		if(pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_OFF)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
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
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__Tempprocess447
	MOVLW       255
	XORWF       R1, 0 
L__Tempprocess447:
	BTFSS       STATUS+0, 2 
	GOTO        L_Tempprocess104
;Mainprocess.c,466 :: 		asm nop;
	NOP
;Mainprocess.c,467 :: 		Spcssr[ChannelNum].SSR_cmd = 0;        //SET_SSR_DIS
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcssr+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_Spcssr+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;Mainprocess.c,468 :: 		if(ActivedAlarms & (CH1_LOWTEMPALARM << ChannelNum))
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Tempprocess448:
	BZ          L__Tempprocess449
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Tempprocess448
L__Tempprocess449:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_Tempprocess105
;Mainprocess.c,469 :: 		alarmoperate(CH1_LOWTEMPALARM << ChannelNum,DISALARM);
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       1
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Tempprocess450:
	BZ          L__Tempprocess451
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Tempprocess450
L__Tempprocess451:
	CLRF        FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Tempprocess105:
;Mainprocess.c,471 :: 		if(ActivedAlarms & (CH1_HIGHTEMPALARM << ChannelNum))
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       4
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Tempprocess452:
	BZ          L__Tempprocess453
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Tempprocess452
L__Tempprocess453:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_Tempprocess106
;Mainprocess.c,472 :: 		alarmoperate(CH1_HIGHTEMPALARM << ChannelNum,DISALARM);
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       4
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Tempprocess454:
	BZ          L__Tempprocess455
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Tempprocess454
L__Tempprocess455:
	CLRF        FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Tempprocess106:
;Mainprocess.c,473 :: 		}
	GOTO        L_Tempprocess107
L_Tempprocess104:
;Mainprocess.c,476 :: 		if((pSPCValue[ChannelNum].SPCActual.Temperature.Temperature_C >
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
;Mainprocess.c,477 :: 		pSPCValue[ChannelNum].SPCSetPoints.HighTemp.Temperature_C) &&
	MOVLW       54
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       8
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
;Mainprocess.c,478 :: 		(pSPCValue[ChannelNum].SPCSetPoints.HighTemp.Temperature_C != SPC_SYSTEMVALUE_OFF))
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R4, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Tempprocess456
	MOVF        R3, 0 
	SUBWF       R1, 0 
L__Tempprocess456:
	BTFSC       STATUS+0, 0 
	GOTO        L_Tempprocess110
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
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
	MOVLW       8
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__Tempprocess457
	MOVLW       255
	XORWF       R1, 0 
L__Tempprocess457:
	BTFSC       STATUS+0, 2 
	GOTO        L_Tempprocess110
L__Tempprocess318:
;Mainprocess.c,480 :: 		if(HighTempCutoffEn[ChannelNum] == 0)
	MOVLW       _HighTempCutoffEn+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_HighTempCutoffEn+0)
	MOVWF       FSR0H 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Tempprocess111
;Mainprocess.c,482 :: 		if(!(ActivedAlarms & (CH1_HIGHTEMPALARM << ChannelNum)))
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       4
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Tempprocess458:
	BZ          L__Tempprocess459
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Tempprocess458
L__Tempprocess459:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_Tempprocess112
;Mainprocess.c,483 :: 		alarmoperate(CH1_HIGHTEMPALARM << ChannelNum,ENALARM);
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       4
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Tempprocess460:
	BZ          L__Tempprocess461
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Tempprocess460
L__Tempprocess461:
	MOVLW       1
	MOVWF       FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Tempprocess112:
;Mainprocess.c,484 :: 		}
L_Tempprocess111:
;Mainprocess.c,486 :: 		if(ActivedAlarms & (CH1_LOWTEMPALARM << ChannelNum))
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Tempprocess462:
	BZ          L__Tempprocess463
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Tempprocess462
L__Tempprocess463:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_Tempprocess113
;Mainprocess.c,487 :: 		alarmoperate(CH1_LOWTEMPALARM << ChannelNum,DISALARM);
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       1
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Tempprocess464:
	BZ          L__Tempprocess465
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Tempprocess464
L__Tempprocess465:
	CLRF        FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Tempprocess113:
;Mainprocess.c,488 :: 		}
	GOTO        L_Tempprocess114
L_Tempprocess110:
;Mainprocess.c,489 :: 		else if((pSPCValue[ChannelNum].SPCActual.Temperature.Temperature_C <
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
;Mainprocess.c,490 :: 		pSPCValue[ChannelNum].SPCSetPoints.LowTemp.Temperature_C) &&
	MOVLW       54
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       4
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
;Mainprocess.c,491 :: 		(pSPCValue[ChannelNum].SPCSetPoints.LowTemp.Temperature_C != SPC_SYSTEMVALUE_OFF))
	MOVLW       128
	XORWF       R4, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Tempprocess466
	MOVF        R1, 0 
	SUBWF       R3, 0 
L__Tempprocess466:
	BTFSC       STATUS+0, 0 
	GOTO        L_Tempprocess117
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
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
	MOVLW       4
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__Tempprocess467
	MOVLW       255
	XORWF       R1, 0 
L__Tempprocess467:
	BTFSC       STATUS+0, 2 
	GOTO        L_Tempprocess117
L__Tempprocess317:
;Mainprocess.c,493 :: 		if(!(ActivedAlarms & (CH1_LOWTEMPALARM << ChannelNum)))
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Tempprocess468:
	BZ          L__Tempprocess469
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Tempprocess468
L__Tempprocess469:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_Tempprocess118
;Mainprocess.c,494 :: 		alarmoperate(CH1_LOWTEMPALARM << ChannelNum,ENALARM);
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       1
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Tempprocess470:
	BZ          L__Tempprocess471
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Tempprocess470
L__Tempprocess471:
	MOVLW       1
	MOVWF       FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Tempprocess118:
;Mainprocess.c,496 :: 		if(HighTempCutoffEn[ChannelNum] == 0)
	MOVLW       _HighTempCutoffEn+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_HighTempCutoffEn+0)
	MOVWF       FSR0H 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Tempprocess119
;Mainprocess.c,498 :: 		if(ActivedAlarms & (CH1_HIGHTEMPALARM << ChannelNum))
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       4
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Tempprocess472:
	BZ          L__Tempprocess473
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Tempprocess472
L__Tempprocess473:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_Tempprocess120
;Mainprocess.c,499 :: 		alarmoperate(CH1_HIGHTEMPALARM << ChannelNum,DISALARM);
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       4
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Tempprocess474:
	BZ          L__Tempprocess475
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Tempprocess474
L__Tempprocess475:
	CLRF        FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Tempprocess120:
;Mainprocess.c,500 :: 		}
L_Tempprocess119:
;Mainprocess.c,501 :: 		}
	GOTO        L_Tempprocess121
L_Tempprocess117:
;Mainprocess.c,504 :: 		if(ActivedAlarms & (CH1_LOWTEMPALARM << ChannelNum))
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Tempprocess476:
	BZ          L__Tempprocess477
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Tempprocess476
L__Tempprocess477:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_Tempprocess122
;Mainprocess.c,505 :: 		alarmoperate(CH1_LOWTEMPALARM << ChannelNum,DISALARM);
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       1
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Tempprocess478:
	BZ          L__Tempprocess479
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Tempprocess478
L__Tempprocess479:
	CLRF        FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Tempprocess122:
;Mainprocess.c,507 :: 		if(HighTempCutoffEn[ChannelNum] == 0)
	MOVLW       _HighTempCutoffEn+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_HighTempCutoffEn+0)
	MOVWF       FSR0H 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Tempprocess123
;Mainprocess.c,509 :: 		if(ActivedAlarms & (CH1_HIGHTEMPALARM << ChannelNum))
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       4
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Tempprocess480:
	BZ          L__Tempprocess481
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Tempprocess480
L__Tempprocess481:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_Tempprocess124
;Mainprocess.c,510 :: 		alarmoperate(CH1_HIGHTEMPALARM << ChannelNum,DISALARM);
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       4
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Tempprocess482:
	BZ          L__Tempprocess483
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Tempprocess482
L__Tempprocess483:
	CLRF        FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Tempprocess124:
;Mainprocess.c,511 :: 		}
L_Tempprocess123:
;Mainprocess.c,512 :: 		}
L_Tempprocess121:
L_Tempprocess114:
;Mainprocess.c,514 :: 		if(pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_NONE)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
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
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__Tempprocess484
	MOVLW       254
	XORWF       R1, 0 
L__Tempprocess484:
	BTFSS       STATUS+0, 2 
	GOTO        L_Tempprocess125
;Mainprocess.c,516 :: 		asm nop;
	NOP
;Mainprocess.c,517 :: 		Spcssr[ChannelNum].SSR_cmd = 0;
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcssr+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_Spcssr+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;Mainprocess.c,518 :: 		ADC_busy[ChannelNum] = ADC_FREE;
	MOVLW       _ADC_busy+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_ADC_busy+0)
	MOVWF       FSR1H 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;Mainprocess.c,519 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_Tempprocess
;Mainprocess.c,520 :: 		}
L_Tempprocess125:
;Mainprocess.c,524 :: 		if(SSRForceOp[ChannelNum] != LOAD_OK)
	MOVLW       _SSRForceOp+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_SSRForceOp+0)
	MOVWF       FSR0H 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_Tempprocess126
;Mainprocess.c,526 :: 		ADC_busy[ChannelNum] = ADC_FREE;
	MOVLW       _ADC_busy+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_ADC_busy+0)
	MOVWF       FSR1H 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;Mainprocess.c,527 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_Tempprocess
;Mainprocess.c,528 :: 		}
L_Tempprocess126:
;Mainprocess.c,530 :: 		if(pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.ctl_type)  //if it is pi control
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
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
	BTFSS       R0, 3 
	GOTO        L_Tempprocess127
;Mainprocess.c,532 :: 		asm nop;
	NOP
;Mainprocess.c,533 :: 		Spcssr[ChannelNum].SSR_cmd = 1;         //SET_SSR_EN
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcssr+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_Spcssr+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
;Mainprocess.c,534 :: 		if(Spcssr[ChannelNum].SSR_stat == 0)
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcssr+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcssr+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Tempprocess128
;Mainprocess.c,536 :: 		temp_val_old[ChannelNum] = abs(pSPCValue[ChannelNum].SPCActual.Temperature.Temperature_C -
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _temp_val_old+0
	ADDWF       R0, 0 
	MOVWF       FLOC__Tempprocess+0 
	MOVLW       hi_addr(_temp_val_old+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__Tempprocess+1 
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
;Mainprocess.c,537 :: 		pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C);
	MOVLW       54
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	SUBWF       POSTINC0+0, 0 
	MOVWF       FARG_abs_a+0 
	MOVF        POSTINC2+0, 0 
	SUBWFB      POSTINC0+0, 0 
	MOVWF       FARG_abs_a+1 
	CALL        _abs+0, 0
	MOVFF       FLOC__Tempprocess+0, FSR1
	MOVFF       FLOC__Tempprocess+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,538 :: 		}
L_Tempprocess128:
;Mainprocess.c,539 :: 		if(Spcssr[ChannelNum].SSR_stat == 1)   //如果ssr已经打开，进行pi控制算法  SSR_EN
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcssr+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcssr+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Tempprocess129
;Mainprocess.c,541 :: 		if(pSPCValue[ChannelNum].SPCActual.Temperature.Temperature_C >
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
;Mainprocess.c,542 :: 		pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C)
	MOVLW       54
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R4, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Tempprocess485
	MOVF        R3, 0 
	SUBWF       R1, 0 
L__Tempprocess485:
	BTFSC       STATUS+0, 0 
	GOTO        L_Tempprocess130
;Mainprocess.c,545 :: 		temp_val = (pSPCValue[ChannelNum].SPCActual.Temperature.Temperature_C -
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
;Mainprocess.c,546 :: 		pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C);
	MOVLW       54
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	SUBWF       POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC2+0, 0 
	SUBWFB      POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       Tempprocess_temp_val_L0+0 
	MOVF        R4, 0 
	MOVWF       Tempprocess_temp_val_L0+1 
;Mainprocess.c,548 :: 		if(temp_val > temp_val_old[ChannelNum])
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _temp_val_old+0
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       hi_addr(_temp_val_old+0)
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R4, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Tempprocess486
	MOVF        R3, 0 
	SUBWF       R1, 0 
L__Tempprocess486:
	BTFSC       STATUS+0, 0 
	GOTO        L_Tempprocess131
;Mainprocess.c,550 :: 		if(Spcpwm[ChannelNum].duty_point > 0)
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Tempprocess132
;Mainprocess.c,551 :: 		Spcpwm[ChannelNum].duty_point--;
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	DECF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
L_Tempprocess132:
;Mainprocess.c,552 :: 		}
	GOTO        L_Tempprocess133
L_Tempprocess131:
;Mainprocess.c,553 :: 		else if(temp_val == temp_val_old[ChannelNum])
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _temp_val_old+0
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       hi_addr(_temp_val_old+0)
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVF        Tempprocess_temp_val_L0+1, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Tempprocess487
	MOVF        R1, 0 
	XORWF       Tempprocess_temp_val_L0+0, 0 
L__Tempprocess487:
	BTFSS       STATUS+0, 2 
	GOTO        L_Tempprocess134
;Mainprocess.c,555 :: 		if(equalcount[ChannelNum]++ > 20)
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _equalcount+0
	ADDWF       R0, 0 
	MOVWF       R4 
	MOVLW       hi_addr(_equalcount+0)
	ADDWFC      R1, 0 
	MOVWF       R5 
	MOVFF       R4, FSR0
	MOVFF       R5, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVLW       1
	ADDWF       R2, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R1 
	MOVFF       R4, FSR1
	MOVFF       R5, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Tempprocess488
	MOVF        R2, 0 
	SUBLW       20
L__Tempprocess488:
	BTFSC       STATUS+0, 0 
	GOTO        L_Tempprocess135
;Mainprocess.c,557 :: 		equalcount[ChannelNum] = 0;
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _equalcount+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_equalcount+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;Mainprocess.c,558 :: 		if(Spcpwm[ChannelNum].duty_point > 0)
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Tempprocess136
;Mainprocess.c,559 :: 		Spcpwm[ChannelNum].duty_point--;
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	DECF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
L_Tempprocess136:
;Mainprocess.c,560 :: 		}
L_Tempprocess135:
;Mainprocess.c,561 :: 		}
L_Tempprocess134:
L_Tempprocess133:
;Mainprocess.c,562 :: 		temp_val_old[ChannelNum] = temp_val;
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _temp_val_old+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_temp_val_old+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        Tempprocess_temp_val_L0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        Tempprocess_temp_val_L0+1, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,564 :: 		duty_val = temp_val;
	MOVF        Tempprocess_temp_val_L0+0, 0 
	MOVWF       Tempprocess_duty_val_L0+0 
;Mainprocess.c,566 :: 		if(Spcpwm[ChannelNum].duty_point < duty_val)
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        Tempprocess_duty_val_L0+0, 0 
	SUBWF       POSTINC0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Tempprocess137
;Mainprocess.c,567 :: 		duty_index[ChannelNum] = 0;
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _duty_index+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_duty_index+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
	GOTO        L_Tempprocess138
L_Tempprocess137:
;Mainprocess.c,569 :: 		duty_index[ChannelNum] = Spcpwm[ChannelNum].duty_point - duty_val;
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _duty_index+0
	ADDWF       R0, 0 
	MOVWF       FLOC__Tempprocess+0 
	MOVLW       hi_addr(_duty_index+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__Tempprocess+1 
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        Tempprocess_duty_val_L0+0, 0 
	SUBWF       POSTINC0+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVFF       FLOC__Tempprocess+0, FSR1
	MOVFF       FLOC__Tempprocess+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
L_Tempprocess138:
;Mainprocess.c,572 :: 		}
	GOTO        L_Tempprocess139
L_Tempprocess130:
;Mainprocess.c,573 :: 		else if(pSPCValue[ChannelNum].SPCActual.Temperature.Temperature_C <
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
;Mainprocess.c,574 :: 		pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C)
	MOVLW       54
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R4, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Tempprocess489
	MOVF        R1, 0 
	SUBWF       R3, 0 
L__Tempprocess489:
	BTFSC       STATUS+0, 0 
	GOTO        L_Tempprocess140
;Mainprocess.c,577 :: 		temp_val = (pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C -
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       54
	ADDWF       R2, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
;Mainprocess.c,578 :: 		pSPCValue[ChannelNum].SPCActual.Temperature.Temperature_C);
	MOVLW       2
	ADDWF       R2, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	SUBWF       POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC2+0, 0 
	SUBWFB      POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       Tempprocess_temp_val_L0+0 
	MOVF        R4, 0 
	MOVWF       Tempprocess_temp_val_L0+1 
;Mainprocess.c,580 :: 		if(temp_val < temp_val_old[ChannelNum])
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _temp_val_old+0
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       hi_addr(_temp_val_old+0)
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R4, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Tempprocess490
	MOVF        R1, 0 
	SUBWF       R3, 0 
L__Tempprocess490:
	BTFSC       STATUS+0, 0 
	GOTO        L_Tempprocess141
;Mainprocess.c,582 :: 		if(Spcpwm[ChannelNum].duty_point < 10)
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVLW       10
	SUBWF       POSTINC0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Tempprocess142
;Mainprocess.c,583 :: 		Spcpwm[ChannelNum].duty_point++;
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
L_Tempprocess142:
;Mainprocess.c,584 :: 		}
	GOTO        L_Tempprocess143
L_Tempprocess141:
;Mainprocess.c,585 :: 		else if(temp_val == temp_val_old[ChannelNum])
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _temp_val_old+0
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       hi_addr(_temp_val_old+0)
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVF        Tempprocess_temp_val_L0+1, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Tempprocess491
	MOVF        R1, 0 
	XORWF       Tempprocess_temp_val_L0+0, 0 
L__Tempprocess491:
	BTFSS       STATUS+0, 2 
	GOTO        L_Tempprocess144
;Mainprocess.c,587 :: 		if(equalcount[ChannelNum]++ > 20)
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _equalcount+0
	ADDWF       R0, 0 
	MOVWF       R4 
	MOVLW       hi_addr(_equalcount+0)
	ADDWFC      R1, 0 
	MOVWF       R5 
	MOVFF       R4, FSR0
	MOVFF       R5, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVLW       1
	ADDWF       R2, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R1 
	MOVFF       R4, FSR1
	MOVFF       R5, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Tempprocess492
	MOVF        R2, 0 
	SUBLW       20
L__Tempprocess492:
	BTFSC       STATUS+0, 0 
	GOTO        L_Tempprocess145
;Mainprocess.c,589 :: 		equalcount[ChannelNum] = 0;
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _equalcount+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_equalcount+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;Mainprocess.c,590 :: 		if(Spcpwm[ChannelNum].duty_point < 10)
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVLW       10
	SUBWF       POSTINC0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Tempprocess146
;Mainprocess.c,591 :: 		Spcpwm[ChannelNum].duty_point++;
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
L_Tempprocess146:
;Mainprocess.c,592 :: 		}
L_Tempprocess145:
;Mainprocess.c,593 :: 		}
L_Tempprocess144:
L_Tempprocess143:
;Mainprocess.c,594 :: 		temp_val_old[ChannelNum] = temp_val;
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _temp_val_old+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_temp_val_old+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        Tempprocess_temp_val_L0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        Tempprocess_temp_val_L0+1, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,596 :: 		duty_val = temp_val;
	MOVF        Tempprocess_temp_val_L0+0, 0 
	MOVWF       Tempprocess_duty_val_L0+0 
;Mainprocess.c,598 :: 		if(Spcpwm[ChannelNum].duty_point + duty_val > 10)
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        Tempprocess_duty_val_L0+0, 0 
	ADDWF       POSTINC0+0, 0 
	MOVWF       R1 
	CLRF        R2 
	MOVLW       0
	ADDWFC      R2, 1 
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Tempprocess493
	MOVF        R1, 0 
	SUBLW       10
L__Tempprocess493:
	BTFSC       STATUS+0, 0 
	GOTO        L_Tempprocess147
;Mainprocess.c,599 :: 		duty_index[ChannelNum] = 10;
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _duty_index+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_duty_index+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       10
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
	GOTO        L_Tempprocess148
L_Tempprocess147:
;Mainprocess.c,601 :: 		duty_index[ChannelNum] = Spcpwm[ChannelNum].duty_point + duty_val;
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _duty_index+0
	ADDWF       R0, 0 
	MOVWF       FLOC__Tempprocess+0 
	MOVLW       hi_addr(_duty_index+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__Tempprocess+1 
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        Tempprocess_duty_val_L0+0, 0 
	ADDWF       POSTINC0+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVFF       FLOC__Tempprocess+0, FSR1
	MOVFF       FLOC__Tempprocess+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
L_Tempprocess148:
;Mainprocess.c,602 :: 		}
L_Tempprocess140:
L_Tempprocess139:
;Mainprocess.c,604 :: 		if(pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent != SPC_SYSTEMVALUE_OFF)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
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
	MOVLW       28
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__Tempprocess494
	MOVLW       255
	XORWF       R1, 0 
L__Tempprocess494:
	BTFSC       STATUS+0, 2 
	GOTO        L_Tempprocess149
;Mainprocess.c,606 :: 		if(duty_index[ChannelNum] > pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent/10)
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _duty_index+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_duty_index+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__Tempprocess+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__Tempprocess+1 
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
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
	MOVLW       28
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        FLOC__Tempprocess+1, 0 
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Tempprocess495
	MOVF        FLOC__Tempprocess+0, 0 
	SUBWF       R0, 0 
L__Tempprocess495:
	BTFSC       STATUS+0, 0 
	GOTO        L_Tempprocess150
;Mainprocess.c,607 :: 		duty_index[ChannelNum] =  pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent/10;
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _duty_index+0
	ADDWF       R0, 0 
	MOVWF       FLOC__Tempprocess+0 
	MOVLW       hi_addr(_duty_index+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__Tempprocess+1 
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
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
	MOVLW       28
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVFF       FLOC__Tempprocess+0, FSR1
	MOVFF       FLOC__Tempprocess+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
L_Tempprocess150:
;Mainprocess.c,608 :: 		}
L_Tempprocess149:
;Mainprocess.c,609 :: 		pwm_duty[ChannelNum] = get_duty_table(duty_index[ChannelNum]);
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pwm_duty+0
	ADDWF       R0, 0 
	MOVWF       FLOC__Tempprocess+0 
	MOVLW       hi_addr(_pwm_duty+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__Tempprocess+1 
	MOVLW       _duty_index+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_duty_index+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_get_duty_table_index+0 
	CALL        _get_duty_table+0, 0
	MOVFF       FLOC__Tempprocess+0, FSR1
	MOVFF       FLOC__Tempprocess+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,611 :: 		if(pwm_duty[ChannelNum] == 0)
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pwm_duty+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_pwm_duty+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Tempprocess496
	MOVLW       0
	XORWF       R1, 0 
L__Tempprocess496:
	BTFSS       STATUS+0, 2 
	GOTO        L_Tempprocess151
;Mainprocess.c,612 :: 		SetHeatStatStr(HEAT_IS_OFF, ChannelNum);
	CLRF        FARG_SetHeatStatStr_Strlocat+0 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       FARG_SetHeatStatStr_ChannelNum+0 
	CALL        _SetHeatStatStr+0, 0
	GOTO        L_Tempprocess152
L_Tempprocess151:
;Mainprocess.c,614 :: 		SetHeatStatStr(HEAT_IS_ON, ChannelNum);
	MOVLW       1
	MOVWF       FARG_SetHeatStatStr_Strlocat+0 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       FARG_SetHeatStatStr_ChannelNum+0 
	CALL        _SetHeatStatStr+0, 0
L_Tempprocess152:
;Mainprocess.c,616 :: 		dutyshadePI[ChannelNum] = duty_index[ChannelNum]*10;
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _dutyshadePI+0
	ADDWF       R0, 0 
	MOVWF       FLOC__Tempprocess+0 
	MOVLW       hi_addr(_dutyshadePI+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__Tempprocess+1 
	MOVLW       _duty_index+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_duty_index+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVFF       FLOC__Tempprocess+0, FSR1
	MOVFF       FLOC__Tempprocess+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,617 :: 		SystemUpdate |= (CH1_DUTY_UPDATE_REQ << ChannelNum);
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       1
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Tempprocess497:
	BZ          L__Tempprocess498
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Tempprocess497
L__Tempprocess498:
	MOVF        R0, 0 
	IORWF       _SystemUpdate+0, 1 
	MOVF        R1, 0 
	IORWF       _SystemUpdate+1, 1 
	MOVF        R2, 0 
	IORWF       _SystemUpdate+2, 1 
	MOVF        R3, 0 
	IORWF       _SystemUpdate+3, 1 
;Mainprocess.c,618 :: 		SetIntStr((int*)&dutyshadePI[ChannelNum], CH1_ACTURAL_DUTY+ChannelNum, UNIT_PERCENT, 1);
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _dutyshadePI+0
	ADDWF       R0, 0 
	MOVWF       FARG_SetIntStr_ptr+0 
	MOVLW       hi_addr(_dutyshadePI+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_SetIntStr_ptr+1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	ADDLW       18
	MOVWF       FARG_SetIntStr_strlocat+0 
	MOVLW       9
	MOVWF       FARG_SetIntStr_unitlocar+0 
	MOVLW       1
	MOVWF       FARG_SetIntStr_len+0 
	CALL        _SetIntStr+0, 0
;Mainprocess.c,619 :: 		}
L_Tempprocess129:
;Mainprocess.c,620 :: 		}
	GOTO        L_Tempprocess153
L_Tempprocess127:
;Mainprocess.c,624 :: 		if(pSPCValue[ChannelNum].SPCActual.Temperature.Temperature_C >
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R5 
	MOVF        POSTINC0+0, 0 
	MOVWF       R6 
;Mainprocess.c,625 :: 		pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C +
	MOVLW       54
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R4 
;Mainprocess.c,626 :: 		pSPCValue[ChannelNum].SPCSetPoints.DeadBand.Temperature_C)
	MOVLW       12
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVFF       R3, FSR0
	MOVFF       R4, FSR0H
	MOVF        POSTINC2+0, 0 
	ADDWF       POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	ADDWFC      POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R6, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Tempprocess499
	MOVF        R5, 0 
	SUBWF       R1, 0 
L__Tempprocess499:
	BTFSC       STATUS+0, 0 
	GOTO        L_Tempprocess154
;Mainprocess.c,628 :: 		if(Spcssr[ChannelNum].SSR_cmd == 1)
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcssr+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_Spcssr+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Tempprocess155
;Mainprocess.c,629 :: 		Spcssr[ChannelNum].SSR_cmd = 0;         //SET_SSR_DIS
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcssr+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_Spcssr+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
L_Tempprocess155:
;Mainprocess.c,630 :: 		}
	GOTO        L_Tempprocess156
L_Tempprocess154:
;Mainprocess.c,631 :: 		else if(pSPCValue[ChannelNum].SPCActual.Temperature.Temperature_C <
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R5 
	MOVF        POSTINC0+0, 0 
	MOVWF       R6 
;Mainprocess.c,632 :: 		pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C -
	MOVLW       54
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R4 
;Mainprocess.c,633 :: 		pSPCValue[ChannelNum].SPCSetPoints.DeadBand.Temperature_C)
	MOVLW       12
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVFF       R3, FSR0
	MOVFF       R4, FSR0H
	MOVF        POSTINC2+0, 0 
	SUBWF       POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	SUBWFB      POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R6, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Tempprocess500
	MOVF        R1, 0 
	SUBWF       R5, 0 
L__Tempprocess500:
	BTFSC       STATUS+0, 0 
	GOTO        L_Tempprocess157
;Mainprocess.c,635 :: 		if(Spcssr[ChannelNum].SSR_cmd == 0)
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcssr+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_Spcssr+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Tempprocess158
;Mainprocess.c,636 :: 		Spcssr[ChannelNum].SSR_cmd = 1;        //SET_SSR_EN
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcssr+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_Spcssr+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
L_Tempprocess158:
;Mainprocess.c,637 :: 		}
L_Tempprocess157:
L_Tempprocess156:
;Mainprocess.c,638 :: 		}
L_Tempprocess153:
;Mainprocess.c,639 :: 		}
L_Tempprocess107:
;Mainprocess.c,641 :: 		ADC_busy[ChannelNum] = ADC_FREE;
	MOVLW       _ADC_busy+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_ADC_busy+0)
	MOVWF       FSR1H 
	MOVF        FARG_Tempprocess_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;Mainprocess.c,642 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
;Mainprocess.c,643 :: 		}
L_end_Tempprocess:
	RETURN      0
; end of _Tempprocess

_BackupFunc:

;Mainprocess.c,650 :: 		void BackupFunc(char ChannelNum, char RTDstats)
;Mainprocess.c,652 :: 		if(RTDstats & RTDA_ERR)
	BTFSS       FARG_BackupFunc_RTDstats+0, 0 
	GOTO        L_BackupFunc159
;Mainprocess.c,654 :: 		CopyTemp(&(pSPCValue[ChannelNum].SPCActual.TemperatureB),
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_BackupFunc_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       8
	ADDWF       R0, 0 
	MOVWF       FARG_CopyTemp_tempsource+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FARG_CopyTemp_tempsource+1 
;Mainprocess.c,655 :: 		&(pSPCValue[ChannelNum].SPCActual.Temperature));
	MOVF        R0, 0 
	MOVWF       FARG_CopyTemp_temptarget+0 
	MOVF        R1, 0 
	MOVWF       FARG_CopyTemp_temptarget+1 
	CALL        _CopyTemp+0, 0
;Mainprocess.c,656 :: 		}
	GOTO        L_BackupFunc160
L_BackupFunc159:
;Mainprocess.c,659 :: 		CopyTemp(&(pSPCValue[ChannelNum].SPCActual.TemperatureA),
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_BackupFunc_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       4
	ADDWF       R0, 0 
	MOVWF       FARG_CopyTemp_tempsource+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FARG_CopyTemp_tempsource+1 
;Mainprocess.c,660 :: 		&(pSPCValue[ChannelNum].SPCActual.Temperature));
	MOVF        R0, 0 
	MOVWF       FARG_CopyTemp_temptarget+0 
	MOVF        R1, 0 
	MOVWF       FARG_CopyTemp_temptarget+1 
	CALL        _CopyTemp+0, 0
;Mainprocess.c,661 :: 		}
L_BackupFunc160:
;Mainprocess.c,662 :: 		}
L_end_BackupFunc:
	RETURN      0
; end of _BackupFunc

_CalSystemTemp:

;Mainprocess.c,664 :: 		void CalSystemTemp(char ChannelNum, char RTDstat)
;Mainprocess.c,668 :: 		HighTempCutoffEn[ChannelNum] = 0;
	MOVLW       _HighTempCutoffEn+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_HighTempCutoffEn+0)
	MOVWF       FSR1H 
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;Mainprocess.c,669 :: 		dispmodetemp = pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.rtd_opr;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
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
	MOVLW       112
	ANDWF       R0, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	MOVF        R1, 0 
	MOVWF       CalSystemTemp_dispmodetemp_L0+0 
;Mainprocess.c,671 :: 		switch(dispmodetemp)
	GOTO        L_CalSystemTemp161
;Mainprocess.c,673 :: 		case ONE_RTD_MOD:
L_CalSystemTemp163:
;Mainprocess.c,674 :: 		HighTempCutoffEn[ChannelNum] = 0;
	MOVLW       _HighTempCutoffEn+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_HighTempCutoffEn+0)
	MOVWF       FSR1H 
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;Mainprocess.c,675 :: 		ForceSSROFFCondition[ChannelNum] &= ~HIGHTEMPCUTOFFFORCEOFF;
	MOVLW       _ForceSSROFFCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSROFFCondition+0)
	MOVWF       R2 
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVLW       253
	ANDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,676 :: 		CopyTemp(&(pSPCValue[ChannelNum].SPCActual.TemperatureA),
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       4
	ADDWF       R0, 0 
	MOVWF       FARG_CopyTemp_tempsource+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FARG_CopyTemp_tempsource+1 
;Mainprocess.c,677 :: 		&(pSPCValue[ChannelNum].SPCActual.Temperature));
	MOVF        R0, 0 
	MOVWF       FARG_CopyTemp_temptarget+0 
	MOVF        R1, 0 
	MOVWF       FARG_CopyTemp_temptarget+1 
	CALL        _CopyTemp+0, 0
;Mainprocess.c,678 :: 		break;
	GOTO        L_CalSystemTemp162
;Mainprocess.c,679 :: 		case BACKUP_MOD:
L_CalSystemTemp164:
;Mainprocess.c,680 :: 		HighTempCutoffEn[ChannelNum] = 0;
	MOVLW       _HighTempCutoffEn+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_HighTempCutoffEn+0)
	MOVWF       FSR1H 
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;Mainprocess.c,681 :: 		ForceSSROFFCondition[ChannelNum] &= ~HIGHTEMPCUTOFFFORCEOFF;
	MOVLW       _ForceSSROFFCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSROFFCondition+0)
	MOVWF       R2 
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVLW       253
	ANDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,682 :: 		BackupFunc(ChannelNum, RTDstat);
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	MOVWF       FARG_BackupFunc_ChannelNum+0 
	MOVF        FARG_CalSystemTemp_RTDstat+0, 0 
	MOVWF       FARG_BackupFunc_RTDstats+0 
	CALL        _BackupFunc+0, 0
;Mainprocess.c,683 :: 		break;
	GOTO        L_CalSystemTemp162
;Mainprocess.c,684 :: 		case AVERAGE_MOD:
L_CalSystemTemp165:
;Mainprocess.c,685 :: 		HighTempCutoffEn[ChannelNum] = 0;
	MOVLW       _HighTempCutoffEn+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_HighTempCutoffEn+0)
	MOVWF       FSR1H 
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;Mainprocess.c,686 :: 		ForceSSROFFCondition[ChannelNum] &= ~HIGHTEMPCUTOFFFORCEOFF;
	MOVLW       _ForceSSROFFCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSROFFCondition+0)
	MOVWF       R2 
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVLW       253
	ANDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,687 :: 		if(RTDstat == RTD_OK)
	MOVF        FARG_CalSystemTemp_RTDstat+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_CalSystemTemp166
;Mainprocess.c,689 :: 		tempaverage(&(pSPCValue[ChannelNum].SPCActual.TemperatureA),
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       4
	ADDWF       R0, 0 
	MOVWF       FARG_tempaverage_tempsource+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FARG_tempaverage_tempsource+1 
;Mainprocess.c,690 :: 		&(pSPCValue[ChannelNum].SPCActual.Temperature));
	MOVF        R0, 0 
	MOVWF       FARG_tempaverage_temptarget+0 
	MOVF        R1, 0 
	MOVWF       FARG_tempaverage_temptarget+1 
	CALL        _tempaverage+0, 0
;Mainprocess.c,691 :: 		}
	GOTO        L_CalSystemTemp167
L_CalSystemTemp166:
;Mainprocess.c,694 :: 		BackupFunc(ChannelNum, RTDstat);
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	MOVWF       FARG_BackupFunc_ChannelNum+0 
	MOVF        FARG_CalSystemTemp_RTDstat+0, 0 
	MOVWF       FARG_BackupFunc_RTDstats+0 
	CALL        _BackupFunc+0, 0
;Mainprocess.c,695 :: 		}
L_CalSystemTemp167:
;Mainprocess.c,696 :: 		break;
	GOTO        L_CalSystemTemp162
;Mainprocess.c,697 :: 		case LOWEST_MOD:
L_CalSystemTemp168:
;Mainprocess.c,698 :: 		HighTempCutoffEn[ChannelNum] = 0;
	MOVLW       _HighTempCutoffEn+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_HighTempCutoffEn+0)
	MOVWF       FSR1H 
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;Mainprocess.c,699 :: 		ForceSSROFFCondition[ChannelNum] &= ~HIGHTEMPCUTOFFFORCEOFF;
	MOVLW       _ForceSSROFFCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSROFFCondition+0)
	MOVWF       R2 
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVLW       253
	ANDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,700 :: 		if(RTDstat == RTD_OK)
	MOVF        FARG_CalSystemTemp_RTDstat+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_CalSystemTemp169
;Mainprocess.c,702 :: 		if(pSPCValue[ChannelNum].SPCActual.TemperatureA.Temperature_C >=
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       4
	ADDWF       R2, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        POSTINC0+0, 0 
	MOVWF       R5 
;Mainprocess.c,703 :: 		pSPCValue[ChannelNum].SPCActual.TemperatureB.Temperature_C)
	MOVLW       8
	ADDWF       R2, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R5, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__CalSystemTemp503
	MOVF        R1, 0 
	SUBWF       R4, 0 
L__CalSystemTemp503:
	BTFSS       STATUS+0, 0 
	GOTO        L_CalSystemTemp170
;Mainprocess.c,704 :: 		CopyTemp(&(pSPCValue[ChannelNum].SPCActual.TemperatureB),
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       8
	ADDWF       R0, 0 
	MOVWF       FARG_CopyTemp_tempsource+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FARG_CopyTemp_tempsource+1 
;Mainprocess.c,705 :: 		&(pSPCValue[ChannelNum].SPCActual.Temperature));
	MOVF        R0, 0 
	MOVWF       FARG_CopyTemp_temptarget+0 
	MOVF        R1, 0 
	MOVWF       FARG_CopyTemp_temptarget+1 
	CALL        _CopyTemp+0, 0
	GOTO        L_CalSystemTemp171
L_CalSystemTemp170:
;Mainprocess.c,707 :: 		CopyTemp(&(pSPCValue[ChannelNum].SPCActual.TemperatureA),
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       4
	ADDWF       R0, 0 
	MOVWF       FARG_CopyTemp_tempsource+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FARG_CopyTemp_tempsource+1 
;Mainprocess.c,708 :: 		&(pSPCValue[ChannelNum].SPCActual.Temperature));
	MOVF        R0, 0 
	MOVWF       FARG_CopyTemp_temptarget+0 
	MOVF        R1, 0 
	MOVWF       FARG_CopyTemp_temptarget+1 
	CALL        _CopyTemp+0, 0
L_CalSystemTemp171:
;Mainprocess.c,709 :: 		}
	GOTO        L_CalSystemTemp172
L_CalSystemTemp169:
;Mainprocess.c,712 :: 		BackupFunc(ChannelNum, RTDstat);
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	MOVWF       FARG_BackupFunc_ChannelNum+0 
	MOVF        FARG_CalSystemTemp_RTDstat+0, 0 
	MOVWF       FARG_BackupFunc_RTDstats+0 
	CALL        _BackupFunc+0, 0
;Mainprocess.c,713 :: 		}
L_CalSystemTemp172:
;Mainprocess.c,714 :: 		break;
	GOTO        L_CalSystemTemp162
;Mainprocess.c,715 :: 		case HIGHEST_MOD:
L_CalSystemTemp173:
;Mainprocess.c,716 :: 		HighTempCutoffEn[ChannelNum] = 0;
	MOVLW       _HighTempCutoffEn+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_HighTempCutoffEn+0)
	MOVWF       FSR1H 
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;Mainprocess.c,717 :: 		ForceSSROFFCondition[ChannelNum] &= ~HIGHTEMPCUTOFFFORCEOFF;
	MOVLW       _ForceSSROFFCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSROFFCondition+0)
	MOVWF       R2 
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVLW       253
	ANDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,718 :: 		if(RTDstat == RTD_OK)
	MOVF        FARG_CalSystemTemp_RTDstat+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_CalSystemTemp174
;Mainprocess.c,720 :: 		if(pSPCValue[ChannelNum].SPCActual.TemperatureA.Temperature_C <=
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       4
	ADDWF       R2, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        POSTINC0+0, 0 
	MOVWF       R5 
;Mainprocess.c,721 :: 		pSPCValue[ChannelNum].SPCActual.TemperatureB.Temperature_C)
	MOVLW       8
	ADDWF       R2, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R5, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__CalSystemTemp504
	MOVF        R4, 0 
	SUBWF       R1, 0 
L__CalSystemTemp504:
	BTFSS       STATUS+0, 0 
	GOTO        L_CalSystemTemp175
;Mainprocess.c,722 :: 		CopyTemp(&(pSPCValue[ChannelNum].SPCActual.TemperatureB),
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       8
	ADDWF       R0, 0 
	MOVWF       FARG_CopyTemp_tempsource+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FARG_CopyTemp_tempsource+1 
;Mainprocess.c,723 :: 		&(pSPCValue[ChannelNum].SPCActual.Temperature));
	MOVF        R0, 0 
	MOVWF       FARG_CopyTemp_temptarget+0 
	MOVF        R1, 0 
	MOVWF       FARG_CopyTemp_temptarget+1 
	CALL        _CopyTemp+0, 0
	GOTO        L_CalSystemTemp176
L_CalSystemTemp175:
;Mainprocess.c,725 :: 		CopyTemp(&(pSPCValue[ChannelNum].SPCActual.TemperatureA),
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       4
	ADDWF       R0, 0 
	MOVWF       FARG_CopyTemp_tempsource+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FARG_CopyTemp_tempsource+1 
;Mainprocess.c,726 :: 		&(pSPCValue[ChannelNum].SPCActual.Temperature));
	MOVF        R0, 0 
	MOVWF       FARG_CopyTemp_temptarget+0 
	MOVF        R1, 0 
	MOVWF       FARG_CopyTemp_temptarget+1 
	CALL        _CopyTemp+0, 0
L_CalSystemTemp176:
;Mainprocess.c,727 :: 		}
	GOTO        L_CalSystemTemp177
L_CalSystemTemp174:
;Mainprocess.c,730 :: 		BackupFunc(ChannelNum, RTDstat);
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	MOVWF       FARG_BackupFunc_ChannelNum+0 
	MOVF        FARG_CalSystemTemp_RTDstat+0, 0 
	MOVWF       FARG_BackupFunc_RTDstats+0 
	CALL        _BackupFunc+0, 0
;Mainprocess.c,731 :: 		}
L_CalSystemTemp177:
;Mainprocess.c,732 :: 		break;
	GOTO        L_CalSystemTemp162
;Mainprocess.c,733 :: 		case HIGHTEMPCUTOFF_MOD:
L_CalSystemTemp178:
;Mainprocess.c,734 :: 		if(RTDstat == RTD_OK)
	MOVF        FARG_CalSystemTemp_RTDstat+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_CalSystemTemp179
;Mainprocess.c,736 :: 		CopyTemp(&(pSPCValue[ChannelNum].SPCActual.TemperatureA),
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       4
	ADDWF       R0, 0 
	MOVWF       FARG_CopyTemp_tempsource+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FARG_CopyTemp_tempsource+1 
;Mainprocess.c,737 :: 		&(pSPCValue[ChannelNum].SPCActual.Temperature));
	MOVF        R0, 0 
	MOVWF       FARG_CopyTemp_temptarget+0 
	MOVF        R1, 0 
	MOVWF       FARG_CopyTemp_temptarget+1 
	CALL        _CopyTemp+0, 0
;Mainprocess.c,738 :: 		}
L_CalSystemTemp179:
;Mainprocess.c,739 :: 		if(pSPCValue[ChannelNum].SPCSetPoints.HighTemp.Temperature_C == SPC_SYSTEMVALUE_OFF)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
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
	MOVLW       8
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__CalSystemTemp505
	MOVLW       255
	XORWF       R1, 0 
L__CalSystemTemp505:
	BTFSS       STATUS+0, 2 
	GOTO        L_CalSystemTemp180
;Mainprocess.c,741 :: 		HighTempCutoffEn[ChannelNum] = 0;
	MOVLW       _HighTempCutoffEn+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_HighTempCutoffEn+0)
	MOVWF       FSR1H 
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;Mainprocess.c,742 :: 		ForceSSROFFCondition[ChannelNum] &= ~HIGHTEMPCUTOFFFORCEOFF;
	MOVLW       _ForceSSROFFCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSROFFCondition+0)
	MOVWF       R2 
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVLW       253
	ANDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,743 :: 		BackupFunc(ChannelNum, RTDstat);
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	MOVWF       FARG_BackupFunc_ChannelNum+0 
	MOVF        FARG_CalSystemTemp_RTDstat+0, 0 
	MOVWF       FARG_BackupFunc_RTDstats+0 
	CALL        _BackupFunc+0, 0
;Mainprocess.c,744 :: 		}
	GOTO        L_CalSystemTemp181
L_CalSystemTemp180:
;Mainprocess.c,747 :: 		if(RTDstat & RTDB_ERR)
	BTFSS       FARG_CalSystemTemp_RTDstat+0, 1 
	GOTO        L_CalSystemTemp182
;Mainprocess.c,749 :: 		HighTempCutoffEn[ChannelNum] = 0;
	MOVLW       _HighTempCutoffEn+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_HighTempCutoffEn+0)
	MOVWF       FSR1H 
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;Mainprocess.c,750 :: 		ForceSSROFFCondition[ChannelNum] &= ~HIGHTEMPCUTOFFFORCEOFF;
	MOVLW       _ForceSSROFFCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSROFFCondition+0)
	MOVWF       R2 
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVLW       253
	ANDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,751 :: 		BackupFunc(ChannelNum, RTDstat);
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	MOVWF       FARG_BackupFunc_ChannelNum+0 
	MOVF        FARG_CalSystemTemp_RTDstat+0, 0 
	MOVWF       FARG_BackupFunc_RTDstats+0 
	CALL        _BackupFunc+0, 0
;Mainprocess.c,752 :: 		}
	GOTO        L_CalSystemTemp183
L_CalSystemTemp182:
;Mainprocess.c,755 :: 		BackupFunc(ChannelNum, RTDstat);
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	MOVWF       FARG_BackupFunc_ChannelNum+0 
	MOVF        FARG_CalSystemTemp_RTDstat+0, 0 
	MOVWF       FARG_BackupFunc_RTDstats+0 
	CALL        _BackupFunc+0, 0
;Mainprocess.c,756 :: 		if(pSPCValue[ChannelNum].SPCActual.TemperatureB.Temperature_C >
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       8
	ADDWF       R2, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        POSTINC0+0, 0 
	MOVWF       R5 
;Mainprocess.c,757 :: 		pSPCValue[ChannelNum].SPCSetPoints.HighTemp.Temperature_C)
	MOVLW       54
	ADDWF       R2, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R1 
	MOVLW       8
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R5, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__CalSystemTemp506
	MOVF        R4, 0 
	SUBWF       R1, 0 
L__CalSystemTemp506:
	BTFSC       STATUS+0, 0 
	GOTO        L_CalSystemTemp184
;Mainprocess.c,759 :: 		HighTempCutoffEn[ChannelNum] = 1;
	MOVLW       _HighTempCutoffEn+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_HighTempCutoffEn+0)
	MOVWF       FSR1H 
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       1
	MOVWF       POSTINC1+0 
;Mainprocess.c,760 :: 		ForceSSROFFCondition[ChannelNum] |= HIGHTEMPCUTOFFFORCEOFF;
	MOVLW       _ForceSSROFFCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSROFFCondition+0)
	MOVWF       R2 
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVLW       2
	IORWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,761 :: 		if(!(ActivedAlarms & (CH1_HIGHTEMPALARM << ChannelNum)))
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       4
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__CalSystemTemp507:
	BZ          L__CalSystemTemp508
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__CalSystemTemp507
L__CalSystemTemp508:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_CalSystemTemp185
;Mainprocess.c,762 :: 		alarmoperate(CH1_HIGHTEMPALARM << ChannelNum,ENALARM);
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       4
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__CalSystemTemp509:
	BZ          L__CalSystemTemp510
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__CalSystemTemp509
L__CalSystemTemp510:
	MOVLW       1
	MOVWF       FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_CalSystemTemp185:
;Mainprocess.c,763 :: 		}
	GOTO        L_CalSystemTemp186
L_CalSystemTemp184:
;Mainprocess.c,766 :: 		HighTempCutoffEn[ChannelNum] = 0;
	MOVLW       _HighTempCutoffEn+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_HighTempCutoffEn+0)
	MOVWF       FSR1H 
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;Mainprocess.c,767 :: 		ForceSSROFFCondition[ChannelNum] &= ~HIGHTEMPCUTOFFFORCEOFF;
	MOVLW       _ForceSSROFFCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSROFFCondition+0)
	MOVWF       R2 
	MOVF        FARG_CalSystemTemp_ChannelNum+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVLW       253
	ANDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,768 :: 		}
L_CalSystemTemp186:
;Mainprocess.c,769 :: 		}
L_CalSystemTemp183:
;Mainprocess.c,770 :: 		}
L_CalSystemTemp181:
;Mainprocess.c,771 :: 		break;
	GOTO        L_CalSystemTemp162
;Mainprocess.c,772 :: 		}
L_CalSystemTemp161:
	MOVF        CalSystemTemp_dispmodetemp_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_CalSystemTemp163
	MOVF        CalSystemTemp_dispmodetemp_L0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_CalSystemTemp164
	MOVF        CalSystemTemp_dispmodetemp_L0+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_CalSystemTemp165
	MOVF        CalSystemTemp_dispmodetemp_L0+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_CalSystemTemp168
	MOVF        CalSystemTemp_dispmodetemp_L0+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_CalSystemTemp173
	MOVF        CalSystemTemp_dispmodetemp_L0+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_CalSystemTemp178
L_CalSystemTemp162:
;Mainprocess.c,773 :: 		}
L_end_CalSystemTemp:
	RETURN      0
; end of _CalSystemTemp

_EnableHighCurrentAlarmCount:

;Mainprocess.c,780 :: 		void EnableHighCurrentAlarmCount(char ChannelNum)
;Mainprocess.c,782 :: 		if(HighCurrentEn[ChannelNum] == 0)
	MOVLW       _HighCurrentEn+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_HighCurrentEn+0)
	MOVWF       FSR0H 
	MOVF        FARG_EnableHighCurrentAlarmCount_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_EnableHighCurrentAlarmCount187
;Mainprocess.c,784 :: 		HighCurrentAlarmCount[ChannelNum]=0;
	MOVF        FARG_EnableHighCurrentAlarmCount_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _HighCurrentAlarmCount+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_HighCurrentAlarmCount+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;Mainprocess.c,785 :: 		HighCurrentEn[ChannelNum]=1;
	MOVLW       _HighCurrentEn+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_HighCurrentEn+0)
	MOVWF       FSR1H 
	MOVF        FARG_EnableHighCurrentAlarmCount_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       1
	MOVWF       POSTINC1+0 
;Mainprocess.c,786 :: 		}
L_EnableHighCurrentAlarmCount187:
;Mainprocess.c,787 :: 		}
L_end_EnableHighCurrentAlarmCount:
	RETURN      0
; end of _EnableHighCurrentAlarmCount

_DisableHighCurrentAlarmCount:

;Mainprocess.c,789 :: 		void DisableHighCurrentAlarmCount(char ChannelNum)
;Mainprocess.c,791 :: 		HighCurrentAlarmCount[ChannelNum]=0;
	MOVF        FARG_DisableHighCurrentAlarmCount_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _HighCurrentAlarmCount+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_HighCurrentAlarmCount+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;Mainprocess.c,792 :: 		HighCurrentEn[ChannelNum]=0;
	MOVLW       _HighCurrentEn+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_HighCurrentEn+0)
	MOVWF       FSR1H 
	MOVF        FARG_DisableHighCurrentAlarmCount_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;Mainprocess.c,793 :: 		}
L_end_DisableHighCurrentAlarmCount:
	RETURN      0
; end of _DisableHighCurrentAlarmCount

_GetHighCurrentEn:

;Mainprocess.c,795 :: 		char GetHighCurrentEn(char ChannelNum)
;Mainprocess.c,797 :: 		return HighCurrentEn[ChannelNum];
	MOVLW       _HighCurrentEn+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_HighCurrentEn+0)
	MOVWF       FSR0H 
	MOVF        FARG_GetHighCurrentEn_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
;Mainprocess.c,798 :: 		}
L_end_GetHighCurrentEn:
	RETURN      0
; end of _GetHighCurrentEn

_SetHighCurrentEn:

;Mainprocess.c,800 :: 		void SetHighCurrentEn(char ChannelNum, char HighCurrentCmd)
;Mainprocess.c,802 :: 		HighCurrentEn[ChannelNum] = HighCurrentCmd;
	MOVLW       _HighCurrentEn+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_HighCurrentEn+0)
	MOVWF       FSR1H 
	MOVF        FARG_SetHighCurrentEn_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVF        FARG_SetHighCurrentEn_HighCurrentCmd+0, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,803 :: 		}
L_end_SetHighCurrentEn:
	RETURN      0
; end of _SetHighCurrentEn

_Currentprocess:

;Mainprocess.c,805 :: 		void Currentprocess(char ChannelNum)
;Mainprocess.c,808 :: 		char GFIAlarmFlag=0;
	CLRF        Currentprocess_GFIAlarmFlag_L0+0 
	CLRF        Currentprocess_StaticsChange_L0+0 
	CLRF        Currentprocess_buff_L0+0 
	CLRF        Currentprocess_buff_L0+1 
	CLRF        Currentprocess_buff_L0+2 
	CLRF        Currentprocess_buff_L0+3 
;Mainprocess.c,814 :: 		if(Statis_flag[ChannelNum] & STATIS_CURRENT)      //MaximumCurrent is blank
	MOVLW       _Statis_flag+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_Statis_flag+0)
	MOVWF       FSR0H 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	BTFSS       R1, 4 
	GOTO        L_Currentprocess188
;Mainprocess.c,816 :: 		Statis_flag[ChannelNum] &= ~STATIS_CURRENT;
	MOVLW       _Statis_flag+0
	MOVWF       R1 
	MOVLW       hi_addr(_Statis_flag+0)
	MOVWF       R2 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVLW       239
	ANDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,817 :: 		pSPCValue[ChannelNum].SPCStatistics.MaximumCurrent = pSPCValue[ChannelNum].SPCActual.Current_RMS;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       24
	ADDWF       R2, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R1 
	MOVLW       8
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       16
	ADDWF       R2, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,818 :: 		SystemUpdate |= (CH1_CURRENT_MAX_UPDATE_REQ << ChannelNum);
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       64
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Currentprocess516:
	BZ          L__Currentprocess517
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Currentprocess516
L__Currentprocess517:
	MOVF        R0, 0 
	IORWF       _SystemUpdate+0, 1 
	MOVF        R1, 0 
	IORWF       _SystemUpdate+1, 1 
	MOVF        R2, 0 
	IORWF       _SystemUpdate+2, 1 
	MOVF        R3, 0 
	IORWF       _SystemUpdate+3, 1 
;Mainprocess.c,819 :: 		SetCurrentStr((int*)&pSPCValue[ChannelNum].SPCStatistics.MaximumCurrent, CH1_ACTURAL_CURRENT_MAX+ChannelNum, UNIT_AMPER, 1);
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 0 
	MOVWF       FARG_SetCurrentStr_ptr+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_SetCurrentStr_ptr+1 
	MOVLW       24
	ADDWF       FARG_SetCurrentStr_ptr+0, 1 
	MOVLW       0
	ADDWFC      FARG_SetCurrentStr_ptr+1, 1 
	MOVLW       8
	ADDWF       FARG_SetCurrentStr_ptr+0, 1 
	MOVLW       0
	ADDWFC      FARG_SetCurrentStr_ptr+1, 1 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	ADDLW       20
	MOVWF       FARG_SetCurrentStr_strlocat+0 
	MOVLW       4
	MOVWF       FARG_SetCurrentStr_unitlocar+0 
	MOVLW       1
	MOVWF       FARG_SetCurrentStr_len+0 
	CALL        _SetCurrentStr+0, 0
;Mainprocess.c,820 :: 		StaticsChange = 1;
	MOVLW       1
	MOVWF       Currentprocess_StaticsChange_L0+0 
;Mainprocess.c,821 :: 		}
L_Currentprocess188:
;Mainprocess.c,823 :: 		if(Statis_flag[ChannelNum] & STATIS_GFI)          //MaximumGFCurrent is blank
	MOVLW       _Statis_flag+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_Statis_flag+0)
	MOVWF       FSR0H 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	BTFSS       R1, 5 
	GOTO        L_Currentprocess189
;Mainprocess.c,825 :: 		Statis_flag[ChannelNum] &= ~STATIS_GFI;
	MOVLW       _Statis_flag+0
	MOVWF       R1 
	MOVLW       hi_addr(_Statis_flag+0)
	MOVWF       R2 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVLW       223
	ANDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,826 :: 		pSPCValue[ChannelNum].SPCStatistics.MaximumGFCurrent = pSPCValue[ChannelNum].SPCActual.GFICurrent;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       24
	ADDWF       R2, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R1 
	MOVLW       10
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       18
	ADDWF       R2, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,827 :: 		SystemUpdate |= (CH1_GFI_MAX_UPDATE_REQ << ChannelNum);
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Currentprocess518:
	BZ          L__Currentprocess519
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Currentprocess518
L__Currentprocess519:
	MOVF        R0, 0 
	IORWF       _SystemUpdate+0, 1 
	MOVF        R1, 0 
	IORWF       _SystemUpdate+1, 1 
	MOVF        R2, 0 
	IORWF       _SystemUpdate+2, 1 
	MOVF        R3, 0 
	IORWF       _SystemUpdate+3, 1 
;Mainprocess.c,828 :: 		SetIntStr((int*)&pSPCValue[ChannelNum].SPCStatistics.MaximumGFCurrent, CH1_ACTURAL_GFI_MAX+ChannelNum, UNIT_MILIAMPER, 2);
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 0 
	MOVWF       FARG_SetIntStr_ptr+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_SetIntStr_ptr+1 
	MOVLW       24
	ADDWF       FARG_SetIntStr_ptr+0, 1 
	MOVLW       0
	ADDWFC      FARG_SetIntStr_ptr+1, 1 
	MOVLW       10
	ADDWF       FARG_SetIntStr_ptr+0, 1 
	MOVLW       0
	ADDWFC      FARG_SetIntStr_ptr+1, 1 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	ADDLW       22
	MOVWF       FARG_SetIntStr_strlocat+0 
	MOVLW       5
	MOVWF       FARG_SetIntStr_unitlocar+0 
	MOVLW       2
	MOVWF       FARG_SetIntStr_len+0 
	CALL        _SetIntStr+0, 0
;Mainprocess.c,829 :: 		StaticsChange = 1;
	MOVLW       1
	MOVWF       Currentprocess_StaticsChange_L0+0 
;Mainprocess.c,830 :: 		}
L_Currentprocess189:
;Mainprocess.c,832 :: 		if(pSPCValue[ChannelNum].SPCStatistics.MaximumCurrent < pSPCValue[ChannelNum].SPCActual.Current_RMS)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       24
	ADDWF       R2, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R1 
	MOVLW       8
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        POSTINC0+0, 0 
	MOVWF       R5 
	MOVLW       16
	ADDWF       R2, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R5, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Currentprocess520
	MOVF        R1, 0 
	SUBWF       R4, 0 
L__Currentprocess520:
	BTFSC       STATUS+0, 0 
	GOTO        L_Currentprocess190
;Mainprocess.c,834 :: 		pSPCValue[ChannelNum].SPCStatistics.MaximumCurrent = pSPCValue[ChannelNum].SPCActual.Current_RMS;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       24
	ADDWF       R2, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R1 
	MOVLW       8
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       16
	ADDWF       R2, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,835 :: 		SystemUpdate |= (CH1_CURRENT_MAX_UPDATE_REQ << ChannelNum);
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       64
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Currentprocess521:
	BZ          L__Currentprocess522
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Currentprocess521
L__Currentprocess522:
	MOVF        R0, 0 
	IORWF       _SystemUpdate+0, 1 
	MOVF        R1, 0 
	IORWF       _SystemUpdate+1, 1 
	MOVF        R2, 0 
	IORWF       _SystemUpdate+2, 1 
	MOVF        R3, 0 
	IORWF       _SystemUpdate+3, 1 
;Mainprocess.c,836 :: 		SetCurrentStr((int*)&pSPCValue[ChannelNum].SPCStatistics.MaximumCurrent, CH1_ACTURAL_CURRENT_MAX+ChannelNum, UNIT_AMPER, 1);
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 0 
	MOVWF       FARG_SetCurrentStr_ptr+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_SetCurrentStr_ptr+1 
	MOVLW       24
	ADDWF       FARG_SetCurrentStr_ptr+0, 1 
	MOVLW       0
	ADDWFC      FARG_SetCurrentStr_ptr+1, 1 
	MOVLW       8
	ADDWF       FARG_SetCurrentStr_ptr+0, 1 
	MOVLW       0
	ADDWFC      FARG_SetCurrentStr_ptr+1, 1 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	ADDLW       20
	MOVWF       FARG_SetCurrentStr_strlocat+0 
	MOVLW       4
	MOVWF       FARG_SetCurrentStr_unitlocar+0 
	MOVLW       1
	MOVWF       FARG_SetCurrentStr_len+0 
	CALL        _SetCurrentStr+0, 0
;Mainprocess.c,837 :: 		StaticsChange = 1;
	MOVLW       1
	MOVWF       Currentprocess_StaticsChange_L0+0 
;Mainprocess.c,838 :: 		}
L_Currentprocess190:
;Mainprocess.c,840 :: 		if(pSPCValue[ChannelNum].SPCStatistics.MaximumGFCurrent < pSPCValue[ChannelNum].SPCActual.GFICurrent)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       24
	ADDWF       R2, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R1 
	MOVLW       10
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        POSTINC0+0, 0 
	MOVWF       R5 
	MOVLW       18
	ADDWF       R2, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R5, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Currentprocess523
	MOVF        R1, 0 
	SUBWF       R4, 0 
L__Currentprocess523:
	BTFSC       STATUS+0, 0 
	GOTO        L_Currentprocess191
;Mainprocess.c,842 :: 		pSPCValue[ChannelNum].SPCStatistics.MaximumGFCurrent = pSPCValue[ChannelNum].SPCActual.GFICurrent;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       24
	ADDWF       R2, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R1 
	MOVLW       10
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       18
	ADDWF       R2, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,843 :: 		SystemUpdate |= (CH1_GFI_MAX_UPDATE_REQ << ChannelNum);
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Currentprocess524:
	BZ          L__Currentprocess525
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Currentprocess524
L__Currentprocess525:
	MOVF        R0, 0 
	IORWF       _SystemUpdate+0, 1 
	MOVF        R1, 0 
	IORWF       _SystemUpdate+1, 1 
	MOVF        R2, 0 
	IORWF       _SystemUpdate+2, 1 
	MOVF        R3, 0 
	IORWF       _SystemUpdate+3, 1 
;Mainprocess.c,844 :: 		SetIntStr((int*)&pSPCValue[ChannelNum].SPCStatistics.MaximumGFCurrent, CH1_ACTURAL_GFI_MAX+ChannelNum, UNIT_MILIAMPER, 2);
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 0 
	MOVWF       FARG_SetIntStr_ptr+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_SetIntStr_ptr+1 
	MOVLW       24
	ADDWF       FARG_SetIntStr_ptr+0, 1 
	MOVLW       0
	ADDWFC      FARG_SetIntStr_ptr+1, 1 
	MOVLW       10
	ADDWF       FARG_SetIntStr_ptr+0, 1 
	MOVLW       0
	ADDWFC      FARG_SetIntStr_ptr+1, 1 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	ADDLW       22
	MOVWF       FARG_SetIntStr_strlocat+0 
	MOVLW       5
	MOVWF       FARG_SetIntStr_unitlocar+0 
	MOVLW       2
	MOVWF       FARG_SetIntStr_len+0 
	CALL        _SetIntStr+0, 0
;Mainprocess.c,845 :: 		StaticsChange = 1;
	MOVLW       1
	MOVWF       Currentprocess_StaticsChange_L0+0 
;Mainprocess.c,846 :: 		}
L_Currentprocess191:
;Mainprocess.c,847 :: 		if(StaticsChange)
	MOVF        Currentprocess_StaticsChange_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Currentprocess192
;Mainprocess.c,848 :: 		EEPROM_set(0x01+2*sizeof(SPCSETPIONTS)+ChannelNum*sizeof(STATISTICS),sizeof(STATISTICS),(UCHAR*)(&pSPCValue[ChannelNum].SPCStatistics));
	MOVLW       30
	MULWF       FARG_Currentprocess_ChannelNum+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVLW       177
	ADDWF       R0, 0 
	MOVWF       FARG_EEPROM_set_EEPROM_WRITE_ADDRESS+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FARG_EEPROM_set_EEPROM_WRITE_ADDRESS+1 
	MOVLW       30
	MOVWF       FARG_EEPROM_set_Len+0 
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 0 
	MOVWF       FARG_EEPROM_set_writebuffer+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_EEPROM_set_writebuffer+1 
	MOVLW       24
	ADDWF       FARG_EEPROM_set_writebuffer+0, 1 
	MOVLW       0
	ADDWFC      FARG_EEPROM_set_writebuffer+1, 1 
	CALL        _EEPROM_set+0, 0
L_Currentprocess192:
;Mainprocess.c,852 :: 		if(SSRStatInMeas[ChannelNum] == RELAY_IS_OFF)
	MOVLW       _SSRStatInMeas+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_SSRStatInMeas+0)
	MOVWF       FSR0H 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Currentprocess193
;Mainprocess.c,854 :: 		buff = CH1_CONTINUEFAILALARM << ChannelNum;
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	MOVLW       64
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Currentprocess526:
	BZ          L__Currentprocess527
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Currentprocess526
L__Currentprocess527:
	MOVF        R0, 0 
	MOVWF       Currentprocess_buff_L0+0 
	MOVF        R1, 0 
	MOVWF       Currentprocess_buff_L0+1 
	MOVF        R2, 0 
	MOVWF       Currentprocess_buff_L0+2 
	MOVF        R3, 0 
	MOVWF       Currentprocess_buff_L0+3 
;Mainprocess.c,855 :: 		if(ActivedAlarms & buff)
	MOVF        Currentprocess_buff_L0+0, 0 
	ANDWF       _ActivedAlarms+0, 0 
	MOVWF       R0 
	MOVF        Currentprocess_buff_L0+1, 0 
	ANDWF       _ActivedAlarms+1, 0 
	MOVWF       R1 
	MOVF        Currentprocess_buff_L0+2, 0 
	ANDWF       _ActivedAlarms+2, 0 
	MOVWF       R2 
	MOVF        Currentprocess_buff_L0+3, 0 
	ANDWF       _ActivedAlarms+3, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_Currentprocess194
;Mainprocess.c,856 :: 		alarmoperate(buff << ChannelNum,DISALARM);
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVF        Currentprocess_buff_L0+0, 0 
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVF        Currentprocess_buff_L0+1, 0 
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVF        Currentprocess_buff_L0+2, 0 
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVF        Currentprocess_buff_L0+3, 0 
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Currentprocess528:
	BZ          L__Currentprocess529
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Currentprocess528
L__Currentprocess529:
	CLRF        FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Currentprocess194:
;Mainprocess.c,858 :: 		if(pSPCValue[ChannelNum].SPCActual.Current > 0)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       14
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Currentprocess530
	MOVF        R1, 0 
	SUBLW       0
L__Currentprocess530:
	BTFSC       STATUS+0, 0 
	GOTO        L_Currentprocess195
;Mainprocess.c,860 :: 		if(ShortFailCount[ChannelNum] <= 20)
	MOVLW       Currentprocess_ShortFailCount_L0+0
	MOVWF       FSR0 
	MOVLW       hi_addr(Currentprocess_ShortFailCount_L0+0)
	MOVWF       FSR0H 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	SUBLW       20
	BTFSS       STATUS+0, 0 
	GOTO        L_Currentprocess196
;Mainprocess.c,862 :: 		ShortFailCount[ChannelNum]++;
	MOVLW       Currentprocess_ShortFailCount_L0+0
	MOVWF       R1 
	MOVLW       hi_addr(Currentprocess_ShortFailCount_L0+0)
	MOVWF       R2 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVF        POSTINC0+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,863 :: 		}
	GOTO        L_Currentprocess197
L_Currentprocess196:
;Mainprocess.c,866 :: 		ShortFailCount[ChannelNum]=0;
	MOVLW       Currentprocess_ShortFailCount_L0+0
	MOVWF       FSR1 
	MOVLW       hi_addr(Currentprocess_ShortFailCount_L0+0)
	MOVWF       FSR1H 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;Mainprocess.c,867 :: 		if(!(ActivedAlarms & (CH1_FAILEDSHORTALARM << ChannelNum)))
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       1
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Currentprocess531:
	BZ          L__Currentprocess532
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Currentprocess531
L__Currentprocess532:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_Currentprocess198
;Mainprocess.c,868 :: 		alarmoperate(CH1_FAILEDSHORTALARM << ChannelNum,ENALARM);
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       1
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Currentprocess533:
	BZ          L__Currentprocess534
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Currentprocess533
L__Currentprocess534:
	MOVLW       1
	MOVWF       FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Currentprocess198:
;Mainprocess.c,869 :: 		}
L_Currentprocess197:
;Mainprocess.c,870 :: 		}
	GOTO        L_Currentprocess199
L_Currentprocess195:
;Mainprocess.c,873 :: 		ShortFailCount[ChannelNum]=0;
	MOVLW       Currentprocess_ShortFailCount_L0+0
	MOVWF       FSR1 
	MOVLW       hi_addr(Currentprocess_ShortFailCount_L0+0)
	MOVWF       FSR1H 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;Mainprocess.c,874 :: 		}
L_Currentprocess199:
;Mainprocess.c,875 :: 		}
	GOTO        L_Currentprocess200
L_Currentprocess193:
;Mainprocess.c,878 :: 		if(ActivedAlarms & (CH1_FAILEDSHORTALARM << ChannelNum))
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       1
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Currentprocess535:
	BZ          L__Currentprocess536
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Currentprocess535
L__Currentprocess536:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_Currentprocess201
;Mainprocess.c,879 :: 		alarmoperate(CH1_FAILEDSHORTALARM << ChannelNum,DISALARM);
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       1
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Currentprocess537:
	BZ          L__Currentprocess538
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Currentprocess537
L__Currentprocess538:
	CLRF        FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Currentprocess201:
;Mainprocess.c,881 :: 		if(pSPCValue[ChannelNum].SPCActual.Current == 0)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       14
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Currentprocess539
	MOVLW       0
	XORWF       R1, 0 
L__Currentprocess539:
	BTFSS       STATUS+0, 2 
	GOTO        L_Currentprocess202
;Mainprocess.c,883 :: 		if(CountinueFailCount[ChannelNum] <= 20)
	MOVLW       Currentprocess_CountinueFailCount_L0+0
	MOVWF       FSR0 
	MOVLW       hi_addr(Currentprocess_CountinueFailCount_L0+0)
	MOVWF       FSR0H 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	SUBLW       20
	BTFSS       STATUS+0, 0 
	GOTO        L_Currentprocess203
;Mainprocess.c,885 :: 		CountinueFailCount[ChannelNum]++;
	MOVLW       Currentprocess_CountinueFailCount_L0+0
	MOVWF       R1 
	MOVLW       hi_addr(Currentprocess_CountinueFailCount_L0+0)
	MOVWF       R2 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVF        POSTINC0+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,886 :: 		}
	GOTO        L_Currentprocess204
L_Currentprocess203:
;Mainprocess.c,889 :: 		CountinueFailCount[ChannelNum] = 0;
	MOVLW       Currentprocess_CountinueFailCount_L0+0
	MOVWF       FSR1 
	MOVLW       hi_addr(Currentprocess_CountinueFailCount_L0+0)
	MOVWF       FSR1H 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;Mainprocess.c,890 :: 		if(!(ActivedAlarms & (CH1_CONTINUEFAILALARM << ChannelNum)))
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	MOVLW       64
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Currentprocess540:
	BZ          L__Currentprocess541
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Currentprocess540
L__Currentprocess541:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_Currentprocess205
;Mainprocess.c,891 :: 		alarmoperate(CH1_CONTINUEFAILALARM << ChannelNum,ENALARM);
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       64
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Currentprocess542:
	BZ          L__Currentprocess543
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Currentprocess542
L__Currentprocess543:
	MOVLW       1
	MOVWF       FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Currentprocess205:
;Mainprocess.c,892 :: 		}
L_Currentprocess204:
;Mainprocess.c,893 :: 		}
	GOTO        L_Currentprocess206
L_Currentprocess202:
;Mainprocess.c,896 :: 		CountinueFailCount[ChannelNum] = 0;
	MOVLW       Currentprocess_CountinueFailCount_L0+0
	MOVWF       FSR1 
	MOVLW       hi_addr(Currentprocess_CountinueFailCount_L0+0)
	MOVWF       FSR1H 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;Mainprocess.c,897 :: 		}
L_Currentprocess206:
;Mainprocess.c,898 :: 		}
L_Currentprocess200:
;Mainprocess.c,900 :: 		if(SSRStatInMeas[ChannelNum] == RELAY_IS_OFF)
	MOVLW       _SSRStatInMeas+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_SSRStatInMeas+0)
	MOVWF       FSR0H 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Currentprocess207
;Mainprocess.c,902 :: 		if(ActivedAlarms & (CH1_LOWCURRENTALARM << ChannelNum))
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       16
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Currentprocess544:
	BZ          L__Currentprocess545
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Currentprocess544
L__Currentprocess545:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_Currentprocess208
;Mainprocess.c,903 :: 		alarmoperate(CH1_LOWCURRENTALARM << ChannelNum,DISALARM);
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       16
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Currentprocess546:
	BZ          L__Currentprocess547
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Currentprocess546
L__Currentprocess547:
	CLRF        FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Currentprocess208:
;Mainprocess.c,905 :: 		if(ActivedAlarms & (CH1_HIGHCURRENTALARM << ChannelNum))
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       64
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Currentprocess548:
	BZ          L__Currentprocess549
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Currentprocess548
L__Currentprocess549:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_Currentprocess209
;Mainprocess.c,906 :: 		alarmoperate(CH1_HIGHCURRENTALARM << ChannelNum,DISALARM);
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       64
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Currentprocess550:
	BZ          L__Currentprocess551
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Currentprocess550
L__Currentprocess551:
	CLRF        FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Currentprocess209:
;Mainprocess.c,907 :: 		}
	GOTO        L_Currentprocess210
L_Currentprocess207:
;Mainprocess.c,910 :: 		if(pSPCValue[ChannelNum].SPCSetPoints.LowCurrent != SPC_SYSTEMVALUE_OFF)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
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
	MOVLW       16
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__Currentprocess552
	MOVLW       255
	XORWF       R1, 0 
L__Currentprocess552:
	BTFSC       STATUS+0, 2 
	GOTO        L_Currentprocess211
;Mainprocess.c,912 :: 		if(pSPCValue[ChannelNum].SPCActual.Current < pSPCValue[ChannelNum].SPCSetPoints.LowCurrent)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       14
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       54
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       16
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R4, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Currentprocess553
	MOVF        R1, 0 
	SUBWF       R3, 0 
L__Currentprocess553:
	BTFSC       STATUS+0, 0 
	GOTO        L_Currentprocess212
;Mainprocess.c,914 :: 		if(!(ActivedAlarms & (CH1_LOWCURRENTALARM << ChannelNum)))
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       16
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Currentprocess554:
	BZ          L__Currentprocess555
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Currentprocess554
L__Currentprocess555:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_Currentprocess213
;Mainprocess.c,915 :: 		alarmoperate(CH1_LOWCURRENTALARM << ChannelNum,ENALARM);
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       16
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Currentprocess556:
	BZ          L__Currentprocess557
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Currentprocess556
L__Currentprocess557:
	MOVLW       1
	MOVWF       FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Currentprocess213:
;Mainprocess.c,916 :: 		}
	GOTO        L_Currentprocess214
L_Currentprocess212:
;Mainprocess.c,919 :: 		if(ActivedAlarms & (CH1_LOWCURRENTALARM << ChannelNum))
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       16
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Currentprocess558:
	BZ          L__Currentprocess559
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Currentprocess558
L__Currentprocess559:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_Currentprocess215
;Mainprocess.c,920 :: 		alarmoperate(CH1_LOWCURRENTALARM << ChannelNum,DISALARM);
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       16
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Currentprocess560:
	BZ          L__Currentprocess561
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Currentprocess560
L__Currentprocess561:
	CLRF        FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Currentprocess215:
;Mainprocess.c,921 :: 		}
L_Currentprocess214:
;Mainprocess.c,922 :: 		}
	GOTO        L_Currentprocess216
L_Currentprocess211:
;Mainprocess.c,925 :: 		if(ActivedAlarms & (CH1_LOWCURRENTALARM << ChannelNum))
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       16
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Currentprocess562:
	BZ          L__Currentprocess563
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Currentprocess562
L__Currentprocess563:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_Currentprocess217
;Mainprocess.c,926 :: 		alarmoperate(CH1_LOWCURRENTALARM << ChannelNum,DISALARM);
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       16
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Currentprocess564:
	BZ          L__Currentprocess565
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Currentprocess564
L__Currentprocess565:
	CLRF        FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Currentprocess217:
;Mainprocess.c,927 :: 		}
L_Currentprocess216:
;Mainprocess.c,929 :: 		if(pSPCValue[ChannelNum].SPCSetPoints.HighCurrent != SPC_SYSTEMVALUE_OFF)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
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
	MOVLW       18
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__Currentprocess566
	MOVLW       255
	XORWF       R1, 0 
L__Currentprocess566:
	BTFSC       STATUS+0, 2 
	GOTO        L_Currentprocess218
;Mainprocess.c,931 :: 		if(pSPCValue[ChannelNum].SPCActual.Current > pSPCValue[ChannelNum].SPCSetPoints.HighCurrent)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       14
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       54
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       18
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R4, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Currentprocess567
	MOVF        R3, 0 
	SUBWF       R1, 0 
L__Currentprocess567:
	BTFSC       STATUS+0, 0 
	GOTO        L_Currentprocess219
;Mainprocess.c,933 :: 		EnableHighCurrentAlarmCount(ChannelNum);
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       FARG_EnableHighCurrentAlarmCount_ChannelNum+0 
	CALL        _EnableHighCurrentAlarmCount+0, 0
;Mainprocess.c,934 :: 		}
	GOTO        L_Currentprocess220
L_Currentprocess219:
;Mainprocess.c,937 :: 		DisableHighCurrentAlarmCount(ChannelNum);
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       FARG_DisableHighCurrentAlarmCount_ChannelNum+0 
	CALL        _DisableHighCurrentAlarmCount+0, 0
;Mainprocess.c,938 :: 		if(ActivedAlarms & (CH1_HIGHCURRENTALARM << ChannelNum))
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       64
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Currentprocess568:
	BZ          L__Currentprocess569
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Currentprocess568
L__Currentprocess569:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_Currentprocess221
;Mainprocess.c,939 :: 		alarmoperate(CH1_HIGHCURRENTALARM << ChannelNum,DISALARM);
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       64
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Currentprocess570:
	BZ          L__Currentprocess571
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Currentprocess570
L__Currentprocess571:
	CLRF        FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Currentprocess221:
;Mainprocess.c,940 :: 		}
L_Currentprocess220:
;Mainprocess.c,941 :: 		}
	GOTO        L_Currentprocess222
L_Currentprocess218:
;Mainprocess.c,944 :: 		DisableHighCurrentAlarmCount(ChannelNum);
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       FARG_DisableHighCurrentAlarmCount_ChannelNum+0 
	CALL        _DisableHighCurrentAlarmCount+0, 0
;Mainprocess.c,945 :: 		if(ActivedAlarms & (CH1_HIGHCURRENTALARM << ChannelNum))
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       64
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Currentprocess572:
	BZ          L__Currentprocess573
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Currentprocess572
L__Currentprocess573:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_Currentprocess223
;Mainprocess.c,946 :: 		alarmoperate(CH1_HIGHCURRENTALARM << ChannelNum,DISALARM);
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       64
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Currentprocess574:
	BZ          L__Currentprocess575
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Currentprocess574
L__Currentprocess575:
	CLRF        FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Currentprocess223:
;Mainprocess.c,947 :: 		}
L_Currentprocess222:
;Mainprocess.c,950 :: 		if(GFITestCmd[ChannelNum] == 1)
	MOVLW       _GFITestCmd+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_GFITestCmd+0)
	MOVWF       FSR0H 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Currentprocess224
;Mainprocess.c,951 :: 		GFITestbuff = 30;
	MOVLW       30
	MOVWF       Currentprocess_GFITestbuff_L0+0 
	MOVLW       0
	MOVWF       Currentprocess_GFITestbuff_L0+1 
	GOTO        L_Currentprocess225
L_Currentprocess224:
;Mainprocess.c,953 :: 		GFITestbuff = pSPCValue[ChannelNum].SPCSetPoints.GFITrip;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
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
	MOVLW       22
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       Currentprocess_GFITestbuff_L0+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       Currentprocess_GFITestbuff_L0+1 
L_Currentprocess225:
;Mainprocess.c,955 :: 		if(GFITestbuff != SPC_SYSTEMVALUE_OFF)
	MOVF        Currentprocess_GFITestbuff_L0+1, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__Currentprocess576
	MOVLW       255
	XORWF       Currentprocess_GFITestbuff_L0+0, 0 
L__Currentprocess576:
	BTFSC       STATUS+0, 2 
	GOTO        L_Currentprocess226
;Mainprocess.c,957 :: 		if(pSPCValue[ChannelNum].SPCActual.GFICurrent > GFITestbuff)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       18
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	SUBWF       Currentprocess_GFITestbuff_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Currentprocess577
	MOVF        R1, 0 
	SUBWF       Currentprocess_GFITestbuff_L0+0, 0 
L__Currentprocess577:
	BTFSC       STATUS+0, 0 
	GOTO        L_Currentprocess227
;Mainprocess.c,959 :: 		if((pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.gfi_test_mod == GFI_TEST_AUTO) &&
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
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
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVLW       3
	ANDWF       POSTINC0+0, 0 
	MOVWF       R1 
;Mainprocess.c,960 :: 		(AutoGFITestEN[ChannelNum] == 1))
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Currentprocess230
	MOVLW       _AutoGFITestEN+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_AutoGFITestEN+0)
	MOVWF       FSR0H 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Currentprocess230
L__Currentprocess327:
;Mainprocess.c,962 :: 		AutoGFITestPass[ChannelNum] = 1;
	MOVLW       _AutoGFITestPass+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_AutoGFITestPass+0)
	MOVWF       FSR1H 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       1
	MOVWF       POSTINC1+0 
;Mainprocess.c,964 :: 		if(ChannelNum == CHANNEL1)
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Currentprocess231
;Mainprocess.c,965 :: 		LATF2_bit = 1;
	BSF         LATF2_bit+0, BitPos(LATF2_bit+0) 
	GOTO        L_Currentprocess232
L_Currentprocess231:
;Mainprocess.c,966 :: 		else if(ChannelNum == CHANNEL2)
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Currentprocess233
;Mainprocess.c,967 :: 		LATF1_bit = 1;
	BSF         LATF1_bit+0, BitPos(LATF1_bit+0) 
L_Currentprocess233:
L_Currentprocess232:
;Mainprocess.c,968 :: 		ForceSSROFFCondition[ChannelNum] |= GFITRIPFORCEOFF;
	MOVLW       _ForceSSROFFCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSROFFCondition+0)
	MOVWF       R2 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVLW       1
	IORWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,969 :: 		}
	GOTO        L_Currentprocess234
L_Currentprocess230:
;Mainprocess.c,970 :: 		else if((pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.gfi_test_mod == GFI_TEST_NOW) &&
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
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
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVLW       3
	ANDWF       POSTINC0+0, 0 
	MOVWF       R1 
;Mainprocess.c,971 :: 		(GFITestCmd[ChannelNum] == 1))
	MOVF        R1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Currentprocess237
	MOVLW       _GFITestCmd+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_GFITestCmd+0)
	MOVWF       FSR0H 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Currentprocess237
L__Currentprocess326:
;Mainprocess.c,973 :: 		GFITestPass[ChannelNum] = 1;
	MOVLW       _GFITestPass+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_GFITestPass+0)
	MOVWF       FSR1H 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       1
	MOVWF       POSTINC1+0 
;Mainprocess.c,975 :: 		if(ChannelNum == CHANNEL1)
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Currentprocess238
;Mainprocess.c,976 :: 		LATF2_bit = 1;
	BSF         LATF2_bit+0, BitPos(LATF2_bit+0) 
	GOTO        L_Currentprocess239
L_Currentprocess238:
;Mainprocess.c,977 :: 		else if(ChannelNum == CHANNEL2)
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Currentprocess240
;Mainprocess.c,978 :: 		LATF1_bit = 1;
	BSF         LATF1_bit+0, BitPos(LATF1_bit+0) 
L_Currentprocess240:
L_Currentprocess239:
;Mainprocess.c,979 :: 		ForceSSROFFCondition[ChannelNum] |= GFITRIPFORCEOFF;
	MOVLW       _ForceSSROFFCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSROFFCondition+0)
	MOVWF       R2 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVLW       1
	IORWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,980 :: 		}
	GOTO        L_Currentprocess241
L_Currentprocess237:
;Mainprocess.c,984 :: 		if(ChannelNum == CHANNEL1)
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Currentprocess242
;Mainprocess.c,985 :: 		LATF2_bit = 1;
	BSF         LATF2_bit+0, BitPos(LATF2_bit+0) 
	GOTO        L_Currentprocess243
L_Currentprocess242:
;Mainprocess.c,986 :: 		else if(ChannelNum == CHANNEL2)
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Currentprocess244
;Mainprocess.c,987 :: 		LATF1_bit = 1;
	BSF         LATF1_bit+0, BitPos(LATF1_bit+0) 
L_Currentprocess244:
L_Currentprocess243:
;Mainprocess.c,988 :: 		ForceSSROFFCondition[ChannelNum] |= GFITRIPFORCEOFF;
	MOVLW       _ForceSSROFFCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSROFFCondition+0)
	MOVWF       R2 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVLW       1
	IORWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,990 :: 		if(!(ActivedAlarms & (CH1_GFITRIP << ChannelNum)))
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	MOVLW       4
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Currentprocess578:
	BZ          L__Currentprocess579
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Currentprocess578
L__Currentprocess579:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_Currentprocess245
;Mainprocess.c,992 :: 		if(ActivedAlarms & (CH1_GFIALARM << ChannelNum))
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Currentprocess580:
	BZ          L__Currentprocess581
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Currentprocess580
L__Currentprocess581:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_Currentprocess246
;Mainprocess.c,993 :: 		alarmoperate(CH1_GFIALARM << ChannelNum,DISALARM);
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       1
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Currentprocess582:
	BZ          L__Currentprocess583
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Currentprocess582
L__Currentprocess583:
	CLRF        FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Currentprocess246:
;Mainprocess.c,995 :: 		alarmoperate(CH1_GFITRIP << ChannelNum,ENALARM);
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       4
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Currentprocess584:
	BZ          L__Currentprocess585
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Currentprocess584
L__Currentprocess585:
	MOVLW       1
	MOVWF       FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
;Mainprocess.c,996 :: 		}
L_Currentprocess245:
;Mainprocess.c,997 :: 		}
L_Currentprocess241:
L_Currentprocess234:
;Mainprocess.c,998 :: 		}
	GOTO        L_Currentprocess247
L_Currentprocess227:
;Mainprocess.c,1000 :: 		GFIAlarmFlag |= TRIPNOTHAPPEN;
	BSF         Currentprocess_GFIAlarmFlag_L0+0, 1 
L_Currentprocess247:
;Mainprocess.c,1001 :: 		}
	GOTO        L_Currentprocess248
L_Currentprocess226:
;Mainprocess.c,1003 :: 		GFIAlarmFlag |= TRIPNOTHAPPEN;
	BSF         Currentprocess_GFIAlarmFlag_L0+0, 1 
L_Currentprocess248:
;Mainprocess.c,1005 :: 		if(pSPCValue[ChannelNum].SPCSetPoints.GFIAlarm != SPC_SYSTEMVALUE_OFF)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
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
	MOVLW       20
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__Currentprocess586
	MOVLW       255
	XORWF       R1, 0 
L__Currentprocess586:
	BTFSC       STATUS+0, 2 
	GOTO        L_Currentprocess249
;Mainprocess.c,1007 :: 		if(pSPCValue[ChannelNum].SPCActual.GFICurrent > pSPCValue[ChannelNum].SPCSetPoints.GFIAlarm)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       18
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       54
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       20
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R4, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Currentprocess587
	MOVF        R3, 0 
	SUBWF       R1, 0 
L__Currentprocess587:
	BTFSC       STATUS+0, 0 
	GOTO        L_Currentprocess250
;Mainprocess.c,1009 :: 		if((pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.gfi_test_mod == GFI_TEST_AUTO) &&
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
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
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVLW       3
	ANDWF       POSTINC0+0, 0 
	MOVWF       R1 
;Mainprocess.c,1010 :: 		(AutoGFITestEN[ChannelNum] == 1))
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Currentprocess253
	MOVLW       _AutoGFITestEN+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_AutoGFITestEN+0)
	MOVWF       FSR0H 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Currentprocess253
L__Currentprocess325:
;Mainprocess.c,1012 :: 		asm nop;
	NOP
;Mainprocess.c,1013 :: 		}
	GOTO        L_Currentprocess254
L_Currentprocess253:
;Mainprocess.c,1014 :: 		else if((pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.gfi_test_mod == GFI_TEST_NOW) &&
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
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
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVLW       3
	ANDWF       POSTINC0+0, 0 
	MOVWF       R1 
;Mainprocess.c,1015 :: 		(GFITestCmd[ChannelNum] == 1))
	MOVF        R1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Currentprocess257
	MOVLW       _GFITestCmd+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_GFITestCmd+0)
	MOVWF       FSR0H 
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Currentprocess257
L__Currentprocess324:
;Mainprocess.c,1017 :: 		asm nop;
	NOP
;Mainprocess.c,1018 :: 		}
	GOTO        L_Currentprocess258
L_Currentprocess257:
;Mainprocess.c,1019 :: 		else if(!(ActivedAlarms & (CH1_GFITRIP << ChannelNum)))
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	MOVLW       4
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Currentprocess588:
	BZ          L__Currentprocess589
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Currentprocess588
L__Currentprocess589:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_Currentprocess259
;Mainprocess.c,1021 :: 		if(!(ActivedAlarms & (CH1_GFIALARM << ChannelNum)))
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Currentprocess590:
	BZ          L__Currentprocess591
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Currentprocess590
L__Currentprocess591:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_Currentprocess260
;Mainprocess.c,1022 :: 		alarmoperate(CH1_GFIALARM << ChannelNum,ENALARM);
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       1
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Currentprocess592:
	BZ          L__Currentprocess593
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Currentprocess592
L__Currentprocess593:
	MOVLW       1
	MOVWF       FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Currentprocess260:
;Mainprocess.c,1023 :: 		}
L_Currentprocess259:
L_Currentprocess258:
L_Currentprocess254:
;Mainprocess.c,1024 :: 		}
	GOTO        L_Currentprocess261
L_Currentprocess250:
;Mainprocess.c,1026 :: 		GFIAlarmFlag |= ALARMNOTHAPPEN;
	BSF         Currentprocess_GFIAlarmFlag_L0+0, 0 
L_Currentprocess261:
;Mainprocess.c,1027 :: 		}
	GOTO        L_Currentprocess262
L_Currentprocess249:
;Mainprocess.c,1029 :: 		GFIAlarmFlag |= ALARMNOTHAPPEN;
	BSF         Currentprocess_GFIAlarmFlag_L0+0, 0 
L_Currentprocess262:
;Mainprocess.c,1031 :: 		if((GFIAlarmFlag & ALARMNOTHAPPEN) && (GFIAlarmFlag & TRIPNOTHAPPEN))
	BTFSS       Currentprocess_GFIAlarmFlag_L0+0, 0 
	GOTO        L_Currentprocess265
	BTFSS       Currentprocess_GFIAlarmFlag_L0+0, 1 
	GOTO        L_Currentprocess265
L__Currentprocess323:
;Mainprocess.c,1033 :: 		if(!(ActivedAlarms & (CH1_GFITRIP << ChannelNum)))
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	MOVLW       4
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Currentprocess594:
	BZ          L__Currentprocess595
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Currentprocess594
L__Currentprocess595:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_Currentprocess266
;Mainprocess.c,1035 :: 		if(ActivedAlarms & (CH1_GFIALARM << ChannelNum))
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Currentprocess596:
	BZ          L__Currentprocess597
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Currentprocess596
L__Currentprocess597:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_Currentprocess267
;Mainprocess.c,1036 :: 		alarmoperate(CH1_GFIALARM << ChannelNum,DISALARM);
	MOVF        FARG_Currentprocess_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       1
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__Currentprocess598:
	BZ          L__Currentprocess599
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__Currentprocess598
L__Currentprocess599:
	CLRF        FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Currentprocess267:
;Mainprocess.c,1037 :: 		}
L_Currentprocess266:
;Mainprocess.c,1038 :: 		}
L_Currentprocess265:
;Mainprocess.c,1039 :: 		}
L_Currentprocess210:
;Mainprocess.c,1040 :: 		}
L_end_Currentprocess:
	RETURN      0
; end of _Currentprocess

_ActivateHighCurrentAlarm:

;Mainprocess.c,1042 :: 		void ActivateHighCurrentAlarm(char ChannelNum)
;Mainprocess.c,1044 :: 		if(HighCurrentEn[ChannelNum] == 2)
	MOVLW       _HighCurrentEn+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_HighCurrentEn+0)
	MOVWF       FSR0H 
	MOVF        FARG_ActivateHighCurrentAlarm_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_ActivateHighCurrentAlarm268
;Mainprocess.c,1046 :: 		HighCurrentEn[ChannelNum] = 0;
	MOVLW       _HighCurrentEn+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_HighCurrentEn+0)
	MOVWF       FSR1H 
	MOVF        FARG_ActivateHighCurrentAlarm_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;Mainprocess.c,1047 :: 		if(!(ActivedAlarms & (CH1_HIGHCURRENTALARM << ChannelNum)))
	MOVF        FARG_ActivateHighCurrentAlarm_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       64
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__ActivateHighCurrentAlarm601:
	BZ          L__ActivateHighCurrentAlarm602
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__ActivateHighCurrentAlarm601
L__ActivateHighCurrentAlarm602:
	MOVF        _ActivedAlarms+0, 0 
	ANDWF       R0, 1 
	MOVF        _ActivedAlarms+1, 0 
	ANDWF       R1, 1 
	MOVF        _ActivedAlarms+2, 0 
	ANDWF       R2, 1 
	MOVF        _ActivedAlarms+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_ActivateHighCurrentAlarm269
;Mainprocess.c,1048 :: 		alarmoperate(CH1_HIGHCURRENTALARM << ChannelNum,ENALARM);
	MOVF        FARG_ActivateHighCurrentAlarm_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       64
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__ActivateHighCurrentAlarm603:
	BZ          L__ActivateHighCurrentAlarm604
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__ActivateHighCurrentAlarm603
L__ActivateHighCurrentAlarm604:
	MOVLW       1
	MOVWF       FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_ActivateHighCurrentAlarm269:
;Mainprocess.c,1049 :: 		}
L_ActivateHighCurrentAlarm268:
;Mainprocess.c,1050 :: 		}
L_end_ActivateHighCurrentAlarm:
	RETURN      0
; end of _ActivateHighCurrentAlarm

_Voltprocess:

;Mainprocess.c,1057 :: 		void Voltprocess()
;Mainprocess.c,1059 :: 		char StaticsChange=0;
	CLRF        Voltprocess_StaticsChange_L0+0 
;Mainprocess.c,1061 :: 		Getvoltage();
	CALL        _Getvoltage+0, 0
;Mainprocess.c,1062 :: 		if(pSPCValue[0].SPCActual.Voltage > MAX_SPCVOLT)
	MOVLW       128
	XORLW       1
	MOVWF       R0 
	MOVLW       128
	XORWF       _pSPCValue+21, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Voltprocess606
	MOVF        _pSPCValue+20, 0 
	SUBLW       24
L__Voltprocess606:
	BTFSC       STATUS+0, 0 
	GOTO        L_Voltprocess270
;Mainprocess.c,1064 :: 		pSPCValue[0].SPCActual.Voltage = OUTOFRANGE;
	MOVLW       254
	MOVWF       _pSPCValue+20 
	MOVLW       127
	MOVWF       _pSPCValue+21 
;Mainprocess.c,1065 :: 		}
L_Voltprocess270:
;Mainprocess.c,1067 :: 		spc_system_flag.bite.meas_VT_reach &= 0xfe;
	MOVLW       6
	ANDWF       _spc_system_flag+0, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	BCF         R1, 7 
	MOVLW       254
	ANDWF       R1, 0 
	MOVWF       R2 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       R1 
	MOVF        R2, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__Voltprocess607:
	BZ          L__Voltprocess608
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__Voltprocess607
L__Voltprocess608:
	MOVF        _spc_system_flag+0, 0 
	XORWF       R0, 1 
	MOVLW       6
	ANDWF       R0, 1 
	MOVF        _spc_system_flag+0, 0 
	XORWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _spc_system_flag+0 
;Mainprocess.c,1069 :: 		SystemUpdate |= VOLTAGE_UPDATE_REQ;
	BSF         _SystemUpdate+3, 0 
;Mainprocess.c,1070 :: 		SetIntStr((int*)&pSPCValue[0].SPCActual.Voltage, ACTURAL_VOLT, UNIT_ACVOLT, 1);
	MOVLW       _pSPCValue+20
	MOVWF       FARG_SetIntStr_ptr+0 
	MOVLW       hi_addr(_pSPCValue+20)
	MOVWF       FARG_SetIntStr_ptr+1 
	MOVLW       30
	MOVWF       FARG_SetIntStr_strlocat+0 
	MOVLW       6
	MOVWF       FARG_SetIntStr_unitlocar+0 
	MOVLW       1
	MOVWF       FARG_SetIntStr_len+0 
	CALL        _SetIntStr+0, 0
;Mainprocess.c,1074 :: 		if(Statis_flag[0] & STATIS_MAX_VOLT)
	BTFSS       _Statis_flag+0, 2 
	GOTO        L_Voltprocess271
;Mainprocess.c,1076 :: 		Statis_flag[0] &= ~STATIS_MAX_VOLT;
	BCF         _Statis_flag+0, 2 
;Mainprocess.c,1077 :: 		pSPCValue[0].SPCStatistics.MaximumVoltage = pSPCValue[0].SPCActual.Voltage;
	MOVF        _pSPCValue+20, 0 
	MOVWF       _pSPCValue+36 
	MOVF        _pSPCValue+21, 0 
	MOVWF       _pSPCValue+37 
;Mainprocess.c,1078 :: 		SystemUpdate |= VOLTAGE_MAX_UPDATE_REQ;
	BSF         _SystemUpdate+3, 1 
;Mainprocess.c,1079 :: 		SetIntStr((int*)&pSPCValue[0].SPCStatistics.MaximumVoltage, ACTURAL_VOLT_MAX, UNIT_ACVOLT, 1);
	MOVLW       _pSPCValue+36
	MOVWF       FARG_SetIntStr_ptr+0 
	MOVLW       hi_addr(_pSPCValue+36)
	MOVWF       FARG_SetIntStr_ptr+1 
	MOVLW       32
	MOVWF       FARG_SetIntStr_strlocat+0 
	MOVLW       6
	MOVWF       FARG_SetIntStr_unitlocar+0 
	MOVLW       1
	MOVWF       FARG_SetIntStr_len+0 
	CALL        _SetIntStr+0, 0
;Mainprocess.c,1080 :: 		StaticsChange = 1;
	MOVLW       1
	MOVWF       Voltprocess_StaticsChange_L0+0 
;Mainprocess.c,1081 :: 		}
L_Voltprocess271:
;Mainprocess.c,1082 :: 		if(Statis_flag[0] & STATIS_MIN_VOLT)
	BTFSS       _Statis_flag+0, 3 
	GOTO        L_Voltprocess272
;Mainprocess.c,1084 :: 		Statis_flag[0] &= ~STATIS_MIN_VOLT;
	BCF         _Statis_flag+0, 3 
;Mainprocess.c,1085 :: 		pSPCValue[0].SPCStatistics.MinimumVoltage = pSPCValue[0].SPCActual.Voltage;
	MOVF        _pSPCValue+20, 0 
	MOVWF       _pSPCValue+38 
	MOVF        _pSPCValue+21, 0 
	MOVWF       _pSPCValue+39 
;Mainprocess.c,1086 :: 		SystemUpdate |= VOLTAGE_MIN_UPDATE_REQ;
	BSF         _SystemUpdate+3, 2 
;Mainprocess.c,1087 :: 		SetIntStr((int*)&pSPCValue[0].SPCStatistics.MinimumVoltage, ACTURAL_VOLT_MIN, UNIT_ACVOLT, 1);
	MOVLW       _pSPCValue+38
	MOVWF       FARG_SetIntStr_ptr+0 
	MOVLW       hi_addr(_pSPCValue+38)
	MOVWF       FARG_SetIntStr_ptr+1 
	MOVLW       34
	MOVWF       FARG_SetIntStr_strlocat+0 
	MOVLW       6
	MOVWF       FARG_SetIntStr_unitlocar+0 
	MOVLW       1
	MOVWF       FARG_SetIntStr_len+0 
	CALL        _SetIntStr+0, 0
;Mainprocess.c,1088 :: 		StaticsChange = 1;
	MOVLW       1
	MOVWF       Voltprocess_StaticsChange_L0+0 
;Mainprocess.c,1089 :: 		}
L_Voltprocess272:
;Mainprocess.c,1090 :: 		if(pSPCValue[0].SPCActual.Voltage > pSPCValue[0].SPCStatistics.MaximumVoltage)
	MOVLW       128
	XORWF       _pSPCValue+37, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _pSPCValue+21, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Voltprocess609
	MOVF        _pSPCValue+20, 0 
	SUBWF       _pSPCValue+36, 0 
L__Voltprocess609:
	BTFSC       STATUS+0, 0 
	GOTO        L_Voltprocess273
;Mainprocess.c,1092 :: 		pSPCValue[0].SPCStatistics.MaximumVoltage = pSPCValue[0].SPCActual.Voltage;
	MOVF        _pSPCValue+20, 0 
	MOVWF       _pSPCValue+36 
	MOVF        _pSPCValue+21, 0 
	MOVWF       _pSPCValue+37 
;Mainprocess.c,1093 :: 		SystemUpdate |= VOLTAGE_MAX_UPDATE_REQ;
	BSF         _SystemUpdate+3, 1 
;Mainprocess.c,1094 :: 		SetIntStr((int*)&pSPCValue[0].SPCStatistics.MaximumVoltage, ACTURAL_VOLT_MAX, UNIT_ACVOLT, 1);
	MOVLW       _pSPCValue+36
	MOVWF       FARG_SetIntStr_ptr+0 
	MOVLW       hi_addr(_pSPCValue+36)
	MOVWF       FARG_SetIntStr_ptr+1 
	MOVLW       32
	MOVWF       FARG_SetIntStr_strlocat+0 
	MOVLW       6
	MOVWF       FARG_SetIntStr_unitlocar+0 
	MOVLW       1
	MOVWF       FARG_SetIntStr_len+0 
	CALL        _SetIntStr+0, 0
;Mainprocess.c,1095 :: 		StaticsChange = 1;
	MOVLW       1
	MOVWF       Voltprocess_StaticsChange_L0+0 
;Mainprocess.c,1096 :: 		}
	GOTO        L_Voltprocess274
L_Voltprocess273:
;Mainprocess.c,1097 :: 		else if(pSPCValue[0].SPCActual.Voltage < pSPCValue[0].SPCStatistics.MinimumVoltage)
	MOVLW       128
	XORWF       _pSPCValue+21, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _pSPCValue+39, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Voltprocess610
	MOVF        _pSPCValue+38, 0 
	SUBWF       _pSPCValue+20, 0 
L__Voltprocess610:
	BTFSC       STATUS+0, 0 
	GOTO        L_Voltprocess275
;Mainprocess.c,1099 :: 		pSPCValue[0].SPCStatistics.MinimumVoltage = pSPCValue[0].SPCActual.Voltage;
	MOVF        _pSPCValue+20, 0 
	MOVWF       _pSPCValue+38 
	MOVF        _pSPCValue+21, 0 
	MOVWF       _pSPCValue+39 
;Mainprocess.c,1100 :: 		SystemUpdate |= VOLTAGE_MIN_UPDATE_REQ;
	BSF         _SystemUpdate+3, 2 
;Mainprocess.c,1101 :: 		SetIntStr((int*)&pSPCValue[0].SPCStatistics.MinimumVoltage, ACTURAL_VOLT_MIN, UNIT_ACVOLT, 1);
	MOVLW       _pSPCValue+38
	MOVWF       FARG_SetIntStr_ptr+0 
	MOVLW       hi_addr(_pSPCValue+38)
	MOVWF       FARG_SetIntStr_ptr+1 
	MOVLW       34
	MOVWF       FARG_SetIntStr_strlocat+0 
	MOVLW       6
	MOVWF       FARG_SetIntStr_unitlocar+0 
	MOVLW       1
	MOVWF       FARG_SetIntStr_len+0 
	CALL        _SetIntStr+0, 0
;Mainprocess.c,1102 :: 		StaticsChange = 1;
	MOVLW       1
	MOVWF       Voltprocess_StaticsChange_L0+0 
;Mainprocess.c,1103 :: 		}
L_Voltprocess275:
L_Voltprocess274:
;Mainprocess.c,1104 :: 		if(StaticsChange)
	MOVF        Voltprocess_StaticsChange_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Voltprocess276
;Mainprocess.c,1105 :: 		EEPROM_set(0x01+2*sizeof(SPCSETPIONTS),sizeof(STATISTICS),(UCHAR*)(&pSPCValue[0].SPCStatistics));
	MOVLW       177
	MOVWF       FARG_EEPROM_set_EEPROM_WRITE_ADDRESS+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_set_EEPROM_WRITE_ADDRESS+1 
	MOVLW       30
	MOVWF       FARG_EEPROM_set_Len+0 
	MOVLW       _pSPCValue+24
	MOVWF       FARG_EEPROM_set_writebuffer+0 
	MOVLW       hi_addr(_pSPCValue+24)
	MOVWF       FARG_EEPROM_set_writebuffer+1 
	CALL        _EEPROM_set+0, 0
L_Voltprocess276:
;Mainprocess.c,1109 :: 		(pSPCValue[0].SPCSetPoints.LowVoltage != SPC_SYSTEMVALUE_OFF))
	MOVLW       128
	XORWF       _pSPCValue+21, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _pSPCValue+79, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Voltprocess611
	MOVF        _pSPCValue+78, 0 
	SUBWF       _pSPCValue+20, 0 
L__Voltprocess611:
	BTFSC       STATUS+0, 0 
	GOTO        L_Voltprocess279
	MOVF        _pSPCValue+79, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__Voltprocess612
	MOVLW       255
	XORWF       _pSPCValue+78, 0 
L__Voltprocess612:
	BTFSC       STATUS+0, 2 
	GOTO        L_Voltprocess279
L__Voltprocess329:
;Mainprocess.c,1111 :: 		if(!(ActivedAlarms & LOWVOLTALARM))
	BTFSC       _ActivedAlarms+1, 4 
	GOTO        L_Voltprocess280
;Mainprocess.c,1112 :: 		alarmoperate(LOWVOLTALARM,ENALARM);
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       16
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVLW       1
	MOVWF       FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Voltprocess280:
;Mainprocess.c,1114 :: 		if(ActivedAlarms & HIGHVOLTALARM)
	BTFSS       _ActivedAlarms+1, 5 
	GOTO        L_Voltprocess281
;Mainprocess.c,1115 :: 		alarmoperate(HIGHVOLTALARM,DISALARM);
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       32
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	CLRF        FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Voltprocess281:
;Mainprocess.c,1116 :: 		}
	GOTO        L_Voltprocess282
L_Voltprocess279:
;Mainprocess.c,1118 :: 		(pSPCValue[0].SPCSetPoints.HighVoltage != SPC_SYSTEMVALUE_OFF))
	MOVLW       128
	XORWF       _pSPCValue+81, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _pSPCValue+21, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Voltprocess613
	MOVF        _pSPCValue+20, 0 
	SUBWF       _pSPCValue+80, 0 
L__Voltprocess613:
	BTFSC       STATUS+0, 0 
	GOTO        L_Voltprocess285
	MOVF        _pSPCValue+81, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__Voltprocess614
	MOVLW       255
	XORWF       _pSPCValue+80, 0 
L__Voltprocess614:
	BTFSC       STATUS+0, 2 
	GOTO        L_Voltprocess285
L__Voltprocess328:
;Mainprocess.c,1120 :: 		if(!(ActivedAlarms & HIGHVOLTALARM))
	BTFSC       _ActivedAlarms+1, 5 
	GOTO        L_Voltprocess286
;Mainprocess.c,1121 :: 		alarmoperate(HIGHVOLTALARM,ENALARM);
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       32
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVLW       1
	MOVWF       FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Voltprocess286:
;Mainprocess.c,1123 :: 		if(ActivedAlarms & LOWVOLTALARM)
	BTFSS       _ActivedAlarms+1, 4 
	GOTO        L_Voltprocess287
;Mainprocess.c,1124 :: 		alarmoperate(LOWVOLTALARM,DISALARM);
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       16
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	CLRF        FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Voltprocess287:
;Mainprocess.c,1125 :: 		}
	GOTO        L_Voltprocess288
L_Voltprocess285:
;Mainprocess.c,1128 :: 		if(ActivedAlarms & HIGHVOLTALARM)
	BTFSS       _ActivedAlarms+1, 5 
	GOTO        L_Voltprocess289
;Mainprocess.c,1129 :: 		alarmoperate(HIGHVOLTALARM,DISALARM);
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       32
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	CLRF        FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Voltprocess289:
;Mainprocess.c,1131 :: 		if(ActivedAlarms & LOWVOLTALARM)
	BTFSS       _ActivedAlarms+1, 4 
	GOTO        L_Voltprocess290
;Mainprocess.c,1132 :: 		alarmoperate(LOWVOLTALARM,DISALARM);
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       16
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	CLRF        FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_Voltprocess290:
;Mainprocess.c,1133 :: 		}
L_Voltprocess288:
L_Voltprocess282:
;Mainprocess.c,1134 :: 		}
L_end_Voltprocess:
	RETURN      0
; end of _Voltprocess

_enegy_acc:

;Mainprocess.c,1141 :: 		void enegy_acc()
;Mainprocess.c,1144 :: 		char enegychaged=0;
	CLRF        enegy_acc_enegychaged_L0+0 
	CLRF        enegy_acc_SkipCh_L0+0 
	CLRF        enegy_acc_SkipCh_L0+1 
;Mainprocess.c,1149 :: 		if(energyacc == 0)
	MOVF        _energyacc+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_enegy_acc291
;Mainprocess.c,1150 :: 		return;
	GOTO        L_end_enegy_acc
L_enegy_acc291:
;Mainprocess.c,1152 :: 		energyacc = 0;
	CLRF        _energyacc+0 
;Mainprocess.c,1153 :: 		for(i=0;i<2;i++)
	CLRF        enegy_acc_i_L0+0 
L_enegy_acc292:
	MOVLW       2
	SUBWF       enegy_acc_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_enegy_acc293
;Mainprocess.c,1155 :: 		if(pSPCValue[i].SPCStatistics.EnergyUsed == OUTOFRANGE)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        enegy_acc_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       24
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       16
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__enegy_acc616
	MOVLW       254
	XORWF       R1, 0 
L__enegy_acc616:
	BTFSS       STATUS+0, 2 
	GOTO        L_enegy_acc295
;Mainprocess.c,1157 :: 		MemeSet((char *)&Volt_acc[i], 0, sizeof(VALUEACC));
	MOVLW       5
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        enegy_acc_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Volt_acc+0
	ADDWF       R0, 0 
	MOVWF       FARG_MemeSet_target+0 
	MOVLW       hi_addr(_Volt_acc+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_MemeSet_target+1 
	CLRF        FARG_MemeSet_Transdata+0 
	MOVLW       5
	MOVWF       FARG_MemeSet_len+0 
	MOVLW       0
	MOVWF       FARG_MemeSet_len+1 
	CALL        _MemeSet+0, 0
;Mainprocess.c,1158 :: 		MemeSet((char *)&Current_acc[i], 0, sizeof(VALUEACC));
	MOVLW       5
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        enegy_acc_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Current_acc+0
	ADDWF       R0, 0 
	MOVWF       FARG_MemeSet_target+0 
	MOVLW       hi_addr(_Current_acc+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_MemeSet_target+1 
	CLRF        FARG_MemeSet_Transdata+0 
	MOVLW       5
	MOVWF       FARG_MemeSet_len+0 
	MOVLW       0
	MOVWF       FARG_MemeSet_len+1 
	CALL        _MemeSet+0, 0
;Mainprocess.c,1159 :: 		SkipCh[i] = 1;
	MOVLW       enegy_acc_SkipCh_L0+0
	MOVWF       FSR1 
	MOVLW       hi_addr(enegy_acc_SkipCh_L0+0)
	MOVWF       FSR1H 
	MOVF        enegy_acc_i_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       1
	MOVWF       POSTINC1+0 
;Mainprocess.c,1161 :: 		}
L_enegy_acc295:
;Mainprocess.c,1163 :: 		if(pSPCValue[0].SPCActual.Voltage == OUTOFRANGE)
	MOVF        _pSPCValue+21, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__enegy_acc617
	MOVLW       254
	XORWF       _pSPCValue+20, 0 
L__enegy_acc617:
	BTFSS       STATUS+0, 2 
	GOTO        L_enegy_acc296
;Mainprocess.c,1164 :: 		SkipCh[i] = 1;           //return;
	MOVLW       enegy_acc_SkipCh_L0+0
	MOVWF       FSR1 
	MOVLW       hi_addr(enegy_acc_SkipCh_L0+0)
	MOVWF       FSR1H 
	MOVF        enegy_acc_i_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       1
	MOVWF       POSTINC1+0 
L_enegy_acc296:
;Mainprocess.c,1166 :: 		if(pSPCValue[i].SPCActual.Current_RMS == OUTOFRANGE)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        enegy_acc_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       16
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__enegy_acc618
	MOVLW       254
	XORWF       R1, 0 
L__enegy_acc618:
	BTFSS       STATUS+0, 2 
	GOTO        L_enegy_acc297
;Mainprocess.c,1167 :: 		SkipCh[i] = 1;             //return;
	MOVLW       enegy_acc_SkipCh_L0+0
	MOVWF       FSR1 
	MOVLW       hi_addr(enegy_acc_SkipCh_L0+0)
	MOVWF       FSR1H 
	MOVF        enegy_acc_i_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       1
	MOVWF       POSTINC1+0 
L_enegy_acc297:
;Mainprocess.c,1169 :: 		if(SkipCh[i] == 0)
	MOVLW       enegy_acc_SkipCh_L0+0
	MOVWF       FSR0 
	MOVLW       hi_addr(enegy_acc_SkipCh_L0+0)
	MOVWF       FSR0H 
	MOVF        enegy_acc_i_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_enegy_acc298
;Mainprocess.c,1171 :: 		if(Volt_acc[i].num >= 100)        //100
	MOVLW       5
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        enegy_acc_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Volt_acc+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_Volt_acc+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       100
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_enegy_acc299
;Mainprocess.c,1173 :: 		v_temp = Volt_acc[i].acc/100;              //100
	MOVLW       5
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        enegy_acc_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__enegy_acc+0 
	MOVF        R1, 0 
	MOVWF       FLOC__enegy_acc+1 
	MOVLW       _Volt_acc+0
	ADDWF       FLOC__enegy_acc+0, 0 
	MOVWF       R0 
	MOVLW       hi_addr(_Volt_acc+0)
	ADDWFC      FLOC__enegy_acc+1, 0 
	MOVWF       R1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Div_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       enegy_acc_v_temp_L0+0 
	MOVF        R1, 0 
	MOVWF       enegy_acc_v_temp_L0+1 
	MOVF        R2, 0 
	MOVWF       enegy_acc_v_temp_L0+2 
	MOVF        R3, 0 
	MOVWF       enegy_acc_v_temp_L0+3 
;Mainprocess.c,1174 :: 		c_temp = Current_acc[i].acc/100;           //100
	MOVLW       _Current_acc+0
	ADDWF       FLOC__enegy_acc+0, 0 
	MOVWF       R0 
	MOVLW       hi_addr(_Current_acc+0)
	ADDWFC      FLOC__enegy_acc+1, 0 
	MOVWF       R1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Div_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       enegy_acc_c_temp_L0+0 
	MOVF        R1, 0 
	MOVWF       enegy_acc_c_temp_L0+1 
	MOVF        R2, 0 
	MOVWF       enegy_acc_c_temp_L0+2 
	MOVF        R3, 0 
	MOVWF       enegy_acc_c_temp_L0+3 
;Mainprocess.c,1175 :: 		TotalEnergyWh[i] += v_temp*c_temp;
	MOVF        enegy_acc_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       enegy_acc_TotalEnergyWh_L0+0
	ADDWF       R0, 0 
	MOVWF       FLOC__enegy_acc+0 
	MOVLW       hi_addr(enegy_acc_TotalEnergyWh_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__enegy_acc+1 
	MOVF        enegy_acc_v_temp_L0+0, 0 
	MOVWF       R0 
	MOVF        enegy_acc_v_temp_L0+1, 0 
	MOVWF       R1 
	MOVF        enegy_acc_c_temp_L0+0, 0 
	MOVWF       R4 
	MOVF        enegy_acc_c_temp_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVFF       FLOC__enegy_acc+0, FSR0
	MOVFF       FLOC__enegy_acc+1, FSR0H
	MOVF        POSTINC0+0, 0 
	ADDWF       R0, 1 
	MOVF        POSTINC0+0, 0 
	ADDWFC      R1, 1 
	MOVFF       FLOC__enegy_acc+0, FSR1
	MOVFF       FLOC__enegy_acc+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,1177 :: 		if(TotalEnergyWh[i] > 1000)
	MOVF        enegy_acc_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       enegy_acc_TotalEnergyWh_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(enegy_acc_TotalEnergyWh_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	SUBLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L__enegy_acc619
	MOVF        R1, 0 
	SUBLW       232
L__enegy_acc619:
	BTFSC       STATUS+0, 0 
	GOTO        L_enegy_acc300
;Mainprocess.c,1179 :: 		TotalEnergyKwh[i] += (TotalEnergyWh[i]/1000);
	MOVF        enegy_acc_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       enegy_acc_TotalEnergyKwh_L0+0
	ADDWF       R0, 0 
	MOVWF       FLOC__enegy_acc+0 
	MOVLW       hi_addr(enegy_acc_TotalEnergyKwh_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__enegy_acc+1 
	MOVLW       enegy_acc_TotalEnergyWh_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(enegy_acc_TotalEnergyWh_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVFF       FLOC__enegy_acc+0, FSR0
	MOVFF       FLOC__enegy_acc+1, FSR0H
	MOVF        POSTINC0+0, 0 
	ADDWF       R0, 1 
	MOVF        POSTINC0+0, 0 
	ADDWFC      R1, 1 
	MOVFF       FLOC__enegy_acc+0, FSR1
	MOVFF       FLOC__enegy_acc+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,1180 :: 		TotalEnergyWh[i] %= 1000;
	MOVF        enegy_acc_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       enegy_acc_TotalEnergyWh_L0+0
	ADDWF       R0, 0 
	MOVWF       FLOC__enegy_acc+0 
	MOVLW       hi_addr(enegy_acc_TotalEnergyWh_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__enegy_acc+1 
	MOVFF       FLOC__enegy_acc+0, FSR0
	MOVFF       FLOC__enegy_acc+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVFF       FLOC__enegy_acc+0, FSR1
	MOVFF       FLOC__enegy_acc+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,1182 :: 		if(TotalEnergyKwh[i] > 1000)
	MOVF        enegy_acc_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       enegy_acc_TotalEnergyKwh_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(enegy_acc_TotalEnergyKwh_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	SUBLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L__enegy_acc620
	MOVF        R1, 0 
	SUBLW       232
L__enegy_acc620:
	BTFSC       STATUS+0, 0 
	GOTO        L_enegy_acc301
;Mainprocess.c,1184 :: 		pSPCValue[i].SPCStatistics.EnergyUsed += (TotalEnergyKwh[i]/1000);
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        enegy_acc_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       24
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       16
	ADDWF       R0, 0 
	MOVWF       FLOC__enegy_acc+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__enegy_acc+1 
	MOVF        enegy_acc_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       enegy_acc_TotalEnergyKwh_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(enegy_acc_TotalEnergyKwh_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVFF       FLOC__enegy_acc+0, FSR0
	MOVFF       FLOC__enegy_acc+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R2, 0 
	ADDWF       R0, 1 
	MOVF        R3, 0 
	ADDWFC      R1, 1 
	MOVFF       FLOC__enegy_acc+0, FSR1
	MOVFF       FLOC__enegy_acc+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,1185 :: 		TotalEnergyKwh[i] %= 1000;
	MOVF        enegy_acc_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       enegy_acc_TotalEnergyKwh_L0+0
	ADDWF       R0, 0 
	MOVWF       FLOC__enegy_acc+0 
	MOVLW       hi_addr(enegy_acc_TotalEnergyKwh_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__enegy_acc+1 
	MOVFF       FLOC__enegy_acc+0, FSR0
	MOVFF       FLOC__enegy_acc+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVFF       FLOC__enegy_acc+0, FSR1
	MOVFF       FLOC__enegy_acc+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,1187 :: 		if(pSPCValue[i].SPCStatistics.EnergyUsed > MAX_SPCENEGY)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        enegy_acc_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       24
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       16
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORLW       39
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__enegy_acc621
	MOVF        R1, 0 
	SUBLW       16
L__enegy_acc621:
	BTFSC       STATUS+0, 0 
	GOTO        L_enegy_acc302
;Mainprocess.c,1189 :: 		pSPCValue[i].SPCStatistics.EnergyUsed = OUTOFRANGE;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        enegy_acc_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       24
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       16
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       254
	MOVWF       POSTINC1+0 
	MOVLW       127
	MOVWF       POSTINC1+0 
;Mainprocess.c,1190 :: 		pSPCValue[i].SPCStatistics.EnergyCost = COSTOUTOFRANGE;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        enegy_acc_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       24
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       18
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       255
	MOVWF       POSTINC1+0 
	MOVLW       255
	MOVWF       POSTINC1+0 
	MOVLW       255
	MOVWF       POSTINC1+0 
	MOVLW       127
	MOVWF       POSTINC1+0 
;Mainprocess.c,1191 :: 		}
L_enegy_acc302:
;Mainprocess.c,1192 :: 		}
L_enegy_acc301:
;Mainprocess.c,1194 :: 		if(pSPCValue[i].SPCStatistics.EnergyCost != COSTOUTOFRANGE)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        enegy_acc_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       24
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       18
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        R4, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__enegy_acc622
	MOVF        R3, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L__enegy_acc622
	MOVF        R2, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L__enegy_acc622
	MOVF        R1, 0 
	XORLW       255
L__enegy_acc622:
	BTFSC       STATUS+0, 2 
	GOTO        L_enegy_acc303
;Mainprocess.c,1196 :: 		pSPCValue[i].SPCStatistics.EnergyCost = TotalEnergyKwh[i]*
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        enegy_acc_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 0 
	MOVWF       R6 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       R7 
	MOVLW       24
	ADDWF       R6, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      R7, 0 
	MOVWF       R1 
	MOVLW       18
	ADDWF       R0, 0 
	MOVWF       FLOC__enegy_acc+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__enegy_acc+1 
	MOVF        enegy_acc_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       enegy_acc_TotalEnergyKwh_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(enegy_acc_TotalEnergyKwh_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        POSTINC0+0, 0 
	MOVWF       R5 
;Mainprocess.c,1197 :: 		pSPCValue[i].SPCSetPoints.CostPerKWH/10;
	MOVLW       54
	ADDWF       R6, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      R7, 0 
	MOVWF       R1 
	MOVLW       36
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R0 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVFF       FLOC__enegy_acc+0, FSR1
	MOVFF       FLOC__enegy_acc+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,1198 :: 		pSPCValue[i].SPCStatistics.EnergyCost += (unsigned long)pSPCValue[i].SPCStatistics.EnergyUsed*
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        enegy_acc_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       24
	ADDWF       R2, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R1 
	MOVLW       18
	ADDWF       R0, 0 
	MOVWF       FLOC__enegy_acc+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__enegy_acc+1 
	MOVLW       16
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	MOVWF       R6 
	MOVWF       R7 
;Mainprocess.c,1199 :: 		pSPCValue[i].SPCSetPoints.CostPerKWH * 100;
	MOVLW       54
	ADDWF       R2, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R1 
	MOVLW       36
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R0 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVFF       FLOC__enegy_acc+0, FSR0
	MOVFF       FLOC__enegy_acc+1, FSR0H
	MOVF        POSTINC0+0, 0 
	ADDWF       R0, 1 
	MOVF        POSTINC0+0, 0 
	ADDWFC      R1, 1 
	MOVF        POSTINC0+0, 0 
	ADDWFC      R2, 1 
	MOVF        POSTINC0+0, 0 
	ADDWFC      R3, 1 
	MOVFF       FLOC__enegy_acc+0, FSR1
	MOVFF       FLOC__enegy_acc+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,1200 :: 		}
L_enegy_acc303:
;Mainprocess.c,1201 :: 		if(pSPCValue[i].SPCStatistics.EnergyCost > MAX_SPCOST_TOTAL)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        enegy_acc_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       24
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       18
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        R4, 0 
	SUBLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L__enegy_acc623
	MOVF        R3, 0 
	SUBLW       245
	BTFSS       STATUS+0, 2 
	GOTO        L__enegy_acc623
	MOVF        R2, 0 
	SUBLW       225
	BTFSS       STATUS+0, 2 
	GOTO        L__enegy_acc623
	MOVF        R1, 0 
	SUBLW       0
L__enegy_acc623:
	BTFSC       STATUS+0, 0 
	GOTO        L_enegy_acc304
;Mainprocess.c,1202 :: 		pSPCValue[i].SPCStatistics.EnergyCost = COSTOUTOFRANGE;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        enegy_acc_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       24
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       18
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       255
	MOVWF       POSTINC1+0 
	MOVLW       255
	MOVWF       POSTINC1+0 
	MOVLW       255
	MOVWF       POSTINC1+0 
	MOVLW       127
	MOVWF       POSTINC1+0 
L_enegy_acc304:
;Mainprocess.c,1203 :: 		}
L_enegy_acc300:
;Mainprocess.c,1204 :: 		MemeSet((char *)&Volt_acc[i], 0, sizeof(VALUEACC));
	MOVLW       5
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        enegy_acc_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Volt_acc+0
	ADDWF       R0, 0 
	MOVWF       FARG_MemeSet_target+0 
	MOVLW       hi_addr(_Volt_acc+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_MemeSet_target+1 
	CLRF        FARG_MemeSet_Transdata+0 
	MOVLW       5
	MOVWF       FARG_MemeSet_len+0 
	MOVLW       0
	MOVWF       FARG_MemeSet_len+1 
	CALL        _MemeSet+0, 0
;Mainprocess.c,1205 :: 		MemeSet((char *)&Current_acc[i], 0, sizeof(VALUEACC));
	MOVLW       5
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        enegy_acc_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Current_acc+0
	ADDWF       R0, 0 
	MOVWF       FARG_MemeSet_target+0 
	MOVLW       hi_addr(_Current_acc+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_MemeSet_target+1 
	CLRF        FARG_MemeSet_Transdata+0 
	MOVLW       5
	MOVWF       FARG_MemeSet_len+0 
	MOVLW       0
	MOVWF       FARG_MemeSet_len+1 
	CALL        _MemeSet+0, 0
;Mainprocess.c,1206 :: 		enegychaged = 1;
	MOVLW       1
	MOVWF       enegy_acc_enegychaged_L0+0 
;Mainprocess.c,1207 :: 		}
	GOTO        L_enegy_acc305
L_enegy_acc299:
;Mainprocess.c,1210 :: 		Volt_acc[i].num++;
	MOVLW       5
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        enegy_acc_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Volt_acc+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_Volt_acc+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	INCF        R0, 1 
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,1211 :: 		Volt_acc[i].acc += pSPCValue[0].SPCActual.Voltage;
	MOVLW       5
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        enegy_acc_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Volt_acc+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Volt_acc+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       R4 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R5 
	MOVFF       R4, FSR0
	MOVFF       R5, FSR0H
	MOVF        _pSPCValue+20, 0 
	ADDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        _pSPCValue+21, 0 
	ADDWFC      POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       _pSPCValue+21, 7 
	MOVLW       255
	ADDWFC      POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	BTFSC       _pSPCValue+21, 7 
	MOVLW       255
	ADDWFC      POSTINC0+0, 0 
	MOVWF       R3 
	MOVFF       R4, FSR1
	MOVFF       R5, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,1212 :: 		Current_acc[i].acc += pSPCValue[i].SPCActual.Current_RMS;
	MOVLW       5
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        enegy_acc_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Current_acc+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Current_acc+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FLOC__enegy_acc+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__enegy_acc+1 
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        enegy_acc_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       16
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R0 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVFF       FLOC__enegy_acc+0, FSR0
	MOVFF       FLOC__enegy_acc+1, FSR0H
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	ADDWF       R0, 1 
	MOVF        POSTINC0+0, 0 
	ADDWFC      R1, 1 
	MOVF        POSTINC0+0, 0 
	ADDWFC      R2, 1 
	MOVF        POSTINC0+0, 0 
	ADDWFC      R3, 1 
	MOVFF       FLOC__enegy_acc+0, FSR1
	MOVFF       FLOC__enegy_acc+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,1213 :: 		}
L_enegy_acc305:
;Mainprocess.c,1215 :: 		if(enegychaged)
	MOVF        enegy_acc_enegychaged_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_enegy_acc306
;Mainprocess.c,1217 :: 		SystemUpdate |= (CH1_ENEGY_UPDATE_REQ << i);
	MOVF        enegy_acc_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       4
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__enegy_acc624:
	BZ          L__enegy_acc625
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__enegy_acc624
L__enegy_acc625:
	MOVF        R0, 0 
	IORWF       _SystemUpdate+0, 1 
	MOVF        R1, 0 
	IORWF       _SystemUpdate+1, 1 
	MOVF        R2, 0 
	IORWF       _SystemUpdate+2, 1 
	MOVF        R3, 0 
	IORWF       _SystemUpdate+3, 1 
;Mainprocess.c,1218 :: 		SetCostStr(pSPCValue[i].SPCStatistics.EnergyUsed, CH1_ACTURAL_ENEGY+i);
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        enegy_acc_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       24
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       16
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SetCostStr_databuff+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SetCostStr_databuff+1 
	MOVLW       0
	BTFSC       FARG_SetCostStr_databuff+3, 7 
	MOVLW       255
	MOVWF       FARG_SetCostStr_databuff+2 
	MOVWF       FARG_SetCostStr_databuff+3 
	MOVLW       0
	BTFSC       FARG_SetCostStr_databuff+1, 7 
	MOVLW       255
	MOVWF       FARG_SetCostStr_databuff+2 
	MOVWF       FARG_SetCostStr_databuff+3 
	MOVF        enegy_acc_i_L0+0, 0 
	ADDLW       24
	MOVWF       FARG_SetCostStr_strlocat+0 
	CALL        _SetCostStr+0, 0
;Mainprocess.c,1219 :: 		SetCostStr(pSPCValue[i].SPCStatistics.EnergyCost, CH1_ACTURAL_COST+i);
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        enegy_acc_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       24
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       18
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SetCostStr_databuff+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SetCostStr_databuff+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SetCostStr_databuff+2 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SetCostStr_databuff+3 
	MOVF        enegy_acc_i_L0+0, 0 
	ADDLW       26
	MOVWF       FARG_SetCostStr_strlocat+0 
	CALL        _SetCostStr+0, 0
;Mainprocess.c,1220 :: 		EEPROM_set(0x01+2*sizeof(SPCSETPIONTS)+i*sizeof(STATISTICS),sizeof(STATISTICS),(UCHAR*)(&pSPCValue[i].SPCStatistics));
	MOVLW       30
	MULWF       enegy_acc_i_L0+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVLW       177
	ADDWF       R0, 0 
	MOVWF       FARG_EEPROM_set_EEPROM_WRITE_ADDRESS+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FARG_EEPROM_set_EEPROM_WRITE_ADDRESS+1 
	MOVLW       30
	MOVWF       FARG_EEPROM_set_Len+0 
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        enegy_acc_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 0 
	MOVWF       FARG_EEPROM_set_writebuffer+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_EEPROM_set_writebuffer+1 
	MOVLW       24
	ADDWF       FARG_EEPROM_set_writebuffer+0, 1 
	MOVLW       0
	ADDWFC      FARG_EEPROM_set_writebuffer+1, 1 
	CALL        _EEPROM_set+0, 0
;Mainprocess.c,1221 :: 		}
L_enegy_acc306:
;Mainprocess.c,1222 :: 		}
L_enegy_acc298:
;Mainprocess.c,1153 :: 		for(i=0;i<2;i++)
	INCF        enegy_acc_i_L0+0, 1 
;Mainprocess.c,1223 :: 		}
	GOTO        L_enegy_acc292
L_enegy_acc293:
;Mainprocess.c,1224 :: 		}
L_end_enegy_acc:
	RETURN      0
; end of _enegy_acc

_Timeprocess:

;Mainprocess.c,1231 :: 		void Timeprocess()
;Mainprocess.c,1233 :: 		char StaticsChange=0;
	CLRF        Timeprocess_StaticsChange_L0+0 
;Mainprocess.c,1236 :: 		for(i=0;i<2;i++)
	CLRF        Timeprocess_i_L0+0 
L_Timeprocess307:
	MOVLW       2
	SUBWF       Timeprocess_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Timeprocess308
;Mainprocess.c,1238 :: 		if(DataUpdate & (CH1_ONTIME_UPDATE_REQ << i))
	MOVF        Timeprocess_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Timeprocess627:
	BZ          L__Timeprocess628
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Timeprocess627
L__Timeprocess628:
	MOVF        _DataUpdate+0, 0 
	ANDWF       R0, 1 
	MOVF        _DataUpdate+1, 0 
	ANDWF       R1, 1 
	MOVLW       0
	ANDWF       R2, 1 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_Timeprocess310
;Mainprocess.c,1240 :: 		DataUpdate &= ~(CH1_ONTIME_UPDATE_REQ << i);
	MOVF        Timeprocess_i_L0+0, 0 
	MOVWF       R2 
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
L__Timeprocess629:
	BZ          L__Timeprocess630
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__Timeprocess629
L__Timeprocess630:
	COMF        R0, 1 
	COMF        R1, 1 
	MOVF        R0, 0 
	ANDWF       _DataUpdate+0, 1 
	MOVF        R1, 0 
	ANDWF       _DataUpdate+1, 1 
;Mainprocess.c,1241 :: 		SystemUpdate |= (CH1_ONTIME_UPDATE_REQ << i);
	MOVF        Timeprocess_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Timeprocess631:
	BZ          L__Timeprocess632
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Timeprocess631
L__Timeprocess632:
	MOVF        R0, 0 
	IORWF       _SystemUpdate+0, 1 
	MOVF        R1, 0 
	IORWF       _SystemUpdate+1, 1 
	MOVF        R2, 0 
	IORWF       _SystemUpdate+2, 1 
	MOVF        R3, 0 
	IORWF       _SystemUpdate+3, 1 
;Mainprocess.c,1242 :: 		SetOntimeStr(pSPCValue[i].SPCStatistics.RunTime, CH1_ACTURAL_ONTIME+i);
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        Timeprocess_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       24
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       22
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SetOntimeStr_databuff+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SetOntimeStr_databuff+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SetOntimeStr_databuff+2 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SetOntimeStr_databuff+3 
	MOVF        Timeprocess_i_L0+0, 0 
	MOVWF       FARG_SetOntimeStr_strlocat+0 
	CALL        _SetOntimeStr+0, 0
;Mainprocess.c,1243 :: 		StaticsChange = 1;
	MOVLW       1
	MOVWF       Timeprocess_StaticsChange_L0+0 
;Mainprocess.c,1244 :: 		}
L_Timeprocess310:
;Mainprocess.c,1246 :: 		if(DataUpdate & (CH1_ONTIME_UPDATE_PERCENT_REQ << i))
	MOVF        Timeprocess_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       4
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Timeprocess633:
	BZ          L__Timeprocess634
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Timeprocess633
L__Timeprocess634:
	MOVF        _DataUpdate+0, 0 
	ANDWF       R0, 1 
	MOVF        _DataUpdate+1, 0 
	ANDWF       R1, 1 
	MOVLW       0
	ANDWF       R2, 1 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_Timeprocess311
;Mainprocess.c,1248 :: 		DataUpdate &= ~(CH1_ONTIME_UPDATE_PERCENT_REQ << i);
	MOVF        Timeprocess_i_L0+0, 0 
	MOVWF       R2 
	MOVLW       4
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
L__Timeprocess635:
	BZ          L__Timeprocess636
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__Timeprocess635
L__Timeprocess636:
	COMF        R0, 1 
	COMF        R1, 1 
	MOVF        R0, 0 
	ANDWF       _DataUpdate+0, 1 
	MOVF        R1, 0 
	ANDWF       _DataUpdate+1, 1 
;Mainprocess.c,1249 :: 		SystemUpdate |= (CH1_ONTIME_UPDATE_PERCENT_REQ << i);
	MOVF        Timeprocess_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       4
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R4, 0 
L__Timeprocess637:
	BZ          L__Timeprocess638
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Timeprocess637
L__Timeprocess638:
	MOVF        R0, 0 
	IORWF       _SystemUpdate+0, 1 
	MOVF        R1, 0 
	IORWF       _SystemUpdate+1, 1 
	MOVF        R2, 0 
	IORWF       _SystemUpdate+2, 1 
	MOVF        R3, 0 
	IORWF       _SystemUpdate+3, 1 
;Mainprocess.c,1251 :: 		pSPCValue[i].SPCStatistics.HeaterOnTime =
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        Timeprocess_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       24
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       26
	ADDWF       R0, 0 
	MOVWF       FLOC__Timeprocess+4 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__Timeprocess+5 
;Mainprocess.c,1252 :: 		(Heat_On_time[i].hour*60+Heat_On_time[i].minute)*100/(SYS_On_time.hour*60+SYS_On_time.minute);
	MOVLW       6
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        Timeprocess_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Heat_On_time+0
	ADDWF       R0, 0 
	MOVWF       FLOC__Timeprocess+0 
	MOVLW       hi_addr(_Heat_On_time+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__Timeprocess+1 
	MOVLW       2
	ADDWF       FLOC__Timeprocess+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FLOC__Timeprocess+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVLW       60
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       1
	ADDWF       FLOC__Timeprocess+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      FLOC__Timeprocess+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__Timeprocess+0 
	MOVF        R1, 0 
	MOVWF       FLOC__Timeprocess+1 
	MOVF        R2, 0 
	MOVWF       FLOC__Timeprocess+2 
	MOVF        R3, 0 
	MOVWF       FLOC__Timeprocess+3 
	MOVF        _SYS_On_time+2, 0 
	MOVWF       R0 
	MOVF        _SYS_On_time+3, 0 
	MOVWF       R1 
	MOVF        _SYS_On_time+4, 0 
	MOVWF       R2 
	MOVF        _SYS_On_time+5, 0 
	MOVWF       R3 
	MOVLW       60
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVF        _SYS_On_time+1, 0 
	ADDWF       R0, 0 
	MOVWF       R4 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R5 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       R6 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R7 
	MOVF        FLOC__Timeprocess+0, 0 
	MOVWF       R0 
	MOVF        FLOC__Timeprocess+1, 0 
	MOVWF       R1 
	MOVF        FLOC__Timeprocess+2, 0 
	MOVWF       R2 
	MOVF        FLOC__Timeprocess+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
	MOVFF       FLOC__Timeprocess+4, FSR1
	MOVFF       FLOC__Timeprocess+5, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Mainprocess.c,1253 :: 		SetIntStr((int*)&pSPCValue[i].SPCStatistics.HeaterOnTime, CH1_ACTURAL_ONTIME_PERCENT+i, UNIT_PERCENT, 1);
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        Timeprocess_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 0 
	MOVWF       FARG_SetIntStr_ptr+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_SetIntStr_ptr+1 
	MOVLW       24
	ADDWF       FARG_SetIntStr_ptr+0, 1 
	MOVLW       0
	ADDWFC      FARG_SetIntStr_ptr+1, 1 
	MOVLW       26
	ADDWF       FARG_SetIntStr_ptr+0, 1 
	MOVLW       0
	ADDWFC      FARG_SetIntStr_ptr+1, 1 
	MOVF        Timeprocess_i_L0+0, 0 
	ADDLW       36
	MOVWF       FARG_SetIntStr_strlocat+0 
	MOVLW       9
	MOVWF       FARG_SetIntStr_unitlocar+0 
	MOVLW       1
	MOVWF       FARG_SetIntStr_len+0 
	CALL        _SetIntStr+0, 0
;Mainprocess.c,1254 :: 		StaticsChange = 1;
	MOVLW       1
	MOVWF       Timeprocess_StaticsChange_L0+0 
;Mainprocess.c,1255 :: 		}
L_Timeprocess311:
;Mainprocess.c,1257 :: 		if(StaticsChange)
	MOVF        Timeprocess_StaticsChange_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Timeprocess312
;Mainprocess.c,1258 :: 		EEPROM_set(0x01+2*sizeof(SPCSETPIONTS)+i*sizeof(STATISTICS),sizeof(STATISTICS),(UCHAR*)(&pSPCValue[i].SPCStatistics));
	MOVLW       30
	MULWF       Timeprocess_i_L0+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVLW       177
	ADDWF       R0, 0 
	MOVWF       FARG_EEPROM_set_EEPROM_WRITE_ADDRESS+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FARG_EEPROM_set_EEPROM_WRITE_ADDRESS+1 
	MOVLW       30
	MOVWF       FARG_EEPROM_set_Len+0 
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        Timeprocess_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 0 
	MOVWF       FARG_EEPROM_set_writebuffer+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_EEPROM_set_writebuffer+1 
	MOVLW       24
	ADDWF       FARG_EEPROM_set_writebuffer+0, 1 
	MOVLW       0
	ADDWFC      FARG_EEPROM_set_writebuffer+1, 1 
	CALL        _EEPROM_set+0, 0
L_Timeprocess312:
;Mainprocess.c,1236 :: 		for(i=0;i<2;i++)
	INCF        Timeprocess_i_L0+0, 1 
;Mainprocess.c,1259 :: 		}
	GOTO        L_Timeprocess307
L_Timeprocess308:
;Mainprocess.c,1260 :: 		}
L_end_Timeprocess:
	RETURN      0
; end of _Timeprocess
