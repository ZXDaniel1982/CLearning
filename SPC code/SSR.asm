
_Alarm_SSR_on:

;SSR.c,48 :: 		void Alarm_SSR_on(char ChannelNum)
;SSR.c,50 :: 		if(ChannelNum == CHANNEL1)
	MOVF        FARG_Alarm_SSR_on_ChannelNum+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Alarm_SSR_on0
;SSR.c,52 :: 		ENABLE_ALARM_SSR_CH1
	BSF         LATB4_bit+0, BitPos(LATB4_bit+0) 
	BSF         LATB5_bit+0, BitPos(LATB5_bit+0) 
;SSR.c,53 :: 		}
	GOTO        L_Alarm_SSR_on1
L_Alarm_SSR_on0:
;SSR.c,54 :: 		else if(ChannelNum == CHANNEL2)
	MOVF        FARG_Alarm_SSR_on_ChannelNum+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Alarm_SSR_on2
;SSR.c,56 :: 		ENABLE_ALARM_SSR_CH2
	BSF         LATB1_bit+0, BitPos(LATB1_bit+0) 
	BSF         LATB2_bit+0, BitPos(LATB2_bit+0) 
;SSR.c,57 :: 		}
L_Alarm_SSR_on2:
L_Alarm_SSR_on1:
;SSR.c,58 :: 		}
L_end_Alarm_SSR_on:
	RETURN      0
; end of _Alarm_SSR_on

_Alarm_SSR_off:

;SSR.c,60 :: 		void Alarm_SSR_off(char ChannelNum)
;SSR.c,62 :: 		if(ChannelNum == CHANNEL1)
	MOVF        FARG_Alarm_SSR_off_ChannelNum+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Alarm_SSR_off3
;SSR.c,64 :: 		DISABLE_ALARM_SSR_CH1
	BCF         LATB4_bit+0, BitPos(LATB4_bit+0) 
	BCF         LATB5_bit+0, BitPos(LATB5_bit+0) 
;SSR.c,65 :: 		}
	GOTO        L_Alarm_SSR_off4
L_Alarm_SSR_off3:
;SSR.c,66 :: 		else if(ChannelNum == CHANNEL2)
	MOVF        FARG_Alarm_SSR_off_ChannelNum+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Alarm_SSR_off5
;SSR.c,68 :: 		DISABLE_ALARM_SSR_CH2
	BCF         LATB1_bit+0, BitPos(LATB1_bit+0) 
	BCF         LATB2_bit+0, BitPos(LATB2_bit+0) 
;SSR.c,69 :: 		}
L_Alarm_SSR_off5:
L_Alarm_SSR_off4:
;SSR.c,70 :: 		}
L_end_Alarm_SSR_off:
	RETURN      0
; end of _Alarm_SSR_off

_relay_on:

;SSR.c,77 :: 		char relay_on(char ChannelNum)
;SSR.c,79 :: 		if(Spcssr[ChannelNum].SSR_actual_stat == RELAY_IS_OFF)
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_relay_on_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcssr+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcssr+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_relay_on6
;SSR.c,81 :: 		if(ChannelNum)
	MOVF        FARG_relay_on_ChannelNum+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_relay_on7
;SSR.c,82 :: 		LATC5_bit = 1;     //channel 2
	BSF         LATC5_bit+0, BitPos(LATC5_bit+0) 
	GOTO        L_relay_on8
L_relay_on7:
;SSR.c,84 :: 		LATC2_bit = 1;     //channel 1
	BSF         LATC2_bit+0, BitPos(LATC2_bit+0) 
L_relay_on8:
;SSR.c,85 :: 		Spcssr[ChannelNum].SSR_actual_stat = RELAY_IS_ON;
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_relay_on_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcssr+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcssr+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
;SSR.c,86 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_relay_on
;SSR.c,87 :: 		}
L_relay_on6:
;SSR.c,89 :: 		return 0;
	CLRF        R0 
;SSR.c,90 :: 		}
L_end_relay_on:
	RETURN      0
; end of _relay_on

_relay_off:

;SSR.c,92 :: 		char relay_off(char ChannelNum)
;SSR.c,94 :: 		if(Spcssr[ChannelNum].SSR_actual_stat == RELAY_IS_ON)
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_relay_off_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcssr+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcssr+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_relay_off10
;SSR.c,96 :: 		if(ChannelNum)
	MOVF        FARG_relay_off_ChannelNum+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_relay_off11
;SSR.c,97 :: 		LATC5_bit = 0;     //channel 2
	BCF         LATC5_bit+0, BitPos(LATC5_bit+0) 
	GOTO        L_relay_off12
L_relay_off11:
;SSR.c,99 :: 		LATC2_bit = 0;     //channel 1
	BCF         LATC2_bit+0, BitPos(LATC2_bit+0) 
L_relay_off12:
;SSR.c,100 :: 		Spcssr[ChannelNum].SSR_actual_stat = RELAY_IS_OFF;
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_relay_off_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcssr+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcssr+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;SSR.c,101 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_relay_off
;SSR.c,102 :: 		}
L_relay_off10:
;SSR.c,104 :: 		return 0;
	CLRF        R0 
;SSR.c,106 :: 		}
L_end_relay_off:
	RETURN      0
; end of _relay_off

_relay_on_ISR:

;SSR.c,108 :: 		char relay_on_ISR(char ChannelNum)
;SSR.c,110 :: 		if(Spcssr[ChannelNum].SSR_actual_stat == RELAY_IS_OFF)
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_relay_on_ISR_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcssr+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcssr+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_relay_on_ISR14
;SSR.c,112 :: 		if(ChannelNum)
	MOVF        FARG_relay_on_ISR_ChannelNum+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_relay_on_ISR15
;SSR.c,113 :: 		LATC5_bit = 1;     //channel 2
	BSF         LATC5_bit+0, BitPos(LATC5_bit+0) 
	GOTO        L_relay_on_ISR16
L_relay_on_ISR15:
;SSR.c,115 :: 		LATC2_bit = 1;     //channel 1
	BSF         LATC2_bit+0, BitPos(LATC2_bit+0) 
L_relay_on_ISR16:
;SSR.c,116 :: 		Spcssr[ChannelNum].SSR_actual_stat = RELAY_IS_ON;
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_relay_on_ISR_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcssr+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcssr+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
;SSR.c,117 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_relay_on_ISR
;SSR.c,118 :: 		}
L_relay_on_ISR14:
;SSR.c,120 :: 		return 0;
	CLRF        R0 
;SSR.c,121 :: 		}
L_end_relay_on_ISR:
	RETURN      0
; end of _relay_on_ISR

_relay_off_ISR:

;SSR.c,123 :: 		char relay_off_ISR(char ChannelNum)
;SSR.c,125 :: 		if(Spcssr[ChannelNum].SSR_actual_stat == RELAY_IS_ON)
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_relay_off_ISR_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcssr+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcssr+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_relay_off_ISR18
;SSR.c,127 :: 		if(ChannelNum)
	MOVF        FARG_relay_off_ISR_ChannelNum+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_relay_off_ISR19
;SSR.c,128 :: 		LATC5_bit = 0;     //channel 2
	BCF         LATC5_bit+0, BitPos(LATC5_bit+0) 
	GOTO        L_relay_off_ISR20
L_relay_off_ISR19:
;SSR.c,130 :: 		LATC2_bit = 0;     //channel 1
	BCF         LATC2_bit+0, BitPos(LATC2_bit+0) 
L_relay_off_ISR20:
;SSR.c,131 :: 		Spcssr[ChannelNum].SSR_actual_stat = RELAY_IS_OFF;
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_relay_off_ISR_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcssr+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcssr+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;SSR.c,132 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_relay_off_ISR
;SSR.c,133 :: 		}
L_relay_off_ISR18:
;SSR.c,135 :: 		return 0;
	CLRF        R0 
;SSR.c,137 :: 		}
L_end_relay_off_ISR:
	RETURN      0
; end of _relay_off_ISR

_softstart:

;SSR.c,144 :: 		char softstart(char ChannelNum)
;SSR.c,146 :: 		char dutychange=0;
	CLRF        softstart_dutychange_L0+0 
;SSR.c,149 :: 		if(SpcSstart[ChannelNum].SOFTSTART_stat == 0)          //IDEL
	MOVLW       5
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_softstart_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _SpcSstart+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_SpcSstart+0)
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
	GOTO        L_softstart22
;SSR.c,151 :: 		duty_index[ChannelNum] = 1;
	MOVF        FARG_softstart_ChannelNum+0, 0 
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
	MOVLW       1
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;SSR.c,152 :: 		temp = duty_index[ChannelNum];
	MOVF        FARG_softstart_ChannelNum+0, 0 
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
	MOVWF       R5 
	MOVF        R5, 0 
	MOVWF       softstart_temp_L0+0 
;SSR.c,153 :: 		pwm_duty[ChannelNum] = duty_table[temp];
	MOVLW       _pwm_duty+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_pwm_duty+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        R5, 0 
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
	MOVLW       _duty_table+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_duty_table+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(_duty_table+0)
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	TBLRD*+
	MOVFF       TABLAT+0, R1
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;SSR.c,154 :: 		dutychange = 1;
	MOVLW       1
	MOVWF       softstart_dutychange_L0+0 
;SSR.c,155 :: 		SpcSstart[ChannelNum].SOFTSTART_cmd = 1;      //SOFTSTART_EN
	MOVLW       5
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_softstart_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _SpcSstart+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_SpcSstart+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
;SSR.c,156 :: 		SpcSstart[ChannelNum].SOFTSTART_stat = 1;       //RUNNING
	MOVLW       5
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_softstart_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _SpcSstart+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_SpcSstart+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
;SSR.c,157 :: 		Spcpwm[ChannelNum].pwm_cmd = 1;
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_softstart_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
;SSR.c,158 :: 		if(pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent == SPC_SYSTEMVALUE_OFF)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_softstart_ChannelNum+0, 0 
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
	GOTO        L__softstart111
	MOVLW       255
	XORWF       R1, 0 
L__softstart111:
	BTFSS       STATUS+0, 2 
	GOTO        L_softstart23
;SSR.c,159 :: 		SoftStartElement[ChannelNum] = pSPCValue[ChannelNum].SPCSetPoints.SoftStartTime/10;
	MOVF        FARG_softstart_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _SoftStartElement+0
	ADDWF       R0, 0 
	MOVWF       FLOC__softstart+0 
	MOVLW       hi_addr(_SoftStartElement+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__softstart+1 
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_softstart_ChannelNum+0, 0 
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
	MOVLW       30
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
	MOVFF       FLOC__softstart+0, FSR1
	MOVFF       FLOC__softstart+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	GOTO        L_softstart24
L_softstart23:
;SSR.c,161 :: 		SoftStartElement[ChannelNum] = pSPCValue[ChannelNum].SPCSetPoints.SoftStartTime*10/pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent;
	MOVF        FARG_softstart_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _SoftStartElement+0
	ADDWF       R0, 0 
	MOVWF       FLOC__softstart+2 
	MOVLW       hi_addr(_SoftStartElement+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__softstart+3 
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_softstart_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 1 
	MOVLW       54
	ADDWF       R0, 0 
	MOVWF       FLOC__softstart+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__softstart+1 
	MOVLW       30
	ADDWF       FLOC__softstart+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FLOC__softstart+1, 0 
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
	MOVLW       28
	ADDWF       FLOC__softstart+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      FLOC__softstart+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R4 
	MOVF        POSTINC2+0, 0 
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVFF       FLOC__softstart+2, FSR1
	MOVFF       FLOC__softstart+3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
L_softstart24:
;SSR.c,163 :: 		if(dutychange)
	MOVF        softstart_dutychange_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_softstart25
;SSR.c,165 :: 		dutyshadeSOFTSATRT = duty_index[ChannelNum]*10;
	MOVF        FARG_softstart_ChannelNum+0, 0 
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
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _dutyshadeSOFTSATRT+0 
	MOVF        R1, 0 
	MOVWF       _dutyshadeSOFTSATRT+1 
;SSR.c,166 :: 		SystemUpdate |= (CH1_DUTY_UPDATE_REQ << ChannelNum);
	MOVF        FARG_softstart_ChannelNum+0, 0 
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
L__softstart112:
	BZ          L__softstart113
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__softstart112
L__softstart113:
	MOVF        R0, 0 
	IORWF       _SystemUpdate+0, 1 
	MOVF        R1, 0 
	IORWF       _SystemUpdate+1, 1 
	MOVF        R2, 0 
	IORWF       _SystemUpdate+2, 1 
	MOVF        R3, 0 
	IORWF       _SystemUpdate+3, 1 
;SSR.c,167 :: 		SetIntStr((int*)&dutyshadeSOFTSATRT, CH1_ACTURAL_DUTY+ChannelNum, UNIT_PERCENT, 1);
	MOVLW       _dutyshadeSOFTSATRT+0
	MOVWF       FARG_SetIntStr_ptr+0 
	MOVLW       hi_addr(_dutyshadeSOFTSATRT+0)
	MOVWF       FARG_SetIntStr_ptr+1 
	MOVF        FARG_softstart_ChannelNum+0, 0 
	ADDLW       18
	MOVWF       FARG_SetIntStr_strlocat+0 
	MOVLW       9
	MOVWF       FARG_SetIntStr_unitlocar+0 
	MOVLW       1
	MOVWF       FARG_SetIntStr_len+0 
	CALL        _SetIntStr+0, 0
;SSR.c,168 :: 		}
L_softstart25:
;SSR.c,169 :: 		}
	GOTO        L_softstart26
L_softstart22:
;SSR.c,170 :: 		else if(SpcSstart[ChannelNum].SOFTSTART_stat == 1)          //RUNNING
	MOVLW       5
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_softstart_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _SpcSstart+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_SpcSstart+0)
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
	GOTO        L_softstart27
;SSR.c,172 :: 		if(SpcSstart[ChannelNum].SOFTSTART_reach == 1)     //每过1秒
	MOVLW       5
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_softstart_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _SpcSstart+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_SpcSstart+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_softstart28
;SSR.c,174 :: 		SpcSstart[ChannelNum].SOFTSTART_reach = 0;
	MOVLW       5
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_softstart_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _SpcSstart+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_SpcSstart+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;SSR.c,175 :: 		if(SpcSstart[ChannelNum].SOFTSTART_count >= pSPCValue[ChannelNum].SPCSetPoints.SoftStartTime)     //如果客户定义的softstart时间到了
	MOVLW       5
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_softstart_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _SpcSstart+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_SpcSstart+0)
	ADDWFC      R1, 1 
	MOVLW       3
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__softstart+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__softstart+1 
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_softstart_ChannelNum+0, 0 
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
	MOVLW       30
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	SUBWF       FLOC__softstart+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__softstart114
	MOVF        R1, 0 
	SUBWF       FLOC__softstart+0, 0 
L__softstart114:
	BTFSS       STATUS+0, 0 
	GOTO        L_softstart29
;SSR.c,177 :: 		SpcSstart[ChannelNum].SOFTSTART_count = 0;
	MOVLW       5
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_softstart_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _SpcSstart+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_SpcSstart+0)
	ADDWFC      R1, 1 
	MOVLW       3
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;SSR.c,178 :: 		SoftStartElementCount[ChannelNum] = 0;
	MOVF        FARG_softstart_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _SoftStartElementCount+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_SoftStartElementCount+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;SSR.c,179 :: 		SpcSstart[ChannelNum].SOFTSTART_cmd = 0;       //SOFTSTART_DIS
	MOVLW       5
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_softstart_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _SpcSstart+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_SpcSstart+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;SSR.c,180 :: 		}
	GOTO        L_softstart30
L_softstart29:
;SSR.c,183 :: 		SpcSstart[ChannelNum].SOFTSTART_count++;
	MOVLW       5
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_softstart_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _SpcSstart+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_SpcSstart+0)
	ADDWFC      R1, 1 
	MOVLW       3
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVLW       1
	ADDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      POSTINC0+0, 0 
	MOVWF       R1 
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;SSR.c,184 :: 		SoftStartElementCount[ChannelNum]++;
	MOVF        FARG_softstart_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _SoftStartElementCount+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_SoftStartElementCount+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVLW       1
	ADDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      POSTINC0+0, 0 
	MOVWF       R1 
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;SSR.c,185 :: 		if(SoftStartElementCount[ChannelNum] >= SoftStartElement[ChannelNum])
	MOVF        FARG_softstart_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _SoftStartElementCount+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_SoftStartElementCount+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       _SoftStartElement+0
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       hi_addr(_SoftStartElement+0)
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	SUBWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__softstart115
	MOVF        R1, 0 
	SUBWF       R3, 0 
L__softstart115:
	BTFSS       STATUS+0, 0 
	GOTO        L_softstart31
;SSR.c,187 :: 		SoftStartElementCount[ChannelNum] = 0;
	MOVF        FARG_softstart_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _SoftStartElementCount+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_SoftStartElementCount+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;SSR.c,188 :: 		if(duty_index[ChannelNum] < 10)
	MOVF        FARG_softstart_ChannelNum+0, 0 
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
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__softstart116
	MOVLW       10
	SUBWF       R1, 0 
L__softstart116:
	BTFSC       STATUS+0, 0 
	GOTO        L_softstart32
;SSR.c,190 :: 		temp = duty_index[ChannelNum]++;
	MOVF        FARG_softstart_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _duty_index+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_duty_index+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       softstart_temp_L0+0 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVLW       1
	ADDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      POSTINC0+0, 0 
	MOVWF       R1 
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;SSR.c,191 :: 		pwm_duty[ChannelNum] = duty_table[temp];
	MOVF        FARG_softstart_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pwm_duty+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_pwm_duty+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        softstart_temp_L0+0, 0 
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
	MOVLW       _duty_table+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_duty_table+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(_duty_table+0)
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	TBLRD*+
	MOVFF       TABLAT+0, R1
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;SSR.c,192 :: 		dutychange = 1;
	MOVLW       1
	MOVWF       softstart_dutychange_L0+0 
;SSR.c,193 :: 		}
L_softstart32:
;SSR.c,194 :: 		}
L_softstart31:
;SSR.c,195 :: 		}
L_softstart30:
;SSR.c,196 :: 		}
L_softstart28:
;SSR.c,198 :: 		if(dutychange)
	MOVF        softstart_dutychange_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_softstart33
;SSR.c,200 :: 		dutyshadeSOFTSATRT = duty_index[ChannelNum]*10;
	MOVF        FARG_softstart_ChannelNum+0, 0 
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
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _dutyshadeSOFTSATRT+0 
	MOVF        R1, 0 
	MOVWF       _dutyshadeSOFTSATRT+1 
;SSR.c,201 :: 		SystemUpdate |= (CH1_DUTY_UPDATE_REQ << ChannelNum);
	MOVF        FARG_softstart_ChannelNum+0, 0 
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
L__softstart117:
	BZ          L__softstart118
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__softstart117
L__softstart118:
	MOVF        R0, 0 
	IORWF       _SystemUpdate+0, 1 
	MOVF        R1, 0 
	IORWF       _SystemUpdate+1, 1 
	MOVF        R2, 0 
	IORWF       _SystemUpdate+2, 1 
	MOVF        R3, 0 
	IORWF       _SystemUpdate+3, 1 
;SSR.c,202 :: 		SetIntStr((int*)&dutyshadeSOFTSATRT, CH1_ACTURAL_DUTY+ChannelNum, UNIT_PERCENT, 1);
	MOVLW       _dutyshadeSOFTSATRT+0
	MOVWF       FARG_SetIntStr_ptr+0 
	MOVLW       hi_addr(_dutyshadeSOFTSATRT+0)
	MOVWF       FARG_SetIntStr_ptr+1 
	MOVF        FARG_softstart_ChannelNum+0, 0 
	ADDLW       18
	MOVWF       FARG_SetIntStr_strlocat+0 
	MOVLW       9
	MOVWF       FARG_SetIntStr_unitlocar+0 
	MOVLW       1
	MOVWF       FARG_SetIntStr_len+0 
	CALL        _SetIntStr+0, 0
;SSR.c,203 :: 		}
L_softstart33:
;SSR.c,205 :: 		if(SpcSstart[ChannelNum].SOFTSTART_cmd == 0)      //softstart结束    SOFTSTART_DIS
	MOVLW       5
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_softstart_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _SpcSstart+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_SpcSstart+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_softstart34
;SSR.c,207 :: 		SpcSstart[ChannelNum].SOFTSTART_stat = 0;       //IDEL
	MOVLW       5
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_softstart_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _SpcSstart+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_SpcSstart+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;SSR.c,208 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_softstart
;SSR.c,209 :: 		}
L_softstart34:
;SSR.c,210 :: 		}
L_softstart27:
L_softstart26:
;SSR.c,212 :: 		return 0;
	CLRF        R0 
;SSR.c,213 :: 		}
L_end_softstart:
	RETURN      0
; end of _softstart

_RSSoperation:

;SSR.c,220 :: 		void RSSoperation(char ChannelNum)
;SSR.c,224 :: 		if(pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.heater_en == 0)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
	BTFSC       R0, 1 
	GOTO        L_RSSoperation35
;SSR.c,226 :: 		ForceSSROFFCondition[ChannelNum] |= HEATERDISABLEFORCEOFF;
	MOVLW       _ForceSSROFFCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSROFFCondition+0)
	MOVWF       R2 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVLW       16
	IORWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;SSR.c,227 :: 		}
	GOTO        L_RSSoperation36
L_RSSoperation35:
;SSR.c,230 :: 		ForceSSROFFCondition[ChannelNum] &= ~HEATERDISABLEFORCEOFF;
	MOVLW       _ForceSSROFFCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSROFFCondition+0)
	MOVWF       R2 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
;SSR.c,231 :: 		}
L_RSSoperation36:
;SSR.c,235 :: 		if(ForceSSROFFCondition[ChannelNum] & (GFITRIPFORCEOFF+HIGHTEMPCUTOFFFORCEOFF+MANUALFORCEOFF+HEATERDISABLEFORCEOFF))
	MOVLW       _ForceSSROFFCondition+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_ForceSSROFFCondition+0)
	MOVWF       FSR0H 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVLW       27
	ANDWF       POSTINC0+0, 0 
	MOVWF       R0 
	BTFSC       STATUS+0, 2 
	GOTO        L_RSSoperation37
;SSR.c,236 :: 		LoadForce = FORCE_LOAD_OFF;
	MOVLW       2
	MOVWF       RSSoperation_LoadForce_L0+0 
	GOTO        L_RSSoperation38
L_RSSoperation37:
;SSR.c,239 :: 		if(ForceSSRONCondition[ChannelNum] & (GFITESTFORCEON+HEATERTESTFORCEON+FAILUREMODEFORCEON))
	MOVLW       _ForceSSRONCondition+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_ForceSSRONCondition+0)
	MOVWF       FSR0H 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVLW       11
	ANDWF       POSTINC0+0, 0 
	MOVWF       R0 
	BTFSC       STATUS+0, 2 
	GOTO        L_RSSoperation39
;SSR.c,240 :: 		LoadForce = FORCE_LOAD_ON;
	MOVLW       1
	MOVWF       RSSoperation_LoadForce_L0+0 
	GOTO        L_RSSoperation40
L_RSSoperation39:
;SSR.c,243 :: 		if(ForceSSROFFCondition[ChannelNum] & FAILUREMODEFORCEOFF)
	MOVLW       _ForceSSROFFCondition+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_ForceSSROFFCondition+0)
	MOVWF       FSR0H 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	BTFSS       R1, 2 
	GOTO        L_RSSoperation41
;SSR.c,244 :: 		LoadForce = FORCE_LOAD_OFF;
	MOVLW       2
	MOVWF       RSSoperation_LoadForce_L0+0 
	GOTO        L_RSSoperation42
L_RSSoperation41:
;SSR.c,247 :: 		if(ForceSSRONCondition[ChannelNum] & AUTOTESTFORCEON)
	MOVLW       _ForceSSRONCondition+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_ForceSSRONCondition+0)
	MOVWF       FSR0H 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	BTFSS       R1, 2 
	GOTO        L_RSSoperation43
;SSR.c,248 :: 		LoadForce = FORCE_LOAD_ON;
	MOVLW       1
	MOVWF       RSSoperation_LoadForce_L0+0 
	GOTO        L_RSSoperation44
L_RSSoperation43:
;SSR.c,250 :: 		LoadForce = LOAD_OK;
	CLRF        RSSoperation_LoadForce_L0+0 
L_RSSoperation44:
;SSR.c,251 :: 		}
L_RSSoperation42:
;SSR.c,252 :: 		}
L_RSSoperation40:
;SSR.c,253 :: 		}
L_RSSoperation38:
;SSR.c,255 :: 		if(LoadForce == FORCE_LOAD_ON)
	MOVF        RSSoperation_LoadForce_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_RSSoperation45
;SSR.c,257 :: 		SSRForceOp[ChannelNum] = FORCE_LOAD_ON;
	MOVLW       _SSRForceOp+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_SSRForceOp+0)
	MOVWF       FSR1H 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       1
	MOVWF       POSTINC1+0 
;SSR.c,258 :: 		if(ForceSSRONCondition[ChannelNum] & (HEATERTESTFORCEON + FAILUREMODEFORCEON))
	MOVLW       _ForceSSRONCondition+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_ForceSSRONCondition+0)
	MOVWF       FSR0H 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVLW       10
	ANDWF       POSTINC0+0, 0 
	MOVWF       R0 
	BTFSC       STATUS+0, 2 
	GOTO        L_RSSoperation46
;SSR.c,260 :: 		if(pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent != SPC_SYSTEMVALUE_OFF)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
	GOTO        L__RSSoperation120
	MOVLW       255
	XORWF       R1, 0 
L__RSSoperation120:
	BTFSC       STATUS+0, 2 
	GOTO        L_RSSoperation47
;SSR.c,262 :: 		SetHeatStatStr(HEAT_IS_ON, ChannelNum);
	MOVLW       1
	MOVWF       FARG_SetHeatStatStr_Strlocat+0 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	MOVWF       FARG_SetHeatStatStr_ChannelNum+0 
	CALL        _SetHeatStatStr+0, 0
;SSR.c,263 :: 		Spcpwm[ChannelNum].meas_cmd = IDEL_MEASUREMENT;
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
;SSR.c,264 :: 		Spcssr[ChannelNum].SSR_stat = 1;
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
;SSR.c,265 :: 		Spcpwm[ChannelNum].pwm_cmd = 1;
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
;SSR.c,266 :: 		return;
	GOTO        L_end_RSSoperation
;SSR.c,267 :: 		}
L_RSSoperation47:
;SSR.c,268 :: 		}
L_RSSoperation46:
;SSR.c,270 :: 		if(relay_on(ChannelNum))
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	MOVWF       FARG_relay_on_ChannelNum+0 
	CALL        _relay_on+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_RSSoperation48
;SSR.c,272 :: 		SystemUpdate |= (CH1_HEAT_STAT_UPDATE_REQ << ChannelNum);
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
L__RSSoperation121:
	BZ          L__RSSoperation122
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__RSSoperation121
L__RSSoperation122:
	MOVF        R0, 0 
	IORWF       _SystemUpdate+0, 1 
	MOVF        R1, 0 
	IORWF       _SystemUpdate+1, 1 
	MOVF        R2, 0 
	IORWF       _SystemUpdate+2, 1 
	MOVF        R3, 0 
	IORWF       _SystemUpdate+3, 1 
;SSR.c,273 :: 		SetHeatStatStr(HEAT_IS_ON, ChannelNum);
	MOVLW       1
	MOVWF       FARG_SetHeatStatStr_Strlocat+0 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	MOVWF       FARG_SetHeatStatStr_ChannelNum+0 
	CALL        _SetHeatStatStr+0, 0
;SSR.c,275 :: 		SystemUpdate |= (CH1_DUTY_UPDATE_REQ << ChannelNum);
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
L__RSSoperation123:
	BZ          L__RSSoperation124
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__RSSoperation123
L__RSSoperation124:
	MOVF        R0, 0 
	IORWF       _SystemUpdate+0, 1 
	MOVF        R1, 0 
	IORWF       _SystemUpdate+1, 1 
	MOVF        R2, 0 
	IORWF       _SystemUpdate+2, 1 
	MOVF        R3, 0 
	IORWF       _SystemUpdate+3, 1 
;SSR.c,276 :: 		duty_index[ChannelNum] = 10;
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
;SSR.c,277 :: 		dutyshadeNORMAL = duty_index[ChannelNum]*10;
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _dutyshadeNORMAL+0 
	MOVF        R1, 0 
	MOVWF       _dutyshadeNORMAL+1 
;SSR.c,278 :: 		SetIntStr((int*)&dutyshadeNORMAL, CH1_ACTURAL_DUTY+ChannelNum, UNIT_AMPER_PERCENT, 1);
	MOVLW       _dutyshadeNORMAL+0
	MOVWF       FARG_SetIntStr_ptr+0 
	MOVLW       hi_addr(_dutyshadeNORMAL+0)
	MOVWF       FARG_SetIntStr_ptr+1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	ADDLW       18
	MOVWF       FARG_SetIntStr_strlocat+0 
	MOVLW       9
	MOVWF       FARG_SetIntStr_unitlocar+0 
	MOVLW       1
	MOVWF       FARG_SetIntStr_len+0 
	CALL        _SetIntStr+0, 0
;SSR.c,280 :: 		Spcpwm[ChannelNum].meas_cmd = IDEL_MEASUREMENT;
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
;SSR.c,281 :: 		Spcssr[ChannelNum].SSR_stat = 1;
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
;SSR.c,282 :: 		}
L_RSSoperation48:
;SSR.c,284 :: 		return;
	GOTO        L_end_RSSoperation
;SSR.c,285 :: 		}
L_RSSoperation45:
;SSR.c,286 :: 		else if(LoadForce == FORCE_LOAD_OFF)
	MOVF        RSSoperation_LoadForce_L0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_RSSoperation50
;SSR.c,288 :: 		SSRForceOp[ChannelNum] = FORCE_LOAD_OFF;
	MOVLW       _SSRForceOp+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_SSRForceOp+0)
	MOVWF       FSR1H 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       2
	MOVWF       POSTINC1+0 
;SSR.c,289 :: 		if(relay_off(ChannelNum))
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	MOVWF       FARG_relay_off_ChannelNum+0 
	CALL        _relay_off+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_RSSoperation51
;SSR.c,291 :: 		SystemUpdate |= (CH1_HEAT_STAT_UPDATE_REQ << ChannelNum);
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
L__RSSoperation125:
	BZ          L__RSSoperation126
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__RSSoperation125
L__RSSoperation126:
	MOVF        R0, 0 
	IORWF       _SystemUpdate+0, 1 
	MOVF        R1, 0 
	IORWF       _SystemUpdate+1, 1 
	MOVF        R2, 0 
	IORWF       _SystemUpdate+2, 1 
	MOVF        R3, 0 
	IORWF       _SystemUpdate+3, 1 
;SSR.c,293 :: 		if(pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.man_on)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
	GOTO        L_RSSoperation52
;SSR.c,294 :: 		SetHeatStatStr(HEAT_IS_MANOFF, ChannelNum);
	MOVLW       3
	MOVWF       FARG_SetHeatStatStr_Strlocat+0 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	MOVWF       FARG_SetHeatStatStr_ChannelNum+0 
	CALL        _SetHeatStatStr+0, 0
	GOTO        L_RSSoperation53
L_RSSoperation52:
;SSR.c,296 :: 		SetHeatStatStr(HEAT_IS_OFF, ChannelNum);
	CLRF        FARG_SetHeatStatStr_Strlocat+0 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	MOVWF       FARG_SetHeatStatStr_ChannelNum+0 
	CALL        _SetHeatStatStr+0, 0
L_RSSoperation53:
;SSR.c,298 :: 		SystemUpdate |= (CH1_DUTY_UPDATE_REQ << ChannelNum);
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
L__RSSoperation127:
	BZ          L__RSSoperation128
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__RSSoperation127
L__RSSoperation128:
	MOVF        R0, 0 
	IORWF       _SystemUpdate+0, 1 
	MOVF        R1, 0 
	IORWF       _SystemUpdate+1, 1 
	MOVF        R2, 0 
	IORWF       _SystemUpdate+2, 1 
	MOVF        R3, 0 
	IORWF       _SystemUpdate+3, 1 
;SSR.c,299 :: 		duty_index[ChannelNum] = 0;
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
;SSR.c,300 :: 		dutyshadeNORMAL = duty_index[ChannelNum];
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
	MOVWF       _dutyshadeNORMAL+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       _dutyshadeNORMAL+1 
;SSR.c,301 :: 		SetIntStr((int*)&dutyshadeNORMAL, CH1_ACTURAL_DUTY+ChannelNum, UNIT_AMPER_PERCENT, 1);
	MOVLW       _dutyshadeNORMAL+0
	MOVWF       FARG_SetIntStr_ptr+0 
	MOVLW       hi_addr(_dutyshadeNORMAL+0)
	MOVWF       FARG_SetIntStr_ptr+1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	ADDLW       18
	MOVWF       FARG_SetIntStr_strlocat+0 
	MOVLW       9
	MOVWF       FARG_SetIntStr_unitlocar+0 
	MOVLW       1
	MOVWF       FARG_SetIntStr_len+0 
	CALL        _SetIntStr+0, 0
;SSR.c,303 :: 		Spcpwm[ChannelNum].meas_cmd = IDEL_MEASUREMENT;
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
;SSR.c,304 :: 		Spcssr[ChannelNum].SSR_stat = 0;
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;SSR.c,305 :: 		}
L_RSSoperation51:
;SSR.c,307 :: 		return;
	GOTO        L_end_RSSoperation
;SSR.c,308 :: 		}
L_RSSoperation50:
;SSR.c,310 :: 		SSRForceOp[ChannelNum] = LOAD_OK;
	MOVLW       _SSRForceOp+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_SSRForceOp+0)
	MOVWF       FSR1H 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;SSR.c,312 :: 		if(Spcssr[ChannelNum].SSR_cmd == 1)   //SET_SSR_EN
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
	GOTO        L_RSSoperation55
;SSR.c,314 :: 		if(Spcssr[ChannelNum].SSR_stat == 0)   //SSR_DIS
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
	GOTO        L_RSSoperation56
;SSR.c,316 :: 		if((pSPCValue[ChannelNum].SPCSetPoints.SoftStartTime == SPC_SYSTEMVALUE_OFF) || (SoftStartDisable[ChannelNum]))
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
	MOVLW       30
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
	GOTO        L__RSSoperation129
	MOVLW       255
	XORWF       R1, 0 
L__RSSoperation129:
	BTFSC       STATUS+0, 2 
	GOTO        L__RSSoperation103
	MOVLW       _SoftStartDisable+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_SoftStartDisable+0)
	MOVWF       FSR0H 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__RSSoperation103
	GOTO        L_RSSoperation59
L__RSSoperation103:
;SSR.c,318 :: 		if(pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.ctl_type == 0)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
	BTFSC       R0, 3 
	GOTO        L_RSSoperation60
;SSR.c,320 :: 		relay_on(ChannelNum);
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	MOVWF       FARG_relay_on_ChannelNum+0 
	CALL        _relay_on+0, 0
;SSR.c,321 :: 		SystemUpdate |= (CH1_HEAT_STAT_UPDATE_REQ << ChannelNum);
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
L__RSSoperation130:
	BZ          L__RSSoperation131
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__RSSoperation130
L__RSSoperation131:
	MOVF        R0, 0 
	IORWF       _SystemUpdate+0, 1 
	MOVF        R1, 0 
	IORWF       _SystemUpdate+1, 1 
	MOVF        R2, 0 
	IORWF       _SystemUpdate+2, 1 
	MOVF        R3, 0 
	IORWF       _SystemUpdate+3, 1 
;SSR.c,322 :: 		SetHeatStatStr(HEAT_IS_ON, ChannelNum);
	MOVLW       1
	MOVWF       FARG_SetHeatStatStr_Strlocat+0 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	MOVWF       FARG_SetHeatStatStr_ChannelNum+0 
	CALL        _SetHeatStatStr+0, 0
;SSR.c,323 :: 		Spcpwm[ChannelNum].pwm_cmd = 0;
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;SSR.c,324 :: 		Spcpwm[ChannelNum].meas_cmd = IDEL_MEASUREMENT;
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
;SSR.c,327 :: 		duty_index[ChannelNum] = 10;
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
;SSR.c,328 :: 		dutyshadeNORMAL = duty_index[ChannelNum]*10;
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _dutyshadeNORMAL+0 
	MOVF        R1, 0 
	MOVWF       _dutyshadeNORMAL+1 
;SSR.c,329 :: 		if(pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent != SPC_SYSTEMVALUE_OFF)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
	GOTO        L__RSSoperation132
	MOVLW       255
	XORWF       R1, 0 
L__RSSoperation132:
	BTFSC       STATUS+0, 2 
	GOTO        L_RSSoperation61
;SSR.c,331 :: 		duty_index[ChannelNum] = pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent/10;
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _duty_index+0
	ADDWF       R0, 0 
	MOVWF       FLOC__RSSoperation+0 
	MOVLW       hi_addr(_duty_index+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__RSSoperation+1 
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
	MOVFF       FLOC__RSSoperation+0, FSR1
	MOVFF       FLOC__RSSoperation+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;SSR.c,332 :: 		dutyshadeNORMAL = pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
	MOVWF       _dutyshadeNORMAL+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       _dutyshadeNORMAL+1 
;SSR.c,333 :: 		pwm_duty[ChannelNum] = get_duty_table(duty_index[ChannelNum]);
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pwm_duty+0
	ADDWF       R0, 0 
	MOVWF       FLOC__RSSoperation+0 
	MOVLW       hi_addr(_pwm_duty+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__RSSoperation+1 
	MOVLW       _duty_index+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_duty_index+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_get_duty_table_index+0 
	CALL        _get_duty_table+0, 0
	MOVFF       FLOC__RSSoperation+0, FSR1
	MOVFF       FLOC__RSSoperation+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;SSR.c,334 :: 		Spcpwm[ChannelNum].pwm_cmd = 1;
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
;SSR.c,335 :: 		}
L_RSSoperation61:
;SSR.c,337 :: 		SystemUpdate |= (CH1_DUTY_UPDATE_REQ << ChannelNum);
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
L__RSSoperation133:
	BZ          L__RSSoperation134
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__RSSoperation133
L__RSSoperation134:
	MOVF        R0, 0 
	IORWF       _SystemUpdate+0, 1 
	MOVF        R1, 0 
	IORWF       _SystemUpdate+1, 1 
	MOVF        R2, 0 
	IORWF       _SystemUpdate+2, 1 
	MOVF        R3, 0 
	IORWF       _SystemUpdate+3, 1 
;SSR.c,338 :: 		SetIntStr((int*)&dutyshadeNORMAL, CH1_ACTURAL_DUTY+ChannelNum, UNIT_AMPER_PERCENT, 1);
	MOVLW       _dutyshadeNORMAL+0
	MOVWF       FARG_SetIntStr_ptr+0 
	MOVLW       hi_addr(_dutyshadeNORMAL+0)
	MOVWF       FARG_SetIntStr_ptr+1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	ADDLW       18
	MOVWF       FARG_SetIntStr_strlocat+0 
	MOVLW       9
	MOVWF       FARG_SetIntStr_unitlocar+0 
	MOVLW       1
	MOVWF       FARG_SetIntStr_len+0 
	CALL        _SetIntStr+0, 0
;SSR.c,339 :: 		}
	GOTO        L_RSSoperation62
L_RSSoperation60:
;SSR.c,341 :: 		Spcpwm[ChannelNum].pwm_cmd = 1;
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
L_RSSoperation62:
;SSR.c,343 :: 		Spcssr[ChannelNum].SSR_stat = 1;          // SSR_EN
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
;SSR.c,344 :: 		SoftStartDisable[ChannelNum] = 1;
	MOVLW       _SoftStartDisable+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_SoftStartDisable+0)
	MOVWF       FSR1H 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       1
	MOVWF       POSTINC1+0 
;SSR.c,345 :: 		}
	GOTO        L_RSSoperation63
L_RSSoperation59:
;SSR.c,348 :: 		if(softstart(ChannelNum))    //是否完成softstart
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	MOVWF       FARG_softstart_ChannelNum+0 
	CALL        _softstart+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_RSSoperation64
;SSR.c,350 :: 		if(pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.ctl_type == 0)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
	BTFSC       R0, 3 
	GOTO        L_RSSoperation65
;SSR.c,352 :: 		relay_on(ChannelNum);
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	MOVWF       FARG_relay_on_ChannelNum+0 
	CALL        _relay_on+0, 0
;SSR.c,353 :: 		SystemUpdate |= (CH1_HEAT_STAT_UPDATE_REQ << ChannelNum);
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
L__RSSoperation135:
	BZ          L__RSSoperation136
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__RSSoperation135
L__RSSoperation136:
	MOVF        R0, 0 
	IORWF       _SystemUpdate+0, 1 
	MOVF        R1, 0 
	IORWF       _SystemUpdate+1, 1 
	MOVF        R2, 0 
	IORWF       _SystemUpdate+2, 1 
	MOVF        R3, 0 
	IORWF       _SystemUpdate+3, 1 
;SSR.c,354 :: 		SetHeatStatStr(HEAT_IS_ON, ChannelNum);
	MOVLW       1
	MOVWF       FARG_SetHeatStatStr_Strlocat+0 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	MOVWF       FARG_SetHeatStatStr_ChannelNum+0 
	CALL        _SetHeatStatStr+0, 0
;SSR.c,355 :: 		Spcpwm[ChannelNum].pwm_cmd = 0;
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;SSR.c,356 :: 		Spcpwm[ChannelNum].meas_cmd = IDEL_MEASUREMENT;
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
;SSR.c,359 :: 		duty_index[ChannelNum] = 10;
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
;SSR.c,360 :: 		dutyshadeNORMAL = duty_index[ChannelNum]*10;
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _dutyshadeNORMAL+0 
	MOVF        R1, 0 
	MOVWF       _dutyshadeNORMAL+1 
;SSR.c,361 :: 		if(pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent != SPC_SYSTEMVALUE_OFF)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
	GOTO        L__RSSoperation137
	MOVLW       255
	XORWF       R1, 0 
L__RSSoperation137:
	BTFSC       STATUS+0, 2 
	GOTO        L_RSSoperation66
;SSR.c,363 :: 		duty_index[ChannelNum] = pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent/10;
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _duty_index+0
	ADDWF       R0, 0 
	MOVWF       FLOC__RSSoperation+0 
	MOVLW       hi_addr(_duty_index+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__RSSoperation+1 
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
	MOVFF       FLOC__RSSoperation+0, FSR1
	MOVFF       FLOC__RSSoperation+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;SSR.c,364 :: 		dutyshadeNORMAL = pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
	MOVWF       _dutyshadeNORMAL+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       _dutyshadeNORMAL+1 
;SSR.c,365 :: 		pwm_duty[ChannelNum] = get_duty_table(duty_index[ChannelNum]);
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pwm_duty+0
	ADDWF       R0, 0 
	MOVWF       FLOC__RSSoperation+0 
	MOVLW       hi_addr(_pwm_duty+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__RSSoperation+1 
	MOVLW       _duty_index+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_duty_index+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_get_duty_table_index+0 
	CALL        _get_duty_table+0, 0
	MOVFF       FLOC__RSSoperation+0, FSR1
	MOVFF       FLOC__RSSoperation+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;SSR.c,366 :: 		Spcpwm[ChannelNum].pwm_cmd = 1;
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
;SSR.c,367 :: 		}
L_RSSoperation66:
;SSR.c,369 :: 		SystemUpdate |= (CH1_DUTY_UPDATE_REQ << ChannelNum);
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
L__RSSoperation138:
	BZ          L__RSSoperation139
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__RSSoperation138
L__RSSoperation139:
	MOVF        R0, 0 
	IORWF       _SystemUpdate+0, 1 
	MOVF        R1, 0 
	IORWF       _SystemUpdate+1, 1 
	MOVF        R2, 0 
	IORWF       _SystemUpdate+2, 1 
	MOVF        R3, 0 
	IORWF       _SystemUpdate+3, 1 
;SSR.c,370 :: 		SetIntStr((int*)&dutyshadeNORMAL, CH1_ACTURAL_DUTY+ChannelNum, UNIT_AMPER_PERCENT, 1);
	MOVLW       _dutyshadeNORMAL+0
	MOVWF       FARG_SetIntStr_ptr+0 
	MOVLW       hi_addr(_dutyshadeNORMAL+0)
	MOVWF       FARG_SetIntStr_ptr+1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	ADDLW       18
	MOVWF       FARG_SetIntStr_strlocat+0 
	MOVLW       9
	MOVWF       FARG_SetIntStr_unitlocar+0 
	MOVLW       1
	MOVWF       FARG_SetIntStr_len+0 
	CALL        _SetIntStr+0, 0
;SSR.c,371 :: 		}
	GOTO        L_RSSoperation67
L_RSSoperation65:
;SSR.c,373 :: 		Spcpwm[ChannelNum].pwm_cmd = 1;
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
L_RSSoperation67:
;SSR.c,375 :: 		Spcssr[ChannelNum].SSR_stat = 1;          // SSR_EN
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
;SSR.c,376 :: 		SoftStartDisable[ChannelNum] = 1;
	MOVLW       _SoftStartDisable+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_SoftStartDisable+0)
	MOVWF       FSR1H 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       1
	MOVWF       POSTINC1+0 
;SSR.c,377 :: 		}
L_RSSoperation64:
;SSR.c,378 :: 		}
L_RSSoperation63:
;SSR.c,379 :: 		}
	GOTO        L_RSSoperation68
L_RSSoperation56:
;SSR.c,382 :: 		asm nop;
	NOP
;SSR.c,383 :: 		if((pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.ctl_type == 1) ||
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
;SSR.c,384 :: 		(pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent != SPC_SYSTEMVALUE_OFF))
	BTFSC       R0, 3 
	GOTO        L__RSSoperation102
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
	GOTO        L__RSSoperation140
	MOVLW       255
	XORWF       R1, 0 
L__RSSoperation140:
	BTFSS       STATUS+0, 2 
	GOTO        L__RSSoperation102
	GOTO        L_RSSoperation71
L__RSSoperation102:
;SSR.c,386 :: 		asm nop;
	NOP
;SSR.c,387 :: 		Spcpwm[ChannelNum].pwm_cmd = 1;
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
;SSR.c,388 :: 		}
	GOTO        L_RSSoperation72
L_RSSoperation71:
;SSR.c,391 :: 		asm nop;
	NOP
;SSR.c,392 :: 		Spcpwm[ChannelNum].pwm_cmd = 0;
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;SSR.c,393 :: 		}
L_RSSoperation72:
;SSR.c,394 :: 		}
L_RSSoperation68:
;SSR.c,395 :: 		}
	GOTO        L_RSSoperation73
L_RSSoperation55:
;SSR.c,396 :: 		else if(Spcssr[ChannelNum].SSR_cmd == 0)        //SET_SSR_DIS
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
	GOTO        L_RSSoperation74
;SSR.c,398 :: 		if(Spcssr[ChannelNum].SSR_stat == 1)           //SSR_EN
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
	GOTO        L_RSSoperation75
;SSR.c,400 :: 		relay_off(ChannelNum);
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	MOVWF       FARG_relay_off_ChannelNum+0 
	CALL        _relay_off+0, 0
;SSR.c,401 :: 		SystemUpdate |= (CH1_HEAT_STAT_UPDATE_REQ << ChannelNum);
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
L__RSSoperation141:
	BZ          L__RSSoperation142
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__RSSoperation141
L__RSSoperation142:
	MOVF        R0, 0 
	IORWF       _SystemUpdate+0, 1 
	MOVF        R1, 0 
	IORWF       _SystemUpdate+1, 1 
	MOVF        R2, 0 
	IORWF       _SystemUpdate+2, 1 
	MOVF        R3, 0 
	IORWF       _SystemUpdate+3, 1 
;SSR.c,402 :: 		Spcssr[ChannelNum].SSR_stat = 0;        //SSR_DIS
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;SSR.c,403 :: 		SetHeatStatStr(HEAT_IS_OFF, ChannelNum);
	CLRF        FARG_SetHeatStatStr_Strlocat+0 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	MOVWF       FARG_SetHeatStatStr_ChannelNum+0 
	CALL        _SetHeatStatStr+0, 0
;SSR.c,404 :: 		Spcpwm[ChannelNum].pwm_cmd = 0;
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;SSR.c,405 :: 		Spcpwm[ChannelNum].meas_cmd = IDEL_MEASUREMENT;
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
;SSR.c,407 :: 		SystemUpdate |= (CH1_DUTY_UPDATE_REQ << ChannelNum);
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
L__RSSoperation143:
	BZ          L__RSSoperation144
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__RSSoperation143
L__RSSoperation144:
	MOVF        R0, 0 
	IORWF       _SystemUpdate+0, 1 
	MOVF        R1, 0 
	IORWF       _SystemUpdate+1, 1 
	MOVF        R2, 0 
	IORWF       _SystemUpdate+2, 1 
	MOVF        R3, 0 
	IORWF       _SystemUpdate+3, 1 
;SSR.c,408 :: 		duty_index[ChannelNum] = 0;
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
;SSR.c,409 :: 		dutyshadeNORMAL = duty_index[ChannelNum];
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
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
	MOVWF       _dutyshadeNORMAL+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       _dutyshadeNORMAL+1 
;SSR.c,410 :: 		SetIntStr((int*)&dutyshadeNORMAL, CH1_ACTURAL_DUTY+ChannelNum, UNIT_AMPER_PERCENT, 1);
	MOVLW       _dutyshadeNORMAL+0
	MOVWF       FARG_SetIntStr_ptr+0 
	MOVLW       hi_addr(_dutyshadeNORMAL+0)
	MOVWF       FARG_SetIntStr_ptr+1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	ADDLW       18
	MOVWF       FARG_SetIntStr_strlocat+0 
	MOVLW       9
	MOVWF       FARG_SetIntStr_unitlocar+0 
	MOVLW       1
	MOVWF       FARG_SetIntStr_len+0 
	CALL        _SetIntStr+0, 0
;SSR.c,411 :: 		}
L_RSSoperation75:
;SSR.c,412 :: 		SpcSstart[ChannelNum].SOFTSTART_stat = 0;
	MOVLW       5
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _SpcSstart+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_SpcSstart+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;SSR.c,413 :: 		SpcSstart[ChannelNum].SOFTSTART_cmd = 0;
	MOVLW       5
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _SpcSstart+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_SpcSstart+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;SSR.c,414 :: 		Spcpwm[ChannelNum].pwm_cmd = 0;
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_RSSoperation_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;SSR.c,415 :: 		}
L_RSSoperation74:
L_RSSoperation73:
;SSR.c,416 :: 		}
L_end_RSSoperation:
	RETURN      0
; end of _RSSoperation

_AlarmSSRoperation:

;SSR.c,423 :: 		void AlarmSSRoperation()
;SSR.c,425 :: 		if(AlarmForce[0] == FORCE_ALARMSSR_ON)                  //(spc_system_flag.bite.alarmssr_forceop == FORCE_ALARMSSR_ON)
	MOVF        _AlarmForce+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_AlarmSSRoperation76
;SSR.c,427 :: 		Alarm_SSR_on(0);
	CLRF        FARG_Alarm_SSR_on_ChannelNum+0 
	CALL        _Alarm_SSR_on+0, 0
;SSR.c,428 :: 		}
L_AlarmSSRoperation76:
;SSR.c,430 :: 		if(AlarmForce[1] == FORCE_ALARMSSR_ON)                  //(spc_system_flag.bite.alarmssr_forceop == FORCE_ALARMSSR_ON)
	MOVF        _AlarmForce+1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_AlarmSSRoperation77
;SSR.c,432 :: 		Alarm_SSR_on(1);
	MOVLW       1
	MOVWF       FARG_Alarm_SSR_on_ChannelNum+0 
	CALL        _Alarm_SSR_on+0, 0
;SSR.c,433 :: 		}
L_AlarmSSRoperation77:
;SSR.c,434 :: 		}
L_end_AlarmSSRoperation:
	RETURN      0
; end of _AlarmSSRoperation

_pwm:

;SSR.c,441 :: 		char pwm(char ChannelNum)
;SSR.c,443 :: 		char WavesPerPerior=0;
	CLRF        pwm_WavesPerPerior_L0+0 
;SSR.c,445 :: 		if(Spcpwm[ChannelNum].pwm_cmd == 0)
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_pwm_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_pwm78
;SSR.c,446 :: 		return 0;
	CLRF        R0 
	GOTO        L_end_pwm
L_pwm78:
;SSR.c,448 :: 		if(ForceSSROFFCondition[ChannelNum] != 0)
	MOVLW       _ForceSSROFFCondition+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_ForceSSROFFCondition+0)
	MOVWF       FSR0H 
	MOVF        FARG_pwm_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_pwm79
;SSR.c,449 :: 		return 0;
	CLRF        R0 
	GOTO        L_end_pwm
L_pwm79:
;SSR.c,451 :: 		if(SpcSstart[ChannelNum].SOFTSTART_cmd)
	MOVLW       5
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_pwm_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _SpcSstart+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_SpcSstart+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_pwm80
;SSR.c,452 :: 		WavesPerPerior = 1;
	MOVLW       1
	MOVWF       pwm_WavesPerPerior_L0+0 
	GOTO        L_pwm81
L_pwm80:
;SSR.c,454 :: 		WavesPerPerior = PERIORS_IN_CYCAL;
	MOVLW       6
	MOVWF       pwm_WavesPerPerior_L0+0 
L_pwm81:
;SSR.c,456 :: 		if(Spcpwm[ChannelNum].pwm_count.element_count++ > WavesPerPerior*freq_pori)            //ELEMENT_TIMER
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_pwm_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 1 
	MOVLW       3
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__pwm+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__pwm+1 
	MOVLW       1
	ADDWF       FLOC__pwm+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      FLOC__pwm+1, 0 
	MOVWF       R1 
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        pwm_WavesPerPerior_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        _freq_pori+0, 0 
	MOVWF       R4 
	MOVF        _freq_pori+1, 0 
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        FLOC__pwm+1, 0 
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__pwm147
	MOVF        FLOC__pwm+0, 0 
	SUBWF       R0, 0 
L__pwm147:
	BTFSC       STATUS+0, 0 
	GOTO        L_pwm82
;SSR.c,458 :: 		if(shift(pwm_duty[ChannelNum], ChannelNum))
	MOVF        FARG_pwm_ChannelNum+0, 0 
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
	MOVWF       FARG_shift_dduty+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_shift_dduty+1 
	MOVF        FARG_pwm_ChannelNum+0, 0 
	MOVWF       FARG_shift_ChannelNum+0 
	CALL        _shift+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_pwm83
;SSR.c,470 :: 		}
L_pwm83:
;SSR.c,472 :: 		Spcpwm[ChannelNum].pwm_count.element_count = 0;
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_pwm_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 1 
	MOVLW       3
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;SSR.c,473 :: 		}
L_pwm82:
;SSR.c,474 :: 		}
L_end_pwm:
	RETURN      0
; end of _pwm

_shift:

;SSR.c,481 :: 		char shift(unsigned int dduty, char ChannelNum)
;SSR.c,483 :: 		if(ChannelNum == 0)
	MOVF        FARG_shift_ChannelNum+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_shift84
;SSR.c,484 :: 		asm nop;
	NOP
L_shift84:
;SSR.c,486 :: 		if(Spcpwm[ChannelNum].pwm_count.duty_count <= 10)
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_shift_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 1 
	MOVLW       3
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	SUBLW       10
	BTFSS       STATUS+0, 0 
	GOTO        L_shift85
;SSR.c,488 :: 		if((dduty << Spcpwm[ChannelNum].pwm_count.duty_count) & 0x8000)
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_shift_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 1 
	MOVLW       3
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R0 
	MOVF        FARG_shift_dduty+0, 0 
	MOVWF       R2 
	MOVF        FARG_shift_dduty+1, 0 
	MOVWF       R3 
	MOVF        R0, 0 
L__shift149:
	BZ          L__shift150
	RLCF        R2, 1 
	BCF         R2, 0 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__shift149
L__shift150:
	BTFSS       R3, 7 
	GOTO        L_shift86
;SSR.c,490 :: 		if(relay_on_ISR(ChannelNum))
	MOVF        FARG_shift_ChannelNum+0, 0 
	MOVWF       FARG_relay_on_ISR_ChannelNum+0 
	CALL        _relay_on_ISR+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_shift87
;SSR.c,492 :: 		asm nop;
	NOP
;SSR.c,493 :: 		Spcpwm[ChannelNum].meas_cmd = INITIAL_MEASUREMENT;
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_shift_ChannelNum+0, 0 
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
	MOVLW       1
	MOVWF       POSTINC1+0 
;SSR.c,494 :: 		Spcpwm[ChannelNum].pwm_count.meas_count = 0;
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_shift_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 1 
	MOVLW       3
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;SSR.c,495 :: 		}
L_shift87:
;SSR.c,496 :: 		}
	GOTO        L_shift88
L_shift86:
;SSR.c,499 :: 		if(relay_off_ISR(ChannelNum))
	MOVF        FARG_shift_ChannelNum+0, 0 
	MOVWF       FARG_relay_off_ISR_ChannelNum+0 
	CALL        _relay_off_ISR+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_shift89
;SSR.c,500 :: 		Spcpwm[ChannelNum].meas_cmd = DISABLE_MEASUREMENT;
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_shift_ChannelNum+0, 0 
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
	CLRF        POSTINC1+0 
L_shift89:
;SSR.c,501 :: 		}
L_shift88:
;SSR.c,503 :: 		Spcpwm[ChannelNum].pwm_count.duty_count++;
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_shift_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 1 
	MOVLW       3
	ADDWF       R0, 1 
	MOVLW       0
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
;SSR.c,504 :: 		if(Spcpwm[ChannelNum].pwm_count.duty_count == 10)
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_shift_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 1 
	MOVLW       3
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_shift90
;SSR.c,506 :: 		asm nop;
	NOP
;SSR.c,507 :: 		Spcpwm[ChannelNum].pwm_count.duty_count = 0;
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_shift_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 1 
	MOVLW       3
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;SSR.c,508 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_shift
;SSR.c,509 :: 		}
L_shift90:
;SSR.c,511 :: 		return 0;
	CLRF        R0 
	GOTO        L_end_shift
;SSR.c,512 :: 		}
L_shift85:
;SSR.c,513 :: 		}
L_end_shift:
	RETURN      0
; end of _shift

_countformeasurement:

;SSR.c,520 :: 		void countformeasurement(char ChannelNum)
;SSR.c,522 :: 		if(Spcpwm[ChannelNum].meas_cmd == IDEL_MEASUREMENT)
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_countformeasurement_ChannelNum+0, 0 
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
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_countformeasurement92
;SSR.c,524 :: 		if(Spcpwm[ChannelNum].pwm_count.meas_count++ > 100*freq_pori)   //没等待500ms
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_countformeasurement_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 1 
	MOVLW       3
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__countformeasurement+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__countformeasurement+1 
	MOVLW       1
	ADDWF       FLOC__countformeasurement+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      FLOC__countformeasurement+1, 0 
	MOVWF       R1 
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVLW       100
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        _freq_pori+0, 0 
	MOVWF       R4 
	MOVF        _freq_pori+1, 0 
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        FLOC__countformeasurement+1, 0 
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__countformeasurement152
	MOVF        FLOC__countformeasurement+0, 0 
	SUBWF       R0, 0 
L__countformeasurement152:
	BTFSC       STATUS+0, 0 
	GOTO        L_countformeasurement93
;SSR.c,526 :: 		asm nop;
	NOP
;SSR.c,527 :: 		Spcpwm[ChannelNum].pwm_count.meas_count = 0;
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_countformeasurement_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 1 
	MOVLW       3
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;SSR.c,528 :: 		Spcpwm[ChannelNum].meas_cmd = INITIAL_MEASUREMENT;      //等待初始化adc累加器并等待数据采集开始
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_countformeasurement_ChannelNum+0, 0 
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
	MOVLW       1
	MOVWF       POSTINC1+0 
;SSR.c,529 :: 		}
L_countformeasurement93:
;SSR.c,530 :: 		}
	GOTO        L_countformeasurement94
L_countformeasurement92:
;SSR.c,531 :: 		else if(Spcpwm[ChannelNum].meas_cmd == INITIAL_MEASUREMENT)    //如果要求数据采集
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_countformeasurement_ChannelNum+0, 0 
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
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_countformeasurement95
;SSR.c,533 :: 		if(Spcpwm[ChannelNum].pwm_count.meas_count++ > 3*freq_pori)   //等待信号稳定
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_countformeasurement_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 1 
	MOVLW       3
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__countformeasurement+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__countformeasurement+1 
	MOVLW       1
	ADDWF       FLOC__countformeasurement+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      FLOC__countformeasurement+1, 0 
	MOVWF       R1 
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        _freq_pori+0, 0 
	MOVWF       R4 
	MOVF        _freq_pori+1, 0 
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        FLOC__countformeasurement+1, 0 
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__countformeasurement153
	MOVF        FLOC__countformeasurement+0, 0 
	SUBWF       R0, 0 
L__countformeasurement153:
	BTFSC       STATUS+0, 0 
	GOTO        L_countformeasurement96
;SSR.c,535 :: 		asm nop;
	NOP
;SSR.c,536 :: 		Spcpwm[ChannelNum].pwm_count.meas_count = 0;
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_countformeasurement_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 1 
	MOVLW       3
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;SSR.c,537 :: 		Spcpwm[ChannelNum].meas_cmd = START_MEASUREMENT;      //等待初始化adc累加器并等待数据采集开始
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_countformeasurement_ChannelNum+0, 0 
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
	MOVLW       2
	MOVWF       POSTINC1+0 
;SSR.c,538 :: 		}
L_countformeasurement96:
;SSR.c,539 :: 		}
	GOTO        L_countformeasurement97
L_countformeasurement95:
;SSR.c,540 :: 		else if(Spcpwm[ChannelNum].meas_cmd == RUNING_MEASUREMENT)
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_countformeasurement_ChannelNum+0, 0 
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
	GOTO        L_countformeasurement98
;SSR.c,542 :: 		if(ADC_busy[ChannelNum] == GETING_GFI_CURRENT)
	MOVLW       _ADC_busy+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_ADC_busy+0)
	MOVWF       FSR0H 
	MOVF        FARG_countformeasurement_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_countformeasurement99
;SSR.c,544 :: 		if(Spcpwm[ChannelNum].pwm_count.meas_count++ > freq_pori)   //计数一个周期
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_countformeasurement_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 1 
	MOVLW       3
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       R4 
	MOVLW       0
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
	MOVF        R3, 0 
	SUBWF       _freq_pori+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__countformeasurement154
	MOVF        R2, 0 
	SUBWF       _freq_pori+0, 0 
L__countformeasurement154:
	BTFSC       STATUS+0, 0 
	GOTO        L_countformeasurement100
;SSR.c,546 :: 		asm nop;
	NOP
;SSR.c,547 :: 		Spcpwm[ChannelNum].pwm_count.meas_count = 0;
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_countformeasurement_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcpwm+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcpwm+0)
	ADDWFC      R1, 1 
	MOVLW       3
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;SSR.c,548 :: 		Spcpwm[ChannelNum].meas_cmd = FINISH_MEASUREMENT;
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_countformeasurement_ChannelNum+0, 0 
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
	MOVLW       4
	MOVWF       POSTINC1+0 
;SSR.c,549 :: 		SSRStatInMeas[ChannelNum] = Spcssr[ChannelNum].SSR_actual_stat;
	MOVLW       _SSRStatInMeas+0
	MOVWF       FLOC__countformeasurement+0 
	MOVLW       hi_addr(_SSRStatInMeas+0)
	MOVWF       FLOC__countformeasurement+1 
	MOVF        FARG_countformeasurement_ChannelNum+0, 0 
	ADDWF       FLOC__countformeasurement+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__countformeasurement+1, 1 
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_countformeasurement_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Spcssr+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Spcssr+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVFF       FLOC__countformeasurement+0, FSR1
	MOVFF       FLOC__countformeasurement+1, FSR1H
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;SSR.c,550 :: 		}
L_countformeasurement100:
;SSR.c,551 :: 		}
	GOTO        L_countformeasurement101
L_countformeasurement99:
;SSR.c,553 :: 		Spcpwm[ChannelNum].meas_cmd = IDEL_MEASUREMENT;
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_countformeasurement_ChannelNum+0, 0 
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
L_countformeasurement101:
;SSR.c,554 :: 		}
L_countformeasurement98:
L_countformeasurement97:
L_countformeasurement94:
;SSR.c,555 :: 		}
L_end_countformeasurement:
	RETURN      0
; end of _countformeasurement

_get_duty_table:

;SSR.c,561 :: 		unsigned int get_duty_table(char index)
;SSR.c,564 :: 		dtemp = duty_table[index];
	MOVF        FARG_get_duty_table_index+0, 0 
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
	MOVLW       _duty_table+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_duty_table+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(_duty_table+0)
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R5
	TBLRD*+
	MOVFF       TABLAT+0, R6
;SSR.c,565 :: 		return dtemp;
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
;SSR.c,566 :: 		}
L_end_get_duty_table:
	RETURN      0
; end of _get_duty_table
