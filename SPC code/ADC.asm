
_read_adc:

;ADC.c,15 :: 		unsigned int read_adc()
;ADC.c,18 :: 		unsigned int result=0;
	CLRF        read_adc_result_L0+0 
	CLRF        read_adc_result_L0+1 
;ADC.c,21 :: 		CHS1_bit = 0;
	BCF         CHS1_bit+0, BitPos(CHS1_bit+0) 
;ADC.c,22 :: 		CHS2_bit = 0;
	BCF         CHS2_bit+0, BitPos(CHS2_bit+0) 
;ADC.c,23 :: 		CHS3_bit = 0;
	BCF         CHS3_bit+0, BitPos(CHS3_bit+0) 
;ADC.c,24 :: 		CHS0_bit = 1;
	BSF         CHS0_bit+0, BitPos(CHS0_bit+0) 
;ADC.c,26 :: 		for(tt=0; tt<100; tt++);
	CLRF        R2 
L_read_adc0:
	MOVLW       100
	SUBWF       R2, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_read_adc1
	INCF        R2, 1 
	GOTO        L_read_adc0
L_read_adc1:
;ADC.c,27 :: 		GO_bit = 1;
	BSF         GO_bit+0, BitPos(GO_bit+0) 
;ADC.c,28 :: 		while(GO_bit);
L_read_adc3:
	BTFSS       GO_bit+0, BitPos(GO_bit+0) 
	GOTO        L_read_adc4
	GOTO        L_read_adc3
L_read_adc4:
;ADC.c,29 :: 		result = ADRESH;
	MOVF        ADRESH+0, 0 
	MOVWF       read_adc_result_L0+0 
	MOVLW       0
	MOVWF       read_adc_result_L0+1 
;ADC.c,30 :: 		result = (result<<8) + ADRESL;
	MOVF        read_adc_result_L0+0, 0 
	MOVWF       read_adc_result_L0+1 
	CLRF        read_adc_result_L0+0 
	MOVF        ADRESL+0, 0 
	ADDWF       read_adc_result_L0+0, 1 
	MOVLW       0
	ADDWFC      read_adc_result_L0+1, 1 
;ADC.c,32 :: 		asm nop;
	NOP
;ADC.c,33 :: 		asm nop;
	NOP
;ADC.c,34 :: 		asm nop;
	NOP
;ADC.c,35 :: 		return result;
	MOVF        read_adc_result_L0+0, 0 
	MOVWF       R0 
	MOVF        read_adc_result_L0+1, 0 
	MOVWF       R1 
;ADC.c,36 :: 		}
L_end_read_adc:
	RETURN      0
; end of _read_adc

_Getvoltage:

;ADC.c,43 :: 		void Getvoltage(void)
;ADC.c,46 :: 		volatile unsigned int volt = 0;
	CLRF        Getvoltage_volt_L0+0 
	CLRF        Getvoltage_volt_L0+1 
	CLRF        Getvoltage_Voltbuff_L0+0 
	CLRF        Getvoltage_Voltbuff_L0+1 
	CLRF        Getvoltage_Voltbuff_L0+2 
	CLRF        Getvoltage_Voltbuff_L0+3 
;ADC.c,49 :: 		for(i=0;i<40;i++)
	CLRF        Getvoltage_i_L0+0 
L_Getvoltage5:
	MOVLW       40
	SUBWF       Getvoltage_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Getvoltage6
;ADC.c,51 :: 		volt = read_adc();
	CALL        _read_adc+0, 0
	MOVF        R0, 0 
	MOVWF       Getvoltage_volt_L0+0 
	MOVF        R1, 0 
	MOVWF       Getvoltage_volt_L0+1 
;ADC.c,52 :: 		Voltbuff += volt;
	MOVF        Getvoltage_volt_L0+0, 0 
	ADDWF       Getvoltage_Voltbuff_L0+0, 1 
	MOVF        Getvoltage_volt_L0+1, 0 
	ADDWFC      Getvoltage_Voltbuff_L0+1, 1 
	MOVLW       0
	ADDWFC      Getvoltage_Voltbuff_L0+2, 1 
	ADDWFC      Getvoltage_Voltbuff_L0+3, 1 
;ADC.c,54 :: 		if(freqency == 60)
	MOVLW       0
	XORWF       _freqency+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Getvoltage33
	MOVLW       60
	XORWF       _freqency+0, 0 
L__Getvoltage33:
	BTFSS       STATUS+0, 2 
	GOTO        L_Getvoltage8
;ADC.c,55 :: 		Delay_us(190);       //60Hz
	MOVLW       2
	MOVWF       R12, 0
	MOVLW       58
	MOVWF       R13, 0
L_Getvoltage9:
	DECFSZ      R13, 1, 1
	BRA         L_Getvoltage9
	DECFSZ      R12, 1, 1
	BRA         L_Getvoltage9
	NOP
	GOTO        L_Getvoltage10
L_Getvoltage8:
;ADC.c,57 :: 		Delay_us(232);       //50Hz
	MOVLW       2
	MOVWF       R12, 0
	MOVLW       128
	MOVWF       R13, 0
L_Getvoltage11:
	DECFSZ      R13, 1, 1
	BRA         L_Getvoltage11
	DECFSZ      R12, 1, 1
	BRA         L_Getvoltage11
	NOP
L_Getvoltage10:
;ADC.c,49 :: 		for(i=0;i<40;i++)
	INCF        Getvoltage_i_L0+0, 1 
;ADC.c,58 :: 		}
	GOTO        L_Getvoltage5
L_Getvoltage6:
;ADC.c,60 :: 		volt = Voltbuff/40;
	MOVLW       40
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	MOVF        Getvoltage_Voltbuff_L0+0, 0 
	MOVWF       R0 
	MOVF        Getvoltage_Voltbuff_L0+1, 0 
	MOVWF       R1 
	MOVF        Getvoltage_Voltbuff_L0+2, 0 
	MOVWF       R2 
	MOVF        Getvoltage_Voltbuff_L0+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       Getvoltage_volt_L0+0 
	MOVF        R1, 0 
	MOVWF       Getvoltage_volt_L0+1 
;ADC.c,61 :: 		Voltbuff = 0;
	CLRF        Getvoltage_Voltbuff_L0+0 
	CLRF        Getvoltage_Voltbuff_L0+1 
	CLRF        Getvoltage_Voltbuff_L0+2 
	CLRF        Getvoltage_Voltbuff_L0+3 
;ADC.c,63 :: 		pSPCValue[0].SPCActual.Voltage = ConvertADtoVoltage(volt,freqency);
	MOVF        Getvoltage_volt_L0+0, 0 
	MOVWF       FARG_ConvertADtoVoltage_ADcurrent+0 
	MOVF        Getvoltage_volt_L0+1, 0 
	MOVWF       FARG_ConvertADtoVoltage_ADcurrent+1 
	MOVF        _freqency+0, 0 
	MOVWF       FARG_ConvertADtoVoltage_freq+0 
	CALL        _ConvertADtoVoltage+0, 0
	MOVF        R0, 0 
	MOVWF       _pSPCValue+20 
	MOVF        R1, 0 
	MOVWF       _pSPCValue+21 
;ADC.c,64 :: 		}
L_end_Getvoltage:
	RETURN      0
; end of _Getvoltage

_ConvertADtoVoltage:

;ADC.c,71 :: 		signed int ConvertADtoVoltage(unsigned int ADVolt, char freq)
;ADC.c,77 :: 		if(freq == 50)
	MOVF        FARG_ConvertADtoVoltage_freq+0, 0 
	XORLW       50
	BTFSS       STATUS+0, 2 
	GOTO        L_ConvertADtoVoltage12
;ADC.c,79 :: 		ADHigh = 576;
	MOVLW       64
	MOVWF       ConvertADtoVoltage_ADHigh_L0+0 
	MOVLW       2
	MOVWF       ConvertADtoVoltage_ADHigh_L0+1 
;ADC.c,80 :: 		VHigh  = 2407;
	MOVLW       103
	MOVWF       ConvertADtoVoltage_VHigh_L0+0 
	MOVLW       9
	MOVWF       ConvertADtoVoltage_VHigh_L0+1 
;ADC.c,81 :: 		ADLow  = 211;
	MOVLW       211
	MOVWF       ConvertADtoVoltage_ADLow_L0+0 
	MOVLW       0
	MOVWF       ConvertADtoVoltage_ADLow_L0+1 
;ADC.c,82 :: 		VLow   = 910;
	MOVLW       142
	MOVWF       ConvertADtoVoltage_VLow_L0+0 
	MOVLW       3
	MOVWF       ConvertADtoVoltage_VLow_L0+1 
;ADC.c,83 :: 		}
	GOTO        L_ConvertADtoVoltage13
L_ConvertADtoVoltage12:
;ADC.c,86 :: 		ADHigh = 589;
	MOVLW       77
	MOVWF       ConvertADtoVoltage_ADHigh_L0+0 
	MOVLW       2
	MOVWF       ConvertADtoVoltage_ADHigh_L0+1 
;ADC.c,87 :: 		VHigh  = 2403;
	MOVLW       99
	MOVWF       ConvertADtoVoltage_VHigh_L0+0 
	MOVLW       9
	MOVWF       ConvertADtoVoltage_VHigh_L0+1 
;ADC.c,88 :: 		ADLow  = 216;
	MOVLW       216
	MOVWF       ConvertADtoVoltage_ADLow_L0+0 
	MOVLW       0
	MOVWF       ConvertADtoVoltage_ADLow_L0+1 
;ADC.c,89 :: 		VLow   = 902;
	MOVLW       134
	MOVWF       ConvertADtoVoltage_VLow_L0+0 
	MOVLW       3
	MOVWF       ConvertADtoVoltage_VLow_L0+1 
;ADC.c,90 :: 		}
L_ConvertADtoVoltage13:
;ADC.c,92 :: 		ret =  (signed int)((signed long)((signed int)ADVolt - ADLow) * (VHigh - VLow)/(ADHigh - ADLow)) + VLow;
	MOVF        ConvertADtoVoltage_ADLow_L0+0, 0 
	SUBWF       FARG_ConvertADtoVoltage_ADVolt+0, 0 
	MOVWF       R0 
	MOVF        ConvertADtoVoltage_ADLow_L0+1, 0 
	SUBWFB      FARG_ConvertADtoVoltage_ADVolt+1, 0 
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
	MOVF        ConvertADtoVoltage_VLow_L0+0, 0 
	SUBWF       ConvertADtoVoltage_VHigh_L0+0, 0 
	MOVWF       R0 
	MOVF        ConvertADtoVoltage_VLow_L0+1, 0 
	SUBWFB      ConvertADtoVoltage_VHigh_L0+1, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	CALL        _Mul_32x32_U+0, 0
	MOVF        ConvertADtoVoltage_ADLow_L0+0, 0 
	SUBWF       ConvertADtoVoltage_ADHigh_L0+0, 0 
	MOVWF       R4 
	MOVF        ConvertADtoVoltage_ADLow_L0+1, 0 
	SUBWFB      ConvertADtoVoltage_ADHigh_L0+1, 0 
	MOVWF       R5 
	MOVLW       0
	BTFSC       R5, 7 
	MOVLW       255
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Div_32x32_S+0, 0
	MOVF        ConvertADtoVoltage_VLow_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       R4 
	MOVF        ConvertADtoVoltage_VLow_L0+1, 0 
	ADDWFC      R1, 0 
	MOVWF       R5 
	MOVF        R4, 0 
	MOVWF       ConvertADtoVoltage_ret_L0+0 
	MOVF        R5, 0 
	MOVWF       ConvertADtoVoltage_ret_L0+1 
;ADC.c,94 :: 		if(ret < 0)
	MOVLW       128
	XORWF       R5, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ConvertADtoVoltage35
	MOVLW       0
	SUBWF       R4, 0 
L__ConvertADtoVoltage35:
	BTFSC       STATUS+0, 0 
	GOTO        L_ConvertADtoVoltage14
;ADC.c,95 :: 		ret = 0;
	CLRF        ConvertADtoVoltage_ret_L0+0 
	CLRF        ConvertADtoVoltage_ret_L0+1 
L_ConvertADtoVoltage14:
;ADC.c,97 :: 		return ret/10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        ConvertADtoVoltage_ret_L0+0, 0 
	MOVWF       R0 
	MOVF        ConvertADtoVoltage_ret_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
;ADC.c,98 :: 		}
L_end_ConvertADtoVoltage:
	RETURN      0
; end of _ConvertADtoVoltage

_GetMinVoltpoint:

;ADC.c,106 :: 		unsigned int GetMinVoltpoint()
;ADC.c,108 :: 		char non_val=0;
	CLRF        GetMinVoltpoint_non_val_L0+0 
;ADC.c,113 :: 		old_freq_en = freq_en;
	MOVF        _freq_en+0, 0 
	MOVWF       GetMinVoltpoint_old_freq_en_L0+0 
;ADC.c,114 :: 		while(freq_en == old_freq_en)
L_GetMinVoltpoint15:
	MOVF        _freq_en+0, 0 
	XORWF       GetMinVoltpoint_old_freq_en_L0+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_GetMinVoltpoint16
;ADC.c,116 :: 		volt_ad = read_adc();
	CALL        _read_adc+0, 0
	MOVF        R0, 0 
	MOVWF       GetMinVoltpoint_volt_ad_L0+0 
	MOVF        R1, 0 
	MOVWF       GetMinVoltpoint_volt_ad_L0+1 
;ADC.c,118 :: 		if(non_val == 0)
	MOVF        GetMinVoltpoint_non_val_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetMinVoltpoint17
;ADC.c,120 :: 		volt_ad_min = volt_ad;
	MOVF        GetMinVoltpoint_volt_ad_L0+0, 0 
	MOVWF       GetMinVoltpoint_volt_ad_min_L0+0 
	MOVF        GetMinVoltpoint_volt_ad_L0+1, 0 
	MOVWF       GetMinVoltpoint_volt_ad_min_L0+1 
;ADC.c,121 :: 		freq_count_temp = spc_count.freq_count;
	MOVF        _spc_count+13, 0 
	MOVWF       GetMinVoltpoint_freq_count_temp_L0+0 
	MOVF        _spc_count+14, 0 
	MOVWF       GetMinVoltpoint_freq_count_temp_L0+1 
;ADC.c,122 :: 		non_val = 1;
	MOVLW       1
	MOVWF       GetMinVoltpoint_non_val_L0+0 
;ADC.c,123 :: 		}
	GOTO        L_GetMinVoltpoint18
L_GetMinVoltpoint17:
;ADC.c,126 :: 		if(volt_ad < volt_ad_min)
	MOVLW       128
	XORWF       GetMinVoltpoint_volt_ad_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       GetMinVoltpoint_volt_ad_min_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetMinVoltpoint37
	MOVF        GetMinVoltpoint_volt_ad_min_L0+0, 0 
	SUBWF       GetMinVoltpoint_volt_ad_L0+0, 0 
L__GetMinVoltpoint37:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetMinVoltpoint19
;ADC.c,128 :: 		volt_ad_min = volt_ad;
	MOVF        GetMinVoltpoint_volt_ad_L0+0, 0 
	MOVWF       GetMinVoltpoint_volt_ad_min_L0+0 
	MOVF        GetMinVoltpoint_volt_ad_L0+1, 0 
	MOVWF       GetMinVoltpoint_volt_ad_min_L0+1 
;ADC.c,129 :: 		freq_count_temp = spc_count.freq_count;
	MOVF        _spc_count+13, 0 
	MOVWF       GetMinVoltpoint_freq_count_temp_L0+0 
	MOVF        _spc_count+14, 0 
	MOVWF       GetMinVoltpoint_freq_count_temp_L0+1 
;ADC.c,130 :: 		}
L_GetMinVoltpoint19:
;ADC.c,131 :: 		}
L_GetMinVoltpoint18:
;ADC.c,132 :: 		}
	GOTO        L_GetMinVoltpoint15
L_GetMinVoltpoint16:
;ADC.c,134 :: 		return freq_count_temp;
	MOVF        GetMinVoltpoint_freq_count_temp_L0+0, 0 
	MOVWF       R0 
	MOVF        GetMinVoltpoint_freq_count_temp_L0+1, 0 
	MOVWF       R1 
;ADC.c,135 :: 		}
L_end_GetMinVoltpoint:
	RETURN      0
; end of _GetMinVoltpoint

_GetFreqency:

;ADC.c,142 :: 		void GetFreqency()
;ADC.c,144 :: 		volatile unsigned int freq_val, freq_num_min1=0,freq_num_min2=0;
	CLRF        GetFreqency_freq_num_min1_L0+0 
	CLRF        GetFreqency_freq_num_min1_L0+1 
	CLRF        GetFreqency_freq_num_min2_L0+0 
	CLRF        GetFreqency_freq_num_min2_L0+1 
;ADC.c,146 :: 		while(1)
L_GetFreqency20:
;ADC.c,148 :: 		freq_en = 1;
	MOVLW       1
	MOVWF       _freq_en+0 
;ADC.c,149 :: 		spc_count.freq_count = 0;
	CLRF        _spc_count+13 
	CLRF        _spc_count+14 
;ADC.c,151 :: 		freq_num_min1 = GetMinVoltpoint();
	CALL        _GetMinVoltpoint+0, 0
	MOVF        R0, 0 
	MOVWF       GetFreqency_freq_num_min1_L0+0 
	MOVF        R1, 0 
	MOVWF       GetFreqency_freq_num_min1_L0+1 
;ADC.c,152 :: 		freq_num_min2 = GetMinVoltpoint();
	CALL        _GetMinVoltpoint+0, 0
	MOVF        R0, 0 
	MOVWF       GetFreqency_freq_num_min2_L0+0 
	MOVF        R1, 0 
	MOVWF       GetFreqency_freq_num_min2_L0+1 
;ADC.c,154 :: 		freq_val = abs(freq_num_min1 - freq_num_min2);
	MOVF        GetFreqency_freq_num_min2_L0+0, 0 
	SUBWF       GetFreqency_freq_num_min1_L0+0, 0 
	MOVWF       FARG_abs_a+0 
	MOVF        GetFreqency_freq_num_min2_L0+1, 0 
	SUBWFB      GetFreqency_freq_num_min1_L0+1, 0 
	MOVWF       FARG_abs_a+1 
	CALL        _abs+0, 0
	MOVF        R0, 0 
	MOVWF       GetFreqency_freq_val_L0+0 
	MOVF        R1, 0 
	MOVWF       GetFreqency_freq_val_L0+1 
;ADC.c,155 :: 		if((freq_val > 35) && (freq_val < 45))
	MOVLW       0
	MOVWF       R0 
	MOVF        GetFreqency_freq_val_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetFreqency39
	MOVF        GetFreqency_freq_val_L0+0, 0 
	SUBLW       35
L__GetFreqency39:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetFreqency24
	MOVLW       0
	SUBWF       GetFreqency_freq_val_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetFreqency40
	MOVLW       45
	SUBWF       GetFreqency_freq_val_L0+0, 0 
L__GetFreqency40:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetFreqency24
L__GetFreqency30:
;ADC.c,157 :: 		freqency = 60;
	MOVLW       60
	MOVWF       _freqency+0 
	MOVLW       0
	MOVWF       _freqency+1 
;ADC.c,158 :: 		freq_pori = 83;
	MOVLW       83
	MOVWF       _freq_pori+0 
	MOVLW       0
	MOVWF       _freq_pori+1 
;ADC.c,159 :: 		return;
	GOTO        L_end_GetFreqency
;ADC.c,160 :: 		}
L_GetFreqency24:
;ADC.c,161 :: 		else if((freq_val > 45) && (freq_val < 55))
	MOVLW       0
	MOVWF       R0 
	MOVF        GetFreqency_freq_val_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetFreqency41
	MOVF        GetFreqency_freq_val_L0+0, 0 
	SUBLW       45
L__GetFreqency41:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetFreqency28
	MOVLW       0
	SUBWF       GetFreqency_freq_val_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetFreqency42
	MOVLW       55
	SUBWF       GetFreqency_freq_val_L0+0, 0 
L__GetFreqency42:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetFreqency28
L__GetFreqency29:
;ADC.c,163 :: 		freqency = 50;
	MOVLW       50
	MOVWF       _freqency+0 
	MOVLW       0
	MOVWF       _freqency+1 
;ADC.c,164 :: 		freq_pori = 100;
	MOVLW       100
	MOVWF       _freq_pori+0 
	MOVLW       0
	MOVWF       _freq_pori+1 
;ADC.c,165 :: 		return;
	GOTO        L_end_GetFreqency
;ADC.c,166 :: 		}
L_GetFreqency28:
;ADC.c,167 :: 		}
	GOTO        L_GetFreqency20
;ADC.c,168 :: 		}
L_end_GetFreqency:
	RETURN      0
; end of _GetFreqency
