
_SPCSystemInitialize:

;Spcsystem.c,115 :: 		void SPCSystemInitialize()
;Spcsystem.c,117 :: 		MemeSet((char *)&pSPCValue[0], 0, sizeof(SPCVALUE));
	MOVLW       _pSPCValue+0
	MOVWF       FARG_MemeSet_target+0 
	MOVLW       hi_addr(_pSPCValue+0)
	MOVWF       FARG_MemeSet_target+1 
	CLRF        FARG_MemeSet_Transdata+0 
	MOVLW       142
	MOVWF       FARG_MemeSet_len+0 
	MOVLW       0
	MOVWF       FARG_MemeSet_len+1 
	CALL        _MemeSet+0, 0
;Spcsystem.c,118 :: 		MemeSet((char *)&pSPCValue[1], 0, sizeof(SPCVALUE));
	MOVLW       _pSPCValue+142
	MOVWF       FARG_MemeSet_target+0 
	MOVLW       hi_addr(_pSPCValue+142)
	MOVWF       FARG_MemeSet_target+1 
	CLRF        FARG_MemeSet_Transdata+0 
	MOVLW       142
	MOVWF       FARG_MemeSet_len+0 
	MOVLW       0
	MOVWF       FARG_MemeSet_len+1 
	CALL        _MemeSet+0, 0
;Spcsystem.c,119 :: 		MemeSet((char *)&SetP_shade, 0, sizeof(SPCSETPIONTS));
	MOVLW       _SetP_shade+0
	MOVWF       FARG_MemeSet_target+0 
	MOVLW       hi_addr(_SetP_shade+0)
	MOVWF       FARG_MemeSet_target+1 
	CLRF        FARG_MemeSet_Transdata+0 
	MOVLW       88
	MOVWF       FARG_MemeSet_len+0 
	MOVLW       0
	MOVWF       FARG_MemeSet_len+1 
	CALL        _MemeSet+0, 0
;Spcsystem.c,120 :: 		MemeSet((char *)&spc_count, 0, sizeof(SPCCOUNT));
	MOVLW       _spc_count+0
	MOVWF       FARG_MemeSet_target+0 
	MOVLW       hi_addr(_spc_count+0)
	MOVWF       FARG_MemeSet_target+1 
	CLRF        FARG_MemeSet_Transdata+0 
	MOVLW       22
	MOVWF       FARG_MemeSet_len+0 
	MOVLW       0
	MOVWF       FARG_MemeSet_len+1 
	CALL        _MemeSet+0, 0
;Spcsystem.c,121 :: 		MemeSet((char *)&pSPCAlarm, 0, sizeof(SPCALARMBOX));
	MOVLW       _pSPCAlarm+0
	MOVWF       FARG_MemeSet_target+0 
	MOVLW       hi_addr(_pSPCAlarm+0)
	MOVWF       FARG_MemeSet_target+1 
	CLRF        FARG_MemeSet_Transdata+0 
	MOVLW       162
	MOVWF       FARG_MemeSet_len+0 
	MOVLW       0
	MOVWF       FARG_MemeSet_len+1 
	CALL        _MemeSet+0, 0
;Spcsystem.c,122 :: 		MemeSet((char *)&SpcSstart, 0, sizeof(SOFTSTART));
	MOVLW       _SpcSstart+0
	MOVWF       FARG_MemeSet_target+0 
	MOVLW       hi_addr(_SpcSstart+0)
	MOVWF       FARG_MemeSet_target+1 
	CLRF        FARG_MemeSet_Transdata+0 
	MOVLW       5
	MOVWF       FARG_MemeSet_len+0 
	MOVLW       0
	MOVWF       FARG_MemeSet_len+1 
	CALL        _MemeSet+0, 0
;Spcsystem.c,123 :: 		MemeSet((char *)&SpcAcc[0], 0, sizeof(ACCUMULATE));
	MOVLW       _SpcAcc+0
	MOVWF       FARG_MemeSet_target+0 
	MOVLW       hi_addr(_SpcAcc+0)
	MOVWF       FARG_MemeSet_target+1 
	CLRF        FARG_MemeSet_Transdata+0 
	MOVLW       12
	MOVWF       FARG_MemeSet_len+0 
	MOVLW       0
	MOVWF       FARG_MemeSet_len+1 
	CALL        _MemeSet+0, 0
;Spcsystem.c,124 :: 		MemeSet((char *)&SpcAcc[1], 0, sizeof(ACCUMULATE));
	MOVLW       _SpcAcc+12
	MOVWF       FARG_MemeSet_target+0 
	MOVLW       hi_addr(_SpcAcc+12)
	MOVWF       FARG_MemeSet_target+1 
	CLRF        FARG_MemeSet_Transdata+0 
	MOVLW       12
	MOVWF       FARG_MemeSet_len+0 
	MOVLW       0
	MOVWF       FARG_MemeSet_len+1 
	CALL        _MemeSet+0, 0
;Spcsystem.c,125 :: 		MemeSet((char *)&Spcssr[0], 0, sizeof(SPCSSR));
	MOVLW       _Spcssr+0
	MOVWF       FARG_MemeSet_target+0 
	MOVLW       hi_addr(_Spcssr+0)
	MOVWF       FARG_MemeSet_target+1 
	CLRF        FARG_MemeSet_Transdata+0 
	MOVLW       3
	MOVWF       FARG_MemeSet_len+0 
	MOVLW       0
	MOVWF       FARG_MemeSet_len+1 
	CALL        _MemeSet+0, 0
;Spcsystem.c,126 :: 		MemeSet((char *)&Spcssr[1], 0, sizeof(SPCSSR));
	MOVLW       _Spcssr+3
	MOVWF       FARG_MemeSet_target+0 
	MOVLW       hi_addr(_Spcssr+3)
	MOVWF       FARG_MemeSet_target+1 
	CLRF        FARG_MemeSet_Transdata+0 
	MOVLW       3
	MOVWF       FARG_MemeSet_len+0 
	MOVLW       0
	MOVWF       FARG_MemeSet_len+1 
	CALL        _MemeSet+0, 0
;Spcsystem.c,127 :: 		MemeSet((char *)&Spcpwm[0], 0, sizeof(SPCPWM));
	MOVLW       _Spcpwm+0
	MOVWF       FARG_MemeSet_target+0 
	MOVLW       hi_addr(_Spcpwm+0)
	MOVWF       FARG_MemeSet_target+1 
	CLRF        FARG_MemeSet_Transdata+0 
	MOVLW       11
	MOVWF       FARG_MemeSet_len+0 
	MOVLW       0
	MOVWF       FARG_MemeSet_len+1 
	CALL        _MemeSet+0, 0
;Spcsystem.c,128 :: 		MemeSet((char *)&Spcpwm[1], 0, sizeof(SPCPWM));
	MOVLW       _Spcpwm+11
	MOVWF       FARG_MemeSet_target+0 
	MOVLW       hi_addr(_Spcpwm+11)
	MOVWF       FARG_MemeSet_target+1 
	CLRF        FARG_MemeSet_Transdata+0 
	MOVLW       11
	MOVWF       FARG_MemeSet_len+0 
	MOVLW       0
	MOVWF       FARG_MemeSet_len+1 
	CALL        _MemeSet+0, 0
;Spcsystem.c,129 :: 		MemeSet((char *)&Volt_acc, 0, sizeof(VALUEACC));
	MOVLW       _Volt_acc+0
	MOVWF       FARG_MemeSet_target+0 
	MOVLW       hi_addr(_Volt_acc+0)
	MOVWF       FARG_MemeSet_target+1 
	CLRF        FARG_MemeSet_Transdata+0 
	MOVLW       5
	MOVWF       FARG_MemeSet_len+0 
	MOVLW       0
	MOVWF       FARG_MemeSet_len+1 
	CALL        _MemeSet+0, 0
;Spcsystem.c,130 :: 		MemeSet((char *)&Current_acc, 0, sizeof(VALUEACC));
	MOVLW       _Current_acc+0
	MOVWF       FARG_MemeSet_target+0 
	MOVLW       hi_addr(_Current_acc+0)
	MOVWF       FARG_MemeSet_target+1 
	CLRF        FARG_MemeSet_Transdata+0 
	MOVLW       5
	MOVWF       FARG_MemeSet_len+0 
	MOVLW       0
	MOVWF       FARG_MemeSet_len+1 
	CALL        _MemeSet+0, 0
;Spcsystem.c,131 :: 		MemeSet((char *)&SYS_On_time, 0, sizeof(SPCTIME));
	MOVLW       _SYS_On_time+0
	MOVWF       FARG_MemeSet_target+0 
	MOVLW       hi_addr(_SYS_On_time+0)
	MOVWF       FARG_MemeSet_target+1 
	CLRF        FARG_MemeSet_Transdata+0 
	MOVLW       6
	MOVWF       FARG_MemeSet_len+0 
	MOVLW       0
	MOVWF       FARG_MemeSet_len+1 
	CALL        _MemeSet+0, 0
;Spcsystem.c,132 :: 		MemeSet((char *)&Heat_On_time[0], 0, sizeof(SPCTIME));
	MOVLW       _Heat_On_time+0
	MOVWF       FARG_MemeSet_target+0 
	MOVLW       hi_addr(_Heat_On_time+0)
	MOVWF       FARG_MemeSet_target+1 
	CLRF        FARG_MemeSet_Transdata+0 
	MOVLW       6
	MOVWF       FARG_MemeSet_len+0 
	MOVLW       0
	MOVWF       FARG_MemeSet_len+1 
	CALL        _MemeSet+0, 0
;Spcsystem.c,133 :: 		MemeSet((char *)&Heat_On_time[1], 0, sizeof(SPCTIME));
	MOVLW       _Heat_On_time+6
	MOVWF       FARG_MemeSet_target+0 
	MOVLW       hi_addr(_Heat_On_time+6)
	MOVWF       FARG_MemeSet_target+1 
	CLRF        FARG_MemeSet_Transdata+0 
	MOVLW       6
	MOVWF       FARG_MemeSet_len+0 
	MOVLW       0
	MOVWF       FARG_MemeSet_len+1 
	CALL        _MemeSet+0, 0
;Spcsystem.c,135 :: 		ClearStr(Actural_disp_str[0], 38*17);
	MOVLW       _Actural_disp_str+0
	MOVWF       FARG_ClearStr_target+0 
	MOVLW       hi_addr(_Actural_disp_str+0)
	MOVWF       FARG_ClearStr_target+1 
	MOVLW       134
	MOVWF       FARG_ClearStr_len+0 
	MOVLW       2
	MOVWF       FARG_ClearStr_len+1 
	CALL        _ClearStr+0, 0
;Spcsystem.c,137 :: 		pwm_duty[0] = 0;
	CLRF        _pwm_duty+0 
	CLRF        _pwm_duty+1 
;Spcsystem.c,138 :: 		duty_index[0] = 0;
	CLRF        _duty_index+0 
	CLRF        _duty_index+1 
;Spcsystem.c,139 :: 		pwm_duty[1] = 0;
	CLRF        _pwm_duty+2 
	CLRF        _pwm_duty+3 
;Spcsystem.c,140 :: 		duty_index[1] = 0;
	CLRF        _duty_index+2 
	CLRF        _duty_index+3 
;Spcsystem.c,142 :: 		Spcpwm[0].duty_point = 5;
	MOVLW       5
	MOVWF       _Spcpwm+1 
;Spcsystem.c,143 :: 		Spcpwm[1].duty_point = 5;
	MOVLW       5
	MOVWF       _Spcpwm+12 
;Spcsystem.c,144 :: 		spc_system_flag.word = 0;
	CLRF        _spc_system_flag+0 
	CLRF        _spc_system_flag+1 
	CLRF        _spc_system_flag+2 
	CLRF        _spc_system_flag+3 
;Spcsystem.c,150 :: 		if(SPCIfFirstRun())
	CALL        _SPCIfFirstRun+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCSystemInitialize0
;Spcsystem.c,152 :: 		SetSystemToDefault();
	CALL        _SetSystemToDefault+0, 0
;Spcsystem.c,153 :: 		}
	GOTO        L_SPCSystemInitialize1
L_SPCSystemInitialize0:
;Spcsystem.c,156 :: 		SetSystemFromEEP();
	CALL        _SetSystemFromEEP+0, 0
;Spcsystem.c,157 :: 		}
L_SPCSystemInitialize1:
;Spcsystem.c,159 :: 		Spcpwm[0].meas_cmd = INITIAL_MEASUREMENT;
	MOVLW       1
	MOVWF       _Spcpwm+2 
;Spcsystem.c,160 :: 		Spcpwm[1].meas_cmd = INITIAL_MEASUREMENT;
	MOVLW       1
	MOVWF       _Spcpwm+13 
;Spcsystem.c,161 :: 		Statis_flag[0] = (STATIS_MAX_TEMP + STATIS_MIN_TEMP + STATIS_MAX_VOLT + STATIS_MIN_VOLT + STATIS_CURRENT + STATIS_GFI);
	MOVLW       63
	MOVWF       _Statis_flag+0 
;Spcsystem.c,162 :: 		Statis_flag[1] = (STATIS_MAX_TEMP + STATIS_MIN_TEMP + STATIS_MAX_VOLT + STATIS_MIN_VOLT + STATIS_CURRENT + STATIS_GFI);
	MOVLW       63
	MOVWF       _Statis_flag+1 
;Spcsystem.c,164 :: 		if(pSPCValue[0].SPCSetPoints.system_valueb.bite.man_on)
	BTFSS       _pSPCValue+138, 2 
	GOTO        L_SPCSystemInitialize2
;Spcsystem.c,165 :: 		SetHeatStatStr(HEAT_IS_MANOFF, 0);
	MOVLW       3
	MOVWF       FARG_SetHeatStatStr_Strlocat+0 
	CLRF        FARG_SetHeatStatStr_ChannelNum+0 
	CALL        _SetHeatStatStr+0, 0
	GOTO        L_SPCSystemInitialize3
L_SPCSystemInitialize2:
;Spcsystem.c,167 :: 		SetHeatStatStr(HEAT_IS_OFF, 0);
	CLRF        FARG_SetHeatStatStr_Strlocat+0 
	CLRF        FARG_SetHeatStatStr_ChannelNum+0 
	CALL        _SetHeatStatStr+0, 0
L_SPCSystemInitialize3:
;Spcsystem.c,169 :: 		if(pSPCValue[1].SPCSetPoints.system_valueb.bite.man_on)
	BTFSS       _pSPCValue+280, 2 
	GOTO        L_SPCSystemInitialize4
;Spcsystem.c,170 :: 		SetHeatStatStr(HEAT_IS_MANOFF, 1);
	MOVLW       3
	MOVWF       FARG_SetHeatStatStr_Strlocat+0 
	MOVLW       1
	MOVWF       FARG_SetHeatStatStr_ChannelNum+0 
	CALL        _SetHeatStatStr+0, 0
	GOTO        L_SPCSystemInitialize5
L_SPCSystemInitialize4:
;Spcsystem.c,172 :: 		SetHeatStatStr(HEAT_IS_OFF, 1);
	CLRF        FARG_SetHeatStatStr_Strlocat+0 
	MOVLW       1
	MOVWF       FARG_SetHeatStatStr_ChannelNum+0 
	CALL        _SetHeatStatStr+0, 0
L_SPCSystemInitialize5:
;Spcsystem.c,174 :: 		SetIntStr((int*)&duty_index[0], CH1_ACTURAL_DUTY, UNIT_AMPER_PERCENT, 1);
	MOVLW       _duty_index+0
	MOVWF       FARG_SetIntStr_ptr+0 
	MOVLW       hi_addr(_duty_index+0)
	MOVWF       FARG_SetIntStr_ptr+1 
	MOVLW       18
	MOVWF       FARG_SetIntStr_strlocat+0 
	MOVLW       9
	MOVWF       FARG_SetIntStr_unitlocar+0 
	MOVLW       1
	MOVWF       FARG_SetIntStr_len+0 
	CALL        _SetIntStr+0, 0
;Spcsystem.c,175 :: 		SetIntStr((int*)&duty_index[0], CH1_ACTURAL_ENEGY, UNIT_ENEGRY, 3);
	MOVLW       _duty_index+0
	MOVWF       FARG_SetIntStr_ptr+0 
	MOVLW       hi_addr(_duty_index+0)
	MOVWF       FARG_SetIntStr_ptr+1 
	MOVLW       24
	MOVWF       FARG_SetIntStr_strlocat+0 
	MOVLW       11
	MOVWF       FARG_SetIntStr_unitlocar+0 
	MOVLW       3
	MOVWF       FARG_SetIntStr_len+0 
	CALL        _SetIntStr+0, 0
;Spcsystem.c,176 :: 		SetIntStr((int*)&duty_index[0], CH1_ACTURAL_ONTIME_PERCENT, UNIT_PERCENT, 1);
	MOVLW       _duty_index+0
	MOVWF       FARG_SetIntStr_ptr+0 
	MOVLW       hi_addr(_duty_index+0)
	MOVWF       FARG_SetIntStr_ptr+1 
	MOVLW       36
	MOVWF       FARG_SetIntStr_strlocat+0 
	MOVLW       9
	MOVWF       FARG_SetIntStr_unitlocar+0 
	MOVLW       1
	MOVWF       FARG_SetIntStr_len+0 
	CALL        _SetIntStr+0, 0
;Spcsystem.c,177 :: 		SetIntStr((int*)&duty_index[1], CH2_ACTURAL_DUTY, UNIT_AMPER_PERCENT, 1);
	MOVLW       _duty_index+2
	MOVWF       FARG_SetIntStr_ptr+0 
	MOVLW       hi_addr(_duty_index+2)
	MOVWF       FARG_SetIntStr_ptr+1 
	MOVLW       19
	MOVWF       FARG_SetIntStr_strlocat+0 
	MOVLW       9
	MOVWF       FARG_SetIntStr_unitlocar+0 
	MOVLW       1
	MOVWF       FARG_SetIntStr_len+0 
	CALL        _SetIntStr+0, 0
;Spcsystem.c,178 :: 		SetIntStr((int*)&duty_index[1], CH2_ACTURAL_ENEGY, UNIT_ENEGRY, 3);
	MOVLW       _duty_index+2
	MOVWF       FARG_SetIntStr_ptr+0 
	MOVLW       hi_addr(_duty_index+2)
	MOVWF       FARG_SetIntStr_ptr+1 
	MOVLW       25
	MOVWF       FARG_SetIntStr_strlocat+0 
	MOVLW       11
	MOVWF       FARG_SetIntStr_unitlocar+0 
	MOVLW       3
	MOVWF       FARG_SetIntStr_len+0 
	CALL        _SetIntStr+0, 0
;Spcsystem.c,179 :: 		SetIntStr((int*)&duty_index[1], CH2_ACTURAL_ONTIME_PERCENT, UNIT_PERCENT, 1);
	MOVLW       _duty_index+2
	MOVWF       FARG_SetIntStr_ptr+0 
	MOVLW       hi_addr(_duty_index+2)
	MOVWF       FARG_SetIntStr_ptr+1 
	MOVLW       37
	MOVWF       FARG_SetIntStr_strlocat+0 
	MOVLW       9
	MOVWF       FARG_SetIntStr_unitlocar+0 
	MOVLW       1
	MOVWF       FARG_SetIntStr_len+0 
	CALL        _SetIntStr+0, 0
;Spcsystem.c,180 :: 		SetOntimeStr(0, CH1_ACTURAL_ONTIME);
	CLRF        FARG_SetOntimeStr_databuff+0 
	CLRF        FARG_SetOntimeStr_databuff+1 
	CLRF        FARG_SetOntimeStr_databuff+2 
	CLRF        FARG_SetOntimeStr_databuff+3 
	CLRF        FARG_SetOntimeStr_strlocat+0 
	CALL        _SetOntimeStr+0, 0
;Spcsystem.c,181 :: 		SetOntimeStr(0, CH2_ACTURAL_ONTIME);
	CLRF        FARG_SetOntimeStr_databuff+0 
	CLRF        FARG_SetOntimeStr_databuff+1 
	CLRF        FARG_SetOntimeStr_databuff+2 
	CLRF        FARG_SetOntimeStr_databuff+3 
	MOVLW       1
	MOVWF       FARG_SetOntimeStr_strlocat+0 
	CALL        _SetOntimeStr+0, 0
;Spcsystem.c,182 :: 		SetCostStr(0, CH1_ACTURAL_COST);
	CLRF        FARG_SetCostStr_databuff+0 
	CLRF        FARG_SetCostStr_databuff+1 
	CLRF        FARG_SetCostStr_databuff+2 
	CLRF        FARG_SetCostStr_databuff+3 
	MOVLW       26
	MOVWF       FARG_SetCostStr_strlocat+0 
	CALL        _SetCostStr+0, 0
;Spcsystem.c,183 :: 		SetCostStr(0, CH2_ACTURAL_COST);
	CLRF        FARG_SetCostStr_databuff+0 
	CLRF        FARG_SetCostStr_databuff+1 
	CLRF        FARG_SetCostStr_databuff+2 
	CLRF        FARG_SetCostStr_databuff+3 
	MOVLW       27
	MOVWF       FARG_SetCostStr_strlocat+0 
	CALL        _SetCostStr+0, 0
;Spcsystem.c,185 :: 		SetIntStr((int*)&pSPCAlarm.spcalarms.num_alarms, ACTURAL_ALARM, UNIT_ALARM, 7);
	MOVLW       _pSPCAlarm+0
	MOVWF       FARG_SetIntStr_ptr+0 
	MOVLW       hi_addr(_pSPCAlarm+0)
	MOVWF       FARG_SetIntStr_ptr+1 
	MOVLW       28
	MOVWF       FARG_SetIntStr_strlocat+0 
	MOVLW       12
	MOVWF       FARG_SetIntStr_unitlocar+0 
	MOVLW       7
	MOVWF       FARG_SetIntStr_len+0 
	CALL        _SetIntStr+0, 0
;Spcsystem.c,188 :: 		SystemUpdate = 0;
	CLRF        _SystemUpdate+0 
	CLRF        _SystemUpdate+1 
	CLRF        _SystemUpdate+2 
	CLRF        _SystemUpdate+3 
;Spcsystem.c,189 :: 		ActivedAlarms = 0;
	CLRF        _ActivedAlarms+0 
	CLRF        _ActivedAlarms+1 
	CLRF        _ActivedAlarms+2 
	CLRF        _ActivedAlarms+3 
;Spcsystem.c,190 :: 		ActualAlarmNum = 0;
	CLRF        _ActualAlarmNum+0 
;Spcsystem.c,191 :: 		forceop_level = 0;
	CLRF        _forceop_level+0 
;Spcsystem.c,192 :: 		FirstTempCheck = 1;
	MOVLW       1
	MOVWF       _FirstTempCheck+0 
;Spcsystem.c,194 :: 		EEPROM_get(0x2f0,1,(char*)(&SPCCalibrationEN));
	MOVLW       240
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+0 
	MOVLW       2
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+1 
	MOVLW       1
	MOVWF       FARG_EEPROM_get_Len+0 
	MOVLW       _SPCCalibrationEN+0
	MOVWF       FARG_EEPROM_get_readbuffer+0 
	MOVLW       hi_addr(_SPCCalibrationEN+0)
	MOVWF       FARG_EEPROM_get_readbuffer+1 
	CALL        _EEPROM_get+0, 0
;Spcsystem.c,195 :: 		EEPROM_get(0x2f1,1,(char*)(&SPCTestingEN));
	MOVLW       241
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+0 
	MOVLW       2
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+1 
	MOVLW       1
	MOVWF       FARG_EEPROM_get_Len+0 
	MOVLW       _SPCTestingEN+0
	MOVWF       FARG_EEPROM_get_readbuffer+0 
	MOVLW       hi_addr(_SPCTestingEN+0)
	MOVWF       FARG_EEPROM_get_readbuffer+1 
	CALL        _EEPROM_get+0, 0
;Spcsystem.c,196 :: 		SPCCalibrationBox.CalibartionType = 25;
	MOVLW       25
	MOVWF       _SPCCalibrationBox+0 
;Spcsystem.c,198 :: 		LATC2_bit = 0;
	BCF         LATC2_bit+0, BitPos(LATC2_bit+0) 
;Spcsystem.c,199 :: 		LATC5_bit = 0;
	BCF         LATC5_bit+0, BitPos(LATC5_bit+0) 
;Spcsystem.c,200 :: 		KeyEn = 1;
	MOVLW       1
	MOVWF       _KeyEn+0 
;Spcsystem.c,202 :: 		if(pSPCValue[0].SPCSetPoints.system_valueb.bite.gfi_test_mod == GFI_TEST_NOW)
	MOVLW       3
	ANDWF       _pSPCValue+140, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPCSystemInitialize6
;Spcsystem.c,204 :: 		pSPCValue[0].SPCSetPoints.system_valueb.bite.gfi_test_mod = GFI_TEST_DISABLE;
	MOVLW       2
	XORWF       _pSPCValue+140, 0 
	MOVWF       R0 
	MOVLW       3
	ANDWF       R0, 1 
	MOVF        _pSPCValue+140, 0 
	XORWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _pSPCValue+140 
;Spcsystem.c,205 :: 		}
L_SPCSystemInitialize6:
;Spcsystem.c,207 :: 		if(pSPCValue[1].SPCSetPoints.system_valueb.bite.gfi_test_mod == GFI_TEST_NOW)
	MOVLW       3
	ANDWF       _pSPCValue+282, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPCSystemInitialize7
;Spcsystem.c,209 :: 		pSPCValue[1].SPCSetPoints.system_valueb.bite.gfi_test_mod = GFI_TEST_DISABLE;
	MOVLW       2
	XORWF       _pSPCValue+282, 0 
	MOVWF       R0 
	MOVLW       3
	ANDWF       R0, 1 
	MOVF        _pSPCValue+282, 0 
	XORWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _pSPCValue+282 
;Spcsystem.c,210 :: 		}
L_SPCSystemInitialize7:
;Spcsystem.c,211 :: 		}
L_end_SPCSystemInitialize:
	RETURN      0
; end of _SPCSystemInitialize

_MainTainTempDisable:

;Spcsystem.c,218 :: 		UCHAR MainTainTempDisable(char ChannelNum)
;Spcsystem.c,220 :: 		if(pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_NONE)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_MainTainTempDisable_ChannelNum+0, 0 
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
	GOTO        L__MainTainTempDisable551
	MOVLW       254
	XORWF       R1, 0 
L__MainTainTempDisable551:
	BTFSS       STATUS+0, 2 
	GOTO        L_MainTainTempDisable8
;Spcsystem.c,221 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_MainTainTempDisable
L_MainTainTempDisable8:
;Spcsystem.c,222 :: 		else if(pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_OFF)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_MainTainTempDisable_ChannelNum+0, 0 
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
	GOTO        L__MainTainTempDisable552
	MOVLW       255
	XORWF       R1, 0 
L__MainTainTempDisable552:
	BTFSS       STATUS+0, 2 
	GOTO        L_MainTainTempDisable10
;Spcsystem.c,223 :: 		return 2;
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_MainTainTempDisable
L_MainTainTempDisable10:
;Spcsystem.c,225 :: 		return 0;
	CLRF        R0 
;Spcsystem.c,226 :: 		}
L_end_MainTainTempDisable:
	RETURN      0
; end of _MainTainTempDisable

_ProCtlEnable:

;Spcsystem.c,233 :: 		UCHAR ProCtlEnable(char ChannelNum)
;Spcsystem.c,235 :: 		if(pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.ctl_type == FALSE)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_ProCtlEnable_ChannelNum+0, 0 
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
	GOTO        L_ProCtlEnable12
;Spcsystem.c,236 :: 		return 0;
	CLRF        R0 
	GOTO        L_end_ProCtlEnable
L_ProCtlEnable12:
;Spcsystem.c,238 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
;Spcsystem.c,239 :: 		}
L_end_ProCtlEnable:
	RETURN      0
; end of _ProCtlEnable

_SelfRegulaEnable:

;Spcsystem.c,246 :: 		UCHAR SelfRegulaEnable(char ChannelNum)
;Spcsystem.c,248 :: 		if(pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.heater_type == FALSE)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_SelfRegulaEnable_ChannelNum+0, 0 
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
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	BTFSC       R0, 7 
	GOTO        L_SelfRegulaEnable14
;Spcsystem.c,249 :: 		return 0;
	CLRF        R0 
	GOTO        L_end_SelfRegulaEnable
L_SelfRegulaEnable14:
;Spcsystem.c,251 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
;Spcsystem.c,252 :: 		}
L_end_SelfRegulaEnable:
	RETURN      0
; end of _SelfRegulaEnable

_SetSystemToDefault:

;Spcsystem.c,259 :: 		void SetSystemToDefault()
;Spcsystem.c,263 :: 		for(i=0;i<2;i++)
	CLRF        SetSystemToDefault_i_L0+0 
L_SetSystemToDefault16:
	MOVLW       2
	SUBWF       SetSystemToDefault_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SetSystemToDefault17
;Spcsystem.c,265 :: 		pSPCValue[i].SPCSetPoints.MaintainTemp.Temperature_C = MAINTAINTEMP_DEF_C;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
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
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       10
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Spcsystem.c,266 :: 		pSPCValue[i].SPCSetPoints.MaintainTemp.Temperature_F = MAINTAINTEMP_DEF_F;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
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
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       50
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Spcsystem.c,267 :: 		pSPCValue[i].SPCSetPoints.LowTemp.Temperature_C = LOWTEMPALARM_DEF_C;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
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
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       5
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Spcsystem.c,268 :: 		pSPCValue[i].SPCSetPoints.LowTemp.Temperature_F = LOWTEMPALARM_DEF_F;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
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
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       41
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Spcsystem.c,269 :: 		pSPCValue[i].SPCSetPoints.HighTemp.Temperature_C = SPC_SYSTEMVALUE_OFF;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
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
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       255
	MOVWF       POSTINC1+0 
	MOVLW       127
	MOVWF       POSTINC1+0 
;Spcsystem.c,270 :: 		pSPCValue[i].SPCSetPoints.HighTemp.Temperature_F = SPC_SYSTEMVALUE_OFF;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
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
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       255
	MOVWF       POSTINC1+0 
	MOVLW       127
	MOVWF       POSTINC1+0 
;Spcsystem.c,271 :: 		pSPCValue[i].SPCSetPoints.DeadBand.Temperature_C = DEADBAND_DEF_C;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
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
	MOVLW       12
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
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Spcsystem.c,272 :: 		pSPCValue[i].SPCSetPoints.DeadBand.Temperature_F = DEADBAND_DEF_F;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
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
	MOVLW       12
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       5
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Spcsystem.c,274 :: 		pSPCValue[i].SPCSetPoints.LowCurrent = SPC_SYSTEMVALUE_OFF;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
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
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       255
	MOVWF       POSTINC1+0 
	MOVLW       127
	MOVWF       POSTINC1+0 
;Spcsystem.c,275 :: 		pSPCValue[i].SPCSetPoints.HighCurrent = SPC_SYSTEMVALUE_OFF;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
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
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       255
	MOVWF       POSTINC1+0 
	MOVLW       127
	MOVWF       POSTINC1+0 
;Spcsystem.c,276 :: 		pSPCValue[i].SPCSetPoints.GFIAlarm = GFI_ALARM_DEF;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
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
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       30
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Spcsystem.c,277 :: 		pSPCValue[i].SPCSetPoints.GFITrip = GFI_TRIP_DEF;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
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
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       50
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Spcsystem.c,279 :: 		pSPCValue[i].SPCSetPoints.LowVoltage = SPC_SYSTEMVALUE_OFF;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
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
	MOVLW       24
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       255
	MOVWF       POSTINC1+0 
	MOVLW       127
	MOVWF       POSTINC1+0 
;Spcsystem.c,280 :: 		pSPCValue[i].SPCSetPoints.HighVoltage = SPC_SYSTEMVALUE_OFF;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
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
	MOVLW       26
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       255
	MOVWF       POSTINC1+0 
	MOVLW       127
	MOVWF       POSTINC1+0 
;Spcsystem.c,282 :: 		pSPCValue[i].SPCSetPoints.LimitedCurrent = SPC_SYSTEMVALUE_OFF;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
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
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       255
	MOVWF       POSTINC1+0 
	MOVLW       127
	MOVWF       POSTINC1+0 
;Spcsystem.c,283 :: 		pSPCValue[i].SPCSetPoints.SoftStartTime = SPC_SYSTEMVALUE_OFF;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
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
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       255
	MOVWF       POSTINC1+0 
	MOVLW       127
	MOVWF       POSTINC1+0 
;Spcsystem.c,285 :: 		pSPCValue[i].SPCSetPoints.AutoTestTime = AUTOTESTCYCLE_DEF;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
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
	MOVLW       32
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       24
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Spcsystem.c,287 :: 		pSPCValue[i].SPCSetPoints.DisplayTime = DISPLAY_TIME_DEF;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
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
	MOVLW       34
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       120
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Spcsystem.c,288 :: 		pSPCValue[i].SPCSetPoints.CostPerKWH = COSTPERKWH_DEF;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
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
	MOVLW       36
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       5
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Spcsystem.c,289 :: 		pSPCValue[i].SPCSetPoints.ScanSpeed = SCANSPEED_LOW;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
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
	MOVLW       38
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       3
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Spcsystem.c,290 :: 		pSPCValue[i].SPCSetPoints.ModbusAdd = MODBUSADD_LOW;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
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
	MOVLW       40
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Spcsystem.c,291 :: 		pSPCValue[i].SPCSetPoints.BaudRate = BAUDRATE_9600;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
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
	MOVLW       42
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       3
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Spcsystem.c,293 :: 		pSPCValue[i].SPCSetPoints.AlarmOutTest = SPC_SYSTEMVALUE_DISABLE;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
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
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       252
	MOVWF       POSTINC1+0 
	MOVLW       127
	MOVWF       POSTINC1+0 
;Spcsystem.c,294 :: 		pSPCValue[i].SPCSetPoints.HeaterTest = SPC_SYSTEMVALUE_DISABLE;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
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
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       252
	MOVWF       POSTINC1+0 
	MOVLW       127
	MOVWF       POSTINC1+0 
;Spcsystem.c,295 :: 		pSPCValue[i].SPCSetPoints.GFTest = GFI_TEST_DISABLE;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
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
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       2
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Spcsystem.c,297 :: 		ClearStr(pSPCValue[i].SPCSetPoints.HeaterName, 16);
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 0 
	MOVWF       FARG_ClearStr_target+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_ClearStr_target+1 
	MOVLW       54
	ADDWF       FARG_ClearStr_target+0, 1 
	MOVLW       0
	ADDWFC      FARG_ClearStr_target+1, 1 
	MOVLW       50
	ADDWF       FARG_ClearStr_target+0, 1 
	MOVLW       0
	ADDWFC      FARG_ClearStr_target+1, 1 
	MOVLW       16
	MOVWF       FARG_ClearStr_len+0 
	MOVLW       0
	MOVWF       FARG_ClearStr_len+1 
	CALL        _ClearStr+0, 0
;Spcsystem.c,301 :: 		pSPCValue[i].SPCSetPoints.system_valueb.bite.heater_en = TRUE;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
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
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	BSF         POSTINC1+0, 1 
;Spcsystem.c,302 :: 		pSPCValue[i].SPCSetPoints.system_valueb.bite.man_on = FALSE;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
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
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	BCF         POSTINC1+0, 2 
;Spcsystem.c,303 :: 		pSPCValue[i].SPCSetPoints.system_valueb.bite.ctl_type = FALSE;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
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
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	BCF         POSTINC1+0, 3 
;Spcsystem.c,304 :: 		pSPCValue[i].SPCSetPoints.system_valueb.bite.rtd_opr = ONE_RTD_MOD;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
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
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       143
	ANDWF       R0, 1 
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,305 :: 		pSPCValue[i].SPCSetPoints.system_valueb.bite.rtd_fail_mod = FALSE;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
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
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	BCF         POSTINC1+0, 7 
;Spcsystem.c,307 :: 		pSPCValue[i].SPCSetPoints.system_valueb.bite.spc_units_c = TRUE;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
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
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	BSF         POSTINC1+0, 0 
;Spcsystem.c,308 :: 		pSPCValue[i].SPCSetPoints.system_valueb.bite.usr_advanced = TRUE;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
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
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	BSF         POSTINC1+0, 1 
;Spcsystem.c,311 :: 		pSPCValue[i].SPCSetPoints.system_valueb.bite.def_display = HEATER_STATUS_MOD;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
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
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       4
	XORWF       R1, 0 
	MOVWF       R0 
	MOVLW       12
	ANDWF       R0, 1 
	MOVF        R1, 0 
	XORWF       R0, 1 
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,312 :: 		pSPCValue[i].SPCSetPoints.system_valueb.bite.gfi_test_mod = GFI_TEST_DISABLE;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
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
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       2
	XORWF       R1, 0 
	MOVWF       R0 
	MOVLW       3
	ANDWF       R0, 1 
	MOVF        R1, 0 
	XORWF       R0, 1 
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,313 :: 		pSPCValue[i].SPCSetPoints.system_valueb.bite.heater_type = 1;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
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
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	BSF         POSTINC1+0, 7 
;Spcsystem.c,314 :: 		pSPCValue[i].SPCSetPoints.system_valueb.bite.baud = BAUDRATE_9600;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SetSystemToDefault_i_L0+0, 0 
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
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       48
	XORWF       R1, 0 
	MOVWF       R0 
	MOVLW       112
	ANDWF       R0, 1 
	MOVF        R1, 0 
	XORWF       R0, 1 
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,317 :: 		Statis_flag[i] = (STATIS_MAX_TEMP + STATIS_MIN_TEMP + STATIS_MAX_VOLT + STATIS_MIN_VOLT + STATIS_CURRENT + STATIS_GFI);
	MOVLW       _Statis_flag+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_Statis_flag+0)
	MOVWF       FSR1H 
	MOVF        SetSystemToDefault_i_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       63
	MOVWF       POSTINC1+0 
;Spcsystem.c,263 :: 		for(i=0;i<2;i++)
	INCF        SetSystemToDefault_i_L0+0, 1 
;Spcsystem.c,318 :: 		}
	GOTO        L_SetSystemToDefault16
L_SetSystemToDefault17:
;Spcsystem.c,319 :: 		ClearStr(pSPCValue[0].SPCSetPoints.Password, 16);
	MOVLW       _pSPCValue+120
	MOVWF       FARG_ClearStr_target+0 
	MOVLW       hi_addr(_pSPCValue+120)
	MOVWF       FARG_ClearStr_target+1 
	MOVLW       16
	MOVWF       FARG_ClearStr_len+0 
	MOVLW       0
	MOVWF       FARG_ClearStr_len+1 
	CALL        _ClearStr+0, 0
;Spcsystem.c,320 :: 		getParaChar(pSPCValue[0].SPCSetPoints.Password, DEFAULT_PSW_STR);
	MOVLW       _pSPCValue+120
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_pSPCValue+120)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       78
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,321 :: 		pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en = 1;
	BSF         _pSPCValue+139, 0 
;Spcsystem.c,323 :: 		EEPROM_set(0x01,sizeof(SPCSETPIONTS),(UCHAR*)(&pSPCValue[0].SPCSetPoints));
	MOVLW       1
	MOVWF       FARG_EEPROM_set_EEPROM_WRITE_ADDRESS+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_set_EEPROM_WRITE_ADDRESS+1 
	MOVLW       88
	MOVWF       FARG_EEPROM_set_Len+0 
	MOVLW       _pSPCValue+54
	MOVWF       FARG_EEPROM_set_writebuffer+0 
	MOVLW       hi_addr(_pSPCValue+54)
	MOVWF       FARG_EEPROM_set_writebuffer+1 
	CALL        _EEPROM_set+0, 0
;Spcsystem.c,324 :: 		EEPROM_set(0x01+sizeof(SPCSETPIONTS),sizeof(SPCSETPIONTS),(UCHAR*)(&pSPCValue[1].SPCSetPoints));
	MOVLW       89
	MOVWF       FARG_EEPROM_set_EEPROM_WRITE_ADDRESS+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_set_EEPROM_WRITE_ADDRESS+1 
	MOVLW       88
	MOVWF       FARG_EEPROM_set_Len+0 
	MOVLW       _pSPCValue+196
	MOVWF       FARG_EEPROM_set_writebuffer+0 
	MOVLW       hi_addr(_pSPCValue+196)
	MOVWF       FARG_EEPROM_set_writebuffer+1 
	CALL        _EEPROM_set+0, 0
;Spcsystem.c,326 :: 		EEPROM_set(0x01+2*sizeof(SPCSETPIONTS),sizeof(STATISTICS),(UCHAR*)(&pSPCValue[0].SPCStatistics));
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
;Spcsystem.c,327 :: 		EEPROM_set(0x01+2*sizeof(SPCSETPIONTS)+sizeof(STATISTICS),sizeof(STATISTICS),(UCHAR*)(&pSPCValue[1].SPCStatistics));
	MOVLW       207
	MOVWF       FARG_EEPROM_set_EEPROM_WRITE_ADDRESS+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_set_EEPROM_WRITE_ADDRESS+1 
	MOVLW       30
	MOVWF       FARG_EEPROM_set_Len+0 
	MOVLW       _pSPCValue+166
	MOVWF       FARG_EEPROM_set_writebuffer+0 
	MOVLW       hi_addr(_pSPCValue+166)
	MOVWF       FARG_EEPROM_set_writebuffer+1 
	CALL        _EEPROM_set+0, 0
;Spcsystem.c,328 :: 		EEPROM_set(0x01+2*sizeof(SPCSETPIONTS)+2*sizeof(STATISTICS),sizeof(SPCLOG),(UCHAR*)(&pSPCAlarm.spclogs));
	MOVLW       237
	MOVWF       FARG_EEPROM_set_EEPROM_WRITE_ADDRESS+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_set_EEPROM_WRITE_ADDRESS+1 
	MOVLW       81
	MOVWF       FARG_EEPROM_set_Len+0 
	MOVLW       _pSPCAlarm+81
	MOVWF       FARG_EEPROM_set_writebuffer+0 
	MOVLW       hi_addr(_pSPCAlarm+81)
	MOVWF       FARG_EEPROM_set_writebuffer+1 
	CALL        _EEPROM_set+0, 0
;Spcsystem.c,329 :: 		}
L_end_SetSystemToDefault:
	RETURN      0
; end of _SetSystemToDefault

_SetSystemFromEEP:

;Spcsystem.c,336 :: 		void SetSystemFromEEP()
;Spcsystem.c,341 :: 		EEPROM_get(0x01,sizeof(SPCSETPIONTS),(UCHAR*)(&pSPCValue[0].SPCSetPoints));
	MOVLW       1
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+1 
	MOVLW       88
	MOVWF       FARG_EEPROM_get_Len+0 
	MOVLW       _pSPCValue+54
	MOVWF       FARG_EEPROM_get_readbuffer+0 
	MOVLW       hi_addr(_pSPCValue+54)
	MOVWF       FARG_EEPROM_get_readbuffer+1 
	CALL        _EEPROM_get+0, 0
;Spcsystem.c,342 :: 		EEPROM_get(0x01+sizeof(SPCSETPIONTS),sizeof(SPCSETPIONTS),(UCHAR*)(&pSPCValue[1].SPCSetPoints));
	MOVLW       89
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+1 
	MOVLW       88
	MOVWF       FARG_EEPROM_get_Len+0 
	MOVLW       _pSPCValue+196
	MOVWF       FARG_EEPROM_get_readbuffer+0 
	MOVLW       hi_addr(_pSPCValue+196)
	MOVWF       FARG_EEPROM_get_readbuffer+1 
	CALL        _EEPROM_get+0, 0
;Spcsystem.c,344 :: 		EEPROM_get(0x01+2*sizeof(SPCSETPIONTS),sizeof(STATISTICS),(UCHAR*)(&pSPCValue[0].SPCStatistics));
	MOVLW       177
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+1 
	MOVLW       30
	MOVWF       FARG_EEPROM_get_Len+0 
	MOVLW       _pSPCValue+24
	MOVWF       FARG_EEPROM_get_readbuffer+0 
	MOVLW       hi_addr(_pSPCValue+24)
	MOVWF       FARG_EEPROM_get_readbuffer+1 
	CALL        _EEPROM_get+0, 0
;Spcsystem.c,345 :: 		EEPROM_get(0x01+2*sizeof(SPCSETPIONTS)+sizeof(STATISTICS),sizeof(STATISTICS),(UCHAR*)(&pSPCValue[1].SPCStatistics));
	MOVLW       207
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+1 
	MOVLW       30
	MOVWF       FARG_EEPROM_get_Len+0 
	MOVLW       _pSPCValue+166
	MOVWF       FARG_EEPROM_get_readbuffer+0 
	MOVLW       hi_addr(_pSPCValue+166)
	MOVWF       FARG_EEPROM_get_readbuffer+1 
	CALL        _EEPROM_get+0, 0
;Spcsystem.c,346 :: 		EEPROM_get(0x01+2*sizeof(SPCSETPIONTS)+2*sizeof(STATISTICS),sizeof(SPCLOG),(UCHAR*)(&pSPCAlarm.spclogs));
	MOVLW       237
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+1 
	MOVLW       81
	MOVWF       FARG_EEPROM_get_Len+0 
	MOVLW       _pSPCAlarm+81
	MOVWF       FARG_EEPROM_get_readbuffer+0 
	MOVLW       hi_addr(_pSPCAlarm+81)
	MOVWF       FARG_EEPROM_get_readbuffer+1 
	CALL        _EEPROM_get+0, 0
;Spcsystem.c,349 :: 		units = pSPCValue[0].SPCSetPoints.system_valueb.bite.spc_units_c;
	MOVLW       0
	BTFSC       _pSPCValue+138, 0 
	MOVLW       1
	MOVWF       SetSystemFromEEP_units_L0+0 
;Spcsystem.c,350 :: 		temp_ptr = (signed int *)(&pSPCValue[Cable_Channel].SPCStatistics.MaximumTemp) + units;
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
	ADDWF       R0, 0 
	MOVWF       FARG_SetTempStatStr_temp+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_SetTempStatStr_temp+1 
	MOVLW       24
	ADDWF       FARG_SetTempStatStr_temp+0, 1 
	MOVLW       0
	ADDWFC      FARG_SetTempStatStr_temp+1, 1 
	MOVF        SetSystemFromEEP_units_L0+0, 0 
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
;Spcsystem.c,351 :: 		SetTempStatStr(temp_ptr, CH1_ACTURAL_MAX, Cable_Channel);
	MOVLW       12
	MOVWF       FARG_SetTempStatStr_strlocat+0 
	MOVF        _Cable_Channel+0, 0 
	MOVWF       FARG_SetTempStatStr_ChannelNum+0 
	CALL        _SetTempStatStr+0, 0
;Spcsystem.c,352 :: 		temp_ptr = (signed int *)(&pSPCValue[Cable_Channel].SPCStatistics.MinimumTemp) + units;
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
	MOVF        SetSystemFromEEP_units_L0+0, 0 
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
;Spcsystem.c,353 :: 		SetTempStatStr(temp_ptr,CH1_ACTURAL_MIN, Cable_Channel);
	MOVLW       14
	MOVWF       FARG_SetTempStatStr_strlocat+0 
	MOVF        _Cable_Channel+0, 0 
	MOVWF       FARG_SetTempStatStr_ChannelNum+0 
	CALL        _SetTempStatStr+0, 0
;Spcsystem.c,354 :: 		SetIntStr((int*)&pSPCValue[Cable_Channel].SPCStatistics.MaximumGFCurrent, CH1_ACTURAL_GFI_MAX+Cable_Channel, UNIT_MILIAMPER, 2);
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
	MOVF        _Cable_Channel+0, 0 
	ADDLW       22
	MOVWF       FARG_SetIntStr_strlocat+0 
	MOVLW       5
	MOVWF       FARG_SetIntStr_unitlocar+0 
	MOVLW       2
	MOVWF       FARG_SetIntStr_len+0 
	CALL        _SetIntStr+0, 0
;Spcsystem.c,355 :: 		SetCurrentStr((int*)&pSPCValue[Cable_Channel].SPCStatistics.MaximumCurrent, CH1_ACTURAL_CURRENT_MAX+Cable_Channel, UNIT_AMPER, 1);
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
	MOVF        _Cable_Channel+0, 0 
	ADDLW       20
	MOVWF       FARG_SetCurrentStr_strlocat+0 
	MOVLW       4
	MOVWF       FARG_SetCurrentStr_unitlocar+0 
	MOVLW       1
	MOVWF       FARG_SetCurrentStr_len+0 
	CALL        _SetCurrentStr+0, 0
;Spcsystem.c,356 :: 		SetIntStr((int*)&pSPCValue[Cable_Channel].SPCStatistics.MaximumVoltage, ACTURAL_VOLT_MAX+Cable_Channel, UNIT_ACVOLT, 1);
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
	ADDWF       R0, 0 
	MOVWF       FARG_SetIntStr_ptr+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_SetIntStr_ptr+1 
	MOVLW       24
	ADDWF       FARG_SetIntStr_ptr+0, 1 
	MOVLW       0
	ADDWFC      FARG_SetIntStr_ptr+1, 1 
	MOVLW       12
	ADDWF       FARG_SetIntStr_ptr+0, 1 
	MOVLW       0
	ADDWFC      FARG_SetIntStr_ptr+1, 1 
	MOVF        _Cable_Channel+0, 0 
	ADDLW       32
	MOVWF       FARG_SetIntStr_strlocat+0 
	MOVLW       6
	MOVWF       FARG_SetIntStr_unitlocar+0 
	MOVLW       1
	MOVWF       FARG_SetIntStr_len+0 
	CALL        _SetIntStr+0, 0
;Spcsystem.c,357 :: 		SetIntStr((int*)&pSPCValue[Cable_Channel].SPCStatistics.MinimumVoltage, ACTURAL_VOLT_MIN+Cable_Channel, UNIT_ACVOLT, 1);
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
	ADDWF       R0, 0 
	MOVWF       FARG_SetIntStr_ptr+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_SetIntStr_ptr+1 
	MOVLW       24
	ADDWF       FARG_SetIntStr_ptr+0, 1 
	MOVLW       0
	ADDWFC      FARG_SetIntStr_ptr+1, 1 
	MOVLW       14
	ADDWF       FARG_SetIntStr_ptr+0, 1 
	MOVLW       0
	ADDWFC      FARG_SetIntStr_ptr+1, 1 
	MOVF        _Cable_Channel+0, 0 
	ADDLW       34
	MOVWF       FARG_SetIntStr_strlocat+0 
	MOVLW       6
	MOVWF       FARG_SetIntStr_unitlocar+0 
	MOVLW       1
	MOVWF       FARG_SetIntStr_len+0 
	CALL        _SetIntStr+0, 0
;Spcsystem.c,358 :: 		}
L_end_SetSystemFromEEP:
	RETURN      0
; end of _SetSystemFromEEP

_TitleSet:

;Spcsystem.c,365 :: 		void TitleSet(UCHAR direct, UCHAR cmd)
;Spcsystem.c,369 :: 		for(i=0;i<16;i++)
	CLRF        TitleSet_i_L0+0 
L_TitleSet19:
	MOVLW       16
	SUBWF       TitleSet_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_TitleSet20
;Spcsystem.c,370 :: 		Info_Line2[i] = SPCTitle[SpcMenu[Menustat].offset][i];
	MOVLW       _Info_Line2+0
	MOVWF       FLOC__TitleSet+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FLOC__TitleSet+1 
	MOVF        TitleSet_i_L0+0, 0 
	ADDWF       FLOC__TitleSet+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__TitleSet+1, 1 
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
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
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVLW       20
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       Spcsystem_SPCTitle+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SPCTitle+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SPCTitle+0)
	ADDWFC      R2, 1 
	MOVF        TitleSet_i_L0+0, 0 
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
	MOVFF       FLOC__TitleSet+0, FSR1
	MOVFF       FLOC__TitleSet+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,369 :: 		for(i=0;i<16;i++)
	INCF        TitleSet_i_L0+0, 1 
;Spcsystem.c,370 :: 		Info_Line2[i] = SPCTitle[SpcMenu[Menustat].offset][i];
	GOTO        L_TitleSet19
L_TitleSet20:
;Spcsystem.c,371 :: 		asm nop;
	NOP
;Spcsystem.c,372 :: 		}
L_end_TitleSet:
	RETURN      0
; end of _TitleSet

_ChannelConfig:

;Spcsystem.c,379 :: 		void ChannelConfig(UCHAR direct, UCHAR cmd)
;Spcsystem.c,383 :: 		if(cmd == CMD_ENTER)
	MOVF        FARG_ChannelConfig_cmd+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_ChannelConfig22
;Spcsystem.c,388 :: 		Cable_Channel = ChannelConfigMirror;
	MOVF        ChannelConfig_ChannelConfigMirror_L0+0, 0 
	MOVWF       _Cable_Channel+0 
;Spcsystem.c,389 :: 		storage();
	CALL        _storage+0, 0
;Spcsystem.c,390 :: 		ParametersChanged = 1;
	MOVLW       1
	MOVWF       _ParametersChanged+0 
;Spcsystem.c,391 :: 		}
	GOTO        L_ChannelConfig23
L_ChannelConfig22:
;Spcsystem.c,392 :: 		else if(cmd == CMD_RESET)
	MOVF        FARG_ChannelConfig_cmd+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_ChannelConfig24
;Spcsystem.c,394 :: 		getParaChar(Info_Line2, CHANNEL1_STR+Cable_Channel);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVF        _Cable_Channel+0, 0 
	ADDLW       96
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,395 :: 		ChannelConfigMirror = Cable_Channel;
	MOVF        _Cable_Channel+0, 0 
	MOVWF       ChannelConfig_ChannelConfigMirror_L0+0 
;Spcsystem.c,396 :: 		}
	GOTO        L_ChannelConfig25
L_ChannelConfig24:
;Spcsystem.c,397 :: 		else if(cmd == CMD_ADJUST)
	MOVF        FARG_ChannelConfig_cmd+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_ChannelConfig26
;Spcsystem.c,402 :: 		if(direct)
	MOVF        FARG_ChannelConfig_direct+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_ChannelConfig27
;Spcsystem.c,404 :: 		if(ChannelConfigMirror == 0)
	MOVF        ChannelConfig_ChannelConfigMirror_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_ChannelConfig28
;Spcsystem.c,406 :: 		ChannelConfigMirror = 1;
	MOVLW       1
	MOVWF       ChannelConfig_ChannelConfigMirror_L0+0 
;Spcsystem.c,407 :: 		getParaChar(Info_Line2, CHANNEL1_STR+ChannelConfigMirror);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       97
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,408 :: 		}
L_ChannelConfig28:
;Spcsystem.c,409 :: 		}
	GOTO        L_ChannelConfig29
L_ChannelConfig27:
;Spcsystem.c,412 :: 		if(ChannelConfigMirror == 1)
	MOVF        ChannelConfig_ChannelConfigMirror_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_ChannelConfig30
;Spcsystem.c,414 :: 		ChannelConfigMirror = 0;
	CLRF        ChannelConfig_ChannelConfigMirror_L0+0 
;Spcsystem.c,415 :: 		getParaChar(Info_Line2, CHANNEL1_STR+ChannelConfigMirror);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       96
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,416 :: 		}
L_ChannelConfig30:
;Spcsystem.c,417 :: 		}
L_ChannelConfig29:
;Spcsystem.c,418 :: 		}
L_ChannelConfig26:
L_ChannelConfig25:
L_ChannelConfig23:
;Spcsystem.c,419 :: 		}
L_end_ChannelConfig:
	RETURN      0
; end of _ChannelConfig

_MaintainTempSet:

;Spcsystem.c,426 :: 		void MaintainTempSet(UCHAR direct, UCHAR cmd)
;Spcsystem.c,431 :: 		units = pSPCValue[0].SPCSetPoints.system_valueb.bite.spc_units_c;
	MOVLW       0
	BTFSC       _pSPCValue+138, 0 
	MOVLW       1
	MOVWF       MaintainTempSet_units_L0+0 
	CLRF        MaintainTempSet_units_L0+1 
;Spcsystem.c,432 :: 		ptr = (int *)(&SetP_shade.MaintainTemp);
	MOVLW       _SetP_shade+0
	MOVWF       MaintainTempSet_ptr_L0+0 
	MOVLW       hi_addr(_SetP_shade+0)
	MOVWF       MaintainTempSet_ptr_L0+1 
;Spcsystem.c,434 :: 		if(units)
	MOVF        MaintainTempSet_units_L0+0, 0 
	IORWF       MaintainTempSet_units_L0+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_MaintainTempSet31
;Spcsystem.c,436 :: 		maxtemp = MAX_TEMP_C;
	MOVLW       244
	MOVWF       MaintainTempSet_maxtemp_L0+0 
	MOVLW       1
	MOVWF       MaintainTempSet_maxtemp_L0+1 
;Spcsystem.c,437 :: 		mintemp = MIN_TEMP_C;
	MOVLW       206
	MOVWF       MaintainTempSet_mintemp_L0+0 
	MOVLW       255
	MOVWF       MaintainTempSet_mintemp_L0+1 
;Spcsystem.c,438 :: 		}
	GOTO        L_MaintainTempSet32
L_MaintainTempSet31:
;Spcsystem.c,441 :: 		maxtemp = MAX_TEMP_F;
	MOVLW       164
	MOVWF       MaintainTempSet_maxtemp_L0+0 
	MOVLW       3
	MOVWF       MaintainTempSet_maxtemp_L0+1 
;Spcsystem.c,442 :: 		mintemp = MIN_TEMP_F;
	MOVLW       198
	MOVWF       MaintainTempSet_mintemp_L0+0 
	MOVLW       255
	MOVWF       MaintainTempSet_mintemp_L0+1 
;Spcsystem.c,443 :: 		}
L_MaintainTempSet32:
;Spcsystem.c,445 :: 		if(cmd == CMD_ENTER)
	MOVF        FARG_MaintainTempSet_cmd+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_MaintainTempSet33
;Spcsystem.c,447 :: 		if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
	BTFSC       _pSPCValue+139, 0 
	GOTO        L_MaintainTempSet34
;Spcsystem.c,448 :: 		return;
	GOTO        L_end_MaintainTempSet
L_MaintainTempSet34:
;Spcsystem.c,451 :: 		(SetP_shade.MaintainTemp.Temperature_C != SPC_SYSTEMVALUE_NONE))
	MOVF        _SetP_shade+3, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__MaintainTempSet560
	MOVLW       255
	XORWF       _SetP_shade+2, 0 
L__MaintainTempSet560:
	BTFSC       STATUS+0, 2 
	GOTO        L_MaintainTempSet37
	MOVF        _SetP_shade+3, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__MaintainTempSet561
	MOVLW       254
	XORWF       _SetP_shade+2, 0 
L__MaintainTempSet561:
	BTFSC       STATUS+0, 2 
	GOTO        L_MaintainTempSet37
L__MaintainTempSet526:
;Spcsystem.c,452 :: 		ConvertTemp(&SetP_shade.MaintainTemp);
	MOVLW       _SetP_shade+0
	MOVWF       FARG_ConvertTemp_temptocon+0 
	MOVLW       hi_addr(_SetP_shade+0)
	MOVWF       FARG_ConvertTemp_temptocon+1 
	CALL        _ConvertTemp+0, 0
L_MaintainTempSet37:
;Spcsystem.c,454 :: 		CopyTemp(&SetP_shade.MaintainTemp, &pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp);
	MOVLW       _SetP_shade+0
	MOVWF       FARG_CopyTemp_tempsource+0 
	MOVLW       hi_addr(_SetP_shade+0)
	MOVWF       FARG_CopyTemp_tempsource+1 
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
	ADDWF       R0, 0 
	MOVWF       FARG_CopyTemp_temptarget+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_CopyTemp_temptarget+1 
	MOVLW       54
	ADDWF       FARG_CopyTemp_temptarget+0, 1 
	MOVLW       0
	ADDWFC      FARG_CopyTemp_temptarget+1, 1 
	CALL        _CopyTemp+0, 0
;Spcsystem.c,455 :: 		storage();
	CALL        _storage+0, 0
;Spcsystem.c,456 :: 		ParametersChanged = 1;
	MOVLW       1
	MOVWF       _ParametersChanged+0 
;Spcsystem.c,457 :: 		}
	GOTO        L_MaintainTempSet38
L_MaintainTempSet33:
;Spcsystem.c,458 :: 		else if(cmd == CMD_RESET)
	MOVF        FARG_MaintainTempSet_cmd+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_MaintainTempSet39
;Spcsystem.c,460 :: 		CopyTemp(&pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp, &SetP_shade.MaintainTemp);
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
	ADDWF       R0, 0 
	MOVWF       FARG_CopyTemp_tempsource+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_CopyTemp_tempsource+1 
	MOVLW       54
	ADDWF       FARG_CopyTemp_tempsource+0, 1 
	MOVLW       0
	ADDWFC      FARG_CopyTemp_tempsource+1, 1 
	MOVLW       _SetP_shade+0
	MOVWF       FARG_CopyTemp_temptarget+0 
	MOVLW       hi_addr(_SetP_shade+0)
	MOVWF       FARG_CopyTemp_temptarget+1 
	CALL        _CopyTemp+0, 0
;Spcsystem.c,461 :: 		if(SetP_shade.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_OFF)
	MOVF        _SetP_shade+3, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__MaintainTempSet562
	MOVLW       255
	XORWF       _SetP_shade+2, 0 
L__MaintainTempSet562:
	BTFSS       STATUS+0, 2 
	GOTO        L_MaintainTempSet40
;Spcsystem.c,462 :: 		getParaChar(Info_Line2, OFF_STR);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       73
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
	GOTO        L_MaintainTempSet41
L_MaintainTempSet40:
;Spcsystem.c,463 :: 		else if(SetP_shade.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_NONE)
	MOVF        _SetP_shade+3, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__MaintainTempSet563
	MOVLW       254
	XORWF       _SetP_shade+2, 0 
L__MaintainTempSet563:
	BTFSS       STATUS+0, 2 
	GOTO        L_MaintainTempSet42
;Spcsystem.c,464 :: 		getParaChar(Info_Line2, NONE_STR);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       75
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
	GOTO        L_MaintainTempSet43
L_MaintainTempSet42:
;Spcsystem.c,466 :: 		FromIntToStr(*(ptr+units),Info_Line2,SpcMenu[Menustat].decimal);
	MOVF        MaintainTempSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        MaintainTempSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       MaintainTempSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      MaintainTempSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+1 
	MOVLW       0
	BTFSC       FARG_FromIntToStr_ValueResoure+3, 7 
	MOVLW       255
	MOVWF       FARG_FromIntToStr_ValueResoure+2 
	MOVWF       FARG_FromIntToStr_ValueResoure+3 
	MOVLW       0
	BTFSC       FARG_FromIntToStr_ValueResoure+1, 7 
	MOVLW       255
	MOVWF       FARG_FromIntToStr_ValueResoure+2 
	MOVWF       FARG_FromIntToStr_ValueResoure+3 
	MOVLW       _Info_Line2+0
	MOVWF       FARG_FromIntToStr_StringTarget+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_FromIntToStr_StringTarget+1 
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       17
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_FromIntToStr_offset+0
	CALL        _FromIntToStr+0, 0
L_MaintainTempSet43:
L_MaintainTempSet41:
;Spcsystem.c,467 :: 		}
	GOTO        L_MaintainTempSet44
L_MaintainTempSet39:
;Spcsystem.c,468 :: 		else if(cmd == CMD_ADJUST)
	MOVF        FARG_MaintainTempSet_cmd+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_MaintainTempSet45
;Spcsystem.c,470 :: 		if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
	BTFSC       _pSPCValue+139, 0 
	GOTO        L_MaintainTempSet46
;Spcsystem.c,471 :: 		return;
	GOTO        L_end_MaintainTempSet
L_MaintainTempSet46:
;Spcsystem.c,473 :: 		Flashing_EN();
	CALL        _Flashing_EN+0, 0
;Spcsystem.c,474 :: 		if(direct)
	MOVF        FARG_MaintainTempSet_direct+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_MaintainTempSet47
;Spcsystem.c,476 :: 		if(*(ptr+units) == SPC_SYSTEMVALUE_NONE)
	MOVF        MaintainTempSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        MaintainTempSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       MaintainTempSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      MaintainTempSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__MaintainTempSet564
	MOVLW       254
	XORWF       R1, 0 
L__MaintainTempSet564:
	BTFSS       STATUS+0, 2 
	GOTO        L_MaintainTempSet48
;Spcsystem.c,478 :: 		SetP_shade.MaintainTemp.Temperature_C = SPC_SYSTEMVALUE_OFF;
	MOVLW       255
	MOVWF       _SetP_shade+2 
	MOVLW       127
	MOVWF       _SetP_shade+3 
;Spcsystem.c,479 :: 		SetP_shade.MaintainTemp.Temperature_F = SPC_SYSTEMVALUE_OFF;
	MOVLW       255
	MOVWF       _SetP_shade+0 
	MOVLW       127
	MOVWF       _SetP_shade+1 
;Spcsystem.c,480 :: 		getParaChar(Info_Line2, OFF_STR);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       73
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,481 :: 		}
	GOTO        L_MaintainTempSet49
L_MaintainTempSet48:
;Spcsystem.c,482 :: 		else if(*(ptr+units) == maxtemp)
	MOVF        MaintainTempSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        MaintainTempSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       MaintainTempSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      MaintainTempSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORWF       MaintainTempSet_maxtemp_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__MaintainTempSet565
	MOVF        MaintainTempSet_maxtemp_L0+0, 0 
	XORWF       R1, 0 
L__MaintainTempSet565:
	BTFSS       STATUS+0, 2 
	GOTO        L_MaintainTempSet50
;Spcsystem.c,484 :: 		SetP_shade.MaintainTemp.Temperature_C = SPC_SYSTEMVALUE_NONE;
	MOVLW       254
	MOVWF       _SetP_shade+2 
	MOVLW       127
	MOVWF       _SetP_shade+3 
;Spcsystem.c,485 :: 		SetP_shade.MaintainTemp.Temperature_F = SPC_SYSTEMVALUE_NONE;
	MOVLW       254
	MOVWF       _SetP_shade+0 
	MOVLW       127
	MOVWF       _SetP_shade+1 
;Spcsystem.c,486 :: 		getParaChar(Info_Line2, NONE_STR);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       75
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,487 :: 		}
	GOTO        L_MaintainTempSet51
L_MaintainTempSet50:
;Spcsystem.c,488 :: 		else if(*(ptr+units) < maxtemp)
	MOVF        MaintainTempSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        MaintainTempSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       MaintainTempSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      MaintainTempSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       MaintainTempSet_maxtemp_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__MaintainTempSet566
	MOVF        MaintainTempSet_maxtemp_L0+0, 0 
	SUBWF       R1, 0 
L__MaintainTempSet566:
	BTFSC       STATUS+0, 0 
	GOTO        L_MaintainTempSet52
;Spcsystem.c,490 :: 		(*(ptr+units)) += KeyHoldStep;
	MOVF        MaintainTempSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        MaintainTempSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       MaintainTempSet_ptr_L0+0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	ADDWFC      MaintainTempSet_ptr_L0+1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        _KeyHoldStep+0, 0 
	ADDWF       R0, 1 
	MOVF        _KeyHoldStep+1, 0 
	ADDWFC      R1, 1 
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,491 :: 		if(*(ptr+units) > maxtemp) *(ptr+units) = maxtemp;
	MOVF        MaintainTempSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        MaintainTempSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       MaintainTempSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      MaintainTempSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       MaintainTempSet_maxtemp_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__MaintainTempSet567
	MOVF        R1, 0 
	SUBWF       MaintainTempSet_maxtemp_L0+0, 0 
L__MaintainTempSet567:
	BTFSC       STATUS+0, 0 
	GOTO        L_MaintainTempSet53
	MOVF        MaintainTempSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        MaintainTempSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       MaintainTempSet_ptr_L0+0, 0 
	MOVWF       FSR1 
	MOVF        R1, 0 
	ADDWFC      MaintainTempSet_ptr_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        MaintainTempSet_maxtemp_L0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        MaintainTempSet_maxtemp_L0+1, 0 
	MOVWF       POSTINC1+0 
L_MaintainTempSet53:
;Spcsystem.c,492 :: 		FromIntToStr(*(ptr+units),Info_Line2,SpcMenu[Menustat].decimal);
	MOVF        MaintainTempSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        MaintainTempSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       MaintainTempSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      MaintainTempSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+1 
	MOVLW       0
	BTFSC       FARG_FromIntToStr_ValueResoure+3, 7 
	MOVLW       255
	MOVWF       FARG_FromIntToStr_ValueResoure+2 
	MOVWF       FARG_FromIntToStr_ValueResoure+3 
	MOVLW       0
	BTFSC       FARG_FromIntToStr_ValueResoure+1, 7 
	MOVLW       255
	MOVWF       FARG_FromIntToStr_ValueResoure+2 
	MOVWF       FARG_FromIntToStr_ValueResoure+3 
	MOVLW       _Info_Line2+0
	MOVWF       FARG_FromIntToStr_StringTarget+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_FromIntToStr_StringTarget+1 
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       17
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_FromIntToStr_offset+0
	CALL        _FromIntToStr+0, 0
;Spcsystem.c,493 :: 		}
L_MaintainTempSet52:
L_MaintainTempSet51:
L_MaintainTempSet49:
;Spcsystem.c,494 :: 		}
	GOTO        L_MaintainTempSet54
L_MaintainTempSet47:
;Spcsystem.c,497 :: 		if(*(ptr+units) == SPC_SYSTEMVALUE_OFF)
	MOVF        MaintainTempSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        MaintainTempSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       MaintainTempSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      MaintainTempSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__MaintainTempSet568
	MOVLW       255
	XORWF       R1, 0 
L__MaintainTempSet568:
	BTFSS       STATUS+0, 2 
	GOTO        L_MaintainTempSet55
;Spcsystem.c,499 :: 		SetP_shade.MaintainTemp.Temperature_C = SPC_SYSTEMVALUE_NONE;
	MOVLW       254
	MOVWF       _SetP_shade+2 
	MOVLW       127
	MOVWF       _SetP_shade+3 
;Spcsystem.c,500 :: 		SetP_shade.MaintainTemp.Temperature_F = SPC_SYSTEMVALUE_NONE;
	MOVLW       254
	MOVWF       _SetP_shade+0 
	MOVLW       127
	MOVWF       _SetP_shade+1 
;Spcsystem.c,501 :: 		getParaChar(Info_Line2, NONE_STR);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       75
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,502 :: 		}
	GOTO        L_MaintainTempSet56
L_MaintainTempSet55:
;Spcsystem.c,503 :: 		else if(*(ptr+units) == SPC_SYSTEMVALUE_NONE)
	MOVF        MaintainTempSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        MaintainTempSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       MaintainTempSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      MaintainTempSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__MaintainTempSet569
	MOVLW       254
	XORWF       R1, 0 
L__MaintainTempSet569:
	BTFSS       STATUS+0, 2 
	GOTO        L_MaintainTempSet57
;Spcsystem.c,505 :: 		*(ptr+units) = maxtemp;
	MOVF        MaintainTempSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        MaintainTempSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       MaintainTempSet_ptr_L0+0, 0 
	MOVWF       FSR1 
	MOVF        R1, 0 
	ADDWFC      MaintainTempSet_ptr_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        MaintainTempSet_maxtemp_L0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        MaintainTempSet_maxtemp_L0+1, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,506 :: 		ConvertTemp(&SetP_shade.MaintainTemp);
	MOVLW       _SetP_shade+0
	MOVWF       FARG_ConvertTemp_temptocon+0 
	MOVLW       hi_addr(_SetP_shade+0)
	MOVWF       FARG_ConvertTemp_temptocon+1 
	CALL        _ConvertTemp+0, 0
;Spcsystem.c,507 :: 		FromIntToStr(*(ptr+units),Info_Line2,SpcMenu[Menustat].decimal);
	MOVF        MaintainTempSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        MaintainTempSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       MaintainTempSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      MaintainTempSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+1 
	MOVLW       0
	BTFSC       FARG_FromIntToStr_ValueResoure+3, 7 
	MOVLW       255
	MOVWF       FARG_FromIntToStr_ValueResoure+2 
	MOVWF       FARG_FromIntToStr_ValueResoure+3 
	MOVLW       0
	BTFSC       FARG_FromIntToStr_ValueResoure+1, 7 
	MOVLW       255
	MOVWF       FARG_FromIntToStr_ValueResoure+2 
	MOVWF       FARG_FromIntToStr_ValueResoure+3 
	MOVLW       _Info_Line2+0
	MOVWF       FARG_FromIntToStr_StringTarget+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_FromIntToStr_StringTarget+1 
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       17
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_FromIntToStr_offset+0
	CALL        _FromIntToStr+0, 0
;Spcsystem.c,508 :: 		}
	GOTO        L_MaintainTempSet58
L_MaintainTempSet57:
;Spcsystem.c,509 :: 		else if(*(ptr+units) > mintemp)
	MOVF        MaintainTempSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        MaintainTempSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       MaintainTempSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      MaintainTempSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       MaintainTempSet_mintemp_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__MaintainTempSet570
	MOVF        R1, 0 
	SUBWF       MaintainTempSet_mintemp_L0+0, 0 
L__MaintainTempSet570:
	BTFSC       STATUS+0, 0 
	GOTO        L_MaintainTempSet59
;Spcsystem.c,511 :: 		(*(ptr+units)) -= KeyHoldStep;
	MOVF        MaintainTempSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        MaintainTempSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       MaintainTempSet_ptr_L0+0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	ADDWFC      MaintainTempSet_ptr_L0+1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        _KeyHoldStep+0, 0 
	SUBWF       R0, 1 
	MOVF        _KeyHoldStep+1, 0 
	SUBWFB      R1, 1 
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,512 :: 		if(*(ptr+units) < mintemp) *(ptr+units) = mintemp;
	MOVF        MaintainTempSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        MaintainTempSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       MaintainTempSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      MaintainTempSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       MaintainTempSet_mintemp_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__MaintainTempSet571
	MOVF        MaintainTempSet_mintemp_L0+0, 0 
	SUBWF       R1, 0 
L__MaintainTempSet571:
	BTFSC       STATUS+0, 0 
	GOTO        L_MaintainTempSet60
	MOVF        MaintainTempSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        MaintainTempSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       MaintainTempSet_ptr_L0+0, 0 
	MOVWF       FSR1 
	MOVF        R1, 0 
	ADDWFC      MaintainTempSet_ptr_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        MaintainTempSet_mintemp_L0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        MaintainTempSet_mintemp_L0+1, 0 
	MOVWF       POSTINC1+0 
L_MaintainTempSet60:
;Spcsystem.c,513 :: 		FromIntToStr(*(ptr+units),Info_Line2,SpcMenu[Menustat].decimal);
	MOVF        MaintainTempSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        MaintainTempSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       MaintainTempSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      MaintainTempSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+1 
	MOVLW       0
	BTFSC       FARG_FromIntToStr_ValueResoure+3, 7 
	MOVLW       255
	MOVWF       FARG_FromIntToStr_ValueResoure+2 
	MOVWF       FARG_FromIntToStr_ValueResoure+3 
	MOVLW       0
	BTFSC       FARG_FromIntToStr_ValueResoure+1, 7 
	MOVLW       255
	MOVWF       FARG_FromIntToStr_ValueResoure+2 
	MOVWF       FARG_FromIntToStr_ValueResoure+3 
	MOVLW       _Info_Line2+0
	MOVWF       FARG_FromIntToStr_StringTarget+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_FromIntToStr_StringTarget+1 
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       17
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_FromIntToStr_offset+0
	CALL        _FromIntToStr+0, 0
;Spcsystem.c,514 :: 		}
L_MaintainTempSet59:
L_MaintainTempSet58:
L_MaintainTempSet56:
;Spcsystem.c,515 :: 		}
L_MaintainTempSet54:
;Spcsystem.c,516 :: 		}
L_MaintainTempSet45:
L_MaintainTempSet44:
L_MaintainTempSet38:
;Spcsystem.c,517 :: 		Info_Line2[14] = 'P';
	MOVLW       80
	MOVWF       _Info_Line2+14 
;Spcsystem.c,518 :: 		Info_Line2[15] = Cable_Channel+0X31;
	MOVLW       49
	ADDWF       _Cable_Channel+0, 0 
	MOVWF       _Info_Line2+15 
;Spcsystem.c,519 :: 		}
L_end_MaintainTempSet:
	RETURN      0
; end of _MaintainTempSet

_DeadbandSet:

;Spcsystem.c,526 :: 		void DeadbandSet(UCHAR direct, UCHAR cmd)
;Spcsystem.c,531 :: 		units = pSPCValue[0].SPCSetPoints.system_valueb.bite.spc_units_c;
	MOVLW       0
	BTFSC       _pSPCValue+138, 0 
	MOVLW       1
	MOVWF       DeadbandSet_units_L0+0 
	CLRF        DeadbandSet_units_L0+1 
;Spcsystem.c,532 :: 		ptr = (int *)(&SetP_shade.DeadBand);
	MOVLW       _SetP_shade+12
	MOVWF       DeadbandSet_ptr_L0+0 
	MOVLW       hi_addr(_SetP_shade+12)
	MOVWF       DeadbandSet_ptr_L0+1 
;Spcsystem.c,533 :: 		if(units)
	MOVF        DeadbandSet_units_L0+0, 0 
	IORWF       DeadbandSet_units_L0+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_DeadbandSet61
;Spcsystem.c,535 :: 		maxtemp = MAX_SPCDEADBAND_C;
	MOVLW       5
	MOVWF       DeadbandSet_maxtemp_L0+0 
	MOVLW       0
	MOVWF       DeadbandSet_maxtemp_L0+1 
;Spcsystem.c,536 :: 		mintemp = MIN_SPCDEADBAND_C;
	MOVLW       1
	MOVWF       DeadbandSet_mintemp_L0+0 
	MOVLW       0
	MOVWF       DeadbandSet_mintemp_L0+1 
;Spcsystem.c,537 :: 		}
	GOTO        L_DeadbandSet62
L_DeadbandSet61:
;Spcsystem.c,540 :: 		maxtemp = MAX_SPCDEADBAND_F;
	MOVLW       10
	MOVWF       DeadbandSet_maxtemp_L0+0 
	MOVLW       0
	MOVWF       DeadbandSet_maxtemp_L0+1 
;Spcsystem.c,541 :: 		mintemp = MIN_SPCDEADBAND_F;
	MOVLW       1
	MOVWF       DeadbandSet_mintemp_L0+0 
	MOVLW       0
	MOVWF       DeadbandSet_mintemp_L0+1 
;Spcsystem.c,542 :: 		}
L_DeadbandSet62:
;Spcsystem.c,544 :: 		if(cmd == CMD_ENTER)
	MOVF        FARG_DeadbandSet_cmd+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_DeadbandSet63
;Spcsystem.c,546 :: 		if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
	BTFSC       _pSPCValue+139, 0 
	GOTO        L_DeadbandSet64
;Spcsystem.c,547 :: 		return;
	GOTO        L_end_DeadbandSet
L_DeadbandSet64:
;Spcsystem.c,549 :: 		ConvertDead(&SetP_shade.DeadBand);
	MOVLW       _SetP_shade+12
	MOVWF       FARG_ConvertDead_temptocon+0 
	MOVLW       hi_addr(_SetP_shade+12)
	MOVWF       FARG_ConvertDead_temptocon+1 
	CALL        _ConvertDead+0, 0
;Spcsystem.c,550 :: 		CopyTemp(&SetP_shade.DeadBand, &pSPCValue[Cable_Channel].SPCSetPoints.DeadBand);
	MOVLW       _SetP_shade+12
	MOVWF       FARG_CopyTemp_tempsource+0 
	MOVLW       hi_addr(_SetP_shade+12)
	MOVWF       FARG_CopyTemp_tempsource+1 
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
	ADDWF       R0, 0 
	MOVWF       FARG_CopyTemp_temptarget+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_CopyTemp_temptarget+1 
	MOVLW       54
	ADDWF       FARG_CopyTemp_temptarget+0, 1 
	MOVLW       0
	ADDWFC      FARG_CopyTemp_temptarget+1, 1 
	MOVLW       12
	ADDWF       FARG_CopyTemp_temptarget+0, 1 
	MOVLW       0
	ADDWFC      FARG_CopyTemp_temptarget+1, 1 
	CALL        _CopyTemp+0, 0
;Spcsystem.c,551 :: 		storage();
	CALL        _storage+0, 0
;Spcsystem.c,552 :: 		ParametersChanged = 1;
	MOVLW       1
	MOVWF       _ParametersChanged+0 
;Spcsystem.c,553 :: 		}
	GOTO        L_DeadbandSet65
L_DeadbandSet63:
;Spcsystem.c,554 :: 		else if(cmd == CMD_RESET)
	MOVF        FARG_DeadbandSet_cmd+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_DeadbandSet66
;Spcsystem.c,556 :: 		CopyTemp(&pSPCValue[Cable_Channel].SPCSetPoints.DeadBand, &SetP_shade.DeadBand);
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
	ADDWF       R0, 0 
	MOVWF       FARG_CopyTemp_tempsource+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_CopyTemp_tempsource+1 
	MOVLW       54
	ADDWF       FARG_CopyTemp_tempsource+0, 1 
	MOVLW       0
	ADDWFC      FARG_CopyTemp_tempsource+1, 1 
	MOVLW       12
	ADDWF       FARG_CopyTemp_tempsource+0, 1 
	MOVLW       0
	ADDWFC      FARG_CopyTemp_tempsource+1, 1 
	MOVLW       _SetP_shade+12
	MOVWF       FARG_CopyTemp_temptarget+0 
	MOVLW       hi_addr(_SetP_shade+12)
	MOVWF       FARG_CopyTemp_temptarget+1 
	CALL        _CopyTemp+0, 0
;Spcsystem.c,557 :: 		FromIntToStr(*(ptr+units),Info_Line2,SpcMenu[Menustat].decimal);
	MOVF        DeadbandSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        DeadbandSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       DeadbandSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      DeadbandSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+1 
	MOVLW       0
	BTFSC       FARG_FromIntToStr_ValueResoure+3, 7 
	MOVLW       255
	MOVWF       FARG_FromIntToStr_ValueResoure+2 
	MOVWF       FARG_FromIntToStr_ValueResoure+3 
	MOVLW       0
	BTFSC       FARG_FromIntToStr_ValueResoure+1, 7 
	MOVLW       255
	MOVWF       FARG_FromIntToStr_ValueResoure+2 
	MOVWF       FARG_FromIntToStr_ValueResoure+3 
	MOVLW       _Info_Line2+0
	MOVWF       FARG_FromIntToStr_StringTarget+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_FromIntToStr_StringTarget+1 
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       17
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_FromIntToStr_offset+0
	CALL        _FromIntToStr+0, 0
;Spcsystem.c,558 :: 		}
	GOTO        L_DeadbandSet67
L_DeadbandSet66:
;Spcsystem.c,559 :: 		else if(cmd == CMD_ADJUST)
	MOVF        FARG_DeadbandSet_cmd+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_DeadbandSet68
;Spcsystem.c,561 :: 		if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
	BTFSC       _pSPCValue+139, 0 
	GOTO        L_DeadbandSet69
;Spcsystem.c,562 :: 		return;
	GOTO        L_end_DeadbandSet
L_DeadbandSet69:
;Spcsystem.c,564 :: 		Flashing_EN();
	CALL        _Flashing_EN+0, 0
;Spcsystem.c,565 :: 		if((*(ptr+units) <= maxtemp) && (*(ptr+units) >= mintemp))
	MOVF        DeadbandSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        DeadbandSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       DeadbandSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      DeadbandSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       DeadbandSet_maxtemp_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__DeadbandSet573
	MOVF        R1, 0 
	SUBWF       DeadbandSet_maxtemp_L0+0, 0 
L__DeadbandSet573:
	BTFSS       STATUS+0, 0 
	GOTO        L_DeadbandSet72
	MOVF        DeadbandSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        DeadbandSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       DeadbandSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      DeadbandSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       DeadbandSet_mintemp_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__DeadbandSet574
	MOVF        DeadbandSet_mintemp_L0+0, 0 
	SUBWF       R1, 0 
L__DeadbandSet574:
	BTFSS       STATUS+0, 0 
	GOTO        L_DeadbandSet72
L__DeadbandSet527:
;Spcsystem.c,567 :: 		if(direct)
	MOVF        FARG_DeadbandSet_direct+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_DeadbandSet73
;Spcsystem.c,569 :: 		(*(ptr+units)) += KeyHoldStep;
	MOVF        DeadbandSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        DeadbandSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       DeadbandSet_ptr_L0+0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	ADDWFC      DeadbandSet_ptr_L0+1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        _KeyHoldStep+0, 0 
	ADDWF       R0, 1 
	MOVF        _KeyHoldStep+1, 0 
	ADDWFC      R1, 1 
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,570 :: 		if(*(ptr+units) > maxtemp) *(ptr+units) = maxtemp;
	MOVF        DeadbandSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        DeadbandSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       DeadbandSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      DeadbandSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       DeadbandSet_maxtemp_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__DeadbandSet575
	MOVF        R1, 0 
	SUBWF       DeadbandSet_maxtemp_L0+0, 0 
L__DeadbandSet575:
	BTFSC       STATUS+0, 0 
	GOTO        L_DeadbandSet74
	MOVF        DeadbandSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        DeadbandSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       DeadbandSet_ptr_L0+0, 0 
	MOVWF       FSR1 
	MOVF        R1, 0 
	ADDWFC      DeadbandSet_ptr_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        DeadbandSet_maxtemp_L0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        DeadbandSet_maxtemp_L0+1, 0 
	MOVWF       POSTINC1+0 
L_DeadbandSet74:
;Spcsystem.c,571 :: 		}
	GOTO        L_DeadbandSet75
L_DeadbandSet73:
;Spcsystem.c,574 :: 		(*(ptr+units)) -= KeyHoldStep;
	MOVF        DeadbandSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        DeadbandSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       DeadbandSet_ptr_L0+0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	ADDWFC      DeadbandSet_ptr_L0+1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        _KeyHoldStep+0, 0 
	SUBWF       R0, 1 
	MOVF        _KeyHoldStep+1, 0 
	SUBWFB      R1, 1 
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,575 :: 		if(*(ptr+units) < mintemp) *(ptr+units) = mintemp;
	MOVF        DeadbandSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        DeadbandSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       DeadbandSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      DeadbandSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       DeadbandSet_mintemp_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__DeadbandSet576
	MOVF        DeadbandSet_mintemp_L0+0, 0 
	SUBWF       R1, 0 
L__DeadbandSet576:
	BTFSC       STATUS+0, 0 
	GOTO        L_DeadbandSet76
	MOVF        DeadbandSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        DeadbandSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       DeadbandSet_ptr_L0+0, 0 
	MOVWF       FSR1 
	MOVF        R1, 0 
	ADDWFC      DeadbandSet_ptr_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        DeadbandSet_mintemp_L0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        DeadbandSet_mintemp_L0+1, 0 
	MOVWF       POSTINC1+0 
L_DeadbandSet76:
;Spcsystem.c,576 :: 		}
L_DeadbandSet75:
;Spcsystem.c,578 :: 		FromIntToStr(*(ptr+units),Info_Line2,SpcMenu[Menustat].decimal);
	MOVF        DeadbandSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        DeadbandSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       DeadbandSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      DeadbandSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+1 
	MOVLW       0
	BTFSC       FARG_FromIntToStr_ValueResoure+3, 7 
	MOVLW       255
	MOVWF       FARG_FromIntToStr_ValueResoure+2 
	MOVWF       FARG_FromIntToStr_ValueResoure+3 
	MOVLW       0
	BTFSC       FARG_FromIntToStr_ValueResoure+1, 7 
	MOVLW       255
	MOVWF       FARG_FromIntToStr_ValueResoure+2 
	MOVWF       FARG_FromIntToStr_ValueResoure+3 
	MOVLW       _Info_Line2+0
	MOVWF       FARG_FromIntToStr_StringTarget+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_FromIntToStr_StringTarget+1 
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       17
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_FromIntToStr_offset+0
	CALL        _FromIntToStr+0, 0
;Spcsystem.c,579 :: 		}
L_DeadbandSet72:
;Spcsystem.c,580 :: 		}
L_DeadbandSet68:
L_DeadbandSet67:
L_DeadbandSet65:
;Spcsystem.c,581 :: 		Info_Line2[14] = 'P';
	MOVLW       80
	MOVWF       _Info_Line2+14 
;Spcsystem.c,582 :: 		Info_Line2[15] = Cable_Channel+0X31;
	MOVLW       49
	ADDWF       _Cable_Channel+0, 0 
	MOVWF       _Info_Line2+15 
;Spcsystem.c,583 :: 		}
L_end_DeadbandSet:
	RETURN      0
; end of _DeadbandSet

_LowTempAlarmSet:

;Spcsystem.c,590 :: 		void LowTempAlarmSet(UCHAR direct, UCHAR cmd)
;Spcsystem.c,596 :: 		units = pSPCValue[0].SPCSetPoints.system_valueb.bite.spc_units_c;
	MOVLW       0
	BTFSC       _pSPCValue+138, 0 
	MOVLW       1
	MOVWF       LowTempAlarmSet_units_L0+0 
	CLRF        LowTempAlarmSet_units_L0+1 
;Spcsystem.c,597 :: 		Ltemp = (int *)(&pSPCValue[Cable_Channel].SPCSetPoints.LowTemp);
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
	ADDWF       R0, 0 
	MOVWF       R5 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R6 
	MOVLW       4
	ADDWF       R5, 0 
	MOVWF       R3 
	MOVLW       0
	ADDWFC      R6, 0 
	MOVWF       R4 
;Spcsystem.c,598 :: 		Mtemp = (&pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp.Temperature_F);
	MOVF        R5, 0 
	MOVWF       LowTempAlarmSet_Mtemp_L0+0 
	MOVF        R6, 0 
	MOVWF       LowTempAlarmSet_Mtemp_L0+1 
;Spcsystem.c,599 :: 		Dtemp = (&pSPCValue[Cable_Channel].SPCSetPoints.DeadBand.Temperature_F);
	MOVLW       12
	ADDWF       R5, 0 
	MOVWF       LowTempAlarmSet_Dtemp_L0+0 
	MOVLW       0
	ADDWFC      R6, 0 
	MOVWF       LowTempAlarmSet_Dtemp_L0+1 
;Spcsystem.c,600 :: 		ptr = (&SetP_shade.LowTemp.Temperature_F);
	MOVLW       _SetP_shade+4
	MOVWF       LowTempAlarmSet_ptr_L0+0 
	MOVLW       hi_addr(_SetP_shade+4)
	MOVWF       LowTempAlarmSet_ptr_L0+1 
;Spcsystem.c,602 :: 		temp = *(Ltemp+units);
	MOVF        LowTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        LowTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       R3, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      R4, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       LowTempAlarmSet_temp_L0+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       LowTempAlarmSet_temp_L0+1 
;Spcsystem.c,604 :: 		if((pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_OFF) ||
	MOVLW       2
	ADDWF       R5, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R6, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
;Spcsystem.c,605 :: 		(pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_NONE))
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__LowTempAlarmSet578
	MOVLW       255
	XORWF       R1, 0 
L__LowTempAlarmSet578:
	BTFSC       STATUS+0, 2 
	GOTO        L__LowTempAlarmSet528
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
	GOTO        L__LowTempAlarmSet579
	MOVLW       254
	XORWF       R1, 0 
L__LowTempAlarmSet579:
	BTFSC       STATUS+0, 2 
	GOTO        L__LowTempAlarmSet528
	GOTO        L_LowTempAlarmSet79
L__LowTempAlarmSet528:
;Spcsystem.c,607 :: 		if(pSPCValue[Cable_Channel].SPCSetPoints.HighTemp.Temperature_C == SPC_SYSTEMVALUE_OFF)
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
	GOTO        L__LowTempAlarmSet580
	MOVLW       255
	XORWF       R1, 0 
L__LowTempAlarmSet580:
	BTFSS       STATUS+0, 2 
	GOTO        L_LowTempAlarmSet80
;Spcsystem.c,609 :: 		if(units)
	MOVF        LowTempAlarmSet_units_L0+0, 0 
	IORWF       LowTempAlarmSet_units_L0+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_LowTempAlarmSet81
;Spcsystem.c,610 :: 		maxtemp = MAX_TEMP_C-1;
	MOVLW       243
	MOVWF       LowTempAlarmSet_maxtemp_L0+0 
	MOVLW       1
	MOVWF       LowTempAlarmSet_maxtemp_L0+1 
	GOTO        L_LowTempAlarmSet82
L_LowTempAlarmSet81:
;Spcsystem.c,612 :: 		maxtemp = MAX_TEMP_F-1;
	MOVLW       163
	MOVWF       LowTempAlarmSet_maxtemp_L0+0 
	MOVLW       3
	MOVWF       LowTempAlarmSet_maxtemp_L0+1 
L_LowTempAlarmSet82:
;Spcsystem.c,613 :: 		}
	GOTO        L_LowTempAlarmSet83
L_LowTempAlarmSet80:
;Spcsystem.c,616 :: 		if(units)
	MOVF        LowTempAlarmSet_units_L0+0, 0 
	IORWF       LowTempAlarmSet_units_L0+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_LowTempAlarmSet84
;Spcsystem.c,617 :: 		maxtemp = pSPCValue[Cable_Channel].SPCSetPoints.HighTemp.Temperature_C-1;
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
	MOVLW       1
	SUBWF       POSTINC0+0, 0 
	MOVWF       LowTempAlarmSet_maxtemp_L0+0 
	MOVLW       0
	SUBWFB      POSTINC0+0, 0 
	MOVWF       LowTempAlarmSet_maxtemp_L0+1 
	GOTO        L_LowTempAlarmSet85
L_LowTempAlarmSet84:
;Spcsystem.c,619 :: 		maxtemp = pSPCValue[Cable_Channel].SPCSetPoints.HighTemp.Temperature_F-1;
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
	MOVLW       8
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       1
	SUBWF       R0, 0 
	MOVWF       LowTempAlarmSet_maxtemp_L0+0 
	MOVLW       0
	SUBWFB      R1, 0 
	MOVWF       LowTempAlarmSet_maxtemp_L0+1 
L_LowTempAlarmSet85:
;Spcsystem.c,620 :: 		}
L_LowTempAlarmSet83:
;Spcsystem.c,621 :: 		}
	GOTO        L_LowTempAlarmSet86
L_LowTempAlarmSet79:
;Spcsystem.c,624 :: 		if(ProCtlEnable(Cable_Channel))
	MOVF        _Cable_Channel+0, 0 
	MOVWF       FARG_ProCtlEnable_ChannelNum+0 
	CALL        _ProCtlEnable+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LowTempAlarmSet87
;Spcsystem.c,625 :: 		maxtemp = *(Mtemp+units);
	MOVF        LowTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        LowTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       LowTempAlarmSet_Mtemp_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      LowTempAlarmSet_Mtemp_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       LowTempAlarmSet_maxtemp_L0+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       LowTempAlarmSet_maxtemp_L0+1 
	GOTO        L_LowTempAlarmSet88
L_LowTempAlarmSet87:
;Spcsystem.c,627 :: 		maxtemp = *(Mtemp+units) - *(Dtemp+units);
	MOVF        LowTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        LowTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       LowTempAlarmSet_Mtemp_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      LowTempAlarmSet_Mtemp_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        R0, 0 
	ADDWF       LowTempAlarmSet_Dtemp_L0+0, 0 
	MOVWF       FSR2 
	MOVF        R1, 0 
	ADDWFC      LowTempAlarmSet_Dtemp_L0+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	SUBWF       POSTINC0+0, 0 
	MOVWF       LowTempAlarmSet_maxtemp_L0+0 
	MOVF        POSTINC2+0, 0 
	SUBWFB      POSTINC0+0, 0 
	MOVWF       LowTempAlarmSet_maxtemp_L0+1 
L_LowTempAlarmSet88:
;Spcsystem.c,628 :: 		}
L_LowTempAlarmSet86:
;Spcsystem.c,630 :: 		if(units)
	MOVF        LowTempAlarmSet_units_L0+0, 0 
	IORWF       LowTempAlarmSet_units_L0+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_LowTempAlarmSet89
;Spcsystem.c,631 :: 		mintemp = MIN_TEMP_C;
	MOVLW       206
	MOVWF       LowTempAlarmSet_mintemp_L0+0 
	MOVLW       255
	MOVWF       LowTempAlarmSet_mintemp_L0+1 
	GOTO        L_LowTempAlarmSet90
L_LowTempAlarmSet89:
;Spcsystem.c,633 :: 		mintemp = MIN_TEMP_F;
	MOVLW       198
	MOVWF       LowTempAlarmSet_mintemp_L0+0 
	MOVLW       255
	MOVWF       LowTempAlarmSet_mintemp_L0+1 
L_LowTempAlarmSet90:
;Spcsystem.c,635 :: 		if(cmd == CMD_ENTER)
	MOVF        FARG_LowTempAlarmSet_cmd+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LowTempAlarmSet91
;Spcsystem.c,637 :: 		if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
	BTFSC       _pSPCValue+139, 0 
	GOTO        L_LowTempAlarmSet92
;Spcsystem.c,638 :: 		return;
	GOTO        L_end_LowTempAlarmSet
L_LowTempAlarmSet92:
;Spcsystem.c,639 :: 		if(pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_NONE)
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
	GOTO        L__LowTempAlarmSet581
	MOVLW       254
	XORWF       R1, 0 
L__LowTempAlarmSet581:
	BTFSS       STATUS+0, 2 
	GOTO        L_LowTempAlarmSet93
;Spcsystem.c,640 :: 		return;
	GOTO        L_end_LowTempAlarmSet
L_LowTempAlarmSet93:
;Spcsystem.c,642 :: 		if(SetP_shade.LowTemp.Temperature_C != SPC_SYSTEMVALUE_OFF)
	MOVF        _SetP_shade+7, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__LowTempAlarmSet582
	MOVLW       255
	XORWF       _SetP_shade+6, 0 
L__LowTempAlarmSet582:
	BTFSC       STATUS+0, 2 
	GOTO        L_LowTempAlarmSet94
;Spcsystem.c,643 :: 		ConvertTemp(&SetP_shade.LowTemp);
	MOVLW       _SetP_shade+4
	MOVWF       FARG_ConvertTemp_temptocon+0 
	MOVLW       hi_addr(_SetP_shade+4)
	MOVWF       FARG_ConvertTemp_temptocon+1 
	CALL        _ConvertTemp+0, 0
L_LowTempAlarmSet94:
;Spcsystem.c,644 :: 		CopyTemp(&SetP_shade.LowTemp, &pSPCValue[Cable_Channel].SPCSetPoints.LowTemp);
	MOVLW       _SetP_shade+4
	MOVWF       FARG_CopyTemp_tempsource+0 
	MOVLW       hi_addr(_SetP_shade+4)
	MOVWF       FARG_CopyTemp_tempsource+1 
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
	ADDWF       R0, 0 
	MOVWF       FARG_CopyTemp_temptarget+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_CopyTemp_temptarget+1 
	MOVLW       54
	ADDWF       FARG_CopyTemp_temptarget+0, 1 
	MOVLW       0
	ADDWFC      FARG_CopyTemp_temptarget+1, 1 
	MOVLW       4
	ADDWF       FARG_CopyTemp_temptarget+0, 1 
	MOVLW       0
	ADDWFC      FARG_CopyTemp_temptarget+1, 1 
	CALL        _CopyTemp+0, 0
;Spcsystem.c,645 :: 		storage();
	CALL        _storage+0, 0
;Spcsystem.c,646 :: 		ParametersChanged = 1;
	MOVLW       1
	MOVWF       _ParametersChanged+0 
;Spcsystem.c,647 :: 		}
	GOTO        L_LowTempAlarmSet95
L_LowTempAlarmSet91:
;Spcsystem.c,648 :: 		else if(cmd == CMD_RESET)
	MOVF        FARG_LowTempAlarmSet_cmd+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_LowTempAlarmSet96
;Spcsystem.c,650 :: 		if(pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_NONE)
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
	GOTO        L__LowTempAlarmSet583
	MOVLW       254
	XORWF       R1, 0 
L__LowTempAlarmSet583:
	BTFSS       STATUS+0, 2 
	GOTO        L_LowTempAlarmSet97
;Spcsystem.c,652 :: 		getParaChar(Info_Line2, NONEVALUE_STR);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       89
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,653 :: 		return;
	GOTO        L_end_LowTempAlarmSet
;Spcsystem.c,654 :: 		}
L_LowTempAlarmSet97:
;Spcsystem.c,656 :: 		CopyTemp(&pSPCValue[Cable_Channel].SPCSetPoints.LowTemp, &SetP_shade.LowTemp);
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
	ADDWF       R0, 0 
	MOVWF       FARG_CopyTemp_tempsource+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_CopyTemp_tempsource+1 
	MOVLW       54
	ADDWF       FARG_CopyTemp_tempsource+0, 1 
	MOVLW       0
	ADDWFC      FARG_CopyTemp_tempsource+1, 1 
	MOVLW       4
	ADDWF       FARG_CopyTemp_tempsource+0, 1 
	MOVLW       0
	ADDWFC      FARG_CopyTemp_tempsource+1, 1 
	MOVLW       _SetP_shade+4
	MOVWF       FARG_CopyTemp_temptarget+0 
	MOVLW       hi_addr(_SetP_shade+4)
	MOVWF       FARG_CopyTemp_temptarget+1 
	CALL        _CopyTemp+0, 0
;Spcsystem.c,657 :: 		if(SetP_shade.LowTemp.Temperature_C == SPC_SYSTEMVALUE_OFF)
	MOVF        _SetP_shade+7, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__LowTempAlarmSet584
	MOVLW       255
	XORWF       _SetP_shade+6, 0 
L__LowTempAlarmSet584:
	BTFSS       STATUS+0, 2 
	GOTO        L_LowTempAlarmSet98
;Spcsystem.c,658 :: 		getParaChar(Info_Line2, OFF_STR);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       73
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
	GOTO        L_LowTempAlarmSet99
L_LowTempAlarmSet98:
;Spcsystem.c,660 :: 		FromIntToStr(*(ptr+units),Info_Line2,SpcMenu[Menustat].decimal);
	MOVF        LowTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        LowTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       LowTempAlarmSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      LowTempAlarmSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+1 
	MOVLW       0
	BTFSC       FARG_FromIntToStr_ValueResoure+3, 7 
	MOVLW       255
	MOVWF       FARG_FromIntToStr_ValueResoure+2 
	MOVWF       FARG_FromIntToStr_ValueResoure+3 
	MOVLW       0
	BTFSC       FARG_FromIntToStr_ValueResoure+1, 7 
	MOVLW       255
	MOVWF       FARG_FromIntToStr_ValueResoure+2 
	MOVWF       FARG_FromIntToStr_ValueResoure+3 
	MOVLW       _Info_Line2+0
	MOVWF       FARG_FromIntToStr_StringTarget+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_FromIntToStr_StringTarget+1 
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       17
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_FromIntToStr_offset+0
	CALL        _FromIntToStr+0, 0
L_LowTempAlarmSet99:
;Spcsystem.c,661 :: 		}
	GOTO        L_LowTempAlarmSet100
L_LowTempAlarmSet96:
;Spcsystem.c,662 :: 		else if(cmd == CMD_ADJUST)
	MOVF        FARG_LowTempAlarmSet_cmd+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_LowTempAlarmSet101
;Spcsystem.c,664 :: 		if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
	BTFSC       _pSPCValue+139, 0 
	GOTO        L_LowTempAlarmSet102
;Spcsystem.c,665 :: 		return;
	GOTO        L_end_LowTempAlarmSet
L_LowTempAlarmSet102:
;Spcsystem.c,666 :: 		if(pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_NONE)
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
	GOTO        L__LowTempAlarmSet585
	MOVLW       254
	XORWF       R1, 0 
L__LowTempAlarmSet585:
	BTFSS       STATUS+0, 2 
	GOTO        L_LowTempAlarmSet103
;Spcsystem.c,667 :: 		return;
	GOTO        L_end_LowTempAlarmSet
L_LowTempAlarmSet103:
;Spcsystem.c,669 :: 		Flashing_EN();
	CALL        _Flashing_EN+0, 0
;Spcsystem.c,670 :: 		if(direct)
	MOVF        FARG_LowTempAlarmSet_direct+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LowTempAlarmSet104
;Spcsystem.c,672 :: 		if(*(ptr+units) == maxtemp-1)
	MOVF        LowTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        LowTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       LowTempAlarmSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      LowTempAlarmSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       1
	SUBWF       LowTempAlarmSet_maxtemp_L0+0, 0 
	MOVWF       R1 
	MOVLW       0
	SUBWFB      LowTempAlarmSet_maxtemp_L0+1, 0 
	MOVWF       R2 
	MOVF        R4, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LowTempAlarmSet586
	MOVF        R1, 0 
	XORWF       R3, 0 
L__LowTempAlarmSet586:
	BTFSS       STATUS+0, 2 
	GOTO        L_LowTempAlarmSet105
;Spcsystem.c,674 :: 		SetP_shade.LowTemp.Temperature_C = SPC_SYSTEMVALUE_OFF;
	MOVLW       255
	MOVWF       _SetP_shade+6 
	MOVLW       127
	MOVWF       _SetP_shade+7 
;Spcsystem.c,675 :: 		SetP_shade.LowTemp.Temperature_F = SPC_SYSTEMVALUE_OFF;
	MOVLW       255
	MOVWF       _SetP_shade+4 
	MOVLW       127
	MOVWF       _SetP_shade+5 
;Spcsystem.c,676 :: 		getParaChar(Info_Line2, OFF_STR);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       73
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,677 :: 		}
	GOTO        L_LowTempAlarmSet106
L_LowTempAlarmSet105:
;Spcsystem.c,678 :: 		else if(*(ptr+units) < maxtemp-1)
	MOVF        LowTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        LowTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       LowTempAlarmSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      LowTempAlarmSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       1
	SUBWF       LowTempAlarmSet_maxtemp_L0+0, 0 
	MOVWF       R1 
	MOVLW       0
	SUBWFB      LowTempAlarmSet_maxtemp_L0+1, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R4, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LowTempAlarmSet587
	MOVF        R1, 0 
	SUBWF       R3, 0 
L__LowTempAlarmSet587:
	BTFSC       STATUS+0, 0 
	GOTO        L_LowTempAlarmSet107
;Spcsystem.c,680 :: 		(*(ptr+units)) += KeyHoldStep;
	MOVF        LowTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        LowTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       LowTempAlarmSet_ptr_L0+0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	ADDWFC      LowTempAlarmSet_ptr_L0+1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        _KeyHoldStep+0, 0 
	ADDWF       R0, 1 
	MOVF        _KeyHoldStep+1, 0 
	ADDWFC      R1, 1 
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,681 :: 		if(*(ptr+units) > maxtemp-1) *(ptr+units) = maxtemp-1;
	MOVF        LowTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        LowTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       LowTempAlarmSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      LowTempAlarmSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       1
	SUBWF       LowTempAlarmSet_maxtemp_L0+0, 0 
	MOVWF       R1 
	MOVLW       0
	SUBWFB      LowTempAlarmSet_maxtemp_L0+1, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R4, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LowTempAlarmSet588
	MOVF        R3, 0 
	SUBWF       R1, 0 
L__LowTempAlarmSet588:
	BTFSC       STATUS+0, 0 
	GOTO        L_LowTempAlarmSet108
	MOVF        LowTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        LowTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       LowTempAlarmSet_ptr_L0+0, 0 
	MOVWF       FSR1 
	MOVF        R1, 0 
	ADDWFC      LowTempAlarmSet_ptr_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	SUBWF       LowTempAlarmSet_maxtemp_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      LowTempAlarmSet_maxtemp_L0+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
L_LowTempAlarmSet108:
;Spcsystem.c,682 :: 		FromIntToStr(*(ptr+units),Info_Line2,SpcMenu[Menustat].decimal);
	MOVF        LowTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        LowTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       LowTempAlarmSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      LowTempAlarmSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+1 
	MOVLW       0
	BTFSC       FARG_FromIntToStr_ValueResoure+3, 7 
	MOVLW       255
	MOVWF       FARG_FromIntToStr_ValueResoure+2 
	MOVWF       FARG_FromIntToStr_ValueResoure+3 
	MOVLW       0
	BTFSC       FARG_FromIntToStr_ValueResoure+1, 7 
	MOVLW       255
	MOVWF       FARG_FromIntToStr_ValueResoure+2 
	MOVWF       FARG_FromIntToStr_ValueResoure+3 
	MOVLW       _Info_Line2+0
	MOVWF       FARG_FromIntToStr_StringTarget+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_FromIntToStr_StringTarget+1 
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       17
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_FromIntToStr_offset+0
	CALL        _FromIntToStr+0, 0
;Spcsystem.c,683 :: 		}
	GOTO        L_LowTempAlarmSet109
L_LowTempAlarmSet107:
;Spcsystem.c,686 :: 		if(SetP_shade.LowTemp.Temperature_C != SPC_SYSTEMVALUE_OFF)
	MOVF        _SetP_shade+7, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__LowTempAlarmSet589
	MOVLW       255
	XORWF       _SetP_shade+6, 0 
L__LowTempAlarmSet589:
	BTFSC       STATUS+0, 2 
	GOTO        L_LowTempAlarmSet110
;Spcsystem.c,687 :: 		*(ptr+units) = maxtemp-1;
	MOVF        LowTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        LowTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       LowTempAlarmSet_ptr_L0+0, 0 
	MOVWF       FSR1 
	MOVF        R1, 0 
	ADDWFC      LowTempAlarmSet_ptr_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	SUBWF       LowTempAlarmSet_maxtemp_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      LowTempAlarmSet_maxtemp_L0+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
L_LowTempAlarmSet110:
;Spcsystem.c,688 :: 		ConvertTemp(&SetP_shade.LowTemp);
	MOVLW       _SetP_shade+4
	MOVWF       FARG_ConvertTemp_temptocon+0 
	MOVLW       hi_addr(_SetP_shade+4)
	MOVWF       FARG_ConvertTemp_temptocon+1 
	CALL        _ConvertTemp+0, 0
;Spcsystem.c,689 :: 		}
L_LowTempAlarmSet109:
L_LowTempAlarmSet106:
;Spcsystem.c,691 :: 		}
	GOTO        L_LowTempAlarmSet111
L_LowTempAlarmSet104:
;Spcsystem.c,694 :: 		if(*(ptr+units) == SPC_SYSTEMVALUE_OFF)
	MOVF        LowTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        LowTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       LowTempAlarmSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      LowTempAlarmSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__LowTempAlarmSet590
	MOVLW       255
	XORWF       R1, 0 
L__LowTempAlarmSet590:
	BTFSS       STATUS+0, 2 
	GOTO        L_LowTempAlarmSet112
;Spcsystem.c,696 :: 		*(ptr+units) = maxtemp-1;
	MOVF        LowTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        LowTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       LowTempAlarmSet_ptr_L0+0, 0 
	MOVWF       FSR1 
	MOVF        R1, 0 
	ADDWFC      LowTempAlarmSet_ptr_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	SUBWF       LowTempAlarmSet_maxtemp_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      LowTempAlarmSet_maxtemp_L0+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,697 :: 		ConvertTemp(&SetP_shade.LowTemp);
	MOVLW       _SetP_shade+4
	MOVWF       FARG_ConvertTemp_temptocon+0 
	MOVLW       hi_addr(_SetP_shade+4)
	MOVWF       FARG_ConvertTemp_temptocon+1 
	CALL        _ConvertTemp+0, 0
;Spcsystem.c,698 :: 		if(*(ptr+units) < mintemp) *(ptr+units) = mintemp;
	MOVF        LowTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        LowTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       LowTempAlarmSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      LowTempAlarmSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       LowTempAlarmSet_mintemp_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LowTempAlarmSet591
	MOVF        LowTempAlarmSet_mintemp_L0+0, 0 
	SUBWF       R1, 0 
L__LowTempAlarmSet591:
	BTFSC       STATUS+0, 0 
	GOTO        L_LowTempAlarmSet113
	MOVF        LowTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        LowTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       LowTempAlarmSet_ptr_L0+0, 0 
	MOVWF       FSR1 
	MOVF        R1, 0 
	ADDWFC      LowTempAlarmSet_ptr_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        LowTempAlarmSet_mintemp_L0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        LowTempAlarmSet_mintemp_L0+1, 0 
	MOVWF       POSTINC1+0 
L_LowTempAlarmSet113:
;Spcsystem.c,699 :: 		}
	GOTO        L_LowTempAlarmSet114
L_LowTempAlarmSet112:
;Spcsystem.c,700 :: 		else if(*(ptr+units) > mintemp)
	MOVF        LowTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        LowTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       LowTempAlarmSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      LowTempAlarmSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       LowTempAlarmSet_mintemp_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LowTempAlarmSet592
	MOVF        R1, 0 
	SUBWF       LowTempAlarmSet_mintemp_L0+0, 0 
L__LowTempAlarmSet592:
	BTFSC       STATUS+0, 0 
	GOTO        L_LowTempAlarmSet115
;Spcsystem.c,702 :: 		(*(ptr+units)) -= KeyHoldStep;
	MOVF        LowTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        LowTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       LowTempAlarmSet_ptr_L0+0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	ADDWFC      LowTempAlarmSet_ptr_L0+1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        _KeyHoldStep+0, 0 
	SUBWF       R0, 1 
	MOVF        _KeyHoldStep+1, 0 
	SUBWFB      R1, 1 
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,703 :: 		if(*(ptr+units) < mintemp) *(ptr+units) = mintemp;
	MOVF        LowTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        LowTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       LowTempAlarmSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      LowTempAlarmSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       LowTempAlarmSet_mintemp_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LowTempAlarmSet593
	MOVF        LowTempAlarmSet_mintemp_L0+0, 0 
	SUBWF       R1, 0 
L__LowTempAlarmSet593:
	BTFSC       STATUS+0, 0 
	GOTO        L_LowTempAlarmSet116
	MOVF        LowTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        LowTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       LowTempAlarmSet_ptr_L0+0, 0 
	MOVWF       FSR1 
	MOVF        R1, 0 
	ADDWFC      LowTempAlarmSet_ptr_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        LowTempAlarmSet_mintemp_L0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        LowTempAlarmSet_mintemp_L0+1, 0 
	MOVWF       POSTINC1+0 
L_LowTempAlarmSet116:
;Spcsystem.c,704 :: 		}
	GOTO        L_LowTempAlarmSet117
L_LowTempAlarmSet115:
;Spcsystem.c,705 :: 		else if(*(ptr+units) < mintemp)
	MOVF        LowTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        LowTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       LowTempAlarmSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      LowTempAlarmSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       LowTempAlarmSet_mintemp_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LowTempAlarmSet594
	MOVF        LowTempAlarmSet_mintemp_L0+0, 0 
	SUBWF       R1, 0 
L__LowTempAlarmSet594:
	BTFSC       STATUS+0, 0 
	GOTO        L_LowTempAlarmSet118
;Spcsystem.c,706 :: 		*(ptr+units) = mintemp;
	MOVF        LowTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        LowTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       LowTempAlarmSet_ptr_L0+0, 0 
	MOVWF       FSR1 
	MOVF        R1, 0 
	ADDWFC      LowTempAlarmSet_ptr_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        LowTempAlarmSet_mintemp_L0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        LowTempAlarmSet_mintemp_L0+1, 0 
	MOVWF       POSTINC1+0 
L_LowTempAlarmSet118:
L_LowTempAlarmSet117:
L_LowTempAlarmSet114:
;Spcsystem.c,708 :: 		FromIntToStr(*(ptr+units),Info_Line2,SpcMenu[Menustat].decimal);
	MOVF        LowTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        LowTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       LowTempAlarmSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      LowTempAlarmSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+1 
	MOVLW       0
	BTFSC       FARG_FromIntToStr_ValueResoure+3, 7 
	MOVLW       255
	MOVWF       FARG_FromIntToStr_ValueResoure+2 
	MOVWF       FARG_FromIntToStr_ValueResoure+3 
	MOVLW       0
	BTFSC       FARG_FromIntToStr_ValueResoure+1, 7 
	MOVLW       255
	MOVWF       FARG_FromIntToStr_ValueResoure+2 
	MOVWF       FARG_FromIntToStr_ValueResoure+3 
	MOVLW       _Info_Line2+0
	MOVWF       FARG_FromIntToStr_StringTarget+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_FromIntToStr_StringTarget+1 
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       17
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_FromIntToStr_offset+0
	CALL        _FromIntToStr+0, 0
;Spcsystem.c,709 :: 		}
L_LowTempAlarmSet111:
;Spcsystem.c,710 :: 		}
L_LowTempAlarmSet101:
L_LowTempAlarmSet100:
L_LowTempAlarmSet95:
;Spcsystem.c,711 :: 		Info_Line2[14] = 'P';
	MOVLW       80
	MOVWF       _Info_Line2+14 
;Spcsystem.c,712 :: 		Info_Line2[15] = Cable_Channel+0X31;
	MOVLW       49
	ADDWF       _Cable_Channel+0, 0 
	MOVWF       _Info_Line2+15 
;Spcsystem.c,713 :: 		}
L_end_LowTempAlarmSet:
	RETURN      0
; end of _LowTempAlarmSet

_HighTempAlarmSet:

;Spcsystem.c,720 :: 		void HighTempAlarmSet(UCHAR direct, UCHAR cmd)
;Spcsystem.c,726 :: 		units = pSPCValue[0].SPCSetPoints.system_valueb.bite.spc_units_c;
	MOVLW       0
	BTFSC       _pSPCValue+138, 0 
	MOVLW       1
	MOVWF       HighTempAlarmSet_units_L0+0 
	CLRF        HighTempAlarmSet_units_L0+1 
;Spcsystem.c,727 :: 		Htemp = (int *)(&pSPCValue[Cable_Channel].SPCSetPoints.HighTemp);
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
	ADDWF       R0, 0 
	MOVWF       R5 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R6 
	MOVLW       8
	ADDWF       R5, 0 
	MOVWF       R3 
	MOVLW       0
	ADDWFC      R6, 0 
	MOVWF       R4 
;Spcsystem.c,728 :: 		Mtemp = (int *)(&pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp);
	MOVF        R5, 0 
	MOVWF       HighTempAlarmSet_Mtemp_L0+0 
	MOVF        R6, 0 
	MOVWF       HighTempAlarmSet_Mtemp_L0+1 
;Spcsystem.c,729 :: 		Dtemp = (int *)(&pSPCValue[Cable_Channel].SPCSetPoints.DeadBand);
	MOVLW       12
	ADDWF       R5, 0 
	MOVWF       HighTempAlarmSet_Dtemp_L0+0 
	MOVLW       0
	ADDWFC      R6, 0 
	MOVWF       HighTempAlarmSet_Dtemp_L0+1 
;Spcsystem.c,730 :: 		ptr = (int *)(&SetP_shade.HighTemp);
	MOVLW       _SetP_shade+8
	MOVWF       HighTempAlarmSet_ptr_L0+0 
	MOVLW       hi_addr(_SetP_shade+8)
	MOVWF       HighTempAlarmSet_ptr_L0+1 
;Spcsystem.c,732 :: 		temp = *(Htemp+units);
	MOVF        HighTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        HighTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       R3, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      R4, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       HighTempAlarmSet_temp_L0+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       HighTempAlarmSet_temp_L0+1 
;Spcsystem.c,734 :: 		if((pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_OFF) ||
	MOVLW       2
	ADDWF       R5, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R6, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
;Spcsystem.c,735 :: 		(pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_NONE))
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__HighTempAlarmSet596
	MOVLW       255
	XORWF       R1, 0 
L__HighTempAlarmSet596:
	BTFSC       STATUS+0, 2 
	GOTO        L__HighTempAlarmSet529
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
	GOTO        L__HighTempAlarmSet597
	MOVLW       254
	XORWF       R1, 0 
L__HighTempAlarmSet597:
	BTFSC       STATUS+0, 2 
	GOTO        L__HighTempAlarmSet529
	GOTO        L_HighTempAlarmSet121
L__HighTempAlarmSet529:
;Spcsystem.c,737 :: 		if(pSPCValue[Cable_Channel].SPCSetPoints.LowTemp.Temperature_C == SPC_SYSTEMVALUE_OFF)
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
	GOTO        L__HighTempAlarmSet598
	MOVLW       255
	XORWF       R1, 0 
L__HighTempAlarmSet598:
	BTFSS       STATUS+0, 2 
	GOTO        L_HighTempAlarmSet122
;Spcsystem.c,739 :: 		if(units)
	MOVF        HighTempAlarmSet_units_L0+0, 0 
	IORWF       HighTempAlarmSet_units_L0+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_HighTempAlarmSet123
;Spcsystem.c,740 :: 		mintemp = MIN_TEMP_C+1;
	MOVLW       207
	MOVWF       HighTempAlarmSet_mintemp_L0+0 
	MOVLW       255
	MOVWF       HighTempAlarmSet_mintemp_L0+1 
	GOTO        L_HighTempAlarmSet124
L_HighTempAlarmSet123:
;Spcsystem.c,742 :: 		mintemp = MIN_TEMP_F+1;
	MOVLW       199
	MOVWF       HighTempAlarmSet_mintemp_L0+0 
	MOVLW       255
	MOVWF       HighTempAlarmSet_mintemp_L0+1 
L_HighTempAlarmSet124:
;Spcsystem.c,743 :: 		}
	GOTO        L_HighTempAlarmSet125
L_HighTempAlarmSet122:
;Spcsystem.c,746 :: 		if(units)
	MOVF        HighTempAlarmSet_units_L0+0, 0 
	IORWF       HighTempAlarmSet_units_L0+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_HighTempAlarmSet126
;Spcsystem.c,747 :: 		mintemp = pSPCValue[Cable_Channel].SPCSetPoints.LowTemp.Temperature_C+1;
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
	MOVLW       1
	ADDWF       POSTINC0+0, 0 
	MOVWF       HighTempAlarmSet_mintemp_L0+0 
	MOVLW       0
	ADDWFC      POSTINC0+0, 0 
	MOVWF       HighTempAlarmSet_mintemp_L0+1 
	GOTO        L_HighTempAlarmSet127
L_HighTempAlarmSet126:
;Spcsystem.c,749 :: 		mintemp = pSPCValue[Cable_Channel].SPCSetPoints.LowTemp.Temperature_F+1;
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
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       HighTempAlarmSet_mintemp_L0+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       HighTempAlarmSet_mintemp_L0+1 
L_HighTempAlarmSet127:
;Spcsystem.c,750 :: 		}
L_HighTempAlarmSet125:
;Spcsystem.c,751 :: 		}
	GOTO        L_HighTempAlarmSet128
L_HighTempAlarmSet121:
;Spcsystem.c,754 :: 		if(ProCtlEnable(Cable_Channel))
	MOVF        _Cable_Channel+0, 0 
	MOVWF       FARG_ProCtlEnable_ChannelNum+0 
	CALL        _ProCtlEnable+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_HighTempAlarmSet129
;Spcsystem.c,755 :: 		mintemp = *(Mtemp+units);
	MOVF        HighTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        HighTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       HighTempAlarmSet_Mtemp_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      HighTempAlarmSet_Mtemp_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       HighTempAlarmSet_mintemp_L0+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       HighTempAlarmSet_mintemp_L0+1 
	GOTO        L_HighTempAlarmSet130
L_HighTempAlarmSet129:
;Spcsystem.c,757 :: 		mintemp = *(Mtemp+units) + *(Dtemp+units);
	MOVF        HighTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        HighTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       HighTempAlarmSet_Mtemp_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      HighTempAlarmSet_Mtemp_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        R0, 0 
	ADDWF       HighTempAlarmSet_Dtemp_L0+0, 0 
	MOVWF       FSR2 
	MOVF        R1, 0 
	ADDWFC      HighTempAlarmSet_Dtemp_L0+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	ADDWF       POSTINC0+0, 0 
	MOVWF       HighTempAlarmSet_mintemp_L0+0 
	MOVF        POSTINC2+0, 0 
	ADDWFC      POSTINC0+0, 0 
	MOVWF       HighTempAlarmSet_mintemp_L0+1 
L_HighTempAlarmSet130:
;Spcsystem.c,758 :: 		}
L_HighTempAlarmSet128:
;Spcsystem.c,760 :: 		if(units)
	MOVF        HighTempAlarmSet_units_L0+0, 0 
	IORWF       HighTempAlarmSet_units_L0+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_HighTempAlarmSet131
;Spcsystem.c,761 :: 		maxtemp = MAX_TEMP_C;
	MOVLW       244
	MOVWF       HighTempAlarmSet_maxtemp_L0+0 
	MOVLW       1
	MOVWF       HighTempAlarmSet_maxtemp_L0+1 
	GOTO        L_HighTempAlarmSet132
L_HighTempAlarmSet131:
;Spcsystem.c,763 :: 		maxtemp = MAX_TEMP_F;
	MOVLW       164
	MOVWF       HighTempAlarmSet_maxtemp_L0+0 
	MOVLW       3
	MOVWF       HighTempAlarmSet_maxtemp_L0+1 
L_HighTempAlarmSet132:
;Spcsystem.c,765 :: 		if(cmd == CMD_ENTER)
	MOVF        FARG_HighTempAlarmSet_cmd+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_HighTempAlarmSet133
;Spcsystem.c,767 :: 		if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
	BTFSC       _pSPCValue+139, 0 
	GOTO        L_HighTempAlarmSet134
;Spcsystem.c,768 :: 		return;
	GOTO        L_end_HighTempAlarmSet
L_HighTempAlarmSet134:
;Spcsystem.c,769 :: 		if(pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_NONE)
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
	GOTO        L__HighTempAlarmSet599
	MOVLW       254
	XORWF       R1, 0 
L__HighTempAlarmSet599:
	BTFSS       STATUS+0, 2 
	GOTO        L_HighTempAlarmSet135
;Spcsystem.c,770 :: 		return;
	GOTO        L_end_HighTempAlarmSet
L_HighTempAlarmSet135:
;Spcsystem.c,772 :: 		if(SetP_shade.HighTemp.Temperature_C != SPC_SYSTEMVALUE_OFF)
	MOVF        _SetP_shade+11, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__HighTempAlarmSet600
	MOVLW       255
	XORWF       _SetP_shade+10, 0 
L__HighTempAlarmSet600:
	BTFSC       STATUS+0, 2 
	GOTO        L_HighTempAlarmSet136
;Spcsystem.c,773 :: 		ConvertTemp(&SetP_shade.HighTemp);
	MOVLW       _SetP_shade+8
	MOVWF       FARG_ConvertTemp_temptocon+0 
	MOVLW       hi_addr(_SetP_shade+8)
	MOVWF       FARG_ConvertTemp_temptocon+1 
	CALL        _ConvertTemp+0, 0
L_HighTempAlarmSet136:
;Spcsystem.c,774 :: 		CopyTemp(&SetP_shade.HighTemp, &pSPCValue[Cable_Channel].SPCSetPoints.HighTemp);
	MOVLW       _SetP_shade+8
	MOVWF       FARG_CopyTemp_tempsource+0 
	MOVLW       hi_addr(_SetP_shade+8)
	MOVWF       FARG_CopyTemp_tempsource+1 
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
	ADDWF       R0, 0 
	MOVWF       FARG_CopyTemp_temptarget+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_CopyTemp_temptarget+1 
	MOVLW       54
	ADDWF       FARG_CopyTemp_temptarget+0, 1 
	MOVLW       0
	ADDWFC      FARG_CopyTemp_temptarget+1, 1 
	MOVLW       8
	ADDWF       FARG_CopyTemp_temptarget+0, 1 
	MOVLW       0
	ADDWFC      FARG_CopyTemp_temptarget+1, 1 
	CALL        _CopyTemp+0, 0
;Spcsystem.c,775 :: 		storage();
	CALL        _storage+0, 0
;Spcsystem.c,776 :: 		ParametersChanged = 1;
	MOVLW       1
	MOVWF       _ParametersChanged+0 
;Spcsystem.c,777 :: 		}
	GOTO        L_HighTempAlarmSet137
L_HighTempAlarmSet133:
;Spcsystem.c,778 :: 		else if(cmd == CMD_RESET)
	MOVF        FARG_HighTempAlarmSet_cmd+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_HighTempAlarmSet138
;Spcsystem.c,780 :: 		if(pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_NONE)
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
	GOTO        L__HighTempAlarmSet601
	MOVLW       254
	XORWF       R1, 0 
L__HighTempAlarmSet601:
	BTFSS       STATUS+0, 2 
	GOTO        L_HighTempAlarmSet139
;Spcsystem.c,782 :: 		getParaChar(Info_Line2, NONEVALUE_STR);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       89
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,783 :: 		return;
	GOTO        L_end_HighTempAlarmSet
;Spcsystem.c,784 :: 		}
L_HighTempAlarmSet139:
;Spcsystem.c,786 :: 		CopyTemp(&pSPCValue[Cable_Channel].SPCSetPoints.HighTemp, &SetP_shade.HighTemp);
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
	ADDWF       R0, 0 
	MOVWF       FARG_CopyTemp_tempsource+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_CopyTemp_tempsource+1 
	MOVLW       54
	ADDWF       FARG_CopyTemp_tempsource+0, 1 
	MOVLW       0
	ADDWFC      FARG_CopyTemp_tempsource+1, 1 
	MOVLW       8
	ADDWF       FARG_CopyTemp_tempsource+0, 1 
	MOVLW       0
	ADDWFC      FARG_CopyTemp_tempsource+1, 1 
	MOVLW       _SetP_shade+8
	MOVWF       FARG_CopyTemp_temptarget+0 
	MOVLW       hi_addr(_SetP_shade+8)
	MOVWF       FARG_CopyTemp_temptarget+1 
	CALL        _CopyTemp+0, 0
;Spcsystem.c,787 :: 		if(SetP_shade.HighTemp.Temperature_C == SPC_SYSTEMVALUE_OFF)
	MOVF        _SetP_shade+11, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__HighTempAlarmSet602
	MOVLW       255
	XORWF       _SetP_shade+10, 0 
L__HighTempAlarmSet602:
	BTFSS       STATUS+0, 2 
	GOTO        L_HighTempAlarmSet140
;Spcsystem.c,788 :: 		getParaChar(Info_Line2, OFF_STR);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       73
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
	GOTO        L_HighTempAlarmSet141
L_HighTempAlarmSet140:
;Spcsystem.c,790 :: 		FromIntToStr(*(ptr+units),Info_Line2,SpcMenu[Menustat].decimal);
	MOVF        HighTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        HighTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       HighTempAlarmSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      HighTempAlarmSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+1 
	MOVLW       0
	BTFSC       FARG_FromIntToStr_ValueResoure+3, 7 
	MOVLW       255
	MOVWF       FARG_FromIntToStr_ValueResoure+2 
	MOVWF       FARG_FromIntToStr_ValueResoure+3 
	MOVLW       0
	BTFSC       FARG_FromIntToStr_ValueResoure+1, 7 
	MOVLW       255
	MOVWF       FARG_FromIntToStr_ValueResoure+2 
	MOVWF       FARG_FromIntToStr_ValueResoure+3 
	MOVLW       _Info_Line2+0
	MOVWF       FARG_FromIntToStr_StringTarget+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_FromIntToStr_StringTarget+1 
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       17
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_FromIntToStr_offset+0
	CALL        _FromIntToStr+0, 0
L_HighTempAlarmSet141:
;Spcsystem.c,791 :: 		}
	GOTO        L_HighTempAlarmSet142
L_HighTempAlarmSet138:
;Spcsystem.c,792 :: 		else if(cmd == CMD_ADJUST)
	MOVF        FARG_HighTempAlarmSet_cmd+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_HighTempAlarmSet143
;Spcsystem.c,794 :: 		if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
	BTFSC       _pSPCValue+139, 0 
	GOTO        L_HighTempAlarmSet144
;Spcsystem.c,795 :: 		return;
	GOTO        L_end_HighTempAlarmSet
L_HighTempAlarmSet144:
;Spcsystem.c,796 :: 		if(pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_NONE)
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
	GOTO        L__HighTempAlarmSet603
	MOVLW       254
	XORWF       R1, 0 
L__HighTempAlarmSet603:
	BTFSS       STATUS+0, 2 
	GOTO        L_HighTempAlarmSet145
;Spcsystem.c,797 :: 		return;
	GOTO        L_end_HighTempAlarmSet
L_HighTempAlarmSet145:
;Spcsystem.c,799 :: 		Flashing_EN();
	CALL        _Flashing_EN+0, 0
;Spcsystem.c,800 :: 		if(direct)
	MOVF        FARG_HighTempAlarmSet_direct+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_HighTempAlarmSet146
;Spcsystem.c,802 :: 		if(*(ptr+units) == maxtemp)
	MOVF        HighTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        HighTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       HighTempAlarmSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      HighTempAlarmSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORWF       HighTempAlarmSet_maxtemp_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__HighTempAlarmSet604
	MOVF        HighTempAlarmSet_maxtemp_L0+0, 0 
	XORWF       R1, 0 
L__HighTempAlarmSet604:
	BTFSS       STATUS+0, 2 
	GOTO        L_HighTempAlarmSet147
;Spcsystem.c,804 :: 		SetP_shade.HighTemp.Temperature_C = SPC_SYSTEMVALUE_OFF;
	MOVLW       255
	MOVWF       _SetP_shade+10 
	MOVLW       127
	MOVWF       _SetP_shade+11 
;Spcsystem.c,805 :: 		SetP_shade.HighTemp.Temperature_F = SPC_SYSTEMVALUE_OFF;
	MOVLW       255
	MOVWF       _SetP_shade+8 
	MOVLW       127
	MOVWF       _SetP_shade+9 
;Spcsystem.c,806 :: 		getParaChar(Info_Line2, OFF_STR);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       73
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,807 :: 		}
	GOTO        L_HighTempAlarmSet148
L_HighTempAlarmSet147:
;Spcsystem.c,808 :: 		else if(*(ptr+units) < maxtemp)
	MOVF        HighTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        HighTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       HighTempAlarmSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      HighTempAlarmSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       HighTempAlarmSet_maxtemp_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__HighTempAlarmSet605
	MOVF        HighTempAlarmSet_maxtemp_L0+0, 0 
	SUBWF       R1, 0 
L__HighTempAlarmSet605:
	BTFSC       STATUS+0, 0 
	GOTO        L_HighTempAlarmSet149
;Spcsystem.c,810 :: 		(*(ptr+units)) += KeyHoldStep;
	MOVF        HighTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        HighTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       HighTempAlarmSet_ptr_L0+0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	ADDWFC      HighTempAlarmSet_ptr_L0+1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        _KeyHoldStep+0, 0 
	ADDWF       R0, 1 
	MOVF        _KeyHoldStep+1, 0 
	ADDWFC      R1, 1 
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,811 :: 		if(*(ptr+units) > maxtemp) *(ptr+units) = maxtemp;
	MOVF        HighTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        HighTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       HighTempAlarmSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      HighTempAlarmSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       HighTempAlarmSet_maxtemp_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__HighTempAlarmSet606
	MOVF        R1, 0 
	SUBWF       HighTempAlarmSet_maxtemp_L0+0, 0 
L__HighTempAlarmSet606:
	BTFSC       STATUS+0, 0 
	GOTO        L_HighTempAlarmSet150
	MOVF        HighTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        HighTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       HighTempAlarmSet_ptr_L0+0, 0 
	MOVWF       FSR1 
	MOVF        R1, 0 
	ADDWFC      HighTempAlarmSet_ptr_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        HighTempAlarmSet_maxtemp_L0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        HighTempAlarmSet_maxtemp_L0+1, 0 
	MOVWF       POSTINC1+0 
L_HighTempAlarmSet150:
;Spcsystem.c,812 :: 		FromIntToStr(*(ptr+units),Info_Line2,SpcMenu[Menustat].decimal);
	MOVF        HighTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        HighTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       HighTempAlarmSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      HighTempAlarmSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+1 
	MOVLW       0
	BTFSC       FARG_FromIntToStr_ValueResoure+3, 7 
	MOVLW       255
	MOVWF       FARG_FromIntToStr_ValueResoure+2 
	MOVWF       FARG_FromIntToStr_ValueResoure+3 
	MOVLW       0
	BTFSC       FARG_FromIntToStr_ValueResoure+1, 7 
	MOVLW       255
	MOVWF       FARG_FromIntToStr_ValueResoure+2 
	MOVWF       FARG_FromIntToStr_ValueResoure+3 
	MOVLW       _Info_Line2+0
	MOVWF       FARG_FromIntToStr_StringTarget+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_FromIntToStr_StringTarget+1 
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       17
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_FromIntToStr_offset+0
	CALL        _FromIntToStr+0, 0
;Spcsystem.c,813 :: 		}
L_HighTempAlarmSet149:
L_HighTempAlarmSet148:
;Spcsystem.c,814 :: 		}
	GOTO        L_HighTempAlarmSet151
L_HighTempAlarmSet146:
;Spcsystem.c,817 :: 		if(*(ptr+units) == SPC_SYSTEMVALUE_OFF)
	MOVF        HighTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        HighTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       HighTempAlarmSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      HighTempAlarmSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__HighTempAlarmSet607
	MOVLW       255
	XORWF       R1, 0 
L__HighTempAlarmSet607:
	BTFSS       STATUS+0, 2 
	GOTO        L_HighTempAlarmSet152
;Spcsystem.c,819 :: 		*(ptr+units) = maxtemp;
	MOVF        HighTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        HighTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       HighTempAlarmSet_ptr_L0+0, 0 
	MOVWF       FSR1 
	MOVF        R1, 0 
	ADDWFC      HighTempAlarmSet_ptr_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        HighTempAlarmSet_maxtemp_L0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        HighTempAlarmSet_maxtemp_L0+1, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,820 :: 		ConvertTemp(&SetP_shade.HighTemp);
	MOVLW       _SetP_shade+8
	MOVWF       FARG_ConvertTemp_temptocon+0 
	MOVLW       hi_addr(_SetP_shade+8)
	MOVWF       FARG_ConvertTemp_temptocon+1 
	CALL        _ConvertTemp+0, 0
;Spcsystem.c,821 :: 		}
	GOTO        L_HighTempAlarmSet153
L_HighTempAlarmSet152:
;Spcsystem.c,822 :: 		else if(*(ptr+units) > mintemp+1)
	MOVF        HighTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        HighTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       HighTempAlarmSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      HighTempAlarmSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       1
	ADDWF       HighTempAlarmSet_mintemp_L0+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      HighTempAlarmSet_mintemp_L0+1, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R4, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__HighTempAlarmSet608
	MOVF        R3, 0 
	SUBWF       R1, 0 
L__HighTempAlarmSet608:
	BTFSC       STATUS+0, 0 
	GOTO        L_HighTempAlarmSet154
;Spcsystem.c,824 :: 		(*(ptr+units)) -= KeyHoldStep;
	MOVF        HighTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        HighTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       HighTempAlarmSet_ptr_L0+0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	ADDWFC      HighTempAlarmSet_ptr_L0+1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        _KeyHoldStep+0, 0 
	SUBWF       R0, 1 
	MOVF        _KeyHoldStep+1, 0 
	SUBWFB      R1, 1 
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,825 :: 		if(*(ptr+units) < mintemp+1) *(ptr+units) = mintemp+1;
	MOVF        HighTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        HighTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       HighTempAlarmSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      HighTempAlarmSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       1
	ADDWF       HighTempAlarmSet_mintemp_L0+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      HighTempAlarmSet_mintemp_L0+1, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R4, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__HighTempAlarmSet609
	MOVF        R1, 0 
	SUBWF       R3, 0 
L__HighTempAlarmSet609:
	BTFSC       STATUS+0, 0 
	GOTO        L_HighTempAlarmSet155
	MOVF        HighTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        HighTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       HighTempAlarmSet_ptr_L0+0, 0 
	MOVWF       FSR1 
	MOVF        R1, 0 
	ADDWFC      HighTempAlarmSet_ptr_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	ADDWF       HighTempAlarmSet_mintemp_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      HighTempAlarmSet_mintemp_L0+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
L_HighTempAlarmSet155:
;Spcsystem.c,826 :: 		}
L_HighTempAlarmSet154:
L_HighTempAlarmSet153:
;Spcsystem.c,827 :: 		FromIntToStr(*(ptr+units),Info_Line2,SpcMenu[Menustat].decimal);
	MOVF        HighTempAlarmSet_units_L0+0, 0 
	MOVWF       R0 
	MOVF        HighTempAlarmSet_units_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       HighTempAlarmSet_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      HighTempAlarmSet_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+1 
	MOVLW       0
	BTFSC       FARG_FromIntToStr_ValueResoure+3, 7 
	MOVLW       255
	MOVWF       FARG_FromIntToStr_ValueResoure+2 
	MOVWF       FARG_FromIntToStr_ValueResoure+3 
	MOVLW       0
	BTFSC       FARG_FromIntToStr_ValueResoure+1, 7 
	MOVLW       255
	MOVWF       FARG_FromIntToStr_ValueResoure+2 
	MOVWF       FARG_FromIntToStr_ValueResoure+3 
	MOVLW       _Info_Line2+0
	MOVWF       FARG_FromIntToStr_StringTarget+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_FromIntToStr_StringTarget+1 
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       17
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_FromIntToStr_offset+0
	CALL        _FromIntToStr+0, 0
;Spcsystem.c,828 :: 		}
L_HighTempAlarmSet151:
;Spcsystem.c,829 :: 		}
L_HighTempAlarmSet143:
L_HighTempAlarmSet142:
L_HighTempAlarmSet137:
;Spcsystem.c,830 :: 		Info_Line2[14] = 'P';
	MOVLW       80
	MOVWF       _Info_Line2+14 
;Spcsystem.c,831 :: 		Info_Line2[15] = Cable_Channel+0X31;
	MOVLW       49
	ADDWF       _Cable_Channel+0, 0 
	MOVWF       _Info_Line2+15 
;Spcsystem.c,832 :: 		}
L_end_HighTempAlarmSet:
	RETURN      0
; end of _HighTempAlarmSet

_HeaterIDSet:

;Spcsystem.c,839 :: 		void HeaterIDSet(UCHAR direct, UCHAR cmd)
;Spcsystem.c,841 :: 		if(cmd == CMD_ENTER)   //enter
	MOVF        FARG_HeaterIDSet_cmd+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_HeaterIDSet156
;Spcsystem.c,843 :: 		if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
	BTFSC       _pSPCValue+139, 0 
	GOTO        L_HeaterIDSet157
;Spcsystem.c,844 :: 		return;
	GOTO        L_end_HeaterIDSet
L_HeaterIDSet157:
;Spcsystem.c,846 :: 		if(SetP_shade.CharacNum >= 15)
	MOVLW       15
	SUBWF       _SetP_shade+82, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_HeaterIDSet158
;Spcsystem.c,848 :: 		CopyStr(SetP_shade.HeaterName, pSPCValue[Cable_Channel].SPCSetPoints.HeaterName, 16);
	MOVLW       _SetP_shade+50
	MOVWF       FARG_CopyStr_resource+0 
	MOVLW       hi_addr(_SetP_shade+50)
	MOVWF       FARG_CopyStr_resource+1 
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
	ADDWF       R0, 0 
	MOVWF       FARG_CopyStr_target+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_CopyStr_target+1 
	MOVLW       54
	ADDWF       FARG_CopyStr_target+0, 1 
	MOVLW       0
	ADDWFC      FARG_CopyStr_target+1, 1 
	MOVLW       50
	ADDWF       FARG_CopyStr_target+0, 1 
	MOVLW       0
	ADDWFC      FARG_CopyStr_target+1, 1 
	MOVLW       16
	MOVWF       FARG_CopyStr_len+0 
	CALL        _CopyStr+0, 0
;Spcsystem.c,849 :: 		SetP_shade.CharacNum = 0;
	CLRF        _SetP_shade+82 
;Spcsystem.c,850 :: 		SetP_shade.StringNum = getStringNum();
	CALL        _getStringNum+0, 0
	MOVF        R0, 0 
	MOVWF       _SetP_shade+83 
;Spcsystem.c,851 :: 		spc_system_flag.bite.char_flash = 0;
	BCF         _spc_system_flag+3, 6 
;Spcsystem.c,852 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Spcsystem.c,853 :: 		storage();
	CALL        _storage+0, 0
;Spcsystem.c,854 :: 		Savedata(HEATERNAME_FLASH_LACAL+Cable_Channel*sizeof(SPCSETPIONTS),
	MOVLW       88
	MULWF       _Cable_Channel+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVLW       50
	ADDWF       R0, 0 
	MOVWF       FARG_Savedata_flash_lacl+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FARG_Savedata_flash_lacl+1 
;Spcsystem.c,855 :: 		16,
	MOVLW       16
	MOVWF       FARG_Savedata_len+0 
	MOVLW       0
	MOVWF       FARG_Savedata_len+1 
;Spcsystem.c,856 :: 		(UCHAR *)(&pSPCValue[Cable_Channel].SPCSetPoints.HeaterName),
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
	ADDWF       R0, 0 
	MOVWF       FARG_Savedata_ptr+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_Savedata_ptr+1 
	MOVLW       54
	ADDWF       FARG_Savedata_ptr+0, 1 
	MOVLW       0
	ADDWFC      FARG_Savedata_ptr+1, 1 
	MOVLW       50
	ADDWF       FARG_Savedata_ptr+0, 1 
	MOVLW       0
	ADDWFC      FARG_Savedata_ptr+1, 1 
;Spcsystem.c,857 :: 		0);
	CLRF        FARG_Savedata_cmd+0 
	CALL        _Savedata+0, 0
;Spcsystem.c,858 :: 		}
	GOTO        L_HeaterIDSet159
L_HeaterIDSet158:
;Spcsystem.c,861 :: 		SetP_shade.CharacNum++;
	MOVF        _SetP_shade+82, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _SetP_shade+82 
;Spcsystem.c,862 :: 		SetP_shade.StringNum = getStringNum();
	CALL        _getStringNum+0, 0
	MOVF        R0, 0 
	MOVWF       _SetP_shade+83 
;Spcsystem.c,863 :: 		spc_system_flag.bite.char_flash = 1;
	BSF         _spc_system_flag+3, 6 
;Spcsystem.c,865 :: 		char_flash_loca++;
	INCF        _char_flash_loca+0, 1 
;Spcsystem.c,866 :: 		}
L_HeaterIDSet159:
;Spcsystem.c,867 :: 		}
	GOTO        L_HeaterIDSet160
L_HeaterIDSet156:
;Spcsystem.c,868 :: 		else if(cmd == CMD_RESET)    //reset
	MOVF        FARG_HeaterIDSet_cmd+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_HeaterIDSet161
;Spcsystem.c,871 :: 		CopyStr(pSPCValue[Cable_Channel].SPCSetPoints.HeaterName, SetP_shade.HeaterName, 16);
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
	ADDWF       R0, 0 
	MOVWF       FARG_CopyStr_resource+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_CopyStr_resource+1 
	MOVLW       54
	ADDWF       FARG_CopyStr_resource+0, 1 
	MOVLW       0
	ADDWFC      FARG_CopyStr_resource+1, 1 
	MOVLW       50
	ADDWF       FARG_CopyStr_resource+0, 1 
	MOVLW       0
	ADDWFC      FARG_CopyStr_resource+1, 1 
	MOVLW       _SetP_shade+50
	MOVWF       FARG_CopyStr_target+0 
	MOVLW       hi_addr(_SetP_shade+50)
	MOVWF       FARG_CopyStr_target+1 
	MOVLW       16
	MOVWF       FARG_CopyStr_len+0 
	CALL        _CopyStr+0, 0
;Spcsystem.c,872 :: 		CopyStr(SetP_shade.HeaterName, Info_Line2, 16);
	MOVLW       _SetP_shade+50
	MOVWF       FARG_CopyStr_resource+0 
	MOVLW       hi_addr(_SetP_shade+50)
	MOVWF       FARG_CopyStr_resource+1 
	MOVLW       _Info_Line2+0
	MOVWF       FARG_CopyStr_target+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_CopyStr_target+1 
	MOVLW       16
	MOVWF       FARG_CopyStr_len+0 
	CALL        _CopyStr+0, 0
;Spcsystem.c,873 :: 		SetP_shade.CharacNum = 0;
	CLRF        _SetP_shade+82 
;Spcsystem.c,874 :: 		SetP_shade.StringNum = getStringNum();
	CALL        _getStringNum+0, 0
	MOVF        R0, 0 
	MOVWF       _SetP_shade+83 
;Spcsystem.c,876 :: 		if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en)
	BTFSS       _pSPCValue+139, 0 
	GOTO        L_HeaterIDSet162
;Spcsystem.c,878 :: 		spc_system_flag.bite.char_flash = 1;
	BSF         _spc_system_flag+3, 6 
;Spcsystem.c,879 :: 		char_flash_loca = 1;
	MOVLW       1
	MOVWF       _char_flash_loca+0 
;Spcsystem.c,880 :: 		}
L_HeaterIDSet162:
;Spcsystem.c,881 :: 		}
	GOTO        L_HeaterIDSet163
L_HeaterIDSet161:
;Spcsystem.c,882 :: 		else if(cmd == CMD_ADJUST)      //up/down
	MOVF        FARG_HeaterIDSet_cmd+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_HeaterIDSet164
;Spcsystem.c,884 :: 		if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
	BTFSC       _pSPCValue+139, 0 
	GOTO        L_HeaterIDSet165
;Spcsystem.c,885 :: 		return;
	GOTO        L_end_HeaterIDSet
L_HeaterIDSet165:
;Spcsystem.c,887 :: 		if((direct == 1) && (SetP_shade.StringNum < PSW_CHARACT_NUM+PSW_CHARACT_EX_NUM))
	MOVF        FARG_HeaterIDSet_direct+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_HeaterIDSet168
	MOVLW       94
	SUBWF       _SetP_shade+83, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_HeaterIDSet168
L__HeaterIDSet531:
;Spcsystem.c,888 :: 		SetP_shade.HeaterName[SetP_shade.CharacNum] = SpcCharactors[++SetP_shade.StringNum];
	MOVLW       _SetP_shade+50
	MOVWF       FSR1 
	MOVLW       hi_addr(_SetP_shade+50)
	MOVWF       FSR1H 
	MOVF        _SetP_shade+82, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVF        _SetP_shade+83, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _SetP_shade+83 
	MOVLW       Spcsystem_SpcCharactors+0
	ADDWF       _SetP_shade+83, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(Spcsystem_SpcCharactors+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(Spcsystem_SpcCharactors+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	GOTO        L_HeaterIDSet169
L_HeaterIDSet168:
;Spcsystem.c,889 :: 		else if((direct == 0) && (SetP_shade.StringNum > 0))
	MOVF        FARG_HeaterIDSet_direct+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_HeaterIDSet172
	MOVF        _SetP_shade+83, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_HeaterIDSet172
L__HeaterIDSet530:
;Spcsystem.c,890 :: 		SetP_shade.HeaterName[SetP_shade.CharacNum] = SpcCharactors[--SetP_shade.StringNum];
	MOVLW       _SetP_shade+50
	MOVWF       FSR1 
	MOVLW       hi_addr(_SetP_shade+50)
	MOVWF       FSR1H 
	MOVF        _SetP_shade+82, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	DECF        _SetP_shade+83, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _SetP_shade+83 
	MOVLW       Spcsystem_SpcCharactors+0
	ADDWF       _SetP_shade+83, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(Spcsystem_SpcCharactors+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(Spcsystem_SpcCharactors+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
L_HeaterIDSet172:
L_HeaterIDSet169:
;Spcsystem.c,892 :: 		Info_Line2[SetP_shade.CharacNum] = SetP_shade.HeaterName[SetP_shade.CharacNum];
	MOVLW       _Info_Line2+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FSR1H 
	MOVF        _SetP_shade+82, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       _SetP_shade+50
	MOVWF       FSR0 
	MOVLW       hi_addr(_SetP_shade+50)
	MOVWF       FSR0H 
	MOVF        _SetP_shade+82, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,893 :: 		spc_system_flag.bite.char_flash = 1;
	BSF         _spc_system_flag+3, 6 
;Spcsystem.c,894 :: 		}
L_HeaterIDSet164:
L_HeaterIDSet163:
L_HeaterIDSet160:
;Spcsystem.c,896 :: 		Info_Line2[14] = 'P';
	MOVLW       80
	MOVWF       _Info_Line2+14 
;Spcsystem.c,897 :: 		Info_Line2[15] = Cable_Channel+0X31;
	MOVLW       49
	ADDWF       _Cable_Channel+0, 0 
	MOVWF       _Info_Line2+15 
;Spcsystem.c,898 :: 		}
L_end_HeaterIDSet:
	RETURN      0
; end of _HeaterIDSet

_PasswordEidtorSet:

;Spcsystem.c,905 :: 		void PasswordEidtorSet(UCHAR direct, UCHAR cmd)
;Spcsystem.c,909 :: 		if(cmd == CMD_ENTER)     //enter
	MOVF        FARG_PasswordEidtorSet_cmd+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_PasswordEidtorSet173
;Spcsystem.c,911 :: 		if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
	BTFSC       _pSPCValue+139, 0 
	GOTO        L_PasswordEidtorSet174
;Spcsystem.c,912 :: 		return;
	GOTO        L_end_PasswordEidtorSet
L_PasswordEidtorSet174:
;Spcsystem.c,914 :: 		if(SetPSWVal)
	MOVF        PasswordEidtorSet_SetPSWVal_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_PasswordEidtorSet175
;Spcsystem.c,916 :: 		if(SetPSWReq == SET_PSW_START)
	MOVF        PasswordEidtorSet_SetPSWReq_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_PasswordEidtorSet176
;Spcsystem.c,918 :: 		SetP_shade.CharacNum = 0;
	CLRF        _SetP_shade+82 
;Spcsystem.c,919 :: 		SetP_shade.StringNum = 0;
	CLRF        _SetP_shade+83 
;Spcsystem.c,920 :: 		SetPSWReq = SET_OLD_PSW;
	MOVLW       1
	MOVWF       PasswordEidtorSet_SetPSWReq_L0+0 
;Spcsystem.c,921 :: 		CopyPSWTitle(Info_Line1, SetPSWReq);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_CopyPSWTitle_target+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_CopyPSWTitle_target+1 
	MOVLW       1
	MOVWF       FARG_CopyPSWTitle_adder+0 
	CALL        _CopyPSWTitle+0, 0
;Spcsystem.c,922 :: 		spc_system_flag.bite.char_actived = 1;
	BSF         _spc_system_flag+1, 3 
;Spcsystem.c,923 :: 		spc_system_flag.bite.char_flash = 1;
	BSF         _spc_system_flag+3, 6 
;Spcsystem.c,924 :: 		char_flash_loca = 1;
	MOVLW       1
	MOVWF       _char_flash_loca+0 
;Spcsystem.c,925 :: 		}
	GOTO        L_PasswordEidtorSet177
L_PasswordEidtorSet176:
;Spcsystem.c,926 :: 		else if(SetPSWReq == SET_OLD_PSW)
	MOVF        PasswordEidtorSet_SetPSWReq_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_PasswordEidtorSet178
;Spcsystem.c,928 :: 		if(StrCompar(SetP_shade.Password, pSPCValue[0].SPCSetPoints.Password))
	MOVLW       _SetP_shade+66
	MOVWF       FARG_StrCompar_resoure+0 
	MOVLW       hi_addr(_SetP_shade+66)
	MOVWF       FARG_StrCompar_resoure+1 
	MOVLW       _pSPCValue+120
	MOVWF       FARG_StrCompar_target+0 
	MOVLW       hi_addr(_pSPCValue+120)
	MOVWF       FARG_StrCompar_target+1 
	CALL        _StrCompar+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_PasswordEidtorSet179
;Spcsystem.c,930 :: 		SetP_shade.CharacNum = 0;
	CLRF        _SetP_shade+82 
;Spcsystem.c,931 :: 		SetP_shade.StringNum = 0;
	CLRF        _SetP_shade+83 
;Spcsystem.c,932 :: 		SetPSWReq = SET_NEW_PSW;
	MOVLW       2
	MOVWF       PasswordEidtorSet_SetPSWReq_L0+0 
;Spcsystem.c,933 :: 		CopyPSWTitle(Info_Line1, SetPSWReq);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_CopyPSWTitle_target+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_CopyPSWTitle_target+1 
	MOVLW       2
	MOVWF       FARG_CopyPSWTitle_adder+0 
	CALL        _CopyPSWTitle+0, 0
;Spcsystem.c,934 :: 		spc_system_flag.bite.char_flash = 1;
	BSF         _spc_system_flag+3, 6 
;Spcsystem.c,935 :: 		char_flash_loca = 1;
	MOVLW       1
	MOVWF       _char_flash_loca+0 
;Spcsystem.c,936 :: 		}
	GOTO        L_PasswordEidtorSet180
L_PasswordEidtorSet179:
;Spcsystem.c,939 :: 		CopyPSWTitle(Info_Line1, SET_PSW_INVALID);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_CopyPSWTitle_target+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_CopyPSWTitle_target+1 
	MOVLW       5
	MOVWF       FARG_CopyPSWTitle_adder+0 
	CALL        _CopyPSWTitle+0, 0
;Spcsystem.c,940 :: 		SetPSWReq = SET_PSW_START;
	CLRF        PasswordEidtorSet_SetPSWReq_L0+0 
;Spcsystem.c,941 :: 		SetPSWVal = 0;
	CLRF        PasswordEidtorSet_SetPSWVal_L0+0 
;Spcsystem.c,942 :: 		spc_system_flag.bite.char_actived = 0;
	BCF         _spc_system_flag+1, 3 
;Spcsystem.c,943 :: 		LCDext = 1;
	MOVLW       1
	MOVWF       _LCDext+0 
;Spcsystem.c,944 :: 		spc_system_flag.bite.char_flash = 0;
	BCF         _spc_system_flag+3, 6 
;Spcsystem.c,945 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Spcsystem.c,946 :: 		}
L_PasswordEidtorSet180:
;Spcsystem.c,947 :: 		}
	GOTO        L_PasswordEidtorSet181
L_PasswordEidtorSet178:
;Spcsystem.c,948 :: 		else if(SetPSWReq == SET_NEW_PSW)
	MOVF        PasswordEidtorSet_SetPSWReq_L0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_PasswordEidtorSet182
;Spcsystem.c,950 :: 		if(SetP_shade.CharacNum < 3)
	MOVLW       3
	SUBWF       _SetP_shade+82, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_PasswordEidtorSet183
;Spcsystem.c,952 :: 		CopyPSWTitle(Info_Line1, SET_PSW_INVALID);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_CopyPSWTitle_target+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_CopyPSWTitle_target+1 
	MOVLW       5
	MOVWF       FARG_CopyPSWTitle_adder+0 
	CALL        _CopyPSWTitle+0, 0
;Spcsystem.c,953 :: 		SetPSWReq = SET_PSW_START;
	CLRF        PasswordEidtorSet_SetPSWReq_L0+0 
;Spcsystem.c,954 :: 		SetPSWVal = 0;
	CLRF        PasswordEidtorSet_SetPSWVal_L0+0 
;Spcsystem.c,955 :: 		spc_system_flag.bite.char_actived = 0;
	BCF         _spc_system_flag+1, 3 
;Spcsystem.c,956 :: 		LCDext = 1;
	MOVLW       1
	MOVWF       _LCDext+0 
;Spcsystem.c,957 :: 		spc_system_flag.bite.char_flash = 0;
	BCF         _spc_system_flag+3, 6 
;Spcsystem.c,958 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Spcsystem.c,959 :: 		}
	GOTO        L_PasswordEidtorSet184
L_PasswordEidtorSet183:
;Spcsystem.c,962 :: 		SetP_shade.CharacNum = 0;
	CLRF        _SetP_shade+82 
;Spcsystem.c,963 :: 		SetP_shade.StringNum = 0;
	CLRF        _SetP_shade+83 
;Spcsystem.c,964 :: 		SetPSWReq = SET_NEW_PSW_AGAIN;
	MOVLW       3
	MOVWF       PasswordEidtorSet_SetPSWReq_L0+0 
;Spcsystem.c,965 :: 		CopyStr(SetP_shade.Password, Passwordbuff, 16);   //strcpy(Passwordbuff, SetP_shade.Password);
	MOVLW       _SetP_shade+66
	MOVWF       FARG_CopyStr_resource+0 
	MOVLW       hi_addr(_SetP_shade+66)
	MOVWF       FARG_CopyStr_resource+1 
	MOVLW       _Passwordbuff+0
	MOVWF       FARG_CopyStr_target+0 
	MOVLW       hi_addr(_Passwordbuff+0)
	MOVWF       FARG_CopyStr_target+1 
	MOVLW       16
	MOVWF       FARG_CopyStr_len+0 
	CALL        _CopyStr+0, 0
;Spcsystem.c,966 :: 		CopyPSWTitle(Info_Line1, SetPSWReq);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_CopyPSWTitle_target+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_CopyPSWTitle_target+1 
	MOVF        PasswordEidtorSet_SetPSWReq_L0+0, 0 
	MOVWF       FARG_CopyPSWTitle_adder+0 
	CALL        _CopyPSWTitle+0, 0
;Spcsystem.c,967 :: 		spc_system_flag.bite.char_flash = 1;
	BSF         _spc_system_flag+3, 6 
;Spcsystem.c,968 :: 		char_flash_loca = 1;
	MOVLW       1
	MOVWF       _char_flash_loca+0 
;Spcsystem.c,969 :: 		}
L_PasswordEidtorSet184:
;Spcsystem.c,970 :: 		}
	GOTO        L_PasswordEidtorSet185
L_PasswordEidtorSet182:
;Spcsystem.c,971 :: 		else if(SetPSWReq == SET_NEW_PSW_AGAIN)
	MOVF        PasswordEidtorSet_SetPSWReq_L0+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_PasswordEidtorSet186
;Spcsystem.c,973 :: 		if(StrCompar(Passwordbuff, SetP_shade.Password))
	MOVLW       _Passwordbuff+0
	MOVWF       FARG_StrCompar_resoure+0 
	MOVLW       hi_addr(_Passwordbuff+0)
	MOVWF       FARG_StrCompar_resoure+1 
	MOVLW       _SetP_shade+66
	MOVWF       FARG_StrCompar_target+0 
	MOVLW       hi_addr(_SetP_shade+66)
	MOVWF       FARG_StrCompar_target+1 
	CALL        _StrCompar+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_PasswordEidtorSet187
;Spcsystem.c,975 :: 		SetPSWReq =  SET_PSW_SUCCED;
	MOVLW       4
	MOVWF       PasswordEidtorSet_SetPSWReq_L0+0 
;Spcsystem.c,976 :: 		CopyStr(SetP_shade.Password, pSPCValue[0].SPCSetPoints.Password, 16);
	MOVLW       _SetP_shade+66
	MOVWF       FARG_CopyStr_resource+0 
	MOVLW       hi_addr(_SetP_shade+66)
	MOVWF       FARG_CopyStr_resource+1 
	MOVLW       _pSPCValue+120
	MOVWF       FARG_CopyStr_target+0 
	MOVLW       hi_addr(_pSPCValue+120)
	MOVWF       FARG_CopyStr_target+1 
	MOVLW       16
	MOVWF       FARG_CopyStr_len+0 
	CALL        _CopyStr+0, 0
;Spcsystem.c,977 :: 		Savedata(PASSWORD_FLASH_LACAL,
	MOVLW       66
	MOVWF       FARG_Savedata_flash_lacl+0 
	MOVLW       0
	MOVWF       FARG_Savedata_flash_lacl+1 
;Spcsystem.c,978 :: 		16,
	MOVLW       16
	MOVWF       FARG_Savedata_len+0 
	MOVLW       0
	MOVWF       FARG_Savedata_len+1 
;Spcsystem.c,979 :: 		(UCHAR *)(&pSPCValue[0].SPCSetPoints.Password),
	MOVLW       _pSPCValue+120
	MOVWF       FARG_Savedata_ptr+0 
	MOVLW       hi_addr(_pSPCValue+120)
	MOVWF       FARG_Savedata_ptr+1 
;Spcsystem.c,980 :: 		0);
	CLRF        FARG_Savedata_cmd+0 
	CALL        _Savedata+0, 0
;Spcsystem.c,981 :: 		}
	GOTO        L_PasswordEidtorSet188
L_PasswordEidtorSet187:
;Spcsystem.c,983 :: 		SetPSWReq =  SET_PSW_FAIL;
	MOVLW       6
	MOVWF       PasswordEidtorSet_SetPSWReq_L0+0 
L_PasswordEidtorSet188:
;Spcsystem.c,985 :: 		CopyPSWTitle(Info_Line1, SetPSWReq);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_CopyPSWTitle_target+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_CopyPSWTitle_target+1 
	MOVF        PasswordEidtorSet_SetPSWReq_L0+0, 0 
	MOVWF       FARG_CopyPSWTitle_adder+0 
	CALL        _CopyPSWTitle+0, 0
;Spcsystem.c,986 :: 		SetPSWReq = SET_PSW_START;
	CLRF        PasswordEidtorSet_SetPSWReq_L0+0 
;Spcsystem.c,987 :: 		SetPSWVal = 0;
	CLRF        PasswordEidtorSet_SetPSWVal_L0+0 
;Spcsystem.c,988 :: 		LCDext = 1;
	MOVLW       1
	MOVWF       _LCDext+0 
;Spcsystem.c,989 :: 		spc_system_flag.bite.char_flash = 0;
	BCF         _spc_system_flag+3, 6 
;Spcsystem.c,990 :: 		spc_system_flag.bite.char_actived = 0;
	BCF         _spc_system_flag+1, 3 
;Spcsystem.c,991 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Spcsystem.c,992 :: 		}
L_PasswordEidtorSet186:
L_PasswordEidtorSet185:
L_PasswordEidtorSet181:
L_PasswordEidtorSet177:
;Spcsystem.c,993 :: 		ClearStr(Info_Line2, 16);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_ClearStr_target+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_ClearStr_target+1 
	MOVLW       16
	MOVWF       FARG_ClearStr_len+0 
	MOVLW       0
	MOVWF       FARG_ClearStr_len+1 
	CALL        _ClearStr+0, 0
;Spcsystem.c,994 :: 		ClearStr(SetP_shade.Password, 16);
	MOVLW       _SetP_shade+66
	MOVWF       FARG_ClearStr_target+0 
	MOVLW       hi_addr(_SetP_shade+66)
	MOVWF       FARG_ClearStr_target+1 
	MOVLW       16
	MOVWF       FARG_ClearStr_len+0 
	MOVLW       0
	MOVWF       FARG_ClearStr_len+1 
	CALL        _ClearStr+0, 0
;Spcsystem.c,995 :: 		}
	GOTO        L_PasswordEidtorSet189
L_PasswordEidtorSet175:
;Spcsystem.c,997 :: 		return;
	GOTO        L_end_PasswordEidtorSet
L_PasswordEidtorSet189:
;Spcsystem.c,998 :: 		}
	GOTO        L_PasswordEidtorSet190
L_PasswordEidtorSet173:
;Spcsystem.c,999 :: 		else if(cmd == CMD_RESET)   //reset
	MOVF        FARG_PasswordEidtorSet_cmd+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_PasswordEidtorSet191
;Spcsystem.c,1001 :: 		SetPSWReq = SET_PSW_START;
	CLRF        PasswordEidtorSet_SetPSWReq_L0+0 
;Spcsystem.c,1002 :: 		SetPSWVal = 0;
	CLRF        PasswordEidtorSet_SetPSWVal_L0+0 
;Spcsystem.c,1003 :: 		spc_system_flag.bite.char_actived = 0;
	BCF         _spc_system_flag+1, 3 
;Spcsystem.c,1004 :: 		CopyPSWTitle(Info_Line1, SetPSWReq);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_CopyPSWTitle_target+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_CopyPSWTitle_target+1 
	CLRF        FARG_CopyPSWTitle_adder+0 
	CALL        _CopyPSWTitle+0, 0
;Spcsystem.c,1005 :: 		getParaChar(Info_Line2, NO_STR);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       4
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,1006 :: 		CopyStr(Info_Line1, Info_Line1_shape, 16);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_CopyStr_resource+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_CopyStr_resource+1 
	MOVLW       _Info_Line1_shape+0
	MOVWF       FARG_CopyStr_target+0 
	MOVLW       hi_addr(_Info_Line1_shape+0)
	MOVWF       FARG_CopyStr_target+1 
	MOVLW       16
	MOVWF       FARG_CopyStr_len+0 
	CALL        _CopyStr+0, 0
;Spcsystem.c,1007 :: 		CopyStr(Info_Line2, Info_Line2_shape, 16);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_CopyStr_resource+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_CopyStr_resource+1 
	MOVLW       _Info_Line2_shape+0
	MOVWF       FARG_CopyStr_target+0 
	MOVLW       hi_addr(_Info_Line2_shape+0)
	MOVWF       FARG_CopyStr_target+1 
	MOVLW       16
	MOVWF       FARG_CopyStr_len+0 
	CALL        _CopyStr+0, 0
;Spcsystem.c,1008 :: 		ClearStr(SetP_shade.Password, 16);
	MOVLW       _SetP_shade+66
	MOVWF       FARG_ClearStr_target+0 
	MOVLW       hi_addr(_SetP_shade+66)
	MOVWF       FARG_ClearStr_target+1 
	MOVLW       16
	MOVWF       FARG_ClearStr_len+0 
	MOVLW       0
	MOVWF       FARG_ClearStr_len+1 
	CALL        _ClearStr+0, 0
;Spcsystem.c,1009 :: 		spc_system_flag.bite.char_flash = 0;
	BCF         _spc_system_flag+3, 6 
;Spcsystem.c,1010 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Spcsystem.c,1011 :: 		}
	GOTO        L_PasswordEidtorSet192
L_PasswordEidtorSet191:
;Spcsystem.c,1012 :: 		else if(cmd == CMD_SWITCH)
	MOVF        FARG_PasswordEidtorSet_cmd+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_PasswordEidtorSet193
;Spcsystem.c,1014 :: 		if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
	BTFSC       _pSPCValue+139, 0 
	GOTO        L_PasswordEidtorSet194
;Spcsystem.c,1015 :: 		return;
	GOTO        L_end_PasswordEidtorSet
L_PasswordEidtorSet194:
;Spcsystem.c,1017 :: 		CopyPSWTitle(Info_Line1, SetPSWReq);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_CopyPSWTitle_target+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_CopyPSWTitle_target+1 
	MOVF        PasswordEidtorSet_SetPSWReq_L0+0, 0 
	MOVWF       FARG_CopyPSWTitle_adder+0 
	CALL        _CopyPSWTitle+0, 0
;Spcsystem.c,1018 :: 		if(Info_Line2[SetP_shade.CharacNum] != ' ')
	MOVLW       _Info_Line2+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FSR0H 
	MOVF        _SetP_shade+82, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       32
	BTFSC       STATUS+0, 2 
	GOTO        L_PasswordEidtorSet195
;Spcsystem.c,1020 :: 		Info_Line2[SetP_shade.CharacNum] = '*';
	MOVLW       _Info_Line2+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FSR1H 
	MOVF        _SetP_shade+82, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       42
	MOVWF       POSTINC1+0 
;Spcsystem.c,1021 :: 		if((direct == 1) && (SetP_shade.CharacNum < 16) &&
	MOVF        FARG_PasswordEidtorSet_direct+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_PasswordEidtorSet198
	MOVLW       16
	SUBWF       _SetP_shade+82, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_PasswordEidtorSet198
;Spcsystem.c,1022 :: 		(SetP_shade.Password[SetP_shade.CharacNum] != ' '))
	MOVLW       _SetP_shade+66
	MOVWF       FSR0 
	MOVLW       hi_addr(_SetP_shade+66)
	MOVWF       FSR0H 
	MOVF        _SetP_shade+82, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       32
	BTFSC       STATUS+0, 2 
	GOTO        L_PasswordEidtorSet198
L__PasswordEidtorSet534:
;Spcsystem.c,1023 :: 		SetP_shade.CharacNum++;
	MOVF        _SetP_shade+82, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _SetP_shade+82 
L_PasswordEidtorSet198:
;Spcsystem.c,1024 :: 		SetP_shade.StringNum = 0;
	CLRF        _SetP_shade+83 
;Spcsystem.c,1025 :: 		spc_system_flag.bite.char_flash = 1;
	BSF         _spc_system_flag+3, 6 
;Spcsystem.c,1026 :: 		char_flash_loca = SetP_shade.CharacNum+1;
	MOVF        _SetP_shade+82, 0 
	ADDLW       1
	MOVWF       _char_flash_loca+0 
;Spcsystem.c,1027 :: 		}
L_PasswordEidtorSet195:
;Spcsystem.c,1028 :: 		}
	GOTO        L_PasswordEidtorSet199
L_PasswordEidtorSet193:
;Spcsystem.c,1029 :: 		else if(cmd == CMD_ADJUST)
	MOVF        FARG_PasswordEidtorSet_cmd+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_PasswordEidtorSet200
;Spcsystem.c,1031 :: 		if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
	BTFSC       _pSPCValue+139, 0 
	GOTO        L_PasswordEidtorSet201
;Spcsystem.c,1032 :: 		return;
	GOTO        L_end_PasswordEidtorSet
L_PasswordEidtorSet201:
;Spcsystem.c,1034 :: 		if(SetPSWReq == SET_PSW_START)
	MOVF        PasswordEidtorSet_SetPSWReq_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_PasswordEidtorSet202
;Spcsystem.c,1036 :: 		SetPSWVal ^= 1;
	MOVLW       1
	XORWF       PasswordEidtorSet_SetPSWVal_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       PasswordEidtorSet_SetPSWVal_L0+0 
;Spcsystem.c,1037 :: 		if(SetPSWVal)
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_PasswordEidtorSet203
;Spcsystem.c,1038 :: 		getParaChar(Info_Line2, YES_STR);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       5
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
	GOTO        L_PasswordEidtorSet204
L_PasswordEidtorSet203:
;Spcsystem.c,1040 :: 		getParaChar(Info_Line2, NO_STR);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       4
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
L_PasswordEidtorSet204:
;Spcsystem.c,1041 :: 		}
	GOTO        L_PasswordEidtorSet205
L_PasswordEidtorSet202:
;Spcsystem.c,1044 :: 		CopyPSWTitle(Info_Line1, SetPSWReq);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_CopyPSWTitle_target+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_CopyPSWTitle_target+1 
	MOVF        PasswordEidtorSet_SetPSWReq_L0+0, 0 
	MOVWF       FARG_CopyPSWTitle_adder+0 
	CALL        _CopyPSWTitle+0, 0
;Spcsystem.c,1045 :: 		if((direct == 1) && (SetP_shade.StringNum < PSW_CHARACT_NUM))
	MOVF        FARG_PasswordEidtorSet_direct+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_PasswordEidtorSet208
	MOVLW       63
	SUBWF       _SetP_shade+83, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_PasswordEidtorSet208
L__PasswordEidtorSet533:
;Spcsystem.c,1046 :: 		SetP_shade.Password[SetP_shade.CharacNum] = SpcCharactors[++SetP_shade.StringNum];
	MOVLW       _SetP_shade+66
	MOVWF       FSR1 
	MOVLW       hi_addr(_SetP_shade+66)
	MOVWF       FSR1H 
	MOVF        _SetP_shade+82, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVF        _SetP_shade+83, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _SetP_shade+83 
	MOVLW       Spcsystem_SpcCharactors+0
	ADDWF       _SetP_shade+83, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(Spcsystem_SpcCharactors+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(Spcsystem_SpcCharactors+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	GOTO        L_PasswordEidtorSet209
L_PasswordEidtorSet208:
;Spcsystem.c,1047 :: 		else if((direct == 0) && (SetP_shade.StringNum > 0))
	MOVF        FARG_PasswordEidtorSet_direct+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_PasswordEidtorSet212
	MOVF        _SetP_shade+83, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_PasswordEidtorSet212
L__PasswordEidtorSet532:
;Spcsystem.c,1048 :: 		SetP_shade.Password[SetP_shade.CharacNum] = SpcCharactors[--SetP_shade.StringNum];
	MOVLW       _SetP_shade+66
	MOVWF       FSR1 
	MOVLW       hi_addr(_SetP_shade+66)
	MOVWF       FSR1H 
	MOVF        _SetP_shade+82, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	DECF        _SetP_shade+83, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _SetP_shade+83 
	MOVLW       Spcsystem_SpcCharactors+0
	ADDWF       _SetP_shade+83, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(Spcsystem_SpcCharactors+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(Spcsystem_SpcCharactors+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
L_PasswordEidtorSet212:
L_PasswordEidtorSet209:
;Spcsystem.c,1050 :: 		Info_Line2[SetP_shade.CharacNum] = SetP_shade.Password[SetP_shade.CharacNum];
	MOVLW       _Info_Line2+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FSR1H 
	MOVF        _SetP_shade+82, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       _SetP_shade+66
	MOVWF       FSR0 
	MOVLW       hi_addr(_SetP_shade+66)
	MOVWF       FSR0H 
	MOVF        _SetP_shade+82, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,1051 :: 		spc_system_flag.bite.char_flash = 1;
	BSF         _spc_system_flag+3, 6 
;Spcsystem.c,1052 :: 		}
L_PasswordEidtorSet205:
;Spcsystem.c,1053 :: 		}
L_PasswordEidtorSet200:
L_PasswordEidtorSet199:
L_PasswordEidtorSet192:
L_PasswordEidtorSet190:
;Spcsystem.c,1054 :: 		}
L_end_PasswordEidtorSet:
	RETURN      0
; end of _PasswordEidtorSet

_ResetSPCSet:

;Spcsystem.c,1061 :: 		void ResetSPCSet(UCHAR direct, UCHAR cmd)
;Spcsystem.c,1066 :: 		if(cmd == CMD_ENTER)  //enter
	MOVF        FARG_ResetSPCSet_cmd+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_ResetSPCSet213
;Spcsystem.c,1068 :: 		if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
	BTFSC       _pSPCValue+139, 0 
	GOTO        L_ResetSPCSet214
;Spcsystem.c,1069 :: 		return;
	GOTO        L_end_ResetSPCSet
L_ResetSPCSet214:
;Spcsystem.c,1071 :: 		if(ResetStatisticsVal == 1)
	MOVF        ResetSPCSet_ResetStatisticsVal_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_ResetSPCSet215
;Spcsystem.c,1073 :: 		ResetStatisticsVal = 0;
	CLRF        ResetSPCSet_ResetStatisticsVal_L0+0 
;Spcsystem.c,1074 :: 		if(ResetStatisticsReq == 0)
	MOVF        ResetSPCSet_ResetStatisticsReq_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_ResetSPCSet216
;Spcsystem.c,1077 :: 		getParaChar(Info_Line1, CONFIRM_CHANGE_STR);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       84
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,1078 :: 		getParaChar(Info_Line2, NO_STR);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       4
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,1079 :: 		ResetStatisticsReq++;
	INCF        ResetSPCSet_ResetStatisticsReq_L0+0, 1 
;Spcsystem.c,1080 :: 		}
	GOTO        L_ResetSPCSet217
L_ResetSPCSet216:
;Spcsystem.c,1083 :: 		ResetStatisticsReq = 0;
	CLRF        ResetSPCSet_ResetStatisticsReq_L0+0 
;Spcsystem.c,1084 :: 		if(SpcMenu[Menustat].func_mark == FUNC_RESET)
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
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
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_ResetSPCSet218
;Spcsystem.c,1086 :: 		MemeSet((char *)&pSPCValue[0].SPCStatistics, 0, sizeof(STATISTICS));
	MOVLW       _pSPCValue+24
	MOVWF       FARG_MemeSet_target+0 
	MOVLW       hi_addr(_pSPCValue+24)
	MOVWF       FARG_MemeSet_target+1 
	CLRF        FARG_MemeSet_Transdata+0 
	MOVLW       30
	MOVWF       FARG_MemeSet_len+0 
	MOVLW       0
	MOVWF       FARG_MemeSet_len+1 
	CALL        _MemeSet+0, 0
;Spcsystem.c,1087 :: 		MemeSet((char *)&pSPCValue[1].SPCStatistics, 0, sizeof(STATISTICS));
	MOVLW       _pSPCValue+166
	MOVWF       FARG_MemeSet_target+0 
	MOVLW       hi_addr(_pSPCValue+166)
	MOVWF       FARG_MemeSet_target+1 
	CLRF        FARG_MemeSet_Transdata+0 
	MOVLW       30
	MOVWF       FARG_MemeSet_len+0 
	MOVLW       0
	MOVWF       FARG_MemeSet_len+1 
	CALL        _MemeSet+0, 0
;Spcsystem.c,1088 :: 		for(i=10; i<20;i++)
	MOVLW       10
	MOVWF       ResetSPCSet_i_L0+0 
L_ResetSPCSet219:
	MOVLW       20
	SUBWF       ResetSPCSet_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_ResetSPCSet220
;Spcsystem.c,1089 :: 		ClearStr(Actural_disp_str[i], 16);
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        ResetSPCSet_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 0 
	MOVWF       FARG_ClearStr_target+0 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_ClearStr_target+1 
	MOVLW       16
	MOVWF       FARG_ClearStr_len+0 
	MOVLW       0
	MOVWF       FARG_ClearStr_len+1 
	CALL        _ClearStr+0, 0
;Spcsystem.c,1088 :: 		for(i=10; i<20;i++)
	INCF        ResetSPCSet_i_L0+0, 1 
;Spcsystem.c,1089 :: 		ClearStr(Actural_disp_str[i], 16);
	GOTO        L_ResetSPCSet219
L_ResetSPCSet220:
;Spcsystem.c,1090 :: 		Statis_flag[0] = (STATIS_MAX_TEMP + STATIS_MIN_TEMP + STATIS_MAX_VOLT + STATIS_MIN_VOLT + STATIS_CURRENT + STATIS_GFI);
	MOVLW       63
	MOVWF       _Statis_flag+0 
;Spcsystem.c,1091 :: 		Statis_flag[1] = (STATIS_MAX_TEMP + STATIS_MIN_TEMP + STATIS_MAX_VOLT + STATIS_MIN_VOLT + STATIS_CURRENT + STATIS_GFI);
	MOVLW       63
	MOVWF       _Statis_flag+1 
;Spcsystem.c,1092 :: 		SetIntStr((int*)&pSPCValue[0].SPCStatistics.EnergyUsed, CH1_ACTURAL_ENEGY, UNIT_ENEGRY, 3);
	MOVLW       _pSPCValue+40
	MOVWF       FARG_SetIntStr_ptr+0 
	MOVLW       hi_addr(_pSPCValue+40)
	MOVWF       FARG_SetIntStr_ptr+1 
	MOVLW       24
	MOVWF       FARG_SetIntStr_strlocat+0 
	MOVLW       11
	MOVWF       FARG_SetIntStr_unitlocar+0 
	MOVLW       3
	MOVWF       FARG_SetIntStr_len+0 
	CALL        _SetIntStr+0, 0
;Spcsystem.c,1093 :: 		SetIntStr((int*)&pSPCValue[1].SPCStatistics.EnergyUsed, CH1_ACTURAL_ENEGY, UNIT_ENEGRY, 3);
	MOVLW       _pSPCValue+182
	MOVWF       FARG_SetIntStr_ptr+0 
	MOVLW       hi_addr(_pSPCValue+182)
	MOVWF       FARG_SetIntStr_ptr+1 
	MOVLW       24
	MOVWF       FARG_SetIntStr_strlocat+0 
	MOVLW       11
	MOVWF       FARG_SetIntStr_unitlocar+0 
	MOVLW       3
	MOVWF       FARG_SetIntStr_len+0 
	CALL        _SetIntStr+0, 0
;Spcsystem.c,1094 :: 		SetIntStr((int*)&pSPCValue[0].SPCStatistics.HeaterOnTime, CH1_ACTURAL_ENEGY, UNIT_ENEGRY, 3);
	MOVLW       _pSPCValue+50
	MOVWF       FARG_SetIntStr_ptr+0 
	MOVLW       hi_addr(_pSPCValue+50)
	MOVWF       FARG_SetIntStr_ptr+1 
	MOVLW       24
	MOVWF       FARG_SetIntStr_strlocat+0 
	MOVLW       11
	MOVWF       FARG_SetIntStr_unitlocar+0 
	MOVLW       3
	MOVWF       FARG_SetIntStr_len+0 
	CALL        _SetIntStr+0, 0
;Spcsystem.c,1095 :: 		SetIntStr((int*)&pSPCValue[1].SPCStatistics.HeaterOnTime, CH1_ACTURAL_ENEGY, UNIT_ENEGRY, 3);
	MOVLW       _pSPCValue+192
	MOVWF       FARG_SetIntStr_ptr+0 
	MOVLW       hi_addr(_pSPCValue+192)
	MOVWF       FARG_SetIntStr_ptr+1 
	MOVLW       24
	MOVWF       FARG_SetIntStr_strlocat+0 
	MOVLW       11
	MOVWF       FARG_SetIntStr_unitlocar+0 
	MOVLW       3
	MOVWF       FARG_SetIntStr_len+0 
	CALL        _SetIntStr+0, 0
;Spcsystem.c,1096 :: 		SetCostStr(0, CH1_ACTURAL_COST);
	CLRF        FARG_SetCostStr_databuff+0 
	CLRF        FARG_SetCostStr_databuff+1 
	CLRF        FARG_SetCostStr_databuff+2 
	CLRF        FARG_SetCostStr_databuff+3 
	MOVLW       26
	MOVWF       FARG_SetCostStr_strlocat+0 
	CALL        _SetCostStr+0, 0
;Spcsystem.c,1097 :: 		SetOntimeStr(0, CH1_ACTURAL_ONTIME);
	CLRF        FARG_SetOntimeStr_databuff+0 
	CLRF        FARG_SetOntimeStr_databuff+1 
	CLRF        FARG_SetOntimeStr_databuff+2 
	CLRF        FARG_SetOntimeStr_databuff+3 
	CLRF        FARG_SetOntimeStr_strlocat+0 
	CALL        _SetOntimeStr+0, 0
;Spcsystem.c,1098 :: 		SetCostStr(0, CH2_ACTURAL_COST);
	CLRF        FARG_SetCostStr_databuff+0 
	CLRF        FARG_SetCostStr_databuff+1 
	CLRF        FARG_SetCostStr_databuff+2 
	CLRF        FARG_SetCostStr_databuff+3 
	MOVLW       27
	MOVWF       FARG_SetCostStr_strlocat+0 
	CALL        _SetCostStr+0, 0
;Spcsystem.c,1099 :: 		SetOntimeStr(0, CH2_ACTURAL_ONTIME);
	CLRF        FARG_SetOntimeStr_databuff+0 
	CLRF        FARG_SetOntimeStr_databuff+1 
	CLRF        FARG_SetOntimeStr_databuff+2 
	CLRF        FARG_SetOntimeStr_databuff+3 
	MOVLW       1
	MOVWF       FARG_SetOntimeStr_strlocat+0 
	CALL        _SetOntimeStr+0, 0
;Spcsystem.c,1100 :: 		SetIntStr((int*)&pSPCAlarm.spcalarms.num_alarms, ACTURAL_ALARM, UNIT_ALARM, 7);
	MOVLW       _pSPCAlarm+0
	MOVWF       FARG_SetIntStr_ptr+0 
	MOVLW       hi_addr(_pSPCAlarm+0)
	MOVWF       FARG_SetIntStr_ptr+1 
	MOVLW       28
	MOVWF       FARG_SetIntStr_strlocat+0 
	MOVLW       12
	MOVWF       FARG_SetIntStr_unitlocar+0 
	MOVLW       7
	MOVWF       FARG_SetIntStr_len+0 
	CALL        _SetIntStr+0, 0
;Spcsystem.c,1101 :: 		}
	GOTO        L_ResetSPCSet222
L_ResetSPCSet218:
;Spcsystem.c,1102 :: 		else if(SpcMenu[Menustat].func_mark == FUNC_RESET_MODULE)
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
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
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_ResetSPCSet223
;Spcsystem.c,1104 :: 		EEPROM_Write(0x00,0x00);
	CLRF        FARG_EEPROM_Write_address+0 
	CLRF        FARG_EEPROM_Write_address+1 
	CLRF        FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;Spcsystem.c,1105 :: 		SPCSystemInitialize();
	CALL        _SPCSystemInitialize+0, 0
;Spcsystem.c,1106 :: 		}
L_ResetSPCSet223:
L_ResetSPCSet222:
;Spcsystem.c,1107 :: 		getParaChar(Info_Line1, CHANGE_COMPLETE_STR);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       85
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,1108 :: 		ClearStr(Info_Line2, 16);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_ClearStr_target+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_ClearStr_target+1 
	MOVLW       16
	MOVWF       FARG_ClearStr_len+0 
	MOVLW       0
	MOVWF       FARG_ClearStr_len+1 
	CALL        _ClearStr+0, 0
;Spcsystem.c,1109 :: 		LCDext = 1;
	MOVLW       1
	MOVWF       _LCDext+0 
;Spcsystem.c,1110 :: 		reset_psw_en = 0;
	CLRF        _reset_psw_en+0 
;Spcsystem.c,1111 :: 		}
L_ResetSPCSet217:
;Spcsystem.c,1112 :: 		}
	GOTO        L_ResetSPCSet224
L_ResetSPCSet215:
;Spcsystem.c,1115 :: 		ResetStatisticsReq = 0;
	CLRF        ResetSPCSet_ResetStatisticsReq_L0+0 
;Spcsystem.c,1116 :: 		ResetStatisticsVal = 0;
	CLRF        ResetSPCSet_ResetStatisticsVal_L0+0 
;Spcsystem.c,1117 :: 		CopyStr(Info_Line1_shape, Info_Line1, 16);
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
;Spcsystem.c,1118 :: 		CopyStr(Info_Line2_shape, Info_Line2, 16);
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
;Spcsystem.c,1119 :: 		}
L_ResetSPCSet224:
;Spcsystem.c,1120 :: 		}
	GOTO        L_ResetSPCSet225
L_ResetSPCSet213:
;Spcsystem.c,1121 :: 		else if(cmd == CMD_RESET)   //reset
	MOVF        FARG_ResetSPCSet_cmd+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_ResetSPCSet226
;Spcsystem.c,1123 :: 		ResetStatisticsReq = 0;
	CLRF        ResetSPCSet_ResetStatisticsReq_L0+0 
;Spcsystem.c,1124 :: 		ResetStatisticsVal = 0;
	CLRF        ResetSPCSet_ResetStatisticsVal_L0+0 
;Spcsystem.c,1125 :: 		for(i=0; i<16; i++)
	CLRF        ResetSPCSet_i_L0+0 
L_ResetSPCSet227:
	MOVLW       16
	SUBWF       ResetSPCSet_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_ResetSPCSet228
;Spcsystem.c,1126 :: 		Info_Line1[i] = SpcTxtLine1[Menustat][i];
	MOVLW       _Info_Line1+0
	MOVWF       FLOC__ResetSPCSet+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FLOC__ResetSPCSet+1 
	MOVF        ResetSPCSet_i_L0+0, 0 
	ADDWF       FLOC__ResetSPCSet+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__ResetSPCSet+1, 1 
	MOVLW       17
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
	MOVLW       Spcsystem_SpcTxtLine1+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcTxtLine1+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcTxtLine1+0)
	ADDWFC      R2, 1 
	MOVF        ResetSPCSet_i_L0+0, 0 
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
	MOVFF       FLOC__ResetSPCSet+0, FSR1
	MOVFF       FLOC__ResetSPCSet+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,1125 :: 		for(i=0; i<16; i++)
	INCF        ResetSPCSet_i_L0+0, 1 
;Spcsystem.c,1126 :: 		Info_Line1[i] = SpcTxtLine1[Menustat][i];
	GOTO        L_ResetSPCSet227
L_ResetSPCSet228:
;Spcsystem.c,1127 :: 		getParaChar(Info_Line2, NO_STR);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       4
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,1128 :: 		CopyStr(Info_Line1, Info_Line1_shape, 16);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_CopyStr_resource+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_CopyStr_resource+1 
	MOVLW       _Info_Line1_shape+0
	MOVWF       FARG_CopyStr_target+0 
	MOVLW       hi_addr(_Info_Line1_shape+0)
	MOVWF       FARG_CopyStr_target+1 
	MOVLW       16
	MOVWF       FARG_CopyStr_len+0 
	CALL        _CopyStr+0, 0
;Spcsystem.c,1129 :: 		CopyStr(Info_Line2, Info_Line2_shape, 16);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_CopyStr_resource+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_CopyStr_resource+1 
	MOVLW       _Info_Line2_shape+0
	MOVWF       FARG_CopyStr_target+0 
	MOVLW       hi_addr(_Info_Line2_shape+0)
	MOVWF       FARG_CopyStr_target+1 
	MOVLW       16
	MOVWF       FARG_CopyStr_len+0 
	CALL        _CopyStr+0, 0
;Spcsystem.c,1130 :: 		}
	GOTO        L_ResetSPCSet230
L_ResetSPCSet226:
;Spcsystem.c,1131 :: 		else if(cmd == CMD_ADJUST)
	MOVF        FARG_ResetSPCSet_cmd+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_ResetSPCSet231
;Spcsystem.c,1133 :: 		if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
	BTFSC       _pSPCValue+139, 0 
	GOTO        L_ResetSPCSet232
;Spcsystem.c,1134 :: 		return;
	GOTO        L_end_ResetSPCSet
L_ResetSPCSet232:
;Spcsystem.c,1136 :: 		if(direct)
	MOVF        FARG_ResetSPCSet_direct+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_ResetSPCSet233
;Spcsystem.c,1138 :: 		if(ResetStatisticsVal == 0) ResetStatisticsVal = 1;
	MOVF        ResetSPCSet_ResetStatisticsVal_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_ResetSPCSet234
	MOVLW       1
	MOVWF       ResetSPCSet_ResetStatisticsVal_L0+0 
L_ResetSPCSet234:
;Spcsystem.c,1139 :: 		}
	GOTO        L_ResetSPCSet235
L_ResetSPCSet233:
;Spcsystem.c,1142 :: 		if(ResetStatisticsVal) ResetStatisticsVal = 0;
	MOVF        ResetSPCSet_ResetStatisticsVal_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_ResetSPCSet236
	CLRF        ResetSPCSet_ResetStatisticsVal_L0+0 
L_ResetSPCSet236:
;Spcsystem.c,1143 :: 		}
L_ResetSPCSet235:
;Spcsystem.c,1145 :: 		if(ResetStatisticsReq == 1)
	MOVF        ResetSPCSet_ResetStatisticsReq_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_ResetSPCSet237
;Spcsystem.c,1146 :: 		getParaChar(Info_Line1, CONFIRM_CHANGE_STR);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       84
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
L_ResetSPCSet237:
;Spcsystem.c,1149 :: 		if(ResetStatisticsVal)
	MOVF        ResetSPCSet_ResetStatisticsVal_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_ResetSPCSet238
;Spcsystem.c,1150 :: 		getParaChar(Info_Line2, YES_STR);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       5
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
	GOTO        L_ResetSPCSet239
L_ResetSPCSet238:
;Spcsystem.c,1152 :: 		getParaChar(Info_Line2, NO_STR);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       4
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
L_ResetSPCSet239:
;Spcsystem.c,1153 :: 		}
L_ResetSPCSet231:
L_ResetSPCSet230:
L_ResetSPCSet225:
;Spcsystem.c,1154 :: 		}
L_end_ResetSPCSet:
	RETURN      0
; end of _ResetSPCSet

_Savedata:

;Spcsystem.c,1161 :: 		void Savedata(UINT flash_lacl, UINT len, UCHAR *ptr, char cmd)
;Spcsystem.c,1166 :: 		prt_op = ptr;
	MOVF        FARG_Savedata_ptr+0, 0 
	MOVWF       Savedata_prt_op_L0+0 
	MOVF        FARG_Savedata_ptr+1, 0 
	MOVWF       Savedata_prt_op_L0+1 
;Spcsystem.c,1168 :: 		if(cmd)
	MOVF        FARG_Savedata_cmd+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Savedata240
;Spcsystem.c,1169 :: 		add = 0x0001 + sizeof(SPCSETPIONTS);
	MOVLW       89
	MOVWF       Savedata_add_L0+0 
	MOVLW       0
	MOVWF       Savedata_add_L0+1 
	GOTO        L_Savedata241
L_Savedata240:
;Spcsystem.c,1171 :: 		add = 0x0001 + flash_lacl;
	MOVLW       1
	ADDWF       FARG_Savedata_flash_lacl+0, 0 
	MOVWF       Savedata_add_L0+0 
	MOVLW       0
	ADDWFC      FARG_Savedata_flash_lacl+1, 0 
	MOVWF       Savedata_add_L0+1 
L_Savedata241:
;Spcsystem.c,1173 :: 		EEPROM_set(add, len, prt_op);
	MOVF        Savedata_add_L0+0, 0 
	MOVWF       FARG_EEPROM_set_EEPROM_WRITE_ADDRESS+0 
	MOVF        Savedata_add_L0+1, 0 
	MOVWF       FARG_EEPROM_set_EEPROM_WRITE_ADDRESS+1 
	MOVF        FARG_Savedata_len+0, 0 
	MOVWF       FARG_EEPROM_set_Len+0 
	MOVF        Savedata_prt_op_L0+0, 0 
	MOVWF       FARG_EEPROM_set_writebuffer+0 
	MOVF        Savedata_prt_op_L0+1, 0 
	MOVWF       FARG_EEPROM_set_writebuffer+1 
	CALL        _EEPROM_set+0, 0
;Spcsystem.c,1174 :: 		}
L_end_Savedata:
	RETURN      0
; end of _Savedata

_Para_Flag_Set:

;Spcsystem.c,1181 :: 		void Para_Flag_Set(UCHAR direct, UCHAR cmd)
;Spcsystem.c,1183 :: 		volatile char address = 0;
	CLRF        Para_Flag_Set_address_L0+0 
	CLRF        Para_Flag_Set_IndicatorEN_L0+0 
;Spcsystem.c,1187 :: 		address = SpcMenu[Menustat].add;
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       10
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, Para_Flag_Set_address_L0+0
;Spcsystem.c,1188 :: 		switch(SpcMenu[Menustat].offset)
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R4 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       R5 
	GOTO        L_Para_Flag_Set242
;Spcsystem.c,1190 :: 		case FLAG_PSWEN:
L_Para_Flag_Set244:
;Spcsystem.c,1191 :: 		case FLAG_DEFAULTDISP:
L_Para_Flag_Set245:
;Spcsystem.c,1192 :: 		case FLAG_DISPMODE:
L_Para_Flag_Set246:
;Spcsystem.c,1193 :: 		case FLAG_BAUDRATE:
L_Para_Flag_Set247:
;Spcsystem.c,1194 :: 		case FLAG_UNIT:
L_Para_Flag_Set248:
;Spcsystem.c,1195 :: 		ChannelTemp = 0;
	CLRF        Para_Flag_Set_ChannelTemp_L0+0 
;Spcsystem.c,1196 :: 		break;
	GOTO        L_Para_Flag_Set243
;Spcsystem.c,1197 :: 		default:
L_Para_Flag_Set249:
;Spcsystem.c,1198 :: 		ChannelTemp = Cable_Channel;
	MOVF        _Cable_Channel+0, 0 
	MOVWF       Para_Flag_Set_ChannelTemp_L0+0 
;Spcsystem.c,1199 :: 		IndicatorEN = 1;
	MOVLW       1
	MOVWF       Para_Flag_Set_IndicatorEN_L0+0 
;Spcsystem.c,1200 :: 		break;
	GOTO        L_Para_Flag_Set243
;Spcsystem.c,1201 :: 		}
L_Para_Flag_Set242:
	MOVF        R3, 0 
	MOVWF       TBLPTRL 
	MOVF        R4, 0 
	MOVWF       TBLPTRH 
	MOVF        R5, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R1
	MOVF        R1, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_Para_Flag_Set244
	MOVF        R3, 0 
	MOVWF       TBLPTRL 
	MOVF        R4, 0 
	MOVWF       TBLPTRH 
	MOVF        R5, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R1
	MOVF        R1, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_Para_Flag_Set245
	MOVF        R3, 0 
	MOVWF       TBLPTRL 
	MOVF        R4, 0 
	MOVWF       TBLPTRH 
	MOVF        R5, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R1
	MOVF        R1, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_Para_Flag_Set246
	MOVF        R3, 0 
	MOVWF       TBLPTRL 
	MOVF        R4, 0 
	MOVWF       TBLPTRH 
	MOVF        R5, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R1
	MOVF        R1, 0 
	XORLW       12
	BTFSC       STATUS+0, 2 
	GOTO        L_Para_Flag_Set247
	MOVF        R3, 0 
	MOVWF       TBLPTRL 
	MOVF        R4, 0 
	MOVWF       TBLPTRH 
	MOVF        R5, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R1
	MOVF        R1, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_Para_Flag_Set248
	GOTO        L_Para_Flag_Set249
L_Para_Flag_Set243:
;Spcsystem.c,1205 :: 		if(cmd == CMD_ENTER) //enter
	MOVF        FARG_Para_Flag_Set_cmd+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Para_Flag_Set250
;Spcsystem.c,1207 :: 		if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
	BTFSC       _pSPCValue+139, 0 
	GOTO        L_Para_Flag_Set251
;Spcsystem.c,1208 :: 		return;
	GOTO        L_end_Para_Flag_Set
L_Para_Flag_Set251:
;Spcsystem.c,1210 :: 		pSPCValue[ChannelTemp].SPCSetPoints.system_valueb.word &=
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        Para_Flag_Set_ChannelTemp_L0+0, 0 
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
	MOVF        R0, 0 
	MOVWF       FLOC__Para_Flag_Set+0 
	MOVF        R1, 0 
	MOVWF       FLOC__Para_Flag_Set+1 
;Spcsystem.c,1211 :: 		~(((0xffffffff << flag_num[SpcMenu[Menustat].len]) ^ 0xffffffff) << SpcMenu[Menustat].offset);
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 0 
	MOVWF       R9 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 0 
	MOVWF       R10 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R2, 0 
	MOVWF       R11 
	MOVLW       6
	ADDWF       R9, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R10, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R11, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	TBLRD*+
	MOVFF       TABLAT+0, R1
	TBLRD*+
	MOVFF       TABLAT+0, R2
	TBLRD*+
	MOVFF       TABLAT+0, R3
	MOVLW       Spcsystem_flag_num+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(Spcsystem_flag_num+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(Spcsystem_flag_num+0)
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVLW       255
	MOVWF       R0 
	MOVLW       255
	MOVWF       R1 
	MOVLW       255
	MOVWF       R2 
	MOVLW       255
	MOVWF       R3 
	MOVF        R4, 0 
L__Para_Flag_Set615:
	BZ          L__Para_Flag_Set616
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Para_Flag_Set615
L__Para_Flag_Set616:
	MOVLW       255
	XORWF       R0, 0 
	MOVWF       R5 
	MOVLW       255
	XORWF       R1, 0 
	MOVWF       R6 
	MOVLW       255
	XORWF       R2, 0 
	MOVWF       R7 
	MOVLW       255
	XORWF       R3, 0 
	MOVWF       R8 
	MOVLW       5
	ADDWF       R9, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R10, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R11, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	MOVF        R4, 0 
L__Para_Flag_Set617:
	BZ          L__Para_Flag_Set618
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Para_Flag_Set617
L__Para_Flag_Set618:
	COMF        R0, 1 
	COMF        R1, 1 
	COMF        R2, 1 
	COMF        R3, 1 
	MOVFF       FLOC__Para_Flag_Set+0, FSR0
	MOVFF       FLOC__Para_Flag_Set+1, FSR0H
	MOVF        POSTINC0+0, 0 
	ANDWF       R0, 1 
	MOVF        POSTINC0+0, 0 
	ANDWF       R1, 1 
	MOVF        POSTINC0+0, 0 
	ANDWF       R2, 1 
	MOVF        POSTINC0+0, 0 
	ANDWF       R3, 1 
	MOVFF       FLOC__Para_Flag_Set+0, FSR1
	MOVFF       FLOC__Para_Flag_Set+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,1212 :: 		pSPCValue[ChannelTemp].SPCSetPoints.system_valueb.word |= ((ULONG)SetP_shade1.chare << SpcMenu[Menustat].offset);
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        Para_Flag_Set_ChannelTemp_L0+0, 0 
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
	MOVF        R0, 0 
	MOVWF       FLOC__Para_Flag_Set+4 
	MOVF        R1, 0 
	MOVWF       FLOC__Para_Flag_Set+5 
	MOVF        _SetP_shade1+0, 0 
	MOVWF       FLOC__Para_Flag_Set+0 
	MOVLW       0
	MOVWF       FLOC__Para_Flag_Set+1 
	MOVWF       FLOC__Para_Flag_Set+2 
	MOVWF       FLOC__Para_Flag_Set+3 
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
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
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        FLOC__Para_Flag_Set+0, 0 
	MOVWF       R0 
	MOVF        FLOC__Para_Flag_Set+1, 0 
	MOVWF       R1 
	MOVF        FLOC__Para_Flag_Set+2, 0 
	MOVWF       R2 
	MOVF        FLOC__Para_Flag_Set+3, 0 
	MOVWF       R3 
	MOVF        R4, 0 
L__Para_Flag_Set619:
	BZ          L__Para_Flag_Set620
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__Para_Flag_Set619
L__Para_Flag_Set620:
	MOVFF       FLOC__Para_Flag_Set+4, FSR0
	MOVFF       FLOC__Para_Flag_Set+5, FSR0H
	MOVF        POSTINC0+0, 0 
	IORWF       R0, 1 
	MOVF        POSTINC0+0, 0 
	IORWF       R1, 1 
	MOVF        POSTINC0+0, 0 
	IORWF       R2, 1 
	MOVF        POSTINC0+0, 0 
	IORWF       R3, 1 
	MOVFF       FLOC__Para_Flag_Set+4, FSR1
	MOVFF       FLOC__Para_Flag_Set+5, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,1214 :: 		storage();
	CALL        _storage+0, 0
;Spcsystem.c,1215 :: 		ParametersChanged = 1;
	MOVLW       1
	MOVWF       _ParametersChanged+0 
;Spcsystem.c,1216 :: 		}
	GOTO        L_Para_Flag_Set252
L_Para_Flag_Set250:
;Spcsystem.c,1217 :: 		else if(cmd == CMD_RESET)     //reset
	MOVF        FARG_Para_Flag_Set_cmd+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Para_Flag_Set253
;Spcsystem.c,1219 :: 		SetP_shade1.chare = (pSPCValue[ChannelTemp].SPCSetPoints.system_valueb.word >>
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        Para_Flag_Set_ChannelTemp_L0+0, 0 
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
	MOVWF       FLOC__Para_Flag_Set+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__Para_Flag_Set+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__Para_Flag_Set+2 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__Para_Flag_Set+3 
;Spcsystem.c,1220 :: 		SpcMenu[Menustat].offset) &
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 0 
	MOVWF       R4 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 0 
	MOVWF       R5 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R2, 0 
	MOVWF       R6 
	MOVLW       5
	ADDWF       R4, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R5, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R6, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        FLOC__Para_Flag_Set+0, 0 
	MOVWF       R7 
	MOVF        FLOC__Para_Flag_Set+1, 0 
	MOVWF       R8 
	MOVF        FLOC__Para_Flag_Set+2, 0 
	MOVWF       R9 
	MOVF        FLOC__Para_Flag_Set+3, 0 
	MOVWF       R10 
	MOVF        R0, 0 
L__Para_Flag_Set621:
	BZ          L__Para_Flag_Set622
	RRCF        R10, 1 
	RRCF        R9, 1 
	RRCF        R8, 1 
	RRCF        R7, 1 
	BCF         R10, 7 
	ADDLW       255
	GOTO        L__Para_Flag_Set621
L__Para_Flag_Set622:
;Spcsystem.c,1221 :: 		((0xffffffff << flag_num[SpcMenu[Menustat].len]) ^ 0xffffffff);
	MOVLW       6
	ADDWF       R4, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R5, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R6, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	TBLRD*+
	MOVFF       TABLAT+0, R1
	TBLRD*+
	MOVFF       TABLAT+0, R2
	TBLRD*+
	MOVFF       TABLAT+0, R3
	MOVLW       Spcsystem_flag_num+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(Spcsystem_flag_num+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(Spcsystem_flag_num+0)
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	MOVWF       R1 
	MOVLW       255
	MOVWF       R0 
	MOVF        R1, 0 
L__Para_Flag_Set623:
	BZ          L__Para_Flag_Set624
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__Para_Flag_Set623
L__Para_Flag_Set624:
	MOVLW       255
	XORWF       R0, 1 
	MOVF        R7, 0 
	ANDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _SetP_shade1+0 
;Spcsystem.c,1223 :: 		getParaChar(Info_Line2, address+SetP_shade1.chare);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVF        R0, 0 
	ADDWF       Para_Flag_Set_address_L0+0, 0 
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,1224 :: 		}
	GOTO        L_Para_Flag_Set254
L_Para_Flag_Set253:
;Spcsystem.c,1225 :: 		else if(cmd == CMD_ADJUST)    //left/right
	MOVF        FARG_Para_Flag_Set_cmd+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_Para_Flag_Set255
;Spcsystem.c,1227 :: 		if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
	BTFSC       _pSPCValue+139, 0 
	GOTO        L_Para_Flag_Set256
;Spcsystem.c,1228 :: 		return;
	GOTO        L_end_Para_Flag_Set
L_Para_Flag_Set256:
;Spcsystem.c,1230 :: 		Flashing_EN();
	CALL        _Flashing_EN+0, 0
;Spcsystem.c,1231 :: 		if((direct == 1) && (SetP_shade1.chare<SpcMenu[Menustat].len-1))
	MOVF        FARG_Para_Flag_Set_direct+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Para_Flag_Set259
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
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
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVLW       1
	SUBWF       R4, 1 
	MOVLW       0
	SUBWFB      R5, 1 
	SUBWFB      R6, 1 
	SUBWFB      R7, 1 
	MOVF        R7, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__Para_Flag_Set625
	MOVF        R6, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__Para_Flag_Set625
	MOVF        R5, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__Para_Flag_Set625
	MOVF        R4, 0 
	SUBWF       _SetP_shade1+0, 0 
L__Para_Flag_Set625:
	BTFSC       STATUS+0, 0 
	GOTO        L_Para_Flag_Set259
L__Para_Flag_Set536:
;Spcsystem.c,1232 :: 		SetP_shade1.chare++;
	MOVF        _SetP_shade1+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _SetP_shade1+0 
	GOTO        L_Para_Flag_Set260
L_Para_Flag_Set259:
;Spcsystem.c,1233 :: 		else if((direct == 0) && (SetP_shade1.chare>0))
	MOVF        FARG_Para_Flag_Set_direct+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Para_Flag_Set263
	MOVF        _SetP_shade1+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Para_Flag_Set263
L__Para_Flag_Set535:
;Spcsystem.c,1234 :: 		SetP_shade1.chare--;
	DECF        _SetP_shade1+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _SetP_shade1+0 
L_Para_Flag_Set263:
L_Para_Flag_Set260:
;Spcsystem.c,1236 :: 		getParaChar(Info_Line2, address+SetP_shade1.chare);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVF        _SetP_shade1+0, 0 
	ADDWF       Para_Flag_Set_address_L0+0, 0 
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,1237 :: 		}
L_Para_Flag_Set255:
L_Para_Flag_Set254:
L_Para_Flag_Set252:
;Spcsystem.c,1239 :: 		if(IndicatorEN)
	MOVF        Para_Flag_Set_IndicatorEN_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Para_Flag_Set264
;Spcsystem.c,1241 :: 		Info_Line2[14] = 'P';
	MOVLW       80
	MOVWF       _Info_Line2+14 
;Spcsystem.c,1242 :: 		Info_Line2[15] = Cable_Channel+0X31;
	MOVLW       49
	ADDWF       _Cable_Channel+0, 0 
	MOVWF       _Info_Line2+15 
;Spcsystem.c,1243 :: 		}
L_Para_Flag_Set264:
;Spcsystem.c,1244 :: 		}
L_end_Para_Flag_Set:
	RETURN      0
; end of _Para_Flag_Set

_Para_int_Set:

;Spcsystem.c,1251 :: 		void Para_int_Set(UCHAR direct, UCHAR cmd)
;Spcsystem.c,1257 :: 		char IndicatorEN=0;
	CLRF        Para_int_Set_IndicatorEN_L0+0 
;Spcsystem.c,1259 :: 		switch(SpcMenu[Menustat].offset)
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R4 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       R5 
	GOTO        L_Para_int_Set265
;Spcsystem.c,1261 :: 		case INTSET_DISPTIMEOUT:
L_Para_int_Set267:
;Spcsystem.c,1262 :: 		case INTSET_AUTOTEST:
L_Para_int_Set268:
;Spcsystem.c,1263 :: 		case INTSET_MODBUS:
L_Para_int_Set269:
;Spcsystem.c,1264 :: 		case INTSET_LOWVOLT:
L_Para_int_Set270:
;Spcsystem.c,1265 :: 		case INTSET_HIGHVOLT:
L_Para_int_Set271:
;Spcsystem.c,1266 :: 		add = (UCHAR *)(&pSPCValue[0].SPCSetPoints);
	MOVLW       _pSPCValue+54
	MOVWF       Para_int_Set_add_L0+0 
	MOVLW       hi_addr(_pSPCValue+54)
	MOVWF       Para_int_Set_add_L0+1 
;Spcsystem.c,1267 :: 		break;
	GOTO        L_Para_int_Set266
;Spcsystem.c,1268 :: 		default:
L_Para_int_Set272:
;Spcsystem.c,1269 :: 		if(Cable_Channel == 0)
	MOVF        _Cable_Channel+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Para_int_Set273
;Spcsystem.c,1270 :: 		add = (UCHAR *)(&pSPCValue[0].SPCSetPoints);
	MOVLW       _pSPCValue+54
	MOVWF       Para_int_Set_add_L0+0 
	MOVLW       hi_addr(_pSPCValue+54)
	MOVWF       Para_int_Set_add_L0+1 
	GOTO        L_Para_int_Set274
L_Para_int_Set273:
;Spcsystem.c,1272 :: 		add = (UCHAR *)(&pSPCValue[1].SPCSetPoints);
	MOVLW       _pSPCValue+196
	MOVWF       Para_int_Set_add_L0+0 
	MOVLW       hi_addr(_pSPCValue+196)
	MOVWF       Para_int_Set_add_L0+1 
L_Para_int_Set274:
;Spcsystem.c,1274 :: 		IndicatorEN=1;
	MOVLW       1
	MOVWF       Para_int_Set_IndicatorEN_L0+0 
;Spcsystem.c,1275 :: 		break;
	GOTO        L_Para_int_Set266
;Spcsystem.c,1276 :: 		}
L_Para_int_Set265:
	MOVF        R3, 0 
	MOVWF       TBLPTRL 
	MOVF        R4, 0 
	MOVWF       TBLPTRH 
	MOVF        R5, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R1
	MOVF        R1, 0 
	XORLW       34
	BTFSC       STATUS+0, 2 
	GOTO        L_Para_int_Set267
	MOVF        R3, 0 
	MOVWF       TBLPTRL 
	MOVF        R4, 0 
	MOVWF       TBLPTRH 
	MOVF        R5, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R1
	MOVF        R1, 0 
	XORLW       32
	BTFSC       STATUS+0, 2 
	GOTO        L_Para_int_Set268
	MOVF        R3, 0 
	MOVWF       TBLPTRL 
	MOVF        R4, 0 
	MOVWF       TBLPTRH 
	MOVF        R5, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R1
	MOVF        R1, 0 
	XORLW       40
	BTFSC       STATUS+0, 2 
	GOTO        L_Para_int_Set269
	MOVF        R3, 0 
	MOVWF       TBLPTRL 
	MOVF        R4, 0 
	MOVWF       TBLPTRH 
	MOVF        R5, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R1
	MOVF        R1, 0 
	XORLW       24
	BTFSC       STATUS+0, 2 
	GOTO        L_Para_int_Set270
	MOVF        R3, 0 
	MOVWF       TBLPTRL 
	MOVF        R4, 0 
	MOVWF       TBLPTRH 
	MOVF        R5, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R1
	MOVF        R1, 0 
	XORLW       26
	BTFSC       STATUS+0, 2 
	GOTO        L_Para_int_Set271
	GOTO        L_Para_int_Set272
L_Para_int_Set266:
;Spcsystem.c,1278 :: 		add += SpcMenu[Menustat].offset;
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 0 
	MOVWF       R4 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 0 
	MOVWF       R5 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R2, 0 
	MOVWF       R6 
	MOVLW       5
	ADDWF       R4, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R5, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R6, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVLW       0
	MOVWF       R1 
	MOVF        Para_int_Set_add_L0+0, 0 
	ADDWF       R0, 1 
	MOVF        Para_int_Set_add_L0+1, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       Para_int_Set_add_L0+0 
	MOVF        R1, 0 
	MOVWF       Para_int_Set_add_L0+1 
;Spcsystem.c,1279 :: 		ptr = (int*)add;
	MOVF        R0, 0 
	MOVWF       Para_int_Set_ptr_L0+0 
	MOVF        R1, 0 
	MOVWF       Para_int_Set_ptr_L0+1 
;Spcsystem.c,1282 :: 		if(SpcMenu[Menustat].edge_nofix & MAX_NOFIX)
	MOVLW       18
	ADDWF       R4, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R5, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R6, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R1
	BTFSS       R1, 4 
	GOTO        L_Para_int_Set275
;Spcsystem.c,1284 :: 		Para_int_max = *(ptr+1);
	MOVLW       2
	ADDWF       Para_int_Set_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      Para_int_Set_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       Para_int_Set_Para_int_max_L0+0 
	MOVF        R2, 0 
	MOVWF       Para_int_Set_Para_int_max_L0+1 
;Spcsystem.c,1285 :: 		if(Para_int_max == SPC_SYSTEMVALUE_OFF)
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__Para_int_Set627
	MOVLW       255
	XORWF       R1, 0 
L__Para_int_Set627:
	BTFSS       STATUS+0, 2 
	GOTO        L_Para_int_Set276
;Spcsystem.c,1286 :: 		Para_int_max = SpcMenu[Menustat].MaxVal;
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       11
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, Para_int_Set_Para_int_max_L0+0
	TBLRD*+
	MOVFF       TABLAT+0, Para_int_Set_Para_int_max_L0+1
	GOTO        L_Para_int_Set277
L_Para_int_Set276:
;Spcsystem.c,1288 :: 		Para_int_max -= SpcMenu[Menustat].len;
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
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
	MOVF        R0, 0 
	SUBWF       Para_int_Set_Para_int_max_L0+0, 1 
	MOVF        R1, 0 
	SUBWFB      Para_int_Set_Para_int_max_L0+1, 1 
L_Para_int_Set277:
;Spcsystem.c,1290 :: 		if(Para_int_max < SpcMenu[Menustat].MinVal)
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       13
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
	TBLRD*+
	MOVFF       TABLAT+0, R2
	MOVLW       128
	XORWF       Para_int_Set_Para_int_max_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Para_int_Set628
	MOVF        R1, 0 
	SUBWF       Para_int_Set_Para_int_max_L0+0, 0 
L__Para_int_Set628:
	BTFSC       STATUS+0, 0 
	GOTO        L_Para_int_Set278
;Spcsystem.c,1291 :: 		Para_int_max = SpcMenu[Menustat].MinVal;
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       13
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, Para_int_Set_Para_int_max_L0+0
	TBLRD*+
	MOVFF       TABLAT+0, Para_int_Set_Para_int_max_L0+1
L_Para_int_Set278:
;Spcsystem.c,1292 :: 		}
	GOTO        L_Para_int_Set279
L_Para_int_Set275:
;Spcsystem.c,1294 :: 		Para_int_max = SpcMenu[Menustat].MaxVal;
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       11
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, Para_int_Set_Para_int_max_L0+0
	TBLRD*+
	MOVFF       TABLAT+0, Para_int_Set_Para_int_max_L0+1
L_Para_int_Set279:
;Spcsystem.c,1296 :: 		if(SpcMenu[Menustat].edge_nofix & MIN_NOFIX)
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       18
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
	BTFSS       R1, 5 
	GOTO        L_Para_int_Set280
;Spcsystem.c,1298 :: 		Para_int_min = *(ptr-1);
	MOVLW       2
	SUBWF       Para_int_Set_ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	SUBWFB      Para_int_Set_ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       Para_int_Set_Para_int_min_L0+0 
	MOVF        R2, 0 
	MOVWF       Para_int_Set_Para_int_min_L0+1 
;Spcsystem.c,1299 :: 		if(Para_int_min == SPC_SYSTEMVALUE_OFF)
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__Para_int_Set629
	MOVLW       255
	XORWF       R1, 0 
L__Para_int_Set629:
	BTFSS       STATUS+0, 2 
	GOTO        L_Para_int_Set281
;Spcsystem.c,1300 :: 		Para_int_min = SpcMenu[Menustat].MinVal;
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       13
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, Para_int_Set_Para_int_min_L0+0
	TBLRD*+
	MOVFF       TABLAT+0, Para_int_Set_Para_int_min_L0+1
	GOTO        L_Para_int_Set282
L_Para_int_Set281:
;Spcsystem.c,1302 :: 		Para_int_min += SpcMenu[Menustat].len;
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
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
	MOVF        R0, 0 
	ADDWF       Para_int_Set_Para_int_min_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      Para_int_Set_Para_int_min_L0+1, 1 
L_Para_int_Set282:
;Spcsystem.c,1304 :: 		if(Para_int_min > SpcMenu[Menustat].MaxVal)
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       11
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
	TBLRD*+
	MOVFF       TABLAT+0, R2
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       Para_int_Set_Para_int_min_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Para_int_Set630
	MOVF        Para_int_Set_Para_int_min_L0+0, 0 
	SUBWF       R1, 0 
L__Para_int_Set630:
	BTFSC       STATUS+0, 0 
	GOTO        L_Para_int_Set283
;Spcsystem.c,1305 :: 		Para_int_min = SpcMenu[Menustat].MaxVal;
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       11
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, Para_int_Set_Para_int_min_L0+0
	TBLRD*+
	MOVFF       TABLAT+0, Para_int_Set_Para_int_min_L0+1
L_Para_int_Set283:
;Spcsystem.c,1306 :: 		}
	GOTO        L_Para_int_Set284
L_Para_int_Set280:
;Spcsystem.c,1308 :: 		Para_int_min = SpcMenu[Menustat].MinVal;
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       13
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, Para_int_Set_Para_int_min_L0+0
	TBLRD*+
	MOVFF       TABLAT+0, Para_int_Set_Para_int_min_L0+1
L_Para_int_Set284:
;Spcsystem.c,1310 :: 		if(cmd == CMD_ENTER)    //enter
	MOVF        FARG_Para_int_Set_cmd+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Para_int_Set285
;Spcsystem.c,1312 :: 		if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
	BTFSC       _pSPCValue+139, 0 
	GOTO        L_Para_int_Set286
;Spcsystem.c,1313 :: 		return;
	GOTO        L_end_Para_int_Set
L_Para_int_Set286:
;Spcsystem.c,1315 :: 		*ptr = Para_int_temp;
	MOVFF       Para_int_Set_ptr_L0+0, FSR1
	MOVFF       Para_int_Set_ptr_L0+1, FSR1H
	MOVF        Para_int_Set_Para_int_temp_L0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        Para_int_Set_Para_int_temp_L0+1, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,1316 :: 		storage();
	CALL        _storage+0, 0
;Spcsystem.c,1317 :: 		ParametersChanged = 1;
	MOVLW       1
	MOVWF       _ParametersChanged+0 
;Spcsystem.c,1318 :: 		}
	GOTO        L_Para_int_Set287
L_Para_int_Set285:
;Spcsystem.c,1319 :: 		else if(cmd == CMD_RESET)  //reset
	MOVF        FARG_Para_int_Set_cmd+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Para_int_Set288
;Spcsystem.c,1321 :: 		Para_int_temp = *ptr;
	MOVFF       Para_int_Set_ptr_L0+0, FSR0
	MOVFF       Para_int_Set_ptr_L0+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       Para_int_Set_Para_int_temp_L0+0 
	MOVF        R2, 0 
	MOVWF       Para_int_Set_Para_int_temp_L0+1 
;Spcsystem.c,1323 :: 		if(Para_int_temp == SPC_SYSTEMVALUE_DISABLE)
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__Para_int_Set631
	MOVLW       252
	XORWF       R1, 0 
L__Para_int_Set631:
	BTFSS       STATUS+0, 2 
	GOTO        L_Para_int_Set289
;Spcsystem.c,1324 :: 		getParaChar(Info_Line2, DISABLE_STR);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       77
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
	GOTO        L_Para_int_Set290
L_Para_int_Set289:
;Spcsystem.c,1325 :: 		else if(Para_int_temp == SPC_SYSTEMVALUE_CONTINU)
	MOVF        Para_int_Set_Para_int_temp_L0+1, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__Para_int_Set632
	MOVLW       253
	XORWF       Para_int_Set_Para_int_temp_L0+0, 0 
L__Para_int_Set632:
	BTFSS       STATUS+0, 2 
	GOTO        L_Para_int_Set291
;Spcsystem.c,1326 :: 		getParaChar(Info_Line2, COUNTINU_STR);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       76
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
	GOTO        L_Para_int_Set292
L_Para_int_Set291:
;Spcsystem.c,1327 :: 		else if(Para_int_temp == SPC_SYSTEMVALUE_OFF)
	MOVF        Para_int_Set_Para_int_temp_L0+1, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__Para_int_Set633
	MOVLW       255
	XORWF       Para_int_Set_Para_int_temp_L0+0, 0 
L__Para_int_Set633:
	BTFSS       STATUS+0, 2 
	GOTO        L_Para_int_Set293
;Spcsystem.c,1328 :: 		getParaChar(Info_Line2, OFF_STR);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       73
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
	GOTO        L_Para_int_Set294
L_Para_int_Set293:
;Spcsystem.c,1330 :: 		FromIntToStr(Para_int_temp,Info_Line2,SpcMenu[Menustat].decimal);
	MOVF        Para_int_Set_Para_int_temp_L0+0, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+0 
	MOVF        Para_int_Set_Para_int_temp_L0+1, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+1 
	MOVLW       0
	BTFSC       Para_int_Set_Para_int_temp_L0+1, 7 
	MOVLW       255
	MOVWF       FARG_FromIntToStr_ValueResoure+2 
	MOVWF       FARG_FromIntToStr_ValueResoure+3 
	MOVLW       _Info_Line2+0
	MOVWF       FARG_FromIntToStr_StringTarget+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_FromIntToStr_StringTarget+1 
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       17
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_FromIntToStr_offset+0
	CALL        _FromIntToStr+0, 0
L_Para_int_Set294:
L_Para_int_Set292:
L_Para_int_Set290:
;Spcsystem.c,1331 :: 		}
	GOTO        L_Para_int_Set295
L_Para_int_Set288:
;Spcsystem.c,1332 :: 		else if(cmd == CMD_ADJUST)    //left/right
	MOVF        FARG_Para_int_Set_cmd+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_Para_int_Set296
;Spcsystem.c,1334 :: 		if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
	BTFSC       _pSPCValue+139, 0 
	GOTO        L_Para_int_Set297
;Spcsystem.c,1335 :: 		return;
	GOTO        L_end_Para_int_Set
L_Para_int_Set297:
;Spcsystem.c,1337 :: 		Flashing_EN();
	CALL        _Flashing_EN+0, 0
;Spcsystem.c,1338 :: 		if(direct)
	MOVF        FARG_Para_int_Set_direct+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Para_int_Set298
;Spcsystem.c,1340 :: 		if(Para_int_temp == Para_int_max)
	MOVF        Para_int_Set_Para_int_temp_L0+1, 0 
	XORWF       Para_int_Set_Para_int_max_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Para_int_Set634
	MOVF        Para_int_Set_Para_int_max_L0+0, 0 
	XORWF       Para_int_Set_Para_int_temp_L0+0, 0 
L__Para_int_Set634:
	BTFSS       STATUS+0, 2 
	GOTO        L_Para_int_Set299
;Spcsystem.c,1342 :: 		if(SpcMenu[Menustat].NumVal == 1)
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       15
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
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Para_int_Set300
;Spcsystem.c,1344 :: 		Para_int_temp = SPC_SYSTEMVALUE_OFF;
	MOVLW       255
	MOVWF       Para_int_Set_Para_int_temp_L0+0 
	MOVLW       127
	MOVWF       Para_int_Set_Para_int_temp_L0+1 
;Spcsystem.c,1345 :: 		getParaChar(Info_Line2, OFF_STR);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       73
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,1346 :: 		}
	GOTO        L_Para_int_Set301
L_Para_int_Set300:
;Spcsystem.c,1347 :: 		else if(SpcMenu[Menustat].NumVal == 2)
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       15
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
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Para_int_Set302
;Spcsystem.c,1349 :: 		Para_int_temp = SPC_SYSTEMVALUE_DISABLE;
	MOVLW       252
	MOVWF       Para_int_Set_Para_int_temp_L0+0 
	MOVLW       127
	MOVWF       Para_int_Set_Para_int_temp_L0+1 
;Spcsystem.c,1350 :: 		getParaChar(Info_Line2, DISABLE_STR);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       77
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,1351 :: 		}
L_Para_int_Set302:
L_Para_int_Set301:
;Spcsystem.c,1352 :: 		}
	GOTO        L_Para_int_Set303
L_Para_int_Set299:
;Spcsystem.c,1353 :: 		else if(Para_int_temp == SPC_SYSTEMVALUE_DISABLE)
	MOVF        Para_int_Set_Para_int_temp_L0+1, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__Para_int_Set635
	MOVLW       252
	XORWF       Para_int_Set_Para_int_temp_L0+0, 0 
L__Para_int_Set635:
	BTFSS       STATUS+0, 2 
	GOTO        L_Para_int_Set304
;Spcsystem.c,1355 :: 		Para_int_temp = SPC_SYSTEMVALUE_CONTINU;
	MOVLW       253
	MOVWF       Para_int_Set_Para_int_temp_L0+0 
	MOVLW       127
	MOVWF       Para_int_Set_Para_int_temp_L0+1 
;Spcsystem.c,1356 :: 		getParaChar(Info_Line2, COUNTINU_STR);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       76
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,1357 :: 		}
	GOTO        L_Para_int_Set305
L_Para_int_Set304:
;Spcsystem.c,1358 :: 		else if(Para_int_temp < Para_int_max)
	MOVLW       128
	XORWF       Para_int_Set_Para_int_temp_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       Para_int_Set_Para_int_max_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Para_int_Set636
	MOVF        Para_int_Set_Para_int_max_L0+0, 0 
	SUBWF       Para_int_Set_Para_int_temp_L0+0, 0 
L__Para_int_Set636:
	BTFSC       STATUS+0, 0 
	GOTO        L_Para_int_Set306
;Spcsystem.c,1360 :: 		if(SpcMenu[Menustat].offset == INTSET_CURRENTLIMIT)
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
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
	MOVFF       TABLAT+0, R1
	MOVF        R1, 0 
	XORLW       28
	BTFSS       STATUS+0, 2 
	GOTO        L_Para_int_Set307
;Spcsystem.c,1361 :: 		Para_int_temp += KeyHoldStep*10;
	MOVF        _KeyHoldStep+0, 0 
	MOVWF       R0 
	MOVF        _KeyHoldStep+1, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	ADDWF       Para_int_Set_Para_int_temp_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      Para_int_Set_Para_int_temp_L0+1, 1 
	GOTO        L_Para_int_Set308
L_Para_int_Set307:
;Spcsystem.c,1363 :: 		Para_int_temp += KeyHoldStep;
	MOVF        _KeyHoldStep+0, 0 
	ADDWF       Para_int_Set_Para_int_temp_L0+0, 1 
	MOVF        _KeyHoldStep+1, 0 
	ADDWFC      Para_int_Set_Para_int_temp_L0+1, 1 
L_Para_int_Set308:
;Spcsystem.c,1364 :: 		if(Para_int_temp > Para_int_max) Para_int_temp = Para_int_max;
	MOVLW       128
	XORWF       Para_int_Set_Para_int_max_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       Para_int_Set_Para_int_temp_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Para_int_Set637
	MOVF        Para_int_Set_Para_int_temp_L0+0, 0 
	SUBWF       Para_int_Set_Para_int_max_L0+0, 0 
L__Para_int_Set637:
	BTFSC       STATUS+0, 0 
	GOTO        L_Para_int_Set309
	MOVF        Para_int_Set_Para_int_max_L0+0, 0 
	MOVWF       Para_int_Set_Para_int_temp_L0+0 
	MOVF        Para_int_Set_Para_int_max_L0+1, 0 
	MOVWF       Para_int_Set_Para_int_temp_L0+1 
L_Para_int_Set309:
;Spcsystem.c,1365 :: 		FromIntToStr(Para_int_temp,Info_Line2,SpcMenu[Menustat].decimal);
	MOVF        Para_int_Set_Para_int_temp_L0+0, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+0 
	MOVF        Para_int_Set_Para_int_temp_L0+1, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+1 
	MOVLW       0
	BTFSC       Para_int_Set_Para_int_temp_L0+1, 7 
	MOVLW       255
	MOVWF       FARG_FromIntToStr_ValueResoure+2 
	MOVWF       FARG_FromIntToStr_ValueResoure+3 
	MOVLW       _Info_Line2+0
	MOVWF       FARG_FromIntToStr_StringTarget+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_FromIntToStr_StringTarget+1 
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       17
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_FromIntToStr_offset+0
	CALL        _FromIntToStr+0, 0
;Spcsystem.c,1366 :: 		}
L_Para_int_Set306:
L_Para_int_Set305:
L_Para_int_Set303:
;Spcsystem.c,1367 :: 		}
	GOTO        L_Para_int_Set310
L_Para_int_Set298:
;Spcsystem.c,1370 :: 		if(Para_int_temp == SPC_SYSTEMVALUE_CONTINU)
	MOVF        Para_int_Set_Para_int_temp_L0+1, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__Para_int_Set638
	MOVLW       253
	XORWF       Para_int_Set_Para_int_temp_L0+0, 0 
L__Para_int_Set638:
	BTFSS       STATUS+0, 2 
	GOTO        L_Para_int_Set311
;Spcsystem.c,1372 :: 		if(SpcMenu[Menustat].NumVal == 2)
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       15
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
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Para_int_Set312
;Spcsystem.c,1374 :: 		Para_int_temp = SPC_SYSTEMVALUE_DISABLE;
	MOVLW       252
	MOVWF       Para_int_Set_Para_int_temp_L0+0 
	MOVLW       127
	MOVWF       Para_int_Set_Para_int_temp_L0+1 
;Spcsystem.c,1375 :: 		getParaChar(Info_Line2, DISABLE_STR);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       77
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,1376 :: 		}
	GOTO        L_Para_int_Set313
L_Para_int_Set312:
;Spcsystem.c,1379 :: 		Para_int_temp = SPC_SYSTEMVALUE_OFF;
	MOVLW       255
	MOVWF       Para_int_Set_Para_int_temp_L0+0 
	MOVLW       127
	MOVWF       Para_int_Set_Para_int_temp_L0+1 
;Spcsystem.c,1380 :: 		getParaChar(Info_Line2, OFF_STR);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       73
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,1381 :: 		}
L_Para_int_Set313:
;Spcsystem.c,1382 :: 		}
	GOTO        L_Para_int_Set314
L_Para_int_Set311:
;Spcsystem.c,1383 :: 		else if((Para_int_temp == SPC_SYSTEMVALUE_OFF) || (Para_int_temp == SPC_SYSTEMVALUE_DISABLE))
	MOVF        Para_int_Set_Para_int_temp_L0+1, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__Para_int_Set639
	MOVLW       255
	XORWF       Para_int_Set_Para_int_temp_L0+0, 0 
L__Para_int_Set639:
	BTFSC       STATUS+0, 2 
	GOTO        L__Para_int_Set537
	MOVF        Para_int_Set_Para_int_temp_L0+1, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__Para_int_Set640
	MOVLW       252
	XORWF       Para_int_Set_Para_int_temp_L0+0, 0 
L__Para_int_Set640:
	BTFSC       STATUS+0, 2 
	GOTO        L__Para_int_Set537
	GOTO        L_Para_int_Set317
L__Para_int_Set537:
;Spcsystem.c,1385 :: 		Para_int_temp = Para_int_max;
	MOVF        Para_int_Set_Para_int_max_L0+0, 0 
	MOVWF       Para_int_Set_Para_int_temp_L0+0 
	MOVF        Para_int_Set_Para_int_max_L0+1, 0 
	MOVWF       Para_int_Set_Para_int_temp_L0+1 
;Spcsystem.c,1386 :: 		FromIntToStr(Para_int_temp,Info_Line2,SpcMenu[Menustat].decimal);
	MOVF        Para_int_Set_Para_int_max_L0+0, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+0 
	MOVF        Para_int_Set_Para_int_max_L0+1, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+1 
	MOVLW       0
	BTFSC       Para_int_Set_Para_int_max_L0+1, 7 
	MOVLW       255
	MOVWF       FARG_FromIntToStr_ValueResoure+2 
	MOVWF       FARG_FromIntToStr_ValueResoure+3 
	MOVLW       _Info_Line2+0
	MOVWF       FARG_FromIntToStr_StringTarget+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_FromIntToStr_StringTarget+1 
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       17
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_FromIntToStr_offset+0
	CALL        _FromIntToStr+0, 0
;Spcsystem.c,1387 :: 		}
	GOTO        L_Para_int_Set318
L_Para_int_Set317:
;Spcsystem.c,1388 :: 		else if(Para_int_temp > Para_int_min)
	MOVLW       128
	XORWF       Para_int_Set_Para_int_min_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       Para_int_Set_Para_int_temp_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Para_int_Set641
	MOVF        Para_int_Set_Para_int_temp_L0+0, 0 
	SUBWF       Para_int_Set_Para_int_min_L0+0, 0 
L__Para_int_Set641:
	BTFSC       STATUS+0, 0 
	GOTO        L_Para_int_Set319
;Spcsystem.c,1390 :: 		if(SpcMenu[Menustat].offset == INTSET_CURRENTLIMIT)
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
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
	MOVFF       TABLAT+0, R1
	MOVF        R1, 0 
	XORLW       28
	BTFSS       STATUS+0, 2 
	GOTO        L_Para_int_Set320
;Spcsystem.c,1391 :: 		Para_int_temp -= KeyHoldStep*10;
	MOVF        _KeyHoldStep+0, 0 
	MOVWF       R0 
	MOVF        _KeyHoldStep+1, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	SUBWF       Para_int_Set_Para_int_temp_L0+0, 1 
	MOVF        R1, 0 
	SUBWFB      Para_int_Set_Para_int_temp_L0+1, 1 
	GOTO        L_Para_int_Set321
L_Para_int_Set320:
;Spcsystem.c,1393 :: 		Para_int_temp -= KeyHoldStep;
	MOVF        _KeyHoldStep+0, 0 
	SUBWF       Para_int_Set_Para_int_temp_L0+0, 1 
	MOVF        _KeyHoldStep+1, 0 
	SUBWFB      Para_int_Set_Para_int_temp_L0+1, 1 
L_Para_int_Set321:
;Spcsystem.c,1394 :: 		if(Para_int_temp < Para_int_min) Para_int_temp = Para_int_min;
	MOVLW       128
	XORWF       Para_int_Set_Para_int_temp_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       Para_int_Set_Para_int_min_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Para_int_Set642
	MOVF        Para_int_Set_Para_int_min_L0+0, 0 
	SUBWF       Para_int_Set_Para_int_temp_L0+0, 0 
L__Para_int_Set642:
	BTFSC       STATUS+0, 0 
	GOTO        L_Para_int_Set322
	MOVF        Para_int_Set_Para_int_min_L0+0, 0 
	MOVWF       Para_int_Set_Para_int_temp_L0+0 
	MOVF        Para_int_Set_Para_int_min_L0+1, 0 
	MOVWF       Para_int_Set_Para_int_temp_L0+1 
L_Para_int_Set322:
;Spcsystem.c,1395 :: 		FromIntToStr(Para_int_temp,Info_Line2,SpcMenu[Menustat].decimal);
	MOVF        Para_int_Set_Para_int_temp_L0+0, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+0 
	MOVF        Para_int_Set_Para_int_temp_L0+1, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+1 
	MOVLW       0
	BTFSC       Para_int_Set_Para_int_temp_L0+1, 7 
	MOVLW       255
	MOVWF       FARG_FromIntToStr_ValueResoure+2 
	MOVWF       FARG_FromIntToStr_ValueResoure+3 
	MOVLW       _Info_Line2+0
	MOVWF       FARG_FromIntToStr_StringTarget+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_FromIntToStr_StringTarget+1 
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       17
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_FromIntToStr_offset+0
	CALL        _FromIntToStr+0, 0
;Spcsystem.c,1396 :: 		}
L_Para_int_Set319:
L_Para_int_Set318:
L_Para_int_Set314:
;Spcsystem.c,1397 :: 		}
L_Para_int_Set310:
;Spcsystem.c,1398 :: 		}
L_Para_int_Set296:
L_Para_int_Set295:
L_Para_int_Set287:
;Spcsystem.c,1400 :: 		if(IndicatorEN)
	MOVF        Para_int_Set_IndicatorEN_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Para_int_Set323
;Spcsystem.c,1402 :: 		Info_Line2[14] = 'P';
	MOVLW       80
	MOVWF       _Info_Line2+14 
;Spcsystem.c,1403 :: 		Info_Line2[15] = Cable_Channel+0X31;
	MOVLW       49
	ADDWF       _Cable_Channel+0, 0 
	MOVWF       _Info_Line2+15 
;Spcsystem.c,1404 :: 		}
L_Para_int_Set323:
;Spcsystem.c,1405 :: 		}
L_end_Para_int_Set:
	RETURN      0
; end of _Para_int_Set

_Para_show:

;Spcsystem.c,1412 :: 		void Para_show(UCHAR direct, UCHAR cmd)
;Spcsystem.c,1418 :: 		char IndicatorEN=0;
	CLRF        Para_show_IndicatorEN_L0+0 
;Spcsystem.c,1420 :: 		switch(Menustat)
	GOTO        L_Para_show324
;Spcsystem.c,1422 :: 		case 8:      //volt
L_Para_show326:
;Spcsystem.c,1423 :: 		case 14:     //max volt
L_Para_show327:
;Spcsystem.c,1424 :: 		case 15:     //min volt
L_Para_show328:
;Spcsystem.c,1425 :: 		ChannelTemp = 0;
	CLRF        Para_show_ChannelTemp_L0+0 
;Spcsystem.c,1426 :: 		break;
	GOTO        L_Para_show325
;Spcsystem.c,1427 :: 		default:
L_Para_show329:
;Spcsystem.c,1428 :: 		ChannelTemp = Cable_Channel;
	MOVF        _Cable_Channel+0, 0 
	MOVWF       Para_show_ChannelTemp_L0+0 
;Spcsystem.c,1429 :: 		IndicatorEN = 1;
	MOVLW       1
	MOVWF       Para_show_IndicatorEN_L0+0 
;Spcsystem.c,1430 :: 		break;
	GOTO        L_Para_show325
;Spcsystem.c,1431 :: 		}
L_Para_show324:
	MOVF        _Menustat+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_Para_show326
	MOVF        _Menustat+0, 0 
	XORLW       14
	BTFSC       STATUS+0, 2 
	GOTO        L_Para_show327
	MOVF        _Menustat+0, 0 
	XORLW       15
	BTFSC       STATUS+0, 2 
	GOTO        L_Para_show328
	GOTO        L_Para_show329
L_Para_show325:
;Spcsystem.c,1434 :: 		if((Menustat < 10) || (Menustat > 15))
	MOVLW       10
	SUBWF       _Menustat+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L__Para_show538
	MOVF        _Menustat+0, 0 
	SUBLW       15
	BTFSS       STATUS+0, 0 
	GOTO        L__Para_show538
	GOTO        L_Para_show332
L__Para_show538:
;Spcsystem.c,1436 :: 		ResetStatus = 0;
	CLRF        Para_show_ResetStatus_L0+0 
;Spcsystem.c,1437 :: 		locat = SpcMenu[Menustat].offset+ChannelTemp;
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
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
	MOVF        Para_show_ChannelTemp_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       Para_show_locat_L0+0 
;Spcsystem.c,1438 :: 		CopyStr(Actural_disp_str[locat],Info_Line2,16);
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        Para_show_locat_L0+0, 0 
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
;Spcsystem.c,1439 :: 		if(IndicatorEN)
	MOVF        Para_show_IndicatorEN_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Para_show333
;Spcsystem.c,1441 :: 		Info_Line2[14] = 'P';
	MOVLW       80
	MOVWF       _Info_Line2+14 
;Spcsystem.c,1442 :: 		Info_Line2[15] = Cable_Channel+0X31;
	MOVLW       49
	ADDWF       _Cable_Channel+0, 0 
	MOVWF       _Info_Line2+15 
;Spcsystem.c,1443 :: 		}
L_Para_show333:
;Spcsystem.c,1444 :: 		return;
	GOTO        L_end_Para_show
;Spcsystem.c,1445 :: 		}
L_Para_show332:
;Spcsystem.c,1448 :: 		if(cmd == CMD_RESET)
	MOVF        FARG_Para_show_cmd+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Para_show335
;Spcsystem.c,1450 :: 		ResetStatus = 0;
	CLRF        Para_show_ResetStatus_L0+0 
;Spcsystem.c,1451 :: 		ResetParaCmd = 0;
	CLRF        Para_show_ResetParaCmd_L0+0 
;Spcsystem.c,1452 :: 		locat = SpcMenu[Menustat].offset+ChannelTemp;
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
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
	MOVF        Para_show_ChannelTemp_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       Para_show_locat_L0+0 
;Spcsystem.c,1453 :: 		CopyStr(Actural_disp_str[locat],Info_Line2,16);
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        Para_show_locat_L0+0, 0 
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
;Spcsystem.c,1454 :: 		}
	GOTO        L_Para_show336
L_Para_show335:
;Spcsystem.c,1457 :: 		switch(ResetStatus)
	GOTO        L_Para_show337
;Spcsystem.c,1459 :: 		case 0:
L_Para_show339:
;Spcsystem.c,1460 :: 		if(cmd == CMD_ENTER)
	MOVF        FARG_Para_show_cmd+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Para_show340
;Spcsystem.c,1462 :: 		ResetStatus++;
	INCF        Para_show_ResetStatus_L0+0, 1 
;Spcsystem.c,1463 :: 		CopyStr(Info_Line1,Info_Line1_shape,16);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_CopyStr_resource+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_CopyStr_resource+1 
	MOVLW       _Info_Line1_shape+0
	MOVWF       FARG_CopyStr_target+0 
	MOVLW       hi_addr(_Info_Line1_shape+0)
	MOVWF       FARG_CopyStr_target+1 
	MOVLW       16
	MOVWF       FARG_CopyStr_len+0 
	CALL        _CopyStr+0, 0
;Spcsystem.c,1464 :: 		getParaChar(Info_Line1, CONFIRM_CHANGE_STR);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       84
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,1465 :: 		getParaChar(Info_Line2, NO_STR);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       4
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,1466 :: 		}
L_Para_show340:
;Spcsystem.c,1467 :: 		break;
	GOTO        L_Para_show338
;Spcsystem.c,1468 :: 		case 1:
L_Para_show341:
;Spcsystem.c,1469 :: 		if(cmd == CMD_ENTER)
	MOVF        FARG_Para_show_cmd+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Para_show342
;Spcsystem.c,1471 :: 		if(ResetParaCmd)
	MOVF        Para_show_ResetParaCmd_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Para_show343
;Spcsystem.c,1473 :: 		asm nop;
	NOP
;Spcsystem.c,1474 :: 		ResetLocate = ResetCmd[Menustat-10] & 0xff;
	MOVLW       10
	SUBWF       _Menustat+0, 0 
	MOVWF       R5 
	CLRF        R6 
	MOVLW       0
	SUBWFB      R6, 1 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       R6, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	MOVLW       Spcsystem_ResetCmd+0
	ADDWF       R0, 0 
	MOVWF       R4 
	MOVLW       hi_addr(Spcsystem_ResetCmd+0)
	ADDWFC      R1, 0 
	MOVWF       R5 
	MOVLW       higher_addr(Spcsystem_ResetCmd+0)
	ADDWFC      R2, 0 
	MOVWF       R6 
	MOVF        R4, 0 
	MOVWF       TBLPTRL 
	MOVF        R5, 0 
	MOVWF       TBLPTRH 
	MOVF        R6, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVLW       255
	ANDWF       R0, 0 
	MOVWF       Para_show_ResetLocate_L0+0 
;Spcsystem.c,1475 :: 		StringLocate = (ResetCmd[Menustat-10]>>8) & 0xff;
	MOVF        R4, 0 
	MOVWF       TBLPTRL 
	MOVF        R5, 0 
	MOVWF       TBLPTRH 
	MOVF        R6, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R3
	TBLRD*+
	MOVFF       TABLAT+0, R4
	MOVF        R4, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       255
	ANDWF       R0, 0 
	MOVWF       Para_show_StringLocate_L0+0 
;Spcsystem.c,1476 :: 		Statis_flag[ChannelTemp] |= ResetLocate;
	MOVLW       _Statis_flag+0
	MOVWF       R1 
	MOVLW       hi_addr(_Statis_flag+0)
	MOVWF       R2 
	MOVF        Para_show_ChannelTemp_L0+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVF        Para_show_ResetLocate_L0+0, 0 
	IORWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,1477 :: 		ClearStr(Actural_disp_str[StringLocate], 16);
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        Para_show_StringLocate_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Actural_disp_str+0
	ADDWF       R0, 0 
	MOVWF       FARG_ClearStr_target+0 
	MOVLW       hi_addr(_Actural_disp_str+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_ClearStr_target+1 
	MOVLW       16
	MOVWF       FARG_ClearStr_len+0 
	MOVLW       0
	MOVWF       FARG_ClearStr_len+1 
	CALL        _ClearStr+0, 0
;Spcsystem.c,1478 :: 		getParaChar(Info_Line1, CHANGE_COMPLETE_STR);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       85
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,1479 :: 		ClearStr(Info_Line2,16);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_ClearStr_target+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_ClearStr_target+1 
	MOVLW       16
	MOVWF       FARG_ClearStr_len+0 
	MOVLW       0
	MOVWF       FARG_ClearStr_len+1 
	CALL        _ClearStr+0, 0
;Spcsystem.c,1480 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
;Spcsystem.c,1481 :: 		Delay_ms(1000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_Para_show344:
	DECFSZ      R13, 1, 1
	BRA         L_Para_show344
	DECFSZ      R12, 1, 1
	BRA         L_Para_show344
	DECFSZ      R11, 1, 1
	BRA         L_Para_show344
	NOP
;Spcsystem.c,1482 :: 		CopyStr(Info_Line1_shape,Info_Line1,16);
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
;Spcsystem.c,1483 :: 		CopyStr(Actural_disp_str[StringLocate],Info_Line2,16);
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        Para_show_StringLocate_L0+0, 0 
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
;Spcsystem.c,1485 :: 		ResetStatus = 0;
	CLRF        Para_show_ResetStatus_L0+0 
;Spcsystem.c,1486 :: 		ResetParaCmd = 0;
	CLRF        Para_show_ResetParaCmd_L0+0 
;Spcsystem.c,1487 :: 		}
	GOTO        L_Para_show345
L_Para_show343:
;Spcsystem.c,1490 :: 		ResetStatus = 0;
	CLRF        Para_show_ResetStatus_L0+0 
;Spcsystem.c,1491 :: 		ResetParaCmd = 0;
	CLRF        Para_show_ResetParaCmd_L0+0 
;Spcsystem.c,1492 :: 		locat = SpcMenu[Menustat].offset;
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
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
	MOVFF       TABLAT+0, Para_show_locat_L0+0
;Spcsystem.c,1493 :: 		CopyStr(Actural_disp_str[locat],Info_Line2,16);
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        Para_show_locat_L0+0, 0 
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
;Spcsystem.c,1494 :: 		}
L_Para_show345:
;Spcsystem.c,1495 :: 		}
	GOTO        L_Para_show346
L_Para_show342:
;Spcsystem.c,1496 :: 		else if(cmd == CMD_ADJUST)
	MOVF        FARG_Para_show_cmd+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_Para_show347
;Spcsystem.c,1498 :: 		ResetParaCmd ^= 1;
	BTG         Para_show_ResetParaCmd_L0+0, 0 
;Spcsystem.c,1499 :: 		getParaChar(Info_Line1, CONFIRM_CHANGE_STR);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       84
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,1500 :: 		if(ResetParaCmd)
	MOVF        Para_show_ResetParaCmd_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Para_show348
;Spcsystem.c,1501 :: 		getParaChar(Info_Line2, YES_STR);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       5
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
	GOTO        L_Para_show349
L_Para_show348:
;Spcsystem.c,1503 :: 		getParaChar(Info_Line2, NO_STR);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       4
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
L_Para_show349:
;Spcsystem.c,1504 :: 		}
	GOTO        L_Para_show350
L_Para_show347:
;Spcsystem.c,1505 :: 		else if(cmd == KEY_VALUE_RESET)
	MOVF        FARG_Para_show_cmd+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Para_show351
;Spcsystem.c,1507 :: 		ResetStatus = 0;
	CLRF        Para_show_ResetStatus_L0+0 
;Spcsystem.c,1508 :: 		ResetParaCmd = 0;
	CLRF        Para_show_ResetParaCmd_L0+0 
;Spcsystem.c,1509 :: 		locat = SpcMenu[Menustat].offset;
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
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
	MOVFF       TABLAT+0, Para_show_locat_L0+0
;Spcsystem.c,1510 :: 		CopyStr(Actural_disp_str[locat],Info_Line2,16);
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        Para_show_locat_L0+0, 0 
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
;Spcsystem.c,1511 :: 		}
L_Para_show351:
L_Para_show350:
L_Para_show346:
;Spcsystem.c,1512 :: 		break;
	GOTO        L_Para_show338
;Spcsystem.c,1513 :: 		}
L_Para_show337:
	MOVF        Para_show_ResetStatus_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_Para_show339
	MOVF        Para_show_ResetStatus_L0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_Para_show341
L_Para_show338:
;Spcsystem.c,1514 :: 		}
L_Para_show336:
;Spcsystem.c,1517 :: 		if(IndicatorEN)
	MOVF        Para_show_IndicatorEN_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Para_show352
;Spcsystem.c,1519 :: 		Info_Line2[14] = 'P';
	MOVLW       80
	MOVWF       _Info_Line2+14 
;Spcsystem.c,1520 :: 		Info_Line2[15] = Cable_Channel+0X31;
	MOVLW       49
	ADDWF       _Cable_Channel+0, 0 
	MOVWF       _Info_Line2+15 
;Spcsystem.c,1521 :: 		}
L_Para_show352:
;Spcsystem.c,1522 :: 		}
L_end_Para_show:
	RETURN      0
; end of _Para_show

_DisablePSWInputing:

;Spcsystem.c,1529 :: 		void DisablePSWInputing()
;Spcsystem.c,1531 :: 		Usr_Psw_en = 0;
	CLRF        _Usr_Psw_en+0 
;Spcsystem.c,1532 :: 		}
L_end_DisablePSWInputing:
	RETURN      0
; end of _DisablePSWInputing

_Authority_Set:

;Spcsystem.c,1534 :: 		void Authority_Set(UCHAR direct, UCHAR cmd)
;Spcsystem.c,1538 :: 		if(cmd == CMD_ENTER) //enter
	MOVF        FARG_Authority_Set_cmd+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Authority_Set353
;Spcsystem.c,1540 :: 		if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en)
	BTFSS       _pSPCValue+139, 0 
	GOTO        L_Authority_Set354
;Spcsystem.c,1542 :: 		pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en = 0;
	BCF         _pSPCValue+139, 0 
;Spcsystem.c,1543 :: 		getParaChar(Info_Line2, EN_DIS_STR);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       13
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,1545 :: 		Savedata(SYSTEMFLAG_FLASH_LACAL,
	MOVLW       84
	MOVWF       FARG_Savedata_flash_lacl+0 
	MOVLW       0
	MOVWF       FARG_Savedata_flash_lacl+1 
;Spcsystem.c,1546 :: 		sizeof(SYSTEM_VALUEB),
	MOVLW       4
	MOVWF       FARG_Savedata_len+0 
	MOVLW       0
	MOVWF       FARG_Savedata_len+1 
;Spcsystem.c,1547 :: 		(UCHAR *)(&pSPCValue[0].SPCSetPoints.system_valueb),
	MOVLW       _pSPCValue+138
	MOVWF       FARG_Savedata_ptr+0 
	MOVLW       hi_addr(_pSPCValue+138)
	MOVWF       FARG_Savedata_ptr+1 
;Spcsystem.c,1548 :: 		0);
	CLRF        FARG_Savedata_cmd+0 
	CALL        _Savedata+0, 0
;Spcsystem.c,1549 :: 		}
	GOTO        L_Authority_Set355
L_Authority_Set354:
;Spcsystem.c,1552 :: 		if(Usr_Psw_en == 0)
	MOVF        _Usr_Psw_en+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Authority_Set356
;Spcsystem.c,1554 :: 		Usr_Psw_en = 1;
	MOVLW       1
	MOVWF       _Usr_Psw_en+0 
;Spcsystem.c,1555 :: 		spc_system_flag.bite.char_actived = 1;
	BSF         _spc_system_flag+1, 3 
;Spcsystem.c,1556 :: 		SetP_shade.CharacNum = 0;
	CLRF        _SetP_shade+82 
;Spcsystem.c,1557 :: 		SetP_shade.StringNum = 0;
	CLRF        _SetP_shade+83 
;Spcsystem.c,1558 :: 		ClearStr(Info_Line2, 16);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_ClearStr_target+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_ClearStr_target+1 
	MOVLW       16
	MOVWF       FARG_ClearStr_len+0 
	MOVLW       0
	MOVWF       FARG_ClearStr_len+1 
	CALL        _ClearStr+0, 0
;Spcsystem.c,1559 :: 		getParaChar(Info_Line1, ENTER_PSW_STR);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       79
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,1561 :: 		spc_system_flag.bite.char_flash = 1;
	BSF         _spc_system_flag+3, 6 
;Spcsystem.c,1562 :: 		char_flash_loca = 1;
	MOVLW       1
	MOVWF       _char_flash_loca+0 
;Spcsystem.c,1563 :: 		}
	GOTO        L_Authority_Set357
L_Authority_Set356:
;Spcsystem.c,1566 :: 		Usr_Psw_en = 0;
	CLRF        _Usr_Psw_en+0 
;Spcsystem.c,1567 :: 		if(StrCompar(SetP_shade.Password, pSPCValue[0].SPCSetPoints.Password))
	MOVLW       _SetP_shade+66
	MOVWF       FARG_StrCompar_resoure+0 
	MOVLW       hi_addr(_SetP_shade+66)
	MOVWF       FARG_StrCompar_resoure+1 
	MOVLW       _pSPCValue+120
	MOVWF       FARG_StrCompar_target+0 
	MOVLW       hi_addr(_pSPCValue+120)
	MOVWF       FARG_StrCompar_target+1 
	CALL        _StrCompar+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Authority_Set358
;Spcsystem.c,1569 :: 		pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en = 1;
	BSF         _pSPCValue+139, 0 
;Spcsystem.c,1570 :: 		ClearStr(Info_Line2, 16);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_ClearStr_target+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_ClearStr_target+1 
	MOVLW       16
	MOVWF       FARG_ClearStr_len+0 
	MOVLW       0
	MOVWF       FARG_ClearStr_len+1 
	CALL        _ClearStr+0, 0
;Spcsystem.c,1571 :: 		getParaChar(Info_Line1, STORE_STR);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       83
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,1572 :: 		Usr_mode_shape = pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en;
	MOVLW       0
	BTFSC       _pSPCValue+139, 0 
	MOVLW       1
	MOVWF       Authority_Set_Usr_mode_shape_L0+0 
;Spcsystem.c,1573 :: 		getParaChar(Info_Line2_shape, EN_DIS_STR+Usr_mode_shape);
	MOVLW       _Info_Line2_shape+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2_shape+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVF        Authority_Set_Usr_mode_shape_L0+0, 0 
	ADDLW       13
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,1575 :: 		Savedata(SYSTEMFLAG_FLASH_LACAL,
	MOVLW       84
	MOVWF       FARG_Savedata_flash_lacl+0 
	MOVLW       0
	MOVWF       FARG_Savedata_flash_lacl+1 
;Spcsystem.c,1576 :: 		sizeof(SYSTEM_VALUEB),
	MOVLW       4
	MOVWF       FARG_Savedata_len+0 
	MOVLW       0
	MOVWF       FARG_Savedata_len+1 
;Spcsystem.c,1577 :: 		(UCHAR *)(&pSPCValue[0].SPCSetPoints.system_valueb),
	MOVLW       _pSPCValue+138
	MOVWF       FARG_Savedata_ptr+0 
	MOVLW       hi_addr(_pSPCValue+138)
	MOVWF       FARG_Savedata_ptr+1 
;Spcsystem.c,1578 :: 		0);
	CLRF        FARG_Savedata_cmd+0 
	CALL        _Savedata+0, 0
;Spcsystem.c,1579 :: 		}
	GOTO        L_Authority_Set359
L_Authority_Set358:
;Spcsystem.c,1582 :: 		ClearStr(Info_Line2, 16);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_ClearStr_target+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_ClearStr_target+1 
	MOVLW       16
	MOVWF       FARG_ClearStr_len+0 
	MOVLW       0
	MOVWF       FARG_ClearStr_len+1 
	CALL        _ClearStr+0, 0
;Spcsystem.c,1583 :: 		getParaChar(Info_Line1, RESET_FAILT_PSW_STR);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       82
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,1584 :: 		}
L_Authority_Set359:
;Spcsystem.c,1585 :: 		LCDext = 1;
	MOVLW       1
	MOVWF       _LCDext+0 
;Spcsystem.c,1586 :: 		spc_system_flag.bite.char_actived = 0;
	BCF         _spc_system_flag+1, 3 
;Spcsystem.c,1587 :: 		spc_system_flag.bite.char_flash = 0;
	BCF         _spc_system_flag+3, 6 
;Spcsystem.c,1588 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Spcsystem.c,1589 :: 		}
L_Authority_Set357:
;Spcsystem.c,1590 :: 		}
L_Authority_Set355:
;Spcsystem.c,1591 :: 		}
	GOTO        L_Authority_Set360
L_Authority_Set353:
;Spcsystem.c,1592 :: 		else if(cmd == CMD_RESET)     //reset
	MOVF        FARG_Authority_Set_cmd+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Authority_Set361
;Spcsystem.c,1594 :: 		if(spc_system_flag.bite.char_flash == 0)
	BTFSC       _spc_system_flag+3, 6 
	GOTO        L_Authority_Set362
;Spcsystem.c,1595 :: 		Usr_Psw_en = 0;
	CLRF        _Usr_Psw_en+0 
L_Authority_Set362:
;Spcsystem.c,1597 :: 		if(Usr_Psw_en == 0)
	MOVF        _Usr_Psw_en+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Authority_Set363
;Spcsystem.c,1599 :: 		Usr_mode_shape = pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en;
	MOVLW       0
	BTFSC       _pSPCValue+139, 0 
	MOVLW       1
	MOVWF       Authority_Set_Usr_mode_shape_L0+0 
;Spcsystem.c,1600 :: 		getParaChar(Info_Line2, EN_DIS_STR+Usr_mode_shape);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVF        Authority_Set_Usr_mode_shape_L0+0, 0 
	ADDLW       13
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,1602 :: 		CopyStr(Info_Line1, Info_Line1_shape, 16);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_CopyStr_resource+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_CopyStr_resource+1 
	MOVLW       _Info_Line1_shape+0
	MOVWF       FARG_CopyStr_target+0 
	MOVLW       hi_addr(_Info_Line1_shape+0)
	MOVWF       FARG_CopyStr_target+1 
	MOVLW       16
	MOVWF       FARG_CopyStr_len+0 
	CALL        _CopyStr+0, 0
;Spcsystem.c,1603 :: 		CopyStr(Info_Line2, Info_Line2_shape, 16);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_CopyStr_resource+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_CopyStr_resource+1 
	MOVLW       _Info_Line2_shape+0
	MOVWF       FARG_CopyStr_target+0 
	MOVLW       hi_addr(_Info_Line2_shape+0)
	MOVWF       FARG_CopyStr_target+1 
	MOVLW       16
	MOVWF       FARG_CopyStr_len+0 
	CALL        _CopyStr+0, 0
;Spcsystem.c,1604 :: 		}
	GOTO        L_Authority_Set364
L_Authority_Set363:
;Spcsystem.c,1607 :: 		ClearStr(Info_Line2, 16);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_ClearStr_target+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_ClearStr_target+1 
	MOVLW       16
	MOVWF       FARG_ClearStr_len+0 
	MOVLW       0
	MOVWF       FARG_ClearStr_len+1 
	CALL        _ClearStr+0, 0
;Spcsystem.c,1608 :: 		getParaChar(Info_Line1, ENTER_PSW_STR);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       79
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,1609 :: 		SetP_shade.CharacNum = 0;
	CLRF        _SetP_shade+82 
;Spcsystem.c,1610 :: 		SetP_shade.StringNum = 0;
	CLRF        _SetP_shade+83 
;Spcsystem.c,1611 :: 		char_flash_loca = 1;
	MOVLW       1
	MOVWF       _char_flash_loca+0 
;Spcsystem.c,1612 :: 		}
L_Authority_Set364:
;Spcsystem.c,1613 :: 		ClearStr(SetP_shade.Password, 16);
	MOVLW       _SetP_shade+66
	MOVWF       FARG_ClearStr_target+0 
	MOVLW       hi_addr(_SetP_shade+66)
	MOVWF       FARG_ClearStr_target+1 
	MOVLW       16
	MOVWF       FARG_ClearStr_len+0 
	MOVLW       0
	MOVWF       FARG_ClearStr_len+1 
	CALL        _ClearStr+0, 0
;Spcsystem.c,1614 :: 		}
	GOTO        L_Authority_Set365
L_Authority_Set361:
;Spcsystem.c,1615 :: 		else if(cmd == CMD_ADJUST)    //left/right
	MOVF        FARG_Authority_Set_cmd+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_Authority_Set366
;Spcsystem.c,1617 :: 		if(Usr_Psw_en)
	MOVF        _Usr_Psw_en+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Authority_Set367
;Spcsystem.c,1619 :: 		if((direct == 1) && (SetP_shade.StringNum < PSW_CHARACT_NUM))
	MOVF        FARG_Authority_Set_direct+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Authority_Set370
	MOVLW       63
	SUBWF       _SetP_shade+83, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Authority_Set370
L__Authority_Set541:
;Spcsystem.c,1620 :: 		SetP_shade.Password[SetP_shade.CharacNum] = SpcCharactors[++SetP_shade.StringNum];
	MOVLW       _SetP_shade+66
	MOVWF       FSR1 
	MOVLW       hi_addr(_SetP_shade+66)
	MOVWF       FSR1H 
	MOVF        _SetP_shade+82, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVF        _SetP_shade+83, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _SetP_shade+83 
	MOVLW       Spcsystem_SpcCharactors+0
	ADDWF       _SetP_shade+83, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(Spcsystem_SpcCharactors+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(Spcsystem_SpcCharactors+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	GOTO        L_Authority_Set371
L_Authority_Set370:
;Spcsystem.c,1621 :: 		else if((direct == 0) && (SetP_shade.StringNum > 0))
	MOVF        FARG_Authority_Set_direct+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Authority_Set374
	MOVF        _SetP_shade+83, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Authority_Set374
L__Authority_Set540:
;Spcsystem.c,1622 :: 		SetP_shade.Password[SetP_shade.CharacNum] = SpcCharactors[--SetP_shade.StringNum];
	MOVLW       _SetP_shade+66
	MOVWF       FSR1 
	MOVLW       hi_addr(_SetP_shade+66)
	MOVWF       FSR1H 
	MOVF        _SetP_shade+82, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	DECF        _SetP_shade+83, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _SetP_shade+83 
	MOVLW       Spcsystem_SpcCharactors+0
	ADDWF       _SetP_shade+83, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(Spcsystem_SpcCharactors+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(Spcsystem_SpcCharactors+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
L_Authority_Set374:
L_Authority_Set371:
;Spcsystem.c,1624 :: 		Info_Line2[SetP_shade.CharacNum] = SetP_shade.Password[SetP_shade.CharacNum];
	MOVLW       _Info_Line2+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FSR1H 
	MOVF        _SetP_shade+82, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       _SetP_shade+66
	MOVWF       FSR0 
	MOVLW       hi_addr(_SetP_shade+66)
	MOVWF       FSR0H 
	MOVF        _SetP_shade+82, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,1625 :: 		getParaChar(Info_Line1, ENTER_PSW_STR);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       79
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,1626 :: 		}
L_Authority_Set367:
;Spcsystem.c,1627 :: 		}
	GOTO        L_Authority_Set375
L_Authority_Set366:
;Spcsystem.c,1628 :: 		else if(cmd == CMD_SWITCH)
	MOVF        FARG_Authority_Set_cmd+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_Authority_Set376
;Spcsystem.c,1630 :: 		getParaChar(Info_Line1, ENTER_PSW_STR);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       79
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,1631 :: 		Info_Line2[SetP_shade.CharacNum] = '*';
	MOVLW       _Info_Line2+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FSR1H 
	MOVF        _SetP_shade+82, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       42
	MOVWF       POSTINC1+0 
;Spcsystem.c,1632 :: 		if((direct == 1) && (SetP_shade.CharacNum < 16) &&
	MOVF        FARG_Authority_Set_direct+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Authority_Set379
	MOVLW       16
	SUBWF       _SetP_shade+82, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Authority_Set379
;Spcsystem.c,1633 :: 		(SetP_shade.Password[SetP_shade.CharacNum] != ' '))
	MOVLW       _SetP_shade+66
	MOVWF       FSR0 
	MOVLW       hi_addr(_SetP_shade+66)
	MOVWF       FSR0H 
	MOVF        _SetP_shade+82, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       32
	BTFSC       STATUS+0, 2 
	GOTO        L_Authority_Set379
L__Authority_Set539:
;Spcsystem.c,1634 :: 		SetP_shade.CharacNum++;
	MOVF        _SetP_shade+82, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _SetP_shade+82 
L_Authority_Set379:
;Spcsystem.c,1635 :: 		SetP_shade.StringNum = 0;
	CLRF        _SetP_shade+83 
;Spcsystem.c,1636 :: 		char_flash_loca = SetP_shade.CharacNum+1;
	MOVF        _SetP_shade+82, 0 
	ADDLW       1
	MOVWF       _char_flash_loca+0 
;Spcsystem.c,1637 :: 		}
L_Authority_Set376:
L_Authority_Set375:
L_Authority_Set365:
L_Authority_Set360:
;Spcsystem.c,1638 :: 		}
L_end_Authority_Set:
	RETURN      0
; end of _Authority_Set

_Version_show:

;Spcsystem.c,1645 :: 		void Version_show(UCHAR direct, UCHAR cmd)
;Spcsystem.c,1649 :: 		for(i=0; i<16; i++) Info_Line1[i] = Version_title[i];
	CLRF        R1 
L_Version_show380:
	MOVLW       16
	SUBWF       R1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Version_show381
	MOVLW       _Info_Line1+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FSR1H 
	MOVF        R1, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       Spcsystem_Version_title+0
	ADDWF       R1, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(Spcsystem_Version_title+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(Spcsystem_Version_title+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        R1, 1 
	GOTO        L_Version_show380
L_Version_show381:
;Spcsystem.c,1650 :: 		for(i=0; i<16; i++) Info_Line2[i] = Version_content[i];
	CLRF        R1 
L_Version_show383:
	MOVLW       16
	SUBWF       R1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Version_show384
	MOVLW       _Info_Line2+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FSR1H 
	MOVF        R1, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       Spcsystem_Version_content+0
	ADDWF       R1, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(Spcsystem_Version_content+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(Spcsystem_Version_content+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        R1, 1 
	GOTO        L_Version_show383
L_Version_show384:
;Spcsystem.c,1651 :: 		}
L_end_Version_show:
	RETURN      0
; end of _Version_show

_FromIntToStr:

;Spcsystem.c,1658 :: 		void FromIntToStr(long ValueResoure, char *StringTarget, signed char decimal)
;Spcsystem.c,1660 :: 		char sourcecont=0 ,targetcont=0,unitcont, i, flag=0, decimal_flag = 0;
	CLRF        FromIntToStr_sourcecont_L0+0 
	CLRF        FromIntToStr_targetcont_L0+0 
	CLRF        FromIntToStr_flag_L0+0 
	CLRF        FromIntToStr_decimal_flag_L0+0 
;Spcsystem.c,1662 :: 		ClearStr(StringTarget, 16);
	MOVF        FARG_FromIntToStr_StringTarget+0, 0 
	MOVWF       FARG_ClearStr_target+0 
	MOVF        FARG_FromIntToStr_StringTarget+1, 0 
	MOVWF       FARG_ClearStr_target+1 
	MOVLW       16
	MOVWF       FARG_ClearStr_len+0 
	MOVLW       0
	MOVWF       FARG_ClearStr_len+1 
	CALL        _ClearStr+0, 0
;Spcsystem.c,1663 :: 		unitcont = SpcMenu[Menustat].Unit;
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
	MOVLW       Spcsystem_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       16
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
	MOVWF       FromIntToStr_unitcont_L0+0 
;Spcsystem.c,1665 :: 		if(unitcont & 0x80)
	BTFSS       R1, 7 
	GOTO        L_FromIntToStr386
;Spcsystem.c,1666 :: 		*(StringTarget++) = SPCUnit[unitcont&0x7f][0];
	MOVLW       127
	ANDWF       FromIntToStr_unitcont_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVLW       9
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       Spcsystem_SPCUnit+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(Spcsystem_SPCUnit+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(Spcsystem_SPCUnit+0)
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVFF       FARG_FromIntToStr_StringTarget+0, FSR1
	MOVFF       FARG_FromIntToStr_StringTarget+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      FARG_FromIntToStr_StringTarget+0, 1 
	INCF        FARG_FromIntToStr_StringTarget+1, 1 
L_FromIntToStr386:
;Spcsystem.c,1668 :: 		if(ValueResoure < 0)
	MOVLW       128
	XORWF       FARG_FromIntToStr_ValueResoure+3, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FromIntToStr648
	MOVLW       0
	SUBWF       FARG_FromIntToStr_ValueResoure+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FromIntToStr648
	MOVLW       0
	SUBWF       FARG_FromIntToStr_ValueResoure+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FromIntToStr648
	MOVLW       0
	SUBWF       FARG_FromIntToStr_ValueResoure+0, 0 
L__FromIntToStr648:
	BTFSC       STATUS+0, 0 
	GOTO        L_FromIntToStr387
;Spcsystem.c,1669 :: 		*(StringTarget++) = '-';
	MOVFF       FARG_FromIntToStr_StringTarget+0, FSR1
	MOVFF       FARG_FromIntToStr_StringTarget+1, FSR1H
	MOVLW       45
	MOVWF       POSTINC1+0 
	INFSNZ      FARG_FromIntToStr_StringTarget+0, 1 
	INCF        FARG_FromIntToStr_StringTarget+1, 1 
L_FromIntToStr387:
;Spcsystem.c,1670 :: 		ValueResoure = abs(ValueResoure);
	MOVF        FARG_FromIntToStr_ValueResoure+0, 0 
	MOVWF       FARG_abs_a+0 
	MOVF        FARG_FromIntToStr_ValueResoure+1, 0 
	MOVWF       FARG_abs_a+1 
	CALL        _abs+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+0 
	MOVF        R1, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+1 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	MOVWF       FARG_FromIntToStr_ValueResoure+2 
	MOVWF       FARG_FromIntToStr_ValueResoure+3 
;Spcsystem.c,1672 :: 		for(i=0; i<8; i++)
	CLRF        FromIntToStr_i_L0+0 
L_FromIntToStr388:
	MOVLW       8
	SUBWF       FromIntToStr_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_FromIntToStr389
;Spcsystem.c,1674 :: 		if(flag)
	MOVF        FromIntToStr_flag_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_FromIntToStr391
;Spcsystem.c,1675 :: 		*(StringTarget++) = ValueResoure/Chr_str[i] + 0x30;
	MOVF        FromIntToStr_i_L0+0, 0 
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
	MOVLW       Spcsystem_Chr_str+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(Spcsystem_Chr_str+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(Spcsystem_Chr_str+0)
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
	MOVF        FARG_FromIntToStr_ValueResoure+0, 0 
	MOVWF       R0 
	MOVF        FARG_FromIntToStr_ValueResoure+1, 0 
	MOVWF       R1 
	MOVF        FARG_FromIntToStr_ValueResoure+2, 0 
	MOVWF       R2 
	MOVF        FARG_FromIntToStr_ValueResoure+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_S+0, 0
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FARG_FromIntToStr_StringTarget+0, FSR1
	MOVFF       FARG_FromIntToStr_StringTarget+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      FARG_FromIntToStr_StringTarget+0, 1 
	INCF        FARG_FromIntToStr_StringTarget+1, 1 
	GOTO        L_FromIntToStr392
L_FromIntToStr391:
;Spcsystem.c,1678 :: 		if(ValueResoure/Chr_str[i])
	MOVF        FromIntToStr_i_L0+0, 0 
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
	MOVLW       Spcsystem_Chr_str+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(Spcsystem_Chr_str+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(Spcsystem_Chr_str+0)
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
	MOVF        FARG_FromIntToStr_ValueResoure+0, 0 
	MOVWF       R0 
	MOVF        FARG_FromIntToStr_ValueResoure+1, 0 
	MOVWF       R1 
	MOVF        FARG_FromIntToStr_ValueResoure+2, 0 
	MOVWF       R2 
	MOVF        FARG_FromIntToStr_ValueResoure+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_S+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_FromIntToStr393
;Spcsystem.c,1680 :: 		flag = 1;
	MOVLW       1
	MOVWF       FromIntToStr_flag_L0+0 
;Spcsystem.c,1681 :: 		*(StringTarget++) = ValueResoure/Chr_str[i] + 0x30;
	MOVF        FromIntToStr_i_L0+0, 0 
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
	MOVLW       Spcsystem_Chr_str+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(Spcsystem_Chr_str+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(Spcsystem_Chr_str+0)
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
	MOVF        FARG_FromIntToStr_ValueResoure+0, 0 
	MOVWF       R0 
	MOVF        FARG_FromIntToStr_ValueResoure+1, 0 
	MOVWF       R1 
	MOVF        FARG_FromIntToStr_ValueResoure+2, 0 
	MOVWF       R2 
	MOVF        FARG_FromIntToStr_ValueResoure+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_S+0, 0
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FARG_FromIntToStr_StringTarget+0, FSR1
	MOVFF       FARG_FromIntToStr_StringTarget+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      FARG_FromIntToStr_StringTarget+0, 1 
	INCF        FARG_FromIntToStr_StringTarget+1, 1 
;Spcsystem.c,1682 :: 		}
	GOTO        L_FromIntToStr394
L_FromIntToStr393:
;Spcsystem.c,1685 :: 		if(decimal_flag)
	MOVF        FromIntToStr_decimal_flag_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_FromIntToStr395
;Spcsystem.c,1687 :: 		*(StringTarget++) = ValueResoure/Chr_str[i] + 0x30;
	MOVF        FromIntToStr_i_L0+0, 0 
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
	MOVLW       Spcsystem_Chr_str+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(Spcsystem_Chr_str+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(Spcsystem_Chr_str+0)
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
	MOVF        FARG_FromIntToStr_ValueResoure+0, 0 
	MOVWF       R0 
	MOVF        FARG_FromIntToStr_ValueResoure+1, 0 
	MOVWF       R1 
	MOVF        FARG_FromIntToStr_ValueResoure+2, 0 
	MOVWF       R2 
	MOVF        FARG_FromIntToStr_ValueResoure+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_S+0, 0
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FARG_FromIntToStr_StringTarget+0, FSR1
	MOVFF       FARG_FromIntToStr_StringTarget+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      FARG_FromIntToStr_StringTarget+0, 1 
	INCF        FARG_FromIntToStr_StringTarget+1, 1 
;Spcsystem.c,1688 :: 		}
L_FromIntToStr395:
;Spcsystem.c,1690 :: 		if((decimal + i) == 7)
	MOVF        FromIntToStr_i_L0+0, 0 
	ADDWF       FARG_FromIntToStr_decimal+0, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       FARG_FromIntToStr_decimal+0, 7 
	MOVLW       255
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R2, 1 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FromIntToStr649
	MOVLW       7
	XORWF       R1, 0 
L__FromIntToStr649:
	BTFSS       STATUS+0, 2 
	GOTO        L_FromIntToStr396
;Spcsystem.c,1692 :: 		*(StringTarget++) = ValueResoure/Chr_str[i] + 0x30;
	MOVF        FromIntToStr_i_L0+0, 0 
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
	MOVLW       Spcsystem_Chr_str+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(Spcsystem_Chr_str+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(Spcsystem_Chr_str+0)
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
	MOVF        FARG_FromIntToStr_ValueResoure+0, 0 
	MOVWF       R0 
	MOVF        FARG_FromIntToStr_ValueResoure+1, 0 
	MOVWF       R1 
	MOVF        FARG_FromIntToStr_ValueResoure+2, 0 
	MOVWF       R2 
	MOVF        FARG_FromIntToStr_ValueResoure+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_S+0, 0
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FARG_FromIntToStr_StringTarget+0, FSR1
	MOVFF       FARG_FromIntToStr_StringTarget+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      FARG_FromIntToStr_StringTarget+0, 1 
	INCF        FARG_FromIntToStr_StringTarget+1, 1 
;Spcsystem.c,1693 :: 		}
L_FromIntToStr396:
;Spcsystem.c,1694 :: 		}
L_FromIntToStr394:
;Spcsystem.c,1695 :: 		}
L_FromIntToStr392:
;Spcsystem.c,1696 :: 		ValueResoure %= Chr_str[i];
	MOVF        FromIntToStr_i_L0+0, 0 
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
	MOVLW       Spcsystem_Chr_str+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(Spcsystem_Chr_str+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(Spcsystem_Chr_str+0)
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
	MOVF        FARG_FromIntToStr_ValueResoure+0, 0 
	MOVWF       R0 
	MOVF        FARG_FromIntToStr_ValueResoure+1, 0 
	MOVWF       R1 
	MOVF        FARG_FromIntToStr_ValueResoure+2, 0 
	MOVWF       R2 
	MOVF        FARG_FromIntToStr_ValueResoure+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R10, 0 
	MOVWF       R2 
	MOVF        R11, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+0 
	MOVF        R1, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+1 
	MOVF        R2, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+2 
	MOVF        R3, 0 
	MOVWF       FARG_FromIntToStr_ValueResoure+3 
;Spcsystem.c,1698 :: 		if((decimal + i) == 7)
	MOVF        FromIntToStr_i_L0+0, 0 
	ADDWF       FARG_FromIntToStr_decimal+0, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       FARG_FromIntToStr_decimal+0, 7 
	MOVLW       255
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R2, 1 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FromIntToStr650
	MOVLW       7
	XORWF       R1, 0 
L__FromIntToStr650:
	BTFSS       STATUS+0, 2 
	GOTO        L_FromIntToStr397
;Spcsystem.c,1700 :: 		if(decimal != 0)
	MOVF        FARG_FromIntToStr_decimal+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_FromIntToStr398
;Spcsystem.c,1702 :: 		*(StringTarget++) = '.';
	MOVFF       FARG_FromIntToStr_StringTarget+0, FSR1
	MOVFF       FARG_FromIntToStr_StringTarget+1, FSR1H
	MOVLW       46
	MOVWF       POSTINC1+0 
	INFSNZ      FARG_FromIntToStr_StringTarget+0, 1 
	INCF        FARG_FromIntToStr_StringTarget+1, 1 
;Spcsystem.c,1703 :: 		decimal_flag = 1;
	MOVLW       1
	MOVWF       FromIntToStr_decimal_flag_L0+0 
;Spcsystem.c,1704 :: 		}
L_FromIntToStr398:
;Spcsystem.c,1705 :: 		}
L_FromIntToStr397:
;Spcsystem.c,1672 :: 		for(i=0; i<8; i++)
	INCF        FromIntToStr_i_L0+0, 1 
;Spcsystem.c,1706 :: 		}
	GOTO        L_FromIntToStr388
L_FromIntToStr389:
;Spcsystem.c,1708 :: 		if(!(unitcont & 0x80))
	BTFSC       FromIntToStr_unitcont_L0+0, 7 
	GOTO        L_FromIntToStr399
;Spcsystem.c,1710 :: 		sourcecont = 0;
	CLRF        FromIntToStr_sourcecont_L0+0 
;Spcsystem.c,1711 :: 		if(unitcont == UNIT_TEMP)
	MOVF        FromIntToStr_unitcont_L0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_FromIntToStr400
;Spcsystem.c,1712 :: 		unitcont += pSPCValue[0].SPCSetPoints.system_valueb.bite.spc_units_c;
	CLRF        R0 
	BTFSC       _pSPCValue+138, 0 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       FromIntToStr_unitcont_L0+0, 1 
L_FromIntToStr400:
;Spcsystem.c,1713 :: 		*(StringTarget++) = ' ';
	MOVFF       FARG_FromIntToStr_StringTarget+0, FSR1
	MOVFF       FARG_FromIntToStr_StringTarget+1, FSR1H
	MOVLW       32
	MOVWF       POSTINC1+0 
	INFSNZ      FARG_FromIntToStr_StringTarget+0, 1 
	INCF        FARG_FromIntToStr_StringTarget+1, 1 
;Spcsystem.c,1714 :: 		while(SPCUnit[unitcont][sourcecont] != ' ')
L_FromIntToStr401:
	MOVLW       9
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        FromIntToStr_unitcont_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       Spcsystem_SPCUnit+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SPCUnit+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SPCUnit+0)
	ADDWFC      R2, 1 
	MOVF        FromIntToStr_sourcecont_L0+0, 0 
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
	XORLW       32
	BTFSC       STATUS+0, 2 
	GOTO        L_FromIntToStr402
;Spcsystem.c,1716 :: 		*(StringTarget+targetcont) = SPCUnit[unitcont][sourcecont];
	MOVF        FromIntToStr_targetcont_L0+0, 0 
	ADDWF       FARG_FromIntToStr_StringTarget+0, 0 
	MOVWF       FLOC__FromIntToStr+0 
	MOVLW       0
	ADDWFC      FARG_FromIntToStr_StringTarget+1, 0 
	MOVWF       FLOC__FromIntToStr+1 
	MOVLW       9
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        FromIntToStr_unitcont_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       Spcsystem_SPCUnit+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Spcsystem_SPCUnit+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Spcsystem_SPCUnit+0)
	ADDWFC      R2, 1 
	MOVF        FromIntToStr_sourcecont_L0+0, 0 
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
	MOVFF       FLOC__FromIntToStr+0, FSR1
	MOVFF       FLOC__FromIntToStr+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,1717 :: 		sourcecont++;
	INCF        FromIntToStr_sourcecont_L0+0, 1 
;Spcsystem.c,1718 :: 		targetcont++;
	INCF        FromIntToStr_targetcont_L0+0, 1 
;Spcsystem.c,1719 :: 		}
	GOTO        L_FromIntToStr401
L_FromIntToStr402:
;Spcsystem.c,1720 :: 		}
L_FromIntToStr399:
;Spcsystem.c,1721 :: 		}
L_end_FromIntToStr:
	RETURN      0
; end of _FromIntToStr

_storage:

;Spcsystem.c,1728 :: 		void storage()
;Spcsystem.c,1730 :: 		CopyStr(Info_Line1,Info_Line1_shape, 16);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_CopyStr_resource+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_CopyStr_resource+1 
	MOVLW       _Info_Line1_shape+0
	MOVWF       FARG_CopyStr_target+0 
	MOVLW       hi_addr(_Info_Line1_shape+0)
	MOVWF       FARG_CopyStr_target+1 
	MOVLW       16
	MOVWF       FARG_CopyStr_len+0 
	CALL        _CopyStr+0, 0
;Spcsystem.c,1731 :: 		CopyStr(Info_Line2,Info_Line2_shape, 16);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_CopyStr_resource+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_CopyStr_resource+1 
	MOVLW       _Info_Line2_shape+0
	MOVWF       FARG_CopyStr_target+0 
	MOVLW       hi_addr(_Info_Line2_shape+0)
	MOVWF       FARG_CopyStr_target+1 
	MOVLW       16
	MOVWF       FARG_CopyStr_len+0 
	CALL        _CopyStr+0, 0
;Spcsystem.c,1732 :: 		getParaChar(Info_Line1, STORE_STR);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       83
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,1733 :: 		ClearStr(Info_Line2, 16);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_ClearStr_target+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_ClearStr_target+1 
	MOVLW       16
	MOVWF       FARG_ClearStr_len+0 
	MOVLW       0
	MOVWF       FARG_ClearStr_len+1 
	CALL        _ClearStr+0, 0
;Spcsystem.c,1734 :: 		LCDext = 1;
	MOVLW       1
	MOVWF       _LCDext+0 
;Spcsystem.c,1735 :: 		}
L_end_storage:
	RETURN      0
; end of _storage

_Reset_PSW:

;Spcsystem.c,1742 :: 		void Reset_PSW(UCHAR direct, UCHAR cmd)
;Spcsystem.c,1747 :: 		if(reset_psw_en==0)
	MOVF        _reset_psw_en+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Reset_PSW403
;Spcsystem.c,1748 :: 		return;
	GOTO        L_end_Reset_PSW
L_Reset_PSW403:
;Spcsystem.c,1750 :: 		if(cmd == CMD_INIT)
	MOVF        FARG_Reset_PSW_cmd+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_Reset_PSW404
;Spcsystem.c,1752 :: 		reset_psw_en = 1;
	MOVLW       1
	MOVWF       _reset_psw_en+0 
;Spcsystem.c,1753 :: 		Reset_flag = 0;
	CLRF        Reset_PSW_Reset_flag_L0+0 
;Spcsystem.c,1754 :: 		getParaChar(Info_Line1, RESET_REQ_PSW_STR);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       80
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,1755 :: 		getParaChar(Info_Line2, YES_NO_STR+Reset_flag);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVF        Reset_PSW_Reset_flag_L0+0, 0 
	ADDLW       4
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,1756 :: 		}
	GOTO        L_Reset_PSW405
L_Reset_PSW404:
;Spcsystem.c,1757 :: 		else if(cmd == CMD_ENTER)    //enter
	MOVF        FARG_Reset_PSW_cmd+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Reset_PSW406
;Spcsystem.c,1759 :: 		reset_psw_en = 0;
	CLRF        _reset_psw_en+0 
;Spcsystem.c,1760 :: 		if(Reset_flag == 1)        //yes
	MOVF        Reset_PSW_Reset_flag_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Reset_PSW407
;Spcsystem.c,1762 :: 		getParaChar(pSPCValue[0].SPCSetPoints.Password, DEFAULT_PSW_STR);
	MOVLW       _pSPCValue+120
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_pSPCValue+120)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       78
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,1763 :: 		Savedata(PASSWORD_FLASH_LACAL,
	MOVLW       66
	MOVWF       FARG_Savedata_flash_lacl+0 
	MOVLW       0
	MOVWF       FARG_Savedata_flash_lacl+1 
;Spcsystem.c,1764 :: 		16,
	MOVLW       16
	MOVWF       FARG_Savedata_len+0 
	MOVLW       0
	MOVWF       FARG_Savedata_len+1 
;Spcsystem.c,1765 :: 		(UCHAR *)(&pSPCValue[0].SPCSetPoints.Password),
	MOVLW       _pSPCValue+120
	MOVWF       FARG_Savedata_ptr+0 
	MOVLW       hi_addr(_pSPCValue+120)
	MOVWF       FARG_Savedata_ptr+1 
;Spcsystem.c,1766 :: 		0);
	CLRF        FARG_Savedata_cmd+0 
	CALL        _Savedata+0, 0
;Spcsystem.c,1767 :: 		getParaChar(Info_Line1, RESET_SUCCESS_PSW_STR);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       81
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,1768 :: 		ClearStr(Info_Line2, 16);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_ClearStr_target+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_ClearStr_target+1 
	MOVLW       16
	MOVWF       FARG_ClearStr_len+0 
	MOVLW       0
	MOVWF       FARG_ClearStr_len+1 
	CALL        _ClearStr+0, 0
;Spcsystem.c,1769 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
;Spcsystem.c,1770 :: 		Delay_ms(1500);
	MOVLW       39
	MOVWF       R11, 0
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       38
	MOVWF       R13, 0
L_Reset_PSW408:
	DECFSZ      R13, 1, 1
	BRA         L_Reset_PSW408
	DECFSZ      R12, 1, 1
	BRA         L_Reset_PSW408
	DECFSZ      R11, 1, 1
	BRA         L_Reset_PSW408
	NOP
;Spcsystem.c,1771 :: 		spc_system_flag.bite.default_diaped = 0;
	BCF         _spc_system_flag+1, 2 
;Spcsystem.c,1772 :: 		disp_default();
	CALL        _disp_default+0, 0
;Spcsystem.c,1773 :: 		spc_system_flag.bite.default_diaped = 1;   //initial to display default information
	BSF         _spc_system_flag+1, 2 
;Spcsystem.c,1774 :: 		spc_system_flag.bite.stat_update = 1;      //show system stat information
	BSF         _spc_system_flag+3, 7 
;Spcsystem.c,1775 :: 		disp_default();
	CALL        _disp_default+0, 0
;Spcsystem.c,1776 :: 		}
	GOTO        L_Reset_PSW409
L_Reset_PSW407:
;Spcsystem.c,1779 :: 		spc_system_flag.bite.default_diaped = 0;
	BCF         _spc_system_flag+1, 2 
;Spcsystem.c,1780 :: 		disp_default();
	CALL        _disp_default+0, 0
;Spcsystem.c,1781 :: 		spc_system_flag.bite.default_diaped = 1;   //initial to display default information
	BSF         _spc_system_flag+1, 2 
;Spcsystem.c,1782 :: 		spc_system_flag.bite.stat_update = 1;      //show system stat information
	BSF         _spc_system_flag+3, 7 
;Spcsystem.c,1783 :: 		disp_default();
	CALL        _disp_default+0, 0
;Spcsystem.c,1784 :: 		}
L_Reset_PSW409:
;Spcsystem.c,1786 :: 		}
	GOTO        L_Reset_PSW410
L_Reset_PSW406:
;Spcsystem.c,1787 :: 		else if(cmd == CMD_ADJUST)    //left/right
	MOVF        FARG_Reset_PSW_cmd+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_Reset_PSW411
;Spcsystem.c,1789 :: 		if(direct)
	MOVF        FARG_Reset_PSW_direct+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Reset_PSW412
;Spcsystem.c,1791 :: 		if(Reset_flag==0)
	MOVF        Reset_PSW_Reset_flag_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Reset_PSW413
;Spcsystem.c,1793 :: 		Reset_flag = 1;
	MOVLW       1
	MOVWF       Reset_PSW_Reset_flag_L0+0 
;Spcsystem.c,1794 :: 		getParaChar(Info_Line2, YES_NO_STR+Reset_flag);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       5
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,1795 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
;Spcsystem.c,1796 :: 		}
L_Reset_PSW413:
;Spcsystem.c,1797 :: 		}
	GOTO        L_Reset_PSW414
L_Reset_PSW412:
;Spcsystem.c,1800 :: 		if(Reset_flag == 1)
	MOVF        Reset_PSW_Reset_flag_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Reset_PSW415
;Spcsystem.c,1802 :: 		Reset_flag = 0;
	CLRF        Reset_PSW_Reset_flag_L0+0 
;Spcsystem.c,1803 :: 		getParaChar(Info_Line2, YES_NO_STR+Reset_flag);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       4
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcsystem.c,1804 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
;Spcsystem.c,1805 :: 		}
L_Reset_PSW415:
;Spcsystem.c,1806 :: 		}
L_Reset_PSW414:
;Spcsystem.c,1807 :: 		}
L_Reset_PSW411:
L_Reset_PSW410:
L_Reset_PSW405:
;Spcsystem.c,1808 :: 		}
L_end_Reset_PSW:
	RETURN      0
; end of _Reset_PSW

_getStringNum:

;Spcsystem.c,1815 :: 		char getStringNum()
;Spcsystem.c,1819 :: 		for(i=0; i<PSW_CHARACT_NUM+PSW_CHARACT_EX_NUM; i++)
	CLRF        R2 
L_getStringNum416:
	MOVLW       94
	SUBWF       R2, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_getStringNum417
;Spcsystem.c,1821 :: 		if(SetP_shade.HeaterName[SetP_shade.CharacNum] == SpcCharactors[i])
	MOVLW       _SetP_shade+50
	MOVWF       FSR0 
	MOVLW       hi_addr(_SetP_shade+50)
	MOVWF       FSR0H 
	MOVF        _SetP_shade+82, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVLW       Spcsystem_SpcCharactors+0
	ADDWF       R2, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(Spcsystem_SpcCharactors+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(Spcsystem_SpcCharactors+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R1
	MOVF        POSTINC0+0, 0 
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_getStringNum419
;Spcsystem.c,1822 :: 		return i;
	MOVF        R2, 0 
	MOVWF       R0 
	GOTO        L_end_getStringNum
L_getStringNum419:
;Spcsystem.c,1819 :: 		for(i=0; i<PSW_CHARACT_NUM+PSW_CHARACT_EX_NUM; i++)
	INCF        R2, 1 
;Spcsystem.c,1823 :: 		}
	GOTO        L_getStringNum416
L_getStringNum417:
;Spcsystem.c,1824 :: 		}
L_end_getStringNum:
	RETURN      0
; end of _getStringNum

_RangeCheck:

;Spcsystem.c,1826 :: 		char RangeCheck(int *Buff, int MaxPara, int MinPara)
;Spcsystem.c,1828 :: 		char ret=0;
	CLRF        RangeCheck_ret_L0+0 
;Spcsystem.c,1830 :: 		if((*Buff > MaxPara) || (*Buff < MinPara))
	MOVFF       FARG_RangeCheck_Buff+0, FSR0
	MOVFF       FARG_RangeCheck_Buff+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       FARG_RangeCheck_MaxPara+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__RangeCheck655
	MOVF        R1, 0 
	SUBWF       FARG_RangeCheck_MaxPara+0, 0 
L__RangeCheck655:
	BTFSS       STATUS+0, 0 
	GOTO        L__RangeCheck542
	MOVFF       FARG_RangeCheck_Buff+0, FSR0
	MOVFF       FARG_RangeCheck_Buff+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_RangeCheck_MinPara+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__RangeCheck656
	MOVF        FARG_RangeCheck_MinPara+0, 0 
	SUBWF       R1, 0 
L__RangeCheck656:
	BTFSS       STATUS+0, 0 
	GOTO        L__RangeCheck542
	GOTO        L_RangeCheck422
L__RangeCheck542:
;Spcsystem.c,1831 :: 		ret = 1;
	MOVLW       1
	MOVWF       RangeCheck_ret_L0+0 
L_RangeCheck422:
;Spcsystem.c,1833 :: 		return ret;
	MOVF        RangeCheck_ret_L0+0, 0 
	MOVWF       R0 
;Spcsystem.c,1834 :: 		}
L_end_RangeCheck:
	RETURN      0
; end of _RangeCheck

_OutRangeProcess:

;Spcsystem.c,1836 :: 		void OutRangeProcess(char index, unsigned int Address, int *Ptr)
;Spcsystem.c,1838 :: 		switch(index)
	GOTO        L_OutRangeProcess423
;Spcsystem.c,1840 :: 		case 0:  //no special value, no related value
L_OutRangeProcess425:
;Spcsystem.c,1841 :: 		EEPROM_get(Address,sizeof(int),(unsigned char*)Ptr);
	MOVF        FARG_OutRangeProcess_Address+0, 0 
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+0 
	MOVF        FARG_OutRangeProcess_Address+1, 0 
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+1 
	MOVLW       2
	MOVWF       FARG_EEPROM_get_Len+0 
	MOVF        FARG_OutRangeProcess_Ptr+0, 0 
	MOVWF       FARG_EEPROM_get_readbuffer+0 
	MOVF        FARG_OutRangeProcess_Ptr+1, 0 
	MOVWF       FARG_EEPROM_get_readbuffer+1 
	CALL        _EEPROM_get+0, 0
;Spcsystem.c,1842 :: 		break;
	GOTO        L_OutRangeProcess424
;Spcsystem.c,1843 :: 		case 1:  //1 special value OFF, no related value
L_OutRangeProcess426:
;Spcsystem.c,1844 :: 		case 2:  //1 special value OFF, no related value
L_OutRangeProcess427:
;Spcsystem.c,1845 :: 		case 3:  //1 special value OFF, no related value
L_OutRangeProcess428:
;Spcsystem.c,1846 :: 		if(*Ptr != SPC_SYSTEMVALUE_OFF)
	MOVFF       FARG_OutRangeProcess_Ptr+0, FSR0
	MOVFF       FARG_OutRangeProcess_Ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__OutRangeProcess658
	MOVLW       255
	XORWF       R1, 0 
L__OutRangeProcess658:
	BTFSC       STATUS+0, 2 
	GOTO        L_OutRangeProcess429
;Spcsystem.c,1847 :: 		EEPROM_get(Address,sizeof(int),(unsigned char*)Ptr);
	MOVF        FARG_OutRangeProcess_Address+0, 0 
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+0 
	MOVF        FARG_OutRangeProcess_Address+1, 0 
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+1 
	MOVLW       2
	MOVWF       FARG_EEPROM_get_Len+0 
	MOVF        FARG_OutRangeProcess_Ptr+0, 0 
	MOVWF       FARG_EEPROM_get_readbuffer+0 
	MOVF        FARG_OutRangeProcess_Ptr+1, 0 
	MOVWF       FARG_EEPROM_get_readbuffer+1 
	CALL        _EEPROM_get+0, 0
L_OutRangeProcess429:
;Spcsystem.c,1848 :: 		break;
	GOTO        L_OutRangeProcess424
;Spcsystem.c,1849 :: 		case 4:  //no special value, no related value  ,temp value
L_OutRangeProcess430:
;Spcsystem.c,1850 :: 		EEPROM_get(Address,sizeof(int),(unsigned char*)Ptr);
	MOVF        FARG_OutRangeProcess_Address+0, 0 
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+0 
	MOVF        FARG_OutRangeProcess_Address+1, 0 
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+1 
	MOVLW       2
	MOVWF       FARG_EEPROM_get_Len+0 
	MOVF        FARG_OutRangeProcess_Ptr+0, 0 
	MOVWF       FARG_EEPROM_get_readbuffer+0 
	MOVF        FARG_OutRangeProcess_Ptr+1, 0 
	MOVWF       FARG_EEPROM_get_readbuffer+1 
	CALL        _EEPROM_get+0, 0
;Spcsystem.c,1851 :: 		EEPROM_get(Address-2,sizeof(int),(unsigned char*)Ptr-2);
	MOVLW       2
	SUBWF       FARG_OutRangeProcess_Address+0, 0 
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+0 
	MOVLW       0
	SUBWFB      FARG_OutRangeProcess_Address+1, 0 
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+1 
	MOVLW       2
	MOVWF       FARG_EEPROM_get_Len+0 
	MOVLW       2
	SUBWF       FARG_OutRangeProcess_Ptr+0, 0 
	MOVWF       FARG_EEPROM_get_readbuffer+0 
	MOVLW       0
	SUBWFB      FARG_OutRangeProcess_Ptr+1, 0 
	MOVWF       FARG_EEPROM_get_readbuffer+1 
	CALL        _EEPROM_get+0, 0
;Spcsystem.c,1852 :: 		break;
	GOTO        L_OutRangeProcess424
;Spcsystem.c,1853 :: 		case 5:  //1 special value OFF, related value ,temp
L_OutRangeProcess431:
;Spcsystem.c,1854 :: 		case 6:  //1 special value OFF, related value ,temp
L_OutRangeProcess432:
;Spcsystem.c,1855 :: 		if(*Ptr != SPC_SYSTEMVALUE_OFF)
	MOVFF       FARG_OutRangeProcess_Ptr+0, FSR0
	MOVFF       FARG_OutRangeProcess_Ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__OutRangeProcess659
	MOVLW       255
	XORWF       R1, 0 
L__OutRangeProcess659:
	BTFSC       STATUS+0, 2 
	GOTO        L_OutRangeProcess433
;Spcsystem.c,1857 :: 		EEPROM_get(Address,sizeof(int),(unsigned char*)Ptr);
	MOVF        FARG_OutRangeProcess_Address+0, 0 
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+0 
	MOVF        FARG_OutRangeProcess_Address+1, 0 
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+1 
	MOVLW       2
	MOVWF       FARG_EEPROM_get_Len+0 
	MOVF        FARG_OutRangeProcess_Ptr+0, 0 
	MOVWF       FARG_EEPROM_get_readbuffer+0 
	MOVF        FARG_OutRangeProcess_Ptr+1, 0 
	MOVWF       FARG_EEPROM_get_readbuffer+1 
	CALL        _EEPROM_get+0, 0
;Spcsystem.c,1858 :: 		EEPROM_get(Address-2,sizeof(int),(unsigned char*)Ptr-2);
	MOVLW       2
	SUBWF       FARG_OutRangeProcess_Address+0, 0 
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+0 
	MOVLW       0
	SUBWFB      FARG_OutRangeProcess_Address+1, 0 
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+1 
	MOVLW       2
	MOVWF       FARG_EEPROM_get_Len+0 
	MOVLW       2
	SUBWF       FARG_OutRangeProcess_Ptr+0, 0 
	MOVWF       FARG_EEPROM_get_readbuffer+0 
	MOVLW       0
	SUBWFB      FARG_OutRangeProcess_Ptr+1, 0 
	MOVWF       FARG_EEPROM_get_readbuffer+1 
	CALL        _EEPROM_get+0, 0
;Spcsystem.c,1859 :: 		}
L_OutRangeProcess433:
;Spcsystem.c,1860 :: 		break;
	GOTO        L_OutRangeProcess424
;Spcsystem.c,1861 :: 		case 7:  //2 special value DISABLE/CONTINUE, no related value
L_OutRangeProcess434:
;Spcsystem.c,1862 :: 		if((*Ptr != SPC_SYSTEMVALUE_DISABLE) && (*Ptr != SPC_SYSTEMVALUE_CONTINU))
	MOVFF       FARG_OutRangeProcess_Ptr+0, FSR0
	MOVFF       FARG_OutRangeProcess_Ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__OutRangeProcess660
	MOVLW       252
	XORWF       R1, 0 
L__OutRangeProcess660:
	BTFSC       STATUS+0, 2 
	GOTO        L_OutRangeProcess437
	MOVFF       FARG_OutRangeProcess_Ptr+0, FSR0
	MOVFF       FARG_OutRangeProcess_Ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__OutRangeProcess661
	MOVLW       253
	XORWF       R1, 0 
L__OutRangeProcess661:
	BTFSC       STATUS+0, 2 
	GOTO        L_OutRangeProcess437
L__OutRangeProcess544:
;Spcsystem.c,1863 :: 		EEPROM_get(Address,sizeof(int),(unsigned char*)Ptr);
	MOVF        FARG_OutRangeProcess_Address+0, 0 
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+0 
	MOVF        FARG_OutRangeProcess_Address+1, 0 
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+1 
	MOVLW       2
	MOVWF       FARG_EEPROM_get_Len+0 
	MOVF        FARG_OutRangeProcess_Ptr+0, 0 
	MOVWF       FARG_EEPROM_get_readbuffer+0 
	MOVF        FARG_OutRangeProcess_Ptr+1, 0 
	MOVWF       FARG_EEPROM_get_readbuffer+1 
	CALL        _EEPROM_get+0, 0
L_OutRangeProcess437:
;Spcsystem.c,1864 :: 		break;
	GOTO        L_OutRangeProcess424
;Spcsystem.c,1865 :: 		case 8:  //2 special value OFF/NONE, 1 related value
L_OutRangeProcess438:
;Spcsystem.c,1866 :: 		if((*Ptr != SPC_SYSTEMVALUE_OFF) && (*Ptr != SPC_SYSTEMVALUE_NONE))
	MOVFF       FARG_OutRangeProcess_Ptr+0, FSR0
	MOVFF       FARG_OutRangeProcess_Ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__OutRangeProcess662
	MOVLW       255
	XORWF       R1, 0 
L__OutRangeProcess662:
	BTFSC       STATUS+0, 2 
	GOTO        L_OutRangeProcess441
	MOVFF       FARG_OutRangeProcess_Ptr+0, FSR0
	MOVFF       FARG_OutRangeProcess_Ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__OutRangeProcess663
	MOVLW       254
	XORWF       R1, 0 
L__OutRangeProcess663:
	BTFSC       STATUS+0, 2 
	GOTO        L_OutRangeProcess441
L__OutRangeProcess543:
;Spcsystem.c,1868 :: 		EEPROM_get(Address,sizeof(int),(unsigned char*)Ptr);
	MOVF        FARG_OutRangeProcess_Address+0, 0 
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+0 
	MOVF        FARG_OutRangeProcess_Address+1, 0 
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+1 
	MOVLW       2
	MOVWF       FARG_EEPROM_get_Len+0 
	MOVF        FARG_OutRangeProcess_Ptr+0, 0 
	MOVWF       FARG_EEPROM_get_readbuffer+0 
	MOVF        FARG_OutRangeProcess_Ptr+1, 0 
	MOVWF       FARG_EEPROM_get_readbuffer+1 
	CALL        _EEPROM_get+0, 0
;Spcsystem.c,1869 :: 		EEPROM_get(Address-2,sizeof(int),(unsigned char*)Ptr-2);
	MOVLW       2
	SUBWF       FARG_OutRangeProcess_Address+0, 0 
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+0 
	MOVLW       0
	SUBWFB      FARG_OutRangeProcess_Address+1, 0 
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+1 
	MOVLW       2
	MOVWF       FARG_EEPROM_get_Len+0 
	MOVLW       2
	SUBWF       FARG_OutRangeProcess_Ptr+0, 0 
	MOVWF       FARG_EEPROM_get_readbuffer+0 
	MOVLW       0
	SUBWFB      FARG_OutRangeProcess_Ptr+1, 0 
	MOVWF       FARG_EEPROM_get_readbuffer+1 
	CALL        _EEPROM_get+0, 0
;Spcsystem.c,1870 :: 		}
L_OutRangeProcess441:
;Spcsystem.c,1871 :: 		break;
	GOTO        L_OutRangeProcess424
;Spcsystem.c,1872 :: 		}
L_OutRangeProcess423:
	MOVF        FARG_OutRangeProcess_index+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_OutRangeProcess425
	MOVF        FARG_OutRangeProcess_index+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_OutRangeProcess426
	MOVF        FARG_OutRangeProcess_index+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_OutRangeProcess427
	MOVF        FARG_OutRangeProcess_index+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_OutRangeProcess428
	MOVF        FARG_OutRangeProcess_index+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_OutRangeProcess430
	MOVF        FARG_OutRangeProcess_index+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_OutRangeProcess431
	MOVF        FARG_OutRangeProcess_index+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_OutRangeProcess432
	MOVF        FARG_OutRangeProcess_index+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_OutRangeProcess434
	MOVF        FARG_OutRangeProcess_index+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_OutRangeProcess438
L_OutRangeProcess424:
;Spcsystem.c,1873 :: 		}
L_end_OutRangeProcess:
	RETURN      0
; end of _OutRangeProcess

_InRangeProcess:

;Spcsystem.c,1876 :: 		int MaxData, int MinData)
;Spcsystem.c,1878 :: 		switch(index)
	GOTO        L_InRangeProcess442
;Spcsystem.c,1880 :: 		case 2:  //have high related
L_InRangeProcess444:
;Spcsystem.c,1881 :: 		if(*Ptr != SPC_SYSTEMVALUE_OFF)
	MOVFF       FARG_InRangeProcess_Ptr+0, FSR0
	MOVFF       FARG_InRangeProcess_Ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__InRangeProcess665
	MOVLW       255
	XORWF       R1, 0 
L__InRangeProcess665:
	BTFSC       STATUS+0, 2 
	GOTO        L_InRangeProcess445
;Spcsystem.c,1883 :: 		if((*(Ptr+1) != SPC_SYSTEMVALUE_OFF) && (*Ptr >= *(Ptr+1)))
	MOVLW       2
	ADDWF       FARG_InRangeProcess_Ptr+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_InRangeProcess_Ptr+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__InRangeProcess666
	MOVLW       255
	XORWF       R1, 0 
L__InRangeProcess666:
	BTFSC       STATUS+0, 2 
	GOTO        L_InRangeProcess448
	MOVFF       FARG_InRangeProcess_Ptr+0, FSR0
	MOVFF       FARG_InRangeProcess_Ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       2
	ADDWF       FARG_InRangeProcess_Ptr+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      FARG_InRangeProcess_Ptr+1, 0 
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
	GOTO        L__InRangeProcess667
	MOVF        R1, 0 
	SUBWF       R3, 0 
L__InRangeProcess667:
	BTFSS       STATUS+0, 0 
	GOTO        L_InRangeProcess448
L__InRangeProcess548:
;Spcsystem.c,1885 :: 		EEPROM_get(Address,sizeof(int),(unsigned char*)Ptr);
	MOVF        FARG_InRangeProcess_Address+0, 0 
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+0 
	MOVF        FARG_InRangeProcess_Address+1, 0 
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+1 
	MOVLW       2
	MOVWF       FARG_EEPROM_get_Len+0 
	MOVF        FARG_InRangeProcess_Ptr+0, 0 
	MOVWF       FARG_EEPROM_get_readbuffer+0 
	MOVF        FARG_InRangeProcess_Ptr+1, 0 
	MOVWF       FARG_EEPROM_get_readbuffer+1 
	CALL        _EEPROM_get+0, 0
;Spcsystem.c,1886 :: 		}
L_InRangeProcess448:
;Spcsystem.c,1887 :: 		}
L_InRangeProcess445:
;Spcsystem.c,1888 :: 		break;
	GOTO        L_InRangeProcess443
;Spcsystem.c,1889 :: 		case 3:  //have low related
L_InRangeProcess449:
;Spcsystem.c,1890 :: 		if(*Ptr != SPC_SYSTEMVALUE_OFF)
	MOVFF       FARG_InRangeProcess_Ptr+0, FSR0
	MOVFF       FARG_InRangeProcess_Ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__InRangeProcess668
	MOVLW       255
	XORWF       R1, 0 
L__InRangeProcess668:
	BTFSC       STATUS+0, 2 
	GOTO        L_InRangeProcess450
;Spcsystem.c,1892 :: 		if((*(Ptr-1) != SPC_SYSTEMVALUE_OFF) && (*Ptr <= *(Ptr-1)))
	MOVLW       2
	SUBWF       FARG_InRangeProcess_Ptr+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	SUBWFB      FARG_InRangeProcess_Ptr+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__InRangeProcess669
	MOVLW       255
	XORWF       R1, 0 
L__InRangeProcess669:
	BTFSC       STATUS+0, 2 
	GOTO        L_InRangeProcess453
	MOVFF       FARG_InRangeProcess_Ptr+0, FSR0
	MOVFF       FARG_InRangeProcess_Ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       2
	SUBWF       FARG_InRangeProcess_Ptr+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	SUBWFB      FARG_InRangeProcess_Ptr+1, 0 
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
	GOTO        L__InRangeProcess670
	MOVF        R3, 0 
	SUBWF       R1, 0 
L__InRangeProcess670:
	BTFSS       STATUS+0, 0 
	GOTO        L_InRangeProcess453
L__InRangeProcess547:
;Spcsystem.c,1894 :: 		EEPROM_get(Address,sizeof(int),(unsigned char*)Ptr);
	MOVF        FARG_InRangeProcess_Address+0, 0 
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+0 
	MOVF        FARG_InRangeProcess_Address+1, 0 
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+1 
	MOVLW       2
	MOVWF       FARG_EEPROM_get_Len+0 
	MOVF        FARG_InRangeProcess_Ptr+0, 0 
	MOVWF       FARG_EEPROM_get_readbuffer+0 
	MOVF        FARG_InRangeProcess_Ptr+1, 0 
	MOVWF       FARG_EEPROM_get_readbuffer+1 
	CALL        _EEPROM_get+0, 0
;Spcsystem.c,1895 :: 		}
L_InRangeProcess453:
;Spcsystem.c,1896 :: 		}
L_InRangeProcess450:
;Spcsystem.c,1897 :: 		break;
	GOTO        L_InRangeProcess443
;Spcsystem.c,1898 :: 		case 5:  //have high related, temp
L_InRangeProcess454:
;Spcsystem.c,1899 :: 		if(*Ptr != SPC_SYSTEMVALUE_OFF)
	MOVFF       FARG_InRangeProcess_Ptr+0, FSR0
	MOVFF       FARG_InRangeProcess_Ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__InRangeProcess671
	MOVLW       255
	XORWF       R1, 0 
L__InRangeProcess671:
	BTFSC       STATUS+0, 2 
	GOTO        L_InRangeProcess455
;Spcsystem.c,1901 :: 		if((*(Ptr+2) != SPC_SYSTEMVALUE_OFF) && (*Ptr >= *(Ptr+2)))
	MOVLW       4
	ADDWF       FARG_InRangeProcess_Ptr+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_InRangeProcess_Ptr+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__InRangeProcess672
	MOVLW       255
	XORWF       R1, 0 
L__InRangeProcess672:
	BTFSC       STATUS+0, 2 
	GOTO        L_InRangeProcess458
	MOVFF       FARG_InRangeProcess_Ptr+0, FSR0
	MOVFF       FARG_InRangeProcess_Ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       4
	ADDWF       FARG_InRangeProcess_Ptr+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      FARG_InRangeProcess_Ptr+1, 0 
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
	GOTO        L__InRangeProcess673
	MOVF        R1, 0 
	SUBWF       R3, 0 
L__InRangeProcess673:
	BTFSS       STATUS+0, 0 
	GOTO        L_InRangeProcess458
L__InRangeProcess546:
;Spcsystem.c,1903 :: 		EEPROM_get(Address,sizeof(int),(unsigned char*)Ptr);
	MOVF        FARG_InRangeProcess_Address+0, 0 
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+0 
	MOVF        FARG_InRangeProcess_Address+1, 0 
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+1 
	MOVLW       2
	MOVWF       FARG_EEPROM_get_Len+0 
	MOVF        FARG_InRangeProcess_Ptr+0, 0 
	MOVWF       FARG_EEPROM_get_readbuffer+0 
	MOVF        FARG_InRangeProcess_Ptr+1, 0 
	MOVWF       FARG_EEPROM_get_readbuffer+1 
	CALL        _EEPROM_get+0, 0
;Spcsystem.c,1904 :: 		EEPROM_get(Address-2,sizeof(int),(unsigned char*)Ptr-2);
	MOVLW       2
	SUBWF       FARG_InRangeProcess_Address+0, 0 
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+0 
	MOVLW       0
	SUBWFB      FARG_InRangeProcess_Address+1, 0 
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+1 
	MOVLW       2
	MOVWF       FARG_EEPROM_get_Len+0 
	MOVLW       2
	SUBWF       FARG_InRangeProcess_Ptr+0, 0 
	MOVWF       FARG_EEPROM_get_readbuffer+0 
	MOVLW       0
	SUBWFB      FARG_InRangeProcess_Ptr+1, 0 
	MOVWF       FARG_EEPROM_get_readbuffer+1 
	CALL        _EEPROM_get+0, 0
;Spcsystem.c,1905 :: 		}
L_InRangeProcess458:
;Spcsystem.c,1906 :: 		if(ProCtlEnable(ChannelNum))
	MOVF        FARG_InRangeProcess_ChannelNum+0, 0 
	MOVWF       FARG_ProCtlEnable_ChannelNum+0 
	CALL        _ProCtlEnable+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_InRangeProcess459
;Spcsystem.c,1908 :: 		if(*Ptr >= pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C)
	MOVFF       FARG_InRangeProcess_Ptr+0, FSR0
	MOVFF       FARG_InRangeProcess_Ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__InRangeProcess+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__InRangeProcess+1 
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_InRangeProcess_ChannelNum+0, 0 
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
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       FLOC__InRangeProcess+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__InRangeProcess674
	MOVF        R1, 0 
	SUBWF       FLOC__InRangeProcess+0, 0 
L__InRangeProcess674:
	BTFSS       STATUS+0, 0 
	GOTO        L_InRangeProcess460
;Spcsystem.c,1910 :: 		*Ptr = pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C-1;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_InRangeProcess_ChannelNum+0, 0 
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
	MOVLW       1
	SUBWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      POSTINC0+0, 0 
	MOVWF       R1 
	MOVFF       FARG_InRangeProcess_Ptr+0, FSR1
	MOVFF       FARG_InRangeProcess_Ptr+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,1911 :: 		*(Ptr-1) = ConvertCtoF(*Ptr);
	MOVLW       2
	SUBWF       FARG_InRangeProcess_Ptr+0, 0 
	MOVWF       FLOC__InRangeProcess+0 
	MOVLW       0
	SUBWFB      FARG_InRangeProcess_Ptr+1, 0 
	MOVWF       FLOC__InRangeProcess+1 
	MOVFF       FARG_InRangeProcess_Ptr+0, FSR0
	MOVFF       FARG_InRangeProcess_Ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ConvertCtoF_sourse+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ConvertCtoF_sourse+1 
	CALL        _ConvertCtoF+0, 0
	MOVFF       FLOC__InRangeProcess+0, FSR1
	MOVFF       FLOC__InRangeProcess+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,1912 :: 		}
L_InRangeProcess460:
;Spcsystem.c,1914 :: 		}
	GOTO        L_InRangeProcess461
L_InRangeProcess459:
;Spcsystem.c,1917 :: 		if(*Ptr >= pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C-pSPCValue[ChannelNum].SPCSetPoints.DeadBand.Temperature_C)
	MOVFF       FARG_InRangeProcess_Ptr+0, FSR0
	MOVFF       FARG_InRangeProcess_Ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__InRangeProcess+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__InRangeProcess+1 
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_InRangeProcess_ChannelNum+0, 0 
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
	MOVWF       R3 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R4 
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
	XORWF       FLOC__InRangeProcess+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__InRangeProcess675
	MOVF        R1, 0 
	SUBWF       FLOC__InRangeProcess+0, 0 
L__InRangeProcess675:
	BTFSS       STATUS+0, 0 
	GOTO        L_InRangeProcess462
;Spcsystem.c,1919 :: 		*Ptr = pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C-pSPCValue[ChannelNum].SPCSetPoints.DeadBand.Temperature_C-1;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_InRangeProcess_ChannelNum+0, 0 
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
	MOVF        POSTINC2+0, 0 
	SUBWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC2+0, 0 
	SUBWFB      POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       1
	SUBWF       R0, 1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVFF       FARG_InRangeProcess_Ptr+0, FSR1
	MOVFF       FARG_InRangeProcess_Ptr+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,1920 :: 		*(Ptr-1) = ConvertCtoF(*Ptr);
	MOVLW       2
	SUBWF       FARG_InRangeProcess_Ptr+0, 0 
	MOVWF       FLOC__InRangeProcess+0 
	MOVLW       0
	SUBWFB      FARG_InRangeProcess_Ptr+1, 0 
	MOVWF       FLOC__InRangeProcess+1 
	MOVFF       FARG_InRangeProcess_Ptr+0, FSR0
	MOVFF       FARG_InRangeProcess_Ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ConvertCtoF_sourse+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ConvertCtoF_sourse+1 
	CALL        _ConvertCtoF+0, 0
	MOVFF       FLOC__InRangeProcess+0, FSR1
	MOVFF       FLOC__InRangeProcess+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,1921 :: 		}
L_InRangeProcess462:
;Spcsystem.c,1922 :: 		}
L_InRangeProcess461:
;Spcsystem.c,1923 :: 		if(*Ptr < MinData)
	MOVFF       FARG_InRangeProcess_Ptr+0, FSR0
	MOVFF       FARG_InRangeProcess_Ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_InRangeProcess_MinData+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__InRangeProcess676
	MOVF        FARG_InRangeProcess_MinData+0, 0 
	SUBWF       R1, 0 
L__InRangeProcess676:
	BTFSC       STATUS+0, 0 
	GOTO        L_InRangeProcess463
;Spcsystem.c,1925 :: 		*Ptr = MinData;
	MOVFF       FARG_InRangeProcess_Ptr+0, FSR1
	MOVFF       FARG_InRangeProcess_Ptr+1, FSR1H
	MOVF        FARG_InRangeProcess_MinData+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG_InRangeProcess_MinData+1, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,1926 :: 		*(Ptr-1) = ConvertCtoF(*Ptr);
	MOVLW       2
	SUBWF       FARG_InRangeProcess_Ptr+0, 0 
	MOVWF       FLOC__InRangeProcess+0 
	MOVLW       0
	SUBWFB      FARG_InRangeProcess_Ptr+1, 0 
	MOVWF       FLOC__InRangeProcess+1 
	MOVFF       FARG_InRangeProcess_Ptr+0, FSR0
	MOVFF       FARG_InRangeProcess_Ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ConvertCtoF_sourse+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ConvertCtoF_sourse+1 
	CALL        _ConvertCtoF+0, 0
	MOVFF       FLOC__InRangeProcess+0, FSR1
	MOVFF       FLOC__InRangeProcess+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,1927 :: 		}
L_InRangeProcess463:
;Spcsystem.c,1928 :: 		}
L_InRangeProcess455:
;Spcsystem.c,1929 :: 		break;
	GOTO        L_InRangeProcess443
;Spcsystem.c,1930 :: 		case 6:  //have low related, temp
L_InRangeProcess464:
;Spcsystem.c,1931 :: 		if(*Ptr != SPC_SYSTEMVALUE_OFF)
	MOVFF       FARG_InRangeProcess_Ptr+0, FSR0
	MOVFF       FARG_InRangeProcess_Ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__InRangeProcess677
	MOVLW       255
	XORWF       R1, 0 
L__InRangeProcess677:
	BTFSC       STATUS+0, 2 
	GOTO        L_InRangeProcess465
;Spcsystem.c,1933 :: 		if((*(Ptr-2) != SPC_SYSTEMVALUE_OFF) && (*Ptr <= *(Ptr-2)))
	MOVLW       4
	SUBWF       FARG_InRangeProcess_Ptr+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	SUBWFB      FARG_InRangeProcess_Ptr+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__InRangeProcess678
	MOVLW       255
	XORWF       R1, 0 
L__InRangeProcess678:
	BTFSC       STATUS+0, 2 
	GOTO        L_InRangeProcess468
	MOVFF       FARG_InRangeProcess_Ptr+0, FSR0
	MOVFF       FARG_InRangeProcess_Ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       4
	SUBWF       FARG_InRangeProcess_Ptr+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	SUBWFB      FARG_InRangeProcess_Ptr+1, 0 
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
	GOTO        L__InRangeProcess679
	MOVF        R3, 0 
	SUBWF       R1, 0 
L__InRangeProcess679:
	BTFSS       STATUS+0, 0 
	GOTO        L_InRangeProcess468
L__InRangeProcess545:
;Spcsystem.c,1935 :: 		EEPROM_get(Address,sizeof(int),(unsigned char*)Ptr);
	MOVF        FARG_InRangeProcess_Address+0, 0 
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+0 
	MOVF        FARG_InRangeProcess_Address+1, 0 
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+1 
	MOVLW       2
	MOVWF       FARG_EEPROM_get_Len+0 
	MOVF        FARG_InRangeProcess_Ptr+0, 0 
	MOVWF       FARG_EEPROM_get_readbuffer+0 
	MOVF        FARG_InRangeProcess_Ptr+1, 0 
	MOVWF       FARG_EEPROM_get_readbuffer+1 
	CALL        _EEPROM_get+0, 0
;Spcsystem.c,1936 :: 		EEPROM_get(Address-2,sizeof(int),(unsigned char*)Ptr-2);
	MOVLW       2
	SUBWF       FARG_InRangeProcess_Address+0, 0 
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+0 
	MOVLW       0
	SUBWFB      FARG_InRangeProcess_Address+1, 0 
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+1 
	MOVLW       2
	MOVWF       FARG_EEPROM_get_Len+0 
	MOVLW       2
	SUBWF       FARG_InRangeProcess_Ptr+0, 0 
	MOVWF       FARG_EEPROM_get_readbuffer+0 
	MOVLW       0
	SUBWFB      FARG_InRangeProcess_Ptr+1, 0 
	MOVWF       FARG_EEPROM_get_readbuffer+1 
	CALL        _EEPROM_get+0, 0
;Spcsystem.c,1937 :: 		}
L_InRangeProcess468:
;Spcsystem.c,1938 :: 		if(ProCtlEnable(ChannelNum))
	MOVF        FARG_InRangeProcess_ChannelNum+0, 0 
	MOVWF       FARG_ProCtlEnable_ChannelNum+0 
	CALL        _ProCtlEnable+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_InRangeProcess469
;Spcsystem.c,1940 :: 		if(*Ptr <= pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C)
	MOVFF       FARG_InRangeProcess_Ptr+0, FSR0
	MOVFF       FARG_InRangeProcess_Ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__InRangeProcess+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__InRangeProcess+1 
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_InRangeProcess_ChannelNum+0, 0 
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
	XORWF       FLOC__InRangeProcess+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__InRangeProcess680
	MOVF        FLOC__InRangeProcess+0, 0 
	SUBWF       R1, 0 
L__InRangeProcess680:
	BTFSS       STATUS+0, 0 
	GOTO        L_InRangeProcess470
;Spcsystem.c,1942 :: 		*Ptr = pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C+1;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_InRangeProcess_ChannelNum+0, 0 
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
	MOVLW       1
	ADDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      POSTINC0+0, 0 
	MOVWF       R1 
	MOVFF       FARG_InRangeProcess_Ptr+0, FSR1
	MOVFF       FARG_InRangeProcess_Ptr+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,1943 :: 		*(Ptr-1) = ConvertCtoF(*Ptr);
	MOVLW       2
	SUBWF       FARG_InRangeProcess_Ptr+0, 0 
	MOVWF       FLOC__InRangeProcess+0 
	MOVLW       0
	SUBWFB      FARG_InRangeProcess_Ptr+1, 0 
	MOVWF       FLOC__InRangeProcess+1 
	MOVFF       FARG_InRangeProcess_Ptr+0, FSR0
	MOVFF       FARG_InRangeProcess_Ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ConvertCtoF_sourse+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ConvertCtoF_sourse+1 
	CALL        _ConvertCtoF+0, 0
	MOVFF       FLOC__InRangeProcess+0, FSR1
	MOVFF       FLOC__InRangeProcess+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,1944 :: 		}
L_InRangeProcess470:
;Spcsystem.c,1945 :: 		}
	GOTO        L_InRangeProcess471
L_InRangeProcess469:
;Spcsystem.c,1948 :: 		if(*Ptr <= pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C+pSPCValue[ChannelNum].SPCSetPoints.DeadBand.Temperature_C)
	MOVFF       FARG_InRangeProcess_Ptr+0, FSR0
	MOVFF       FARG_InRangeProcess_Ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__InRangeProcess+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__InRangeProcess+1 
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_InRangeProcess_ChannelNum+0, 0 
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
	MOVWF       R3 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R4 
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
	XORWF       FLOC__InRangeProcess+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__InRangeProcess681
	MOVF        FLOC__InRangeProcess+0, 0 
	SUBWF       R1, 0 
L__InRangeProcess681:
	BTFSS       STATUS+0, 0 
	GOTO        L_InRangeProcess472
;Spcsystem.c,1950 :: 		*Ptr = pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C+pSPCValue[ChannelNum].SPCSetPoints.DeadBand.Temperature_C+1;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_InRangeProcess_ChannelNum+0, 0 
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
	MOVF        POSTINC2+0, 0 
	ADDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC2+0, 0 
	ADDWFC      POSTINC0+0, 0 
	MOVWF       R1 
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVFF       FARG_InRangeProcess_Ptr+0, FSR1
	MOVFF       FARG_InRangeProcess_Ptr+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,1951 :: 		*(Ptr-1) = ConvertCtoF(*Ptr);
	MOVLW       2
	SUBWF       FARG_InRangeProcess_Ptr+0, 0 
	MOVWF       FLOC__InRangeProcess+0 
	MOVLW       0
	SUBWFB      FARG_InRangeProcess_Ptr+1, 0 
	MOVWF       FLOC__InRangeProcess+1 
	MOVFF       FARG_InRangeProcess_Ptr+0, FSR0
	MOVFF       FARG_InRangeProcess_Ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ConvertCtoF_sourse+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ConvertCtoF_sourse+1 
	CALL        _ConvertCtoF+0, 0
	MOVFF       FLOC__InRangeProcess+0, FSR1
	MOVFF       FLOC__InRangeProcess+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,1952 :: 		}
L_InRangeProcess472:
;Spcsystem.c,1953 :: 		}
L_InRangeProcess471:
;Spcsystem.c,1954 :: 		if(*Ptr > MaxData)
	MOVFF       FARG_InRangeProcess_Ptr+0, FSR0
	MOVFF       FARG_InRangeProcess_Ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       FARG_InRangeProcess_MaxData+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__InRangeProcess682
	MOVF        R1, 0 
	SUBWF       FARG_InRangeProcess_MaxData+0, 0 
L__InRangeProcess682:
	BTFSC       STATUS+0, 0 
	GOTO        L_InRangeProcess473
;Spcsystem.c,1956 :: 		*Ptr = MaxData;
	MOVFF       FARG_InRangeProcess_Ptr+0, FSR1
	MOVFF       FARG_InRangeProcess_Ptr+1, FSR1H
	MOVF        FARG_InRangeProcess_MaxData+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG_InRangeProcess_MaxData+1, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,1957 :: 		*(Ptr-1) = ConvertCtoF(*Ptr);
	MOVLW       2
	SUBWF       FARG_InRangeProcess_Ptr+0, 0 
	MOVWF       FLOC__InRangeProcess+0 
	MOVLW       0
	SUBWFB      FARG_InRangeProcess_Ptr+1, 0 
	MOVWF       FLOC__InRangeProcess+1 
	MOVFF       FARG_InRangeProcess_Ptr+0, FSR0
	MOVFF       FARG_InRangeProcess_Ptr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ConvertCtoF_sourse+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ConvertCtoF_sourse+1 
	CALL        _ConvertCtoF+0, 0
	MOVFF       FLOC__InRangeProcess+0, FSR1
	MOVFF       FLOC__InRangeProcess+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,1958 :: 		}
L_InRangeProcess473:
;Spcsystem.c,1959 :: 		}
L_InRangeProcess465:
;Spcsystem.c,1960 :: 		break;
	GOTO        L_InRangeProcess443
;Spcsystem.c,1961 :: 		default:
L_InRangeProcess474:
;Spcsystem.c,1962 :: 		break;
	GOTO        L_InRangeProcess443
;Spcsystem.c,1963 :: 		}
L_InRangeProcess442:
	MOVF        FARG_InRangeProcess_index+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_InRangeProcess444
	MOVF        FARG_InRangeProcess_index+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_InRangeProcess449
	MOVF        FARG_InRangeProcess_index+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_InRangeProcess454
	MOVF        FARG_InRangeProcess_index+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_InRangeProcess464
	GOTO        L_InRangeProcess474
L_InRangeProcess443:
;Spcsystem.c,1964 :: 		}
L_end_InRangeProcess:
	RETURN      0
; end of _InRangeProcess

_ConflictCorrection:

;Spcsystem.c,1966 :: 		void ConflictCorrection()
;Spcsystem.c,1972 :: 		char BaudChanged=0;
	CLRF        ConflictCorrection_BaudChanged_L0+0 
;Spcsystem.c,1977 :: 		if(ParametersChanged)
	MOVF        _ParametersChanged+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_ConflictCorrection475
;Spcsystem.c,1979 :: 		ParametersChanged = 0;
	CLRF        _ParametersChanged+0 
;Spcsystem.c,1980 :: 		Ptr[0] = (int*)&pSPCValue[0].SPCSetPoints;
	MOVLW       _pSPCValue+54
	MOVWF       ConflictCorrection_Ptr_L0+0 
	MOVLW       hi_addr(_pSPCValue+54)
	MOVWF       ConflictCorrection_Ptr_L0+1 
;Spcsystem.c,1981 :: 		Ptr[1] = (int*)&pSPCValue[1].SPCSetPoints;
	MOVLW       _pSPCValue+196
	MOVWF       ConflictCorrection_Ptr_L0+2 
	MOVLW       hi_addr(_pSPCValue+196)
	MOVWF       ConflictCorrection_Ptr_L0+3 
;Spcsystem.c,1983 :: 		for(i=0;i<20;i++)
	CLRF        ConflictCorrection_i_L0+0 
L_ConflictCorrection476:
	MOVLW       20
	SUBWF       ConflictCorrection_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_ConflictCorrection477
;Spcsystem.c,1985 :: 		Ptr[0] = (int*)&pSPCValue[0].SPCSetPoints + ConflictCheckList[i].ParaMenAdress;
	MOVLW       6
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        ConflictCorrection_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       _ConflictCheckList+0
	ADDWF       R0, 0 
	MOVWF       R4 
	MOVLW       hi_addr(_ConflictCheckList+0)
	ADDWFC      R1, 0 
	MOVWF       R5 
	MOVLW       higher_addr(_ConflictCheckList+0)
	ADDWFC      R2, 0 
	MOVWF       R6 
	MOVF        R4, 0 
	MOVWF       TBLPTRL 
	MOVF        R5, 0 
	MOVWF       TBLPTRH 
	MOVF        R6, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R3
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pSPCValue+54
	ADDWF       R0, 0 
	MOVWF       ConflictCorrection_Ptr_L0+0 
	MOVLW       hi_addr(_pSPCValue+54)
	ADDWFC      R1, 0 
	MOVWF       ConflictCorrection_Ptr_L0+1 
;Spcsystem.c,1986 :: 		Ptr[1] = (int*)&pSPCValue[1].SPCSetPoints + ConflictCheckList[i].ParaMenAdress;
	MOVF        R4, 0 
	MOVWF       TBLPTRL 
	MOVF        R5, 0 
	MOVWF       TBLPTRH 
	MOVF        R6, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R3
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pSPCValue+196
	ADDWF       R0, 0 
	MOVWF       ConflictCorrection_Ptr_L0+2 
	MOVLW       hi_addr(_pSPCValue+196)
	ADDWFC      R1, 0 
	MOVWF       ConflictCorrection_Ptr_L0+3 
;Spcsystem.c,1987 :: 		OutOfRanged[0] = RangeCheck(Ptr[0], ConflictCheckList[i].MaxPara, ConflictCheckList[i].MinPara);
	MOVF        ConflictCorrection_Ptr_L0+0, 0 
	MOVWF       FARG_RangeCheck_Buff+0 
	MOVF        ConflictCorrection_Ptr_L0+1, 0 
	MOVWF       FARG_RangeCheck_Buff+1 
	MOVLW       1
	ADDWF       R4, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R5, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R6, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_RangeCheck_MaxPara+0
	TBLRD*+
	MOVFF       TABLAT+0, FARG_RangeCheck_MaxPara+1
	MOVLW       3
	ADDWF       R4, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R5, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R6, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_RangeCheck_MinPara+0
	TBLRD*+
	MOVFF       TABLAT+0, FARG_RangeCheck_MinPara+1
	CALL        _RangeCheck+0, 0
	MOVF        R0, 0 
	MOVWF       ConflictCorrection_OutOfRanged_L0+0 
;Spcsystem.c,1988 :: 		OutOfRanged[1] = RangeCheck(Ptr[1], ConflictCheckList[i].MaxPara, ConflictCheckList[i].MinPara);
	MOVF        ConflictCorrection_Ptr_L0+2, 0 
	MOVWF       FARG_RangeCheck_Buff+0 
	MOVF        ConflictCorrection_Ptr_L0+3, 0 
	MOVWF       FARG_RangeCheck_Buff+1 
	MOVLW       6
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        ConflictCorrection_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       _ConflictCheckList+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ConflictCheckList+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(_ConflictCheckList+0)
	ADDWFC      R2, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_RangeCheck_MaxPara+0
	TBLRD*+
	MOVFF       TABLAT+0, FARG_RangeCheck_MaxPara+1
	MOVLW       3
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_RangeCheck_MinPara+0
	TBLRD*+
	MOVFF       TABLAT+0, FARG_RangeCheck_MinPara+1
	CALL        _RangeCheck+0, 0
	MOVF        R0, 0 
	MOVWF       ConflictCorrection_OutOfRanged_L0+1 
;Spcsystem.c,1989 :: 		if(OutOfRanged[0])
	MOVF        ConflictCorrection_OutOfRanged_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_ConflictCorrection479
;Spcsystem.c,1991 :: 		index = ConflictCheckList[i].SpecialNum;
	MOVLW       6
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        ConflictCorrection_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       _ConflictCheckList+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ConflictCheckList+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(_ConflictCheckList+0)
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
	MOVFF       TABLAT+0, FARG_OutRangeProcess_index+0
;Spcsystem.c,1992 :: 		Address = 1+ConflictCheckList[i].ParaMenAdress*2;
	MOVF        R0, 0 
	MOVWF       TBLPTRL 
	MOVF        R1, 0 
	MOVWF       TBLPTRH 
	MOVF        R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R3
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	RLCF        R1, 1 
	BCF         R0, 0 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FARG_OutRangeProcess_Address+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FARG_OutRangeProcess_Address+1 
;Spcsystem.c,1993 :: 		OutRangeProcess(index, Address, Ptr[0]);
	MOVF        ConflictCorrection_Ptr_L0+0, 0 
	MOVWF       FARG_OutRangeProcess_Ptr+0 
	MOVF        ConflictCorrection_Ptr_L0+1, 0 
	MOVWF       FARG_OutRangeProcess_Ptr+1 
	CALL        _OutRangeProcess+0, 0
;Spcsystem.c,1994 :: 		}
	GOTO        L_ConflictCorrection480
L_ConflictCorrection479:
;Spcsystem.c,1997 :: 		index = ConflictCheckList[i].SpecialNum;
	MOVLW       6
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        ConflictCorrection_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       _ConflictCheckList+0
	ADDWF       R0, 0 
	MOVWF       R4 
	MOVLW       hi_addr(_ConflictCheckList+0)
	ADDWFC      R1, 0 
	MOVWF       R5 
	MOVLW       higher_addr(_ConflictCheckList+0)
	ADDWFC      R2, 0 
	MOVWF       R6 
	MOVLW       5
	ADDWF       R4, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R5, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R6, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_InRangeProcess_index+0
;Spcsystem.c,1998 :: 		Address = 1+ConflictCheckList[i].ParaMenAdress*2;
	MOVF        R4, 0 
	MOVWF       TBLPTRL 
	MOVF        R5, 0 
	MOVWF       TBLPTRH 
	MOVF        R6, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R3
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	RLCF        R1, 1 
	BCF         R0, 0 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FARG_InRangeProcess_Address+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FARG_InRangeProcess_Address+1 
;Spcsystem.c,1999 :: 		InRangeProcess(index, Address, Ptr[0], 0, ConflictCheckList[i].MaxPara, ConflictCheckList[i].MinPara);
	MOVF        ConflictCorrection_Ptr_L0+0, 0 
	MOVWF       FARG_InRangeProcess_Ptr+0 
	MOVF        ConflictCorrection_Ptr_L0+1, 0 
	MOVWF       FARG_InRangeProcess_Ptr+1 
	CLRF        FARG_InRangeProcess_ChannelNum+0 
	MOVLW       1
	ADDWF       R4, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R5, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R6, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_InRangeProcess_MaxData+0
	TBLRD*+
	MOVFF       TABLAT+0, FARG_InRangeProcess_MaxData+1
	MOVLW       3
	ADDWF       R4, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R5, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R6, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_InRangeProcess_MinData+0
	TBLRD*+
	MOVFF       TABLAT+0, FARG_InRangeProcess_MinData+1
	CALL        _InRangeProcess+0, 0
;Spcsystem.c,2000 :: 		}
L_ConflictCorrection480:
;Spcsystem.c,2002 :: 		if(OutOfRanged[1])
	MOVF        ConflictCorrection_OutOfRanged_L0+1, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_ConflictCorrection481
;Spcsystem.c,2004 :: 		index = ConflictCheckList[i].SpecialNum;
	MOVLW       6
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        ConflictCorrection_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       _ConflictCheckList+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ConflictCheckList+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(_ConflictCheckList+0)
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
	MOVFF       TABLAT+0, FARG_OutRangeProcess_index+0
;Spcsystem.c,2005 :: 		Address = 1+ConflictCheckList[i].ParaMenAdress*2+sizeof(SPCSETPIONTS);
	MOVF        R0, 0 
	MOVWF       TBLPTRL 
	MOVF        R1, 0 
	MOVWF       TBLPTRH 
	MOVF        R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R3
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	RLCF        R1, 1 
	BCF         R0, 0 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FARG_OutRangeProcess_Address+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FARG_OutRangeProcess_Address+1 
	MOVLW       88
	ADDWF       FARG_OutRangeProcess_Address+0, 1 
	MOVLW       0
	ADDWFC      FARG_OutRangeProcess_Address+1, 1 
;Spcsystem.c,2006 :: 		OutRangeProcess(index, Address, Ptr[1]);
	MOVF        ConflictCorrection_Ptr_L0+2, 0 
	MOVWF       FARG_OutRangeProcess_Ptr+0 
	MOVF        ConflictCorrection_Ptr_L0+3, 0 
	MOVWF       FARG_OutRangeProcess_Ptr+1 
	CALL        _OutRangeProcess+0, 0
;Spcsystem.c,2007 :: 		}
	GOTO        L_ConflictCorrection482
L_ConflictCorrection481:
;Spcsystem.c,2010 :: 		index = ConflictCheckList[i].SpecialNum;
	MOVLW       6
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        ConflictCorrection_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       _ConflictCheckList+0
	ADDWF       R0, 0 
	MOVWF       R4 
	MOVLW       hi_addr(_ConflictCheckList+0)
	ADDWFC      R1, 0 
	MOVWF       R5 
	MOVLW       higher_addr(_ConflictCheckList+0)
	ADDWFC      R2, 0 
	MOVWF       R6 
	MOVLW       5
	ADDWF       R4, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R5, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R6, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_InRangeProcess_index+0
;Spcsystem.c,2011 :: 		Address = 1+ConflictCheckList[i].ParaMenAdress*2+sizeof(SPCSETPIONTS);
	MOVF        R4, 0 
	MOVWF       TBLPTRL 
	MOVF        R5, 0 
	MOVWF       TBLPTRH 
	MOVF        R6, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R3
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	RLCF        R1, 1 
	BCF         R0, 0 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FARG_InRangeProcess_Address+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FARG_InRangeProcess_Address+1 
	MOVLW       88
	ADDWF       FARG_InRangeProcess_Address+0, 1 
	MOVLW       0
	ADDWFC      FARG_InRangeProcess_Address+1, 1 
;Spcsystem.c,2012 :: 		InRangeProcess(index, Address, Ptr[1], 1, ConflictCheckList[i].MaxPara, ConflictCheckList[i].MinPara);
	MOVF        ConflictCorrection_Ptr_L0+2, 0 
	MOVWF       FARG_InRangeProcess_Ptr+0 
	MOVF        ConflictCorrection_Ptr_L0+3, 0 
	MOVWF       FARG_InRangeProcess_Ptr+1 
	MOVLW       1
	MOVWF       FARG_InRangeProcess_ChannelNum+0 
	MOVLW       1
	ADDWF       R4, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R5, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R6, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_InRangeProcess_MaxData+0
	TBLRD*+
	MOVFF       TABLAT+0, FARG_InRangeProcess_MaxData+1
	MOVLW       3
	ADDWF       R4, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R5, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R6, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_InRangeProcess_MinData+0
	TBLRD*+
	MOVFF       TABLAT+0, FARG_InRangeProcess_MinData+1
	CALL        _InRangeProcess+0, 0
;Spcsystem.c,2013 :: 		}
L_ConflictCorrection482:
;Spcsystem.c,1983 :: 		for(i=0;i<20;i++)
	INCF        ConflictCorrection_i_L0+0, 1 
;Spcsystem.c,2014 :: 		}
	GOTO        L_ConflictCorrection476
L_ConflictCorrection477:
;Spcsystem.c,2017 :: 		EEPROM_get(Address,sizeof(SYSTEM_VALUEB),(unsigned char*)&FlagBuff[0]);
	MOVLW       85
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+1 
	MOVLW       4
	MOVWF       FARG_EEPROM_get_Len+0 
	MOVLW       ConflictCorrection_FlagBuff_L0+0
	MOVWF       FARG_EEPROM_get_readbuffer+0 
	MOVLW       hi_addr(ConflictCorrection_FlagBuff_L0+0)
	MOVWF       FARG_EEPROM_get_readbuffer+1 
	CALL        _EEPROM_get+0, 0
;Spcsystem.c,2019 :: 		EEPROM_get(Address,sizeof(SYSTEM_VALUEB),(unsigned char*)&FlagBuff[1]);
	MOVLW       173
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+1 
	MOVLW       4
	MOVWF       FARG_EEPROM_get_Len+0 
	MOVLW       ConflictCorrection_FlagBuff_L0+4
	MOVWF       FARG_EEPROM_get_readbuffer+0 
	MOVLW       hi_addr(ConflictCorrection_FlagBuff_L0+4)
	MOVWF       FARG_EEPROM_get_readbuffer+1 
	CALL        _EEPROM_get+0, 0
;Spcsystem.c,2020 :: 		if(pSPCValue[0].SPCSetPoints.system_valueb.bite.rtd_opr > 5)
	MOVLW       112
	ANDWF       _pSPCValue+138, 0 
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
	SUBLW       5
	BTFSC       STATUS+0, 0 
	GOTO        L_ConflictCorrection483
;Spcsystem.c,2023 :: 		if(FlagBuff[0].bite.rtd_opr > 5)
	MOVLW       112
	ANDWF       ConflictCorrection_FlagBuff_L0+0, 0 
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
	SUBLW       5
	BTFSC       STATUS+0, 0 
	GOTO        L_ConflictCorrection484
;Spcsystem.c,2025 :: 		pSPCValue[0].SPCSetPoints.system_valueb.bite.rtd_opr = ONE_RTD_MOD;
	MOVLW       143
	ANDWF       _pSPCValue+138, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _pSPCValue+138 
;Spcsystem.c,2026 :: 		}
	GOTO        L_ConflictCorrection485
L_ConflictCorrection484:
;Spcsystem.c,2029 :: 		pSPCValue[0].SPCSetPoints.system_valueb.bite.rtd_opr = FlagBuff[0].bite.rtd_opr;
	MOVLW       112
	ANDWF       ConflictCorrection_FlagBuff_L0+0, 0 
	MOVWF       R2 
	RRCF        R2, 1 
	BCF         R2, 7 
	RRCF        R2, 1 
	BCF         R2, 7 
	RRCF        R2, 1 
	BCF         R2, 7 
	RRCF        R2, 1 
	BCF         R2, 7 
	MOVLW       4
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       R1 
	MOVF        R2, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__ConflictCorrection684:
	BZ          L__ConflictCorrection685
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__ConflictCorrection684
L__ConflictCorrection685:
	MOVF        _pSPCValue+138, 0 
	XORWF       R0, 1 
	MOVLW       112
	ANDWF       R0, 1 
	MOVF        _pSPCValue+138, 0 
	XORWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _pSPCValue+138 
;Spcsystem.c,2030 :: 		}
L_ConflictCorrection485:
;Spcsystem.c,2031 :: 		}
L_ConflictCorrection483:
;Spcsystem.c,2033 :: 		if(pSPCValue[0].SPCSetPoints.system_valueb.bite.def_display > 2)
	MOVLW       12
	ANDWF       _pSPCValue+139, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	MOVF        R1, 0 
	SUBLW       2
	BTFSC       STATUS+0, 0 
	GOTO        L_ConflictCorrection486
;Spcsystem.c,2035 :: 		if(FlagBuff[0].bite.def_display > 2)
	MOVLW       12
	ANDWF       ConflictCorrection_FlagBuff_L0+1, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	MOVF        R1, 0 
	SUBLW       2
	BTFSC       STATUS+0, 0 
	GOTO        L_ConflictCorrection487
;Spcsystem.c,2037 :: 		pSPCValue[0].SPCSetPoints.system_valueb.bite.def_display = SYSTEM_STATUS_MOD;
	MOVLW       243
	ANDWF       _pSPCValue+139, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _pSPCValue+139 
;Spcsystem.c,2038 :: 		}
	GOTO        L_ConflictCorrection488
L_ConflictCorrection487:
;Spcsystem.c,2041 :: 		pSPCValue[0].SPCSetPoints.system_valueb.bite.def_display = FlagBuff[0].bite.def_display;
	MOVLW       12
	ANDWF       ConflictCorrection_FlagBuff_L0+1, 0 
	MOVWF       R2 
	RRCF        R2, 1 
	BCF         R2, 7 
	RRCF        R2, 1 
	BCF         R2, 7 
	MOVLW       2
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       R1 
	MOVF        R2, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__ConflictCorrection686:
	BZ          L__ConflictCorrection687
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__ConflictCorrection686
L__ConflictCorrection687:
	MOVF        _pSPCValue+139, 0 
	XORWF       R0, 1 
	MOVLW       12
	ANDWF       R0, 1 
	MOVF        _pSPCValue+139, 0 
	XORWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _pSPCValue+139 
;Spcsystem.c,2042 :: 		}
L_ConflictCorrection488:
;Spcsystem.c,2043 :: 		}
L_ConflictCorrection486:
;Spcsystem.c,2045 :: 		if(pSPCValue[0].SPCSetPoints.system_valueb.bite.gfi_test_mod > 2)
	MOVLW       3
	ANDWF       _pSPCValue+140, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	SUBLW       2
	BTFSC       STATUS+0, 0 
	GOTO        L_ConflictCorrection489
;Spcsystem.c,2048 :: 		if(FlagBuff[0].bite.gfi_test_mod > 2)
	MOVLW       3
	ANDWF       ConflictCorrection_FlagBuff_L0+2, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	SUBLW       2
	BTFSC       STATUS+0, 0 
	GOTO        L_ConflictCorrection490
;Spcsystem.c,2050 :: 		pSPCValue[0].SPCSetPoints.system_valueb.bite.gfi_test_mod = GFI_TEST_DISABLE;
	MOVLW       2
	XORWF       _pSPCValue+140, 0 
	MOVWF       R0 
	MOVLW       3
	ANDWF       R0, 1 
	MOVF        _pSPCValue+140, 0 
	XORWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _pSPCValue+140 
;Spcsystem.c,2051 :: 		}
	GOTO        L_ConflictCorrection491
L_ConflictCorrection490:
;Spcsystem.c,2054 :: 		pSPCValue[0].SPCSetPoints.system_valueb.bite.gfi_test_mod = FlagBuff[0].bite.gfi_test_mod;
	MOVLW       3
	ANDWF       ConflictCorrection_FlagBuff_L0+2, 0 
	MOVWF       R0 
	MOVF        _pSPCValue+140, 0 
	XORWF       R0, 1 
	MOVLW       3
	ANDWF       R0, 1 
	MOVF        _pSPCValue+140, 0 
	XORWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _pSPCValue+140 
;Spcsystem.c,2055 :: 		}
L_ConflictCorrection491:
;Spcsystem.c,2056 :: 		}
L_ConflictCorrection489:
;Spcsystem.c,2058 :: 		if(pSPCValue[1].SPCSetPoints.system_valueb.bite.gfi_test_mod > 2)
	MOVLW       3
	ANDWF       _pSPCValue+282, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	SUBLW       2
	BTFSC       STATUS+0, 0 
	GOTO        L_ConflictCorrection492
;Spcsystem.c,2061 :: 		if(FlagBuff[1].bite.gfi_test_mod > 2)
	MOVLW       3
	ANDWF       ConflictCorrection_FlagBuff_L0+6, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	SUBLW       2
	BTFSC       STATUS+0, 0 
	GOTO        L_ConflictCorrection493
;Spcsystem.c,2063 :: 		pSPCValue[1].SPCSetPoints.system_valueb.bite.gfi_test_mod = GFI_TEST_DISABLE;
	MOVLW       2
	XORWF       _pSPCValue+282, 0 
	MOVWF       R0 
	MOVLW       3
	ANDWF       R0, 1 
	MOVF        _pSPCValue+282, 0 
	XORWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _pSPCValue+282 
;Spcsystem.c,2064 :: 		}
	GOTO        L_ConflictCorrection494
L_ConflictCorrection493:
;Spcsystem.c,2067 :: 		pSPCValue[1].SPCSetPoints.system_valueb.bite.gfi_test_mod = FlagBuff[1].bite.gfi_test_mod;
	MOVLW       3
	ANDWF       ConflictCorrection_FlagBuff_L0+6, 0 
	MOVWF       R0 
	MOVF        _pSPCValue+282, 0 
	XORWF       R0, 1 
	MOVLW       3
	ANDWF       R0, 1 
	MOVF        _pSPCValue+282, 0 
	XORWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _pSPCValue+282 
;Spcsystem.c,2068 :: 		}
L_ConflictCorrection494:
;Spcsystem.c,2069 :: 		}
L_ConflictCorrection492:
;Spcsystem.c,2071 :: 		if(pSPCValue[0].SPCSetPoints.system_valueb.bite.baud > 4)
	MOVLW       112
	ANDWF       _pSPCValue+139, 0 
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
	SUBLW       4
	BTFSC       STATUS+0, 0 
	GOTO        L_ConflictCorrection495
;Spcsystem.c,2073 :: 		if(FlagBuff[0].bite.baud > 4)
	MOVLW       112
	ANDWF       ConflictCorrection_FlagBuff_L0+1, 0 
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
	SUBLW       4
	BTFSC       STATUS+0, 0 
	GOTO        L_ConflictCorrection496
;Spcsystem.c,2075 :: 		pSPCValue[0].SPCSetPoints.system_valueb.bite.baud = BAUDRATE_9600;
	MOVLW       48
	XORWF       _pSPCValue+139, 0 
	MOVWF       R0 
	MOVLW       112
	ANDWF       R0, 1 
	MOVF        _pSPCValue+139, 0 
	XORWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _pSPCValue+139 
;Spcsystem.c,2076 :: 		}
	GOTO        L_ConflictCorrection497
L_ConflictCorrection496:
;Spcsystem.c,2079 :: 		pSPCValue[0].SPCSetPoints.system_valueb.bite.baud = FlagBuff[0].bite.baud;
	MOVLW       112
	ANDWF       ConflictCorrection_FlagBuff_L0+1, 0 
	MOVWF       R2 
	RRCF        R2, 1 
	BCF         R2, 7 
	RRCF        R2, 1 
	BCF         R2, 7 
	RRCF        R2, 1 
	BCF         R2, 7 
	RRCF        R2, 1 
	BCF         R2, 7 
	MOVLW       4
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       R1 
	MOVF        R2, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__ConflictCorrection688:
	BZ          L__ConflictCorrection689
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__ConflictCorrection688
L__ConflictCorrection689:
	MOVF        _pSPCValue+139, 0 
	XORWF       R0, 1 
	MOVLW       112
	ANDWF       R0, 1 
	MOVF        _pSPCValue+139, 0 
	XORWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _pSPCValue+139 
;Spcsystem.c,2080 :: 		}
L_ConflictCorrection497:
;Spcsystem.c,2081 :: 		BaudChanged=1;
	MOVLW       1
	MOVWF       ConflictCorrection_BaudChanged_L0+0 
;Spcsystem.c,2082 :: 		}
	GOTO        L_ConflictCorrection498
L_ConflictCorrection495:
;Spcsystem.c,2085 :: 		if(pSPCValue[0].SPCSetPoints.system_valueb.bite.baud != FlagBuff[0].bite.baud)
	MOVLW       112
	ANDWF       _pSPCValue+139, 0 
	MOVWF       R2 
	RRCF        R2, 1 
	BCF         R2, 7 
	RRCF        R2, 1 
	BCF         R2, 7 
	RRCF        R2, 1 
	BCF         R2, 7 
	RRCF        R2, 1 
	BCF         R2, 7 
	MOVLW       112
	ANDWF       ConflictCorrection_FlagBuff_L0+1, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	MOVF        R2, 0 
	XORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_ConflictCorrection499
;Spcsystem.c,2087 :: 		BaudChanged=1;
	MOVLW       1
	MOVWF       ConflictCorrection_BaudChanged_L0+0 
;Spcsystem.c,2088 :: 		}
L_ConflictCorrection499:
;Spcsystem.c,2089 :: 		}
L_ConflictCorrection498:
;Spcsystem.c,2090 :: 		if(BaudChanged)
	MOVF        ConflictCorrection_BaudChanged_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_ConflictCorrection500
;Spcsystem.c,2092 :: 		Uart_initial();
	CALL        _Uart_initial+0, 0
;Spcsystem.c,2093 :: 		}
L_ConflictCorrection500:
;Spcsystem.c,2095 :: 		if(pSPCValue[0].SPCSetPoints.system_valueb.bite.heater_type==1)      //SR
	BTFSS       _pSPCValue+139, 7 
	GOTO        L_ConflictCorrection501
;Spcsystem.c,2097 :: 		if(pSPCValue[0].SPCSetPoints.LimitedCurrent != SPC_SYSTEMVALUE_OFF)
	MOVF        _pSPCValue+83, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__ConflictCorrection690
	MOVLW       255
	XORWF       _pSPCValue+82, 0 
L__ConflictCorrection690:
	BTFSC       STATUS+0, 2 
	GOTO        L_ConflictCorrection502
;Spcsystem.c,2099 :: 		pSPCValue[0].SPCSetPoints.LimitedCurrent = SPC_SYSTEMVALUE_OFF;
	MOVLW       255
	MOVWF       _pSPCValue+82 
	MOVLW       127
	MOVWF       _pSPCValue+83 
;Spcsystem.c,2100 :: 		}
L_ConflictCorrection502:
;Spcsystem.c,2101 :: 		if(pSPCValue[0].SPCSetPoints.system_valueb.bite.ctl_type != 0)
	BTFSS       _pSPCValue+138, 3 
	GOTO        L_ConflictCorrection503
;Spcsystem.c,2103 :: 		pSPCValue[0].SPCSetPoints.system_valueb.bite.ctl_type = 0;
	BCF         _pSPCValue+138, 3 
;Spcsystem.c,2104 :: 		}
L_ConflictCorrection503:
;Spcsystem.c,2105 :: 		}
L_ConflictCorrection501:
;Spcsystem.c,2107 :: 		if(pSPCValue[1].SPCSetPoints.system_valueb.bite.heater_type==1)      //SR
	BTFSS       _pSPCValue+281, 7 
	GOTO        L_ConflictCorrection504
;Spcsystem.c,2109 :: 		if(pSPCValue[1].SPCSetPoints.LimitedCurrent != SPC_SYSTEMVALUE_OFF)
	MOVF        _pSPCValue+225, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__ConflictCorrection691
	MOVLW       255
	XORWF       _pSPCValue+224, 0 
L__ConflictCorrection691:
	BTFSC       STATUS+0, 2 
	GOTO        L_ConflictCorrection505
;Spcsystem.c,2111 :: 		pSPCValue[1].SPCSetPoints.LimitedCurrent = SPC_SYSTEMVALUE_OFF;
	MOVLW       255
	MOVWF       _pSPCValue+224 
	MOVLW       127
	MOVWF       _pSPCValue+225 
;Spcsystem.c,2112 :: 		}
L_ConflictCorrection505:
;Spcsystem.c,2113 :: 		if(pSPCValue[1].SPCSetPoints.system_valueb.bite.ctl_type != 0)
	BTFSS       _pSPCValue+280, 3 
	GOTO        L_ConflictCorrection506
;Spcsystem.c,2115 :: 		pSPCValue[1].SPCSetPoints.system_valueb.bite.ctl_type = 0;
	BCF         _pSPCValue+280, 3 
;Spcsystem.c,2116 :: 		}
L_ConflictCorrection506:
;Spcsystem.c,2117 :: 		}
L_ConflictCorrection504:
;Spcsystem.c,2119 :: 		if(FlagBuff[0].bite.def_display != pSPCValue[0].SPCSetPoints.system_valueb.bite.def_display)
	MOVLW       12
	ANDWF       ConflictCorrection_FlagBuff_L0+1, 0 
	MOVWF       R2 
	RRCF        R2, 1 
	BCF         R2, 7 
	RRCF        R2, 1 
	BCF         R2, 7 
	MOVLW       12
	ANDWF       _pSPCValue+139, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	MOVF        R2, 0 
	XORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_ConflictCorrection507
;Spcsystem.c,2121 :: 		if(spc_system_flag.bite.default_diaped == 1)
	BTFSS       _spc_system_flag+1, 2 
	GOTO        L_ConflictCorrection508
;Spcsystem.c,2123 :: 		spc_system_flag.bite.stat_update = 1;
	BSF         _spc_system_flag+3, 7 
;Spcsystem.c,2124 :: 		disp_default();
	CALL        _disp_default+0, 0
;Spcsystem.c,2125 :: 		}
L_ConflictCorrection508:
;Spcsystem.c,2126 :: 		}
L_ConflictCorrection507:
;Spcsystem.c,2130 :: 		Savedata(MAINTAIN_FLASH_LACAL,
	CLRF        FARG_Savedata_flash_lacl+0 
	CLRF        FARG_Savedata_flash_lacl+1 
;Spcsystem.c,2131 :: 		sizeof(SPCSETPIONTS),
	MOVLW       88
	MOVWF       FARG_Savedata_len+0 
	MOVLW       0
	MOVWF       FARG_Savedata_len+1 
;Spcsystem.c,2132 :: 		(UCHAR *)(&pSPCValue[0].SPCSetPoints),
	MOVLW       _pSPCValue+54
	MOVWF       FARG_Savedata_ptr+0 
	MOVLW       hi_addr(_pSPCValue+54)
	MOVWF       FARG_Savedata_ptr+1 
;Spcsystem.c,2133 :: 		0);
	CLRF        FARG_Savedata_cmd+0 
	CALL        _Savedata+0, 0
;Spcsystem.c,2134 :: 		Savedata(MAINTAIN_FLASH_LACAL+sizeof(SPCSETPIONTS),
	MOVLW       88
	MOVWF       FARG_Savedata_flash_lacl+0 
	MOVLW       0
	MOVWF       FARG_Savedata_flash_lacl+1 
;Spcsystem.c,2135 :: 		sizeof(SPCSETPIONTS),
	MOVLW       88
	MOVWF       FARG_Savedata_len+0 
	MOVLW       0
	MOVWF       FARG_Savedata_len+1 
;Spcsystem.c,2136 :: 		(UCHAR *)(&pSPCValue[1].SPCSetPoints),
	MOVLW       _pSPCValue+196
	MOVWF       FARG_Savedata_ptr+0 
	MOVLW       hi_addr(_pSPCValue+196)
	MOVWF       FARG_Savedata_ptr+1 
;Spcsystem.c,2137 :: 		0);
	CLRF        FARG_Savedata_cmd+0 
	CALL        _Savedata+0, 0
;Spcsystem.c,2138 :: 		}
L_ConflictCorrection475:
;Spcsystem.c,2140 :: 		for(i=0;i<2;i++)
	CLRF        ConflictCorrection_i_L0+0 
L_ConflictCorrection509:
	MOVLW       2
	SUBWF       ConflictCorrection_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_ConflictCorrection510
;Spcsystem.c,2142 :: 		if(CtrlTypeCheck[i] != pSPCValue[i].SPCSetPoints.system_valueb.bite.ctl_type)
	MOVLW       _CtrlTypeCheck+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_CtrlTypeCheck+0)
	MOVWF       FSR0H 
	MOVF        ConflictCorrection_i_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__ConflictCorrection+0 
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        ConflictCorrection_i_L0+0, 0 
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
	CLRF        R1 
	BTFSC       R0, 3 
	INCF        R1, 1 
	MOVF        FLOC__ConflictCorrection+0, 0 
	XORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_ConflictCorrection512
;Spcsystem.c,2144 :: 		CtrlTypeCheck[i] = pSPCValue[i].SPCSetPoints.system_valueb.bite.ctl_type;
	MOVLW       _CtrlTypeCheck+0
	MOVWF       FLOC__ConflictCorrection+0 
	MOVLW       hi_addr(_CtrlTypeCheck+0)
	MOVWF       FLOC__ConflictCorrection+1 
	MOVF        ConflictCorrection_i_L0+0, 0 
	ADDWF       FLOC__ConflictCorrection+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__ConflictCorrection+1, 1 
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        ConflictCorrection_i_L0+0, 0 
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
	MOVFF       FLOC__ConflictCorrection+0, FSR1
	MOVFF       FLOC__ConflictCorrection+1, FSR1H
	MOVLW       0
	BTFSC       R0, 3 
	MOVLW       1
	MOVWF       POSTINC1+0 
;Spcsystem.c,2145 :: 		if(CtrlTypeCheck[i])   //PI
	MOVLW       _CtrlTypeCheck+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_CtrlTypeCheck+0)
	MOVWF       FSR0H 
	MOVF        ConflictCorrection_i_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_ConflictCorrection513
;Spcsystem.c,2147 :: 		asm nop;
	NOP
;Spcsystem.c,2148 :: 		Spcssr[0].SSR_cmd = 0;
	CLRF        _Spcssr+0 
;Spcsystem.c,2149 :: 		Spcssr[0].SSR_stat = 0;
	CLRF        _Spcssr+1 
;Spcsystem.c,2150 :: 		}
L_ConflictCorrection513:
;Spcsystem.c,2151 :: 		}
L_ConflictCorrection512:
;Spcsystem.c,2153 :: 		if(PowerLimitCheck[i] != pSPCValue[i].SPCSetPoints.LimitedCurrent)
	MOVF        ConflictCorrection_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _PowerLimitCheck+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_PowerLimitCheck+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__ConflictCorrection+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__ConflictCorrection+1 
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        ConflictCorrection_i_L0+0, 0 
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
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVF        FLOC__ConflictCorrection+1, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ConflictCorrection692
	MOVF        R1, 0 
	XORWF       FLOC__ConflictCorrection+0, 0 
L__ConflictCorrection692:
	BTFSC       STATUS+0, 2 
	GOTO        L_ConflictCorrection514
;Spcsystem.c,2155 :: 		PowerLimitCheck[i] = pSPCValue[i].SPCSetPoints.LimitedCurrent;
	MOVF        ConflictCorrection_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _PowerLimitCheck+0
	ADDWF       R0, 0 
	MOVWF       FLOC__ConflictCorrection+0 
	MOVLW       hi_addr(_PowerLimitCheck+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__ConflictCorrection+1 
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        ConflictCorrection_i_L0+0, 0 
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
	MOVFF       FLOC__ConflictCorrection+0, FSR1
	MOVFF       FLOC__ConflictCorrection+1, FSR1H
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,2156 :: 		if(pSPCValue[i].SPCSetPoints.system_valueb.bite.ctl_type == 0)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        ConflictCorrection_i_L0+0, 0 
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
	GOTO        L_ConflictCorrection515
;Spcsystem.c,2158 :: 		if(Spcssr[i].SSR_stat == 1)
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        ConflictCorrection_i_L0+0, 0 
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
	GOTO        L_ConflictCorrection516
;Spcsystem.c,2160 :: 		if(PowerLimitCheck[i] == SPC_SYSTEMVALUE_OFF)
	MOVF        ConflictCorrection_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _PowerLimitCheck+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_PowerLimitCheck+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__ConflictCorrection693
	MOVLW       255
	XORWF       R1, 0 
L__ConflictCorrection693:
	BTFSS       STATUS+0, 2 
	GOTO        L_ConflictCorrection517
;Spcsystem.c,2162 :: 		duty_index[i] = 10;
	MOVF        ConflictCorrection_i_L0+0, 0 
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
;Spcsystem.c,2163 :: 		ShapeForDuty = duty_index[i]*10;
	MOVF        ConflictCorrection_i_L0+0, 0 
	MOVWF       FLOC__ConflictCorrection+0 
	MOVLW       0
	MOVWF       FLOC__ConflictCorrection+1 
	RLCF        FLOC__ConflictCorrection+0, 1 
	BCF         FLOC__ConflictCorrection+0, 0 
	RLCF        FLOC__ConflictCorrection+1, 1 
	MOVLW       _duty_index+0
	ADDWF       FLOC__ConflictCorrection+0, 0 
	MOVWF       FLOC__ConflictCorrection+2 
	MOVLW       hi_addr(_duty_index+0)
	ADDWFC      FLOC__ConflictCorrection+1, 0 
	MOVWF       FLOC__ConflictCorrection+3 
	MOVFF       FLOC__ConflictCorrection+2, FSR0
	MOVFF       FLOC__ConflictCorrection+3, FSR0H
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
	MOVWF       _ShapeForDuty+0 
	MOVF        R1, 0 
	MOVWF       _ShapeForDuty+1 
;Spcsystem.c,2164 :: 		pwm_duty[i] = get_duty_table(duty_index[i]);
	MOVLW       _pwm_duty+0
	ADDWF       FLOC__ConflictCorrection+0, 1 
	MOVLW       hi_addr(_pwm_duty+0)
	ADDWFC      FLOC__ConflictCorrection+1, 1 
	MOVFF       FLOC__ConflictCorrection+2, FSR0
	MOVFF       FLOC__ConflictCorrection+3, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_get_duty_table_index+0 
	CALL        _get_duty_table+0, 0
	MOVFF       FLOC__ConflictCorrection+0, FSR1
	MOVFF       FLOC__ConflictCorrection+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,2165 :: 		SystemUpdate |= (CH1_DUTY_UPDATE_REQ << i);
	MOVF        ConflictCorrection_i_L0+0, 0 
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
L__ConflictCorrection694:
	BZ          L__ConflictCorrection695
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__ConflictCorrection694
L__ConflictCorrection695:
	MOVF        R0, 0 
	IORWF       _SystemUpdate+0, 1 
	MOVF        R1, 0 
	IORWF       _SystemUpdate+1, 1 
	MOVF        R2, 0 
	IORWF       _SystemUpdate+2, 1 
	MOVF        R3, 0 
	IORWF       _SystemUpdate+3, 1 
;Spcsystem.c,2166 :: 		SetIntStr((int*)&ShapeForDuty, CH1_ACTURAL_DUTY+i, UNIT_AMPER_PERCENT, 1);
	MOVLW       _ShapeForDuty+0
	MOVWF       FARG_SetIntStr_ptr+0 
	MOVLW       hi_addr(_ShapeForDuty+0)
	MOVWF       FARG_SetIntStr_ptr+1 
	MOVF        ConflictCorrection_i_L0+0, 0 
	ADDLW       18
	MOVWF       FARG_SetIntStr_strlocat+0 
	MOVLW       9
	MOVWF       FARG_SetIntStr_unitlocar+0 
	MOVLW       1
	MOVWF       FARG_SetIntStr_len+0 
	CALL        _SetIntStr+0, 0
;Spcsystem.c,2167 :: 		}
	GOTO        L_ConflictCorrection518
L_ConflictCorrection517:
;Spcsystem.c,2170 :: 		if(Spcpwm[i].pwm_cmd == 0)
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        ConflictCorrection_i_L0+0, 0 
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
	GOTO        L_ConflictCorrection519
;Spcsystem.c,2172 :: 		asm nop;
	NOP
;Spcsystem.c,2173 :: 		Spcpwm[i].pwm_cmd = 1;
	MOVLW       11
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        ConflictCorrection_i_L0+0, 0 
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
;Spcsystem.c,2174 :: 		}
L_ConflictCorrection519:
;Spcsystem.c,2176 :: 		if(duty_index[i] != pSPCValue[i].SPCSetPoints.LimitedCurrent/10)
	MOVF        ConflictCorrection_i_L0+0, 0 
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
	MOVWF       FLOC__ConflictCorrection+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__ConflictCorrection+1 
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        ConflictCorrection_i_L0+0, 0 
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
	MOVF        FLOC__ConflictCorrection+1, 0 
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ConflictCorrection696
	MOVF        R0, 0 
	XORWF       FLOC__ConflictCorrection+0, 0 
L__ConflictCorrection696:
	BTFSC       STATUS+0, 2 
	GOTO        L_ConflictCorrection520
;Spcsystem.c,2178 :: 		duty_index[i] = pSPCValue[i].SPCSetPoints.LimitedCurrent/10;
	MOVF        ConflictCorrection_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _duty_index+0
	ADDWF       R0, 0 
	MOVWF       FLOC__ConflictCorrection+0 
	MOVLW       hi_addr(_duty_index+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__ConflictCorrection+1 
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        ConflictCorrection_i_L0+0, 0 
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
	MOVFF       FLOC__ConflictCorrection+0, FSR1
	MOVFF       FLOC__ConflictCorrection+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,2179 :: 		pwm_duty[i] = get_duty_table(duty_index[i]);
	MOVF        ConflictCorrection_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pwm_duty+0
	ADDWF       R0, 0 
	MOVWF       FLOC__ConflictCorrection+0 
	MOVLW       hi_addr(_pwm_duty+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__ConflictCorrection+1 
	MOVLW       _duty_index+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_duty_index+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_get_duty_table_index+0 
	CALL        _get_duty_table+0, 0
	MOVFF       FLOC__ConflictCorrection+0, FSR1
	MOVFF       FLOC__ConflictCorrection+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;Spcsystem.c,2180 :: 		SystemUpdate |= (CH1_DUTY_UPDATE_REQ << i);
	MOVF        ConflictCorrection_i_L0+0, 0 
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
L__ConflictCorrection697:
	BZ          L__ConflictCorrection698
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__ConflictCorrection697
L__ConflictCorrection698:
	MOVF        R0, 0 
	IORWF       _SystemUpdate+0, 1 
	MOVF        R1, 0 
	IORWF       _SystemUpdate+1, 1 
	MOVF        R2, 0 
	IORWF       _SystemUpdate+2, 1 
	MOVF        R3, 0 
	IORWF       _SystemUpdate+3, 1 
;Spcsystem.c,2181 :: 		SetIntStr((int*)&pSPCValue[i].SPCSetPoints.LimitedCurrent, CH1_ACTURAL_DUTY+i, UNIT_AMPER_PERCENT, 1);
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        ConflictCorrection_i_L0+0, 0 
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
	MOVLW       54
	ADDWF       FARG_SetIntStr_ptr+0, 1 
	MOVLW       0
	ADDWFC      FARG_SetIntStr_ptr+1, 1 
	MOVLW       28
	ADDWF       FARG_SetIntStr_ptr+0, 1 
	MOVLW       0
	ADDWFC      FARG_SetIntStr_ptr+1, 1 
	MOVF        ConflictCorrection_i_L0+0, 0 
	ADDLW       18
	MOVWF       FARG_SetIntStr_strlocat+0 
	MOVLW       9
	MOVWF       FARG_SetIntStr_unitlocar+0 
	MOVLW       1
	MOVWF       FARG_SetIntStr_len+0 
	CALL        _SetIntStr+0, 0
;Spcsystem.c,2182 :: 		}
L_ConflictCorrection520:
;Spcsystem.c,2183 :: 		}
L_ConflictCorrection518:
;Spcsystem.c,2184 :: 		}
L_ConflictCorrection516:
;Spcsystem.c,2185 :: 		}
L_ConflictCorrection515:
;Spcsystem.c,2186 :: 		}
L_ConflictCorrection514:
;Spcsystem.c,2140 :: 		for(i=0;i<2;i++)
	INCF        ConflictCorrection_i_L0+0, 1 
;Spcsystem.c,2187 :: 		}
	GOTO        L_ConflictCorrection509
L_ConflictCorrection510:
;Spcsystem.c,2189 :: 		if(AlarmNumCheck != pSPCAlarm.spcalarms.num_alarms)
	MOVF        _AlarmNumCheck+0, 0 
	XORWF       _pSPCAlarm+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_ConflictCorrection521
;Spcsystem.c,2191 :: 		if(AlarmNumCheck > pSPCAlarm.spcalarms.num_alarms)
	MOVF        _AlarmNumCheck+0, 0 
	SUBWF       _pSPCAlarm+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_ConflictCorrection522
;Spcsystem.c,2193 :: 		for(i=pSPCAlarm.spcalarms.num_alarms; i<20; i++)
	MOVF        _pSPCAlarm+0, 0 
	MOVWF       ConflictCorrection_i_L0+0 
L_ConflictCorrection523:
	MOVLW       20
	SUBWF       ConflictCorrection_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_ConflictCorrection524
;Spcsystem.c,2195 :: 		pSPCAlarm.spcalarms.alarm_typ[i] = 0;
	MOVF        ConflictCorrection_i_L0+0, 0 
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
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;Spcsystem.c,2193 :: 		for(i=pSPCAlarm.spcalarms.num_alarms; i<20; i++)
	INCF        ConflictCorrection_i_L0+0, 1 
;Spcsystem.c,2196 :: 		}
	GOTO        L_ConflictCorrection523
L_ConflictCorrection524:
;Spcsystem.c,2197 :: 		}
L_ConflictCorrection522:
;Spcsystem.c,2198 :: 		AlarmNumCheck = pSPCAlarm.spcalarms.num_alarms;
	MOVF        _pSPCAlarm+0, 0 
	MOVWF       _AlarmNumCheck+0 
;Spcsystem.c,2199 :: 		}
L_ConflictCorrection521:
;Spcsystem.c,2200 :: 		}
L_end_ConflictCorrection:
	RETURN      0
; end of _ConflictCorrection
