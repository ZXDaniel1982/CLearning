
_TempSend:

;RTD.c,200 :: 		void TempSend(unsigned int ADSample, char line)
;RTD.c,202 :: 		char String=0, i;
;RTD.c,205 :: 		if(line == 1)
	MOVF        FARG_TempSend_line+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_TempSend0
;RTD.c,206 :: 		ptr = Info_Line2;
	MOVLW       _Info_Line2+0
	MOVWF       TempSend_ptr_L0+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       TempSend_ptr_L0+1 
	GOTO        L_TempSend1
L_TempSend0:
;RTD.c,208 :: 		ptr = Info_Line1;
	MOVLW       _Info_Line1+0
	MOVWF       TempSend_ptr_L0+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       TempSend_ptr_L0+1 
L_TempSend1:
;RTD.c,210 :: 		ClearStr(ptr, 16);
	MOVF        TempSend_ptr_L0+0, 0 
	MOVWF       FARG_ClearStr_target+0 
	MOVF        TempSend_ptr_L0+1, 0 
	MOVWF       FARG_ClearStr_target+1 
	MOVLW       16
	MOVWF       FARG_ClearStr_len+0 
	MOVLW       0
	MOVWF       FARG_ClearStr_len+1 
	CALL        _ClearStr+0, 0
;RTD.c,211 :: 		*ptr = ADSample/1000 + 0x30;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        FARG_TempSend_ADSample+0, 0 
	MOVWF       R0 
	MOVF        FARG_TempSend_ADSample+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       TempSend_ptr_L0+0, FSR1
	MOVFF       TempSend_ptr_L0+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;RTD.c,212 :: 		*(ptr+1) = ADSample%1000/100 + 0x30;
	MOVLW       1
	ADDWF       TempSend_ptr_L0+0, 0 
	MOVWF       FLOC__TempSend+0 
	MOVLW       0
	ADDWFC      TempSend_ptr_L0+1, 0 
	MOVWF       FLOC__TempSend+1 
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        FARG_TempSend_ADSample+0, 0 
	MOVWF       R0 
	MOVF        FARG_TempSend_ADSample+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__TempSend+0, FSR1
	MOVFF       FLOC__TempSend+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;RTD.c,213 :: 		*(ptr+2) = ADSample%100/10 + 0x30;
	MOVLW       2
	ADDWF       TempSend_ptr_L0+0, 0 
	MOVWF       FLOC__TempSend+0 
	MOVLW       0
	ADDWFC      TempSend_ptr_L0+1, 0 
	MOVWF       FLOC__TempSend+1 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FARG_TempSend_ADSample+0, 0 
	MOVWF       R0 
	MOVF        FARG_TempSend_ADSample+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__TempSend+0, FSR1
	MOVFF       FLOC__TempSend+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;RTD.c,214 :: 		*(ptr+3) = ADSample%10 + 0x30;
	MOVLW       3
	ADDWF       TempSend_ptr_L0+0, 0 
	MOVWF       FLOC__TempSend+0 
	MOVLW       0
	ADDWFC      TempSend_ptr_L0+1, 0 
	MOVWF       FLOC__TempSend+1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FARG_TempSend_ADSample+0, 0 
	MOVWF       R0 
	MOVF        FARG_TempSend_ADSample+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__TempSend+0, FSR1
	MOVFF       FLOC__TempSend+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;RTD.c,215 :: 		}
L_end_TempSend:
	RETURN      0
; end of _TempSend

_GetTemperature:

;RTD.c,217 :: 		void GetTemperature(TEMPERATURE *RTDA_ptr, char ChannelNum)
;RTD.c,228 :: 		ptr = RTDA_ptr;
	MOVF        FARG_GetTemperature_RTDA_ptr+0, 0 
	MOVWF       GetTemperature_ptr_L0+0 
	MOVF        FARG_GetTemperature_RTDA_ptr+1, 0 
	MOVWF       GetTemperature_ptr_L0+1 
;RTD.c,229 :: 		TempAD = MCP3202_GET_AD(ADC_Channel[ChannelNum+2],RTDA_AD_COMMND, 100);
	MOVLW       2
	ADDWF       FARG_GetTemperature_ChannelNum+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       RTD_ADC_Channel+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(RTD_ADC_Channel+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(RTD_ADC_Channel+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_MCP3202_GET_AD_Spi_Channel+0
	MOVLW       224
	MOVWF       FARG_MCP3202_GET_AD_Spi_AD_CMD+0 
	MOVLW       100
	MOVWF       FARG_MCP3202_GET_AD_NumOfSample+0 
	CALL        _MCP3202_GET_AD+0, 0
;RTD.c,230 :: 		ptr->Temperature_C = ConvertADtoTEMP(TempAD, CALI_RTDA_50, CALI_RTDA_500, ChannelNum);
	MOVLW       2
	ADDWF       GetTemperature_ptr_L0+0, 0 
	MOVWF       FLOC__GetTemperature+0 
	MOVLW       0
	ADDWFC      GetTemperature_ptr_L0+1, 0 
	MOVWF       FLOC__GetTemperature+1 
	MOVF        R0, 0 
	MOVWF       FARG_ConvertADtoTEMP_ADtemp+0 
	MOVF        R1, 0 
	MOVWF       FARG_ConvertADtoTEMP_ADtemp+1 
	CLRF        FARG_ConvertADtoTEMP_paraL+0 
	MOVLW       1
	MOVWF       FARG_ConvertADtoTEMP_paraH+0 
	MOVF        FARG_GetTemperature_ChannelNum+0, 0 
	MOVWF       FARG_ConvertADtoTEMP_ChannelNum+0 
	CALL        _ConvertADtoTEMP+0, 0
	MOVFF       FLOC__GetTemperature+0, FSR1
	MOVFF       FLOC__GetTemperature+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;RTD.c,231 :: 		if((ptr->Temperature_C == RTD_SHORT) || (ptr->Temperature_C == RTD_OPNE))
	MOVLW       2
	ADDWF       GetTemperature_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      GetTemperature_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__GetTemperature43
	MOVLW       255
	XORWF       R1, 0 
L__GetTemperature43:
	BTFSC       STATUS+0, 2 
	GOTO        L__GetTemperature40
	MOVLW       2
	ADDWF       GetTemperature_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      GetTemperature_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__GetTemperature44
	MOVLW       253
	XORWF       R1, 0 
L__GetTemperature44:
	BTFSC       STATUS+0, 2 
	GOTO        L__GetTemperature40
	GOTO        L_GetTemperature4
L__GetTemperature40:
;RTD.c,232 :: 		ptr->Temperature_F = ptr->Temperature_C;
	MOVLW       2
	ADDWF       GetTemperature_ptr_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      GetTemperature_ptr_L0+1, 0 
	MOVWF       R1 
	MOVFF       GetTemperature_ptr_L0+0, FSR1
	MOVFF       GetTemperature_ptr_L0+1, FSR1H
	MOVFF       R0, FSR0
	MOVFF       R1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	GOTO        L_GetTemperature5
L_GetTemperature4:
;RTD.c,234 :: 		ptr->Temperature_F = ConvertCtoF(ptr->Temperature_C);
	MOVF        GetTemperature_ptr_L0+0, 0 
	MOVWF       FLOC__GetTemperature+0 
	MOVF        GetTemperature_ptr_L0+1, 0 
	MOVWF       FLOC__GetTemperature+1 
	MOVLW       2
	ADDWF       GetTemperature_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      GetTemperature_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ConvertCtoF_sourse+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ConvertCtoF_sourse+1 
	CALL        _ConvertCtoF+0, 0
	MOVFF       FLOC__GetTemperature+0, FSR1
	MOVFF       FLOC__GetTemperature+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
L_GetTemperature5:
;RTD.c,236 :: 		ptr++;
	MOVLW       4
	ADDWF       GetTemperature_ptr_L0+0, 1 
	MOVLW       0
	ADDWFC      GetTemperature_ptr_L0+1, 1 
;RTD.c,237 :: 		TempAD = MCP3202_GET_AD(ADC_Channel[ChannelNum+2],RTDB_AD_COMMND, 100);
	MOVLW       2
	ADDWF       FARG_GetTemperature_ChannelNum+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       RTD_ADC_Channel+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(RTD_ADC_Channel+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(RTD_ADC_Channel+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_MCP3202_GET_AD_Spi_Channel+0
	MOVLW       160
	MOVWF       FARG_MCP3202_GET_AD_Spi_AD_CMD+0 
	MOVLW       100
	MOVWF       FARG_MCP3202_GET_AD_NumOfSample+0 
	CALL        _MCP3202_GET_AD+0, 0
;RTD.c,238 :: 		ptr->Temperature_C = ConvertADtoTEMP(TempAD, CALI_RTDB_50, CALI_RTDB_500, ChannelNum);
	MOVLW       2
	ADDWF       GetTemperature_ptr_L0+0, 0 
	MOVWF       FLOC__GetTemperature+0 
	MOVLW       0
	ADDWFC      GetTemperature_ptr_L0+1, 0 
	MOVWF       FLOC__GetTemperature+1 
	MOVF        R0, 0 
	MOVWF       FARG_ConvertADtoTEMP_ADtemp+0 
	MOVF        R1, 0 
	MOVWF       FARG_ConvertADtoTEMP_ADtemp+1 
	MOVLW       2
	MOVWF       FARG_ConvertADtoTEMP_paraL+0 
	MOVLW       3
	MOVWF       FARG_ConvertADtoTEMP_paraH+0 
	MOVF        FARG_GetTemperature_ChannelNum+0, 0 
	MOVWF       FARG_ConvertADtoTEMP_ChannelNum+0 
	CALL        _ConvertADtoTEMP+0, 0
	MOVFF       FLOC__GetTemperature+0, FSR1
	MOVFF       FLOC__GetTemperature+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;RTD.c,239 :: 		if((ptr->Temperature_C == RTD_SHORT) || (ptr->Temperature_C == RTD_OPNE))
	MOVLW       2
	ADDWF       GetTemperature_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      GetTemperature_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__GetTemperature45
	MOVLW       255
	XORWF       R1, 0 
L__GetTemperature45:
	BTFSC       STATUS+0, 2 
	GOTO        L__GetTemperature39
	MOVLW       2
	ADDWF       GetTemperature_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      GetTemperature_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__GetTemperature46
	MOVLW       253
	XORWF       R1, 0 
L__GetTemperature46:
	BTFSC       STATUS+0, 2 
	GOTO        L__GetTemperature39
	GOTO        L_GetTemperature8
L__GetTemperature39:
;RTD.c,240 :: 		ptr->Temperature_F = ptr->Temperature_C;
	MOVLW       2
	ADDWF       GetTemperature_ptr_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      GetTemperature_ptr_L0+1, 0 
	MOVWF       R1 
	MOVFF       GetTemperature_ptr_L0+0, FSR1
	MOVFF       GetTemperature_ptr_L0+1, FSR1H
	MOVFF       R0, FSR0
	MOVFF       R1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	GOTO        L_GetTemperature9
L_GetTemperature8:
;RTD.c,242 :: 		ptr->Temperature_F = ConvertCtoF(ptr->Temperature_C);
	MOVF        GetTemperature_ptr_L0+0, 0 
	MOVWF       FLOC__GetTemperature+0 
	MOVF        GetTemperature_ptr_L0+1, 0 
	MOVWF       FLOC__GetTemperature+1 
	MOVLW       2
	ADDWF       GetTemperature_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      GetTemperature_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ConvertCtoF_sourse+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ConvertCtoF_sourse+1 
	CALL        _ConvertCtoF+0, 0
	MOVFF       FLOC__GetTemperature+0, FSR1
	MOVFF       FLOC__GetTemperature+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
L_GetTemperature9:
;RTD.c,243 :: 		}
L_end_GetTemperature:
	RETURN      0
; end of _GetTemperature

_GetGFI:

;RTD.c,250 :: 		UINT GetGFI(char ChannelSelect, char cmd)
;RTD.c,252 :: 		return MCP3202_GET_AD_ONCE(ChannelSelect,cmd);
	MOVF        FARG_GetGFI_ChannelSelect+0, 0 
	MOVWF       FARG_MCP3202_GET_AD_ONCE_Spi_Channel+0 
	MOVF        FARG_GetGFI_cmd+0, 0 
	MOVWF       FARG_MCP3202_GET_AD_ONCE_Spi_AD_CMD+0 
	CALL        _MCP3202_GET_AD_ONCE+0, 0
;RTD.c,253 :: 		}
L_end_GetGFI:
	RETURN      0
; end of _GetGFI

_ConvertADtoCurrent:

;RTD.c,260 :: 		signed int ConvertADtoCurrent(unsigned int ADcurrent, char ChannelNum)
;RTD.c,263 :: 		char index=0;
	CLRF        ConvertADtoCurrent_index_L0+0 
;RTD.c,266 :: 		PtrForCalibrationData = (SPCCALIBRATIONREG *)&SPCCalibrationStructure[ChannelNum];
	MOVLW       60
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_ConvertADtoCurrent_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _SPCCalibrationStructure+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_SPCCalibrationStructure+0)
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       ConvertADtoCurrent_PtrForCalibrationData_L0+0 
	MOVF        R1, 0 
	MOVWF       ConvertADtoCurrent_PtrForCalibrationData_L0+1 
;RTD.c,267 :: 		if(ADcurrent < GetCalibrationData(PtrForCalibrationData, CURRENTPOINT1, 0))
	MOVF        R0, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+0 
	MOVF        R1, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+1 
	MOVLW       10
	MOVWF       FARG_GetCalibrationData_Location+0 
	CLRF        FARG_GetCalibrationData_ActualReq+0 
	CALL        _GetCalibrationData+0, 0
	MOVF        R1, 0 
	SUBWF       FARG_ConvertADtoCurrent_ADcurrent+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ConvertADtoCurrent49
	MOVF        R0, 0 
	SUBWF       FARG_ConvertADtoCurrent_ADcurrent+0, 0 
L__ConvertADtoCurrent49:
	BTFSC       STATUS+0, 0 
	GOTO        L_ConvertADtoCurrent10
;RTD.c,268 :: 		return 0;
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_ConvertADtoCurrent
L_ConvertADtoCurrent10:
;RTD.c,269 :: 		else if(ADcurrent < GetCalibrationData(PtrForCalibrationData, CURRENTPOINT2, 0))     // SPCCalibrationReg[CURRENTPOINT2].CalibartionSetpoint   CurrentCalibrationADTable[1]
	MOVF        ConvertADtoCurrent_PtrForCalibrationData_L0+0, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+0 
	MOVF        ConvertADtoCurrent_PtrForCalibrationData_L0+1, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+1 
	MOVLW       11
	MOVWF       FARG_GetCalibrationData_Location+0 
	CLRF        FARG_GetCalibrationData_ActualReq+0 
	CALL        _GetCalibrationData+0, 0
	MOVF        R1, 0 
	SUBWF       FARG_ConvertADtoCurrent_ADcurrent+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ConvertADtoCurrent50
	MOVF        R0, 0 
	SUBWF       FARG_ConvertADtoCurrent_ADcurrent+0, 0 
L__ConvertADtoCurrent50:
	BTFSC       STATUS+0, 0 
	GOTO        L_ConvertADtoCurrent12
;RTD.c,270 :: 		index = 0;
	CLRF        ConvertADtoCurrent_index_L0+0 
	GOTO        L_ConvertADtoCurrent13
L_ConvertADtoCurrent12:
;RTD.c,271 :: 		else if(ADcurrent < GetCalibrationData(PtrForCalibrationData, CURRENTPOINT3, 0))  // SPCCalibrationReg[CURRENTPOINT3].CalibartionSetpoint  CurrentCalibrationADTable[2]
	MOVF        ConvertADtoCurrent_PtrForCalibrationData_L0+0, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+0 
	MOVF        ConvertADtoCurrent_PtrForCalibrationData_L0+1, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+1 
	MOVLW       12
	MOVWF       FARG_GetCalibrationData_Location+0 
	CLRF        FARG_GetCalibrationData_ActualReq+0 
	CALL        _GetCalibrationData+0, 0
	MOVF        R1, 0 
	SUBWF       FARG_ConvertADtoCurrent_ADcurrent+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ConvertADtoCurrent51
	MOVF        R0, 0 
	SUBWF       FARG_ConvertADtoCurrent_ADcurrent+0, 0 
L__ConvertADtoCurrent51:
	BTFSC       STATUS+0, 0 
	GOTO        L_ConvertADtoCurrent14
;RTD.c,272 :: 		index = 1;
	MOVLW       1
	MOVWF       ConvertADtoCurrent_index_L0+0 
	GOTO        L_ConvertADtoCurrent15
L_ConvertADtoCurrent14:
;RTD.c,273 :: 		else if(ADcurrent < GetCalibrationData(PtrForCalibrationData, CURRENTPOINT4, 0))  // SPCCalibrationReg[CURRENTPOINT4].CalibartionSetpoint  CurrentCalibrationADTable[3]
	MOVF        ConvertADtoCurrent_PtrForCalibrationData_L0+0, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+0 
	MOVF        ConvertADtoCurrent_PtrForCalibrationData_L0+1, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+1 
	MOVLW       13
	MOVWF       FARG_GetCalibrationData_Location+0 
	CLRF        FARG_GetCalibrationData_ActualReq+0 
	CALL        _GetCalibrationData+0, 0
	MOVF        R1, 0 
	SUBWF       FARG_ConvertADtoCurrent_ADcurrent+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ConvertADtoCurrent52
	MOVF        R0, 0 
	SUBWF       FARG_ConvertADtoCurrent_ADcurrent+0, 0 
L__ConvertADtoCurrent52:
	BTFSC       STATUS+0, 0 
	GOTO        L_ConvertADtoCurrent16
;RTD.c,274 :: 		index = 2;
	MOVLW       2
	MOVWF       ConvertADtoCurrent_index_L0+0 
	GOTO        L_ConvertADtoCurrent17
L_ConvertADtoCurrent16:
;RTD.c,276 :: 		index = 3;
	MOVLW       3
	MOVWF       ConvertADtoCurrent_index_L0+0 
L_ConvertADtoCurrent17:
L_ConvertADtoCurrent15:
L_ConvertADtoCurrent13:
;RTD.c,278 :: 		index += CURRENTPOINT1;
	MOVLW       10
	ADDWF       ConvertADtoCurrent_index_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       ConvertADtoCurrent_index_L0+0 
;RTD.c,279 :: 		temp = GetCalibrationData(PtrForCalibrationData, index+1, 1) - GetCalibrationData(PtrForCalibrationData, index, 1);
	MOVF        ConvertADtoCurrent_PtrForCalibrationData_L0+0, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+0 
	MOVF        ConvertADtoCurrent_PtrForCalibrationData_L0+1, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+1 
	MOVF        R0, 0 
	ADDLW       1
	MOVWF       FARG_GetCalibrationData_Location+0 
	MOVLW       1
	MOVWF       FARG_GetCalibrationData_ActualReq+0 
	CALL        _GetCalibrationData+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__ConvertADtoCurrent+0 
	MOVF        R1, 0 
	MOVWF       FLOC__ConvertADtoCurrent+1 
	MOVF        ConvertADtoCurrent_PtrForCalibrationData_L0+0, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+0 
	MOVF        ConvertADtoCurrent_PtrForCalibrationData_L0+1, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+1 
	MOVF        ConvertADtoCurrent_index_L0+0, 0 
	MOVWF       FARG_GetCalibrationData_Location+0 
	MOVLW       1
	MOVWF       FARG_GetCalibrationData_ActualReq+0 
	CALL        _GetCalibrationData+0, 0
	MOVF        R0, 0 
	SUBWF       FLOC__ConvertADtoCurrent+0, 0 
	MOVWF       ConvertADtoCurrent_temp_L0+0 
	MOVF        R1, 0 
	SUBWFB      FLOC__ConvertADtoCurrent+1, 0 
	MOVWF       ConvertADtoCurrent_temp_L0+1 
	MOVLW       0
	BTFSC       ConvertADtoCurrent_temp_L0+1, 7 
	MOVLW       255
	MOVWF       ConvertADtoCurrent_temp_L0+2 
	MOVWF       ConvertADtoCurrent_temp_L0+3 
;RTD.c,280 :: 		tempL = GetCalibrationData(PtrForCalibrationData, index+1, 0) - GetCalibrationData(PtrForCalibrationData, index, 0);
	MOVF        ConvertADtoCurrent_PtrForCalibrationData_L0+0, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+0 
	MOVF        ConvertADtoCurrent_PtrForCalibrationData_L0+1, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+1 
	MOVF        ConvertADtoCurrent_index_L0+0, 0 
	ADDLW       1
	MOVWF       FARG_GetCalibrationData_Location+0 
	CLRF        FARG_GetCalibrationData_ActualReq+0 
	CALL        _GetCalibrationData+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__ConvertADtoCurrent+0 
	MOVF        R1, 0 
	MOVWF       FLOC__ConvertADtoCurrent+1 
	MOVF        ConvertADtoCurrent_PtrForCalibrationData_L0+0, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+0 
	MOVF        ConvertADtoCurrent_PtrForCalibrationData_L0+1, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+1 
	MOVF        ConvertADtoCurrent_index_L0+0, 0 
	MOVWF       FARG_GetCalibrationData_Location+0 
	CLRF        FARG_GetCalibrationData_ActualReq+0 
	CALL        _GetCalibrationData+0, 0
	MOVF        R0, 0 
	SUBWF       FLOC__ConvertADtoCurrent+0, 0 
	MOVWF       ConvertADtoCurrent_tempL_L0+0 
	MOVF        R1, 0 
	SUBWFB      FLOC__ConvertADtoCurrent+1, 0 
	MOVWF       ConvertADtoCurrent_tempL_L0+1 
	MOVLW       0
	BTFSC       ConvertADtoCurrent_tempL_L0+1, 7 
	MOVLW       255
	MOVWF       ConvertADtoCurrent_tempL_L0+2 
	MOVWF       ConvertADtoCurrent_tempL_L0+3 
;RTD.c,281 :: 		temp = temp* (ADcurrent - GetCalibrationData(PtrForCalibrationData, index, 0))/ tempL;
	MOVF        ConvertADtoCurrent_PtrForCalibrationData_L0+0, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+0 
	MOVF        ConvertADtoCurrent_PtrForCalibrationData_L0+1, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+1 
	MOVF        ConvertADtoCurrent_index_L0+0, 0 
	MOVWF       FARG_GetCalibrationData_Location+0 
	CLRF        FARG_GetCalibrationData_ActualReq+0 
	CALL        _GetCalibrationData+0, 0
	MOVF        R0, 0 
	SUBWF       FARG_ConvertADtoCurrent_ADcurrent+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
	SUBWFB      FARG_ConvertADtoCurrent_ADcurrent+1, 0 
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVWF       R3 
	MOVF        ConvertADtoCurrent_temp_L0+0, 0 
	MOVWF       R4 
	MOVF        ConvertADtoCurrent_temp_L0+1, 0 
	MOVWF       R5 
	MOVF        ConvertADtoCurrent_temp_L0+2, 0 
	MOVWF       R6 
	MOVF        ConvertADtoCurrent_temp_L0+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVF        ConvertADtoCurrent_tempL_L0+0, 0 
	MOVWF       R4 
	MOVF        ConvertADtoCurrent_tempL_L0+1, 0 
	MOVWF       R5 
	MOVF        ConvertADtoCurrent_tempL_L0+2, 0 
	MOVWF       R6 
	MOVF        ConvertADtoCurrent_tempL_L0+3, 0 
	MOVWF       R7 
	CALL        _Div_32x32_S+0, 0
	MOVF        R0, 0 
	MOVWF       ConvertADtoCurrent_temp_L0+0 
	MOVF        R1, 0 
	MOVWF       ConvertADtoCurrent_temp_L0+1 
	MOVF        R2, 0 
	MOVWF       ConvertADtoCurrent_temp_L0+2 
	MOVF        R3, 0 
	MOVWF       ConvertADtoCurrent_temp_L0+3 
;RTD.c,282 :: 		ret = temp + GetCalibrationData(PtrForCalibrationData, index, 1);
	MOVF        ConvertADtoCurrent_PtrForCalibrationData_L0+0, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+0 
	MOVF        ConvertADtoCurrent_PtrForCalibrationData_L0+1, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+1 
	MOVF        ConvertADtoCurrent_index_L0+0, 0 
	MOVWF       FARG_GetCalibrationData_Location+0 
	MOVLW       1
	MOVWF       FARG_GetCalibrationData_ActualReq+0 
	CALL        _GetCalibrationData+0, 0
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	MOVF        ConvertADtoCurrent_temp_L0+0, 0 
	ADDWF       R0, 1 
	MOVF        ConvertADtoCurrent_temp_L0+1, 0 
	ADDWFC      R1, 1 
	MOVF        ConvertADtoCurrent_temp_L0+2, 0 
	ADDWFC      R2, 1 
	MOVF        ConvertADtoCurrent_temp_L0+3, 0 
	ADDWFC      R3, 1 
;RTD.c,284 :: 		return ret/10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Div_32x32_S+0, 0
;RTD.c,285 :: 		}
L_end_ConvertADtoCurrent:
	RETURN      0
; end of _ConvertADtoCurrent

_ConvertADtoGFI:

;RTD.c,292 :: 		unsigned int ConvertADtoGFI(unsigned int ADcurrent, char ChannelNum)
;RTD.c,295 :: 		char index=0;
	CLRF        ConvertADtoGFI_index_L0+0 
;RTD.c,298 :: 		PtrForCalibrationData = (SPCCALIBRATIONREG *)&SPCCalibrationStructure[ChannelNum];
	MOVLW       60
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_ConvertADtoGFI_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _SPCCalibrationStructure+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_SPCCalibrationStructure+0)
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       ConvertADtoGFI_PtrForCalibrationData_L0+0 
	MOVF        R1, 0 
	MOVWF       ConvertADtoGFI_PtrForCalibrationData_L0+1 
;RTD.c,299 :: 		if(ADcurrent < GetCalibrationData(PtrForCalibrationData, GFIPOINT1, 0))
	MOVF        R0, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+0 
	MOVF        R1, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+1 
	MOVLW       4
	MOVWF       FARG_GetCalibrationData_Location+0 
	CLRF        FARG_GetCalibrationData_ActualReq+0 
	CALL        _GetCalibrationData+0, 0
	MOVF        R1, 0 
	SUBWF       FARG_ConvertADtoGFI_ADcurrent+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ConvertADtoGFI54
	MOVF        R0, 0 
	SUBWF       FARG_ConvertADtoGFI_ADcurrent+0, 0 
L__ConvertADtoGFI54:
	BTFSC       STATUS+0, 0 
	GOTO        L_ConvertADtoGFI18
;RTD.c,300 :: 		return 0;
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_ConvertADtoGFI
L_ConvertADtoGFI18:
;RTD.c,301 :: 		else if(ADcurrent < GetCalibrationData(PtrForCalibrationData, GFIPOINT2, 0))     // SPCCalibrationReg[CURRENTPOINT2].CalibartionSetpoint   CurrentCalibrationADTable[1]
	MOVF        ConvertADtoGFI_PtrForCalibrationData_L0+0, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+0 
	MOVF        ConvertADtoGFI_PtrForCalibrationData_L0+1, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+1 
	MOVLW       5
	MOVWF       FARG_GetCalibrationData_Location+0 
	CLRF        FARG_GetCalibrationData_ActualReq+0 
	CALL        _GetCalibrationData+0, 0
	MOVF        R1, 0 
	SUBWF       FARG_ConvertADtoGFI_ADcurrent+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ConvertADtoGFI55
	MOVF        R0, 0 
	SUBWF       FARG_ConvertADtoGFI_ADcurrent+0, 0 
L__ConvertADtoGFI55:
	BTFSC       STATUS+0, 0 
	GOTO        L_ConvertADtoGFI20
;RTD.c,302 :: 		index = 0;
	CLRF        ConvertADtoGFI_index_L0+0 
	GOTO        L_ConvertADtoGFI21
L_ConvertADtoGFI20:
;RTD.c,303 :: 		else if(ADcurrent < GetCalibrationData(PtrForCalibrationData, GFIPOINT3, 0))  // SPCCalibrationReg[CURRENTPOINT3].CalibartionSetpoint  CurrentCalibrationADTable[2]
	MOVF        ConvertADtoGFI_PtrForCalibrationData_L0+0, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+0 
	MOVF        ConvertADtoGFI_PtrForCalibrationData_L0+1, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+1 
	MOVLW       6
	MOVWF       FARG_GetCalibrationData_Location+0 
	CLRF        FARG_GetCalibrationData_ActualReq+0 
	CALL        _GetCalibrationData+0, 0
	MOVF        R1, 0 
	SUBWF       FARG_ConvertADtoGFI_ADcurrent+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ConvertADtoGFI56
	MOVF        R0, 0 
	SUBWF       FARG_ConvertADtoGFI_ADcurrent+0, 0 
L__ConvertADtoGFI56:
	BTFSC       STATUS+0, 0 
	GOTO        L_ConvertADtoGFI22
;RTD.c,304 :: 		index = 1;
	MOVLW       1
	MOVWF       ConvertADtoGFI_index_L0+0 
	GOTO        L_ConvertADtoGFI23
L_ConvertADtoGFI22:
;RTD.c,305 :: 		else if(ADcurrent < GetCalibrationData(PtrForCalibrationData, GFIPOINT4, 0))  // SPCCalibrationReg[CURRENTPOINT4].CalibartionSetpoint  CurrentCalibrationADTable[3]
	MOVF        ConvertADtoGFI_PtrForCalibrationData_L0+0, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+0 
	MOVF        ConvertADtoGFI_PtrForCalibrationData_L0+1, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+1 
	MOVLW       7
	MOVWF       FARG_GetCalibrationData_Location+0 
	CLRF        FARG_GetCalibrationData_ActualReq+0 
	CALL        _GetCalibrationData+0, 0
	MOVF        R1, 0 
	SUBWF       FARG_ConvertADtoGFI_ADcurrent+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ConvertADtoGFI57
	MOVF        R0, 0 
	SUBWF       FARG_ConvertADtoGFI_ADcurrent+0, 0 
L__ConvertADtoGFI57:
	BTFSC       STATUS+0, 0 
	GOTO        L_ConvertADtoGFI24
;RTD.c,306 :: 		index = 2;
	MOVLW       2
	MOVWF       ConvertADtoGFI_index_L0+0 
	GOTO        L_ConvertADtoGFI25
L_ConvertADtoGFI24:
;RTD.c,307 :: 		else if(ADcurrent < GetCalibrationData(PtrForCalibrationData, GFIPOINT5, 0))  // SPCCalibrationReg[CURRENTPOINT5].CalibartionSetpoint   CurrentCalibrationADTable[4]
	MOVF        ConvertADtoGFI_PtrForCalibrationData_L0+0, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+0 
	MOVF        ConvertADtoGFI_PtrForCalibrationData_L0+1, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+1 
	MOVLW       8
	MOVWF       FARG_GetCalibrationData_Location+0 
	CLRF        FARG_GetCalibrationData_ActualReq+0 
	CALL        _GetCalibrationData+0, 0
	MOVF        R1, 0 
	SUBWF       FARG_ConvertADtoGFI_ADcurrent+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ConvertADtoGFI58
	MOVF        R0, 0 
	SUBWF       FARG_ConvertADtoGFI_ADcurrent+0, 0 
L__ConvertADtoGFI58:
	BTFSC       STATUS+0, 0 
	GOTO        L_ConvertADtoGFI26
;RTD.c,308 :: 		index = 3;
	MOVLW       3
	MOVWF       ConvertADtoGFI_index_L0+0 
	GOTO        L_ConvertADtoGFI27
L_ConvertADtoGFI26:
;RTD.c,310 :: 		index = 4;
	MOVLW       4
	MOVWF       ConvertADtoGFI_index_L0+0 
L_ConvertADtoGFI27:
L_ConvertADtoGFI25:
L_ConvertADtoGFI23:
L_ConvertADtoGFI21:
;RTD.c,312 :: 		index += GFIPOINT1;
	MOVLW       4
	ADDWF       ConvertADtoGFI_index_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       ConvertADtoGFI_index_L0+0 
;RTD.c,313 :: 		temp = GetCalibrationData(PtrForCalibrationData, index+1, 1) - GetCalibrationData(PtrForCalibrationData, index, 1);
	MOVF        ConvertADtoGFI_PtrForCalibrationData_L0+0, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+0 
	MOVF        ConvertADtoGFI_PtrForCalibrationData_L0+1, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+1 
	MOVF        R0, 0 
	ADDLW       1
	MOVWF       FARG_GetCalibrationData_Location+0 
	MOVLW       1
	MOVWF       FARG_GetCalibrationData_ActualReq+0 
	CALL        _GetCalibrationData+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__ConvertADtoGFI+0 
	MOVF        R1, 0 
	MOVWF       FLOC__ConvertADtoGFI+1 
	MOVF        ConvertADtoGFI_PtrForCalibrationData_L0+0, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+0 
	MOVF        ConvertADtoGFI_PtrForCalibrationData_L0+1, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+1 
	MOVF        ConvertADtoGFI_index_L0+0, 0 
	MOVWF       FARG_GetCalibrationData_Location+0 
	MOVLW       1
	MOVWF       FARG_GetCalibrationData_ActualReq+0 
	CALL        _GetCalibrationData+0, 0
	MOVF        R0, 0 
	SUBWF       FLOC__ConvertADtoGFI+0, 0 
	MOVWF       ConvertADtoGFI_temp_L0+0 
	MOVF        R1, 0 
	SUBWFB      FLOC__ConvertADtoGFI+1, 0 
	MOVWF       ConvertADtoGFI_temp_L0+1 
	MOVLW       0
	BTFSC       ConvertADtoGFI_temp_L0+1, 7 
	MOVLW       255
	MOVWF       ConvertADtoGFI_temp_L0+2 
	MOVWF       ConvertADtoGFI_temp_L0+3 
;RTD.c,314 :: 		tempL = GetCalibrationData(PtrForCalibrationData, index+1, 0) - GetCalibrationData(PtrForCalibrationData, index, 0);
	MOVF        ConvertADtoGFI_PtrForCalibrationData_L0+0, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+0 
	MOVF        ConvertADtoGFI_PtrForCalibrationData_L0+1, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+1 
	MOVF        ConvertADtoGFI_index_L0+0, 0 
	ADDLW       1
	MOVWF       FARG_GetCalibrationData_Location+0 
	CLRF        FARG_GetCalibrationData_ActualReq+0 
	CALL        _GetCalibrationData+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__ConvertADtoGFI+0 
	MOVF        R1, 0 
	MOVWF       FLOC__ConvertADtoGFI+1 
	MOVF        ConvertADtoGFI_PtrForCalibrationData_L0+0, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+0 
	MOVF        ConvertADtoGFI_PtrForCalibrationData_L0+1, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+1 
	MOVF        ConvertADtoGFI_index_L0+0, 0 
	MOVWF       FARG_GetCalibrationData_Location+0 
	CLRF        FARG_GetCalibrationData_ActualReq+0 
	CALL        _GetCalibrationData+0, 0
	MOVF        R0, 0 
	SUBWF       FLOC__ConvertADtoGFI+0, 0 
	MOVWF       ConvertADtoGFI_tempL_L0+0 
	MOVF        R1, 0 
	SUBWFB      FLOC__ConvertADtoGFI+1, 0 
	MOVWF       ConvertADtoGFI_tempL_L0+1 
	MOVLW       0
	BTFSC       ConvertADtoGFI_tempL_L0+1, 7 
	MOVLW       255
	MOVWF       ConvertADtoGFI_tempL_L0+2 
	MOVWF       ConvertADtoGFI_tempL_L0+3 
;RTD.c,315 :: 		temp = temp* (ADcurrent - GetCalibrationData(PtrForCalibrationData, index, 0))/ tempL;
	MOVF        ConvertADtoGFI_PtrForCalibrationData_L0+0, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+0 
	MOVF        ConvertADtoGFI_PtrForCalibrationData_L0+1, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+1 
	MOVF        ConvertADtoGFI_index_L0+0, 0 
	MOVWF       FARG_GetCalibrationData_Location+0 
	CLRF        FARG_GetCalibrationData_ActualReq+0 
	CALL        _GetCalibrationData+0, 0
	MOVF        R0, 0 
	SUBWF       FARG_ConvertADtoGFI_ADcurrent+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
	SUBWFB      FARG_ConvertADtoGFI_ADcurrent+1, 0 
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVWF       R3 
	MOVF        ConvertADtoGFI_temp_L0+0, 0 
	MOVWF       R4 
	MOVF        ConvertADtoGFI_temp_L0+1, 0 
	MOVWF       R5 
	MOVF        ConvertADtoGFI_temp_L0+2, 0 
	MOVWF       R6 
	MOVF        ConvertADtoGFI_temp_L0+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVF        ConvertADtoGFI_tempL_L0+0, 0 
	MOVWF       R4 
	MOVF        ConvertADtoGFI_tempL_L0+1, 0 
	MOVWF       R5 
	MOVF        ConvertADtoGFI_tempL_L0+2, 0 
	MOVWF       R6 
	MOVF        ConvertADtoGFI_tempL_L0+3, 0 
	MOVWF       R7 
	CALL        _Div_32x32_S+0, 0
	MOVF        R0, 0 
	MOVWF       ConvertADtoGFI_temp_L0+0 
	MOVF        R1, 0 
	MOVWF       ConvertADtoGFI_temp_L0+1 
	MOVF        R2, 0 
	MOVWF       ConvertADtoGFI_temp_L0+2 
	MOVF        R3, 0 
	MOVWF       ConvertADtoGFI_temp_L0+3 
;RTD.c,316 :: 		ret = temp + GetCalibrationData(PtrForCalibrationData, index, 1);
	MOVF        ConvertADtoGFI_PtrForCalibrationData_L0+0, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+0 
	MOVF        ConvertADtoGFI_PtrForCalibrationData_L0+1, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+1 
	MOVF        ConvertADtoGFI_index_L0+0, 0 
	MOVWF       FARG_GetCalibrationData_Location+0 
	MOVLW       1
	MOVWF       FARG_GetCalibrationData_ActualReq+0 
	CALL        _GetCalibrationData+0, 0
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	MOVF        ConvertADtoGFI_temp_L0+0, 0 
	ADDWF       R0, 1 
	MOVF        ConvertADtoGFI_temp_L0+1, 0 
	ADDWFC      R1, 1 
	MOVF        ConvertADtoGFI_temp_L0+2, 0 
	ADDWFC      R2, 1 
	MOVF        ConvertADtoGFI_temp_L0+3, 0 
	ADDWFC      R3, 1 
;RTD.c,318 :: 		return ret/10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Div_32x32_S+0, 0
;RTD.c,319 :: 		}
L_end_ConvertADtoGFI:
	RETURN      0
; end of _ConvertADtoGFI

_ConvertADtoTEMP:

;RTD.c,326 :: 		long ConvertADtoTEMP(UINT ADtemp, char paraL, char paraH, char ChannelNum)
;RTD.c,330 :: 		long tempresult,tempcount=0, temp;
	CLRF        ConvertADtoTEMP_tempcount_L0+0 
	CLRF        ConvertADtoTEMP_tempcount_L0+1 
	CLRF        ConvertADtoTEMP_tempcount_L0+2 
	CLRF        ConvertADtoTEMP_tempcount_L0+3 
;RTD.c,333 :: 		PtrForCalibrationData = (SPCCALIBRATIONREG *)&SPCCalibrationStructure[ChannelNum];
	MOVLW       60
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_ConvertADtoTEMP_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _SPCCalibrationStructure+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_SPCCalibrationStructure+0)
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       ConvertADtoTEMP_PtrForCalibrationData_L0+0 
	MOVF        R1, 0 
	MOVWF       ConvertADtoTEMP_PtrForCalibrationData_L0+1 
;RTD.c,334 :: 		tempH = GetCalibrationData(PtrForCalibrationData, paraH, 1) - GetCalibrationData(PtrForCalibrationData, paraL, 1);
	MOVF        R0, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+0 
	MOVF        R1, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+1 
	MOVF        FARG_ConvertADtoTEMP_paraH+0, 0 
	MOVWF       FARG_GetCalibrationData_Location+0 
	MOVLW       1
	MOVWF       FARG_GetCalibrationData_ActualReq+0 
	CALL        _GetCalibrationData+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__ConvertADtoTEMP+0 
	MOVF        R1, 0 
	MOVWF       FLOC__ConvertADtoTEMP+1 
	MOVF        ConvertADtoTEMP_PtrForCalibrationData_L0+0, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+0 
	MOVF        ConvertADtoTEMP_PtrForCalibrationData_L0+1, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+1 
	MOVF        FARG_ConvertADtoTEMP_paraL+0, 0 
	MOVWF       FARG_GetCalibrationData_Location+0 
	MOVLW       1
	MOVWF       FARG_GetCalibrationData_ActualReq+0 
	CALL        _GetCalibrationData+0, 0
	MOVF        R0, 0 
	SUBWF       FLOC__ConvertADtoTEMP+0, 0 
	MOVWF       ConvertADtoTEMP_tempH_L0+0 
	MOVF        R1, 0 
	SUBWFB      FLOC__ConvertADtoTEMP+1, 0 
	MOVWF       ConvertADtoTEMP_tempH_L0+1 
	MOVLW       0
	BTFSC       ConvertADtoTEMP_tempH_L0+1, 7 
	MOVLW       255
	MOVWF       ConvertADtoTEMP_tempH_L0+2 
	MOVWF       ConvertADtoTEMP_tempH_L0+3 
;RTD.c,335 :: 		tempL = GetCalibrationData(PtrForCalibrationData, paraH, 0) - GetCalibrationData(PtrForCalibrationData, paraL, 0);
	MOVF        ConvertADtoTEMP_PtrForCalibrationData_L0+0, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+0 
	MOVF        ConvertADtoTEMP_PtrForCalibrationData_L0+1, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+1 
	MOVF        FARG_ConvertADtoTEMP_paraH+0, 0 
	MOVWF       FARG_GetCalibrationData_Location+0 
	CLRF        FARG_GetCalibrationData_ActualReq+0 
	CALL        _GetCalibrationData+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__ConvertADtoTEMP+0 
	MOVF        R1, 0 
	MOVWF       FLOC__ConvertADtoTEMP+1 
	MOVF        ConvertADtoTEMP_PtrForCalibrationData_L0+0, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+0 
	MOVF        ConvertADtoTEMP_PtrForCalibrationData_L0+1, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+1 
	MOVF        FARG_ConvertADtoTEMP_paraL+0, 0 
	MOVWF       FARG_GetCalibrationData_Location+0 
	CLRF        FARG_GetCalibrationData_ActualReq+0 
	CALL        _GetCalibrationData+0, 0
	MOVF        R0, 0 
	SUBWF       FLOC__ConvertADtoTEMP+0, 0 
	MOVWF       ConvertADtoTEMP_tempL_L0+0 
	MOVF        R1, 0 
	SUBWFB      FLOC__ConvertADtoTEMP+1, 0 
	MOVWF       ConvertADtoTEMP_tempL_L0+1 
	MOVLW       0
	BTFSC       ConvertADtoTEMP_tempL_L0+1, 7 
	MOVLW       255
	MOVWF       ConvertADtoTEMP_tempL_L0+2 
	MOVWF       ConvertADtoTEMP_tempL_L0+3 
;RTD.c,336 :: 		tempH = tempH* ((signed int)ADtemp - GetCalibrationData(PtrForCalibrationData, paraL, 0))/ tempL;
	MOVF        FARG_ConvertADtoTEMP_ADtemp+0, 0 
	MOVWF       FLOC__ConvertADtoTEMP+0 
	MOVF        FARG_ConvertADtoTEMP_ADtemp+1, 0 
	MOVWF       FLOC__ConvertADtoTEMP+1 
	MOVF        ConvertADtoTEMP_PtrForCalibrationData_L0+0, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+0 
	MOVF        ConvertADtoTEMP_PtrForCalibrationData_L0+1, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+1 
	MOVF        FARG_ConvertADtoTEMP_paraL+0, 0 
	MOVWF       FARG_GetCalibrationData_Location+0 
	CLRF        FARG_GetCalibrationData_ActualReq+0 
	CALL        _GetCalibrationData+0, 0
	MOVF        R0, 0 
	SUBWF       FLOC__ConvertADtoTEMP+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
	SUBWFB      FLOC__ConvertADtoTEMP+1, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	MOVF        ConvertADtoTEMP_tempH_L0+0, 0 
	MOVWF       R4 
	MOVF        ConvertADtoTEMP_tempH_L0+1, 0 
	MOVWF       R5 
	MOVF        ConvertADtoTEMP_tempH_L0+2, 0 
	MOVWF       R6 
	MOVF        ConvertADtoTEMP_tempH_L0+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVF        ConvertADtoTEMP_tempL_L0+0, 0 
	MOVWF       R4 
	MOVF        ConvertADtoTEMP_tempL_L0+1, 0 
	MOVWF       R5 
	MOVF        ConvertADtoTEMP_tempL_L0+2, 0 
	MOVWF       R6 
	MOVF        ConvertADtoTEMP_tempL_L0+3, 0 
	MOVWF       R7 
	CALL        _Div_32x32_S+0, 0
	MOVF        R0, 0 
	MOVWF       ConvertADtoTEMP_tempH_L0+0 
	MOVF        R1, 0 
	MOVWF       ConvertADtoTEMP_tempH_L0+1 
	MOVF        R2, 0 
	MOVWF       ConvertADtoTEMP_tempH_L0+2 
	MOVF        R3, 0 
	MOVWF       ConvertADtoTEMP_tempH_L0+3 
;RTD.c,337 :: 		resis = tempH + GetCalibrationData(PtrForCalibrationData, paraL, 1);
	MOVF        ConvertADtoTEMP_PtrForCalibrationData_L0+0, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+0 
	MOVF        ConvertADtoTEMP_PtrForCalibrationData_L0+1, 0 
	MOVWF       FARG_GetCalibrationData_Ptr+1 
	MOVF        FARG_ConvertADtoTEMP_paraL+0, 0 
	MOVWF       FARG_GetCalibrationData_Location+0 
	MOVLW       1
	MOVWF       FARG_GetCalibrationData_ActualReq+0 
	CALL        _GetCalibrationData+0, 0
	MOVF        R0, 0 
	ADDWF       ConvertADtoTEMP_tempH_L0+0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	ADDWFC      ConvertADtoTEMP_tempH_L0+1, 0 
	MOVWF       R3 
	MOVF        R2, 0 
	MOVWF       ConvertADtoTEMP_resis_L0+0 
	MOVF        R3, 0 
	MOVWF       ConvertADtoTEMP_resis_L0+1 
;RTD.c,339 :: 		if(resis > MAX_RESIS)
	MOVF        R3, 0 
	SUBLW       111
	BTFSS       STATUS+0, 2 
	GOTO        L__ConvertADtoTEMP60
	MOVF        R2, 0 
	SUBLW       14
L__ConvertADtoTEMP60:
	BTFSC       STATUS+0, 0 
	GOTO        L_ConvertADtoTEMP28
;RTD.c,340 :: 		return RTD_OPNE;
	MOVLW       253
	MOVWF       R0 
	MOVLW       127
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVWF       R3 
	GOTO        L_end_ConvertADtoTEMP
L_ConvertADtoTEMP28:
;RTD.c,341 :: 		else if(resis < MIN_RESIS)
	MOVLW       29
	SUBWF       ConvertADtoTEMP_resis_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ConvertADtoTEMP61
	MOVLW       249
	SUBWF       ConvertADtoTEMP_resis_L0+0, 0 
L__ConvertADtoTEMP61:
	BTFSC       STATUS+0, 0 
	GOTO        L_ConvertADtoTEMP30
;RTD.c,342 :: 		return RTD_SHORT;
	MOVLW       255
	MOVWF       R0 
	MOVLW       127
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVWF       R3 
	GOTO        L_end_ConvertADtoTEMP
L_ConvertADtoTEMP30:
;RTD.c,344 :: 		while(1)
L_ConvertADtoTEMP31:
;RTD.c,346 :: 		if(resis < g_RTDTableC[tempcount])
	MOVF        ConvertADtoTEMP_tempcount_L0+0, 0 
	MOVWF       R0 
	MOVF        ConvertADtoTEMP_tempcount_L0+1, 0 
	MOVWF       R1 
	MOVF        ConvertADtoTEMP_tempcount_L0+2, 0 
	MOVWF       R2 
	MOVF        ConvertADtoTEMP_tempcount_L0+3, 0 
	MOVWF       R3 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	MOVLW       _g_RTDTableC+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_g_RTDTableC+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(_g_RTDTableC+0)
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R1
	TBLRD*+
	MOVFF       TABLAT+0, R2
	MOVF        R2, 0 
	SUBWF       ConvertADtoTEMP_resis_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ConvertADtoTEMP62
	MOVF        R1, 0 
	SUBWF       ConvertADtoTEMP_resis_L0+0, 0 
L__ConvertADtoTEMP62:
	BTFSC       STATUS+0, 0 
	GOTO        L_ConvertADtoTEMP33
;RTD.c,348 :: 		if(tempcount)
	MOVF        ConvertADtoTEMP_tempcount_L0+0, 0 
	IORWF       ConvertADtoTEMP_tempcount_L0+1, 0 
	IORWF       ConvertADtoTEMP_tempcount_L0+2, 0 
	IORWF       ConvertADtoTEMP_tempcount_L0+3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_ConvertADtoTEMP34
;RTD.c,350 :: 		temp =  (long)tempcount *10;
	MOVF        ConvertADtoTEMP_tempcount_L0+0, 0 
	MOVWF       R0 
	MOVF        ConvertADtoTEMP_tempcount_L0+1, 0 
	MOVWF       R1 
	MOVF        ConvertADtoTEMP_tempcount_L0+2, 0 
	MOVWF       R2 
	MOVF        ConvertADtoTEMP_tempcount_L0+3, 0 
	MOVWF       R3 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       ConvertADtoTEMP_temp_L0+0 
	MOVF        R1, 0 
	MOVWF       ConvertADtoTEMP_temp_L0+1 
	MOVF        R2, 0 
	MOVWF       ConvertADtoTEMP_temp_L0+2 
	MOVF        R3, 0 
	MOVWF       ConvertADtoTEMP_temp_L0+3 
;RTD.c,351 :: 		tempresult = (long)(temp - (g_RTDTableC[tempcount] - resis)*
	MOVF        ConvertADtoTEMP_tempcount_L0+0, 0 
	MOVWF       R0 
	MOVF        ConvertADtoTEMP_tempcount_L0+1, 0 
	MOVWF       R1 
	MOVF        ConvertADtoTEMP_tempcount_L0+2, 0 
	MOVWF       R2 
	MOVF        ConvertADtoTEMP_tempcount_L0+3, 0 
	MOVWF       R3 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	MOVLW       _g_RTDTableC+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_g_RTDTableC+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(_g_RTDTableC+0)
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, FLOC__ConvertADtoTEMP+4
	TBLRD*+
	MOVFF       TABLAT+0, FLOC__ConvertADtoTEMP+5
	MOVF        ConvertADtoTEMP_resis_L0+0, 0 
	SUBWF       FLOC__ConvertADtoTEMP+4, 0 
	MOVWF       R0 
	MOVF        ConvertADtoTEMP_resis_L0+1, 0 
	SUBWFB      FLOC__ConvertADtoTEMP+5, 0 
	MOVWF       R1 
;RTD.c,352 :: 		10.0/(g_RTDTableC[tempcount] - g_RTDTableC[tempcount-1]));
	CALL        _Word2Double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       130
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__ConvertADtoTEMP+0 
	MOVF        R1, 0 
	MOVWF       FLOC__ConvertADtoTEMP+1 
	MOVF        R2, 0 
	MOVWF       FLOC__ConvertADtoTEMP+2 
	MOVF        R3, 0 
	MOVWF       FLOC__ConvertADtoTEMP+3 
	MOVF        ConvertADtoTEMP_tempcount_L0+0, 0 
	MOVWF       R5 
	MOVF        ConvertADtoTEMP_tempcount_L0+1, 0 
	MOVWF       R6 
	MOVF        ConvertADtoTEMP_tempcount_L0+2, 0 
	MOVWF       R7 
	MOVF        ConvertADtoTEMP_tempcount_L0+3, 0 
	MOVWF       R8 
	MOVLW       1
	SUBWF       R5, 1 
	MOVLW       0
	SUBWFB      R6, 1 
	SUBWFB      R7, 1 
	SUBWFB      R8, 1 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	MOVLW       _g_RTDTableC+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_g_RTDTableC+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(_g_RTDTableC+0)
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	TBLRD*+
	MOVFF       TABLAT+0, R1
	MOVF        R0, 0 
	SUBWF       FLOC__ConvertADtoTEMP+4, 0 
	MOVWF       R0 
	MOVF        R1, 0 
	SUBWFB      FLOC__ConvertADtoTEMP+5, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        FLOC__ConvertADtoTEMP+0, 0 
	MOVWF       R0 
	MOVF        FLOC__ConvertADtoTEMP+1, 0 
	MOVWF       R1 
	MOVF        FLOC__ConvertADtoTEMP+2, 0 
	MOVWF       R2 
	MOVF        FLOC__ConvertADtoTEMP+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__ConvertADtoTEMP+0 
	MOVF        R1, 0 
	MOVWF       FLOC__ConvertADtoTEMP+1 
	MOVF        R2, 0 
	MOVWF       FLOC__ConvertADtoTEMP+2 
	MOVF        R3, 0 
	MOVWF       FLOC__ConvertADtoTEMP+3 
	MOVF        ConvertADtoTEMP_temp_L0+0, 0 
	MOVWF       R0 
	MOVF        ConvertADtoTEMP_temp_L0+1, 0 
	MOVWF       R1 
	MOVF        ConvertADtoTEMP_temp_L0+2, 0 
	MOVWF       R2 
	MOVF        ConvertADtoTEMP_temp_L0+3, 0 
	MOVWF       R3 
	CALL        _Longint2Double+0, 0
	MOVF        FLOC__ConvertADtoTEMP+0, 0 
	MOVWF       R4 
	MOVF        FLOC__ConvertADtoTEMP+1, 0 
	MOVWF       R5 
	MOVF        FLOC__ConvertADtoTEMP+2, 0 
	MOVWF       R6 
	MOVF        FLOC__ConvertADtoTEMP+3, 0 
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	CALL        _Double2Longint+0, 0
	MOVF        R0, 0 
	MOVWF       ConvertADtoTEMP_tempresult_L0+0 
	MOVF        R1, 0 
	MOVWF       ConvertADtoTEMP_tempresult_L0+1 
	MOVF        R2, 0 
	MOVWF       ConvertADtoTEMP_tempresult_L0+2 
	MOVF        R3, 0 
	MOVWF       ConvertADtoTEMP_tempresult_L0+3 
;RTD.c,353 :: 		tempresult -= 590;
	MOVF        R0, 0 
	MOVWF       ConvertADtoTEMP_tempresult_L0+0 
	MOVF        R1, 0 
	MOVWF       ConvertADtoTEMP_tempresult_L0+1 
	MOVF        R2, 0 
	MOVWF       ConvertADtoTEMP_tempresult_L0+2 
	MOVF        R3, 0 
	MOVWF       ConvertADtoTEMP_tempresult_L0+3 
	MOVLW       78
	SUBWF       ConvertADtoTEMP_tempresult_L0+0, 1 
	MOVLW       2
	SUBWFB      ConvertADtoTEMP_tempresult_L0+1, 1 
	MOVLW       0
	SUBWFB      ConvertADtoTEMP_tempresult_L0+2, 1 
	SUBWFB      ConvertADtoTEMP_tempresult_L0+3, 1 
;RTD.c,354 :: 		}
	GOTO        L_ConvertADtoTEMP35
L_ConvertADtoTEMP34:
;RTD.c,356 :: 		tempresult = -590;
	MOVLW       178
	MOVWF       ConvertADtoTEMP_tempresult_L0+0 
	MOVLW       253
	MOVWF       ConvertADtoTEMP_tempresult_L0+1 
	MOVLW       255
	MOVWF       ConvertADtoTEMP_tempresult_L0+2 
	MOVWF       ConvertADtoTEMP_tempresult_L0+3 
L_ConvertADtoTEMP35:
;RTD.c,358 :: 		if(tempresult > 0)
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       ConvertADtoTEMP_tempresult_L0+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ConvertADtoTEMP63
	MOVF        ConvertADtoTEMP_tempresult_L0+2, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__ConvertADtoTEMP63
	MOVF        ConvertADtoTEMP_tempresult_L0+1, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__ConvertADtoTEMP63
	MOVF        ConvertADtoTEMP_tempresult_L0+0, 0 
	SUBLW       0
L__ConvertADtoTEMP63:
	BTFSC       STATUS+0, 0 
	GOTO        L_ConvertADtoTEMP36
;RTD.c,359 :: 		return (tempresult+5)/10;
	MOVLW       5
	ADDWF       ConvertADtoTEMP_tempresult_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      ConvertADtoTEMP_tempresult_L0+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      ConvertADtoTEMP_tempresult_L0+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      ConvertADtoTEMP_tempresult_L0+3, 0 
	MOVWF       R3 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Div_32x32_S+0, 0
	GOTO        L_end_ConvertADtoTEMP
L_ConvertADtoTEMP36:
;RTD.c,361 :: 		return (tempresult-5)/10;
	MOVF        ConvertADtoTEMP_tempresult_L0+0, 0 
	MOVWF       R0 
	MOVF        ConvertADtoTEMP_tempresult_L0+1, 0 
	MOVWF       R1 
	MOVF        ConvertADtoTEMP_tempresult_L0+2, 0 
	MOVWF       R2 
	MOVF        ConvertADtoTEMP_tempresult_L0+3, 0 
	MOVWF       R3 
	MOVLW       5
	SUBWF       R0, 1 
	MOVLW       0
	SUBWFB      R1, 1 
	SUBWFB      R2, 1 
	SUBWFB      R3, 1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Div_32x32_S+0, 0
	GOTO        L_end_ConvertADtoTEMP
;RTD.c,363 :: 		}
L_ConvertADtoTEMP33:
;RTD.c,365 :: 		tempcount++;
	MOVLW       1
	ADDWF       ConvertADtoTEMP_tempcount_L0+0, 1 
	MOVLW       0
	ADDWFC      ConvertADtoTEMP_tempcount_L0+1, 1 
	ADDWFC      ConvertADtoTEMP_tempcount_L0+2, 1 
	ADDWFC      ConvertADtoTEMP_tempcount_L0+3, 1 
;RTD.c,366 :: 		}
	GOTO        L_ConvertADtoTEMP31
;RTD.c,368 :: 		}
L_end_ConvertADtoTEMP:
	RETURN      0
; end of _ConvertADtoTEMP
