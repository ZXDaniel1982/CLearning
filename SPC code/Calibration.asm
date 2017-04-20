
_GetCalibrationData:

;Calibration.c,95 :: 		int GetCalibrationData(SPCCALIBRATIONREG *Ptr,char Location, char ActualReq)
;Calibration.c,98 :: 		TempPtr = Ptr + Location;
	MOVF        FARG_GetCalibrationData_Location+0, 0 
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
	ADDWF       FARG_GetCalibrationData_Ptr+0, 0 
	MOVWF       R3 
	MOVF        R1, 0 
	ADDWFC      FARG_GetCalibrationData_Ptr+1, 0 
	MOVWF       R4 
;Calibration.c,100 :: 		if(ActualReq)
	MOVF        FARG_GetCalibrationData_ActualReq+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_GetCalibrationData0
;Calibration.c,101 :: 		return TempPtr->CalibartionActural;
	MOVFF       R3, FSR0
	MOVFF       R4, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	GOTO        L_end_GetCalibrationData
L_GetCalibrationData0:
;Calibration.c,103 :: 		return TempPtr->CalibartionSetpoint;
	MOVLW       2
	ADDWF       R3, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R4, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
;Calibration.c,104 :: 		}
L_end_GetCalibrationData:
	RETURN      0
; end of _GetCalibrationData

_SetCommand:

;Calibration.c,106 :: 		void SetCommand(char CommandType, char CommandData)
;Calibration.c,108 :: 		CalibrationCommand[CommandType] = CommandData;
	MOVLW       _CalibrationCommand+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_CalibrationCommand+0)
	MOVWF       FSR1H 
	MOVF        FARG_SetCommand_CommandType+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVF        FARG_SetCommand_CommandData+0, 0 
	MOVWF       POSTINC1+0 
;Calibration.c,109 :: 		}
L_end_SetCommand:
	RETURN      0
; end of _SetCommand

_GetCommand:

;Calibration.c,111 :: 		char GetCommand(char CommandType)
;Calibration.c,113 :: 		return CalibrationCommand[CommandType];
	MOVLW       _CalibrationCommand+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_CalibrationCommand+0)
	MOVWF       FSR0H 
	MOVF        FARG_GetCommand_CommandType+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
;Calibration.c,114 :: 		}
L_end_GetCommand:
	RETURN      0
; end of _GetCommand

_MeasureCG:

;Calibration.c,116 :: 		int MeasureCG(char CalibrateCGCmd)
;Calibration.c,119 :: 		long CurrentAcc=0, GFIAcc=0;
	CLRF        MeasureCG_CurrentAcc_L0+0 
	CLRF        MeasureCG_CurrentAcc_L0+1 
	CLRF        MeasureCG_CurrentAcc_L0+2 
	CLRF        MeasureCG_CurrentAcc_L0+3 
	CLRF        MeasureCG_GFIAcc_L0+0 
	CLRF        MeasureCG_GFIAcc_L0+1 
	CLRF        MeasureCG_GFIAcc_L0+2 
	CLRF        MeasureCG_GFIAcc_L0+3 
	CLRF        MeasureCG_SampleNum_L0+0 
	CLRF        MeasureCG_SampleNum_L0+1 
	CLRF        MeasureCG_MeasureEn_L0+0 
;Calibration.c,123 :: 		MeasureEn = 1;
	MOVLW       1
	MOVWF       MeasureCG_MeasureEn_L0+0 
;Calibration.c,124 :: 		CalibrationCommand[CURRENTGFI_MEASURE] = INITIAL_COMMAND;
	MOVLW       1
	MOVWF       _CalibrationCommand+0 
;Calibration.c,125 :: 		CalibrationCount = 0;
	CLRF        _CalibrationCount+0 
;Calibration.c,127 :: 		while(MeasureEn)
L_MeasureCG2:
	MOVF        MeasureCG_MeasureEn_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_MeasureCG3
;Calibration.c,129 :: 		CurrentAcc += GetGFI(ChannelSwitch, CURRENT_AD_COMMND);
	MOVF        _ChannelSwitch+0, 0 
	MOVWF       FARG_GetGFI_ChannelSelect+0 
	MOVLW       160
	MOVWF       FARG_GetGFI_cmd+0 
	CALL        _GetGFI+0, 0
	MOVF        R0, 0 
	ADDWF       MeasureCG_CurrentAcc_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      MeasureCG_CurrentAcc_L0+1, 1 
	MOVLW       0
	ADDWFC      MeasureCG_CurrentAcc_L0+2, 1 
	ADDWFC      MeasureCG_CurrentAcc_L0+3, 1 
;Calibration.c,130 :: 		GFIAcc += GetGFI(ChannelSwitch, GFI_AD_COMMND);
	MOVF        _ChannelSwitch+0, 0 
	MOVWF       FARG_GetGFI_ChannelSelect+0 
	MOVLW       224
	MOVWF       FARG_GetGFI_cmd+0 
	CALL        _GetGFI+0, 0
	MOVF        R0, 0 
	ADDWF       MeasureCG_GFIAcc_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      MeasureCG_GFIAcc_L0+1, 1 
	MOVLW       0
	ADDWFC      MeasureCG_GFIAcc_L0+2, 1 
	ADDWFC      MeasureCG_GFIAcc_L0+3, 1 
;Calibration.c,131 :: 		SampleNum++;
	INFSNZ      MeasureCG_SampleNum_L0+0, 1 
	INCF        MeasureCG_SampleNum_L0+1, 1 
;Calibration.c,133 :: 		if(CalibrationCommand[CURRENTGFI_MEASURE] == FINISH_COMMAND)
	MOVF        _CalibrationCommand+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_MeasureCG4
;Calibration.c,134 :: 		MeasureEn = 0;
	CLRF        MeasureCG_MeasureEn_L0+0 
L_MeasureCG4:
;Calibration.c,135 :: 		}
	GOTO        L_MeasureCG2
L_MeasureCG3:
;Calibration.c,137 :: 		CalibrationCommand[CURRENTGFI_MEASURE] = 0;
	CLRF        _CalibrationCommand+0 
;Calibration.c,138 :: 		CalibrationCount = 0;
	CLRF        _CalibrationCount+0 
;Calibration.c,139 :: 		if(CurrentAcc == 0)
	MOVLW       0
	MOVWF       R0 
	XORWF       MeasureCG_CurrentAcc_L0+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__MeasureCG64
	MOVF        R0, 0 
	XORWF       MeasureCG_CurrentAcc_L0+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__MeasureCG64
	MOVF        R0, 0 
	XORWF       MeasureCG_CurrentAcc_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__MeasureCG64
	MOVF        MeasureCG_CurrentAcc_L0+0, 0 
	XORLW       0
L__MeasureCG64:
	BTFSS       STATUS+0, 2 
	GOTO        L_MeasureCG5
;Calibration.c,140 :: 		CurrentBuff = 0;
	CLRF        MeasureCG_CurrentBuff_L0+0 
	CLRF        MeasureCG_CurrentBuff_L0+1 
	GOTO        L_MeasureCG6
L_MeasureCG5:
;Calibration.c,142 :: 		CurrentBuff = CurrentAcc/SampleNum;
	MOVF        MeasureCG_SampleNum_L0+0, 0 
	MOVWF       R4 
	MOVF        MeasureCG_SampleNum_L0+1, 0 
	MOVWF       R5 
	MOVLW       0
	BTFSC       MeasureCG_SampleNum_L0+1, 7 
	MOVLW       255
	MOVWF       R6 
	MOVWF       R7 
	MOVF        MeasureCG_CurrentAcc_L0+0, 0 
	MOVWF       R0 
	MOVF        MeasureCG_CurrentAcc_L0+1, 0 
	MOVWF       R1 
	MOVF        MeasureCG_CurrentAcc_L0+2, 0 
	MOVWF       R2 
	MOVF        MeasureCG_CurrentAcc_L0+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_S+0, 0
	MOVF        R0, 0 
	MOVWF       MeasureCG_CurrentBuff_L0+0 
	MOVF        R1, 0 
	MOVWF       MeasureCG_CurrentBuff_L0+1 
L_MeasureCG6:
;Calibration.c,144 :: 		if(GFIAcc == 0)
	MOVLW       0
	MOVWF       R0 
	XORWF       MeasureCG_GFIAcc_L0+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__MeasureCG65
	MOVF        R0, 0 
	XORWF       MeasureCG_GFIAcc_L0+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__MeasureCG65
	MOVF        R0, 0 
	XORWF       MeasureCG_GFIAcc_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__MeasureCG65
	MOVF        MeasureCG_GFIAcc_L0+0, 0 
	XORLW       0
L__MeasureCG65:
	BTFSS       STATUS+0, 2 
	GOTO        L_MeasureCG7
;Calibration.c,145 :: 		GFIBuff = 0;
	CLRF        MeasureCG_GFIBuff_L0+0 
	CLRF        MeasureCG_GFIBuff_L0+1 
	GOTO        L_MeasureCG8
L_MeasureCG7:
;Calibration.c,147 :: 		GFIBuff = GFIAcc/SampleNum;
	MOVF        MeasureCG_SampleNum_L0+0, 0 
	MOVWF       R4 
	MOVF        MeasureCG_SampleNum_L0+1, 0 
	MOVWF       R5 
	MOVLW       0
	BTFSC       MeasureCG_SampleNum_L0+1, 7 
	MOVLW       255
	MOVWF       R6 
	MOVWF       R7 
	MOVF        MeasureCG_GFIAcc_L0+0, 0 
	MOVWF       R0 
	MOVF        MeasureCG_GFIAcc_L0+1, 0 
	MOVWF       R1 
	MOVF        MeasureCG_GFIAcc_L0+2, 0 
	MOVWF       R2 
	MOVF        MeasureCG_GFIAcc_L0+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_S+0, 0
	MOVF        R0, 0 
	MOVWF       MeasureCG_GFIBuff_L0+0 
	MOVF        R1, 0 
	MOVWF       MeasureCG_GFIBuff_L0+1 
L_MeasureCG8:
;Calibration.c,149 :: 		if(CalibrateCGCmd)
	MOVF        FARG_MeasureCG_CalibrateCGCmd+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_MeasureCG9
;Calibration.c,150 :: 		return CurrentBuff;
	MOVF        MeasureCG_CurrentBuff_L0+0, 0 
	MOVWF       R0 
	MOVF        MeasureCG_CurrentBuff_L0+1, 0 
	MOVWF       R1 
	GOTO        L_end_MeasureCG
L_MeasureCG9:
;Calibration.c,152 :: 		return GFIBuff;
	MOVF        MeasureCG_GFIBuff_L0+0, 0 
	MOVWF       R0 
	MOVF        MeasureCG_GFIBuff_L0+1, 0 
	MOVWF       R1 
;Calibration.c,153 :: 		}
L_end_MeasureCG:
	RETURN      0
; end of _MeasureCG

_WaitForValue:

;Calibration.c,156 :: 		void WaitForValue(char LowValueType)
;Calibration.c,158 :: 		char Loop=1;
	MOVLW       1
	MOVWF       WaitForValue_Loop_L0+0 
;Calibration.c,161 :: 		while(Loop)
L_WaitForValue11:
	MOVF        WaitForValue_Loop_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_WaitForValue12
;Calibration.c,163 :: 		ValueTemp = MeasureCG(LowValueType);
	MOVF        FARG_WaitForValue_LowValueType+0, 0 
	MOVWF       FARG_MeasureCG_CalibrateCGCmd+0 
	CALL        _MeasureCG+0, 0
;Calibration.c,164 :: 		if(ValueTemp < 50)
	MOVLW       128
	XORWF       R1, 0 
	MOVWF       R2 
	MOVLW       128
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WaitForValue67
	MOVLW       50
	SUBWF       R0, 0 
L__WaitForValue67:
	BTFSC       STATUS+0, 0 
	GOTO        L_WaitForValue13
;Calibration.c,165 :: 		Loop = 0;
	CLRF        WaitForValue_Loop_L0+0 
L_WaitForValue13:
;Calibration.c,166 :: 		}
	GOTO        L_WaitForValue11
L_WaitForValue12:
;Calibration.c,167 :: 		}
L_end_WaitForValue:
	RETURN      0
; end of _WaitForValue

_SPCCalibration:

;Calibration.c,169 :: 		void SPCCalibration()
;Calibration.c,174 :: 		Ptr = (SPCCALIBRATIONREG *)&SPCCalibrationStructure[0];
	MOVLW       _SPCCalibrationStructure+0
	MOVWF       SPCCalibration_Ptr_L0+0 
	MOVLW       hi_addr(_SPCCalibrationStructure+0)
	MOVWF       SPCCalibration_Ptr_L0+1 
;Calibration.c,175 :: 		if(SPCCalibrationEN == 0)
	MOVF        _SPCCalibrationEN+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_SPCCalibration14
;Calibration.c,176 :: 		return;
	GOTO        L_end_SPCCalibration
L_SPCCalibration14:
;Calibration.c,179 :: 		while(SPCCalibrationEN)
L_SPCCalibration16:
	MOVF        _SPCCalibrationEN+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCCalibration17
;Calibration.c,181 :: 		modbusprocess();
	CALL        _modbusprocess+0, 0
;Calibration.c,182 :: 		switch(SPCCalibrationBox.CalibartionType)
	GOTO        L_SPCCalibration18
;Calibration.c,184 :: 		case 0:
L_SPCCalibration20:
;Calibration.c,185 :: 		getParaChar(Info_Line1, NOW_CALIBRATION_STR);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       91
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Calibration.c,186 :: 		getParaChar(Info_Line2, BLANK_STR);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       39
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Calibration.c,187 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
;Calibration.c,188 :: 		SPCCalibrationBox.CalibartionType = 25;
	MOVLW       25
	MOVWF       _SPCCalibrationBox+0 
;Calibration.c,189 :: 		SetModbusTxData(0);
	CLRF        FARG_SetModbusTxData_TransData+0 
	CLRF        FARG_SetModbusTxData_TransData+1 
	CALL        _SetModbusTxData+0, 0
;Calibration.c,190 :: 		modbus_respond();
	CALL        _modbus_respond+0, 0
;Calibration.c,191 :: 		break;
	GOTO        L_SPCCalibration19
;Calibration.c,192 :: 		case 1:  //temp cali A channel
L_SPCCalibration21:
;Calibration.c,193 :: 		Delay_ms(600);
	MOVLW       16
	MOVWF       R11, 0
	MOVLW       57
	MOVWF       R12, 0
	MOVLW       13
	MOVWF       R13, 0
L_SPCCalibration22:
	DECFSZ      R13, 1, 1
	BRA         L_SPCCalibration22
	DECFSZ      R12, 1, 1
	BRA         L_SPCCalibration22
	DECFSZ      R11, 1, 1
	BRA         L_SPCCalibration22
	NOP
	NOP
;Calibration.c,194 :: 		ADBuff = MCP3202_GET_AD(RTD_CHANNEL1+ChannelSwitch,RTDA_AD_COMMND, 100);
	MOVF        _ChannelSwitch+0, 0 
	ADDLW       8
	MOVWF       FARG_MCP3202_GET_AD_Spi_Channel+0 
	MOVLW       224
	MOVWF       FARG_MCP3202_GET_AD_Spi_AD_CMD+0 
	MOVLW       100
	MOVWF       FARG_MCP3202_GET_AD_NumOfSample+0 
	CALL        _MCP3202_GET_AD+0, 0
	MOVF        R0, 0 
	MOVWF       SPCCalibration_ADBuff_L0+0 
	MOVF        R1, 0 
	MOVWF       SPCCalibration_ADBuff_L0+1 
;Calibration.c,196 :: 		Ptr += SPCCalibrationBox.CalibartionAddress;
	MOVF        _SPCCalibrationBox+1, 0 
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	RLCF        R2, 1 
	BCF         R2, 0 
	RLCF        R3, 1 
	RLCF        R2, 1 
	BCF         R2, 0 
	RLCF        R3, 1 
	MOVF        SPCCalibration_Ptr_L0+0, 0 
	ADDWF       R2, 1 
	MOVF        SPCCalibration_Ptr_L0+1, 0 
	ADDWFC      R3, 1 
	MOVF        R2, 0 
	MOVWF       SPCCalibration_Ptr_L0+0 
	MOVF        R3, 0 
	MOVWF       SPCCalibration_Ptr_L0+1 
;Calibration.c,197 :: 		Ptr->CalibartionSetpoint = ADBuff;
	MOVLW       2
	ADDWF       R2, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       FSR1H 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Calibration.c,198 :: 		Ptr->CalibartionActural = SPCCalibrationBox.CalibartionData;
	MOVFF       SPCCalibration_Ptr_L0+0, FSR1
	MOVFF       SPCCalibration_Ptr_L0+1, FSR1H
	MOVF        _SPCCalibrationBox+2, 0 
	MOVWF       POSTINC1+0 
	MOVF        _SPCCalibrationBox+3, 0 
	MOVWF       POSTINC1+0 
;Calibration.c,199 :: 		SPCCalibrationBox.CalibartionType = 25;
	MOVLW       25
	MOVWF       _SPCCalibrationBox+0 
;Calibration.c,200 :: 		SetModbusTxData(ADBuff);
	MOVF        SPCCalibration_ADBuff_L0+0, 0 
	MOVWF       FARG_SetModbusTxData_TransData+0 
	MOVF        SPCCalibration_ADBuff_L0+1, 0 
	MOVWF       FARG_SetModbusTxData_TransData+1 
	CALL        _SetModbusTxData+0, 0
;Calibration.c,201 :: 		modbus_respond();
	CALL        _modbus_respond+0, 0
;Calibration.c,202 :: 		break;
	GOTO        L_SPCCalibration19
;Calibration.c,203 :: 		case 2:  //temp cali B channel
L_SPCCalibration23:
;Calibration.c,204 :: 		Delay_ms(600);
	MOVLW       16
	MOVWF       R11, 0
	MOVLW       57
	MOVWF       R12, 0
	MOVLW       13
	MOVWF       R13, 0
L_SPCCalibration24:
	DECFSZ      R13, 1, 1
	BRA         L_SPCCalibration24
	DECFSZ      R12, 1, 1
	BRA         L_SPCCalibration24
	DECFSZ      R11, 1, 1
	BRA         L_SPCCalibration24
	NOP
	NOP
;Calibration.c,205 :: 		ADBuff = MCP3202_GET_AD(RTD_CHANNEL1+ChannelSwitch,RTDB_AD_COMMND, 100);
	MOVF        _ChannelSwitch+0, 0 
	ADDLW       8
	MOVWF       FARG_MCP3202_GET_AD_Spi_Channel+0 
	MOVLW       160
	MOVWF       FARG_MCP3202_GET_AD_Spi_AD_CMD+0 
	MOVLW       100
	MOVWF       FARG_MCP3202_GET_AD_NumOfSample+0 
	CALL        _MCP3202_GET_AD+0, 0
	MOVF        R0, 0 
	MOVWF       SPCCalibration_ADBuff_L0+0 
	MOVF        R1, 0 
	MOVWF       SPCCalibration_ADBuff_L0+1 
;Calibration.c,207 :: 		Ptr += SPCCalibrationBox.CalibartionAddress;
	MOVF        _SPCCalibrationBox+1, 0 
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	RLCF        R2, 1 
	BCF         R2, 0 
	RLCF        R3, 1 
	RLCF        R2, 1 
	BCF         R2, 0 
	RLCF        R3, 1 
	MOVF        SPCCalibration_Ptr_L0+0, 0 
	ADDWF       R2, 1 
	MOVF        SPCCalibration_Ptr_L0+1, 0 
	ADDWFC      R3, 1 
	MOVF        R2, 0 
	MOVWF       SPCCalibration_Ptr_L0+0 
	MOVF        R3, 0 
	MOVWF       SPCCalibration_Ptr_L0+1 
;Calibration.c,208 :: 		Ptr->CalibartionSetpoint = ADBuff;
	MOVLW       2
	ADDWF       R2, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       FSR1H 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Calibration.c,209 :: 		Ptr->CalibartionActural = SPCCalibrationBox.CalibartionData;
	MOVFF       SPCCalibration_Ptr_L0+0, FSR1
	MOVFF       SPCCalibration_Ptr_L0+1, FSR1H
	MOVF        _SPCCalibrationBox+2, 0 
	MOVWF       POSTINC1+0 
	MOVF        _SPCCalibrationBox+3, 0 
	MOVWF       POSTINC1+0 
;Calibration.c,210 :: 		SPCCalibrationBox.CalibartionType = 25;
	MOVLW       25
	MOVWF       _SPCCalibrationBox+0 
;Calibration.c,211 :: 		SetModbusTxData(ADBuff);
	MOVF        SPCCalibration_ADBuff_L0+0, 0 
	MOVWF       FARG_SetModbusTxData_TransData+0 
	MOVF        SPCCalibration_ADBuff_L0+1, 0 
	MOVWF       FARG_SetModbusTxData_TransData+1 
	CALL        _SetModbusTxData+0, 0
;Calibration.c,212 :: 		modbus_respond();
	CALL        _modbus_respond+0, 0
;Calibration.c,213 :: 		break;
	GOTO        L_SPCCalibration19
;Calibration.c,214 :: 		case 3:  //current cali
L_SPCCalibration25:
;Calibration.c,215 :: 		if(CalibrationCommand[CURRENT_CALIBRATION_STEP] == 0)
	MOVF        _CalibrationCommand+3, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_SPCCalibration26
;Calibration.c,217 :: 		WaitForValue(CURRENT_LOW);
	MOVLW       1
	MOVWF       FARG_WaitForValue_LowValueType+0 
	CALL        _WaitForValue+0, 0
;Calibration.c,218 :: 		SetModbusTxData(0);
	CLRF        FARG_SetModbusTxData_TransData+0 
	CLRF        FARG_SetModbusTxData_TransData+1 
	CALL        _SetModbusTxData+0, 0
;Calibration.c,219 :: 		}
	GOTO        L_SPCCalibration27
L_SPCCalibration26:
;Calibration.c,222 :: 		Delay_ms(600);
	MOVLW       16
	MOVWF       R11, 0
	MOVLW       57
	MOVWF       R12, 0
	MOVLW       13
	MOVWF       R13, 0
L_SPCCalibration28:
	DECFSZ      R13, 1, 1
	BRA         L_SPCCalibration28
	DECFSZ      R12, 1, 1
	BRA         L_SPCCalibration28
	DECFSZ      R11, 1, 1
	BRA         L_SPCCalibration28
	NOP
	NOP
;Calibration.c,223 :: 		ADBuff = MeasureCG(GETCURRENTFORCALIBRATION);
	MOVLW       1
	MOVWF       FARG_MeasureCG_CalibrateCGCmd+0 
	CALL        _MeasureCG+0, 0
	MOVF        R0, 0 
	MOVWF       SPCCalibration_ADBuff_L0+0 
	MOVF        R1, 0 
	MOVWF       SPCCalibration_ADBuff_L0+1 
;Calibration.c,225 :: 		Ptr += SPCCalibrationBox.CalibartionAddress;
	MOVF        _SPCCalibrationBox+1, 0 
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	RLCF        R2, 1 
	BCF         R2, 0 
	RLCF        R3, 1 
	RLCF        R2, 1 
	BCF         R2, 0 
	RLCF        R3, 1 
	MOVF        SPCCalibration_Ptr_L0+0, 0 
	ADDWF       R2, 1 
	MOVF        SPCCalibration_Ptr_L0+1, 0 
	ADDWFC      R3, 1 
	MOVF        R2, 0 
	MOVWF       SPCCalibration_Ptr_L0+0 
	MOVF        R3, 0 
	MOVWF       SPCCalibration_Ptr_L0+1 
;Calibration.c,226 :: 		Ptr->CalibartionSetpoint = ADBuff;
	MOVLW       2
	ADDWF       R2, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       FSR1H 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Calibration.c,227 :: 		Ptr->CalibartionActural = SPCCalibrationBox.CalibartionData;
	MOVFF       SPCCalibration_Ptr_L0+0, FSR1
	MOVFF       SPCCalibration_Ptr_L0+1, FSR1H
	MOVF        _SPCCalibrationBox+2, 0 
	MOVWF       POSTINC1+0 
	MOVF        _SPCCalibrationBox+3, 0 
	MOVWF       POSTINC1+0 
;Calibration.c,228 :: 		SetModbusTxData(ADBuff);
	MOVF        SPCCalibration_ADBuff_L0+0, 0 
	MOVWF       FARG_SetModbusTxData_TransData+0 
	MOVF        SPCCalibration_ADBuff_L0+1, 0 
	MOVWF       FARG_SetModbusTxData_TransData+1 
	CALL        _SetModbusTxData+0, 0
;Calibration.c,229 :: 		}
L_SPCCalibration27:
;Calibration.c,230 :: 		CalibrationCommand[CURRENT_CALIBRATION_STEP] ^= 1;
	BTG         _CalibrationCommand+3, 0 
;Calibration.c,231 :: 		SPCCalibrationBox.CalibartionType = 25;
	MOVLW       25
	MOVWF       _SPCCalibrationBox+0 
;Calibration.c,232 :: 		modbus_respond();
	CALL        _modbus_respond+0, 0
;Calibration.c,233 :: 		break;
	GOTO        L_SPCCalibration19
;Calibration.c,234 :: 		case 4:  //GFI cali
L_SPCCalibration29:
;Calibration.c,235 :: 		if(CalibrationCommand[GFI_CALIBRATION_STEP] == 0)
	MOVF        _CalibrationCommand+4, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_SPCCalibration30
;Calibration.c,237 :: 		WaitForValue(GFI_LOW);
	CLRF        FARG_WaitForValue_LowValueType+0 
	CALL        _WaitForValue+0, 0
;Calibration.c,238 :: 		SetModbusTxData(0);
	CLRF        FARG_SetModbusTxData_TransData+0 
	CLRF        FARG_SetModbusTxData_TransData+1 
	CALL        _SetModbusTxData+0, 0
;Calibration.c,239 :: 		}
	GOTO        L_SPCCalibration31
L_SPCCalibration30:
;Calibration.c,242 :: 		Delay_ms(600);
	MOVLW       16
	MOVWF       R11, 0
	MOVLW       57
	MOVWF       R12, 0
	MOVLW       13
	MOVWF       R13, 0
L_SPCCalibration32:
	DECFSZ      R13, 1, 1
	BRA         L_SPCCalibration32
	DECFSZ      R12, 1, 1
	BRA         L_SPCCalibration32
	DECFSZ      R11, 1, 1
	BRA         L_SPCCalibration32
	NOP
	NOP
;Calibration.c,243 :: 		ADBuff = MeasureCG(GETGFIFORCALIBRATION);
	CLRF        FARG_MeasureCG_CalibrateCGCmd+0 
	CALL        _MeasureCG+0, 0
	MOVF        R0, 0 
	MOVWF       SPCCalibration_ADBuff_L0+0 
	MOVF        R1, 0 
	MOVWF       SPCCalibration_ADBuff_L0+1 
;Calibration.c,245 :: 		Ptr += SPCCalibrationBox.CalibartionAddress;
	MOVF        _SPCCalibrationBox+1, 0 
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	RLCF        R2, 1 
	BCF         R2, 0 
	RLCF        R3, 1 
	RLCF        R2, 1 
	BCF         R2, 0 
	RLCF        R3, 1 
	MOVF        SPCCalibration_Ptr_L0+0, 0 
	ADDWF       R2, 1 
	MOVF        SPCCalibration_Ptr_L0+1, 0 
	ADDWFC      R3, 1 
	MOVF        R2, 0 
	MOVWF       SPCCalibration_Ptr_L0+0 
	MOVF        R3, 0 
	MOVWF       SPCCalibration_Ptr_L0+1 
;Calibration.c,246 :: 		Ptr->CalibartionSetpoint = ADBuff;
	MOVLW       2
	ADDWF       R2, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       FSR1H 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Calibration.c,247 :: 		Ptr->CalibartionActural = SPCCalibrationBox.CalibartionData;
	MOVFF       SPCCalibration_Ptr_L0+0, FSR1
	MOVFF       SPCCalibration_Ptr_L0+1, FSR1H
	MOVF        _SPCCalibrationBox+2, 0 
	MOVWF       POSTINC1+0 
	MOVF        _SPCCalibrationBox+3, 0 
	MOVWF       POSTINC1+0 
;Calibration.c,248 :: 		SetModbusTxData(ADBuff);
	MOVF        SPCCalibration_ADBuff_L0+0, 0 
	MOVWF       FARG_SetModbusTxData_TransData+0 
	MOVF        SPCCalibration_ADBuff_L0+1, 0 
	MOVWF       FARG_SetModbusTxData_TransData+1 
	CALL        _SetModbusTxData+0, 0
;Calibration.c,249 :: 		}
L_SPCCalibration31:
;Calibration.c,250 :: 		CalibrationCommand[GFI_CALIBRATION_STEP] ^= 1;
	BTG         _CalibrationCommand+4, 0 
;Calibration.c,251 :: 		SPCCalibrationBox.CalibartionType = 25;
	MOVLW       25
	MOVWF       _SPCCalibrationBox+0 
;Calibration.c,252 :: 		modbus_respond();
	CALL        _modbus_respond+0, 0
;Calibration.c,253 :: 		break;
	GOTO        L_SPCCalibration19
;Calibration.c,254 :: 		case 5:  //temp a test
L_SPCCalibration33:
;Calibration.c,255 :: 		Delay_ms(600);
	MOVLW       16
	MOVWF       R11, 0
	MOVLW       57
	MOVWF       R12, 0
	MOVLW       13
	MOVWF       R13, 0
L_SPCCalibration34:
	DECFSZ      R13, 1, 1
	BRA         L_SPCCalibration34
	DECFSZ      R12, 1, 1
	BRA         L_SPCCalibration34
	DECFSZ      R11, 1, 1
	BRA         L_SPCCalibration34
	NOP
	NOP
;Calibration.c,256 :: 		ADBuff = MCP3202_GET_AD(RTD_CHANNEL1+ChannelSwitch,RTDA_AD_COMMND, 100);
	MOVF        _ChannelSwitch+0, 0 
	ADDLW       8
	MOVWF       FARG_MCP3202_GET_AD_Spi_Channel+0 
	MOVLW       224
	MOVWF       FARG_MCP3202_GET_AD_Spi_AD_CMD+0 
	MOVLW       100
	MOVWF       FARG_MCP3202_GET_AD_NumOfSample+0 
	CALL        _MCP3202_GET_AD+0, 0
	MOVF        R0, 0 
	MOVWF       SPCCalibration_ADBuff_L0+0 
	MOVF        R1, 0 
	MOVWF       SPCCalibration_ADBuff_L0+1 
;Calibration.c,257 :: 		ADBuff = ConvertADtoTEMP(ADBuff, CALI_RTDA_50, CALI_RTDA_500, 0);
	MOVF        R0, 0 
	MOVWF       FARG_ConvertADtoTEMP_ADtemp+0 
	MOVF        R1, 0 
	MOVWF       FARG_ConvertADtoTEMP_ADtemp+1 
	CLRF        FARG_ConvertADtoTEMP_paraL+0 
	MOVLW       1
	MOVWF       FARG_ConvertADtoTEMP_paraH+0 
	CLRF        FARG_ConvertADtoTEMP_ChannelNum+0 
	CALL        _ConvertADtoTEMP+0, 0
	MOVF        R0, 0 
	MOVWF       SPCCalibration_ADBuff_L0+0 
	MOVF        R1, 0 
	MOVWF       SPCCalibration_ADBuff_L0+1 
;Calibration.c,258 :: 		SPCCalibrationBox.CalibartionType = 25;
	MOVLW       25
	MOVWF       _SPCCalibrationBox+0 
;Calibration.c,259 :: 		SetModbusTxData(ADBuff);
	MOVF        R0, 0 
	MOVWF       FARG_SetModbusTxData_TransData+0 
	MOVF        R1, 0 
	MOVWF       FARG_SetModbusTxData_TransData+1 
	CALL        _SetModbusTxData+0, 0
;Calibration.c,260 :: 		modbus_respond();
	CALL        _modbus_respond+0, 0
;Calibration.c,261 :: 		break;
	GOTO        L_SPCCalibration19
;Calibration.c,262 :: 		case 6:  //temp b test
L_SPCCalibration35:
;Calibration.c,263 :: 		Delay_ms(600);
	MOVLW       16
	MOVWF       R11, 0
	MOVLW       57
	MOVWF       R12, 0
	MOVLW       13
	MOVWF       R13, 0
L_SPCCalibration36:
	DECFSZ      R13, 1, 1
	BRA         L_SPCCalibration36
	DECFSZ      R12, 1, 1
	BRA         L_SPCCalibration36
	DECFSZ      R11, 1, 1
	BRA         L_SPCCalibration36
	NOP
	NOP
;Calibration.c,264 :: 		ADBuff = MCP3202_GET_AD(RTD_CHANNEL1+ChannelSwitch,RTDB_AD_COMMND, 100);
	MOVF        _ChannelSwitch+0, 0 
	ADDLW       8
	MOVWF       FARG_MCP3202_GET_AD_Spi_Channel+0 
	MOVLW       160
	MOVWF       FARG_MCP3202_GET_AD_Spi_AD_CMD+0 
	MOVLW       100
	MOVWF       FARG_MCP3202_GET_AD_NumOfSample+0 
	CALL        _MCP3202_GET_AD+0, 0
	MOVF        R0, 0 
	MOVWF       SPCCalibration_ADBuff_L0+0 
	MOVF        R1, 0 
	MOVWF       SPCCalibration_ADBuff_L0+1 
;Calibration.c,265 :: 		ADBuff = ConvertADtoTEMP(ADBuff, CALI_RTDB_50, CALI_RTDB_500, 0);
	MOVF        R0, 0 
	MOVWF       FARG_ConvertADtoTEMP_ADtemp+0 
	MOVF        R1, 0 
	MOVWF       FARG_ConvertADtoTEMP_ADtemp+1 
	MOVLW       2
	MOVWF       FARG_ConvertADtoTEMP_paraL+0 
	MOVLW       3
	MOVWF       FARG_ConvertADtoTEMP_paraH+0 
	CLRF        FARG_ConvertADtoTEMP_ChannelNum+0 
	CALL        _ConvertADtoTEMP+0, 0
	MOVF        R0, 0 
	MOVWF       SPCCalibration_ADBuff_L0+0 
	MOVF        R1, 0 
	MOVWF       SPCCalibration_ADBuff_L0+1 
;Calibration.c,266 :: 		SPCCalibrationBox.CalibartionType = 25;
	MOVLW       25
	MOVWF       _SPCCalibrationBox+0 
;Calibration.c,267 :: 		SetModbusTxData(ADBuff);
	MOVF        R0, 0 
	MOVWF       FARG_SetModbusTxData_TransData+0 
	MOVF        R1, 0 
	MOVWF       FARG_SetModbusTxData_TransData+1 
	CALL        _SetModbusTxData+0, 0
;Calibration.c,268 :: 		modbus_respond();
	CALL        _modbus_respond+0, 0
;Calibration.c,269 :: 		break;
	GOTO        L_SPCCalibration19
;Calibration.c,270 :: 		case 7:  //current test
L_SPCCalibration37:
;Calibration.c,271 :: 		if(CalibrationCommand[CURRENT_CALIBRATION_STEP] == 0)
	MOVF        _CalibrationCommand+3, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_SPCCalibration38
;Calibration.c,273 :: 		WaitForValue(CURRENT_LOW);
	MOVLW       1
	MOVWF       FARG_WaitForValue_LowValueType+0 
	CALL        _WaitForValue+0, 0
;Calibration.c,274 :: 		SetModbusTxData(0);
	CLRF        FARG_SetModbusTxData_TransData+0 
	CLRF        FARG_SetModbusTxData_TransData+1 
	CALL        _SetModbusTxData+0, 0
;Calibration.c,275 :: 		}
	GOTO        L_SPCCalibration39
L_SPCCalibration38:
;Calibration.c,278 :: 		Delay_ms(600);
	MOVLW       16
	MOVWF       R11, 0
	MOVLW       57
	MOVWF       R12, 0
	MOVLW       13
	MOVWF       R13, 0
L_SPCCalibration40:
	DECFSZ      R13, 1, 1
	BRA         L_SPCCalibration40
	DECFSZ      R12, 1, 1
	BRA         L_SPCCalibration40
	DECFSZ      R11, 1, 1
	BRA         L_SPCCalibration40
	NOP
	NOP
;Calibration.c,279 :: 		ADBuff = MeasureCG(GETCURRENTFORCALIBRATION);
	MOVLW       1
	MOVWF       FARG_MeasureCG_CalibrateCGCmd+0 
	CALL        _MeasureCG+0, 0
	MOVF        R0, 0 
	MOVWF       SPCCalibration_ADBuff_L0+0 
	MOVF        R1, 0 
	MOVWF       SPCCalibration_ADBuff_L0+1 
;Calibration.c,280 :: 		ADBuff = ConvertADtoCurrent(ADBuff,0);
	MOVF        R0, 0 
	MOVWF       FARG_ConvertADtoCurrent_ADcurrent+0 
	MOVF        R1, 0 
	MOVWF       FARG_ConvertADtoCurrent_ADcurrent+1 
	CLRF        FARG_ConvertADtoCurrent_ChannelNum+0 
	CALL        _ConvertADtoCurrent+0, 0
	MOVF        R0, 0 
	MOVWF       SPCCalibration_ADBuff_L0+0 
	MOVF        R1, 0 
	MOVWF       SPCCalibration_ADBuff_L0+1 
;Calibration.c,281 :: 		SetModbusTxData(ADBuff*10);
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_SetModbusTxData_TransData+0 
	MOVF        R1, 0 
	MOVWF       FARG_SetModbusTxData_TransData+1 
	CALL        _SetModbusTxData+0, 0
;Calibration.c,282 :: 		}
L_SPCCalibration39:
;Calibration.c,283 :: 		CalibrationCommand[CURRENT_CALIBRATION_STEP] ^= 1;
	BTG         _CalibrationCommand+3, 0 
;Calibration.c,284 :: 		SPCCalibrationBox.CalibartionType = 25;
	MOVLW       25
	MOVWF       _SPCCalibrationBox+0 
;Calibration.c,285 :: 		modbus_respond();
	CALL        _modbus_respond+0, 0
;Calibration.c,286 :: 		break;
	GOTO        L_SPCCalibration19
;Calibration.c,287 :: 		case 8:  //gfi test
L_SPCCalibration41:
;Calibration.c,288 :: 		if(CalibrationCommand[GFI_CALIBRATION_STEP] == 0)
	MOVF        _CalibrationCommand+4, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_SPCCalibration42
;Calibration.c,290 :: 		WaitForValue(GFI_LOW);
	CLRF        FARG_WaitForValue_LowValueType+0 
	CALL        _WaitForValue+0, 0
;Calibration.c,291 :: 		SetModbusTxData(0);
	CLRF        FARG_SetModbusTxData_TransData+0 
	CLRF        FARG_SetModbusTxData_TransData+1 
	CALL        _SetModbusTxData+0, 0
;Calibration.c,292 :: 		}
	GOTO        L_SPCCalibration43
L_SPCCalibration42:
;Calibration.c,295 :: 		Delay_ms(600);
	MOVLW       16
	MOVWF       R11, 0
	MOVLW       57
	MOVWF       R12, 0
	MOVLW       13
	MOVWF       R13, 0
L_SPCCalibration44:
	DECFSZ      R13, 1, 1
	BRA         L_SPCCalibration44
	DECFSZ      R12, 1, 1
	BRA         L_SPCCalibration44
	DECFSZ      R11, 1, 1
	BRA         L_SPCCalibration44
	NOP
	NOP
;Calibration.c,296 :: 		ADBuff = MeasureCG(GETGFIFORCALIBRATION);
	CLRF        FARG_MeasureCG_CalibrateCGCmd+0 
	CALL        _MeasureCG+0, 0
	MOVF        R0, 0 
	MOVWF       SPCCalibration_ADBuff_L0+0 
	MOVF        R1, 0 
	MOVWF       SPCCalibration_ADBuff_L0+1 
;Calibration.c,297 :: 		ADBuff = ConvertADtoGFI(ADBuff, 0);
	MOVF        R0, 0 
	MOVWF       FARG_ConvertADtoGFI_ADcurrent+0 
	MOVF        R1, 0 
	MOVWF       FARG_ConvertADtoGFI_ADcurrent+1 
	CLRF        FARG_ConvertADtoGFI_ChannelNum+0 
	CALL        _ConvertADtoGFI+0, 0
	MOVF        R0, 0 
	MOVWF       SPCCalibration_ADBuff_L0+0 
	MOVF        R1, 0 
	MOVWF       SPCCalibration_ADBuff_L0+1 
;Calibration.c,298 :: 		SetModbusTxData(ADBuff*10);
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_SetModbusTxData_TransData+0 
	MOVF        R1, 0 
	MOVWF       FARG_SetModbusTxData_TransData+1 
	CALL        _SetModbusTxData+0, 0
;Calibration.c,299 :: 		}
L_SPCCalibration43:
;Calibration.c,300 :: 		CalibrationCommand[GFI_CALIBRATION_STEP] ^= 1;
	BTG         _CalibrationCommand+4, 0 
;Calibration.c,301 :: 		SPCCalibrationBox.CalibartionType = 25;
	MOVLW       25
	MOVWF       _SPCCalibrationBox+0 
;Calibration.c,302 :: 		modbus_respond();
	CALL        _modbus_respond+0, 0
;Calibration.c,303 :: 		break;
	GOTO        L_SPCCalibration19
;Calibration.c,304 :: 		case 9:  //SSR test
L_SPCCalibration45:
;Calibration.c,305 :: 		LATC2_bit = 1;
	BSF         LATC2_bit+0, BitPos(LATC2_bit+0) 
;Calibration.c,306 :: 		Delay_ms(600);
	MOVLW       16
	MOVWF       R11, 0
	MOVLW       57
	MOVWF       R12, 0
	MOVLW       13
	MOVWF       R13, 0
L_SPCCalibration46:
	DECFSZ      R13, 1, 1
	BRA         L_SPCCalibration46
	DECFSZ      R12, 1, 1
	BRA         L_SPCCalibration46
	DECFSZ      R11, 1, 1
	BRA         L_SPCCalibration46
	NOP
	NOP
;Calibration.c,307 :: 		ADBuff = MeasureCG(GETCURRENTFORCALIBRATION);
	MOVLW       1
	MOVWF       FARG_MeasureCG_CalibrateCGCmd+0 
	CALL        _MeasureCG+0, 0
	MOVF        R0, 0 
	MOVWF       SPCCalibration_ADBuff_L0+0 
	MOVF        R1, 0 
	MOVWF       SPCCalibration_ADBuff_L0+1 
;Calibration.c,308 :: 		ADBuff = ConvertADtoCurrent(ADBuff,0);
	MOVF        R0, 0 
	MOVWF       FARG_ConvertADtoCurrent_ADcurrent+0 
	MOVF        R1, 0 
	MOVWF       FARG_ConvertADtoCurrent_ADcurrent+1 
	CLRF        FARG_ConvertADtoCurrent_ChannelNum+0 
	CALL        _ConvertADtoCurrent+0, 0
	MOVF        R0, 0 
	MOVWF       SPCCalibration_ADBuff_L0+0 
	MOVF        R1, 0 
	MOVWF       SPCCalibration_ADBuff_L0+1 
;Calibration.c,309 :: 		SetModbusTxData(ADBuff*10);
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_SetModbusTxData_TransData+0 
	MOVF        R1, 0 
	MOVWF       FARG_SetModbusTxData_TransData+1 
	CALL        _SetModbusTxData+0, 0
;Calibration.c,310 :: 		LATC2_bit = 0;
	BCF         LATC2_bit+0, BitPos(LATC2_bit+0) 
;Calibration.c,311 :: 		SPCCalibrationBox.CalibartionType = 25;
	MOVLW       25
	MOVWF       _SPCCalibrationBox+0 
;Calibration.c,312 :: 		modbus_respond();
	CALL        _modbus_respond+0, 0
;Calibration.c,313 :: 		break;
	GOTO        L_SPCCalibration19
;Calibration.c,314 :: 		case 10:
L_SPCCalibration47:
;Calibration.c,315 :: 		LATB4_bit = 1;
	BSF         LATB4_bit+0, BitPos(LATB4_bit+0) 
;Calibration.c,316 :: 		LATB5_bit = 1;
	BSF         LATB5_bit+0, BitPos(LATB5_bit+0) 
;Calibration.c,317 :: 		ADBuff = 0;
	CLRF        SPCCalibration_ADBuff_L0+0 
	CLRF        SPCCalibration_ADBuff_L0+1 
;Calibration.c,318 :: 		SPCCalibrationBox.CalibartionType = 25;
	MOVLW       25
	MOVWF       _SPCCalibrationBox+0 
;Calibration.c,319 :: 		SetModbusTxData(ADBuff);
	CLRF        FARG_SetModbusTxData_TransData+0 
	CLRF        FARG_SetModbusTxData_TransData+1 
	CALL        _SetModbusTxData+0, 0
;Calibration.c,320 :: 		modbus_respond();
	CALL        _modbus_respond+0, 0
;Calibration.c,321 :: 		Delay_ms(600);
	MOVLW       16
	MOVWF       R11, 0
	MOVLW       57
	MOVWF       R12, 0
	MOVLW       13
	MOVWF       R13, 0
L_SPCCalibration48:
	DECFSZ      R13, 1, 1
	BRA         L_SPCCalibration48
	DECFSZ      R12, 1, 1
	BRA         L_SPCCalibration48
	DECFSZ      R11, 1, 1
	BRA         L_SPCCalibration48
	NOP
	NOP
;Calibration.c,322 :: 		LATB4_bit = 0;
	BCF         LATB4_bit+0, BitPos(LATB4_bit+0) 
;Calibration.c,323 :: 		LATB5_bit = 0;
	BCF         LATB5_bit+0, BitPos(LATB5_bit+0) 
;Calibration.c,324 :: 		break;
	GOTO        L_SPCCalibration19
;Calibration.c,325 :: 		case 11:
L_SPCCalibration49:
;Calibration.c,326 :: 		Delay_ms(600);
	MOVLW       16
	MOVWF       R11, 0
	MOVLW       57
	MOVWF       R12, 0
	MOVLW       13
	MOVWF       R13, 0
L_SPCCalibration50:
	DECFSZ      R13, 1, 1
	BRA         L_SPCCalibration50
	DECFSZ      R12, 1, 1
	BRA         L_SPCCalibration50
	DECFSZ      R11, 1, 1
	BRA         L_SPCCalibration50
	NOP
	NOP
;Calibration.c,327 :: 		ADBuff = RB3_bit;
	MOVLW       0
	BTFSC       RB3_bit+0, BitPos(RB3_bit+0) 
	MOVLW       1
	MOVWF       SPCCalibration_ADBuff_L0+0 
	CLRF        SPCCalibration_ADBuff_L0+1 
;Calibration.c,328 :: 		SPCCalibrationBox.CalibartionType = 25;
	MOVLW       25
	MOVWF       _SPCCalibrationBox+0 
;Calibration.c,329 :: 		SetModbusTxData(ADBuff);
	MOVF        SPCCalibration_ADBuff_L0+0, 0 
	MOVWF       FARG_SetModbusTxData_TransData+0 
	MOVF        SPCCalibration_ADBuff_L0+1, 0 
	MOVWF       FARG_SetModbusTxData_TransData+1 
	CALL        _SetModbusTxData+0, 0
;Calibration.c,330 :: 		modbus_respond();
	CALL        _modbus_respond+0, 0
;Calibration.c,331 :: 		break;
	GOTO        L_SPCCalibration19
;Calibration.c,332 :: 		case 12:  //finish cali
L_SPCCalibration51:
;Calibration.c,333 :: 		getParaChar(Info_Line1, NEED_TESTING_STR);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       93
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Calibration.c,334 :: 		getParaChar(Info_Line2, BLANK_STR);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       39
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Calibration.c,335 :: 		EEPROM_set(0x300,sizeof(SPCCALIBRATIONREG)*30,(UCHAR*)&SPCCalibrationStructure[0]);
	MOVLW       0
	MOVWF       FARG_EEPROM_set_EEPROM_WRITE_ADDRESS+0 
	MOVLW       3
	MOVWF       FARG_EEPROM_set_EEPROM_WRITE_ADDRESS+1 
	MOVLW       120
	MOVWF       FARG_EEPROM_set_Len+0 
	MOVLW       _SPCCalibrationStructure+0
	MOVWF       FARG_EEPROM_set_writebuffer+0 
	MOVLW       hi_addr(_SPCCalibrationStructure+0)
	MOVWF       FARG_EEPROM_set_writebuffer+1 
	CALL        _EEPROM_set+0, 0
;Calibration.c,336 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
;Calibration.c,337 :: 		SPCCalibrationBox.CalibartionType = 25;
	MOVLW       25
	MOVWF       _SPCCalibrationBox+0 
;Calibration.c,338 :: 		SetModbusTxData(0);
	CLRF        FARG_SetModbusTxData_TransData+0 
	CLRF        FARG_SetModbusTxData_TransData+1 
	CALL        _SetModbusTxData+0, 0
;Calibration.c,339 :: 		modbus_respond();
	CALL        _modbus_respond+0, 0
;Calibration.c,340 :: 		break;
	GOTO        L_SPCCalibration19
;Calibration.c,341 :: 		case 13:  //start test
L_SPCCalibration52:
;Calibration.c,342 :: 		getParaChar(Info_Line1, NOW_TESTING_STR);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       94
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Calibration.c,343 :: 		getParaChar(Info_Line2, BLANK_STR);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       39
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Calibration.c,344 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
;Calibration.c,345 :: 		SPCCalibrationBox.CalibartionType = 25;
	MOVLW       25
	MOVWF       _SPCCalibrationBox+0 
;Calibration.c,346 :: 		SetModbusTxData(0);
	CLRF        FARG_SetModbusTxData_TransData+0 
	CLRF        FARG_SetModbusTxData_TransData+1 
	CALL        _SetModbusTxData+0, 0
;Calibration.c,347 :: 		modbus_respond();
	CALL        _modbus_respond+0, 0
;Calibration.c,348 :: 		break;
	GOTO        L_SPCCalibration19
;Calibration.c,349 :: 		case 14:
L_SPCCalibration53:
;Calibration.c,350 :: 		SPCTestingEN = 0;
	CLRF        _SPCTestingEN+0 
;Calibration.c,351 :: 		SPCCalibrationEN = 0;
	CLRF        _SPCCalibrationEN+0 
;Calibration.c,352 :: 		EEPROM_set(0x2f1, 1, (char*)&SPCTestingEN);
	MOVLW       241
	MOVWF       FARG_EEPROM_set_EEPROM_WRITE_ADDRESS+0 
	MOVLW       2
	MOVWF       FARG_EEPROM_set_EEPROM_WRITE_ADDRESS+1 
	MOVLW       1
	MOVWF       FARG_EEPROM_set_Len+0 
	MOVLW       _SPCTestingEN+0
	MOVWF       FARG_EEPROM_set_writebuffer+0 
	MOVLW       hi_addr(_SPCTestingEN+0)
	MOVWF       FARG_EEPROM_set_writebuffer+1 
	CALL        _EEPROM_set+0, 0
;Calibration.c,353 :: 		EEPROM_set(0x2f0, 1, (char*)&SPCCalibrationEN);
	MOVLW       240
	MOVWF       FARG_EEPROM_set_EEPROM_WRITE_ADDRESS+0 
	MOVLW       2
	MOVWF       FARG_EEPROM_set_EEPROM_WRITE_ADDRESS+1 
	MOVLW       1
	MOVWF       FARG_EEPROM_set_Len+0 
	MOVLW       _SPCCalibrationEN+0
	MOVWF       FARG_EEPROM_set_writebuffer+0 
	MOVLW       hi_addr(_SPCCalibrationEN+0)
	MOVWF       FARG_EEPROM_set_writebuffer+1 
	CALL        _EEPROM_set+0, 0
;Calibration.c,354 :: 		SetModbusTxData(0);
	CLRF        FARG_SetModbusTxData_TransData+0 
	CLRF        FARG_SetModbusTxData_TransData+1 
	CALL        _SetModbusTxData+0, 0
;Calibration.c,355 :: 		modbus_respond();
	CALL        _modbus_respond+0, 0
;Calibration.c,356 :: 		break;
	GOTO        L_SPCCalibration19
;Calibration.c,357 :: 		default:
L_SPCCalibration54:
;Calibration.c,358 :: 		break;
	GOTO        L_SPCCalibration19
;Calibration.c,359 :: 		}
L_SPCCalibration18:
	MOVF        _SPCCalibrationBox+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCCalibration20
	MOVF        _SPCCalibrationBox+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCCalibration21
	MOVF        _SPCCalibrationBox+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCCalibration23
	MOVF        _SPCCalibrationBox+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCCalibration25
	MOVF        _SPCCalibrationBox+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCCalibration29
	MOVF        _SPCCalibrationBox+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCCalibration33
	MOVF        _SPCCalibrationBox+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCCalibration35
	MOVF        _SPCCalibrationBox+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCCalibration37
	MOVF        _SPCCalibrationBox+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCCalibration41
	MOVF        _SPCCalibrationBox+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCCalibration45
	MOVF        _SPCCalibrationBox+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCCalibration47
	MOVF        _SPCCalibrationBox+0, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCCalibration49
	MOVF        _SPCCalibrationBox+0, 0 
	XORLW       12
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCCalibration51
	MOVF        _SPCCalibrationBox+0, 0 
	XORLW       13
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCCalibration52
	MOVF        _SPCCalibrationBox+0, 0 
	XORLW       14
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCCalibration53
	GOTO        L_SPCCalibration54
L_SPCCalibration19:
;Calibration.c,360 :: 		}
	GOTO        L_SPCCalibration16
L_SPCCalibration17:
;Calibration.c,363 :: 		if(SPCTestingEN == 0)
	MOVF        _SPCTestingEN+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_SPCCalibration55
;Calibration.c,364 :: 		return;
	GOTO        L_end_SPCCalibration
L_SPCCalibration55:
;Calibration.c,369 :: 		}
L_end_SPCCalibration:
	RETURN      0
; end of _SPCCalibration

_InitialCalibrationReg:

;Calibration.c,371 :: 		void InitialCalibrationReg()
;Calibration.c,376 :: 		Ptr = (signed int *)&SPCCalibrationStructure[0];
	MOVLW       _SPCCalibrationStructure+0
	MOVWF       R4 
	MOVLW       hi_addr(_SPCCalibrationStructure+0)
	MOVWF       R5 
;Calibration.c,377 :: 		for(i=0;i<60;i++)
	CLRF        R6 
L_InitialCalibrationReg57:
	MOVLW       60
	SUBWF       R6, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_InitialCalibrationReg58
;Calibration.c,379 :: 		*(Ptr+i) = ConstCalibrationBuff[i];
	MOVF        R6, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       R4, 0 
	MOVWF       FSR1 
	MOVF        R1, 0 
	ADDWFC      R5, 0 
	MOVWF       FSR1H 
	MOVLW       0
	MOVWF       R2 
	MOVWF       R3 
	MOVLW       _ConstCalibrationBuff+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_ConstCalibrationBuff+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(_ConstCalibrationBuff+0)
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
;Calibration.c,377 :: 		for(i=0;i<60;i++)
	INCF        R6, 1 
;Calibration.c,380 :: 		}
	GOTO        L_InitialCalibrationReg57
L_InitialCalibrationReg58:
;Calibration.c,381 :: 		}
L_end_InitialCalibrationReg:
	RETURN      0
; end of _InitialCalibrationReg
