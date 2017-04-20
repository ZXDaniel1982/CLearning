
_CheckError:

;SPC code.c,88 :: 		char CheckError()
;SPC code.c,90 :: 		if(ActivedAlarms)
	MOVF        _ActivedAlarms+0, 0 
	IORWF       _ActivedAlarms+1, 0 
	IORWF       _ActivedAlarms+2, 0 
	IORWF       _ActivedAlarms+3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_CheckError0
;SPC code.c,91 :: 		ACheck = ActivedAlarms;
	MOVF        _ActivedAlarms+0, 0 
	MOVWF       _ACheck+0 
	MOVF        _ActivedAlarms+1, 0 
	MOVWF       _ACheck+1 
	MOVF        _ActivedAlarms+2, 0 
	MOVWF       _ACheck+2 
	MOVF        _ActivedAlarms+3, 0 
	MOVWF       _ACheck+3 
	GOTO        L_CheckError1
L_CheckError0:
;SPC code.c,94 :: 		if(ACheck)
	MOVF        _ACheck+0, 0 
	IORWF       _ACheck+1, 0 
	IORWF       _ACheck+2, 0 
	IORWF       _ACheck+3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_CheckError2
;SPC code.c,96 :: 		ACheck = 0;
	CLRF        _ACheck+0 
	CLRF        _ACheck+1 
	CLRF        _ACheck+2 
	CLRF        _ACheck+3 
;SPC code.c,97 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_CheckError
;SPC code.c,98 :: 		}
L_CheckError2:
;SPC code.c,99 :: 		}
L_CheckError1:
;SPC code.c,101 :: 		return 0;
	CLRF        R0 
;SPC code.c,102 :: 		}
L_end_CheckError:
	RETURN      0
; end of _CheckError

_main:

;SPC code.c,104 :: 		void main()
;SPC code.c,106 :: 		GlobalInterrupt_diable();                  //disable interrupt
	CALL        _GlobalInterrupt_diable+0, 0
;SPC code.c,107 :: 		SPCSystemInitialize();
	CALL        _SPCSystemInitialize+0, 0
;SPC code.c,108 :: 		SPC_Initial();
	CALL        _SPC_Initial+0, 0
;SPC code.c,109 :: 		selftest();                                //selftest for now
	CALL        _selftest+0, 0
;SPC code.c,110 :: 		GlobalInterrupt_enable();                  //enable interrupt
	CALL        _GlobalInterrupt_enable+0, 0
;SPC code.c,112 :: 		spc_system_flag.bite.default_diaped = 1;   //initial to display default information
	BSF         _spc_system_flag+1, 2 
;SPC code.c,113 :: 		spc_system_flag.bite.stat_update = 1;      //show system stat information
	BSF         _spc_system_flag+3, 7 
;SPC code.c,114 :: 		Menustat = 0;
	CLRF        _Menustat+0 
;SPC code.c,116 :: 		SelfCheck();
	CALL        _SelfCheck+0, 0
;SPC code.c,118 :: 		asm nop;
	NOP
;SPC code.c,122 :: 		freqency = 60;              //set the frequency to 60Hz
	MOVLW       60
	MOVWF       _freqency+0 
	MOVLW       0
	MOVWF       _freqency+1 
;SPC code.c,124 :: 		freq_pori = 83;             //make a counter for 8.33ms
	MOVLW       83
	MOVWF       _freq_pori+0 
	MOVLW       0
	MOVWF       _freq_pori+1 
;SPC code.c,145 :: 		InitialCalibrationReg();
	CALL        _InitialCalibrationReg+0, 0
;SPC code.c,148 :: 		while(1)
L_main3:
;SPC code.c,150 :: 		if((spc_system_flag.bite.keypushed == KEYPUSH) && (LCDext==0))
	BTFSS       _spc_system_flag+0, 0 
	GOTO        L_main7
	MOVF        _LCDext+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main7
L__main82:
;SPC code.c,153 :: 		spc_system_flag.bite.keypushed = KEYIDEL;
	BCF         _spc_system_flag+0, 0 
;SPC code.c,154 :: 		SPCMenuOperation();
	CALL        _SPCMenuOperation+0, 0
;SPC code.c,155 :: 		}
L_main7:
;SPC code.c,159 :: 		if(bUpdate)
	MOVF        _bUpdate+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main8
;SPC code.c,162 :: 		bUpdate = 0;
	CLRF        _bUpdate+0 
;SPC code.c,164 :: 		if(SpcMenu[Menustat].func_mark == FUNC_HEATID)
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
	MOVLW       SPC_32code_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(SPC_32code_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(SPC_32code_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       4
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R1
	MOVF        R1, 0 
	XORLW       36
	BTFSS       STATUS+0, 2 
	GOTO        L_main9
;SPC code.c,166 :: 		spc_system_flag.bite.char_flash = 1;
	BSF         _spc_system_flag+3, 6 
;SPC code.c,167 :: 		char_flash_loca = 1;
	MOVLW       1
	MOVWF       _char_flash_loca+0 
;SPC code.c,168 :: 		}
L_main9:
;SPC code.c,170 :: 		CopyStr(Info_Line1_shape, Info_Line1, 16);
	MOVLW       _Info_Line1_shape+0
	MOVWF       FARG_CopyStr_resource+0 
	MOVLW       hi_addr(_Info_Line1_shape+0)
	MOVWF       FARG_CopyStr_resource+1 
	MOVLW       _Info_Line1+0
	MOVWF       FARG_CopyStr_target+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_CopyStr_target+1 
	MOVLW       16
	MOVWF       FARG_CopyStr_len+0 
	CALL        _CopyStr+0, 0
;SPC code.c,171 :: 		CopyStr(Info_Line2_shape, Info_Line2, 16);
	MOVLW       _Info_Line2_shape+0
	MOVWF       FARG_CopyStr_resource+0 
	MOVLW       hi_addr(_Info_Line2_shape+0)
	MOVWF       FARG_CopyStr_resource+1 
	MOVLW       _Info_Line2+0
	MOVWF       FARG_CopyStr_target+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_CopyStr_target+1 
	MOVLW       16
	MOVWF       FARG_CopyStr_len+0 
	CALL        _CopyStr+0, 0
;SPC code.c,172 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
;SPC code.c,173 :: 		}
L_main8:
;SPC code.c,177 :: 		disp_default();
	CALL        _disp_default+0, 0
;SPC code.c,182 :: 		if(spc_system_flag.bite.flashing_reach == 1)
	BTFSS       _spc_system_flag+2, 0 
	GOTO        L_main10
;SPC code.c,184 :: 		spc_system_flag.bite.flashing_reach = 0;
	BCF         _spc_system_flag+2, 0 
;SPC code.c,185 :: 		Flashing();
	CALL        _Flashing+0, 0
;SPC code.c,186 :: 		}
L_main10:
;SPC code.c,190 :: 		if(spc_system_flag.bite.meas_VT_reach)
	MOVLW       6
	ANDWF       _spc_system_flag+0, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	BCF         R1, 7 
	MOVF        R1, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main11
;SPC code.c,192 :: 		VTProcess();          //measure the voltage and temperature
	CALL        _VTProcess+0, 0
;SPC code.c,193 :: 		}
L_main11:
;SPC code.c,198 :: 		RollCharact();
	CALL        _RollCharact+0, 0
;SPC code.c,202 :: 		CGProcess(CHANNEL1);            //measure the current and GFI
	CLRF        FARG_CGProcess_ChannelNum+0 
	CALL        _CGProcess+0, 0
;SPC code.c,204 :: 		CGProcess(CHANNEL2);
	MOVLW       1
	MOVWF       FARG_CGProcess_ChannelNum+0 
	CALL        _CGProcess+0, 0
;SPC code.c,206 :: 		Timeprocess();          //update the running time
	CALL        _Timeprocess+0, 0
;SPC code.c,208 :: 		enegy_acc();            //measure the enegy and cost
	CALL        _enegy_acc+0, 0
;SPC code.c,210 :: 		systemtest(CHANNEL1);           //system test function
	CLRF        FARG_systemtest_ChannelNum+0 
	CALL        _systemtest+0, 0
;SPC code.c,212 :: 		systemtest(CHANNEL2);
	MOVLW       1
	MOVWF       FARG_systemtest_ChannelNum+0 
	CALL        _systemtest+0, 0
;SPC code.c,214 :: 		manual(CHANNEL1);               //override operation
	CLRF        FARG_manual_ChannelNum+0 
	CALL        _manual+0, 0
;SPC code.c,216 :: 		manual(CHANNEL2);               //override operation
	MOVLW       1
	MOVWF       FARG_manual_ChannelNum+0 
	CALL        _manual+0, 0
;SPC code.c,218 :: 		dispupdate();           //update the lcd screen
	CALL        _dispupdate+0, 0
;SPC code.c,220 :: 		alarmdispupdate();      //update the alarm information
	CALL        _alarmdispupdate+0, 0
;SPC code.c,222 :: 		RSSoperation(CHANNEL1);         //relay operation
	CLRF        FARG_RSSoperation_ChannelNum+0 
	CALL        _RSSoperation+0, 0
;SPC code.c,224 :: 		RSSoperation(CHANNEL2);         //relay operation
	MOVLW       1
	MOVWF       FARG_RSSoperation_ChannelNum+0 
	CALL        _RSSoperation+0, 0
;SPC code.c,226 :: 		AlarmSSRoperation();    //alarm relay operation
	CALL        _AlarmSSRoperation+0, 0
;SPC code.c,228 :: 		AlarmLedOperation();
	CALL        _AlarmLedOperation+0, 0
;SPC code.c,230 :: 		ActivateHighCurrentAlarm(0);
	CLRF        FARG_ActivateHighCurrentAlarm_ChannelNum+0 
	CALL        _ActivateHighCurrentAlarm+0, 0
;SPC code.c,232 :: 		modbusprocess();
	CALL        _modbusprocess+0, 0
;SPC code.c,234 :: 		ConflictCorrection();
	CALL        _ConflictCorrection+0, 0
;SPC code.c,236 :: 		AutoAutho();
	CALL        _AutoAutho+0, 0
;SPC code.c,239 :: 		if(KeyResetEN)
	MOVF        _KeyResetEN+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main12
;SPC code.c,241 :: 		KeyResetEN = 0;
	CLRF        _KeyResetEN+0 
;SPC code.c,242 :: 		QT60Reset();
	CALL        _QT60Reset+0, 0
;SPC code.c,243 :: 		}
L_main12:
;SPC code.c,246 :: 		}
	GOTO        L_main3
;SPC code.c,247 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_Tcount:

;SPC code.c,249 :: 		void Tcount(SPCTIME *time ,char cmd)
;SPC code.c,253 :: 		if(time->second++ > DELAY_M)
	MOVFF       FARG_Tcount_time+0, FSR0
	MOVFF       FARG_Tcount_time+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVFF       FARG_Tcount_time+0, FSR1
	MOVFF       FARG_Tcount_time+1, FSR1H
	MOVF        R1, 0 
	ADDLW       1
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	SUBLW       60
	BTFSC       STATUS+0, 0 
	GOTO        L_Tcount13
;SPC code.c,255 :: 		time->second = 0;
	MOVFF       FARG_Tcount_time+0, FSR1
	MOVFF       FARG_Tcount_time+1, FSR1H
	CLRF        POSTINC1+0 
;SPC code.c,256 :: 		if(cmd == 0)
	MOVF        FARG_Tcount_cmd+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Tcount14
;SPC code.c,258 :: 		DataUpdate |= (CH1_ONTIME_UPDATE_PERCENT_REQ+CH2_ONTIME_UPDATE_PERCENT_REQ);
	MOVLW       12
	IORWF       _DataUpdate+0, 1 
	MOVLW       0
	IORWF       _DataUpdate+1, 1 
;SPC code.c,260 :: 		if(KeyResetCount++ > 5)
	MOVF        _KeyResetCount+0, 0 
	MOVWF       R1 
	MOVF        _KeyResetCount+1, 0 
	MOVWF       R2 
	INFSNZ      _KeyResetCount+0, 1 
	INCF        _KeyResetCount+1, 1 
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Tcount87
	MOVF        R1, 0 
	SUBLW       5
L__Tcount87:
	BTFSC       STATUS+0, 0 
	GOTO        L_Tcount15
;SPC code.c,262 :: 		KeyResetCount = 0;
	CLRF        _KeyResetCount+0 
	CLRF        _KeyResetCount+1 
;SPC code.c,263 :: 		KeyResetEN = 1;
	MOVLW       1
	MOVWF       _KeyResetEN+0 
;SPC code.c,264 :: 		}
L_Tcount15:
;SPC code.c,266 :: 		if(GetAutoAutho() == 1)
	CALL        _GetAutoAutho+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Tcount16
;SPC code.c,268 :: 		AutoAuthoCount++;
	INCF        _AutoAuthoCount+0, 1 
;SPC code.c,269 :: 		if(AutoAuthoCount >= 15)
	MOVLW       15
	SUBWF       _AutoAuthoCount+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_Tcount17
;SPC code.c,271 :: 		AutoAuthoCount = 0;
	CLRF        _AutoAuthoCount+0 
;SPC code.c,272 :: 		SetAutoAutho(2);
	MOVLW       2
	MOVWF       FARG_SetAutoAutho_AutoAuthoCmd+0 
	CALL        _SetAutoAutho+0, 0
;SPC code.c,273 :: 		}
L_Tcount17:
;SPC code.c,274 :: 		}
L_Tcount16:
;SPC code.c,275 :: 		}
L_Tcount14:
;SPC code.c,277 :: 		if(time->minute++ > DELAY_H)
	MOVLW       1
	ADDWF       FARG_Tcount_time+0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      FARG_Tcount_time+1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	ADDLW       1
	MOVWF       R0 
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	SUBLW       60
	BTFSC       STATUS+0, 0 
	GOTO        L_Tcount18
;SPC code.c,281 :: 		time->minute = 0;
	MOVLW       1
	ADDWF       FARG_Tcount_time+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_Tcount_time+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;SPC code.c,282 :: 		if(time->hour < 0xffffffff)
	MOVLW       2
	ADDWF       FARG_Tcount_time+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Tcount_time+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       255
	SUBWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Tcount88
	MOVLW       255
	SUBWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Tcount88
	MOVLW       255
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Tcount88
	MOVLW       255
	SUBWF       R1, 0 
L__Tcount88:
	BTFSC       STATUS+0, 0 
	GOTO        L_Tcount19
;SPC code.c,283 :: 		time->hour++;
	MOVLW       2
	ADDWF       FARG_Tcount_time+0, 0 
	MOVWF       R4 
	MOVLW       0
	ADDWFC      FARG_Tcount_time+1, 0 
	MOVWF       R5 
	MOVFF       R4, FSR0
	MOVFF       R5, FSR0H
	MOVLW       1
	ADDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
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
L_Tcount19:
;SPC code.c,285 :: 		if(cmd)
	MOVF        FARG_Tcount_cmd+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Tcount20
;SPC code.c,287 :: 		if(time->hour < 1000000)
	MOVLW       2
	ADDWF       FARG_Tcount_time+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Tcount_time+1, 0 
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
	SUBWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Tcount89
	MOVLW       15
	SUBWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Tcount89
	MOVLW       66
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Tcount89
	MOVLW       64
	SUBWF       R1, 0 
L__Tcount89:
	BTFSC       STATUS+0, 0 
	GOTO        L_Tcount21
;SPC code.c,288 :: 		pSPCValue[cmd-1].SPCStatistics.RunTime = time->hour;
	DECF        FARG_Tcount_cmd+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       142
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
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       2
	ADDWF       FARG_Tcount_time+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Tcount_time+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	GOTO        L_Tcount22
L_Tcount21:
;SPC code.c,290 :: 		pSPCValue[cmd-1].SPCStatistics.RunTime = ONTIMEOUTOFRANGE;
	DECF        FARG_Tcount_cmd+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       142
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
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       96
	MOVWF       POSTINC1+0 
	MOVLW       227
	MOVWF       POSTINC1+0 
	MOVLW       22
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
L_Tcount22:
;SPC code.c,292 :: 		DataUpdate |= (CH1_ONTIME_UPDATE_REQ << (cmd-1));
	DECF        FARG_Tcount_cmd+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
	MOVWF       R2 
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
L__Tcount90:
	BZ          L__Tcount91
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__Tcount90
L__Tcount91:
	MOVF        R0, 0 
	IORWF       _DataUpdate+0, 1 
	MOVF        R1, 0 
	IORWF       _DataUpdate+1, 1 
;SPC code.c,293 :: 		}
L_Tcount20:
;SPC code.c,295 :: 		if(cmd == 0)
	MOVF        FARG_Tcount_cmd+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Tcount23
;SPC code.c,297 :: 		for(i=0;i<2;i++)
	CLRF        Tcount_i_L0+0 
L_Tcount24:
	MOVLW       2
	SUBWF       Tcount_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Tcount25
;SPC code.c,299 :: 		if(HeaterTestCmd[i] == 1)                      //(spc_system_flag.bite.heatest_req)
	MOVLW       _HeaterTestCmd+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_HeaterTestCmd+0)
	MOVWF       FSR0H 
	MOVF        Tcount_i_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Tcount27
;SPC code.c,301 :: 		if(HeaterTestCount[i]++ >= pSPCValue[i].SPCSetPoints.HeaterTest)
	MOVLW       _HeaterTestCount+0
	MOVWF       R1 
	MOVLW       hi_addr(_HeaterTestCount+0)
	MOVWF       R2 
	MOVF        Tcount_i_L0+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__Tcount+0 
	MOVF        FLOC__Tcount+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        Tcount_i_L0+0, 0 
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
	MOVLW       46
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
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Tcount92
	MOVF        R1, 0 
	SUBWF       FLOC__Tcount+0, 0 
L__Tcount92:
	BTFSS       STATUS+0, 0 
	GOTO        L_Tcount28
;SPC code.c,303 :: 		HeaterTestCount[i] = 0;
	MOVLW       _HeaterTestCount+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_HeaterTestCount+0)
	MOVWF       FSR1H 
	MOVF        Tcount_i_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;SPC code.c,305 :: 		HeaterTestCmd[i] = 2;
	MOVLW       _HeaterTestCmd+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_HeaterTestCmd+0)
	MOVWF       FSR1H 
	MOVF        Tcount_i_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       2
	MOVWF       POSTINC1+0 
;SPC code.c,306 :: 		}
L_Tcount28:
;SPC code.c,307 :: 		}
L_Tcount27:
;SPC code.c,309 :: 		if(AlarmTestCmd[i] == 1)                      //(spc_system_flag.bite.heatest_req)
	MOVLW       _AlarmTestCmd+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_AlarmTestCmd+0)
	MOVWF       FSR0H 
	MOVF        Tcount_i_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Tcount29
;SPC code.c,311 :: 		if(AlarmTestCount[i]++ >= pSPCValue[i].SPCSetPoints.AlarmOutTest)
	MOVLW       _AlarmTestCount+0
	MOVWF       R1 
	MOVLW       hi_addr(_AlarmTestCount+0)
	MOVWF       R2 
	MOVF        Tcount_i_L0+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__Tcount+0 
	MOVF        FLOC__Tcount+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        Tcount_i_L0+0, 0 
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
	MOVLW       44
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
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Tcount93
	MOVF        R1, 0 
	SUBWF       FLOC__Tcount+0, 0 
L__Tcount93:
	BTFSS       STATUS+0, 0 
	GOTO        L_Tcount30
;SPC code.c,313 :: 		AlarmTestCount[i] = 0;
	MOVLW       _AlarmTestCount+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_AlarmTestCount+0)
	MOVWF       FSR1H 
	MOVF        Tcount_i_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;SPC code.c,315 :: 		AlarmTestCmd[i] = 2;
	MOVLW       _AlarmTestCmd+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_AlarmTestCmd+0)
	MOVWF       FSR1H 
	MOVF        Tcount_i_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       2
	MOVWF       POSTINC1+0 
;SPC code.c,316 :: 		}
L_Tcount30:
;SPC code.c,317 :: 		}
L_Tcount29:
;SPC code.c,297 :: 		for(i=0;i<2;i++)
	INCF        Tcount_i_L0+0, 1 
;SPC code.c,318 :: 		}
	GOTO        L_Tcount24
L_Tcount25:
;SPC code.c,320 :: 		if(pSPCValue[0].SPCSetPoints.AutoTestTime == SPC_SYSTEMVALUE_OFF)
	MOVF        _pSPCValue+87, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__Tcount94
	MOVLW       255
	XORWF       _pSPCValue+86, 0 
L__Tcount94:
	BTFSS       STATUS+0, 2 
	GOTO        L_Tcount31
;SPC code.c,321 :: 		return;
	GOTO        L_end_Tcount
L_Tcount31:
;SPC code.c,323 :: 		spc_count.AutoTest_count++;
	MOVLW       1
	ADDWF       _spc_count+17, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _spc_count+18, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _spc_count+17 
	MOVF        R1, 0 
	MOVWF       _spc_count+18 
;SPC code.c,324 :: 		if(spc_count.AutoTest_count >= pSPCValue[0].SPCSetPoints.AutoTestTime)
	MOVF        _pSPCValue+87, 0 
	SUBWF       _spc_count+18, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Tcount95
	MOVF        _pSPCValue+86, 0 
	SUBWF       _spc_count+17, 0 
L__Tcount95:
	BTFSS       STATUS+0, 0 
	GOTO        L_Tcount32
;SPC code.c,326 :: 		spc_count.AutoTest_count = 0;
	CLRF        _spc_count+17 
	CLRF        _spc_count+18 
;SPC code.c,327 :: 		if(spc_system_flag.bite.autotest_req == IDEL)
	MOVLW       48
	ANDWF       _spc_system_flag+3, 0 
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
	GOTO        L_Tcount33
;SPC code.c,329 :: 		if((ActivedAlarms & CH1_HIGHTEMPALARM) || (ActivedAlarms & CH2_HIGHTEMPALARM))
	BTFSC       _ActivedAlarms+0, 2 
	GOTO        L__Tcount83
	BTFSC       _ActivedAlarms+0, 3 
	GOTO        L__Tcount83
	GOTO        L_Tcount36
L__Tcount83:
;SPC code.c,330 :: 		return;
	GOTO        L_end_Tcount
L_Tcount36:
;SPC code.c,332 :: 		if(spc_system_flag.bite.load_forceop != FORCE_LOAD_OFF)
	MOVLW       48
	ANDWF       _spc_system_flag+2, 0 
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
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_Tcount37
;SPC code.c,333 :: 		spc_system_flag.bite.autotest_req = RUNNING;
	MOVLW       16
	XORWF       _spc_system_flag+3, 0 
	MOVWF       R0 
	MOVLW       48
	ANDWF       R0, 1 
	MOVF        _spc_system_flag+3, 0 
	XORWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _spc_system_flag+3 
L_Tcount37:
;SPC code.c,334 :: 		}
L_Tcount33:
;SPC code.c,335 :: 		}
L_Tcount32:
;SPC code.c,336 :: 		}
L_Tcount23:
;SPC code.c,337 :: 		}
L_Tcount18:
;SPC code.c,338 :: 		}
L_Tcount13:
;SPC code.c,339 :: 		}
L_end_Tcount:
	RETURN      0
; end of _Tcount

_interrupt:

;SPC code.c,341 :: 		void interrupt()
;SPC code.c,345 :: 		if(TMR0IF_bit)
	BTFSS       TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
	GOTO        L_interrupt38
;SPC code.c,348 :: 		if(freq_en)
	MOVF        _freq_en+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt39
;SPC code.c,350 :: 		spc_count.freq_count++;
	MOVLW       1
	ADDWF       _spc_count+13, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _spc_count+14, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _spc_count+13 
	MOVF        R1, 0 
	MOVWF       _spc_count+14 
;SPC code.c,351 :: 		if(spc_count.freq_count > 100)
	MOVLW       0
	MOVWF       R0 
	MOVF        _spc_count+14, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt98
	MOVF        _spc_count+13, 0 
	SUBLW       100
L__interrupt98:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt40
;SPC code.c,352 :: 		freq_en = 0;
	CLRF        _freq_en+0 
	GOTO        L_interrupt41
L_interrupt40:
;SPC code.c,353 :: 		else if(spc_count.freq_count > 50)
	MOVLW       0
	MOVWF       R0 
	MOVF        _spc_count+14, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt99
	MOVF        _spc_count+13, 0 
	SUBLW       50
L__interrupt99:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt42
;SPC code.c,354 :: 		freq_en = 2;
	MOVLW       2
	MOVWF       _freq_en+0 
L_interrupt42:
L_interrupt41:
;SPC code.c,355 :: 		}
	GOTO        L_interrupt43
L_interrupt39:
;SPC code.c,358 :: 		pwm(CHANNEL1);
	CLRF        FARG_pwm_ChannelNum+0 
	CALL        _pwm+0, 0
;SPC code.c,359 :: 		pwm(CHANNEL2);
	MOVLW       1
	MOVWF       FARG_pwm_ChannelNum+0 
	CALL        _pwm+0, 0
;SPC code.c,360 :: 		countformeasurement(CHANNEL1);
	CLRF        FARG_countformeasurement_ChannelNum+0 
	CALL        _countformeasurement+0, 0
;SPC code.c,361 :: 		countformeasurement(CHANNEL2);
	MOVLW       1
	MOVWF       FARG_countformeasurement_ChannelNum+0 
	CALL        _countformeasurement+0, 0
;SPC code.c,363 :: 		if(ModbusRecived)
	MOVF        _ModbusRecived+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt44
;SPC code.c,365 :: 		LED_COMMUNICATION_FAIL = 1;
	BSF         LATE1_bit+0, BitPos(LATE1_bit+0) 
;SPC code.c,366 :: 		ModbusCounter++;
	INFSNZ      _ModbusCounter+0, 1 
	INCF        _ModbusCounter+1, 1 
;SPC code.c,367 :: 		if(ModbusCounter >= 100)
	MOVLW       0
	SUBWF       _ModbusCounter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt100
	MOVLW       100
	SUBWF       _ModbusCounter+0, 0 
L__interrupt100:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt45
;SPC code.c,369 :: 		ModbusRecived = 0;
	CLRF        _ModbusRecived+0 
;SPC code.c,370 :: 		LED_COMMUNICATION_FAIL = 0;
	BCF         LATE1_bit+0, BitPos(LATE1_bit+0) 
;SPC code.c,371 :: 		ModbusValid = 1;
	MOVLW       1
	MOVWF       _ModbusValid+0 
;SPC code.c,372 :: 		}
L_interrupt45:
;SPC code.c,373 :: 		}
L_interrupt44:
;SPC code.c,385 :: 		if(RollCharactEN == 1)
	MOVF        _RollCharactEN+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt46
;SPC code.c,387 :: 		RollCharactCount++;
	INFSNZ      _RollCharactCount+0, 1 
	INCF        _RollCharactCount+1, 1 
;SPC code.c,388 :: 		if(RollCharactCount >= 600)
	MOVLW       128
	XORWF       _RollCharactCount+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       2
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt101
	MOVLW       88
	SUBWF       _RollCharactCount+0, 0 
L__interrupt101:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt47
;SPC code.c,390 :: 		RollCharactCount = 0;
	CLRF        _RollCharactCount+0 
	CLRF        _RollCharactCount+1 
;SPC code.c,391 :: 		RollCharactEN = 2;
	MOVLW       2
	MOVWF       _RollCharactEN+0 
;SPC code.c,392 :: 		}
L_interrupt47:
;SPC code.c,393 :: 		}
L_interrupt46:
;SPC code.c,395 :: 		spc_count.secout++;
	MOVLW       1
	ADDWF       _spc_count+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _spc_count+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _spc_count+0 
	MOVF        R1, 0 
	MOVWF       _spc_count+1 
;SPC code.c,396 :: 		if(spc_count.secout >= DELAY_S)
	MOVLW       19
	SUBWF       _spc_count+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt102
	MOVLW       136
	SUBWF       _spc_count+0, 0 
L__interrupt102:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt48
;SPC code.c,398 :: 		LATG1_bit ^= 1;
	BTG         LATG1_bit+0, BitPos(LATG1_bit+0) 
;SPC code.c,399 :: 		spc_count.secout = 0;
	CLRF        _spc_count+0 
	CLRF        _spc_count+1 
;SPC code.c,400 :: 		SpcSstart[0].SOFTSTART_reach = 1;
	MOVLW       1
	MOVWF       _SpcSstart+2 
;SPC code.c,401 :: 		SpcSstart[1].SOFTSTART_reach = 1;
	MOVLW       1
	MOVWF       _SpcSstart+7 
;SPC code.c,404 :: 		if(ResetPasswordStep)
	MOVF        _ResetPasswordStep+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt49
;SPC code.c,406 :: 		if(ResetPasswordCount++ > 10)
	MOVF        _ResetPasswordCount+0, 0 
	MOVWF       R1 
	MOVF        _ResetPasswordCount+1, 0 
	MOVWF       R2 
	INFSNZ      _ResetPasswordCount+0, 1 
	INCF        _ResetPasswordCount+1, 1 
	MOVLW       0
	MOVWF       R0 
	MOVF        R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt103
	MOVF        R1, 0 
	SUBLW       10
L__interrupt103:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt50
;SPC code.c,408 :: 		ResetPasswordStep = 0;
	CLRF        _ResetPasswordStep+0 
;SPC code.c,409 :: 		ResetPasswordCount = 0;
	CLRF        _ResetPasswordCount+0 
	CLRF        _ResetPasswordCount+1 
;SPC code.c,410 :: 		}
L_interrupt50:
;SPC code.c,411 :: 		}
L_interrupt49:
;SPC code.c,413 :: 		if(spc_system_flag.bite.default_diaped == 0)
	BTFSC       _spc_system_flag+1, 2 
	GOTO        L_interrupt51
;SPC code.c,415 :: 		if(pSPCValue[0].SPCSetPoints.DisplayTime != SPC_SYSTEMVALUE_OFF)
	MOVF        _pSPCValue+89, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt104
	MOVLW       255
	XORWF       _pSPCValue+88, 0 
L__interrupt104:
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt52
;SPC code.c,417 :: 		if(spc_count.Timeout_count++ >= pSPCValue[0].SPCSetPoints.DisplayTime)
	MOVF        _spc_count+4, 0 
	MOVWF       R2 
	MOVF        _spc_count+5, 0 
	MOVWF       R3 
	MOVLW       1
	ADDWF       _spc_count+4, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _spc_count+5, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _spc_count+4 
	MOVF        R1, 0 
	MOVWF       _spc_count+5 
	MOVF        _pSPCValue+89, 0 
	SUBWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt105
	MOVF        _pSPCValue+88, 0 
	SUBWF       R2, 0 
L__interrupt105:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt53
;SPC code.c,419 :: 		spc_count.Timeout_count = 0;
	CLRF        _spc_count+4 
	CLRF        _spc_count+5 
;SPC code.c,420 :: 		spc_system_flag.bite.default_diaped = 1;
	BSF         _spc_system_flag+1, 2 
;SPC code.c,421 :: 		spc_system_flag.bite.stat_update = 1;
	BSF         _spc_system_flag+3, 7 
;SPC code.c,422 :: 		}
L_interrupt53:
;SPC code.c,423 :: 		}
L_interrupt52:
;SPC code.c,424 :: 		}
L_interrupt51:
;SPC code.c,426 :: 		if(spc_count.meas_VT_count++ >= DELAY_VT)
	MOVF        _spc_count+10, 0 
	MOVWF       R1 
	MOVF        _spc_count+10, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _spc_count+10 
	MOVLW       10
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt54
;SPC code.c,428 :: 		spc_count.meas_VT_count = 0;
	CLRF        _spc_count+10 
;SPC code.c,429 :: 		spc_system_flag.bite.meas_VT_reach = 0x03;
	MOVLW       6
	IORWF       _spc_system_flag+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _spc_system_flag+0 
;SPC code.c,430 :: 		}
L_interrupt54:
;SPC code.c,432 :: 		if(energycount++ >= 36)
	MOVF        _energycount+0, 0 
	MOVWF       R1 
	MOVF        _energycount+1, 0 
	MOVWF       R2 
	INFSNZ      _energycount+0, 1 
	INCF        _energycount+1, 1 
	MOVLW       0
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt106
	MOVLW       36
	SUBWF       R1, 0 
L__interrupt106:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt55
;SPC code.c,434 :: 		energycount = 0;
	CLRF        _energycount+0 
	CLRF        _energycount+1 
;SPC code.c,435 :: 		energyacc = 1;
	MOVLW       1
	MOVWF       _energyacc+0 
;SPC code.c,436 :: 		}
L_interrupt55:
;SPC code.c,438 :: 		if(GFITestCmd[0] == 1)
	MOVF        _GFITestCmd+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt56
;SPC code.c,440 :: 		if(GFITestCount[0]++ >= 10)
	MOVF        _GFITestCount+0, 0 
	MOVWF       R1 
	MOVF        _GFITestCount+1, 0 
	MOVWF       R2 
	INFSNZ      _GFITestCount+0, 1 
	INCF        _GFITestCount+1, 1 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt107
	MOVLW       10
	SUBWF       R1, 0 
L__interrupt107:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt57
;SPC code.c,442 :: 		GFITestCount[0] = 0;
	CLRF        _GFITestCount+0 
	CLRF        _GFITestCount+1 
;SPC code.c,443 :: 		GFITestCmd[0] = 2;
	MOVLW       2
	MOVWF       _GFITestCmd+0 
;SPC code.c,444 :: 		LATF2_bit = 0;
	BCF         LATF2_bit+0, BitPos(LATF2_bit+0) 
;SPC code.c,445 :: 		}
L_interrupt57:
;SPC code.c,446 :: 		}
L_interrupt56:
;SPC code.c,448 :: 		if(GFITestCmd[1] == 1)
	MOVF        _GFITestCmd+1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt58
;SPC code.c,450 :: 		if(GFITestCount[1]++ >= 10)
	MOVF        _GFITestCount+2, 0 
	MOVWF       R1 
	MOVF        _GFITestCount+3, 0 
	MOVWF       R2 
	INFSNZ      _GFITestCount+2, 1 
	INCF        _GFITestCount+3, 1 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt108
	MOVLW       10
	SUBWF       R1, 0 
L__interrupt108:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt59
;SPC code.c,452 :: 		GFITestCount[1] = 0;
	CLRF        _GFITestCount+2 
	CLRF        _GFITestCount+3 
;SPC code.c,453 :: 		GFITestCmd[1] = 2;
	MOVLW       2
	MOVWF       _GFITestCmd+1 
;SPC code.c,454 :: 		LATF1_bit = 0;
	BCF         LATF1_bit+0, BitPos(LATF1_bit+0) 
;SPC code.c,455 :: 		}
L_interrupt59:
;SPC code.c,456 :: 		}
L_interrupt58:
;SPC code.c,458 :: 		if(spc_system_flag.bite.autotest_req == RUNNING)
	MOVLW       48
	ANDWF       _spc_system_flag+3, 0 
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
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt60
;SPC code.c,460 :: 		if(spc_count.AutoTest_last_count++ >= 320)             //320
	MOVF        _spc_count+19, 0 
	MOVWF       R2 
	MOVF        _spc_count+20, 0 
	MOVWF       R3 
	MOVLW       1
	ADDWF       _spc_count+19, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _spc_count+20, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _spc_count+19 
	MOVF        R1, 0 
	MOVWF       _spc_count+20 
	MOVLW       1
	SUBWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt109
	MOVLW       64
	SUBWF       R2, 0 
L__interrupt109:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt61
;SPC code.c,462 :: 		spc_count.AutoTest_last_count = 0;
	CLRF        _spc_count+19 
	CLRF        _spc_count+20 
;SPC code.c,463 :: 		spc_system_flag.bite.autotest_req = DONES;
	MOVLW       32
	XORWF       _spc_system_flag+3, 0 
	MOVWF       R0 
	MOVLW       48
	ANDWF       R0, 1 
	MOVF        _spc_system_flag+3, 0 
	XORWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _spc_system_flag+3 
;SPC code.c,464 :: 		}
L_interrupt61:
;SPC code.c,465 :: 		}
L_interrupt60:
;SPC code.c,467 :: 		if(GetHighCurrentEn(0) == 1)
	CLRF        FARG_GetHighCurrentEn_ChannelNum+0 
	CALL        _GetHighCurrentEn+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt62
;SPC code.c,469 :: 		if(HighCurrentAlarmCount[0]++ >= 300)
	MOVF        _HighCurrentAlarmCount+0, 0 
	MOVWF       R1 
	MOVF        _HighCurrentAlarmCount+1, 0 
	MOVWF       R2 
	INFSNZ      _HighCurrentAlarmCount+0, 1 
	INCF        _HighCurrentAlarmCount+1, 1 
	MOVLW       1
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt110
	MOVLW       44
	SUBWF       R1, 0 
L__interrupt110:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt63
;SPC code.c,471 :: 		HighCurrentAlarmCount[0] = 0;
	CLRF        _HighCurrentAlarmCount+0 
	CLRF        _HighCurrentAlarmCount+1 
;SPC code.c,472 :: 		SetHighCurrentEn(2,0);
	MOVLW       2
	MOVWF       FARG_SetHighCurrentEn_ChannelNum+0 
	CLRF        FARG_SetHighCurrentEn_HighCurrentCmd+0 
	CALL        _SetHighCurrentEn+0, 0
;SPC code.c,473 :: 		}
L_interrupt63:
;SPC code.c,474 :: 		}
L_interrupt62:
;SPC code.c,476 :: 		if(GetHighCurrentEn(1) == 1)
	MOVLW       1
	MOVWF       FARG_GetHighCurrentEn_ChannelNum+0 
	CALL        _GetHighCurrentEn+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt64
;SPC code.c,478 :: 		if(HighCurrentAlarmCount[1]++ >= 300)
	MOVF        _HighCurrentAlarmCount+2, 0 
	MOVWF       R1 
	MOVF        _HighCurrentAlarmCount+3, 0 
	MOVWF       R2 
	INFSNZ      _HighCurrentAlarmCount+2, 1 
	INCF        _HighCurrentAlarmCount+3, 1 
	MOVLW       1
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt111
	MOVLW       44
	SUBWF       R1, 0 
L__interrupt111:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt65
;SPC code.c,480 :: 		HighCurrentAlarmCount[1] = 0;
	CLRF        _HighCurrentAlarmCount+2 
	CLRF        _HighCurrentAlarmCount+3 
;SPC code.c,481 :: 		SetHighCurrentEn(2,1);
	MOVLW       2
	MOVWF       FARG_SetHighCurrentEn_ChannelNum+0 
	MOVLW       1
	MOVWF       FARG_SetHighCurrentEn_HighCurrentCmd+0 
	CALL        _SetHighCurrentEn+0, 0
;SPC code.c,482 :: 		}
L_interrupt65:
;SPC code.c,483 :: 		}
L_interrupt64:
;SPC code.c,485 :: 		if(GetAlarmEn())
	CALL        _GetAlarmEn+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt66
;SPC code.c,487 :: 		LED_ALARM ^= 1;
	BTG         LATE0_bit+0, BitPos(LATE0_bit+0) 
;SPC code.c,488 :: 		}
L_interrupt66:
;SPC code.c,490 :: 		Tcount(&SYS_On_time, 0);    //进行auto test计数
	MOVLW       _SYS_On_time+0
	MOVWF       FARG_Tcount_time+0 
	MOVLW       hi_addr(_SYS_On_time+0)
	MOVWF       FARG_Tcount_time+1 
	CLRF        FARG_Tcount_cmd+0 
	CALL        _Tcount+0, 0
;SPC code.c,491 :: 		if(Spcssr[0].SSR_stat == 1)
	MOVF        _Spcssr+1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt67
;SPC code.c,492 :: 		Tcount(&Heat_On_time[0], 1);
	MOVLW       _Heat_On_time+0
	MOVWF       FARG_Tcount_time+0 
	MOVLW       hi_addr(_Heat_On_time+0)
	MOVWF       FARG_Tcount_time+1 
	MOVLW       1
	MOVWF       FARG_Tcount_cmd+0 
	CALL        _Tcount+0, 0
L_interrupt67:
;SPC code.c,493 :: 		if(Spcssr[1].SSR_stat == 1)
	MOVF        _Spcssr+4, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt68
;SPC code.c,494 :: 		Tcount(&Heat_On_time[1], 2);
	MOVLW       _Heat_On_time+6
	MOVWF       FARG_Tcount_time+0 
	MOVLW       hi_addr(_Heat_On_time+6)
	MOVWF       FARG_Tcount_time+1 
	MOVLW       2
	MOVWF       FARG_Tcount_cmd+0 
	CALL        _Tcount+0, 0
L_interrupt68:
;SPC code.c,495 :: 		}
L_interrupt48:
;SPC code.c,497 :: 		if(LCDext)
	MOVF        _LCDext+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt69
;SPC code.c,499 :: 		if(spc_count.toutT++ >= DELAY_S)
	MOVF        _spc_count+2, 0 
	MOVWF       R2 
	MOVF        _spc_count+3, 0 
	MOVWF       R3 
	MOVLW       1
	ADDWF       _spc_count+2, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _spc_count+3, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _spc_count+2 
	MOVF        R1, 0 
	MOVWF       _spc_count+3 
	MOVLW       19
	SUBWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt112
	MOVLW       136
	SUBWF       R2, 0 
L__interrupt112:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt70
;SPC code.c,501 :: 		LCDext = 0;
	CLRF        _LCDext+0 
;SPC code.c,502 :: 		spc_count.toutT = 0;
	CLRF        _spc_count+2 
	CLRF        _spc_count+3 
;SPC code.c,503 :: 		if(reset_psw_en)
	MOVF        _reset_psw_en+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt71
;SPC code.c,504 :: 		spc_system_flag.bite.default_diaped = 1;
	BSF         _spc_system_flag+1, 2 
	GOTO        L_interrupt72
L_interrupt71:
;SPC code.c,506 :: 		bUpdate = 1;
	MOVLW       1
	MOVWF       _bUpdate+0 
L_interrupt72:
;SPC code.c,507 :: 		}
L_interrupt70:
;SPC code.c,508 :: 		}
L_interrupt69:
;SPC code.c,510 :: 		if(spc_system_flag.bite.flashing_en == 1)
	BTFSS       _spc_system_flag+1, 7 
	GOTO        L_interrupt73
;SPC code.c,512 :: 		if(spc_count.scanT++ >= 5000)
	MOVF        _spc_count+8, 0 
	MOVWF       R2 
	MOVF        _spc_count+9, 0 
	MOVWF       R3 
	MOVLW       1
	ADDWF       _spc_count+8, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _spc_count+9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _spc_count+8 
	MOVF        R1, 0 
	MOVWF       _spc_count+9 
	MOVLW       19
	SUBWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt113
	MOVLW       136
	SUBWF       R2, 0 
L__interrupt113:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt74
;SPC code.c,514 :: 		spc_count.scanT = 0;
	CLRF        _spc_count+8 
	CLRF        _spc_count+9 
;SPC code.c,515 :: 		spc_system_flag.bite.flashing_reach = 1;
	BSF         _spc_system_flag+2, 0 
;SPC code.c,516 :: 		}
L_interrupt74:
;SPC code.c,517 :: 		}
L_interrupt73:
;SPC code.c,519 :: 		if(KeyEn)
	MOVF        _KeyEn+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt75
;SPC code.c,521 :: 		if(KeyDetectCount++ >= 150)
	MOVF        _KeyDetectCount+0, 0 
	MOVWF       R1 
	MOVF        _KeyDetectCount+1, 0 
	MOVWF       R2 
	INFSNZ      _KeyDetectCount+0, 1 
	INCF        _KeyDetectCount+1, 1 
	MOVLW       0
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt114
	MOVLW       150
	SUBWF       R1, 0 
L__interrupt114:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt76
;SPC code.c,523 :: 		KeyDetectCount = 0;
	CLRF        _KeyDetectCount+0 
	CLRF        _KeyDetectCount+1 
;SPC code.c,524 :: 		spc_system_flag.bite.keypushed = KEYPUSH;
	BSF         _spc_system_flag+0, 0 
;SPC code.c,525 :: 		}
L_interrupt76:
;SPC code.c,526 :: 		}
L_interrupt75:
;SPC code.c,527 :: 		}
L_interrupt43:
;SPC code.c,535 :: 		TMR0H = 0XFe;
	MOVLW       254
	MOVWF       TMR0H+0 
;SPC code.c,536 :: 		TMR0L = 0x84;
	MOVLW       132
	MOVWF       TMR0L+0 
;SPC code.c,537 :: 		TMR0IF_bit = 0;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;SPC code.c,538 :: 		}
	GOTO        L_interrupt77
L_interrupt38:
;SPC code.c,539 :: 		else if(INT0IF_bit)
	BTFSS       INT0IF_bit+0, BitPos(INT0IF_bit+0) 
	GOTO        L_interrupt78
;SPC code.c,541 :: 		INT0IF_bit = 0;
	BCF         INT0IF_bit+0, BitPos(INT0IF_bit+0) 
;SPC code.c,542 :: 		}
	GOTO        L_interrupt79
L_interrupt78:
;SPC code.c,543 :: 		else if(RC1IF_bit)
	BTFSS       RC1IF_bit+0, BitPos(RC1IF_bit+0) 
	GOTO        L_interrupt80
;SPC code.c,545 :: 		if(ModbusRecived == 0)
	MOVF        _ModbusRecived+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt81
;SPC code.c,546 :: 		ModbusRecived = 1;
	MOVLW       1
	MOVWF       _ModbusRecived+0 
L_interrupt81:
;SPC code.c,548 :: 		modbus_rcdata[modbus_rcn] = RCREG1;
	MOVLW       _modbus_rcdata+0
	ADDWF       _modbus_rcn+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_modbus_rcdata+0)
	ADDWFC      _modbus_rcn+1, 0 
	MOVWF       FSR1H 
	MOVF        RCREG1+0, 0 
	MOVWF       POSTINC1+0 
;SPC code.c,549 :: 		modbus_rcn++;
	INFSNZ      _modbus_rcn+0, 1 
	INCF        _modbus_rcn+1, 1 
;SPC code.c,550 :: 		ModbusCounter = 0;
	CLRF        _ModbusCounter+0 
	CLRF        _ModbusCounter+1 
;SPC code.c,552 :: 		RC1IF_bit = 0;
	BCF         RC1IF_bit+0, BitPos(RC1IF_bit+0) 
;SPC code.c,553 :: 		}
L_interrupt80:
L_interrupt79:
L_interrupt77:
;SPC code.c,554 :: 		}
L_end_interrupt:
L__interrupt97:
	RETFIE      1
; end of _interrupt
