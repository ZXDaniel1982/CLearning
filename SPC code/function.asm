
_CopyTemp:

;function.c,42 :: 		void CopyTemp(TEMPERATURE *tempsource, TEMPERATURE *temptarget)
;function.c,44 :: 		temptarget->Temperature_C = tempsource->Temperature_C;
	MOVLW       2
	ADDWF       FARG_CopyTemp_temptarget+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_CopyTemp_temptarget+1, 0 
	MOVWF       FSR1H 
	MOVLW       2
	ADDWF       FARG_CopyTemp_tempsource+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_CopyTemp_tempsource+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;function.c,45 :: 		temptarget->Temperature_F = tempsource->Temperature_F;
	MOVFF       FARG_CopyTemp_temptarget+0, FSR1
	MOVFF       FARG_CopyTemp_temptarget+1, FSR1H
	MOVFF       FARG_CopyTemp_tempsource+0, FSR0
	MOVFF       FARG_CopyTemp_tempsource+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;function.c,46 :: 		}
L_end_CopyTemp:
	RETURN      0
; end of _CopyTemp

_ConvertCtoF:

;function.c,53 :: 		int ConvertCtoF(int sourse)
;function.c,56 :: 		return (int)(32 + ((long)sourse * 18) / 10);
	MOVF        FARG_ConvertCtoF_sourse+0, 0 
	MOVWF       R0 
	MOVF        FARG_ConvertCtoF_sourse+1, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       FARG_ConvertCtoF_sourse+1, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	MOVLW       18
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Div_32x32_S+0, 0
	MOVLW       32
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
;function.c,57 :: 		}
L_end_ConvertCtoF:
	RETURN      0
; end of _ConvertCtoF

_ConvertFtoC:

;function.c,59 :: 		int ConvertFtoC(int sourse)
;function.c,61 :: 		return (int)(((long)(sourse - 32)*10) / 18);
	MOVLW       32
	SUBWF       FARG_ConvertFtoC_sourse+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      FARG_ConvertFtoC_sourse+1, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       18
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Div_32x32_S+0, 0
;function.c,62 :: 		}
L_end_ConvertFtoC:
	RETURN      0
; end of _ConvertFtoC

_ConvertTemp:

;function.c,64 :: 		void ConvertTemp(TEMPERATURE *temptocon)
;function.c,67 :: 		units = pSPCValue[0].SPCSetPoints.system_valueb.bite.spc_units_c;
	MOVLW       0
	BTFSC       _pSPCValue+138, 0 
	MOVLW       1
	MOVWF       ConvertTemp_units_L0+0 
;function.c,69 :: 		if(units)
	MOVF        ConvertTemp_units_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_ConvertTemp0
;function.c,71 :: 		temptocon->Temperature_F = ConvertCtoF(temptocon->Temperature_C);
	MOVF        FARG_ConvertTemp_temptocon+0, 0 
	MOVWF       FLOC__ConvertTemp+0 
	MOVF        FARG_ConvertTemp_temptocon+1, 0 
	MOVWF       FLOC__ConvertTemp+1 
	MOVLW       2
	ADDWF       FARG_ConvertTemp_temptocon+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ConvertTemp_temptocon+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ConvertCtoF_sourse+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ConvertCtoF_sourse+1 
	CALL        _ConvertCtoF+0, 0
	MOVFF       FLOC__ConvertTemp+0, FSR1
	MOVFF       FLOC__ConvertTemp+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	GOTO        L_ConvertTemp1
L_ConvertTemp0:
;function.c,74 :: 		temptocon->Temperature_C = ConvertFtoC(temptocon->Temperature_F);
	MOVLW       2
	ADDWF       FARG_ConvertTemp_temptocon+0, 0 
	MOVWF       FLOC__ConvertTemp+0 
	MOVLW       0
	ADDWFC      FARG_ConvertTemp_temptocon+1, 0 
	MOVWF       FLOC__ConvertTemp+1 
	MOVFF       FARG_ConvertTemp_temptocon+0, FSR0
	MOVFF       FARG_ConvertTemp_temptocon+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ConvertFtoC_sourse+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ConvertFtoC_sourse+1 
	CALL        _ConvertFtoC+0, 0
	MOVFF       FLOC__ConvertTemp+0, FSR1
	MOVFF       FLOC__ConvertTemp+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
L_ConvertTemp1:
;function.c,75 :: 		}
L_end_ConvertTemp:
	RETURN      0
; end of _ConvertTemp

_ConvertDead:

;function.c,82 :: 		void ConvertDead(TEMPERATURE *temptocon)
;function.c,85 :: 		units = pSPCValue[0].SPCSetPoints.system_valueb.bite.spc_units_c;
	MOVLW       0
	BTFSC       _pSPCValue+138, 0 
	MOVLW       1
	MOVWF       R5 
;function.c,87 :: 		if(units)
	MOVF        R5, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_ConvertDead2
;function.c,89 :: 		temptocon->Temperature_F = (int)(temptocon->Temperature_C * 2);
	MOVLW       2
	ADDWF       FARG_ConvertDead_temptocon+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ConvertDead_temptocon+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVFF       FARG_ConvertDead_temptocon+0, FSR1
	MOVFF       FARG_ConvertDead_temptocon+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;function.c,90 :: 		if(temptocon->Temperature_F > 10)
	MOVFF       FARG_ConvertDead_temptocon+0, FSR0
	MOVFF       FARG_ConvertDead_temptocon+1, FSR0H
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
	GOTO        L__ConvertDead248
	MOVF        R1, 0 
	SUBLW       10
L__ConvertDead248:
	BTFSC       STATUS+0, 0 
	GOTO        L_ConvertDead3
;function.c,91 :: 		temptocon->Temperature_F = 10;
	MOVFF       FARG_ConvertDead_temptocon+0, FSR1
	MOVFF       FARG_ConvertDead_temptocon+1, FSR1H
	MOVLW       10
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
L_ConvertDead3:
;function.c,92 :: 		if(temptocon->Temperature_F < 1)
	MOVFF       FARG_ConvertDead_temptocon+0, FSR0
	MOVFF       FARG_ConvertDead_temptocon+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ConvertDead249
	MOVLW       1
	SUBWF       R1, 0 
L__ConvertDead249:
	BTFSC       STATUS+0, 0 
	GOTO        L_ConvertDead4
;function.c,93 :: 		temptocon->Temperature_F = 1;
	MOVFF       FARG_ConvertDead_temptocon+0, FSR1
	MOVFF       FARG_ConvertDead_temptocon+1, FSR1H
	MOVLW       1
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
L_ConvertDead4:
;function.c,94 :: 		}
	GOTO        L_ConvertDead5
L_ConvertDead2:
;function.c,97 :: 		temptocon->Temperature_C = (int)(temptocon->Temperature_F / 2);
	MOVLW       2
	ADDWF       FARG_ConvertDead_temptocon+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_ConvertDead_temptocon+1, 0 
	MOVWF       FSR1H 
	MOVFF       FARG_ConvertDead_temptocon+0, FSR0
	MOVFF       FARG_ConvertDead_temptocon+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;function.c,98 :: 		if(temptocon->Temperature_C > 5)
	MOVLW       2
	ADDWF       FARG_ConvertDead_temptocon+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ConvertDead_temptocon+1, 0 
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
	GOTO        L__ConvertDead250
	MOVF        R1, 0 
	SUBLW       5
L__ConvertDead250:
	BTFSC       STATUS+0, 0 
	GOTO        L_ConvertDead6
;function.c,99 :: 		temptocon->Temperature_C = 5;
	MOVLW       2
	ADDWF       FARG_ConvertDead_temptocon+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_ConvertDead_temptocon+1, 0 
	MOVWF       FSR1H 
	MOVLW       5
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
L_ConvertDead6:
;function.c,100 :: 		if(temptocon->Temperature_C < 1)
	MOVLW       2
	ADDWF       FARG_ConvertDead_temptocon+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ConvertDead_temptocon+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ConvertDead251
	MOVLW       1
	SUBWF       R1, 0 
L__ConvertDead251:
	BTFSC       STATUS+0, 0 
	GOTO        L_ConvertDead7
;function.c,101 :: 		temptocon->Temperature_C = 1;
	MOVLW       2
	ADDWF       FARG_ConvertDead_temptocon+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_ConvertDead_temptocon+1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
L_ConvertDead7:
;function.c,102 :: 		}
L_ConvertDead5:
;function.c,103 :: 		}
L_end_ConvertDead:
	RETURN      0
; end of _ConvertDead

_CopyPSWTitle:

;function.c,110 :: 		void CopyPSWTitle(char *target, char adder)
;function.c,113 :: 		for(i=0; i<16; i++)
	CLRF        CopyPSWTitle_i_L0+0 
L_CopyPSWTitle8:
	MOVLW       16
	SUBWF       CopyPSWTitle_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_CopyPSWTitle9
;function.c,114 :: 		*(target+i) = PSWTitle[adder][i];
	MOVF        CopyPSWTitle_i_L0+0, 0 
	ADDWF       FARG_CopyPSWTitle_target+0, 0 
	MOVWF       FLOC__CopyPSWTitle+0 
	MOVLW       0
	ADDWFC      FARG_CopyPSWTitle_target+1, 0 
	MOVWF       FLOC__CopyPSWTitle+1 
	MOVLW       20
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        FARG_CopyPSWTitle_adder+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       function_PSWTitle+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(function_PSWTitle+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(function_PSWTitle+0)
	ADDWFC      R2, 1 
	MOVF        CopyPSWTitle_i_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVFF       FLOC__CopyPSWTitle+0, FSR1
	MOVFF       FLOC__CopyPSWTitle+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;function.c,113 :: 		for(i=0; i<16; i++)
	INCF        CopyPSWTitle_i_L0+0, 1 
;function.c,114 :: 		*(target+i) = PSWTitle[adder][i];
	GOTO        L_CopyPSWTitle8
L_CopyPSWTitle9:
;function.c,115 :: 		}
L_end_CopyPSWTitle:
	RETURN      0
; end of _CopyPSWTitle

_StrCompar:

;function.c,122 :: 		char StrCompar(char *resoure,char *target)
;function.c,124 :: 		char i=0;
	CLRF        StrCompar_i_L0+0 
;function.c,125 :: 		while(i<16)
L_StrCompar11:
	MOVLW       16
	SUBWF       StrCompar_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_StrCompar12
;function.c,127 :: 		if(*(resoure+i) == *(target+i)) i++;
	MOVF        StrCompar_i_L0+0, 0 
	ADDWF       FARG_StrCompar_resoure+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_StrCompar_resoure+1, 0 
	MOVWF       FSR0H 
	MOVF        StrCompar_i_L0+0, 0 
	ADDWF       FARG_StrCompar_target+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      FARG_StrCompar_target+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC0+0, 0 
	XORWF       POSTINC2+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_StrCompar13
	INCF        StrCompar_i_L0+0, 1 
	GOTO        L_StrCompar14
L_StrCompar13:
;function.c,128 :: 		else return FALSE;
	CLRF        R0 
	GOTO        L_end_StrCompar
L_StrCompar14:
;function.c,129 :: 		}
	GOTO        L_StrCompar11
L_StrCompar12:
;function.c,130 :: 		return TRUE;
	MOVLW       1
	MOVWF       R0 
;function.c,131 :: 		}
L_end_StrCompar:
	RETURN      0
; end of _StrCompar

_tempaverage:

;function.c,138 :: 		void tempaverage(TEMPERATURE *tempsource, TEMPERATURE *temptarget)
;function.c,141 :: 		temp = tempsource+1;
	MOVLW       4
	ADDWF       FARG_tempaverage_tempsource+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      FARG_tempaverage_tempsource+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       R6 
	MOVF        R1, 0 
	MOVWF       R7 
;function.c,142 :: 		temptarget->Temperature_C = (tempsource->Temperature_C
	MOVLW       2
	ADDWF       FARG_tempaverage_temptarget+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_tempaverage_temptarget+1, 0 
	MOVWF       FSR1H 
	MOVLW       2
	ADDWF       FARG_tempaverage_tempsource+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_tempaverage_tempsource+1, 0 
	MOVWF       FSR0H 
;function.c,143 :: 		+temp->Temperature_C)/2;
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	ADDWF       POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC2+0, 0 
	ADDWFC      POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;function.c,144 :: 		temptarget->Temperature_F = (tempsource->Temperature_F
	MOVFF       FARG_tempaverage_tempsource+0, FSR0
	MOVFF       FARG_tempaverage_tempsource+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
;function.c,145 :: 		+temp->Temperature_F)/2;
	MOVFF       R6, FSR0
	MOVFF       R7, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	ADDWF       R2, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	ADDWFC      R3, 0 
	MOVWF       R5 
	MOVF        R4, 0 
	MOVWF       R0 
	MOVF        R5, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	MOVFF       FARG_tempaverage_temptarget+0, FSR1
	MOVFF       FARG_tempaverage_temptarget+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;function.c,146 :: 		}
L_end_tempaverage:
	RETURN      0
; end of _tempaverage

_AlarmLedOperation:

;function.c,154 :: 		void AlarmLedOperation()
;function.c,156 :: 		if(ActualAlarmNum>0)
	MOVF        _ActualAlarmNum+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_AlarmLedOperation15
;function.c,158 :: 		AlarmEn = 1;
	MOVLW       1
	MOVWF       _AlarmEn+0 
;function.c,159 :: 		}
	GOTO        L_AlarmLedOperation16
L_AlarmLedOperation15:
;function.c,162 :: 		if(spc_system_flag.bite.alarmssr_forceop == ALARMSSR_OK)
	BTFSC       _spc_system_flag+2, 6 
	GOTO        L_AlarmLedOperation17
;function.c,164 :: 		Alarm_SSR_off(0);
	CLRF        FARG_Alarm_SSR_off_ChannelNum+0 
	CALL        _Alarm_SSR_off+0, 0
;function.c,165 :: 		}
L_AlarmLedOperation17:
;function.c,167 :: 		if(pSPCAlarm.spcalarms.num_alarms>0)
	MOVF        _pSPCAlarm+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_AlarmLedOperation18
;function.c,169 :: 		AlarmEn = 0;
	CLRF        _AlarmEn+0 
;function.c,170 :: 		LED_ALARM = 1;
	BSF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;function.c,171 :: 		}
	GOTO        L_AlarmLedOperation19
L_AlarmLedOperation18:
;function.c,174 :: 		AlarmEn = 0;
	CLRF        _AlarmEn+0 
;function.c,175 :: 		LED_ALARM = 0;
	BCF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;function.c,176 :: 		}
L_AlarmLedOperation19:
;function.c,177 :: 		}
L_AlarmLedOperation16:
;function.c,178 :: 		}
L_end_AlarmLedOperation:
	RETURN      0
; end of _AlarmLedOperation

_alarmoperate:

;function.c,180 :: 		void alarmoperate(unsigned long alarmcommand, char active)
;function.c,184 :: 		unsigned long AlarmTypeBuff=0;
	CLRF        alarmoperate_AlarmTypeBuff_L0+0 
	CLRF        alarmoperate_AlarmTypeBuff_L0+1 
	CLRF        alarmoperate_AlarmTypeBuff_L0+2 
	CLRF        alarmoperate_AlarmTypeBuff_L0+3 
	CLRF        alarmoperate_AlarmTypeCount_L0+0 
;function.c,187 :: 		spc_system_flag.bite.stat_update = 1;
	BSF         _spc_system_flag+3, 7 
;function.c,188 :: 		if(active == ENALARM)
	MOVF        FARG_alarmoperate_active+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_alarmoperate20
;function.c,190 :: 		ActivedAlarms |= alarmcommand;
	MOVF        FARG_alarmoperate_alarmcommand+0, 0 
	IORWF       _ActivedAlarms+0, 1 
	MOVF        FARG_alarmoperate_alarmcommand+1, 0 
	IORWF       _ActivedAlarms+1, 1 
	MOVF        FARG_alarmoperate_alarmcommand+2, 0 
	IORWF       _ActivedAlarms+2, 1 
	MOVF        FARG_alarmoperate_alarmcommand+3, 0 
	IORWF       _ActivedAlarms+3, 1 
;function.c,192 :: 		if(pSPCAlarm.spcalarms.num_alarms == MAX_LOGS)
	MOVF        _pSPCAlarm+0, 0 
	XORLW       20
	BTFSS       STATUS+0, 2 
	GOTO        L_alarmoperate21
;function.c,194 :: 		for(i=0;i<MAX_LOGS;i++)
	CLRF        alarmoperate_i_L0+0 
L_alarmoperate22:
	MOVLW       20
	SUBWF       alarmoperate_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_alarmoperate23
;function.c,196 :: 		AlarmTypeBuff = pSPCAlarm.spcalarms.alarm_typ[i];
	MOVF        alarmoperate_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pSPCAlarm+1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_pSPCAlarm+1)
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
	MOVF        R0, 0 
	MOVWF       alarmoperate_AlarmTypeBuff_L0+0 
	MOVF        R1, 0 
	MOVWF       alarmoperate_AlarmTypeBuff_L0+1 
	MOVF        R2, 0 
	MOVWF       alarmoperate_AlarmTypeBuff_L0+2 
	MOVF        R3, 0 
	MOVWF       alarmoperate_AlarmTypeBuff_L0+3 
;function.c,197 :: 		if(!(AlarmTypeBuff & (CH1_GFITRIP+CH2_GFITRIP+SELFCHECKFAILURE+AUTOTESTALARM)))
	MOVLW       0
	ANDWF       R0, 1 
	MOVLW       12
	ANDWF       R1, 1 
	MOVLW       0
	ANDWF       R2, 1 
	MOVLW       48
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_alarmoperate25
;function.c,199 :: 		break;
	GOTO        L_alarmoperate23
;function.c,200 :: 		}
L_alarmoperate25:
;function.c,194 :: 		for(i=0;i<MAX_LOGS;i++)
	INCF        alarmoperate_i_L0+0, 1 
;function.c,201 :: 		}
	GOTO        L_alarmoperate22
L_alarmoperate23:
;function.c,203 :: 		if(ActivedAlarms & AlarmTypeBuff)
	MOVF        alarmoperate_AlarmTypeBuff_L0+0, 0 
	ANDWF       _ActivedAlarms+0, 0 
	MOVWF       R0 
	MOVF        alarmoperate_AlarmTypeBuff_L0+1, 0 
	ANDWF       _ActivedAlarms+1, 0 
	MOVWF       R1 
	MOVF        alarmoperate_AlarmTypeBuff_L0+2, 0 
	ANDWF       _ActivedAlarms+2, 0 
	MOVWF       R2 
	MOVF        alarmoperate_AlarmTypeBuff_L0+3, 0 
	ANDWF       _ActivedAlarms+3, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_alarmoperate26
;function.c,205 :: 		for(j=0;j<MAX_LOGS;j++)
	CLRF        alarmoperate_j_L0+0 
L_alarmoperate27:
	MOVLW       20
	SUBWF       alarmoperate_j_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_alarmoperate28
;function.c,207 :: 		if(pSPCAlarm.spcalarms.alarm_typ[j] == AlarmTypeBuff)
	MOVF        alarmoperate_j_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pSPCAlarm+1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_pSPCAlarm+1)
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
	XORWF       alarmoperate_AlarmTypeBuff_L0+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__alarmoperate257
	MOVF        R3, 0 
	XORWF       alarmoperate_AlarmTypeBuff_L0+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__alarmoperate257
	MOVF        R2, 0 
	XORWF       alarmoperate_AlarmTypeBuff_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__alarmoperate257
	MOVF        R1, 0 
	XORWF       alarmoperate_AlarmTypeBuff_L0+0, 0 
L__alarmoperate257:
	BTFSS       STATUS+0, 2 
	GOTO        L_alarmoperate30
;function.c,208 :: 		AlarmTypeCount++;
	INCF        alarmoperate_AlarmTypeCount_L0+0, 1 
L_alarmoperate30:
;function.c,205 :: 		for(j=0;j<MAX_LOGS;j++)
	INCF        alarmoperate_j_L0+0, 1 
;function.c,209 :: 		}
	GOTO        L_alarmoperate27
L_alarmoperate28:
;function.c,210 :: 		if(AlarmTypeCount == 1)
	MOVF        alarmoperate_AlarmTypeCount_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_alarmoperate31
;function.c,212 :: 		ActivedAlarms &= ~AlarmTypeBuff;
	COMF        alarmoperate_AlarmTypeBuff_L0+0, 0 
	MOVWF       R0 
	COMF        alarmoperate_AlarmTypeBuff_L0+1, 0 
	MOVWF       R1 
	COMF        alarmoperate_AlarmTypeBuff_L0+2, 0 
	MOVWF       R2 
	COMF        alarmoperate_AlarmTypeBuff_L0+3, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	ANDWF       _ActivedAlarms+0, 1 
	MOVF        R1, 0 
	ANDWF       _ActivedAlarms+1, 1 
	MOVF        R2, 0 
	ANDWF       _ActivedAlarms+2, 1 
	MOVF        R3, 0 
	ANDWF       _ActivedAlarms+3, 1 
;function.c,213 :: 		ActualAlarmNum--;
	DECF        _ActualAlarmNum+0, 1 
;function.c,214 :: 		}
L_alarmoperate31:
;function.c,215 :: 		}
L_alarmoperate26:
;function.c,217 :: 		for(; i<MAX_LOGS-1; i++)
L_alarmoperate32:
	MOVLW       19
	SUBWF       alarmoperate_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_alarmoperate33
;function.c,218 :: 		pSPCAlarm.spcalarms.alarm_typ[i] = pSPCAlarm.spcalarms.alarm_typ[i+1];
	MOVF        alarmoperate_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pSPCAlarm+1
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_pSPCAlarm+1)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        alarmoperate_i_L0+0, 0 
	ADDLW       1
	MOVWF       R3 
	CLRF        R4 
	MOVLW       0
	ADDWFC      R4, 1 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pSPCAlarm+1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_pSPCAlarm+1)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;function.c,217 :: 		for(; i<MAX_LOGS-1; i++)
	INCF        alarmoperate_i_L0+0, 1 
;function.c,218 :: 		pSPCAlarm.spcalarms.alarm_typ[i] = pSPCAlarm.spcalarms.alarm_typ[i+1];
	GOTO        L_alarmoperate32
L_alarmoperate33:
;function.c,220 :: 		pSPCAlarm.spcalarms.alarm_typ[MAX_LOGS-1] = alarmcommand;
	MOVF        FARG_alarmoperate_alarmcommand+0, 0 
	MOVWF       _pSPCAlarm+77 
	MOVF        FARG_alarmoperate_alarmcommand+1, 0 
	MOVWF       _pSPCAlarm+78 
	MOVF        FARG_alarmoperate_alarmcommand+2, 0 
	MOVWF       _pSPCAlarm+79 
	MOVF        FARG_alarmoperate_alarmcommand+3, 0 
	MOVWF       _pSPCAlarm+80 
;function.c,221 :: 		ActualAlarmNum++;
	INCF        _ActualAlarmNum+0, 1 
;function.c,222 :: 		Alarm_SSR_on(0);
	CLRF        FARG_Alarm_SSR_on_ChannelNum+0 
	CALL        _Alarm_SSR_on+0, 0
;function.c,223 :: 		}
	GOTO        L_alarmoperate35
L_alarmoperate21:
;function.c,226 :: 		pSPCAlarm.spcalarms.alarm_typ[pSPCAlarm.spcalarms.num_alarms++] = alarmcommand;
	MOVF        _pSPCAlarm+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pSPCAlarm+1
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_pSPCAlarm+1)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        FARG_alarmoperate_alarmcommand+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG_alarmoperate_alarmcommand+1, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG_alarmoperate_alarmcommand+2, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG_alarmoperate_alarmcommand+3, 0 
	MOVWF       POSTINC1+0 
	MOVF        _pSPCAlarm+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _pSPCAlarm+0 
;function.c,227 :: 		ActualAlarmNum++;
	INCF        _ActualAlarmNum+0, 1 
;function.c,228 :: 		Alarm_SSR_on(0);
	CLRF        FARG_Alarm_SSR_on_ChannelNum+0 
	CALL        _Alarm_SSR_on+0, 0
;function.c,230 :: 		SystemUpdate |= ALARM_STAT_UPDATE_REQ;
	BSF         _SystemUpdate+2, 6 
;function.c,231 :: 		alarm_num_temp = pSPCAlarm.spcalarms.num_alarms;
	MOVF        _pSPCAlarm+0, 0 
	MOVWF       alarmoperate_alarm_num_temp_L0+0 
	MOVLW       0
	MOVWF       alarmoperate_alarm_num_temp_L0+1 
;function.c,232 :: 		SetAlarmStr(Actural_disp_str[ACTURAL_ALARM], alarm_num_temp, NULL, UNIT_ALARM, 7, ALARM_INDEX);
	MOVLW       _Actural_disp_str+476
	MOVWF       FARG_SetAlarmStr_prt+0 
	MOVLW       hi_addr(_Actural_disp_str+476)
	MOVWF       FARG_SetAlarmStr_prt+1 
	MOVF        alarmoperate_alarm_num_temp_L0+0, 0 
	MOVWF       FARG_SetAlarmStr_datasouce+0 
	CLRF        FARG_SetAlarmStr_datatotle+0 
	MOVLW       12
	MOVWF       FARG_SetAlarmStr_unitype+0 
	MOVLW       7
	MOVWF       FARG_SetAlarmStr_len+0 
	CLRF        FARG_SetAlarmStr_cmd+0 
	CALL        _SetAlarmStr+0, 0
;function.c,233 :: 		}
L_alarmoperate35:
;function.c,234 :: 		}
	GOTO        L_alarmoperate36
L_alarmoperate20:
;function.c,235 :: 		else if(active == DISALARM)
	MOVF        FARG_alarmoperate_active+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_alarmoperate37
;function.c,237 :: 		ActivedAlarms &= ~alarmcommand;
	COMF        FARG_alarmoperate_alarmcommand+0, 0 
	MOVWF       R0 
	COMF        FARG_alarmoperate_alarmcommand+1, 0 
	MOVWF       R1 
	COMF        FARG_alarmoperate_alarmcommand+2, 0 
	MOVWF       R2 
	COMF        FARG_alarmoperate_alarmcommand+3, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	ANDWF       _ActivedAlarms+0, 1 
	MOVF        R1, 0 
	ANDWF       _ActivedAlarms+1, 1 
	MOVF        R2, 0 
	ANDWF       _ActivedAlarms+2, 1 
	MOVF        R3, 0 
	ANDWF       _ActivedAlarms+3, 1 
;function.c,238 :: 		ActualAlarmNum--;
	DECF        _ActualAlarmNum+0, 1 
;function.c,239 :: 		}
L_alarmoperate37:
L_alarmoperate36:
;function.c,240 :: 		}
L_end_alarmoperate:
	RETURN      0
; end of _alarmoperate

_CopyStr:

;function.c,247 :: 		void CopyStr(char *resource, char *target, char len)
;function.c,250 :: 		for(i=0; i<len; i++)
	CLRF        R1 
L_CopyStr38:
	MOVF        FARG_CopyStr_len+0, 0 
	SUBWF       R1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_CopyStr39
;function.c,251 :: 		*(target+i) = *(resource+i);
	MOVF        R1, 0 
	ADDWF       FARG_CopyStr_target+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_CopyStr_target+1, 0 
	MOVWF       FSR1H 
	MOVF        R1, 0 
	ADDWF       FARG_CopyStr_resource+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_CopyStr_resource+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;function.c,250 :: 		for(i=0; i<len; i++)
	INCF        R1, 1 
;function.c,251 :: 		*(target+i) = *(resource+i);
	GOTO        L_CopyStr38
L_CopyStr39:
;function.c,252 :: 		}
L_end_CopyStr:
	RETURN      0
; end of _CopyStr

_Scantime_EN:

;function.c,259 :: 		void Scantime_EN()
;function.c,261 :: 		spc_count.scanT = 0;
	CLRF        _spc_count+8 
	CLRF        _spc_count+9 
;function.c,262 :: 		spc_system_flag.bite.scantime_en = SCANTIME_START;
	MOVLW       32
	XORWF       _spc_system_flag+1, 0 
	MOVWF       R0 
	MOVLW       96
	ANDWF       R0, 1 
	MOVF        _spc_system_flag+1, 0 
	XORWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _spc_system_flag+1 
;function.c,263 :: 		}
L_end_Scantime_EN:
	RETURN      0
; end of _Scantime_EN

_Scantime_DIS:

;function.c,265 :: 		void Scantime_DIS()
;function.c,267 :: 		spc_count.scanT = 0;
	CLRF        _spc_count+8 
	CLRF        _spc_count+9 
;function.c,268 :: 		spc_system_flag.bite.scantime_en = SCANTIME_IDLE;
	MOVLW       159
	ANDWF       _spc_system_flag+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _spc_system_flag+1 
;function.c,269 :: 		}
L_end_Scantime_DIS:
	RETURN      0
; end of _Scantime_DIS

_Flashing_EN:

;function.c,276 :: 		void Flashing_EN()
;function.c,278 :: 		spc_system_flag.bite.flashing_en = 1;
	BSF         _spc_system_flag+1, 7 
;function.c,279 :: 		}
L_end_Flashing_EN:
	RETURN      0
; end of _Flashing_EN

_Flashing_DIS:

;function.c,281 :: 		void Flashing_DIS()
;function.c,283 :: 		spc_system_flag.bite.flashing_en = 0;
	BCF         _spc_system_flag+1, 7 
;function.c,284 :: 		spc_system_flag.bite.flashing_reach = 0;
	BCF         _spc_system_flag+2, 0 
;function.c,285 :: 		}
L_end_Flashing_DIS:
	RETURN      0
; end of _Flashing_DIS

_Flashing:

;function.c,287 :: 		void Flashing()
;function.c,289 :: 		spc_system_flag.bite.flashing_state ^= 1;
	BTG         _spc_system_flag+2, 1 
;function.c,290 :: 		if(spc_system_flag.bite.flashing_state)
	BTFSS       _spc_system_flag+2, 1 
	GOTO        L_Flashing41
;function.c,291 :: 		LcdOut(2,Info_Line2);
	MOVLW       2
	MOVWF       FARG_LcdOut_num+0 
	MOVLW       _Info_Line2+0
	MOVWF       FARG_LcdOut_line+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_LcdOut_line+1 
	CALL        _LcdOut+0, 0
	GOTO        L_Flashing42
L_Flashing41:
;function.c,293 :: 		LcdOut(2,blank);
	MOVLW       2
	MOVWF       FARG_LcdOut_num+0 
	MOVLW       _blank+0
	MOVWF       FARG_LcdOut_line+0 
	MOVLW       hi_addr(_blank+0)
	MOVWF       FARG_LcdOut_line+1 
	CALL        _LcdOut+0, 0
L_Flashing42:
;function.c,294 :: 		}
L_end_Flashing:
	RETURN      0
; end of _Flashing

_EnableRollInformation:

;function.c,301 :: 		void EnableRollInformation()
;function.c,303 :: 		RollCharactEN=1;
	MOVLW       1
	MOVWF       _RollCharactEN+0 
;function.c,304 :: 		RollCharactCount=0;
	CLRF        _RollCharactCount+0 
	CLRF        _RollCharactCount+1 
;function.c,305 :: 		}
L_end_EnableRollInformation:
	RETURN      0
; end of _EnableRollInformation

_DisableRollInformation:

;function.c,307 :: 		void DisableRollInformation()
;function.c,309 :: 		RollCharactEN=0;
	CLRF        _RollCharactEN+0 
;function.c,310 :: 		RollCharactCount=0;
	CLRF        _RollCharactCount+0 
	CLRF        _RollCharactCount+1 
;function.c,311 :: 		}
L_end_DisableRollInformation:
	RETURN      0
; end of _DisableRollInformation

_RollCharact:

;function.c,314 :: 		void RollCharact()
;function.c,317 :: 		if(spc_system_flag.bite.default_diaped)
	BTFSS       _spc_system_flag+1, 2 
	GOTO        L_RollCharact43
;function.c,319 :: 		if((RollCharactEN == 0) && (pSPCValue[0].SPCSetPoints.system_valueb.bite.def_display != SYSTEM_STATUS_MOD))
	MOVF        _RollCharactEN+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_RollCharact46
	MOVLW       12
	ANDWF       _pSPCValue+139, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	MOVF        R1, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_RollCharact46
L__RollCharact233:
;function.c,321 :: 		RollCharactEN = 1;
	MOVLW       1
	MOVWF       _RollCharactEN+0 
;function.c,322 :: 		RollCharactCount = 0;
	CLRF        _RollCharactCount+0 
	CLRF        _RollCharactCount+1 
;function.c,323 :: 		}
L_RollCharact46:
;function.c,324 :: 		}
	GOTO        L_RollCharact47
L_RollCharact43:
;function.c,327 :: 		RollCharactEN = 0;
	CLRF        _RollCharactEN+0 
;function.c,328 :: 		RollCharactCount = 0;
	CLRF        _RollCharactCount+0 
	CLRF        _RollCharactCount+1 
;function.c,329 :: 		}
L_RollCharact47:
;function.c,331 :: 		if(RollCharactEN == 2)
	MOVF        _RollCharactEN+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_RollCharact48
;function.c,333 :: 		RollCharactEN = 1;
	MOVLW       1
	MOVWF       _RollCharactEN+0 
;function.c,334 :: 		if(RollCharactPointer <= 25)
	MOVF        _RollCharactPointer+0, 0 
	SUBLW       25
	BTFSS       STATUS+0, 0 
	GOTO        L_RollCharact49
;function.c,336 :: 		CopyStr(RollCharactBuff+RollCharactPointer, Info_Line2, 16);
	MOVLW       _RollCharactBuff+0
	MOVWF       FARG_CopyStr_resource+0 
	MOVLW       hi_addr(_RollCharactBuff+0)
	MOVWF       FARG_CopyStr_resource+1 
	MOVF        _RollCharactPointer+0, 0 
	ADDWF       FARG_CopyStr_resource+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FARG_CopyStr_resource+1, 1 
	MOVLW       _Info_Line2+0
	MOVWF       FARG_CopyStr_target+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_CopyStr_target+1 
	MOVLW       16
	MOVWF       FARG_CopyStr_len+0 
	CALL        _CopyStr+0, 0
;function.c,337 :: 		RollCharactPointer++;
	INCF        _RollCharactPointer+0, 1 
;function.c,338 :: 		}
	GOTO        L_RollCharact50
L_RollCharact49:
;function.c,339 :: 		else if(RollCharactPointer <= 40)
	MOVF        _RollCharactPointer+0, 0 
	SUBLW       40
	BTFSS       STATUS+0, 0 
	GOTO        L_RollCharact51
;function.c,341 :: 		temp = 41-RollCharactPointer;
	MOVF        _RollCharactPointer+0, 0 
	SUBLW       41
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       RollCharact_temp_L0+0 
;function.c,342 :: 		CopyStr(RollCharactBuff+RollCharactPointer, Info_Line2, temp);
	MOVLW       _RollCharactBuff+0
	MOVWF       FARG_CopyStr_resource+0 
	MOVLW       hi_addr(_RollCharactBuff+0)
	MOVWF       FARG_CopyStr_resource+1 
	MOVF        _RollCharactPointer+0, 0 
	ADDWF       FARG_CopyStr_resource+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FARG_CopyStr_resource+1, 1 
	MOVLW       _Info_Line2+0
	MOVWF       FARG_CopyStr_target+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_CopyStr_target+1 
	MOVF        R0, 0 
	MOVWF       FARG_CopyStr_len+0 
	CALL        _CopyStr+0, 0
;function.c,343 :: 		CopyStr(RollCharactBuff, Info_Line2+temp, RollCharactPointer-25);
	MOVLW       _RollCharactBuff+0
	MOVWF       FARG_CopyStr_resource+0 
	MOVLW       hi_addr(_RollCharactBuff+0)
	MOVWF       FARG_CopyStr_resource+1 
	MOVLW       _Info_Line2+0
	MOVWF       FARG_CopyStr_target+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_CopyStr_target+1 
	MOVF        RollCharact_temp_L0+0, 0 
	ADDWF       FARG_CopyStr_target+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FARG_CopyStr_target+1, 1 
	MOVLW       25
	SUBWF       _RollCharactPointer+0, 0 
	MOVWF       FARG_CopyStr_len+0 
	CALL        _CopyStr+0, 0
;function.c,344 :: 		RollCharactPointer++;
	INCF        _RollCharactPointer+0, 1 
;function.c,345 :: 		}
	GOTO        L_RollCharact52
L_RollCharact51:
;function.c,348 :: 		RollCharactPointer = 0;
	CLRF        _RollCharactPointer+0 
;function.c,349 :: 		CopyStr(RollCharactBuff+RollCharactPointer, Info_Line2, 16);
	MOVLW       _RollCharactBuff+0
	MOVWF       FARG_CopyStr_resource+0 
	MOVLW       hi_addr(_RollCharactBuff+0)
	MOVWF       FARG_CopyStr_resource+1 
	MOVF        _RollCharactPointer+0, 0 
	ADDWF       FARG_CopyStr_resource+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FARG_CopyStr_resource+1, 1 
	MOVLW       _Info_Line2+0
	MOVWF       FARG_CopyStr_target+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_CopyStr_target+1 
	MOVLW       16
	MOVWF       FARG_CopyStr_len+0 
	CALL        _CopyStr+0, 0
;function.c,350 :: 		}
L_RollCharact52:
L_RollCharact50:
;function.c,351 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
;function.c,352 :: 		}
L_RollCharact48:
;function.c,353 :: 		}
L_end_RollCharact:
	RETURN      0
; end of _RollCharact

_SetDefaultInformation:

;function.c,356 :: 		void SetDefaultInformation()
;function.c,358 :: 		char pointer=0;
	CLRF        SetDefaultInformation_pointer_L0+0 
	CLRF        SetDefaultInformation_i_L0+0 
;function.c,361 :: 		for(i=0;i<4;i++)
	CLRF        SetDefaultInformation_i_L0+0 
L_SetDefaultInformation53:
	MOVLW       4
	SUBWF       SetDefaultInformation_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SetDefaultInformation54
;function.c,362 :: 		RollCharactBuff[pointer++] = Channel1_Str[i];
	MOVLW       _RollCharactBuff+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_RollCharactBuff+0)
	MOVWF       FSR1H 
	MOVF        SetDefaultInformation_pointer_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       _Channel1_Str+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_Channel1_Str+0)
	MOVWF       FSR0H 
	MOVF        SetDefaultInformation_i_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	INCF        SetDefaultInformation_pointer_L0+0, 1 
;function.c,361 :: 		for(i=0;i<4;i++)
	INCF        SetDefaultInformation_i_L0+0, 1 
;function.c,362 :: 		RollCharactBuff[pointer++] = Channel1_Str[i];
	GOTO        L_SetDefaultInformation53
L_SetDefaultInformation54:
;function.c,364 :: 		pointer+=16;
	MOVLW       16
	ADDWF       SetDefaultInformation_pointer_L0+0, 1 
;function.c,365 :: 		for(i=0;i<5;i++)
	CLRF        SetDefaultInformation_i_L0+0 
L_SetDefaultInformation56:
	MOVLW       5
	SUBWF       SetDefaultInformation_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SetDefaultInformation57
;function.c,366 :: 		RollCharactBuff[pointer++] = Channel2_Str[i];
	MOVLW       _RollCharactBuff+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_RollCharactBuff+0)
	MOVWF       FSR1H 
	MOVF        SetDefaultInformation_pointer_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       _Channel2_Str+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_Channel2_Str+0)
	MOVWF       FSR0H 
	MOVF        SetDefaultInformation_i_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	INCF        SetDefaultInformation_pointer_L0+0, 1 
;function.c,365 :: 		for(i=0;i<5;i++)
	INCF        SetDefaultInformation_i_L0+0, 1 
;function.c,366 :: 		RollCharactBuff[pointer++] = Channel2_Str[i];
	GOTO        L_SetDefaultInformation56
L_SetDefaultInformation57:
;function.c,368 :: 		pointer = 4;
	MOVLW       4
	MOVWF       SetDefaultInformation_pointer_L0+0 
;function.c,370 :: 		if(pSPCValue[0].SPCSetPoints.system_valueb.bite.def_display == HEATER_TEMP_MOD)
	MOVLW       12
	ANDWF       _pSPCValue+139, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	MOVF        R1, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_SetDefaultInformation59
;function.c,372 :: 		if(pSPCValue[0].SPCSetPoints.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_OFF)
	MOVF        _pSPCValue+57, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__SetDefaultInformation268
	MOVLW       255
	XORWF       _pSPCValue+56, 0 
L__SetDefaultInformation268:
	BTFSS       STATUS+0, 2 
	GOTO        L_SetDefaultInformation60
;function.c,373 :: 		getParaChar(RollCharactBuff+pointer, NONEVALUE_STR);
	MOVLW       _RollCharactBuff+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_RollCharactBuff+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVF        SetDefaultInformation_pointer_L0+0, 0 
	ADDWF       FARG_getParaChar_ptr+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FARG_getParaChar_ptr+1, 1 
	MOVLW       89
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
	GOTO        L_SetDefaultInformation61
L_SetDefaultInformation60:
;function.c,375 :: 		CopyStr(Actural_disp_str[CH1_ACTURAL_ALL],RollCharactBuff+pointer,16);
	MOVLW       _Actural_disp_str+102
	MOVWF       FARG_CopyStr_resource+0 
	MOVLW       hi_addr(_Actural_disp_str+102)
	MOVWF       FARG_CopyStr_resource+1 
	MOVLW       _RollCharactBuff+0
	MOVWF       FARG_CopyStr_target+0 
	MOVLW       hi_addr(_RollCharactBuff+0)
	MOVWF       FARG_CopyStr_target+1 
	MOVF        SetDefaultInformation_pointer_L0+0, 0 
	ADDWF       FARG_CopyStr_target+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FARG_CopyStr_target+1, 1 
	MOVLW       16
	MOVWF       FARG_CopyStr_len+0 
	CALL        _CopyStr+0, 0
L_SetDefaultInformation61:
;function.c,377 :: 		pointer += 21;
	MOVLW       21
	ADDWF       SetDefaultInformation_pointer_L0+0, 1 
;function.c,379 :: 		if(pSPCValue[1].SPCSetPoints.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_OFF)
	MOVF        _pSPCValue+199, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__SetDefaultInformation269
	MOVLW       255
	XORWF       _pSPCValue+198, 0 
L__SetDefaultInformation269:
	BTFSS       STATUS+0, 2 
	GOTO        L_SetDefaultInformation62
;function.c,380 :: 		getParaChar(RollCharactBuff+pointer, NONEVALUE_STR);
	MOVLW       _RollCharactBuff+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_RollCharactBuff+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVF        SetDefaultInformation_pointer_L0+0, 0 
	ADDWF       FARG_getParaChar_ptr+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FARG_getParaChar_ptr+1, 1 
	MOVLW       89
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
	GOTO        L_SetDefaultInformation63
L_SetDefaultInformation62:
;function.c,382 :: 		CopyStr(Actural_disp_str[CH2_ACTURAL_ALL],RollCharactBuff+pointer,16);
	MOVLW       _Actural_disp_str+119
	MOVWF       FARG_CopyStr_resource+0 
	MOVLW       hi_addr(_Actural_disp_str+119)
	MOVWF       FARG_CopyStr_resource+1 
	MOVLW       _RollCharactBuff+0
	MOVWF       FARG_CopyStr_target+0 
	MOVLW       hi_addr(_RollCharactBuff+0)
	MOVWF       FARG_CopyStr_target+1 
	MOVF        SetDefaultInformation_pointer_L0+0, 0 
	ADDWF       FARG_CopyStr_target+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FARG_CopyStr_target+1, 1 
	MOVLW       16
	MOVWF       FARG_CopyStr_len+0 
	CALL        _CopyStr+0, 0
L_SetDefaultInformation63:
;function.c,383 :: 		}
	GOTO        L_SetDefaultInformation64
L_SetDefaultInformation59:
;function.c,384 :: 		else if(pSPCValue[0].SPCSetPoints.system_valueb.bite.def_display == HEATER_STATUS_MOD)
	MOVLW       12
	ANDWF       _pSPCValue+139, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	MOVF        R1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SetDefaultInformation65
;function.c,386 :: 		CopyStr(Actural_disp_str[CH1_ACTURAL_HEAT],RollCharactBuff+pointer,16);
	MOVLW       _Actural_disp_str+272
	MOVWF       FARG_CopyStr_resource+0 
	MOVLW       hi_addr(_Actural_disp_str+272)
	MOVWF       FARG_CopyStr_resource+1 
	MOVLW       _RollCharactBuff+0
	MOVWF       FARG_CopyStr_target+0 
	MOVLW       hi_addr(_RollCharactBuff+0)
	MOVWF       FARG_CopyStr_target+1 
	MOVF        SetDefaultInformation_pointer_L0+0, 0 
	ADDWF       FARG_CopyStr_target+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FARG_CopyStr_target+1, 1 
	MOVLW       16
	MOVWF       FARG_CopyStr_len+0 
	CALL        _CopyStr+0, 0
;function.c,387 :: 		pointer += 21;
	MOVLW       21
	ADDWF       SetDefaultInformation_pointer_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       SetDefaultInformation_pointer_L0+0 
;function.c,388 :: 		CopyStr(Actural_disp_str[CH2_ACTURAL_HEAT],RollCharactBuff+pointer,16);
	MOVLW       _Actural_disp_str+289
	MOVWF       FARG_CopyStr_resource+0 
	MOVLW       hi_addr(_Actural_disp_str+289)
	MOVWF       FARG_CopyStr_resource+1 
	MOVLW       _RollCharactBuff+0
	MOVWF       FARG_CopyStr_target+0 
	MOVLW       hi_addr(_RollCharactBuff+0)
	MOVWF       FARG_CopyStr_target+1 
	MOVF        R0, 0 
	ADDWF       FARG_CopyStr_target+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FARG_CopyStr_target+1, 1 
	MOVLW       16
	MOVWF       FARG_CopyStr_len+0 
	CALL        _CopyStr+0, 0
;function.c,389 :: 		}
L_SetDefaultInformation65:
L_SetDefaultInformation64:
;function.c,390 :: 		}
L_end_SetDefaultInformation:
	RETURN      0
; end of _SetDefaultInformation

_disp_default:

;function.c,392 :: 		void disp_default()
;function.c,397 :: 		if(GFITestCmd[0] || GFITestCmd[1])
	MOVF        _GFITestCmd+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__disp_default234
	MOVF        _GFITestCmd+1, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__disp_default234
	GOTO        L_disp_default68
L__disp_default234:
;function.c,398 :: 		return;
	GOTO        L_end_disp_default
L_disp_default68:
;function.c,400 :: 		if(DisplayApp == 0)
	MOVF        disp_default_DisplayApp_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_disp_default69
;function.c,402 :: 		if(spc_system_flag.bite.default_diaped == 1)
	BTFSS       _spc_system_flag+1, 2 
	GOTO        L_disp_default70
;function.c,404 :: 		DisplayApp = 1;
	MOVLW       1
	MOVWF       disp_default_DisplayApp_L0+0 
;function.c,405 :: 		ChannelSelStat = CH_SEL_RESET;
	CLRF        _ChannelSelStat+0 
;function.c,406 :: 		}
	GOTO        L_disp_default71
L_disp_default70:
;function.c,409 :: 		DisplayApp = 0;
	CLRF        disp_default_DisplayApp_L0+0 
;function.c,410 :: 		return;
	GOTO        L_end_disp_default
;function.c,411 :: 		}
L_disp_default71:
;function.c,412 :: 		}
	GOTO        L_disp_default72
L_disp_default69:
;function.c,415 :: 		if(spc_system_flag.bite.default_diaped == 0)
	BTFSC       _spc_system_flag+1, 2 
	GOTO        L_disp_default73
;function.c,417 :: 		DisplayApp = 0;
	CLRF        disp_default_DisplayApp_L0+0 
;function.c,418 :: 		}
L_disp_default73:
;function.c,419 :: 		return;
	GOTO        L_end_disp_default
;function.c,420 :: 		}
L_disp_default72:
;function.c,422 :: 		Menustat = 0;
	CLRF        _Menustat+0 
;function.c,423 :: 		Alarmstat = 0;
	CLRF        _Alarmstat+0 
;function.c,424 :: 		spc_system_flag.bite.alarm_actived = 0;
	BCF         _spc_system_flag+1, 0 
;function.c,425 :: 		reset_psw_en = 0;
	CLRF        _reset_psw_en+0 
;function.c,426 :: 		spc_system_flag.bite.char_actived = 0;
	BCF         _spc_system_flag+1, 3 
;function.c,427 :: 		Flashing_DIS();
	CALL        _Flashing_DIS+0, 0
;function.c,428 :: 		spc_system_flag.bite.char_flash = 0;
	BCF         _spc_system_flag+3, 6 
;function.c,429 :: 		DisablePSWInputing();
	CALL        _DisablePSWInputing+0, 0
;function.c,430 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;function.c,432 :: 		if(pSPCValue[0].SPCSetPoints.system_valueb.bite.def_display == HEATER_TEMP_MOD)
	MOVLW       12
	ANDWF       _pSPCValue+139, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	MOVF        R1, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_disp_default74
;function.c,434 :: 		if(spc_system_flag.bite.stat_update)
	BTFSS       _spc_system_flag+3, 7 
	GOTO        L_disp_default75
;function.c,436 :: 		spc_system_flag.bite.stat_update = 0;
	BCF         _spc_system_flag+3, 7 
;function.c,437 :: 		getParaChar(Info_Line1, DEFAULT_HEATERTEMP_STR);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       86
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;function.c,439 :: 		ClearStr(RollCharactBuff,41);
	MOVLW       _RollCharactBuff+0
	MOVWF       FARG_ClearStr_target+0 
	MOVLW       hi_addr(_RollCharactBuff+0)
	MOVWF       FARG_ClearStr_target+1 
	MOVLW       41
	MOVWF       FARG_ClearStr_len+0 
	MOVLW       0
	MOVWF       FARG_ClearStr_len+1 
	CALL        _ClearStr+0, 0
;function.c,440 :: 		SetDefaultInformation();
	CALL        _SetDefaultInformation+0, 0
;function.c,447 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
;function.c,448 :: 		}
L_disp_default75:
;function.c,449 :: 		}
	GOTO        L_disp_default76
L_disp_default74:
;function.c,450 :: 		else if(pSPCValue[0].SPCSetPoints.system_valueb.bite.def_display == HEATER_STATUS_MOD)
	MOVLW       12
	ANDWF       _pSPCValue+139, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	MOVF        R1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_disp_default77
;function.c,452 :: 		if(spc_system_flag.bite.stat_update)
	BTFSS       _spc_system_flag+3, 7 
	GOTO        L_disp_default78
;function.c,454 :: 		spc_system_flag.bite.stat_update = 0;
	BCF         _spc_system_flag+3, 7 
;function.c,455 :: 		getParaChar(Info_Line1, DEFAULT_HEATERSTATUS_STR);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       87
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;function.c,457 :: 		ClearStr(RollCharactBuff,41);
	MOVLW       _RollCharactBuff+0
	MOVWF       FARG_ClearStr_target+0 
	MOVLW       hi_addr(_RollCharactBuff+0)
	MOVWF       FARG_ClearStr_target+1 
	MOVLW       41
	MOVWF       FARG_ClearStr_len+0 
	MOVLW       0
	MOVWF       FARG_ClearStr_len+1 
	CALL        _ClearStr+0, 0
;function.c,458 :: 		SetDefaultInformation();
	CALL        _SetDefaultInformation+0, 0
;function.c,459 :: 		EnableRollInformation();
	CALL        _EnableRollInformation+0, 0
;function.c,463 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
;function.c,464 :: 		}
L_disp_default78:
;function.c,465 :: 		}
	GOTO        L_disp_default79
L_disp_default77:
;function.c,468 :: 		if(spc_system_flag.bite.stat_update)
	BTFSS       _spc_system_flag+3, 7 
	GOTO        L_disp_default80
;function.c,471 :: 		spc_system_flag.bite.stat_update = 0;
	BCF         _spc_system_flag+3, 7 
;function.c,472 :: 		getParaChar(Info_Line1, DEFAULT_SYSTEMSTATUS_STR);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       88
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;function.c,473 :: 		SetAlarmStr(Info_Line2, pSPCAlarm.spcalarms.num_alarms, NULL, UNIT_ALARM, 7, ALARM_INDEX);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_SetAlarmStr_prt+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_SetAlarmStr_prt+1 
	MOVF        _pSPCAlarm+0, 0 
	MOVWF       FARG_SetAlarmStr_datasouce+0 
	CLRF        FARG_SetAlarmStr_datatotle+0 
	MOVLW       12
	MOVWF       FARG_SetAlarmStr_unitype+0 
	MOVLW       7
	MOVWF       FARG_SetAlarmStr_len+0 
	CLRF        FARG_SetAlarmStr_cmd+0 
	CALL        _SetAlarmStr+0, 0
;function.c,474 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
;function.c,475 :: 		}
L_disp_default80:
;function.c,476 :: 		}
L_disp_default79:
L_disp_default76:
;function.c,477 :: 		}
L_end_disp_default:
	RETURN      0
; end of _disp_default

_dispupdate:

;function.c,484 :: 		void dispupdate()
;function.c,489 :: 		char bUpdate=0;
	CLRF        dispupdate_bUpdate_L0+0 
	CLRF        dispupdate_Length_L0+0 
	CLRF        dispupdate_Length_L0+1 
	CLRF        dispupdate_Length_L0+2 
	CLRF        dispupdate_Length_L0+3 
;function.c,494 :: 		if(spc_system_flag.bite.alarm_actived)
	BTFSS       _spc_system_flag+1, 0 
	GOTO        L_dispupdate81
;function.c,495 :: 		return;
	GOTO        L_end_dispupdate
L_dispupdate81:
;function.c,496 :: 		if(reset_psw_en)
	MOVF        _reset_psw_en+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_dispupdate82
;function.c,497 :: 		return;
	GOTO        L_end_dispupdate
L_dispupdate82:
;function.c,498 :: 		if(GFITestCmd[0] || GFITestCmd[1])
	MOVF        _GFITestCmd+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__dispupdate235
	MOVF        _GFITestCmd+1, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__dispupdate235
	GOTO        L_dispupdate85
L__dispupdate235:
;function.c,499 :: 		return;
	GOTO        L_end_dispupdate
L_dispupdate85:
;function.c,501 :: 		if(spc_system_flag.bite.default_diaped == 1)
	BTFSS       _spc_system_flag+1, 2 
	GOTO        L_dispupdate86
;function.c,503 :: 		if(pSPCValue[0].SPCSetPoints.system_valueb.bite.def_display == HEATER_TEMP_MOD)
	MOVLW       12
	ANDWF       _pSPCValue+139, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	MOVF        R1, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_dispupdate87
;function.c,508 :: 		if(SystemUpdate & CH1_TEMP_UPDATE_REQ)
	BTFSS       _SystemUpdate+1, 2 
	GOTO        L_dispupdate88
;function.c,511 :: 		SetDefaultInformation();
	CALL        _SetDefaultInformation+0, 0
;function.c,515 :: 		SystemUpdate &= ~CH1_TEMP_UPDATE_REQ;
	MOVLW       255
	ANDWF       _SystemUpdate+0, 1 
	MOVLW       251
	ANDWF       _SystemUpdate+1, 1 
	MOVLW       255
	ANDWF       _SystemUpdate+2, 1 
	MOVLW       255
	ANDWF       _SystemUpdate+3, 1 
;function.c,516 :: 		bUpdate = 1;
	MOVLW       1
	MOVWF       dispupdate_bUpdate_L0+0 
;function.c,518 :: 		}
L_dispupdate88:
;function.c,520 :: 		if(SystemUpdate & CH2_TEMP_UPDATE_REQ)
	BTFSS       _SystemUpdate+1, 3 
	GOTO        L_dispupdate89
;function.c,523 :: 		SetDefaultInformation();
	CALL        _SetDefaultInformation+0, 0
;function.c,527 :: 		SystemUpdate &= ~CH2_TEMP_UPDATE_REQ;
	MOVLW       255
	ANDWF       _SystemUpdate+0, 1 
	MOVLW       247
	ANDWF       _SystemUpdate+1, 1 
	MOVLW       255
	ANDWF       _SystemUpdate+2, 1 
	MOVLW       255
	ANDWF       _SystemUpdate+3, 1 
;function.c,528 :: 		bUpdate = 1;
	MOVLW       1
	MOVWF       dispupdate_bUpdate_L0+0 
;function.c,529 :: 		}
L_dispupdate89:
;function.c,530 :: 		}
	GOTO        L_dispupdate90
L_dispupdate87:
;function.c,531 :: 		else if(pSPCValue[Cable_Channel].SPCSetPoints.system_valueb.bite.def_display == HEATER_STATUS_MOD)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        _Cable_Channel+0, 0 
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
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVLW       12
	ANDWF       POSTINC0+0, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	MOVF        R1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_dispupdate91
;function.c,533 :: 		if(SystemUpdate & CH1_HEAT_STAT_UPDATE_REQ)
	BTFSS       _SystemUpdate+2, 4 
	GOTO        L_dispupdate92
;function.c,536 :: 		SetDefaultInformation();
	CALL        _SetDefaultInformation+0, 0
;function.c,540 :: 		SystemUpdate &= ~CH1_HEAT_STAT_UPDATE_REQ;
	MOVLW       255
	ANDWF       _SystemUpdate+0, 1 
	MOVLW       255
	ANDWF       _SystemUpdate+1, 1 
	MOVLW       239
	ANDWF       _SystemUpdate+2, 1 
	MOVLW       255
	ANDWF       _SystemUpdate+3, 1 
;function.c,542 :: 		bUpdate = 1;
	MOVLW       1
	MOVWF       dispupdate_bUpdate_L0+0 
;function.c,543 :: 		}
L_dispupdate92:
;function.c,545 :: 		if(SystemUpdate & CH2_HEAT_STAT_UPDATE_REQ)
	BTFSS       _SystemUpdate+2, 5 
	GOTO        L_dispupdate93
;function.c,548 :: 		SetDefaultInformation();
	CALL        _SetDefaultInformation+0, 0
;function.c,552 :: 		SystemUpdate &= ~CH2_HEAT_STAT_UPDATE_REQ;
	MOVLW       255
	ANDWF       _SystemUpdate+0, 1 
	MOVLW       255
	ANDWF       _SystemUpdate+1, 1 
	MOVLW       223
	ANDWF       _SystemUpdate+2, 1 
	MOVLW       255
	ANDWF       _SystemUpdate+3, 1 
;function.c,554 :: 		bUpdate = 1;
	MOVLW       1
	MOVWF       dispupdate_bUpdate_L0+0 
;function.c,555 :: 		}
L_dispupdate93:
;function.c,556 :: 		}
	GOTO        L_dispupdate94
L_dispupdate91:
;function.c,561 :: 		if(SystemUpdate & ALARM_STAT_UPDATE_REQ)
	BTFSS       _SystemUpdate+2, 6 
	GOTO        L_dispupdate95
;function.c,563 :: 		CopyStr(Actural_disp_str[ACTURAL_ALARM],Info_Line2,16);
	MOVLW       _Actural_disp_str+476
	MOVWF       FARG_CopyStr_resource+0 
	MOVLW       hi_addr(_Actural_disp_str+476)
	MOVWF       FARG_CopyStr_resource+1 
	MOVLW       _Info_Line2+0
	MOVWF       FARG_CopyStr_target+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_CopyStr_target+1 
	MOVLW       16
	MOVWF       FARG_CopyStr_len+0 
	CALL        _CopyStr+0, 0
;function.c,564 :: 		SystemUpdate &= ~ALARM_STAT_UPDATE_REQ;
	MOVLW       255
	ANDWF       _SystemUpdate+0, 1 
	MOVLW       255
	ANDWF       _SystemUpdate+1, 1 
	MOVLW       191
	ANDWF       _SystemUpdate+2, 1 
	MOVLW       255
	ANDWF       _SystemUpdate+3, 1 
;function.c,566 :: 		bUpdate = 1;
	MOVLW       1
	MOVWF       dispupdate_bUpdate_L0+0 
;function.c,567 :: 		}
L_dispupdate95:
;function.c,568 :: 		}
L_dispupdate94:
L_dispupdate90:
;function.c,570 :: 		if(bUpdate)
	MOVF        dispupdate_bUpdate_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_dispupdate96
;function.c,571 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
L_dispupdate96:
;function.c,572 :: 		return;
	GOTO        L_end_dispupdate
;function.c,573 :: 		}
L_dispupdate86:
;function.c,575 :: 		if(SpcMenu[Menustat].index == MENU_IN_ACTUAL)
	MOVLW       19
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        _Menustat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       function_SpcMenu+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(function_SpcMenu+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(function_SpcMenu+0)
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R1
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_dispupdate97
;function.c,577 :: 		if(SpcMenu[Menustat].len & MULTI_CH_REQ)
	MOVLW       19
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        _Menustat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       function_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(function_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(function_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R4
	TBLRD*+
	MOVFF       TABLAT+0, R5
	TBLRD*+
	MOVFF       TABLAT+0, R6
	TBLRD*+
	MOVFF       TABLAT+0, R7
	BTFSS       R7, 7 
	GOTO        L_dispupdate98
;function.c,579 :: 		Length =  SpcMenu[Menustat].len;
	MOVLW       19
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        _Menustat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       function_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(function_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(function_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R4
	TBLRD*+
	MOVFF       TABLAT+0, R5
	TBLRD*+
	MOVFF       TABLAT+0, R6
	TBLRD*+
	MOVFF       TABLAT+0, R7
	MOVF        R4, 0 
	MOVWF       dispupdate_Length_L0+0 
	MOVF        R5, 0 
	MOVWF       dispupdate_Length_L0+1 
	MOVF        R6, 0 
	MOVWF       dispupdate_Length_L0+2 
	MOVF        R7, 0 
	MOVWF       dispupdate_Length_L0+3 
;function.c,580 :: 		LTemp = MULTI_CH_REQ;
	MOVLW       0
	MOVWF       dispupdate_LTemp_L0+0 
	MOVLW       0
	MOVWF       dispupdate_LTemp_L0+1 
	MOVLW       0
	MOVWF       dispupdate_LTemp_L0+2 
	MOVLW       128
	MOVWF       dispupdate_LTemp_L0+3 
;function.c,581 :: 		Length &= ~LTemp;
	COMF        dispupdate_LTemp_L0+0, 0 
	MOVWF       R0 
	COMF        dispupdate_LTemp_L0+1, 0 
	MOVWF       R1 
	COMF        dispupdate_LTemp_L0+2, 0 
	MOVWF       R2 
	COMF        dispupdate_LTemp_L0+3, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	ANDWF       R4, 0 
	MOVWF       R8 
	MOVF        R1, 0 
	ANDWF       R5, 0 
	MOVWF       R9 
	MOVF        R2, 0 
	ANDWF       R6, 0 
	MOVWF       R10 
	MOVF        R3, 0 
	ANDWF       R7, 0 
	MOVWF       R11 
	MOVF        R8, 0 
	MOVWF       dispupdate_Length_L0+0 
	MOVF        R9, 0 
	MOVWF       dispupdate_Length_L0+1 
	MOVF        R10, 0 
	MOVWF       dispupdate_Length_L0+2 
	MOVF        R11, 0 
	MOVWF       dispupdate_Length_L0+3 
;function.c,582 :: 		Length <<= Cable_Channel;
	MOVF        _Cable_Channel+0, 0 
	MOVWF       R4 
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R10, 0 
	MOVWF       R2 
	MOVF        R11, 0 
	MOVWF       R3 
	MOVF        R4, 0 
L__dispupdate272:
	BZ          L__dispupdate273
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__dispupdate272
L__dispupdate273:
	MOVF        R0, 0 
	MOVWF       dispupdate_Length_L0+0 
	MOVF        R1, 0 
	MOVWF       dispupdate_Length_L0+1 
	MOVF        R2, 0 
	MOVWF       dispupdate_Length_L0+2 
	MOVF        R3, 0 
	MOVWF       dispupdate_Length_L0+3 
;function.c,583 :: 		if(SystemUpdate & Length)
	MOVF        _SystemUpdate+0, 0 
	ANDWF       R0, 1 
	MOVF        _SystemUpdate+1, 0 
	ANDWF       R1, 1 
	MOVF        _SystemUpdate+2, 0 
	ANDWF       R2, 1 
	MOVF        _SystemUpdate+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_dispupdate99
;function.c,585 :: 		temp = SpcMenu[Menustat].offset+Cable_Channel;
	MOVLW       19
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        _Menustat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       function_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(function_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(function_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        _Cable_Channel+0, 0 
	ADDWF       R0, 1 
;function.c,586 :: 		CopyStr(Actural_disp_str[temp],Info_Line2,16);
	MOVLW       0
	MOVWF       R1 
	MOVLW       17
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 0 
	MOVWF       FARG_CopyStr_resource+0 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_CopyStr_resource+1 
	MOVLW       _Info_Line2+0
	MOVWF       FARG_CopyStr_target+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_CopyStr_target+1 
	MOVLW       16
	MOVWF       FARG_CopyStr_len+0 
	CALL        _CopyStr+0, 0
;function.c,587 :: 		SystemUpdate &= ~Length;
	COMF        dispupdate_Length_L0+0, 0 
	MOVWF       R0 
	COMF        dispupdate_Length_L0+1, 0 
	MOVWF       R1 
	COMF        dispupdate_Length_L0+2, 0 
	MOVWF       R2 
	COMF        dispupdate_Length_L0+3, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	ANDWF       _SystemUpdate+0, 1 
	MOVF        R1, 0 
	ANDWF       _SystemUpdate+1, 1 
	MOVF        R2, 0 
	ANDWF       _SystemUpdate+2, 1 
	MOVF        R3, 0 
	ANDWF       _SystemUpdate+3, 1 
;function.c,588 :: 		Info_Line2[14] = 'C';
	MOVLW       67
	MOVWF       _Info_Line2+14 
;function.c,589 :: 		Info_Line2[15] = Cable_Channel+0X31;
	MOVLW       49
	ADDWF       _Cable_Channel+0, 0 
	MOVWF       _Info_Line2+15 
;function.c,590 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
;function.c,591 :: 		}
L_dispupdate99:
;function.c,592 :: 		}
	GOTO        L_dispupdate100
L_dispupdate98:
;function.c,595 :: 		if(SystemUpdate & SpcMenu[Menustat].len)
	MOVLW       19
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        _Menustat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       function_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(function_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(function_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	TBLRD*+
	MOVFF       TABLAT+0, R1
	TBLRD*+
	MOVFF       TABLAT+0, R2
	TBLRD*+
	MOVFF       TABLAT+0, R3
	MOVF        _SystemUpdate+0, 0 
	ANDWF       R0, 1 
	MOVF        _SystemUpdate+1, 0 
	ANDWF       R1, 1 
	MOVF        _SystemUpdate+2, 0 
	ANDWF       R2, 1 
	MOVF        _SystemUpdate+3, 0 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_dispupdate101
;function.c,597 :: 		temp = SpcMenu[Menustat].offset;
	MOVLW       19
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        _Menustat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       function_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(function_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(function_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
;function.c,598 :: 		CopyStr(Actural_disp_str[temp],Info_Line2,16);
	MOVLW       0
	MOVWF       R1 
	MOVLW       17
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 0 
	MOVWF       FARG_CopyStr_resource+0 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_CopyStr_resource+1 
	MOVLW       _Info_Line2+0
	MOVWF       FARG_CopyStr_target+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_CopyStr_target+1 
	MOVLW       16
	MOVWF       FARG_CopyStr_len+0 
	CALL        _CopyStr+0, 0
;function.c,599 :: 		SystemUpdate &= ~SpcMenu[Menustat].len;
	MOVLW       19
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        _Menustat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       function_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(function_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(function_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	TBLRD*+
	MOVFF       TABLAT+0, R1
	TBLRD*+
	MOVFF       TABLAT+0, R2
	TBLRD*+
	MOVFF       TABLAT+0, R3
	COMF        R0, 1 
	COMF        R1, 1 
	COMF        R2, 1 
	COMF        R3, 1 
	MOVF        R0, 0 
	ANDWF       _SystemUpdate+0, 1 
	MOVF        R1, 0 
	ANDWF       _SystemUpdate+1, 1 
	MOVF        R2, 0 
	ANDWF       _SystemUpdate+2, 1 
	MOVF        R3, 0 
	ANDWF       _SystemUpdate+3, 1 
;function.c,600 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
;function.c,601 :: 		}
L_dispupdate101:
;function.c,602 :: 		}
L_dispupdate100:
;function.c,603 :: 		}
L_dispupdate97:
;function.c,604 :: 		}
L_end_dispupdate:
	RETURN      0
; end of _dispupdate

_alarmdispupdate:

;function.c,611 :: 		void alarmdispupdate()
;function.c,613 :: 		if(spc_system_flag.bite.alarm_actived)
	BTFSS       _spc_system_flag+1, 0 
	GOTO        L_alarmdispupdate102
;function.c,615 :: 		if(spc_system_flag.bite.alarm_displayed == 0)
	BTFSC       _spc_system_flag+0, 7 
	GOTO        L_alarmdispupdate103
;function.c,617 :: 		if(SystemUpdate & ALARM_STAT_UPDATE_REQ)
	BTFSS       _SystemUpdate+2, 6 
	GOTO        L_alarmdispupdate104
;function.c,619 :: 		CopyStr(Actural_disp_str[ACTURAL_ALARM],Info_Line1,16);
	MOVLW       _Actural_disp_str+476
	MOVWF       FARG_CopyStr_resource+0 
	MOVLW       hi_addr(_Actural_disp_str+476)
	MOVWF       FARG_CopyStr_resource+1 
	MOVLW       _Info_Line1+0
	MOVWF       FARG_CopyStr_target+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_CopyStr_target+1 
	MOVLW       16
	MOVWF       FARG_CopyStr_len+0 
	CALL        _CopyStr+0, 0
;function.c,620 :: 		SystemUpdate &= ~ALARM_STAT_UPDATE_REQ;
	MOVLW       255
	ANDWF       _SystemUpdate+0, 1 
	MOVLW       255
	ANDWF       _SystemUpdate+1, 1 
	MOVLW       191
	ANDWF       _SystemUpdate+2, 1 
	MOVLW       255
	ANDWF       _SystemUpdate+3, 1 
;function.c,621 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
;function.c,622 :: 		}
L_alarmdispupdate104:
;function.c,623 :: 		}
L_alarmdispupdate103:
;function.c,625 :: 		if(SystemUpdate & ALARM_STAT_UPDATE_REQ)
	BTFSS       _SystemUpdate+2, 6 
	GOTO        L_alarmdispupdate105
;function.c,627 :: 		if(spc_system_flag.bite.alarm_displayed)
	BTFSS       _spc_system_flag+0, 7 
	GOTO        L_alarmdispupdate106
;function.c,629 :: 		SystemUpdate &= ~ALARM_STAT_UPDATE_REQ;
	MOVLW       255
	ANDWF       _SystemUpdate+0, 1 
	MOVLW       255
	ANDWF       _SystemUpdate+1, 1 
	MOVLW       191
	ANDWF       _SystemUpdate+2, 1 
	MOVLW       255
	ANDWF       _SystemUpdate+3, 1 
;function.c,630 :: 		}
	GOTO        L_alarmdispupdate107
L_alarmdispupdate106:
;function.c,633 :: 		CopyStr(Actural_disp_str[ACTURAL_ALARM],Info_Line1,16);
	MOVLW       _Actural_disp_str+476
	MOVWF       FARG_CopyStr_resource+0 
	MOVLW       hi_addr(_Actural_disp_str+476)
	MOVWF       FARG_CopyStr_resource+1 
	MOVLW       _Info_Line1+0
	MOVWF       FARG_CopyStr_target+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_CopyStr_target+1 
	MOVLW       16
	MOVWF       FARG_CopyStr_len+0 
	CALL        _CopyStr+0, 0
;function.c,634 :: 		SystemUpdate &= ~ALARM_STAT_UPDATE_REQ;
	MOVLW       255
	ANDWF       _SystemUpdate+0, 1 
	MOVLW       255
	ANDWF       _SystemUpdate+1, 1 
	MOVLW       191
	ANDWF       _SystemUpdate+2, 1 
	MOVLW       255
	ANDWF       _SystemUpdate+3, 1 
;function.c,635 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
;function.c,636 :: 		}
L_alarmdispupdate107:
;function.c,637 :: 		}
L_alarmdispupdate105:
;function.c,638 :: 		}
L_alarmdispupdate102:
;function.c,639 :: 		}
L_end_alarmdispupdate:
	RETURN      0
; end of _alarmdispupdate

_SetHeatStatStr:

;function.c,646 :: 		void SetHeatStatStr(char Strlocat, char ChannelNum)
;function.c,649 :: 		getParaChar(Actural_disp_str[CH1_ACTURAL_HEAT+ChannelNum], Strlocat);
	MOVF        FARG_SetHeatStatStr_ChannelNum+0, 0 
	ADDLW       16
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       17
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 0 
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_getParaChar_ptr+1 
	MOVF        FARG_SetHeatStatStr_Strlocat+0, 0 
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;function.c,650 :: 		if((Strlocat == HEAT_IS_ON) || (Strlocat == HEAT_IS_MANON))
	MOVF        FARG_SetHeatStatStr_Strlocat+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__SetHeatStatStr238
	MOVF        FARG_SetHeatStatStr_Strlocat+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L__SetHeatStatStr238
	GOTO        L_SetHeatStatStr110
L__SetHeatStatStr238:
;function.c,653 :: 		SSRLedStat[ChannelNum] = 1;
	MOVLW       SetHeatStatStr_SSRLedStat_L0+0
	MOVWF       FSR1 
	MOVLW       hi_addr(SetHeatStatStr_SSRLedStat_L0+0)
	MOVWF       FSR1H 
	MOVF        FARG_SetHeatStatStr_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       1
	MOVWF       POSTINC1+0 
;function.c,654 :: 		}
	GOTO        L_SetHeatStatStr111
L_SetHeatStatStr110:
;function.c,655 :: 		else if((Strlocat == HEAT_IS_OFF) || (Strlocat == HEAT_IS_MANOFF))
	MOVF        FARG_SetHeatStatStr_Strlocat+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__SetHeatStatStr237
	MOVF        FARG_SetHeatStatStr_Strlocat+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__SetHeatStatStr237
	GOTO        L_SetHeatStatStr114
L__SetHeatStatStr237:
;function.c,658 :: 		SSRLedStat[ChannelNum] = 0;
	MOVLW       SetHeatStatStr_SSRLedStat_L0+0
	MOVWF       FSR1 
	MOVLW       hi_addr(SetHeatStatStr_SSRLedStat_L0+0)
	MOVWF       FSR1H 
	MOVF        FARG_SetHeatStatStr_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;function.c,659 :: 		}
L_SetHeatStatStr114:
L_SetHeatStatStr111:
;function.c,661 :: 		if((SSRLedStat[0]==0) && (SSRLedStat[1]==0))
	MOVF        SetHeatStatStr_SSRLedStat_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_SetHeatStatStr117
	MOVF        SetHeatStatStr_SSRLedStat_L0+1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_SetHeatStatStr117
L__SetHeatStatStr236:
;function.c,662 :: 		LED_HEATER_ON = 0;
	BCF         LATE3_bit+0, BitPos(LATE3_bit+0) 
	GOTO        L_SetHeatStatStr118
L_SetHeatStatStr117:
;function.c,664 :: 		LED_HEATER_ON = 1;
	BSF         LATE3_bit+0, BitPos(LATE3_bit+0) 
L_SetHeatStatStr118:
;function.c,665 :: 		}
L_end_SetHeatStatStr:
	RETURN      0
; end of _SetHeatStatStr

_SetTempStatStr:

;function.c,672 :: 		void SetTempStatStr(int *temp, char strlocat, char ChannelNum)
;function.c,675 :: 		char j=0,i;
	CLRF        SetTempStatStr_j_L0+0 
;function.c,679 :: 		units = pSPCValue[0].SPCSetPoints.system_valueb.bite.spc_units_c;
	MOVLW       0
	BTFSC       _pSPCValue+138, 0 
	MOVLW       1
	MOVWF       SetTempStatStr_units_L0+0 
;function.c,680 :: 		strlocat += ChannelNum;
	MOVF        FARG_SetTempStatStr_ChannelNum+0, 0 
	ADDWF       FARG_SetTempStatStr_strlocat+0, 1 
;function.c,682 :: 		if(units)
	MOVF        SetTempStatStr_units_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SetTempStatStr119
;function.c,684 :: 		strbuf = 0x1a;
	MOVLW       26
	MOVWF       SetTempStatStr_strbuf_L0+0 
;function.c,685 :: 		MaxTemp = MAX_TEMP_C;
	MOVLW       244
	MOVWF       SetTempStatStr_MaxTemp_L0+0 
	MOVLW       1
	MOVWF       SetTempStatStr_MaxTemp_L0+1 
;function.c,686 :: 		MinTemp = MIN_TEMP_C;
	MOVLW       206
	MOVWF       SetTempStatStr_MinTemp_L0+0 
	MOVLW       255
	MOVWF       SetTempStatStr_MinTemp_L0+1 
;function.c,687 :: 		}
	GOTO        L_SetTempStatStr120
L_SetTempStatStr119:
;function.c,690 :: 		strbuf = 0x1b;
	MOVLW       27
	MOVWF       SetTempStatStr_strbuf_L0+0 
;function.c,691 :: 		MaxTemp = MAX_TEMP_F;
	MOVLW       164
	MOVWF       SetTempStatStr_MaxTemp_L0+0 
	MOVLW       3
	MOVWF       SetTempStatStr_MaxTemp_L0+1 
;function.c,692 :: 		MinTemp = MIN_TEMP_F;
	MOVLW       198
	MOVWF       SetTempStatStr_MinTemp_L0+0 
	MOVLW       255
	MOVWF       SetTempStatStr_MinTemp_L0+1 
;function.c,693 :: 		}
L_SetTempStatStr120:
;function.c,695 :: 		for(i=0; i<16; i++)
	CLRF        SetTempStatStr_i_L0+0 
L_SetTempStatStr121:
	MOVLW       16
	SUBWF       SetTempStatStr_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SetTempStatStr122
;function.c,696 :: 		Actural_disp_str[strlocat][i] = ' ';
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetTempStatStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetTempStatStr_i_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       32
	MOVWF       POSTINC1+0 
;function.c,695 :: 		for(i=0; i<16; i++)
	INCF        SetTempStatStr_i_L0+0, 1 
;function.c,696 :: 		Actural_disp_str[strlocat][i] = ' ';
	GOTO        L_SetTempStatStr121
L_SetTempStatStr122:
;function.c,698 :: 		buffer = *temp;
	MOVFF       FARG_SetTempStatStr_temp+0, FSR0
	MOVFF       FARG_SetTempStatStr_temp+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       SetTempStatStr_buffer_L0+0 
	MOVF        R2, 0 
	MOVWF       SetTempStatStr_buffer_L0+1 
;function.c,699 :: 		if(buffer == RTD_SHORT)
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__SetTempStatStr277
	MOVLW       255
	XORWF       R1, 0 
L__SetTempStatStr277:
	BTFSS       STATUS+0, 2 
	GOTO        L_SetTempStatStr124
;function.c,702 :: 		for(i=0; i<16; i++)
	CLRF        SetTempStatStr_i_L0+0 
L_SetTempStatStr125:
	MOVLW       16
	SUBWF       SetTempStatStr_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SetTempStatStr126
;function.c,703 :: 		Actural_disp_str[strlocat][i] = ParaChar[RTD_SHORT_STR][i];
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetTempStatStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetTempStatStr_i_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       function_ParaChar+680
	ADDWF       SetTempStatStr_i_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(function_ParaChar+680)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(function_ParaChar+680)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;function.c,702 :: 		for(i=0; i<16; i++)
	INCF        SetTempStatStr_i_L0+0, 1 
;function.c,703 :: 		Actural_disp_str[strlocat][i] = ParaChar[RTD_SHORT_STR][i];
	GOTO        L_SetTempStatStr125
L_SetTempStatStr126:
;function.c,705 :: 		return;
	GOTO        L_end_SetTempStatStr
;function.c,706 :: 		}
L_SetTempStatStr124:
;function.c,707 :: 		else if(buffer == RTD_OPNE)
	MOVF        SetTempStatStr_buffer_L0+1, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__SetTempStatStr278
	MOVLW       253
	XORWF       SetTempStatStr_buffer_L0+0, 0 
L__SetTempStatStr278:
	BTFSS       STATUS+0, 2 
	GOTO        L_SetTempStatStr129
;function.c,710 :: 		for(i=0; i<16; i++)
	CLRF        SetTempStatStr_i_L0+0 
L_SetTempStatStr130:
	MOVLW       16
	SUBWF       SetTempStatStr_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SetTempStatStr131
;function.c,711 :: 		Actural_disp_str[strlocat][i] = ParaChar[RTD_OPEN_STR][i];
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetTempStatStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetTempStatStr_i_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       function_ParaChar+697
	ADDWF       SetTempStatStr_i_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(function_ParaChar+697)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(function_ParaChar+697)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;function.c,710 :: 		for(i=0; i<16; i++)
	INCF        SetTempStatStr_i_L0+0, 1 
;function.c,711 :: 		Actural_disp_str[strlocat][i] = ParaChar[RTD_OPEN_STR][i];
	GOTO        L_SetTempStatStr130
L_SetTempStatStr131:
;function.c,712 :: 		return;
	GOTO        L_end_SetTempStatStr
;function.c,713 :: 		}
L_SetTempStatStr129:
;function.c,716 :: 		if(buffer > MaxTemp)
	MOVLW       128
	XORWF       SetTempStatStr_MaxTemp_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       SetTempStatStr_buffer_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SetTempStatStr279
	MOVF        SetTempStatStr_buffer_L0+0, 0 
	SUBWF       SetTempStatStr_MaxTemp_L0+0, 0 
L__SetTempStatStr279:
	BTFSC       STATUS+0, 0 
	GOTO        L_SetTempStatStr134
;function.c,717 :: 		buffer = MaxTemp;
	MOVF        SetTempStatStr_MaxTemp_L0+0, 0 
	MOVWF       SetTempStatStr_buffer_L0+0 
	MOVF        SetTempStatStr_MaxTemp_L0+1, 0 
	MOVWF       SetTempStatStr_buffer_L0+1 
L_SetTempStatStr134:
;function.c,718 :: 		if(buffer < MinTemp)
	MOVLW       128
	XORWF       SetTempStatStr_buffer_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       SetTempStatStr_MinTemp_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SetTempStatStr280
	MOVF        SetTempStatStr_MinTemp_L0+0, 0 
	SUBWF       SetTempStatStr_buffer_L0+0, 0 
L__SetTempStatStr280:
	BTFSC       STATUS+0, 0 
	GOTO        L_SetTempStatStr135
;function.c,719 :: 		buffer = MinTemp;
	MOVF        SetTempStatStr_MinTemp_L0+0, 0 
	MOVWF       SetTempStatStr_buffer_L0+0 
	MOVF        SetTempStatStr_MinTemp_L0+1, 0 
	MOVWF       SetTempStatStr_buffer_L0+1 
L_SetTempStatStr135:
;function.c,724 :: 		if(buffer < 0)
	MOVLW       128
	XORWF       SetTempStatStr_buffer_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SetTempStatStr281
	MOVLW       0
	SUBWF       SetTempStatStr_buffer_L0+0, 0 
L__SetTempStatStr281:
	BTFSC       STATUS+0, 0 
	GOTO        L_SetTempStatStr136
;function.c,726 :: 		Actural_disp_str[strlocat][j++] = '-';
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetTempStatStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetTempStatStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       45
	MOVWF       POSTINC1+0 
	INCF        SetTempStatStr_j_L0+0, 1 
;function.c,727 :: 		buffer = -buffer;
	MOVF        SetTempStatStr_buffer_L0+0, 0 
	SUBLW       0
	MOVWF       SetTempStatStr_buffer_L0+0 
	MOVF        SetTempStatStr_buffer_L0+1, 0 
	MOVWF       SetTempStatStr_buffer_L0+1 
	MOVLW       0
	SUBFWB      SetTempStatStr_buffer_L0+1, 1 
;function.c,728 :: 		}
L_SetTempStatStr136:
;function.c,730 :: 		if(buffer > 99)
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       SetTempStatStr_buffer_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SetTempStatStr282
	MOVF        SetTempStatStr_buffer_L0+0, 0 
	SUBLW       99
L__SetTempStatStr282:
	BTFSC       STATUS+0, 0 
	GOTO        L_SetTempStatStr137
;function.c,732 :: 		Actural_disp_str[strlocat][j++] = buffer/100 +0x30;
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetTempStatStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetTempStatStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FLOC__SetTempStatStr+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__SetTempStatStr+1 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        SetTempStatStr_buffer_L0+0, 0 
	MOVWF       R0 
	MOVF        SetTempStatStr_buffer_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__SetTempStatStr+0, FSR1
	MOVFF       FLOC__SetTempStatStr+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        SetTempStatStr_j_L0+0, 1 
;function.c,733 :: 		Actural_disp_str[strlocat][j++] = buffer%100/10 +0x30;
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetTempStatStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetTempStatStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FLOC__SetTempStatStr+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__SetTempStatStr+1 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        SetTempStatStr_buffer_L0+0, 0 
	MOVWF       R0 
	MOVF        SetTempStatStr_buffer_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__SetTempStatStr+0, FSR1
	MOVFF       FLOC__SetTempStatStr+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        SetTempStatStr_j_L0+0, 1 
;function.c,734 :: 		Actural_disp_str[strlocat][j++] = buffer%10 +0x30;
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetTempStatStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetTempStatStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FLOC__SetTempStatStr+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__SetTempStatStr+1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        SetTempStatStr_buffer_L0+0, 0 
	MOVWF       R0 
	MOVF        SetTempStatStr_buffer_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__SetTempStatStr+0, FSR1
	MOVFF       FLOC__SetTempStatStr+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        SetTempStatStr_j_L0+0, 1 
;function.c,735 :: 		}
	GOTO        L_SetTempStatStr138
L_SetTempStatStr137:
;function.c,736 :: 		else if(buffer > 9)
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       SetTempStatStr_buffer_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SetTempStatStr283
	MOVF        SetTempStatStr_buffer_L0+0, 0 
	SUBLW       9
L__SetTempStatStr283:
	BTFSC       STATUS+0, 0 
	GOTO        L_SetTempStatStr139
;function.c,738 :: 		Actural_disp_str[strlocat][j++] = buffer/10 +0x30;
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetTempStatStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetTempStatStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FLOC__SetTempStatStr+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__SetTempStatStr+1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        SetTempStatStr_buffer_L0+0, 0 
	MOVWF       R0 
	MOVF        SetTempStatStr_buffer_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__SetTempStatStr+0, FSR1
	MOVFF       FLOC__SetTempStatStr+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        SetTempStatStr_j_L0+0, 1 
;function.c,739 :: 		Actural_disp_str[strlocat][j++] = buffer%10 +0x30;
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetTempStatStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetTempStatStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FLOC__SetTempStatStr+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__SetTempStatStr+1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        SetTempStatStr_buffer_L0+0, 0 
	MOVWF       R0 
	MOVF        SetTempStatStr_buffer_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__SetTempStatStr+0, FSR1
	MOVFF       FLOC__SetTempStatStr+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        SetTempStatStr_j_L0+0, 1 
;function.c,740 :: 		}
	GOTO        L_SetTempStatStr140
L_SetTempStatStr139:
;function.c,742 :: 		Actural_disp_str[strlocat][j++] = buffer +0x30;
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetTempStatStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetTempStatStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       48
	ADDWF       SetTempStatStr_buffer_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        SetTempStatStr_j_L0+0, 1 
L_SetTempStatStr140:
L_SetTempStatStr138:
;function.c,744 :: 		Actural_disp_str[strlocat][j++] = ' ';
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetTempStatStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetTempStatStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       32
	MOVWF       POSTINC1+0 
	INCF        SetTempStatStr_j_L0+0, 1 
;function.c,745 :: 		Actural_disp_str[strlocat][j++] = strbuf;
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetTempStatStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetTempStatStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        SetTempStatStr_strbuf_L0+0, 0 
	MOVWF       POSTINC1+0 
	INCF        SetTempStatStr_j_L0+0, 1 
;function.c,746 :: 		}
L_end_SetTempStatStr:
	RETURN      0
; end of _SetTempStatStr

_SetIntStr:

;function.c,753 :: 		void SetIntStr(int *ptr, char strlocat, char unitlocar, char len)
;function.c,755 :: 		char j=0, i;
	CLRF        SetIntStr_j_L0+0 
;function.c,758 :: 		temp = *ptr;
	MOVFF       FARG_SetIntStr_ptr+0, FSR0
	MOVFF       FARG_SetIntStr_ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       SetIntStr_temp_L0+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       SetIntStr_temp_L0+1 
;function.c,760 :: 		for(i=0; i<16; i++)
	CLRF        SetIntStr_i_L0+0 
L_SetIntStr141:
	MOVLW       16
	SUBWF       SetIntStr_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SetIntStr142
;function.c,761 :: 		Actural_disp_str[strlocat][i] = ' ';
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetIntStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetIntStr_i_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       32
	MOVWF       POSTINC1+0 
;function.c,760 :: 		for(i=0; i<16; i++)
	INCF        SetIntStr_i_L0+0, 1 
;function.c,761 :: 		Actural_disp_str[strlocat][i] = ' ';
	GOTO        L_SetIntStr141
L_SetIntStr142:
;function.c,763 :: 		if(*ptr == OUTOFRANGE)
	MOVFF       FARG_SetIntStr_ptr+0, FSR0
	MOVFF       FARG_SetIntStr_ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__SetIntStr285
	MOVLW       254
	XORWF       R1, 0 
L__SetIntStr285:
	BTFSS       STATUS+0, 2 
	GOTO        L_SetIntStr144
;function.c,765 :: 		for(i=0; i<16; i++)
	CLRF        SetIntStr_i_L0+0 
L_SetIntStr145:
	MOVLW       16
	SUBWF       SetIntStr_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SetIntStr146
;function.c,766 :: 		Actural_disp_str[strlocat][i] = ParaChar[OUTOFRANGE_STR][i];
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetIntStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetIntStr_i_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       function_ParaChar+714
	ADDWF       SetIntStr_i_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(function_ParaChar+714)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(function_ParaChar+714)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;function.c,765 :: 		for(i=0; i<16; i++)
	INCF        SetIntStr_i_L0+0, 1 
;function.c,766 :: 		Actural_disp_str[strlocat][i] = ParaChar[OUTOFRANGE_STR][i];
	GOTO        L_SetIntStr145
L_SetIntStr146:
;function.c,767 :: 		return;
	GOTO        L_end_SetIntStr
;function.c,768 :: 		}
L_SetIntStr144:
;function.c,770 :: 		if(*ptr > 999)
	MOVFF       FARG_SetIntStr_ptr+0, FSR0
	MOVFF       FARG_SetIntStr_ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORLW       3
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SetIntStr286
	MOVF        R1, 0 
	SUBLW       231
L__SetIntStr286:
	BTFSC       STATUS+0, 0 
	GOTO        L_SetIntStr148
;function.c,772 :: 		Actural_disp_str[strlocat][j++] = *ptr/1000 +0x30;
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetIntStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetIntStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FLOC__SetIntStr+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__SetIntStr+1 
	MOVFF       FARG_SetIntStr_ptr+0, FSR0
	MOVFF       FARG_SetIntStr_ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__SetIntStr+0, FSR1
	MOVFF       FLOC__SetIntStr+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        SetIntStr_j_L0+0, 1 
;function.c,773 :: 		Actural_disp_str[strlocat][j++] = *ptr%1000/100 +0x30;
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetIntStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetIntStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FLOC__SetIntStr+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__SetIntStr+1 
	MOVFF       FARG_SetIntStr_ptr+0, FSR0
	MOVFF       FARG_SetIntStr_ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__SetIntStr+0, FSR1
	MOVFF       FLOC__SetIntStr+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        SetIntStr_j_L0+0, 1 
;function.c,774 :: 		Actural_disp_str[strlocat][j++] = *ptr%100/10 +0x30;
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetIntStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetIntStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FLOC__SetIntStr+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__SetIntStr+1 
	MOVFF       FARG_SetIntStr_ptr+0, FSR0
	MOVFF       FARG_SetIntStr_ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__SetIntStr+0, FSR1
	MOVFF       FLOC__SetIntStr+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        SetIntStr_j_L0+0, 1 
;function.c,775 :: 		Actural_disp_str[strlocat][j++] = *ptr%10 +0x30;
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetIntStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetIntStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FLOC__SetIntStr+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__SetIntStr+1 
	MOVFF       FARG_SetIntStr_ptr+0, FSR0
	MOVFF       FARG_SetIntStr_ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__SetIntStr+0, FSR1
	MOVFF       FLOC__SetIntStr+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        SetIntStr_j_L0+0, 1 
;function.c,776 :: 		}
	GOTO        L_SetIntStr149
L_SetIntStr148:
;function.c,777 :: 		else if(*ptr > 99)
	MOVFF       FARG_SetIntStr_ptr+0, FSR0
	MOVFF       FARG_SetIntStr_ptr+1, FSR0H
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
	GOTO        L__SetIntStr287
	MOVF        R1, 0 
	SUBLW       99
L__SetIntStr287:
	BTFSC       STATUS+0, 0 
	GOTO        L_SetIntStr150
;function.c,779 :: 		Actural_disp_str[strlocat][j++] = *ptr/100 +0x30;
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetIntStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetIntStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FLOC__SetIntStr+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__SetIntStr+1 
	MOVFF       FARG_SetIntStr_ptr+0, FSR0
	MOVFF       FARG_SetIntStr_ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__SetIntStr+0, FSR1
	MOVFF       FLOC__SetIntStr+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        SetIntStr_j_L0+0, 1 
;function.c,780 :: 		Actural_disp_str[strlocat][j++] = *ptr%100/10 +0x30;
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetIntStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetIntStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FLOC__SetIntStr+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__SetIntStr+1 
	MOVFF       FARG_SetIntStr_ptr+0, FSR0
	MOVFF       FARG_SetIntStr_ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__SetIntStr+0, FSR1
	MOVFF       FLOC__SetIntStr+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        SetIntStr_j_L0+0, 1 
;function.c,781 :: 		Actural_disp_str[strlocat][j++] = *ptr%10 +0x30;
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetIntStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetIntStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FLOC__SetIntStr+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__SetIntStr+1 
	MOVFF       FARG_SetIntStr_ptr+0, FSR0
	MOVFF       FARG_SetIntStr_ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__SetIntStr+0, FSR1
	MOVFF       FLOC__SetIntStr+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        SetIntStr_j_L0+0, 1 
;function.c,782 :: 		}
	GOTO        L_SetIntStr151
L_SetIntStr150:
;function.c,783 :: 		else if(*ptr > 9)
	MOVFF       FARG_SetIntStr_ptr+0, FSR0
	MOVFF       FARG_SetIntStr_ptr+1, FSR0H
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
	GOTO        L__SetIntStr288
	MOVF        R1, 0 
	SUBLW       9
L__SetIntStr288:
	BTFSC       STATUS+0, 0 
	GOTO        L_SetIntStr152
;function.c,785 :: 		Actural_disp_str[strlocat][j++] = *ptr/10 +0x30;
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetIntStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetIntStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FLOC__SetIntStr+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__SetIntStr+1 
	MOVFF       FARG_SetIntStr_ptr+0, FSR0
	MOVFF       FARG_SetIntStr_ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__SetIntStr+0, FSR1
	MOVFF       FLOC__SetIntStr+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        SetIntStr_j_L0+0, 1 
;function.c,786 :: 		Actural_disp_str[strlocat][j++] = *ptr%10 +0x30;
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetIntStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetIntStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FLOC__SetIntStr+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__SetIntStr+1 
	MOVFF       FARG_SetIntStr_ptr+0, FSR0
	MOVFF       FARG_SetIntStr_ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__SetIntStr+0, FSR1
	MOVFF       FLOC__SetIntStr+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        SetIntStr_j_L0+0, 1 
;function.c,787 :: 		}
	GOTO        L_SetIntStr153
L_SetIntStr152:
;function.c,789 :: 		Actural_disp_str[strlocat][j++] = *ptr +0x30;
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetIntStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetIntStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVFF       FARG_SetIntStr_ptr+0, FSR0
	MOVFF       FARG_SetIntStr_ptr+1, FSR0H
	MOVLW       48
	ADDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        SetIntStr_j_L0+0, 1 
L_SetIntStr153:
L_SetIntStr151:
L_SetIntStr149:
;function.c,791 :: 		Actural_disp_str[strlocat][j++] = ' ';
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetIntStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetIntStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       32
	MOVWF       POSTINC1+0 
	INCF        SetIntStr_j_L0+0, 1 
;function.c,793 :: 		for(i=0;i<len;i++)
	CLRF        SetIntStr_i_L0+0 
L_SetIntStr154:
	MOVF        FARG_SetIntStr_len+0, 0 
	SUBWF       SetIntStr_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SetIntStr155
;function.c,794 :: 		Actural_disp_str[strlocat][j++] = SPCUnit[unitlocar][i];
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetIntStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetIntStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FLOC__SetIntStr+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__SetIntStr+1 
	MOVLW       9
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        FARG_SetIntStr_unitlocar+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       function_SPCUnit+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(function_SPCUnit+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(function_SPCUnit+0)
	ADDWFC      R2, 1 
	MOVF        SetIntStr_i_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVFF       FLOC__SetIntStr+0, FSR1
	MOVFF       FLOC__SetIntStr+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        SetIntStr_j_L0+0, 1 
;function.c,793 :: 		for(i=0;i<len;i++)
	INCF        SetIntStr_i_L0+0, 1 
;function.c,794 :: 		Actural_disp_str[strlocat][j++] = SPCUnit[unitlocar][i];
	GOTO        L_SetIntStr154
L_SetIntStr155:
;function.c,795 :: 		}
L_end_SetIntStr:
	RETURN      0
; end of _SetIntStr

_SetCurrentStr:

;function.c,802 :: 		void SetCurrentStr(int *ptr, char strlocat, char unitlocar, char len)
;function.c,804 :: 		char j=0, i;
	CLRF        SetCurrentStr_j_L0+0 
;function.c,807 :: 		for(i=0; i<16; i++)
	CLRF        SetCurrentStr_i_L0+0 
L_SetCurrentStr157:
	MOVLW       16
	SUBWF       SetCurrentStr_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SetCurrentStr158
;function.c,808 :: 		Actural_disp_str[strlocat][i] = ' ';
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetCurrentStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetCurrentStr_i_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       32
	MOVWF       POSTINC1+0 
;function.c,807 :: 		for(i=0; i<16; i++)
	INCF        SetCurrentStr_i_L0+0, 1 
;function.c,808 :: 		Actural_disp_str[strlocat][i] = ' ';
	GOTO        L_SetCurrentStr157
L_SetCurrentStr158:
;function.c,810 :: 		if(*ptr == OUTOFRANGE)
	MOVFF       FARG_SetCurrentStr_ptr+0, FSR0
	MOVFF       FARG_SetCurrentStr_ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__SetCurrentStr290
	MOVLW       254
	XORWF       R1, 0 
L__SetCurrentStr290:
	BTFSS       STATUS+0, 2 
	GOTO        L_SetCurrentStr160
;function.c,813 :: 		for(i=0; i<16; i++)
	CLRF        SetCurrentStr_i_L0+0 
L_SetCurrentStr161:
	MOVLW       16
	SUBWF       SetCurrentStr_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SetCurrentStr162
;function.c,814 :: 		Actural_disp_str[strlocat][i] = ParaChar[OUTOFRANGE_STR][i];
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetCurrentStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetCurrentStr_i_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       function_ParaChar+714
	ADDWF       SetCurrentStr_i_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(function_ParaChar+714)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(function_ParaChar+714)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;function.c,813 :: 		for(i=0; i<16; i++)
	INCF        SetCurrentStr_i_L0+0, 1 
;function.c,814 :: 		Actural_disp_str[strlocat][i] = ParaChar[OUTOFRANGE_STR][i];
	GOTO        L_SetCurrentStr161
L_SetCurrentStr162:
;function.c,815 :: 		return;
	GOTO        L_end_SetCurrentStr
;function.c,816 :: 		}
L_SetCurrentStr160:
;function.c,818 :: 		value_H = *ptr/10;
	MOVFF       FARG_SetCurrentStr_ptr+0, FSR0
	MOVFF       FARG_SetCurrentStr_ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       SetCurrentStr_value_H_L0+0 
	MOVF        R1, 0 
	MOVWF       SetCurrentStr_value_H_L0+1 
;function.c,819 :: 		value_L = *ptr%10;
	MOVFF       FARG_SetCurrentStr_ptr+0, FSR0
	MOVFF       FARG_SetCurrentStr_ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       SetCurrentStr_value_L_L0+0 
	MOVF        R1, 0 
	MOVWF       SetCurrentStr_value_L_L0+1 
;function.c,821 :: 		if(value_H > 9)
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       SetCurrentStr_value_H_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SetCurrentStr291
	MOVF        SetCurrentStr_value_H_L0+0, 0 
	SUBLW       9
L__SetCurrentStr291:
	BTFSC       STATUS+0, 0 
	GOTO        L_SetCurrentStr164
;function.c,823 :: 		Actural_disp_str[strlocat][j++] = value_H/10 +0x30;
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetCurrentStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetCurrentStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FLOC__SetCurrentStr+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__SetCurrentStr+1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        SetCurrentStr_value_H_L0+0, 0 
	MOVWF       R0 
	MOVF        SetCurrentStr_value_H_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__SetCurrentStr+0, FSR1
	MOVFF       FLOC__SetCurrentStr+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        SetCurrentStr_j_L0+0, 1 
;function.c,824 :: 		Actural_disp_str[strlocat][j++] = value_H%10 +0x30;
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetCurrentStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetCurrentStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FLOC__SetCurrentStr+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__SetCurrentStr+1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        SetCurrentStr_value_H_L0+0, 0 
	MOVWF       R0 
	MOVF        SetCurrentStr_value_H_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__SetCurrentStr+0, FSR1
	MOVFF       FLOC__SetCurrentStr+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        SetCurrentStr_j_L0+0, 1 
;function.c,825 :: 		}
	GOTO        L_SetCurrentStr165
L_SetCurrentStr164:
;function.c,827 :: 		Actural_disp_str[strlocat][j++] = value_H +0x30;
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetCurrentStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetCurrentStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       48
	ADDWF       SetCurrentStr_value_H_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        SetCurrentStr_j_L0+0, 1 
L_SetCurrentStr165:
;function.c,829 :: 		Actural_disp_str[strlocat][j++] = '.';
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetCurrentStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetCurrentStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       46
	MOVWF       POSTINC1+0 
	INCF        SetCurrentStr_j_L0+0, 1 
;function.c,830 :: 		Actural_disp_str[strlocat][j++] = value_L +0x30;
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetCurrentStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetCurrentStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       48
	ADDWF       SetCurrentStr_value_L_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        SetCurrentStr_j_L0+0, 1 
;function.c,832 :: 		Actural_disp_str[strlocat][j++] = ' ';
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetCurrentStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetCurrentStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       32
	MOVWF       POSTINC1+0 
	INCF        SetCurrentStr_j_L0+0, 1 
;function.c,833 :: 		for(i=0;i<len;i++)
	CLRF        SetCurrentStr_i_L0+0 
L_SetCurrentStr166:
	MOVF        FARG_SetCurrentStr_len+0, 0 
	SUBWF       SetCurrentStr_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SetCurrentStr167
;function.c,834 :: 		Actural_disp_str[strlocat][j++] = SPCUnit[unitlocar][i];
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetCurrentStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetCurrentStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FLOC__SetCurrentStr+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__SetCurrentStr+1 
	MOVLW       9
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        FARG_SetCurrentStr_unitlocar+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       function_SPCUnit+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(function_SPCUnit+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(function_SPCUnit+0)
	ADDWFC      R2, 1 
	MOVF        SetCurrentStr_i_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVFF       FLOC__SetCurrentStr+0, FSR1
	MOVFF       FLOC__SetCurrentStr+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        SetCurrentStr_j_L0+0, 1 
;function.c,833 :: 		for(i=0;i<len;i++)
	INCF        SetCurrentStr_i_L0+0, 1 
;function.c,834 :: 		Actural_disp_str[strlocat][j++] = SPCUnit[unitlocar][i];
	GOTO        L_SetCurrentStr166
L_SetCurrentStr167:
;function.c,835 :: 		}
L_end_SetCurrentStr:
	RETURN      0
; end of _SetCurrentStr

_SetCostStr:

;function.c,842 :: 		void SetCostStr(ULONG databuff, char strlocat)
;function.c,844 :: 		char j=0, i;
	CLRF        SetCostStr_j_L0+0 
;function.c,849 :: 		for(i=0; i<16; i++)
	CLRF        SetCostStr_i_L0+0 
L_SetCostStr169:
	MOVLW       16
	SUBWF       SetCostStr_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SetCostStr170
;function.c,850 :: 		Actural_disp_str[strlocat][i] = ' ';
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetCostStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetCostStr_i_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       32
	MOVWF       POSTINC1+0 
;function.c,849 :: 		for(i=0; i<16; i++)
	INCF        SetCostStr_i_L0+0, 1 
;function.c,850 :: 		Actural_disp_str[strlocat][i] = ' ';
	GOTO        L_SetCostStr169
L_SetCostStr170:
;function.c,852 :: 		if((databuff == OUTOFRANGE) || (databuff == COSTOUTOFRANGE))
	MOVLW       0
	MOVWF       R0 
	XORWF       FARG_SetCostStr_databuff+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SetCostStr293
	MOVF        R0, 0 
	XORWF       FARG_SetCostStr_databuff+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SetCostStr293
	MOVLW       127
	XORWF       FARG_SetCostStr_databuff+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SetCostStr293
	MOVF        FARG_SetCostStr_databuff+0, 0 
	XORLW       254
L__SetCostStr293:
	BTFSC       STATUS+0, 2 
	GOTO        L__SetCostStr242
	MOVF        FARG_SetCostStr_databuff+3, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__SetCostStr294
	MOVF        FARG_SetCostStr_databuff+2, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L__SetCostStr294
	MOVF        FARG_SetCostStr_databuff+1, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L__SetCostStr294
	MOVF        FARG_SetCostStr_databuff+0, 0 
	XORLW       255
L__SetCostStr294:
	BTFSC       STATUS+0, 2 
	GOTO        L__SetCostStr242
	GOTO        L_SetCostStr174
L__SetCostStr242:
;function.c,855 :: 		for(i=0; i<16; i++)
	CLRF        SetCostStr_i_L0+0 
L_SetCostStr175:
	MOVLW       16
	SUBWF       SetCostStr_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SetCostStr176
;function.c,856 :: 		Actural_disp_str[strlocat][i] = ParaChar[OUTOFRANGE_STR][i];
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetCostStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetCostStr_i_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       function_ParaChar+714
	ADDWF       SetCostStr_i_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(function_ParaChar+714)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(function_ParaChar+714)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;function.c,855 :: 		for(i=0; i<16; i++)
	INCF        SetCostStr_i_L0+0, 1 
;function.c,856 :: 		Actural_disp_str[strlocat][i] = ParaChar[OUTOFRANGE_STR][i];
	GOTO        L_SetCostStr175
L_SetCostStr176:
;function.c,857 :: 		return;
	GOTO        L_end_SetCostStr
;function.c,858 :: 		}
L_SetCostStr174:
;function.c,860 :: 		if((strlocat == CH1_ACTURAL_COST) || (strlocat == CH2_ACTURAL_COST))
	MOVF        FARG_SetCostStr_strlocat+0, 0 
	XORLW       26
	BTFSC       STATUS+0, 2 
	GOTO        L__SetCostStr241
	MOVF        FARG_SetCostStr_strlocat+0, 0 
	XORLW       27
	BTFSC       STATUS+0, 2 
	GOTO        L__SetCostStr241
	GOTO        L_SetCostStr180
L__SetCostStr241:
;function.c,861 :: 		Divider = 100;
	MOVLW       100
	MOVWF       SetCostStr_Divider_L0+0 
	GOTO        L_SetCostStr181
L_SetCostStr180:
;function.c,863 :: 		Divider = 10;
	MOVLW       10
	MOVWF       SetCostStr_Divider_L0+0 
L_SetCostStr181:
;function.c,865 :: 		value_H = databuff/Divider;
	MOVF        SetCostStr_Divider_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	MOVF        FARG_SetCostStr_databuff+0, 0 
	MOVWF       R0 
	MOVF        FARG_SetCostStr_databuff+1, 0 
	MOVWF       R1 
	MOVF        FARG_SetCostStr_databuff+2, 0 
	MOVWF       R2 
	MOVF        FARG_SetCostStr_databuff+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       SetCostStr_value_H_L0+0 
	MOVF        R1, 0 
	MOVWF       SetCostStr_value_H_L0+1 
	MOVF        R2, 0 
	MOVWF       SetCostStr_value_H_L0+2 
	MOVF        R3, 0 
	MOVWF       SetCostStr_value_H_L0+3 
;function.c,866 :: 		value_L = databuff%Divider;
	MOVF        SetCostStr_Divider_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	MOVF        FARG_SetCostStr_databuff+0, 0 
	MOVWF       R0 
	MOVF        FARG_SetCostStr_databuff+1, 0 
	MOVWF       R1 
	MOVF        FARG_SetCostStr_databuff+2, 0 
	MOVWF       R2 
	MOVF        FARG_SetCostStr_databuff+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R10, 0 
	MOVWF       R2 
	MOVF        R11, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       SetCostStr_value_L_L0+0 
	MOVF        R1, 0 
	MOVWF       SetCostStr_value_L_L0+1 
;function.c,868 :: 		if((strlocat == CH1_ACTURAL_COST) || (strlocat == CH2_ACTURAL_COST))
	MOVF        FARG_SetCostStr_strlocat+0, 0 
	XORLW       26
	BTFSC       STATUS+0, 2 
	GOTO        L__SetCostStr240
	MOVF        FARG_SetCostStr_strlocat+0, 0 
	XORLW       27
	BTFSC       STATUS+0, 2 
	GOTO        L__SetCostStr240
	GOTO        L_SetCostStr184
L__SetCostStr240:
;function.c,869 :: 		Actural_disp_str[strlocat][j++] = '$';
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetCostStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetCostStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       36
	MOVWF       POSTINC1+0 
	INCF        SetCostStr_j_L0+0, 1 
L_SetCostStr184:
;function.c,871 :: 		for(i=0; i<8; i++)
	CLRF        SetCostStr_i_L0+0 
L_SetCostStr185:
	MOVLW       8
	SUBWF       SetCostStr_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SetCostStr186
;function.c,873 :: 		if(value_H / Chr_str[i])
	MOVF        SetCostStr_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	MOVLW       function_Chr_str+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(function_Chr_str+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(function_Chr_str+0)
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R4
	TBLRD*+
	MOVFF       TABLAT+0, R5
	TBLRD*+
	MOVFF       TABLAT+0, R6
	TBLRD*+
	MOVFF       TABLAT+0, R7
	MOVF        SetCostStr_value_H_L0+0, 0 
	MOVWF       R0 
	MOVF        SetCostStr_value_H_L0+1, 0 
	MOVWF       R1 
	MOVF        SetCostStr_value_H_L0+2, 0 
	MOVWF       R2 
	MOVF        SetCostStr_value_H_L0+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_SetCostStr188
;function.c,874 :: 		break;
	GOTO        L_SetCostStr186
L_SetCostStr188:
;function.c,876 :: 		value_H %= Chr_str[i];
	MOVF        SetCostStr_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	MOVLW       function_Chr_str+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(function_Chr_str+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(function_Chr_str+0)
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R4
	TBLRD*+
	MOVFF       TABLAT+0, R5
	TBLRD*+
	MOVFF       TABLAT+0, R6
	TBLRD*+
	MOVFF       TABLAT+0, R7
	MOVF        SetCostStr_value_H_L0+0, 0 
	MOVWF       R0 
	MOVF        SetCostStr_value_H_L0+1, 0 
	MOVWF       R1 
	MOVF        SetCostStr_value_H_L0+2, 0 
	MOVWF       R2 
	MOVF        SetCostStr_value_H_L0+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R10, 0 
	MOVWF       R2 
	MOVF        R11, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       SetCostStr_value_H_L0+0 
	MOVF        R1, 0 
	MOVWF       SetCostStr_value_H_L0+1 
	MOVF        R2, 0 
	MOVWF       SetCostStr_value_H_L0+2 
	MOVF        R3, 0 
	MOVWF       SetCostStr_value_H_L0+3 
;function.c,878 :: 		if(i == 7)
	MOVF        SetCostStr_i_L0+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_SetCostStr190
;function.c,879 :: 		Actural_disp_str[strlocat][j++] = value_H + 0x30;
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetCostStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetCostStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       48
	ADDWF       SetCostStr_value_H_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        SetCostStr_j_L0+0, 1 
L_SetCostStr190:
;function.c,871 :: 		for(i=0; i<8; i++)
	INCF        SetCostStr_i_L0+0, 1 
;function.c,880 :: 		}
	GOTO        L_SetCostStr185
L_SetCostStr186:
;function.c,882 :: 		for(; i<8; i++)
L_SetCostStr191:
	MOVLW       8
	SUBWF       SetCostStr_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SetCostStr192
;function.c,884 :: 		Actural_disp_str[strlocat][j++] = value_H / Chr_str[i] + 0x30;
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetCostStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetCostStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FLOC__SetCostStr+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__SetCostStr+1 
	MOVF        SetCostStr_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	MOVLW       function_Chr_str+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(function_Chr_str+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(function_Chr_str+0)
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R4
	TBLRD*+
	MOVFF       TABLAT+0, R5
	TBLRD*+
	MOVFF       TABLAT+0, R6
	TBLRD*+
	MOVFF       TABLAT+0, R7
	MOVF        SetCostStr_value_H_L0+0, 0 
	MOVWF       R0 
	MOVF        SetCostStr_value_H_L0+1, 0 
	MOVWF       R1 
	MOVF        SetCostStr_value_H_L0+2, 0 
	MOVWF       R2 
	MOVF        SetCostStr_value_H_L0+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__SetCostStr+0, FSR1
	MOVFF       FLOC__SetCostStr+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        SetCostStr_j_L0+0, 1 
;function.c,885 :: 		value_H %= Chr_str[i];
	MOVF        SetCostStr_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	MOVLW       function_Chr_str+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(function_Chr_str+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(function_Chr_str+0)
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R4
	TBLRD*+
	MOVFF       TABLAT+0, R5
	TBLRD*+
	MOVFF       TABLAT+0, R6
	TBLRD*+
	MOVFF       TABLAT+0, R7
	MOVF        SetCostStr_value_H_L0+0, 0 
	MOVWF       R0 
	MOVF        SetCostStr_value_H_L0+1, 0 
	MOVWF       R1 
	MOVF        SetCostStr_value_H_L0+2, 0 
	MOVWF       R2 
	MOVF        SetCostStr_value_H_L0+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R10, 0 
	MOVWF       R2 
	MOVF        R11, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       SetCostStr_value_H_L0+0 
	MOVF        R1, 0 
	MOVWF       SetCostStr_value_H_L0+1 
	MOVF        R2, 0 
	MOVWF       SetCostStr_value_H_L0+2 
	MOVF        R3, 0 
	MOVWF       SetCostStr_value_H_L0+3 
;function.c,882 :: 		for(; i<8; i++)
	INCF        SetCostStr_i_L0+0, 1 
;function.c,886 :: 		}
	GOTO        L_SetCostStr191
L_SetCostStr192:
;function.c,888 :: 		Actural_disp_str[strlocat][j++] = '.';
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetCostStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetCostStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       46
	MOVWF       POSTINC1+0 
	INCF        SetCostStr_j_L0+0, 1 
;function.c,890 :: 		if((strlocat == CH1_ACTURAL_COST) || (strlocat == CH2_ACTURAL_COST))
	MOVF        FARG_SetCostStr_strlocat+0, 0 
	XORLW       26
	BTFSC       STATUS+0, 2 
	GOTO        L__SetCostStr239
	MOVF        FARG_SetCostStr_strlocat+0, 0 
	XORLW       27
	BTFSC       STATUS+0, 2 
	GOTO        L__SetCostStr239
	GOTO        L_SetCostStr196
L__SetCostStr239:
;function.c,892 :: 		Actural_disp_str[strlocat][j++] = value_L/10 +0x30;
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetCostStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetCostStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FLOC__SetCostStr+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__SetCostStr+1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        SetCostStr_value_L_L0+0, 0 
	MOVWF       R0 
	MOVF        SetCostStr_value_L_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__SetCostStr+0, FSR1
	MOVFF       FLOC__SetCostStr+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        SetCostStr_j_L0+0, 1 
;function.c,893 :: 		Actural_disp_str[strlocat][j++] = value_L%10 +0x30;
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetCostStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetCostStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FLOC__SetCostStr+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__SetCostStr+1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        SetCostStr_value_L_L0+0, 0 
	MOVWF       R0 
	MOVF        SetCostStr_value_L_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__SetCostStr+0, FSR1
	MOVFF       FLOC__SetCostStr+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        SetCostStr_j_L0+0, 1 
;function.c,894 :: 		}
	GOTO        L_SetCostStr197
L_SetCostStr196:
;function.c,897 :: 		Actural_disp_str[strlocat][j++] = value_L +0x30;
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetCostStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetCostStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       48
	ADDWF       SetCostStr_value_L_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        SetCostStr_j_L0+0, 1 
;function.c,898 :: 		Actural_disp_str[strlocat][j++] = ' ';
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetCostStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetCostStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       32
	MOVWF       POSTINC1+0 
	INCF        SetCostStr_j_L0+0, 1 
;function.c,899 :: 		for(i=0;i<3;i++)
	CLRF        SetCostStr_i_L0+0 
L_SetCostStr198:
	MOVLW       3
	SUBWF       SetCostStr_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SetCostStr199
;function.c,900 :: 		Actural_disp_str[strlocat][j++] = SPCUnit[UNIT_ENEGRY][i];
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetCostStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetCostStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       function_SPCUnit+99
	ADDWF       SetCostStr_i_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(function_SPCUnit+99)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(function_SPCUnit+99)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        SetCostStr_j_L0+0, 1 
;function.c,899 :: 		for(i=0;i<3;i++)
	INCF        SetCostStr_i_L0+0, 1 
;function.c,900 :: 		Actural_disp_str[strlocat][j++] = SPCUnit[UNIT_ENEGRY][i];
	GOTO        L_SetCostStr198
L_SetCostStr199:
;function.c,901 :: 		}
L_SetCostStr197:
;function.c,902 :: 		}
L_end_SetCostStr:
	RETURN      0
; end of _SetCostStr

_SetOntimeStr:

;function.c,909 :: 		void SetOntimeStr(ULONG databuff, char strlocat)
;function.c,911 :: 		char j=0, i;
	CLRF        SetOntimeStr_j_L0+0 
;function.c,913 :: 		for(i=0; i<16; i++)
	CLRF        SetOntimeStr_i_L0+0 
L_SetOntimeStr201:
	MOVLW       16
	SUBWF       SetOntimeStr_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SetOntimeStr202
;function.c,914 :: 		Actural_disp_str[strlocat][i] = ' ';
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetOntimeStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetOntimeStr_i_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       32
	MOVWF       POSTINC1+0 
;function.c,913 :: 		for(i=0; i<16; i++)
	INCF        SetOntimeStr_i_L0+0, 1 
;function.c,914 :: 		Actural_disp_str[strlocat][i] = ' ';
	GOTO        L_SetOntimeStr201
L_SetOntimeStr202:
;function.c,916 :: 		if(databuff == ONTIMEOUTOFRANGE)
	MOVF        FARG_SetOntimeStr_databuff+3, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__SetOntimeStr296
	MOVF        FARG_SetOntimeStr_databuff+2, 0 
	XORLW       22
	BTFSS       STATUS+0, 2 
	GOTO        L__SetOntimeStr296
	MOVF        FARG_SetOntimeStr_databuff+1, 0 
	XORLW       227
	BTFSS       STATUS+0, 2 
	GOTO        L__SetOntimeStr296
	MOVF        FARG_SetOntimeStr_databuff+0, 0 
	XORLW       96
L__SetOntimeStr296:
	BTFSS       STATUS+0, 2 
	GOTO        L_SetOntimeStr204
;function.c,919 :: 		for(i=0; i<16; i++)
	CLRF        SetOntimeStr_i_L0+0 
L_SetOntimeStr205:
	MOVLW       16
	SUBWF       SetOntimeStr_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SetOntimeStr206
;function.c,920 :: 		Actural_disp_str[strlocat][i] = ParaChar[OUTOFRANGE_STR][i];
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetOntimeStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetOntimeStr_i_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       function_ParaChar+714
	ADDWF       SetOntimeStr_i_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(function_ParaChar+714)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(function_ParaChar+714)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;function.c,919 :: 		for(i=0; i<16; i++)
	INCF        SetOntimeStr_i_L0+0, 1 
;function.c,920 :: 		Actural_disp_str[strlocat][i] = ParaChar[OUTOFRANGE_STR][i];
	GOTO        L_SetOntimeStr205
L_SetOntimeStr206:
;function.c,921 :: 		return;
	GOTO        L_end_SetOntimeStr
;function.c,922 :: 		}
L_SetOntimeStr204:
;function.c,924 :: 		for(i=0; i<8; i++)
	CLRF        SetOntimeStr_i_L0+0 
L_SetOntimeStr208:
	MOVLW       8
	SUBWF       SetOntimeStr_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SetOntimeStr209
;function.c,926 :: 		if(databuff / Chr_str[i])
	MOVF        SetOntimeStr_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	MOVLW       function_Chr_str+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(function_Chr_str+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(function_Chr_str+0)
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R4
	TBLRD*+
	MOVFF       TABLAT+0, R5
	TBLRD*+
	MOVFF       TABLAT+0, R6
	TBLRD*+
	MOVFF       TABLAT+0, R7
	MOVF        FARG_SetOntimeStr_databuff+0, 0 
	MOVWF       R0 
	MOVF        FARG_SetOntimeStr_databuff+1, 0 
	MOVWF       R1 
	MOVF        FARG_SetOntimeStr_databuff+2, 0 
	MOVWF       R2 
	MOVF        FARG_SetOntimeStr_databuff+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOntimeStr211
;function.c,927 :: 		break;
	GOTO        L_SetOntimeStr209
L_SetOntimeStr211:
;function.c,929 :: 		databuff %= Chr_str[i];
	MOVF        SetOntimeStr_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	MOVLW       function_Chr_str+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(function_Chr_str+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(function_Chr_str+0)
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R4
	TBLRD*+
	MOVFF       TABLAT+0, R5
	TBLRD*+
	MOVFF       TABLAT+0, R6
	TBLRD*+
	MOVFF       TABLAT+0, R7
	MOVF        FARG_SetOntimeStr_databuff+0, 0 
	MOVWF       R0 
	MOVF        FARG_SetOntimeStr_databuff+1, 0 
	MOVWF       R1 
	MOVF        FARG_SetOntimeStr_databuff+2, 0 
	MOVWF       R2 
	MOVF        FARG_SetOntimeStr_databuff+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R10, 0 
	MOVWF       R2 
	MOVF        R11, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       FARG_SetOntimeStr_databuff+0 
	MOVF        R1, 0 
	MOVWF       FARG_SetOntimeStr_databuff+1 
	MOVF        R2, 0 
	MOVWF       FARG_SetOntimeStr_databuff+2 
	MOVF        R3, 0 
	MOVWF       FARG_SetOntimeStr_databuff+3 
;function.c,931 :: 		if(i == 7)
	MOVF        SetOntimeStr_i_L0+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_SetOntimeStr213
;function.c,932 :: 		Actural_disp_str[strlocat][j++] = databuff + 0x30;
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetOntimeStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetOntimeStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       48
	ADDWF       FARG_SetOntimeStr_databuff+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        SetOntimeStr_j_L0+0, 1 
L_SetOntimeStr213:
;function.c,924 :: 		for(i=0; i<8; i++)
	INCF        SetOntimeStr_i_L0+0, 1 
;function.c,933 :: 		}
	GOTO        L_SetOntimeStr208
L_SetOntimeStr209:
;function.c,935 :: 		for(; i<8; i++)
L_SetOntimeStr214:
	MOVLW       8
	SUBWF       SetOntimeStr_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SetOntimeStr215
;function.c,937 :: 		Actural_disp_str[strlocat][j++] = databuff / Chr_str[i] + 0x30;
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetOntimeStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetOntimeStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FLOC__SetOntimeStr+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__SetOntimeStr+1 
	MOVF        SetOntimeStr_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	MOVLW       function_Chr_str+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(function_Chr_str+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(function_Chr_str+0)
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R4
	TBLRD*+
	MOVFF       TABLAT+0, R5
	TBLRD*+
	MOVFF       TABLAT+0, R6
	TBLRD*+
	MOVFF       TABLAT+0, R7
	MOVF        FARG_SetOntimeStr_databuff+0, 0 
	MOVWF       R0 
	MOVF        FARG_SetOntimeStr_databuff+1, 0 
	MOVWF       R1 
	MOVF        FARG_SetOntimeStr_databuff+2, 0 
	MOVWF       R2 
	MOVF        FARG_SetOntimeStr_databuff+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__SetOntimeStr+0, FSR1
	MOVFF       FLOC__SetOntimeStr+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        SetOntimeStr_j_L0+0, 1 
;function.c,938 :: 		databuff %= Chr_str[i];
	MOVF        SetOntimeStr_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	MOVLW       function_Chr_str+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(function_Chr_str+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(function_Chr_str+0)
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R4
	TBLRD*+
	MOVFF       TABLAT+0, R5
	TBLRD*+
	MOVFF       TABLAT+0, R6
	TBLRD*+
	MOVFF       TABLAT+0, R7
	MOVF        FARG_SetOntimeStr_databuff+0, 0 
	MOVWF       R0 
	MOVF        FARG_SetOntimeStr_databuff+1, 0 
	MOVWF       R1 
	MOVF        FARG_SetOntimeStr_databuff+2, 0 
	MOVWF       R2 
	MOVF        FARG_SetOntimeStr_databuff+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R10, 0 
	MOVWF       R2 
	MOVF        R11, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       FARG_SetOntimeStr_databuff+0 
	MOVF        R1, 0 
	MOVWF       FARG_SetOntimeStr_databuff+1 
	MOVF        R2, 0 
	MOVWF       FARG_SetOntimeStr_databuff+2 
	MOVF        R3, 0 
	MOVWF       FARG_SetOntimeStr_databuff+3 
;function.c,935 :: 		for(; i<8; i++)
	INCF        SetOntimeStr_i_L0+0, 1 
;function.c,939 :: 		}
	GOTO        L_SetOntimeStr214
L_SetOntimeStr215:
;function.c,941 :: 		Actural_disp_str[strlocat][j++] = ' ';
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetOntimeStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetOntimeStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       32
	MOVWF       POSTINC1+0 
	INCF        SetOntimeStr_j_L0+0, 1 
;function.c,942 :: 		for(i=0;i<5;i++)
	CLRF        SetOntimeStr_i_L0+0 
L_SetOntimeStr217:
	MOVLW       5
	SUBWF       SetOntimeStr_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SetOntimeStr218
;function.c,943 :: 		Actural_disp_str[strlocat][j++] = SPCUnit[UNIT_HOUR][i];
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SetOntimeStr_strlocat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 1 
	MOVF        SetOntimeStr_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       function_SPCUnit+72
	ADDWF       SetOntimeStr_i_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(function_SPCUnit+72)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(function_SPCUnit+72)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        SetOntimeStr_j_L0+0, 1 
;function.c,942 :: 		for(i=0;i<5;i++)
	INCF        SetOntimeStr_i_L0+0, 1 
;function.c,943 :: 		Actural_disp_str[strlocat][j++] = SPCUnit[UNIT_HOUR][i];
	GOTO        L_SetOntimeStr217
L_SetOntimeStr218:
;function.c,944 :: 		}
L_end_SetOntimeStr:
	RETURN      0
; end of _SetOntimeStr

_SetAlarmStr:

;function.c,953 :: 		char unitype, char len, char cmd)
;function.c,957 :: 		ClearStr(ptr, 16);
	MOVF        FARG_SetAlarmStr_ptr+0, 0 
	MOVWF       FARG_ClearStr_target+0 
	MOVF        FARG_SetAlarmStr_ptr+1, 0 
	MOVWF       FARG_ClearStr_target+1 
	MOVLW       16
	MOVWF       FARG_ClearStr_len+0 
	MOVLW       0
	MOVWF       FARG_ClearStr_len+1 
	CALL        _ClearStr+0, 0
;function.c,959 :: 		if(datasouce > 9)
	MOVF        FARG_SetAlarmStr_datasouce+0, 0 
	SUBLW       9
	BTFSC       STATUS+0, 0 
	GOTO        L_SetAlarmStr220
;function.c,961 :: 		*(ptr++) = datasouce/10 + 0x30;
	MOVLW       10
	MOVWF       R4 
	MOVF        FARG_SetAlarmStr_datasouce+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVFF       FARG_SetAlarmStr_ptr+0, FSR1
	MOVFF       FARG_SetAlarmStr_ptr+1, FSR1H
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      FARG_SetAlarmStr_ptr+0, 1 
	INCF        FARG_SetAlarmStr_ptr+1, 1 
;function.c,962 :: 		*(ptr++) = datasouce%10 + 0x30;
	MOVLW       10
	MOVWF       R4 
	MOVF        FARG_SetAlarmStr_datasouce+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVFF       FARG_SetAlarmStr_ptr+0, FSR1
	MOVFF       FARG_SetAlarmStr_ptr+1, FSR1H
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      FARG_SetAlarmStr_ptr+0, 1 
	INCF        FARG_SetAlarmStr_ptr+1, 1 
;function.c,963 :: 		}
	GOTO        L_SetAlarmStr221
L_SetAlarmStr220:
;function.c,965 :: 		*(ptr++) = datasouce + 0x30;
	MOVFF       FARG_SetAlarmStr_ptr+0, FSR1
	MOVFF       FARG_SetAlarmStr_ptr+1, FSR1H
	MOVLW       48
	ADDWF       FARG_SetAlarmStr_datasouce+0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      FARG_SetAlarmStr_ptr+0, 1 
	INCF        FARG_SetAlarmStr_ptr+1, 1 
L_SetAlarmStr221:
;function.c,967 :: 		*(ptr++) = '/';
	MOVFF       FARG_SetAlarmStr_ptr+0, FSR1
	MOVFF       FARG_SetAlarmStr_ptr+1, FSR1H
	MOVLW       47
	MOVWF       POSTINC1+0 
	INFSNZ      FARG_SetAlarmStr_ptr+0, 1 
	INCF        FARG_SetAlarmStr_ptr+1, 1 
;function.c,969 :: 		if(cmd == ALARM_SUBINDEX)
	MOVF        FARG_SetAlarmStr_cmd+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SetAlarmStr222
;function.c,971 :: 		if(datatotle > 9)
	MOVF        FARG_SetAlarmStr_datatotle+0, 0 
	SUBLW       9
	BTFSC       STATUS+0, 0 
	GOTO        L_SetAlarmStr223
;function.c,973 :: 		*(ptr++) = datatotle/10 + 0x30;
	MOVLW       10
	MOVWF       R4 
	MOVF        FARG_SetAlarmStr_datatotle+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVFF       FARG_SetAlarmStr_ptr+0, FSR1
	MOVFF       FARG_SetAlarmStr_ptr+1, FSR1H
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      FARG_SetAlarmStr_ptr+0, 1 
	INCF        FARG_SetAlarmStr_ptr+1, 1 
;function.c,974 :: 		*(ptr++) = datatotle%10 + 0x30;
	MOVLW       10
	MOVWF       R4 
	MOVF        FARG_SetAlarmStr_datatotle+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVFF       FARG_SetAlarmStr_ptr+0, FSR1
	MOVFF       FARG_SetAlarmStr_ptr+1, FSR1H
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      FARG_SetAlarmStr_ptr+0, 1 
	INCF        FARG_SetAlarmStr_ptr+1, 1 
;function.c,975 :: 		}
	GOTO        L_SetAlarmStr224
L_SetAlarmStr223:
;function.c,977 :: 		*(ptr++) = datatotle + 0x30;
	MOVFF       FARG_SetAlarmStr_ptr+0, FSR1
	MOVFF       FARG_SetAlarmStr_ptr+1, FSR1H
	MOVLW       48
	ADDWF       FARG_SetAlarmStr_datatotle+0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      FARG_SetAlarmStr_ptr+0, 1 
	INCF        FARG_SetAlarmStr_ptr+1, 1 
L_SetAlarmStr224:
;function.c,978 :: 		}
L_SetAlarmStr222:
;function.c,980 :: 		for(i=0;i<len;i++)
	CLRF        SetAlarmStr_i_L0+0 
L_SetAlarmStr225:
	MOVF        FARG_SetAlarmStr_len+0, 0 
	SUBWF       SetAlarmStr_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SetAlarmStr226
;function.c,981 :: 		*(ptr+i) = SPCUnit[unitype][i];
	MOVF        SetAlarmStr_i_L0+0, 0 
	ADDWF       FARG_SetAlarmStr_ptr+0, 0 
	MOVWF       FLOC__SetAlarmStr+0 
	MOVLW       0
	ADDWFC      FARG_SetAlarmStr_ptr+1, 0 
	MOVWF       FLOC__SetAlarmStr+1 
	MOVLW       9
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        FARG_SetAlarmStr_unitype+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       function_SPCUnit+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(function_SPCUnit+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(function_SPCUnit+0)
	ADDWFC      R2, 1 
	MOVF        SetAlarmStr_i_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVFF       FLOC__SetAlarmStr+0, FSR1
	MOVFF       FLOC__SetAlarmStr+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;function.c,980 :: 		for(i=0;i<len;i++)
	INCF        SetAlarmStr_i_L0+0, 1 
;function.c,981 :: 		*(ptr+i) = SPCUnit[unitype][i];
	GOTO        L_SetAlarmStr225
L_SetAlarmStr226:
;function.c,982 :: 		}
L_end_SetAlarmStr:
	RETURN      0
; end of _SetAlarmStr

_GetAlarmEn:

;function.c,984 :: 		char GetAlarmEn()
;function.c,986 :: 		return AlarmEn;
	MOVF        _AlarmEn+0, 0 
	MOVWF       R0 
;function.c,987 :: 		}
L_end_GetAlarmEn:
	RETURN      0
; end of _GetAlarmEn

_AutoAutho:

;function.c,989 :: 		void AutoAutho()
;function.c,991 :: 		if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en)
	BTFSS       _pSPCValue+139, 0 
	GOTO        L_AutoAutho228
;function.c,993 :: 		if(AutoAuthoEN == 0)
	MOVF        _AutoAuthoEN+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_AutoAutho229
;function.c,995 :: 		AutoAuthoEN = 1;
	MOVLW       1
	MOVWF       _AutoAuthoEN+0 
;function.c,996 :: 		AutoAuthoCount = 0;
	CLRF        _AutoAuthoCount+0 
;function.c,997 :: 		}
	GOTO        L_AutoAutho230
L_AutoAutho229:
;function.c,998 :: 		else if(AutoAuthoEN == 2)
	MOVF        _AutoAuthoEN+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_AutoAutho231
;function.c,1000 :: 		AutoAuthoEN = 0;
	CLRF        _AutoAuthoEN+0 
;function.c,1001 :: 		AutoAuthoCount = 0;
	CLRF        _AutoAuthoCount+0 
;function.c,1002 :: 		}
L_AutoAutho231:
L_AutoAutho230:
;function.c,1003 :: 		}
	GOTO        L_AutoAutho232
L_AutoAutho228:
;function.c,1006 :: 		AutoAuthoEN = 0;
	CLRF        _AutoAuthoEN+0 
;function.c,1007 :: 		AutoAuthoCount = 0;
	CLRF        _AutoAuthoCount+0 
;function.c,1008 :: 		}
L_AutoAutho232:
;function.c,1009 :: 		}
L_end_AutoAutho:
	RETURN      0
; end of _AutoAutho

_ResetAutoAutho:

;function.c,1011 :: 		void ResetAutoAutho()
;function.c,1013 :: 		AutoAuthoCount = 0;
	CLRF        _AutoAuthoCount+0 
;function.c,1014 :: 		}
L_end_ResetAutoAutho:
	RETURN      0
; end of _ResetAutoAutho

_GetAutoAutho:

;function.c,1016 :: 		char GetAutoAutho()
;function.c,1018 :: 		return AutoAuthoEN;
	MOVF        _AutoAuthoEN+0, 0 
	MOVWF       R0 
;function.c,1019 :: 		}
L_end_GetAutoAutho:
	RETURN      0
; end of _GetAutoAutho

_SetAutoAutho:

;function.c,1021 :: 		void SetAutoAutho(char AutoAuthoCmd)
;function.c,1023 :: 		AutoAuthoEN = AutoAuthoCmd;
	MOVF        FARG_SetAutoAutho_AutoAuthoCmd+0, 0 
	MOVWF       _AutoAuthoEN+0 
;function.c,1024 :: 		}
L_end_SetAutoAutho:
	RETURN      0
; end of _SetAutoAutho
