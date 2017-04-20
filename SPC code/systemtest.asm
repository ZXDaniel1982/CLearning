
_systemtest:

;systemtest.c,28 :: 		void systemtest(char ChannelNum)
;systemtest.c,33 :: 		if(pSPCValue[ChannelNum].SPCSetPoints.AlarmOutTest == SPC_SYSTEMVALUE_DISABLE)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
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
	GOTO        L__systemtest56
	MOVLW       252
	XORWF       R1, 0 
L__systemtest56:
	BTFSS       STATUS+0, 2 
	GOTO        L_systemtest0
;systemtest.c,37 :: 		AlarmForce[ChannelNum] = ALARMSSR_OK;
	MOVLW       _AlarmForce+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_AlarmForce+0)
	MOVWF       FSR1H 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;systemtest.c,38 :: 		AlarmTestCmd[ChannelNum] = ALARM_TEST_IDLE;
	MOVLW       _AlarmTestCmd+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_AlarmTestCmd+0)
	MOVWF       FSR1H 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;systemtest.c,39 :: 		AlarmTestCount[ChannelNum] = 0;
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _AlarmTestCount+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_AlarmTestCount+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;systemtest.c,40 :: 		}
	GOTO        L_systemtest1
L_systemtest0:
;systemtest.c,41 :: 		else if(pSPCValue[ChannelNum].SPCSetPoints.AlarmOutTest == SPC_SYSTEMVALUE_CONTINU)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
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
	GOTO        L__systemtest57
	MOVLW       253
	XORWF       R1, 0 
L__systemtest57:
	BTFSS       STATUS+0, 2 
	GOTO        L_systemtest2
;systemtest.c,45 :: 		AlarmForce[ChannelNum] = FORCE_ALARMSSR_ON;
	MOVLW       _AlarmForce+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_AlarmForce+0)
	MOVWF       FSR1H 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       1
	MOVWF       POSTINC1+0 
;systemtest.c,46 :: 		AlarmTestCmd[ChannelNum] = ALARM_TEST_IDLE;
	MOVLW       _AlarmTestCmd+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_AlarmTestCmd+0)
	MOVWF       FSR1H 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;systemtest.c,47 :: 		AlarmTestCount[ChannelNum] = 0;
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _AlarmTestCount+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_AlarmTestCount+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;systemtest.c,48 :: 		}
	GOTO        L_systemtest3
L_systemtest2:
;systemtest.c,51 :: 		if(AlarmTestCmd[ChannelNum] == ALARM_TEST_IDLE)
	MOVLW       _AlarmTestCmd+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_AlarmTestCmd+0)
	MOVWF       FSR0H 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_systemtest4
;systemtest.c,53 :: 		AlarmForce[ChannelNum] = FORCE_ALARMSSR_ON;
	MOVLW       _AlarmForce+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_AlarmForce+0)
	MOVWF       FSR1H 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       1
	MOVWF       POSTINC1+0 
;systemtest.c,54 :: 		AlarmTestCmd[ChannelNum] = ALARM_TEST_START;
	MOVLW       _AlarmTestCmd+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_AlarmTestCmd+0)
	MOVWF       FSR1H 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       2
	MOVWF       POSTINC1+0 
;systemtest.c,55 :: 		AlarmTestCount[ChannelNum] = 0;
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _AlarmTestCount+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_AlarmTestCount+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;systemtest.c,58 :: 		}
	GOTO        L_systemtest5
L_systemtest4:
;systemtest.c,59 :: 		else if(AlarmTestCmd[ChannelNum] == ALARM_TEST_END)
	MOVLW       _AlarmTestCmd+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_AlarmTestCmd+0)
	MOVWF       FSR0H 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_systemtest6
;systemtest.c,61 :: 		AlarmTestCmd[ChannelNum] = ALARM_TEST_IDLE;
	MOVLW       _AlarmTestCmd+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_AlarmTestCmd+0)
	MOVWF       FSR1H 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;systemtest.c,62 :: 		AlarmForce[ChannelNum] = ALARMSSR_OK;
	MOVLW       _AlarmForce+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_AlarmForce+0)
	MOVWF       FSR1H 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;systemtest.c,63 :: 		pSPCValue[ChannelNum].SPCSetPoints.AlarmOutTest = SPC_SYSTEMVALUE_DISABLE;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
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
;systemtest.c,65 :: 		Savedata(SYSTEMFLAG_FLASH_LACAL+ChannelNum*sizeof(SPCSETPIONTS),
	MOVLW       88
	MULWF       FARG_systemtest_ChannelNum+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVLW       84
	ADDWF       R0, 0 
	MOVWF       FARG_Savedata_flash_lacl+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FARG_Savedata_flash_lacl+1 
;systemtest.c,66 :: 		sizeof(SYSTEM_VALUEB),
	MOVLW       4
	MOVWF       FARG_Savedata_len+0 
	MOVLW       0
	MOVWF       FARG_Savedata_len+1 
;systemtest.c,67 :: 		(UCHAR *)(&pSPCValue[ChannelNum].SPCSetPoints.system_valueb),
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
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
	MOVLW       84
	ADDWF       FARG_Savedata_ptr+0, 1 
	MOVLW       0
	ADDWFC      FARG_Savedata_ptr+1, 1 
;systemtest.c,68 :: 		0);
	CLRF        FARG_Savedata_cmd+0 
	CALL        _Savedata+0, 0
;systemtest.c,69 :: 		}
L_systemtest6:
L_systemtest5:
;systemtest.c,70 :: 		}
L_systemtest3:
L_systemtest1:
;systemtest.c,73 :: 		if(pSPCValue[ChannelNum].SPCSetPoints.HeaterTest == SPC_SYSTEMVALUE_CONTINU)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
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
	GOTO        L__systemtest58
	MOVLW       253
	XORWF       R1, 0 
L__systemtest58:
	BTFSS       STATUS+0, 2 
	GOTO        L_systemtest7
;systemtest.c,75 :: 		ForceSSRONCondition[ChannelNum] |= HEATERTESTFORCEON;
	MOVLW       _ForceSSRONCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSRONCondition+0)
	MOVWF       R2 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
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
;systemtest.c,76 :: 		}
	GOTO        L_systemtest8
L_systemtest7:
;systemtest.c,77 :: 		else if(pSPCValue[ChannelNum].SPCSetPoints.HeaterTest == SPC_SYSTEMVALUE_DISABLE)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
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
	GOTO        L__systemtest59
	MOVLW       252
	XORWF       R1, 0 
L__systemtest59:
	BTFSS       STATUS+0, 2 
	GOTO        L_systemtest9
;systemtest.c,79 :: 		ForceSSRONCondition[ChannelNum] &= ~HEATERTESTFORCEON;
	MOVLW       _ForceSSRONCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSRONCondition+0)
	MOVWF       R2 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
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
;systemtest.c,80 :: 		}
	GOTO        L_systemtest10
L_systemtest9:
;systemtest.c,83 :: 		if(HeaterTestCmd[ChannelNum] == 0)                                      //(spc_system_flag.bite.heatest_req == 0)
	MOVLW       _HeaterTestCmd+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_HeaterTestCmd+0)
	MOVWF       FSR0H 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_systemtest11
;systemtest.c,86 :: 		ForceSSRONCondition[ChannelNum] |= HEATERTESTFORCEON;
	MOVLW       _ForceSSRONCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSRONCondition+0)
	MOVWF       R2 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
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
;systemtest.c,87 :: 		HeaterTestCount[ChannelNum] = 0;
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _HeaterTestCount+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_HeaterTestCount+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;systemtest.c,88 :: 		HeaterTestCmd[ChannelNum] = 1;
	MOVLW       _HeaterTestCmd+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_HeaterTestCmd+0)
	MOVWF       FSR1H 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       1
	MOVWF       POSTINC1+0 
;systemtest.c,93 :: 		}
	GOTO        L_systemtest12
L_systemtest11:
;systemtest.c,94 :: 		else if(HeaterTestCmd[ChannelNum] == 2)                                      //(spc_system_flag.bite.heatest_reach)
	MOVLW       _HeaterTestCmd+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_HeaterTestCmd+0)
	MOVWF       FSR0H 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_systemtest13
;systemtest.c,97 :: 		ForceSSRONCondition[ChannelNum] &= ~HEATERTESTFORCEON;
	MOVLW       _ForceSSRONCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSRONCondition+0)
	MOVWF       R2 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
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
;systemtest.c,99 :: 		HeaterTestCmd[ChannelNum] = 0;
	MOVLW       _HeaterTestCmd+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_HeaterTestCmd+0)
	MOVWF       FSR1H 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;systemtest.c,100 :: 		pSPCValue[ChannelNum].SPCSetPoints.HeaterTest = SPC_SYSTEMVALUE_DISABLE;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
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
;systemtest.c,101 :: 		Savedata(SYSTEMFLAG_FLASH_LACAL+ChannelNum*sizeof(SPCSETPIONTS),
	MOVLW       88
	MULWF       FARG_systemtest_ChannelNum+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVLW       84
	ADDWF       R0, 0 
	MOVWF       FARG_Savedata_flash_lacl+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FARG_Savedata_flash_lacl+1 
;systemtest.c,102 :: 		sizeof(SYSTEM_VALUEB),
	MOVLW       4
	MOVWF       FARG_Savedata_len+0 
	MOVLW       0
	MOVWF       FARG_Savedata_len+1 
;systemtest.c,103 :: 		(UCHAR *)(&pSPCValue[ChannelNum].SPCSetPoints.system_valueb),
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
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
	MOVLW       84
	ADDWF       FARG_Savedata_ptr+0, 1 
	MOVLW       0
	ADDWFC      FARG_Savedata_ptr+1, 1 
;systemtest.c,104 :: 		0);
	CLRF        FARG_Savedata_cmd+0 
	CALL        _Savedata+0, 0
;systemtest.c,105 :: 		}
L_systemtest13:
L_systemtest12:
;systemtest.c,106 :: 		}
L_systemtest10:
L_systemtest8:
;systemtest.c,109 :: 		if(pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.gfi_test_mod == GFI_TEST_NOW)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
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
	MOVF        R1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_systemtest14
;systemtest.c,111 :: 		if(GFITestCmd[ChannelNum] == 0)
	MOVLW       _GFITestCmd+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_GFITestCmd+0)
	MOVWF       FSR0H 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_systemtest15
;systemtest.c,113 :: 		ForceSSRONCondition[ChannelNum] |= GFITESTFORCEON;
	MOVLW       _ForceSSRONCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSRONCondition+0)
	MOVWF       R2 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
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
;systemtest.c,114 :: 		if(ChannelNum == CHANNEL1)
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_systemtest16
;systemtest.c,115 :: 		LATF2_bit = 1;
	BSF         LATF2_bit+0, BitPos(LATF2_bit+0) 
	GOTO        L_systemtest17
L_systemtest16:
;systemtest.c,116 :: 		else if(ChannelNum == CHANNEL2)
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_systemtest18
;systemtest.c,117 :: 		LATF1_bit = 1;
	BSF         LATF1_bit+0, BitPos(LATF1_bit+0) 
L_systemtest18:
L_systemtest17:
;systemtest.c,119 :: 		GFITestCmd[ChannelNum] = 1;
	MOVLW       _GFITestCmd+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_GFITestCmd+0)
	MOVWF       FSR1H 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       1
	MOVWF       POSTINC1+0 
;systemtest.c,120 :: 		GFITestCount[ChannelNum] = 0;
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _GFITestCount+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_GFITestCount+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;systemtest.c,121 :: 		KeyEn = 0;
	CLRF        _KeyEn+0 
;systemtest.c,122 :: 		}
	GOTO        L_systemtest19
L_systemtest15:
;systemtest.c,123 :: 		else if(GFITestCmd[ChannelNum] == 2)
	MOVLW       _GFITestCmd+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_GFITestCmd+0)
	MOVWF       FSR0H 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_systemtest20
;systemtest.c,125 :: 		if(Cable_Channel == CHANNEL1)
	MOVF        _Cable_Channel+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_systemtest21
;systemtest.c,126 :: 		LATF2_bit = 0;
	BCF         LATF2_bit+0, BitPos(LATF2_bit+0) 
	GOTO        L_systemtest22
L_systemtest21:
;systemtest.c,127 :: 		else if(Cable_Channel == CHANNEL2)
	MOVF        _Cable_Channel+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_systemtest23
;systemtest.c,128 :: 		LATF1_bit = 0;
	BCF         LATF1_bit+0, BitPos(LATF1_bit+0) 
L_systemtest23:
L_systemtest22:
;systemtest.c,130 :: 		ForceSSRONCondition[ChannelNum] &= ~GFITESTFORCEON;
	MOVLW       _ForceSSRONCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSRONCondition+0)
	MOVWF       R2 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
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
;systemtest.c,131 :: 		ForceSSROFFCondition[ChannelNum] &= ~GFITRIPFORCEOFF;
	MOVLW       _ForceSSROFFCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSROFFCondition+0)
	MOVWF       R2 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
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
;systemtest.c,132 :: 		if(GFITestPass[ChannelNum])
	MOVLW       _GFITestPass+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_GFITestPass+0)
	MOVWF       FSR0H 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_systemtest24
;systemtest.c,134 :: 		GFITestPass[ChannelNum] = 0;
	MOVLW       _GFITestPass+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_GFITestPass+0)
	MOVWF       FSR1H 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;systemtest.c,135 :: 		for(i=0; i<16; i++)
	CLRF        systemtest_i_L0+0 
L_systemtest25:
	MOVLW       16
	SUBWF       systemtest_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_systemtest26
;systemtest.c,136 :: 		Info_Line2[i] = GFITestPassStr[i];
	MOVLW       _Info_Line2+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FSR1H 
	MOVF        systemtest_i_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       _GFITestPassStr+0
	ADDWF       systemtest_i_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_GFITestPassStr+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_GFITestPassStr+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;systemtest.c,135 :: 		for(i=0; i<16; i++)
	INCF        systemtest_i_L0+0, 1 
;systemtest.c,136 :: 		Info_Line2[i] = GFITestPassStr[i];
	GOTO        L_systemtest25
L_systemtest26:
;systemtest.c,137 :: 		}
	GOTO        L_systemtest28
L_systemtest24:
;systemtest.c,140 :: 		for(i=0; i<16; i++)
	CLRF        systemtest_i_L0+0 
L_systemtest29:
	MOVLW       16
	SUBWF       systemtest_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_systemtest30
;systemtest.c,141 :: 		Info_Line2[i] = GFITestFailStr[i];
	MOVLW       _Info_Line2+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FSR1H 
	MOVF        systemtest_i_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       _GFITestFailStr+0
	ADDWF       systemtest_i_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_GFITestFailStr+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_GFITestFailStr+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;systemtest.c,140 :: 		for(i=0; i<16; i++)
	INCF        systemtest_i_L0+0, 1 
;systemtest.c,141 :: 		Info_Line2[i] = GFITestFailStr[i];
	GOTO        L_systemtest29
L_systemtest30:
;systemtest.c,142 :: 		if(!(ActivedAlarms & (CH1_GFITESTFAIL << ChannelNum)))
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       4
	MOVWF       R3 
	MOVF        R4, 0 
L__systemtest60:
	BZ          L__systemtest61
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__systemtest60
L__systemtest61:
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
	GOTO        L_systemtest32
;systemtest.c,143 :: 		alarmoperate(CH1_GFITESTFAIL << ChannelNum,ENALARM);
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       4
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVF        R0, 0 
L__systemtest62:
	BZ          L__systemtest63
	RLCF        FARG_alarmoperate_alarmcommand+0, 1 
	BCF         FARG_alarmoperate_alarmcommand+0, 0 
	RLCF        FARG_alarmoperate_alarmcommand+1, 1 
	RLCF        FARG_alarmoperate_alarmcommand+2, 1 
	RLCF        FARG_alarmoperate_alarmcommand+3, 1 
	ADDLW       255
	GOTO        L__systemtest62
L__systemtest63:
	MOVLW       1
	MOVWF       FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_systemtest32:
;systemtest.c,144 :: 		}
L_systemtest28:
;systemtest.c,145 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
;systemtest.c,146 :: 		Delay_ms(2000);
	MOVLW       51
	MOVWF       R11, 0
	MOVLW       187
	MOVWF       R12, 0
	MOVLW       223
	MOVWF       R13, 0
L_systemtest33:
	DECFSZ      R13, 1, 1
	BRA         L_systemtest33
	DECFSZ      R12, 1, 1
	BRA         L_systemtest33
	DECFSZ      R11, 1, 1
	BRA         L_systemtest33
	NOP
	NOP
;systemtest.c,147 :: 		GFITestCmd[ChannelNum] = 0;
	MOVLW       _GFITestCmd+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_GFITestCmd+0)
	MOVWF       FSR1H 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;systemtest.c,148 :: 		pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.gfi_test_mod = GFI_TEST_DISABLE;
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
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
;systemtest.c,149 :: 		Savedata(SYSTEMFLAG_FLASH_LACAL+ChannelNum*sizeof(SPCSETPIONTS),
	MOVLW       88
	MULWF       FARG_systemtest_ChannelNum+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVLW       84
	ADDWF       R0, 0 
	MOVWF       FARG_Savedata_flash_lacl+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FARG_Savedata_flash_lacl+1 
;systemtest.c,150 :: 		sizeof(SYSTEM_VALUEB),
	MOVLW       4
	MOVWF       FARG_Savedata_len+0 
	MOVLW       0
	MOVWF       FARG_Savedata_len+1 
;systemtest.c,151 :: 		(UCHAR *)(&pSPCValue[ChannelNum].SPCSetPoints.system_valueb),
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
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
	MOVLW       84
	ADDWF       FARG_Savedata_ptr+0, 1 
	MOVLW       0
	ADDWFC      FARG_Savedata_ptr+1, 1 
;systemtest.c,152 :: 		0);
	CLRF        FARG_Savedata_cmd+0 
	CALL        _Savedata+0, 0
;systemtest.c,153 :: 		for(i=0; i<16; i++)
	CLRF        systemtest_i_L0+0 
L_systemtest34:
	MOVLW       16
	SUBWF       systemtest_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_systemtest35
;systemtest.c,154 :: 		Info_Line2[i] = ParaChar[DISABLE_STR][i];
	MOVLW       _Info_Line2+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FSR1H 
	MOVF        systemtest_i_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       systemtest_ParaChar+1309
	ADDWF       systemtest_i_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(systemtest_ParaChar+1309)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(systemtest_ParaChar+1309)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;systemtest.c,153 :: 		for(i=0; i<16; i++)
	INCF        systemtest_i_L0+0, 1 
;systemtest.c,154 :: 		Info_Line2[i] = ParaChar[DISABLE_STR][i];
	GOTO        L_systemtest34
L_systemtest35:
;systemtest.c,155 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
;systemtest.c,156 :: 		KeyEn = 1;
	MOVLW       1
	MOVWF       _KeyEn+0 
;systemtest.c,157 :: 		}
L_systemtest20:
L_systemtest19:
;systemtest.c,158 :: 		}
L_systemtest14:
;systemtest.c,161 :: 		if(spc_system_flag.bite.autotest_req == RUNNING)
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
	GOTO        L_systemtest37
;systemtest.c,163 :: 		if(pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.gfi_test_mod != GFI_TEST_AUTO)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
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
	MOVF        R1, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_systemtest38
;systemtest.c,164 :: 		ForceSSRONCondition[ChannelNum] |= AUTOTESTFORCEON;
	MOVLW       _ForceSSRONCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSRONCondition+0)
	MOVWF       R2 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
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
	GOTO        L_systemtest39
L_systemtest38:
;systemtest.c,167 :: 		ForceSSRONCondition[ChannelNum] &= ~AUTOTESTFORCEON;
	MOVLW       _ForceSSRONCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSRONCondition+0)
	MOVWF       R2 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
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
;systemtest.c,168 :: 		spc_system_flag.bite.autotest_req = DONES;
	MOVLW       32
	XORWF       _spc_system_flag+3, 0 
	MOVWF       R0 
	MOVLW       48
	ANDWF       R0, 1 
	MOVF        _spc_system_flag+3, 0 
	XORWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _spc_system_flag+3 
;systemtest.c,169 :: 		spc_count.AutoTest_last_count = 0;
	CLRF        _spc_count+19 
	CLRF        _spc_count+20 
;systemtest.c,170 :: 		}
L_systemtest39:
;systemtest.c,171 :: 		}
	GOTO        L_systemtest40
L_systemtest37:
;systemtest.c,172 :: 		else if(spc_system_flag.bite.autotest_req == DONES)
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
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_systemtest41
;systemtest.c,174 :: 		spc_system_flag.bite.autotest_req = IDEL;
	MOVLW       207
	ANDWF       _spc_system_flag+3, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _spc_system_flag+3 
;systemtest.c,175 :: 		if(pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.gfi_test_mod != GFI_TEST_AUTO)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
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
	MOVF        R1, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_systemtest42
;systemtest.c,177 :: 		asm nop;
	NOP
;systemtest.c,178 :: 		Spcssr[ChannelNum].SSR_cmd = 0;
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
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
;systemtest.c,179 :: 		if(!(ActivedAlarms & AUTOTESTALARM))
	BTFSC       _ActivedAlarms+3, 5 
	GOTO        L_systemtest43
;systemtest.c,181 :: 		if(ActivedAlarms)
	MOVF        _ActivedAlarms+0, 0 
	IORWF       _ActivedAlarms+1, 0 
	IORWF       _ActivedAlarms+2, 0 
	IORWF       _ActivedAlarms+3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_systemtest44
;systemtest.c,182 :: 		alarmoperate(AUTOTESTALARM,ENALARM);
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       32
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVLW       1
	MOVWF       FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_systemtest44:
;systemtest.c,183 :: 		}
L_systemtest43:
;systemtest.c,184 :: 		ForceSSRONCondition[ChannelNum] &= ~AUTOTESTFORCEON;
	MOVLW       _ForceSSRONCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSRONCondition+0)
	MOVWF       R2 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
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
;systemtest.c,185 :: 		}         //if(pSPCValue.SPCSetPoints.system_valueb.bite.gfi_test_mod == GFI_TEST_AUTO)
	GOTO        L_systemtest45
L_systemtest42:
;systemtest.c,188 :: 		if(pSPCValue[ChannelNum].SPCSetPoints.GFITrip != SPC_SYSTEMVALUE_OFF)
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
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
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__systemtest64
	MOVLW       255
	XORWF       R1, 0 
L__systemtest64:
	BTFSC       STATUS+0, 2 
	GOTO        L_systemtest46
;systemtest.c,190 :: 		if(GFITestCmd == 0)
	CLRF        R1 
	CLRF        R2 
	MOVLW       hi_addr(_GFITestCmd+0)
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__systemtest65
	MOVF        R1, 0 
	XORLW       _GFITestCmd+0
L__systemtest65:
	BTFSS       STATUS+0, 2 
	GOTO        L_systemtest47
;systemtest.c,192 :: 		LATF2_bit = 1;
	BSF         LATF2_bit+0, BitPos(LATF2_bit+0) 
;systemtest.c,193 :: 		ForceSSRONCondition[ChannelNum] |= AUTOTESTFORCEON;
	MOVLW       _ForceSSRONCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSRONCondition+0)
	MOVWF       R2 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
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
;systemtest.c,194 :: 		GFITestCmd[ChannelNum] = 1;
	MOVLW       _GFITestCmd+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_GFITestCmd+0)
	MOVWF       FSR1H 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       1
	MOVWF       POSTINC1+0 
;systemtest.c,195 :: 		GFITestCount[ChannelNum] = 0;
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _GFITestCount+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_GFITestCount+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;systemtest.c,196 :: 		AutoGFITestEN[ChannelNum] = 1;
	MOVLW       _AutoGFITestEN+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_AutoGFITestEN+0)
	MOVWF       FSR1H 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       1
	MOVWF       POSTINC1+0 
;systemtest.c,197 :: 		}
L_systemtest47:
;systemtest.c,198 :: 		}
	GOTO        L_systemtest48
L_systemtest46:
;systemtest.c,201 :: 		LATF2_bit = 0;
	BCF         LATF2_bit+0, BitPos(LATF2_bit+0) 
;systemtest.c,202 :: 		GFITestCmd[ChannelNum] = 0;
	MOVLW       _GFITestCmd+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_GFITestCmd+0)
	MOVWF       FSR1H 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;systemtest.c,203 :: 		GFITestCount[ChannelNum] = 0;
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _GFITestCount+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_GFITestCount+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;systemtest.c,204 :: 		AutoGFITestEN[ChannelNum] = 0;
	MOVLW       _AutoGFITestEN+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_AutoGFITestEN+0)
	MOVWF       FSR1H 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;systemtest.c,205 :: 		ForceSSRONCondition[ChannelNum] &= ~AUTOTESTFORCEON;
	MOVLW       _ForceSSRONCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSRONCondition+0)
	MOVWF       R2 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
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
;systemtest.c,206 :: 		ForceSSROFFCondition[ChannelNum] &= ~GFITRIPFORCEOFF;
	MOVLW       _ForceSSROFFCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSROFFCondition+0)
	MOVWF       R2 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
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
;systemtest.c,207 :: 		}
L_systemtest48:
;systemtest.c,208 :: 		}
L_systemtest45:
;systemtest.c,209 :: 		}
L_systemtest41:
L_systemtest40:
;systemtest.c,211 :: 		if(AutoGFITestEN)
	MOVLW       _AutoGFITestEN+0
	MOVWF       R0 
	MOVLW       hi_addr(_AutoGFITestEN+0)
	MOVWF       R1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_systemtest49
;systemtest.c,213 :: 		if(GFITestCmd[ChannelNum] == 2)
	MOVLW       _GFITestCmd+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_GFITestCmd+0)
	MOVWF       FSR0H 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_systemtest50
;systemtest.c,215 :: 		LATF2_bit = 0;
	BCF         LATF2_bit+0, BitPos(LATF2_bit+0) 
;systemtest.c,216 :: 		AutoGFITestEN[ChannelNum] = 0;
	MOVLW       _AutoGFITestEN+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_AutoGFITestEN+0)
	MOVWF       FSR1H 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;systemtest.c,217 :: 		GFITestCmd[ChannelNum] = 0;
	MOVLW       _GFITestCmd+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_GFITestCmd+0)
	MOVWF       FSR1H 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;systemtest.c,218 :: 		if(AutoGFITestPass[ChannelNum])   //fail
	MOVLW       _AutoGFITestPass+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_AutoGFITestPass+0)
	MOVWF       FSR0H 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_systemtest51
;systemtest.c,219 :: 		AutoGFITestPass[ChannelNum] = 0;
	MOVLW       _AutoGFITestPass+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_AutoGFITestPass+0)
	MOVWF       FSR1H 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
	GOTO        L_systemtest52
L_systemtest51:
;systemtest.c,222 :: 		if(!(ActivedAlarms & AUTOTESTALARM))
	BTFSC       _ActivedAlarms+3, 5 
	GOTO        L_systemtest53
;systemtest.c,224 :: 		if(ActivedAlarms)
	MOVF        _ActivedAlarms+0, 0 
	IORWF       _ActivedAlarms+1, 0 
	IORWF       _ActivedAlarms+2, 0 
	IORWF       _ActivedAlarms+3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_systemtest54
;systemtest.c,225 :: 		alarmoperate(AUTOTESTALARM,ENALARM);
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       32
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVLW       1
	MOVWF       FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_systemtest54:
;systemtest.c,226 :: 		}
L_systemtest53:
;systemtest.c,227 :: 		}
L_systemtest52:
;systemtest.c,228 :: 		ForceSSRONCondition[ChannelNum] &= ~AUTOTESTFORCEON;
	MOVLW       _ForceSSRONCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSRONCondition+0)
	MOVWF       R2 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
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
;systemtest.c,229 :: 		ForceSSROFFCondition[ChannelNum] &= ~GFITRIPFORCEOFF;
	MOVLW       _ForceSSROFFCondition+0
	MOVWF       R1 
	MOVLW       hi_addr(_ForceSSROFFCondition+0)
	MOVWF       R2 
	MOVF        FARG_systemtest_ChannelNum+0, 0 
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
;systemtest.c,230 :: 		}
L_systemtest50:
;systemtest.c,231 :: 		}
L_systemtest49:
;systemtest.c,232 :: 		}
L_end_systemtest:
	RETURN      0
; end of _systemtest
