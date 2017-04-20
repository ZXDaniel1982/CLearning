
_getRegisterAddr:

;modbus.c,201 :: 		int* getRegisterAddr(char RegisterAdrr)
;modbus.c,205 :: 		if(RegisterAdrr < 44)
	MOVLW       44
	SUBWF       FARG_getRegisterAddr_RegisterAdrr+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_getRegisterAddr0
;modbus.c,207 :: 		ret = (int *)&pSPCValue[Cable_Channel].SPCSetPoints;
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
	MOVWF       getRegisterAddr_ret_L0+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       getRegisterAddr_ret_L0+1 
	MOVLW       54
	ADDWF       getRegisterAddr_ret_L0+0, 1 
	MOVLW       0
	ADDWFC      getRegisterAddr_ret_L0+1, 1 
;modbus.c,208 :: 		ret += RegisterAdrr;
	MOVF        FARG_getRegisterAddr_RegisterAdrr+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       getRegisterAddr_ret_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      getRegisterAddr_ret_L0+1, 1 
;modbus.c,209 :: 		}
	GOTO        L_getRegisterAddr1
L_getRegisterAddr0:
;modbus.c,210 :: 		else if(RegisterAdrr < 56)
	MOVLW       56
	SUBWF       FARG_getRegisterAddr_RegisterAdrr+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_getRegisterAddr2
;modbus.c,212 :: 		ret = (int *)&pSPCValue[Cable_Channel].SPCActual;
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
	MOVWF       getRegisterAddr_ret_L0+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       getRegisterAddr_ret_L0+1 
;modbus.c,213 :: 		ret += (RegisterAdrr-44);
	MOVLW       44
	SUBWF       FARG_getRegisterAddr_RegisterAdrr+0, 0 
	MOVWF       R3 
	CLRF        R4 
	MOVLW       0
	SUBWFB      R4, 1 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       getRegisterAddr_ret_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      getRegisterAddr_ret_L0+1, 1 
;modbus.c,214 :: 		}
	GOTO        L_getRegisterAddr3
L_getRegisterAddr2:
;modbus.c,215 :: 		else if(RegisterAdrr < 70)
	MOVLW       70
	SUBWF       FARG_getRegisterAddr_RegisterAdrr+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_getRegisterAddr4
;modbus.c,217 :: 		ret = (int *)&pSPCValue[Cable_Channel].SPCStatistics;
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
	MOVWF       getRegisterAddr_ret_L0+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       getRegisterAddr_ret_L0+1 
	MOVLW       24
	ADDWF       getRegisterAddr_ret_L0+0, 1 
	MOVLW       0
	ADDWFC      getRegisterAddr_ret_L0+1, 1 
;modbus.c,218 :: 		ret += (RegisterAdrr-56);
	MOVLW       56
	SUBWF       FARG_getRegisterAddr_RegisterAdrr+0, 0 
	MOVWF       R3 
	CLRF        R4 
	MOVLW       0
	SUBWFB      R4, 1 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       getRegisterAddr_ret_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      getRegisterAddr_ret_L0+1, 1 
;modbus.c,219 :: 		}
	GOTO        L_getRegisterAddr5
L_getRegisterAddr4:
;modbus.c,220 :: 		else if(RegisterAdrr < 90)
	MOVLW       90
	SUBWF       FARG_getRegisterAddr_RegisterAdrr+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_getRegisterAddr6
;modbus.c,222 :: 		ret = (int *)&pSPCAlarm.spcalarms.alarm_typ;
	MOVLW       _pSPCAlarm+1
	MOVWF       getRegisterAddr_ret_L0+0 
	MOVLW       hi_addr(_pSPCAlarm+1)
	MOVWF       getRegisterAddr_ret_L0+1 
;modbus.c,223 :: 		ret += (RegisterAdrr-70);
	MOVLW       70
	SUBWF       FARG_getRegisterAddr_RegisterAdrr+0, 0 
	MOVWF       R3 
	CLRF        R4 
	MOVLW       0
	SUBWFB      R4, 1 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       getRegisterAddr_ret_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      getRegisterAddr_ret_L0+1, 1 
;modbus.c,224 :: 		}
	GOTO        L_getRegisterAddr7
L_getRegisterAddr6:
;modbus.c,225 :: 		else if(RegisterAdrr == 90)
	MOVF        FARG_getRegisterAddr_RegisterAdrr+0, 0 
	XORLW       90
	BTFSS       STATUS+0, 2 
	GOTO        L_getRegisterAddr8
;modbus.c,228 :: 		}
L_getRegisterAddr8:
L_getRegisterAddr7:
L_getRegisterAddr5:
L_getRegisterAddr3:
L_getRegisterAddr1:
;modbus.c,230 :: 		return ret;
	MOVF        getRegisterAddr_ret_L0+0, 0 
	MOVWF       R0 
	MOVF        getRegisterAddr_ret_L0+1, 0 
	MOVWF       R1 
;modbus.c,231 :: 		}
L_end_getRegisterAddr:
	RETURN      0
; end of _getRegisterAddr

_SetErrorMessage:

;modbus.c,233 :: 		char SetErrorMessage(char *ptr, char errortype)
;modbus.c,236 :: 		char len=0;
	CLRF        SetErrorMessage_len_L0+0 
;modbus.c,238 :: 		*(ptr++) = 1;
	MOVFF       FARG_SetErrorMessage_ptr+0, FSR1
	MOVFF       FARG_SetErrorMessage_ptr+1, FSR1H
	MOVLW       1
	MOVWF       POSTINC1+0 
	INFSNZ      FARG_SetErrorMessage_ptr+0, 1 
	INCF        FARG_SetErrorMessage_ptr+1, 1 
;modbus.c,239 :: 		len++;
	INCF        SetErrorMessage_len_L0+0, 1 
;modbus.c,240 :: 		*(ptr++) = 1;
	MOVFF       FARG_SetErrorMessage_ptr+0, FSR1
	MOVFF       FARG_SetErrorMessage_ptr+1, FSR1H
	MOVLW       1
	MOVWF       POSTINC1+0 
	INFSNZ      FARG_SetErrorMessage_ptr+0, 1 
	INCF        FARG_SetErrorMessage_ptr+1, 1 
;modbus.c,241 :: 		len++;
	INCF        SetErrorMessage_len_L0+0, 1 
;modbus.c,242 :: 		*(ptr++) = errortype;
	MOVFF       FARG_SetErrorMessage_ptr+0, FSR1
	MOVFF       FARG_SetErrorMessage_ptr+1, FSR1H
	MOVF        FARG_SetErrorMessage_errortype+0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      FARG_SetErrorMessage_ptr+0, 1 
	INCF        FARG_SetErrorMessage_ptr+1, 1 
;modbus.c,243 :: 		len++;
	INCF        SetErrorMessage_len_L0+0, 1 
;modbus.c,245 :: 		crc_temp =  CRCChecksum(ptr, 3);
	MOVF        FARG_SetErrorMessage_ptr+0, 0 
	MOVWF       FARG_CRCChecksum_chkbuf+0 
	MOVF        FARG_SetErrorMessage_ptr+1, 0 
	MOVWF       FARG_CRCChecksum_chkbuf+1 
	MOVLW       3
	MOVWF       FARG_CRCChecksum_len+0 
	CALL        _CRCChecksum+0, 0
	MOVF        R0, 0 
	MOVWF       SetErrorMessage_crc_temp_L0+0 
	MOVF        R1, 0 
	MOVWF       SetErrorMessage_crc_temp_L0+1 
;modbus.c,246 :: 		*(ptr++) = (crc_temp >> 8) & 0xff;
	MOVF        R1, 0 
	MOVWF       R2 
	CLRF        R3 
	MOVLW       255
	ANDWF       R2, 0 
	MOVWF       R0 
	MOVFF       FARG_SetErrorMessage_ptr+0, FSR1
	MOVFF       FARG_SetErrorMessage_ptr+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      FARG_SetErrorMessage_ptr+0, 1 
	INCF        FARG_SetErrorMessage_ptr+1, 1 
;modbus.c,247 :: 		len++;
	INCF        SetErrorMessage_len_L0+0, 1 
;modbus.c,248 :: 		*ptr = crc_temp & 0xff;
	MOVLW       255
	ANDWF       SetErrorMessage_crc_temp_L0+0, 0 
	MOVWF       R0 
	MOVFF       FARG_SetErrorMessage_ptr+0, FSR1
	MOVFF       FARG_SetErrorMessage_ptr+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;modbus.c,249 :: 		len++;
	INCF        SetErrorMessage_len_L0+0, 1 
;modbus.c,251 :: 		return len;
	MOVF        SetErrorMessage_len_L0+0, 0 
	MOVWF       R0 
;modbus.c,252 :: 		}
L_end_SetErrorMessage:
	RETURN      0
; end of _SetErrorMessage

_modbusprocess:

;modbus.c,254 :: 		void modbusprocess()
;modbus.c,258 :: 		char i,j, ErrorDetected=0;
	CLRF        modbusprocess_ErrorDetected_L0+0 
	CLRF        modbusprocess_ParameterChanged_L0+0 
;modbus.c,265 :: 		CommunicationErrorCheck();
	CALL        _CommunicationErrorCheck+0, 0
;modbus.c,267 :: 		if(ModbusValid == 0)
	MOVF        _ModbusValid+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_modbusprocess9
;modbus.c,268 :: 		return;
	GOTO        L_end_modbusprocess
L_modbusprocess9:
;modbus.c,269 :: 		ModbusValid = 0;
	CLRF        _ModbusValid+0 
;modbus.c,270 :: 		RC1IE_bit = 0;
	BCF         RC1IE_bit+0, BitPos(RC1IE_bit+0) 
;modbus.c,273 :: 		modbus_txn = 0;
	CLRF        _modbus_txn+0 
	CLRF        _modbus_txn+1 
;modbus.c,274 :: 		index = (((UINT)(modbus_rcdata[2]) << 8) | modbus_rcdata[3]);
	MOVF        _modbus_rcdata+2, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        _modbus_rcdata+3, 0 
	IORWF       R0, 0 
	MOVWF       modbusprocess_index_L0+0 
	MOVF        R1, 0 
	MOVWF       modbusprocess_index_L0+1 
	MOVLW       0
	IORWF       modbusprocess_index_L0+1, 1 
;modbus.c,275 :: 		length = (((UINT)(modbus_rcdata[4]) << 8) | modbus_rcdata[5]);
	MOVF        _modbus_rcdata+4, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        _modbus_rcdata+5, 0 
	IORWF       R0, 0 
	MOVWF       modbusprocess_length_L0+0 
	MOVF        R1, 0 
	MOVWF       modbusprocess_length_L0+1 
	MOVLW       0
	IORWF       modbusprocess_length_L0+1, 1 
;modbus.c,276 :: 		crc_rx = (((unsigned int)(modbus_rcdata[modbus_rcn-2]) << 8) | modbus_rcdata[modbus_rcn-1]);
	MOVLW       2
	SUBWF       _modbus_rcn+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      _modbus_rcn+1, 0 
	MOVWF       R1 
	MOVLW       _modbus_rcdata+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_modbus_rcdata+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        R4, 0 
	MOVWF       R3 
	CLRF        R2 
	MOVLW       1
	SUBWF       _modbus_rcn+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      _modbus_rcn+1, 0 
	MOVWF       R1 
	MOVLW       _modbus_rcdata+0
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       hi_addr(_modbus_rcdata+0)
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	IORWF       R2, 0 
	MOVWF       modbusprocess_crc_rx_L0+0 
	MOVF        R3, 0 
	MOVWF       modbusprocess_crc_rx_L0+1 
	MOVLW       0
	IORWF       modbusprocess_crc_rx_L0+1, 1 
;modbus.c,278 :: 		if((modbus_rcdata[0] == pSPCValue[Cable_Channel].SPCSetPoints.ModbusAdd) || (modbus_rcdata[0] == 255))
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
	MOVLW       40
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__modbusprocess122
	MOVF        R1, 0 
	XORWF       _modbus_rcdata+0, 0 
L__modbusprocess122:
	BTFSC       STATUS+0, 2 
	GOTO        L__modbusprocess118
	MOVF        _modbus_rcdata+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L__modbusprocess118
	GOTO        L_modbusprocess12
L__modbusprocess118:
;modbus.c,280 :: 		crc_check = CRCChecksum(modbus_rcdata, modbus_rcn-2);
	MOVLW       _modbus_rcdata+0
	MOVWF       FARG_CRCChecksum_chkbuf+0 
	MOVLW       hi_addr(_modbus_rcdata+0)
	MOVWF       FARG_CRCChecksum_chkbuf+1 
	MOVLW       2
	SUBWF       _modbus_rcn+0, 0 
	MOVWF       FARG_CRCChecksum_len+0 
	CALL        _CRCChecksum+0, 0
	MOVF        R0, 0 
	MOVWF       modbusprocess_crc_check_L0+0 
	MOVF        R1, 0 
	MOVWF       modbusprocess_crc_check_L0+1 
;modbus.c,282 :: 		if(crc_check == crc_rx)
	MOVF        modbusprocess_crc_check_L0+1, 0 
	XORWF       modbusprocess_crc_rx_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__modbusprocess123
	MOVF        modbusprocess_crc_rx_L0+0, 0 
	XORWF       modbusprocess_crc_check_L0+0, 0 
L__modbusprocess123:
	BTFSS       STATUS+0, 2 
	GOTO        L_modbusprocess13
;modbus.c,284 :: 		modbus_txdata[modbus_txn] = modbus_rcdata[modbus_txn];                     //0
	MOVLW       _modbus_txdata+0
	ADDWF       _modbus_txn+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_modbus_txdata+0)
	ADDWFC      _modbus_txn+1, 0 
	MOVWF       FSR1H 
	MOVLW       _modbus_rcdata+0
	ADDWF       _modbus_txn+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_modbus_rcdata+0)
	ADDWFC      _modbus_txn+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;modbus.c,285 :: 		modbus_txn++;
	INFSNZ      _modbus_txn+0, 1 
	INCF        _modbus_txn+1, 1 
;modbus.c,286 :: 		modbus_txdata[modbus_txn] = modbus_rcdata[modbus_txn];                     //1
	MOVLW       _modbus_txdata+0
	ADDWF       _modbus_txn+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_modbus_txdata+0)
	ADDWFC      _modbus_txn+1, 0 
	MOVWF       FSR1H 
	MOVLW       _modbus_rcdata+0
	ADDWF       _modbus_txn+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_modbus_rcdata+0)
	ADDWFC      _modbus_txn+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;modbus.c,287 :: 		modbus_txn++;
	INFSNZ      _modbus_txn+0, 1 
	INCF        _modbus_txn+1, 1 
;modbus.c,289 :: 		switch(modbus_rcdata[1])
	GOTO        L_modbusprocess14
;modbus.c,291 :: 		case 0x03:     //¶Ábytes
L_modbusprocess16:
;modbus.c,292 :: 		if(modbus_rcn == 8)
	MOVLW       0
	XORWF       _modbus_rcn+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__modbusprocess124
	MOVLW       8
	XORWF       _modbus_rcn+0, 0 
L__modbusprocess124:
	BTFSS       STATUS+0, 2 
	GOTO        L_modbusprocess17
;modbus.c,294 :: 		modbus_txdata[modbus_txn++] = length*2;
	MOVLW       _modbus_txdata+0
	ADDWF       _modbus_txn+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_modbus_txdata+0)
	ADDWFC      _modbus_txn+1, 0 
	MOVWF       FSR1H 
	MOVF        modbusprocess_length_L0+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      _modbus_txn+0, 1 
	INCF        _modbus_txn+1, 1 
;modbus.c,296 :: 		for(i=0; i<length ;i++)
	CLRF        modbusprocess_i_L0+0 
L_modbusprocess18:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       modbusprocess_length_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__modbusprocess125
	MOVF        modbusprocess_length_L0+0, 0 
	SUBWF       modbusprocess_i_L0+0, 0 
L__modbusprocess125:
	BTFSC       STATUS+0, 0 
	GOTO        L_modbusprocess19
;modbus.c,298 :: 		if(((index+i)>=0) && ((index+i)<104))                         //(((index+i)>0) && ((index+i)<90))
	MOVF        modbusprocess_i_L0+0, 0 
	ADDWF       modbusprocess_index_L0+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      modbusprocess_index_L0+1, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__modbusprocess126
	MOVLW       0
	SUBWF       R1, 0 
L__modbusprocess126:
	BTFSS       STATUS+0, 0 
	GOTO        L_modbusprocess23
	MOVF        modbusprocess_i_L0+0, 0 
	ADDWF       modbusprocess_index_L0+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      modbusprocess_index_L0+1, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__modbusprocess127
	MOVLW       104
	SUBWF       R1, 0 
L__modbusprocess127:
	BTFSC       STATUS+0, 0 
	GOTO        L_modbusprocess23
L__modbusprocess117:
;modbus.c,301 :: 		Ptr = ModbusList[index+i];
	MOVF        modbusprocess_i_L0+0, 0 
	ADDWF       modbusprocess_index_L0+0, 0 
	MOVWF       R3 
	MOVLW       0
	ADDWFC      modbusprocess_index_L0+1, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _ModbusList+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_ModbusList+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       modbusprocess_Ptr_L0+0 
	MOVF        R1, 0 
	MOVWF       modbusprocess_Ptr_L0+1 
;modbus.c,302 :: 		modbus_txdata[modbus_txn++] = (*Ptr>>8) & 0xff;
	MOVLW       _modbus_txdata+0
	ADDWF       _modbus_txn+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_modbus_txdata+0)
	ADDWFC      _modbus_txn+1, 0 
	MOVWF       FSR1H 
	MOVFF       R0, FSR0
	MOVFF       R1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        R4, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       R4, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       255
	ANDWF       R0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      _modbus_txn+0, 1 
	INCF        _modbus_txn+1, 1 
;modbus.c,303 :: 		modbus_txdata[modbus_txn++] = *Ptr & 0xff;
	MOVLW       _modbus_txdata+0
	ADDWF       _modbus_txn+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_modbus_txdata+0)
	ADDWFC      _modbus_txn+1, 0 
	MOVWF       FSR1H 
	MOVFF       modbusprocess_Ptr_L0+0, FSR0
	MOVFF       modbusprocess_Ptr_L0+1, FSR0H
	MOVLW       255
	ANDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      _modbus_txn+0, 1 
	INCF        _modbus_txn+1, 1 
;modbus.c,304 :: 		}
	GOTO        L_modbusprocess24
L_modbusprocess23:
;modbus.c,305 :: 		else if((index+i)<104+40)
	MOVF        modbusprocess_i_L0+0, 0 
	ADDWF       modbusprocess_index_L0+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      modbusprocess_index_L0+1, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__modbusprocess128
	MOVLW       144
	SUBWF       R1, 0 
L__modbusprocess128:
	BTFSC       STATUS+0, 0 
	GOTO        L_modbusprocess25
;modbus.c,307 :: 		Ptr = (int *)&pSPCAlarm.spcalarms.alarm_typ;
	MOVLW       _pSPCAlarm+1
	MOVWF       modbusprocess_Ptr_L0+0 
	MOVLW       hi_addr(_pSPCAlarm+1)
	MOVWF       modbusprocess_Ptr_L0+1 
;modbus.c,308 :: 		modbus_txdata[modbus_txn++] = (*Ptr>>8) & 0xff;
	MOVLW       _modbus_txdata+0
	ADDWF       _modbus_txn+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_modbus_txdata+0)
	ADDWFC      _modbus_txn+1, 0 
	MOVWF       FSR1H 
	MOVFF       modbusprocess_Ptr_L0+0, FSR0
	MOVFF       modbusprocess_Ptr_L0+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        R4, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       R4, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       255
	ANDWF       R0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      _modbus_txn+0, 1 
	INCF        _modbus_txn+1, 1 
;modbus.c,309 :: 		modbus_txdata[modbus_txn++] = *Ptr & 0xff;
	MOVLW       _modbus_txdata+0
	ADDWF       _modbus_txn+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_modbus_txdata+0)
	ADDWFC      _modbus_txn+1, 0 
	MOVWF       FSR1H 
	MOVFF       modbusprocess_Ptr_L0+0, FSR0
	MOVFF       modbusprocess_Ptr_L0+1, FSR0H
	MOVLW       255
	ANDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      _modbus_txn+0, 1 
	INCF        _modbus_txn+1, 1 
;modbus.c,310 :: 		}
	GOTO        L_modbusprocess26
L_modbusprocess25:
;modbus.c,311 :: 		else if((index+i)<104+80)
	MOVF        modbusprocess_i_L0+0, 0 
	ADDWF       modbusprocess_index_L0+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      modbusprocess_index_L0+1, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__modbusprocess129
	MOVLW       184
	SUBWF       R1, 0 
L__modbusprocess129:
	BTFSC       STATUS+0, 0 
	GOTO        L_modbusprocess27
;modbus.c,313 :: 		Ptr = (int *)&pSPCAlarm.spclogs.log_typ;
	MOVLW       _pSPCAlarm+82
	MOVWF       modbusprocess_Ptr_L0+0 
	MOVLW       hi_addr(_pSPCAlarm+82)
	MOVWF       modbusprocess_Ptr_L0+1 
;modbus.c,314 :: 		modbus_txdata[modbus_txn++] = (*Ptr>>8) & 0xff;
	MOVLW       _modbus_txdata+0
	ADDWF       _modbus_txn+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_modbus_txdata+0)
	ADDWFC      _modbus_txn+1, 0 
	MOVWF       FSR1H 
	MOVFF       modbusprocess_Ptr_L0+0, FSR0
	MOVFF       modbusprocess_Ptr_L0+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        R4, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       R4, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       255
	ANDWF       R0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      _modbus_txn+0, 1 
	INCF        _modbus_txn+1, 1 
;modbus.c,315 :: 		modbus_txdata[modbus_txn++] = *Ptr & 0xff;
	MOVLW       _modbus_txdata+0
	ADDWF       _modbus_txn+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_modbus_txdata+0)
	ADDWFC      _modbus_txn+1, 0 
	MOVWF       FSR1H 
	MOVFF       modbusprocess_Ptr_L0+0, FSR0
	MOVFF       modbusprocess_Ptr_L0+1, FSR0H
	MOVLW       255
	ANDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      _modbus_txn+0, 1 
	INCF        _modbus_txn+1, 1 
;modbus.c,316 :: 		}
	GOTO        L_modbusprocess28
L_modbusprocess27:
;modbus.c,317 :: 		else if((index+i)==0x7fff0)
	MOVF        modbusprocess_i_L0+0, 0 
	ADDWF       modbusprocess_index_L0+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      modbusprocess_index_L0+1, 0 
	MOVWF       R2 
	MOVLW       0
	BTFSC       R2, 7 
	MOVLW       255
	MOVWF       R0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__modbusprocess130
	MOVF        R0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L__modbusprocess130
	MOVF        R2, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L__modbusprocess130
	MOVLW       240
	XORWF       R1, 0 
L__modbusprocess130:
	BTFSS       STATUS+0, 2 
	GOTO        L_modbusprocess29
;modbus.c,319 :: 		*Ptr = PRODUCTCODE;
	MOVFF       modbusprocess_Ptr_L0+0, FSR1
	MOVFF       modbusprocess_Ptr_L0+1, FSR1H
	MOVLW       86
	MOVWF       POSTINC1+0 
	MOVLW       86
	MOVWF       POSTINC1+0 
;modbus.c,320 :: 		modbus_txdata[modbus_txn++] = (*Ptr>>8) & 0xff;
	MOVLW       _modbus_txdata+0
	ADDWF       _modbus_txn+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_modbus_txdata+0)
	ADDWFC      _modbus_txn+1, 0 
	MOVWF       FSR1H 
	MOVFF       modbusprocess_Ptr_L0+0, FSR0
	MOVFF       modbusprocess_Ptr_L0+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        R4, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       R4, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       255
	ANDWF       R0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      _modbus_txn+0, 1 
	INCF        _modbus_txn+1, 1 
;modbus.c,321 :: 		modbus_txdata[modbus_txn++] = *Ptr & 0xff;
	MOVLW       _modbus_txdata+0
	ADDWF       _modbus_txn+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_modbus_txdata+0)
	ADDWFC      _modbus_txn+1, 0 
	MOVWF       FSR1H 
	MOVFF       modbusprocess_Ptr_L0+0, FSR0
	MOVFF       modbusprocess_Ptr_L0+1, FSR0H
	MOVLW       255
	ANDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      _modbus_txn+0, 1 
	INCF        _modbus_txn+1, 1 
;modbus.c,322 :: 		}
	GOTO        L_modbusprocess30
L_modbusprocess29:
;modbus.c,326 :: 		modbus_txn = SetErrorMessage(modbus_txdata, ERROR_REGISTER);
	MOVLW       _modbus_txdata+0
	MOVWF       FARG_SetErrorMessage_ptr+0 
	MOVLW       hi_addr(_modbus_txdata+0)
	MOVWF       FARG_SetErrorMessage_ptr+1 
	MOVLW       2
	MOVWF       FARG_SetErrorMessage_errortype+0 
	CALL        _SetErrorMessage+0, 0
	MOVF        R0, 0 
	MOVWF       _modbus_txn+0 
	MOVLW       0
	MOVWF       _modbus_txn+1 
;modbus.c,327 :: 		ErrorDetected = 1;
	MOVLW       1
	MOVWF       modbusprocess_ErrorDetected_L0+0 
;modbus.c,328 :: 		break;
	GOTO        L_modbusprocess19
;modbus.c,329 :: 		}
L_modbusprocess30:
L_modbusprocess28:
L_modbusprocess26:
L_modbusprocess24:
;modbus.c,296 :: 		for(i=0; i<length ;i++)
	INCF        modbusprocess_i_L0+0, 1 
;modbus.c,330 :: 		}
	GOTO        L_modbusprocess18
L_modbusprocess19:
;modbus.c,332 :: 		if(ErrorDetected == 0)
	MOVF        modbusprocess_ErrorDetected_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_modbusprocess31
;modbus.c,334 :: 		crc_tx = CRCChecksum(modbus_txdata, modbus_txn);
	MOVLW       _modbus_txdata+0
	MOVWF       FARG_CRCChecksum_chkbuf+0 
	MOVLW       hi_addr(_modbus_txdata+0)
	MOVWF       FARG_CRCChecksum_chkbuf+1 
	MOVF        _modbus_txn+0, 0 
	MOVWF       FARG_CRCChecksum_len+0 
	CALL        _CRCChecksum+0, 0
	MOVF        R0, 0 
	MOVWF       modbusprocess_crc_tx_L0+0 
	MOVF        R1, 0 
	MOVWF       modbusprocess_crc_tx_L0+1 
;modbus.c,335 :: 		modbus_txdata[modbus_txn++] = (crc_tx >> 8) & 0xff;
	MOVLW       _modbus_txdata+0
	ADDWF       _modbus_txn+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_modbus_txdata+0)
	ADDWFC      _modbus_txn+1, 0 
	MOVWF       FSR1H 
	MOVF        modbusprocess_crc_tx_L0+1, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       255
	ANDWF       R0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      _modbus_txn+0, 1 
	INCF        _modbus_txn+1, 1 
;modbus.c,336 :: 		modbus_txdata[modbus_txn++] = crc_tx & 0xff;
	MOVLW       _modbus_txdata+0
	ADDWF       _modbus_txn+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_modbus_txdata+0)
	ADDWFC      _modbus_txn+1, 0 
	MOVWF       FSR1H 
	MOVLW       255
	ANDWF       modbusprocess_crc_tx_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      _modbus_txn+0, 1 
	INCF        _modbus_txn+1, 1 
;modbus.c,337 :: 		}
L_modbusprocess31:
;modbus.c,338 :: 		}
	GOTO        L_modbusprocess32
L_modbusprocess17:
;modbus.c,340 :: 		{}
L_modbusprocess32:
;modbus.c,341 :: 		break;
	GOTO        L_modbusprocess15
;modbus.c,342 :: 		case 0x05:     //Ð´bit
L_modbusprocess33:
;modbus.c,343 :: 		if(modbus_rcn == 8)
	MOVLW       0
	XORWF       _modbus_rcn+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__modbusprocess131
	MOVLW       8
	XORWF       _modbus_rcn+0, 0 
L__modbusprocess131:
	BTFSS       STATUS+0, 2 
	GOTO        L_modbusprocess34
;modbus.c,345 :: 		modbus_data = (((unsigned int)(modbus_rcdata[4]) << 8) | modbus_rcdata[5]);
	MOVF        _modbus_rcdata+4, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        _modbus_rcdata+5, 0 
	IORWF       R0, 0 
	MOVWF       modbusprocess_modbus_data_L0+0 
	MOVF        R1, 0 
	MOVWF       modbusprocess_modbus_data_L0+1 
	MOVLW       0
	IORWF       modbusprocess_modbus_data_L0+1, 1 
;modbus.c,346 :: 		if(modbus_data == 0xff00)       //È·¶¨
	MOVF        modbusprocess_modbus_data_L0+1, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L__modbusprocess132
	MOVLW       0
	XORWF       modbusprocess_modbus_data_L0+0, 0 
L__modbusprocess132:
	BTFSS       STATUS+0, 2 
	GOTO        L_modbusprocess35
;modbus.c,348 :: 		if(index < 184)
	MOVLW       128
	XORWF       modbusprocess_index_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__modbusprocess133
	MOVLW       184
	SUBWF       modbusprocess_index_L0+0, 0 
L__modbusprocess133:
	BTFSC       STATUS+0, 0 
	GOTO        L_modbusprocess36
;modbus.c,351 :: 		modbus_txn = SetErrorMessage(modbus_txdata, ERROR_REGISTER);
	MOVLW       _modbus_txdata+0
	MOVWF       FARG_SetErrorMessage_ptr+0 
	MOVLW       hi_addr(_modbus_txdata+0)
	MOVWF       FARG_SetErrorMessage_ptr+1 
	MOVLW       2
	MOVWF       FARG_SetErrorMessage_errortype+0 
	CALL        _SetErrorMessage+0, 0
	MOVF        R0, 0 
	MOVWF       _modbus_txn+0 
	MOVLW       0
	MOVWF       _modbus_txn+1 
;modbus.c,352 :: 		ErrorDetected = 1;
	MOVLW       1
	MOVWF       modbusprocess_ErrorDetected_L0+0 
;modbus.c,353 :: 		}
	GOTO        L_modbusprocess37
L_modbusprocess36:
;modbus.c,354 :: 		else if(index < 186)
	MOVLW       128
	XORWF       modbusprocess_index_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__modbusprocess134
	MOVLW       186
	SUBWF       modbusprocess_index_L0+0, 0 
L__modbusprocess134:
	BTFSC       STATUS+0, 0 
	GOTO        L_modbusprocess38
;modbus.c,356 :: 		temp = index-184;
	MOVLW       184
	SUBWF       modbusprocess_index_L0+0, 0 
	MOVWF       R1 
	MOVLW       0
	SUBWFB      modbusprocess_index_L0+1, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       modbusprocess_temp_L0+0 
	MOVF        R2, 0 
	MOVWF       modbusprocess_temp_L0+1 
;modbus.c,357 :: 		if(temp == 0)
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__modbusprocess135
	MOVLW       0
	XORWF       R1, 0 
L__modbusprocess135:
	BTFSS       STATUS+0, 2 
	GOTO        L_modbusprocess39
;modbus.c,359 :: 		MemeSet((char *)&pSPCAlarm.spcalarms, 0, sizeof(SPCALARM));
	MOVLW       _pSPCAlarm+0
	MOVWF       FARG_MemeSet_target+0 
	MOVLW       hi_addr(_pSPCAlarm+0)
	MOVWF       FARG_MemeSet_target+1 
	CLRF        FARG_MemeSet_Transdata+0 
	MOVLW       81
	MOVWF       FARG_MemeSet_len+0 
	MOVLW       0
	MOVWF       FARG_MemeSet_len+1 
	CALL        _MemeSet+0, 0
;modbus.c,360 :: 		ForceSSROFFCondition[0] &= ~GFITRIPFORCEOFF;
	BCF         _ForceSSROFFCondition+0, 0 
;modbus.c,361 :: 		ForceSSROFFCondition[1] &= ~GFITRIPFORCEOFF;
	BCF         _ForceSSROFFCondition+1, 0 
;modbus.c,362 :: 		ActivedAlarms = 0;
	CLRF        _ActivedAlarms+0 
	CLRF        _ActivedAlarms+1 
	CLRF        _ActivedAlarms+2 
	CLRF        _ActivedAlarms+3 
;modbus.c,363 :: 		}
	GOTO        L_modbusprocess40
L_modbusprocess39:
;modbus.c,366 :: 		MemeSet((char *)&pSPCAlarm.spclogs, 0, sizeof(SPCALARM));
	MOVLW       _pSPCAlarm+81
	MOVWF       FARG_MemeSet_target+0 
	MOVLW       hi_addr(_pSPCAlarm+81)
	MOVWF       FARG_MemeSet_target+1 
	CLRF        FARG_MemeSet_Transdata+0 
	MOVLW       81
	MOVWF       FARG_MemeSet_len+0 
	MOVLW       0
	MOVWF       FARG_MemeSet_len+1 
	CALL        _MemeSet+0, 0
;modbus.c,367 :: 		}
L_modbusprocess40:
;modbus.c,368 :: 		}
	GOTO        L_modbusprocess41
L_modbusprocess38:
;modbus.c,369 :: 		else if(index < 188)
	MOVLW       128
	XORWF       modbusprocess_index_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__modbusprocess136
	MOVLW       188
	SUBWF       modbusprocess_index_L0+0, 0 
L__modbusprocess136:
	BTFSC       STATUS+0, 0 
	GOTO        L_modbusprocess42
;modbus.c,371 :: 		temp = index-186;
	MOVLW       186
	SUBWF       modbusprocess_index_L0+0, 0 
	MOVWF       R1 
	MOVLW       0
	SUBWFB      modbusprocess_index_L0+1, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       modbusprocess_temp_L0+0 
	MOVF        R2, 0 
	MOVWF       modbusprocess_temp_L0+1 
;modbus.c,372 :: 		if(temp < 6)
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__modbusprocess137
	MOVLW       6
	SUBWF       R1, 0 
L__modbusprocess137:
	BTFSC       STATUS+0, 0 
	GOTO        L_modbusprocess43
;modbus.c,374 :: 		PtrTemp = &Statis_flag[0];
	MOVLW       _Statis_flag+0
	MOVWF       modbusprocess_PtrTemp_L0+0 
	MOVLW       hi_addr(_Statis_flag+0)
	MOVWF       modbusprocess_PtrTemp_L0+1 
;modbus.c,375 :: 		StringLocate = (ResetCmd[temp]>>8) & 0xff;
	MOVF        modbusprocess_temp_L0+0, 0 
	MOVWF       R0 
	MOVF        modbusprocess_temp_L0+1, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       modbusprocess_temp_L0+1, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	MOVLW       modbus_ResetCmd+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(modbus_ResetCmd+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(modbus_ResetCmd+0)
	ADDWFC      R2, 0 
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
	MOVWF       modbusprocess_StringLocate_L0+0 
;modbus.c,376 :: 		}
	GOTO        L_modbusprocess44
L_modbusprocess43:
;modbus.c,379 :: 		temp -= 6;
	MOVLW       6
	SUBWF       modbusprocess_temp_L0+0, 0 
	MOVWF       R5 
	MOVLW       0
	SUBWFB      modbusprocess_temp_L0+1, 0 
	MOVWF       R6 
	MOVF        R5, 0 
	MOVWF       modbusprocess_temp_L0+0 
	MOVF        R6, 0 
	MOVWF       modbusprocess_temp_L0+1 
;modbus.c,380 :: 		PtrTemp = &Statis_flag[1];
	MOVLW       _Statis_flag+1
	MOVWF       modbusprocess_PtrTemp_L0+0 
	MOVLW       hi_addr(_Statis_flag+1)
	MOVWF       modbusprocess_PtrTemp_L0+1 
;modbus.c,381 :: 		StringLocate = (ResetCmd[temp]>>8) & 0xff;
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
	MOVLW       modbus_ResetCmd+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(modbus_ResetCmd+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(modbus_ResetCmd+0)
	ADDWFC      R2, 0 
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
	MOVWF       modbusprocess_StringLocate_L0+0 
;modbus.c,382 :: 		StringLocate++;
	MOVF        modbusprocess_StringLocate_L0+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       modbusprocess_StringLocate_L0+0 
;modbus.c,383 :: 		}
L_modbusprocess44:
;modbus.c,384 :: 		ResetLocate = ResetCmd[temp] & 0xff;
	MOVF        modbusprocess_temp_L0+0, 0 
	MOVWF       R0 
	MOVF        modbusprocess_temp_L0+1, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       modbusprocess_temp_L0+1, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	MOVLW       modbus_ResetCmd+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(modbus_ResetCmd+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(modbus_ResetCmd+0)
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVLW       255
	ANDWF       R0, 0 
	MOVWF       modbusprocess_ResetLocate_L0+0 
;modbus.c,385 :: 		*PtrTemp |= ResetLocate;
	MOVFF       modbusprocess_PtrTemp_L0+0, FSR0
	MOVFF       modbusprocess_PtrTemp_L0+1, FSR0H
	MOVFF       modbusprocess_PtrTemp_L0+0, FSR1
	MOVFF       modbusprocess_PtrTemp_L0+1, FSR1H
	MOVF        modbusprocess_ResetLocate_L0+0, 0 
	IORWF       POSTINC0+0, 1 
;modbus.c,386 :: 		ClearStr(Actural_disp_str[StringLocate], 16);
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        modbusprocess_StringLocate_L0+0, 0 
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
;modbus.c,387 :: 		}
	GOTO        L_modbusprocess45
L_modbusprocess42:
;modbus.c,388 :: 		else if(index < 190)
	MOVLW       128
	XORWF       modbusprocess_index_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__modbusprocess138
	MOVLW       190
	SUBWF       modbusprocess_index_L0+0, 0 
L__modbusprocess138:
	BTFSC       STATUS+0, 0 
	GOTO        L_modbusprocess46
;modbus.c,390 :: 		temp = index-188;
	MOVLW       188
	SUBWF       modbusprocess_index_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      modbusprocess_index_L0+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       modbusprocess_temp_L0+0 
	MOVF        R1, 0 
	MOVWF       modbusprocess_temp_L0+1 
;modbus.c,391 :: 		pSPCValue[temp].SPCStatistics.EnergyUsed = 0;
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
	MOVLW       16
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;modbus.c,392 :: 		SetIntStr((int*)&pSPCValue[temp].SPCStatistics.EnergyUsed, CH1_ACTURAL_ENEGY+temp, UNIT_ENEGRY, 3);
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        modbusprocess_temp_L0+0, 0 
	MOVWF       R4 
	MOVF        modbusprocess_temp_L0+1, 0 
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
	MOVLW       16
	ADDWF       FARG_SetIntStr_ptr+0, 1 
	MOVLW       0
	ADDWFC      FARG_SetIntStr_ptr+1, 1 
	MOVF        modbusprocess_temp_L0+0, 0 
	ADDLW       24
	MOVWF       FARG_SetIntStr_strlocat+0 
	MOVLW       11
	MOVWF       FARG_SetIntStr_unitlocar+0 
	MOVLW       3
	MOVWF       FARG_SetIntStr_len+0 
	CALL        _SetIntStr+0, 0
;modbus.c,393 :: 		}
	GOTO        L_modbusprocess47
L_modbusprocess46:
;modbus.c,394 :: 		else if(index < 192)
	MOVLW       128
	XORWF       modbusprocess_index_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__modbusprocess139
	MOVLW       192
	SUBWF       modbusprocess_index_L0+0, 0 
L__modbusprocess139:
	BTFSC       STATUS+0, 0 
	GOTO        L_modbusprocess48
;modbus.c,396 :: 		temp = index-190;
	MOVLW       190
	SUBWF       modbusprocess_index_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      modbusprocess_index_L0+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       modbusprocess_temp_L0+0 
	MOVF        R1, 0 
	MOVWF       modbusprocess_temp_L0+1 
;modbus.c,397 :: 		pSPCValue[temp].SPCStatistics.EnergyCost = 0;
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
	MOVLW       18
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;modbus.c,398 :: 		SetCostStr(0, CH1_ACTURAL_COST+temp);
	CLRF        FARG_SetCostStr_databuff+0 
	CLRF        FARG_SetCostStr_databuff+1 
	CLRF        FARG_SetCostStr_databuff+2 
	CLRF        FARG_SetCostStr_databuff+3 
	MOVF        modbusprocess_temp_L0+0, 0 
	ADDLW       26
	MOVWF       FARG_SetCostStr_strlocat+0 
	CALL        _SetCostStr+0, 0
;modbus.c,399 :: 		}
	GOTO        L_modbusprocess49
L_modbusprocess48:
;modbus.c,400 :: 		else if(index < 194)
	MOVLW       128
	XORWF       modbusprocess_index_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__modbusprocess140
	MOVLW       194
	SUBWF       modbusprocess_index_L0+0, 0 
L__modbusprocess140:
	BTFSC       STATUS+0, 0 
	GOTO        L_modbusprocess50
;modbus.c,402 :: 		temp = index-192;
	MOVLW       192
	SUBWF       modbusprocess_index_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      modbusprocess_index_L0+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       modbusprocess_temp_L0+0 
	MOVF        R1, 0 
	MOVWF       modbusprocess_temp_L0+1 
;modbus.c,403 :: 		pSPCValue[temp].SPCStatistics.RunTime = 0;
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
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;modbus.c,404 :: 		SetOntimeStr(0, CH1_ACTURAL_ONTIME+temp);
	CLRF        FARG_SetOntimeStr_databuff+0 
	CLRF        FARG_SetOntimeStr_databuff+1 
	CLRF        FARG_SetOntimeStr_databuff+2 
	CLRF        FARG_SetOntimeStr_databuff+3 
	MOVF        modbusprocess_temp_L0+0, 0 
	MOVWF       FARG_SetOntimeStr_strlocat+0 
	CALL        _SetOntimeStr+0, 0
;modbus.c,405 :: 		}
	GOTO        L_modbusprocess51
L_modbusprocess50:
;modbus.c,406 :: 		else if(index < 196)
	MOVLW       128
	XORWF       modbusprocess_index_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__modbusprocess141
	MOVLW       196
	SUBWF       modbusprocess_index_L0+0, 0 
L__modbusprocess141:
	BTFSC       STATUS+0, 0 
	GOTO        L_modbusprocess52
;modbus.c,408 :: 		temp = index-194;
	MOVLW       194
	SUBWF       modbusprocess_index_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      modbusprocess_index_L0+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       modbusprocess_temp_L0+0 
	MOVF        R1, 0 
	MOVWF       modbusprocess_temp_L0+1 
;modbus.c,409 :: 		pSPCValue[temp].SPCStatistics.HeaterOnTime = 0;
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
	MOVLW       26
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;modbus.c,410 :: 		SetIntStr((int*)&pSPCValue[temp].SPCStatistics.HeaterOnTime, CH1_ACTURAL_ENEGY+temp, UNIT_ENEGRY, 3);
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        modbusprocess_temp_L0+0, 0 
	MOVWF       R4 
	MOVF        modbusprocess_temp_L0+1, 0 
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
	MOVF        modbusprocess_temp_L0+0, 0 
	ADDLW       24
	MOVWF       FARG_SetIntStr_strlocat+0 
	MOVLW       11
	MOVWF       FARG_SetIntStr_unitlocar+0 
	MOVLW       3
	MOVWF       FARG_SetIntStr_len+0 
	CALL        _SetIntStr+0, 0
;modbus.c,411 :: 		}
	GOTO        L_modbusprocess53
L_modbusprocess52:
;modbus.c,412 :: 		else if(index == 196)
	MOVLW       0
	XORWF       modbusprocess_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__modbusprocess142
	MOVLW       196
	XORWF       modbusprocess_index_L0+0, 0 
L__modbusprocess142:
	BTFSS       STATUS+0, 2 
	GOTO        L_modbusprocess54
;modbus.c,414 :: 		MemeSet((char *)&pSPCValue[0].SPCStatistics, 0, sizeof(STATISTICS));
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
;modbus.c,415 :: 		MemeSet((char *)&pSPCValue[1].SPCStatistics, 0, sizeof(STATISTICS));
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
;modbus.c,416 :: 		for(i=10; i<20;i++)
	MOVLW       10
	MOVWF       modbusprocess_i_L0+0 
L_modbusprocess55:
	MOVLW       20
	SUBWF       modbusprocess_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_modbusprocess56
;modbus.c,417 :: 		ClearStr(Actural_disp_str[i], 16);
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        modbusprocess_i_L0+0, 0 
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
;modbus.c,416 :: 		for(i=10; i<20;i++)
	INCF        modbusprocess_i_L0+0, 1 
;modbus.c,417 :: 		ClearStr(Actural_disp_str[i], 16);
	GOTO        L_modbusprocess55
L_modbusprocess56:
;modbus.c,418 :: 		Statis_flag[0] = (STATIS_MAX_TEMP + STATIS_MIN_TEMP + STATIS_MAX_VOLT + STATIS_MIN_VOLT + STATIS_CURRENT + STATIS_GFI);
	MOVLW       63
	MOVWF       _Statis_flag+0 
;modbus.c,419 :: 		Statis_flag[1] = (STATIS_MAX_TEMP + STATIS_MIN_TEMP + STATIS_MAX_VOLT + STATIS_MIN_VOLT + STATIS_CURRENT + STATIS_GFI);
	MOVLW       63
	MOVWF       _Statis_flag+1 
;modbus.c,420 :: 		SetIntStr((int*)&pSPCValue[0].SPCStatistics.EnergyUsed, CH1_ACTURAL_ENEGY, UNIT_ENEGRY, 3);
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
;modbus.c,421 :: 		SetIntStr((int*)&pSPCValue[1].SPCStatistics.EnergyUsed, CH1_ACTURAL_ENEGY, UNIT_ENEGRY, 3);
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
;modbus.c,422 :: 		SetIntStr((int*)&pSPCValue[0].SPCStatistics.HeaterOnTime, CH1_ACTURAL_ENEGY, UNIT_ENEGRY, 3);
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
;modbus.c,423 :: 		SetIntStr((int*)&pSPCValue[1].SPCStatistics.HeaterOnTime, CH1_ACTURAL_ENEGY, UNIT_ENEGRY, 3);
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
;modbus.c,424 :: 		SetCostStr(0, CH1_ACTURAL_COST);
	CLRF        FARG_SetCostStr_databuff+0 
	CLRF        FARG_SetCostStr_databuff+1 
	CLRF        FARG_SetCostStr_databuff+2 
	CLRF        FARG_SetCostStr_databuff+3 
	MOVLW       26
	MOVWF       FARG_SetCostStr_strlocat+0 
	CALL        _SetCostStr+0, 0
;modbus.c,425 :: 		SetOntimeStr(0, CH1_ACTURAL_ONTIME);
	CLRF        FARG_SetOntimeStr_databuff+0 
	CLRF        FARG_SetOntimeStr_databuff+1 
	CLRF        FARG_SetOntimeStr_databuff+2 
	CLRF        FARG_SetOntimeStr_databuff+3 
	CLRF        FARG_SetOntimeStr_strlocat+0 
	CALL        _SetOntimeStr+0, 0
;modbus.c,426 :: 		SetCostStr(0, CH2_ACTURAL_COST);
	CLRF        FARG_SetCostStr_databuff+0 
	CLRF        FARG_SetCostStr_databuff+1 
	CLRF        FARG_SetCostStr_databuff+2 
	CLRF        FARG_SetCostStr_databuff+3 
	MOVLW       27
	MOVWF       FARG_SetCostStr_strlocat+0 
	CALL        _SetCostStr+0, 0
;modbus.c,427 :: 		SetOntimeStr(0, CH2_ACTURAL_ONTIME);
	CLRF        FARG_SetOntimeStr_databuff+0 
	CLRF        FARG_SetOntimeStr_databuff+1 
	CLRF        FARG_SetOntimeStr_databuff+2 
	CLRF        FARG_SetOntimeStr_databuff+3 
	MOVLW       1
	MOVWF       FARG_SetOntimeStr_strlocat+0 
	CALL        _SetOntimeStr+0, 0
;modbus.c,428 :: 		}
	GOTO        L_modbusprocess58
L_modbusprocess54:
;modbus.c,429 :: 		else if(index == 197)
	MOVLW       0
	XORWF       modbusprocess_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__modbusprocess143
	MOVLW       197
	XORWF       modbusprocess_index_L0+0, 0 
L__modbusprocess143:
	BTFSS       STATUS+0, 2 
	GOTO        L_modbusprocess59
;modbus.c,431 :: 		if(Alarmstat == 0)
	MOVF        _Alarmstat+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_modbusprocess60
;modbus.c,433 :: 		Alarm_SSR_off(0);
	CLRF        FARG_Alarm_SSR_off_ChannelNum+0 
	CALL        _Alarm_SSR_off+0, 0
;modbus.c,434 :: 		}
L_modbusprocess60:
;modbus.c,435 :: 		}
L_modbusprocess59:
L_modbusprocess58:
L_modbusprocess53:
L_modbusprocess51:
L_modbusprocess49:
L_modbusprocess47:
L_modbusprocess45:
L_modbusprocess41:
L_modbusprocess37:
;modbus.c,436 :: 		}
	GOTO        L_modbusprocess61
L_modbusprocess35:
;modbus.c,440 :: 		}
L_modbusprocess61:
;modbus.c,442 :: 		if(ErrorDetected == 0)
	MOVF        modbusprocess_ErrorDetected_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_modbusprocess62
;modbus.c,444 :: 		modbus_txn = 8;
	MOVLW       8
	MOVWF       _modbus_txn+0 
	MOVLW       0
	MOVWF       _modbus_txn+1 
;modbus.c,445 :: 		for(i=0;i<8;i++)
	CLRF        modbusprocess_i_L0+0 
L_modbusprocess63:
	MOVLW       8
	SUBWF       modbusprocess_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_modbusprocess64
;modbus.c,446 :: 		modbus_txdata[i] = modbus_rcdata[i];
	MOVLW       _modbus_txdata+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_modbus_txdata+0)
	MOVWF       FSR1H 
	MOVF        modbusprocess_i_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       _modbus_rcdata+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_modbus_rcdata+0)
	MOVWF       FSR0H 
	MOVF        modbusprocess_i_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;modbus.c,445 :: 		for(i=0;i<8;i++)
	INCF        modbusprocess_i_L0+0, 1 
;modbus.c,446 :: 		modbus_txdata[i] = modbus_rcdata[i];
	GOTO        L_modbusprocess63
L_modbusprocess64:
;modbus.c,447 :: 		}
L_modbusprocess62:
;modbus.c,448 :: 		}
	GOTO        L_modbusprocess66
L_modbusprocess34:
;modbus.c,450 :: 		{}
L_modbusprocess66:
;modbus.c,451 :: 		break;
	GOTO        L_modbusprocess15
;modbus.c,452 :: 		case 0x06:     //Ð´byte
L_modbusprocess67:
;modbus.c,453 :: 		if(modbus_rcn == 8)
	MOVLW       0
	XORWF       _modbus_rcn+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__modbusprocess144
	MOVLW       8
	XORWF       _modbus_rcn+0, 0 
L__modbusprocess144:
	BTFSS       STATUS+0, 2 
	GOTO        L_modbusprocess68
;modbus.c,455 :: 		if(index < 59)
	MOVLW       128
	XORWF       modbusprocess_index_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__modbusprocess145
	MOVLW       59
	SUBWF       modbusprocess_index_L0+0, 0 
L__modbusprocess145:
	BTFSC       STATUS+0, 0 
	GOTO        L_modbusprocess69
;modbus.c,457 :: 		Ptr = ModbusList[index+i];
	MOVF        modbusprocess_i_L0+0, 0 
	ADDWF       modbusprocess_index_L0+0, 0 
	MOVWF       R3 
	MOVLW       0
	ADDWFC      modbusprocess_index_L0+1, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _ModbusList+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_ModbusList+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       modbusprocess_Ptr_L0+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       modbusprocess_Ptr_L0+1 
;modbus.c,459 :: 		if(modbus_rcdata[0] == 255)
	MOVF        _modbus_rcdata+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_modbusprocess70
;modbus.c,462 :: 		}
	GOTO        L_modbusprocess71
L_modbusprocess70:
;modbus.c,465 :: 		modbus_data = (((int)(modbus_rcdata[4]) << 8) | modbus_rcdata[5]);
	MOVF        _modbus_rcdata+4, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        _modbus_rcdata+5, 0 
	IORWF       R0, 0 
	MOVWF       modbusprocess_modbus_data_L0+0 
	MOVF        R1, 0 
	MOVWF       modbusprocess_modbus_data_L0+1 
	MOVLW       0
	IORWF       modbusprocess_modbus_data_L0+1, 1 
;modbus.c,466 :: 		*Ptr = modbus_data;
	MOVFF       modbusprocess_Ptr_L0+0, FSR1
	MOVFF       modbusprocess_Ptr_L0+1, FSR1H
	MOVF        modbusprocess_modbus_data_L0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        modbusprocess_modbus_data_L0+1, 0 
	MOVWF       POSTINC1+0 
;modbus.c,467 :: 		ParameterChanged = 1;
	MOVLW       1
	MOVWF       modbusprocess_ParameterChanged_L0+0 
;modbus.c,468 :: 		}
L_modbusprocess71:
;modbus.c,470 :: 		modbus_txn = 8;
	MOVLW       8
	MOVWF       _modbus_txn+0 
	MOVLW       0
	MOVWF       _modbus_txn+1 
;modbus.c,471 :: 		for(i=0;i<8;i++)
	CLRF        modbusprocess_i_L0+0 
L_modbusprocess72:
	MOVLW       8
	SUBWF       modbusprocess_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_modbusprocess73
;modbus.c,472 :: 		modbus_txdata[i] = modbus_rcdata[i];
	MOVLW       _modbus_txdata+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_modbus_txdata+0)
	MOVWF       FSR1H 
	MOVF        modbusprocess_i_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       _modbus_rcdata+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_modbus_rcdata+0)
	MOVWF       FSR0H 
	MOVF        modbusprocess_i_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;modbus.c,471 :: 		for(i=0;i<8;i++)
	INCF        modbusprocess_i_L0+0, 1 
;modbus.c,472 :: 		modbus_txdata[i] = modbus_rcdata[i];
	GOTO        L_modbusprocess72
L_modbusprocess73:
;modbus.c,473 :: 		}
	GOTO        L_modbusprocess75
L_modbusprocess69:
;modbus.c,477 :: 		modbus_txn = SetErrorMessage(modbus_txdata, ERROR_REGISTER);
	MOVLW       _modbus_txdata+0
	MOVWF       FARG_SetErrorMessage_ptr+0 
	MOVLW       hi_addr(_modbus_txdata+0)
	MOVWF       FARG_SetErrorMessage_ptr+1 
	MOVLW       2
	MOVWF       FARG_SetErrorMessage_errortype+0 
	CALL        _SetErrorMessage+0, 0
	MOVF        R0, 0 
	MOVWF       _modbus_txn+0 
	MOVLW       0
	MOVWF       _modbus_txn+1 
;modbus.c,478 :: 		}
L_modbusprocess75:
;modbus.c,479 :: 		}
	GOTO        L_modbusprocess76
L_modbusprocess68:
;modbus.c,481 :: 		{}
L_modbusprocess76:
;modbus.c,482 :: 		break;
	GOTO        L_modbusprocess15
;modbus.c,483 :: 		case 0x10:     //Ð´bytes
L_modbusprocess77:
;modbus.c,484 :: 		if(modbus_rcdata[6] == (length*2))
	MOVF        modbusprocess_length_L0+0, 0 
	MOVWF       R1 
	MOVF        modbusprocess_length_L0+1, 0 
	MOVWF       R2 
	RLCF        R1, 1 
	BCF         R1, 0 
	RLCF        R2, 1 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__modbusprocess146
	MOVF        R1, 0 
	XORWF       _modbus_rcdata+6, 0 
L__modbusprocess146:
	BTFSS       STATUS+0, 2 
	GOTO        L_modbusprocess78
;modbus.c,486 :: 		if((index+length) < 59)
	MOVF        modbusprocess_length_L0+0, 0 
	ADDWF       modbusprocess_index_L0+0, 0 
	MOVWF       R1 
	MOVF        modbusprocess_length_L0+1, 0 
	ADDWFC      modbusprocess_index_L0+1, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__modbusprocess147
	MOVLW       59
	SUBWF       R1, 0 
L__modbusprocess147:
	BTFSC       STATUS+0, 0 
	GOTO        L_modbusprocess79
;modbus.c,488 :: 		Ptr = ModbusList[index+i];
	MOVF        modbusprocess_i_L0+0, 0 
	ADDWF       modbusprocess_index_L0+0, 0 
	MOVWF       R3 
	MOVLW       0
	ADDWFC      modbusprocess_index_L0+1, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _ModbusList+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_ModbusList+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       modbusprocess_Ptr_L0+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       modbusprocess_Ptr_L0+1 
;modbus.c,489 :: 		i=0;
	CLRF        modbusprocess_i_L0+0 
;modbus.c,490 :: 		j=7;
	MOVLW       7
	MOVWF       modbusprocess_j_L0+0 
;modbus.c,491 :: 		for(;i<length;i++)
L_modbusprocess80:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       modbusprocess_length_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__modbusprocess148
	MOVF        modbusprocess_length_L0+0, 0 
	SUBWF       modbusprocess_i_L0+0, 0 
L__modbusprocess148:
	BTFSC       STATUS+0, 0 
	GOTO        L_modbusprocess81
;modbus.c,493 :: 		*Ptr = (unsigned int)modbus_rcdata[j++] << 8;
	MOVLW       _modbus_rcdata+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_modbus_rcdata+0)
	MOVWF       FSR0H 
	MOVF        modbusprocess_j_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVFF       modbusprocess_Ptr_L0+0, FSR1
	MOVFF       modbusprocess_Ptr_L0+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	INCF        modbusprocess_j_L0+0, 1 
;modbus.c,494 :: 		*Ptr |= modbus_rcdata[j++];
	MOVLW       _modbus_rcdata+0
	MOVWF       FSR2 
	MOVLW       hi_addr(_modbus_rcdata+0)
	MOVWF       FSR2H 
	MOVF        modbusprocess_j_L0+0, 0 
	ADDWF       FSR2, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR2H, 1 
	MOVFF       modbusprocess_Ptr_L0+0, FSR0
	MOVFF       modbusprocess_Ptr_L0+1, FSR0H
	MOVF        POSTINC2+0, 0 
	IORWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       0
	IORWF       R1, 1 
	MOVFF       modbusprocess_Ptr_L0+0, FSR1
	MOVFF       modbusprocess_Ptr_L0+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	INCF        modbusprocess_j_L0+0, 1 
;modbus.c,495 :: 		Ptr++;
	MOVLW       2
	ADDWF       modbusprocess_Ptr_L0+0, 1 
	MOVLW       0
	ADDWFC      modbusprocess_Ptr_L0+1, 1 
;modbus.c,491 :: 		for(;i<length;i++)
	INCF        modbusprocess_i_L0+0, 1 
;modbus.c,496 :: 		}
	GOTO        L_modbusprocess80
L_modbusprocess81:
;modbus.c,497 :: 		ParameterChanged = 1;
	MOVLW       1
	MOVWF       modbusprocess_ParameterChanged_L0+0 
;modbus.c,498 :: 		}
	GOTO        L_modbusprocess83
L_modbusprocess79:
;modbus.c,502 :: 		modbus_txn = SetErrorMessage(modbus_txdata, ERROR_REGISTER);
	MOVLW       _modbus_txdata+0
	MOVWF       FARG_SetErrorMessage_ptr+0 
	MOVLW       hi_addr(_modbus_txdata+0)
	MOVWF       FARG_SetErrorMessage_ptr+1 
	MOVLW       2
	MOVWF       FARG_SetErrorMessage_errortype+0 
	CALL        _SetErrorMessage+0, 0
	MOVF        R0, 0 
	MOVWF       _modbus_txn+0 
	MOVLW       0
	MOVWF       _modbus_txn+1 
;modbus.c,503 :: 		ErrorDetected = 1;
	MOVLW       1
	MOVWF       modbusprocess_ErrorDetected_L0+0 
;modbus.c,504 :: 		}
L_modbusprocess83:
;modbus.c,505 :: 		}
L_modbusprocess78:
;modbus.c,507 :: 		if(ErrorDetected == 0)
	MOVF        modbusprocess_ErrorDetected_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_modbusprocess84
;modbus.c,509 :: 		for(i=0;i<4;i++)
	CLRF        modbusprocess_i_L0+0 
L_modbusprocess85:
	MOVLW       4
	SUBWF       modbusprocess_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_modbusprocess86
;modbus.c,511 :: 		modbus_txdata[modbus_txn] = modbus_rcdata[modbus_txn];
	MOVLW       _modbus_txdata+0
	ADDWF       _modbus_txn+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_modbus_txdata+0)
	ADDWFC      _modbus_txn+1, 0 
	MOVWF       FSR1H 
	MOVLW       _modbus_rcdata+0
	ADDWF       _modbus_txn+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_modbus_rcdata+0)
	ADDWFC      _modbus_txn+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;modbus.c,512 :: 		modbus_txn++;
	INFSNZ      _modbus_txn+0, 1 
	INCF        _modbus_txn+1, 1 
;modbus.c,509 :: 		for(i=0;i<4;i++)
	INCF        modbusprocess_i_L0+0, 1 
;modbus.c,513 :: 		}
	GOTO        L_modbusprocess85
L_modbusprocess86:
;modbus.c,515 :: 		crc_tx = CRCChecksum(modbus_txdata, modbus_txn);
	MOVLW       _modbus_txdata+0
	MOVWF       FARG_CRCChecksum_chkbuf+0 
	MOVLW       hi_addr(_modbus_txdata+0)
	MOVWF       FARG_CRCChecksum_chkbuf+1 
	MOVF        _modbus_txn+0, 0 
	MOVWF       FARG_CRCChecksum_len+0 
	CALL        _CRCChecksum+0, 0
	MOVF        R0, 0 
	MOVWF       modbusprocess_crc_tx_L0+0 
	MOVF        R1, 0 
	MOVWF       modbusprocess_crc_tx_L0+1 
;modbus.c,516 :: 		modbus_txdata[modbus_txn++] = (crc_tx >> 8) & 0xff;
	MOVLW       _modbus_txdata+0
	ADDWF       _modbus_txn+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_modbus_txdata+0)
	ADDWFC      _modbus_txn+1, 0 
	MOVWF       FSR1H 
	MOVF        modbusprocess_crc_tx_L0+1, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       255
	ANDWF       R0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      _modbus_txn+0, 1 
	INCF        _modbus_txn+1, 1 
;modbus.c,517 :: 		modbus_txdata[modbus_txn++] = crc_tx & 0xff;
	MOVLW       _modbus_txdata+0
	ADDWF       _modbus_txn+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_modbus_txdata+0)
	ADDWFC      _modbus_txn+1, 0 
	MOVWF       FSR1H 
	MOVLW       255
	ANDWF       modbusprocess_crc_tx_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      _modbus_txn+0, 1 
	INCF        _modbus_txn+1, 1 
;modbus.c,518 :: 		}
L_modbusprocess84:
;modbus.c,520 :: 		break;
	GOTO        L_modbusprocess15
;modbus.c,521 :: 		case 0x16:    //read measured value
L_modbusprocess88:
;modbus.c,522 :: 		for(i=0;i<15;i++)
	CLRF        modbusprocess_i_L0+0 
L_modbusprocess89:
	MOVLW       15
	SUBWF       modbusprocess_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_modbusprocess90
;modbus.c,525 :: 		modbus_txdata[modbus_txn++] = (temp >> 8) & 0xff;
	MOVLW       _modbus_txdata+0
	ADDWF       _modbus_txn+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_modbus_txdata+0)
	ADDWFC      _modbus_txn+1, 0 
	MOVWF       FSR1H 
	MOVF        modbusprocess_temp_L0+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       modbusprocess_temp_L0+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       255
	ANDWF       R0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      _modbus_txn+0, 1 
	INCF        _modbus_txn+1, 1 
;modbus.c,526 :: 		modbus_txdata[modbus_txn++] = temp & 0xff;
	MOVLW       _modbus_txdata+0
	ADDWF       _modbus_txn+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_modbus_txdata+0)
	ADDWFC      _modbus_txn+1, 0 
	MOVWF       FSR1H 
	MOVLW       255
	ANDWF       modbusprocess_temp_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      _modbus_txn+0, 1 
	INCF        _modbus_txn+1, 1 
;modbus.c,522 :: 		for(i=0;i<15;i++)
	INCF        modbusprocess_i_L0+0, 1 
;modbus.c,527 :: 		}
	GOTO        L_modbusprocess89
L_modbusprocess90:
;modbus.c,540 :: 		crc_tx = CRCChecksum(modbus_txdata, modbus_txn);
	MOVLW       _modbus_txdata+0
	MOVWF       FARG_CRCChecksum_chkbuf+0 
	MOVLW       hi_addr(_modbus_txdata+0)
	MOVWF       FARG_CRCChecksum_chkbuf+1 
	MOVF        _modbus_txn+0, 0 
	MOVWF       FARG_CRCChecksum_len+0 
	CALL        _CRCChecksum+0, 0
	MOVF        R0, 0 
	MOVWF       modbusprocess_crc_tx_L0+0 
	MOVF        R1, 0 
	MOVWF       modbusprocess_crc_tx_L0+1 
;modbus.c,541 :: 		modbus_txdata[modbus_txn++] = (crc_tx >> 8) & 0xff;
	MOVLW       _modbus_txdata+0
	ADDWF       _modbus_txn+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_modbus_txdata+0)
	ADDWFC      _modbus_txn+1, 0 
	MOVWF       FSR1H 
	MOVF        modbusprocess_crc_tx_L0+1, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       255
	ANDWF       R0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      _modbus_txn+0, 1 
	INCF        _modbus_txn+1, 1 
;modbus.c,542 :: 		modbus_txdata[modbus_txn++] = crc_tx & 0xff;
	MOVLW       _modbus_txdata+0
	ADDWF       _modbus_txn+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_modbus_txdata+0)
	ADDWFC      _modbus_txn+1, 0 
	MOVWF       FSR1H 
	MOVLW       255
	ANDWF       modbusprocess_crc_tx_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      _modbus_txn+0, 1 
	INCF        _modbus_txn+1, 1 
;modbus.c,543 :: 		break;
	GOTO        L_modbusprocess15
;modbus.c,565 :: 		default:      //´íÎó¹¦ÄÜÂð
L_modbusprocess92:
;modbus.c,566 :: 		modbus_txn = SetErrorMessage(modbus_txdata, ERROR_FUNCTIONCODE);
	MOVLW       _modbus_txdata+0
	MOVWF       FARG_SetErrorMessage_ptr+0 
	MOVLW       hi_addr(_modbus_txdata+0)
	MOVWF       FARG_SetErrorMessage_ptr+1 
	MOVLW       1
	MOVWF       FARG_SetErrorMessage_errortype+0 
	CALL        _SetErrorMessage+0, 0
	MOVF        R0, 0 
	MOVWF       _modbus_txn+0 
	MOVLW       0
	MOVWF       _modbus_txn+1 
;modbus.c,567 :: 		break;
	GOTO        L_modbusprocess15
;modbus.c,568 :: 		}
L_modbusprocess14:
	MOVF        _modbus_rcdata+1, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_modbusprocess16
	MOVF        _modbus_rcdata+1, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_modbusprocess33
	MOVF        _modbus_rcdata+1, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_modbusprocess67
	MOVF        _modbus_rcdata+1, 0 
	XORLW       16
	BTFSC       STATUS+0, 2 
	GOTO        L_modbusprocess77
	MOVF        _modbus_rcdata+1, 0 
	XORLW       22
	BTFSC       STATUS+0, 2 
	GOTO        L_modbusprocess88
	GOTO        L_modbusprocess92
L_modbusprocess15:
;modbus.c,569 :: 		}
	GOTO        L_modbusprocess93
L_modbusprocess13:
;modbus.c,573 :: 		}
L_modbusprocess93:
;modbus.c,575 :: 		modbus_respond();
	CALL        _modbus_respond+0, 0
;modbus.c,576 :: 		}
	GOTO        L_modbusprocess94
L_modbusprocess12:
;modbus.c,579 :: 		modbus_txn = 0;
	CLRF        _modbus_txn+0 
	CLRF        _modbus_txn+1 
;modbus.c,580 :: 		modbus_rcn = 0;
	CLRF        _modbus_rcn+0 
	CLRF        _modbus_rcn+1 
;modbus.c,581 :: 		}
L_modbusprocess94:
;modbus.c,583 :: 		RC1IE_bit = 1;
	BSF         RC1IE_bit+0, BitPos(RC1IE_bit+0) 
;modbus.c,585 :: 		if(ParameterChanged)
	MOVF        modbusprocess_ParameterChanged_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_modbusprocess95
;modbus.c,587 :: 		Ptr = (int *)&pSPCValue[Cable_Channel].SPCSetPoints;
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
	MOVWF       modbusprocess_Ptr_L0+0 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       modbusprocess_Ptr_L0+1 
	MOVLW       54
	ADDWF       modbusprocess_Ptr_L0+0, 1 
	MOVLW       0
	ADDWFC      modbusprocess_Ptr_L0+1, 1 
;modbus.c,588 :: 		for(i=0;i<4;i++)
	CLRF        modbusprocess_i_L0+0 
L_modbusprocess96:
	MOVLW       4
	SUBWF       modbusprocess_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_modbusprocess97
;modbus.c,590 :: 		EEPROM_get(1+i*sizeof(TEMPERATURE),sizeof(TEMPERATURE),(unsigned char*)&TempBuff);
	MOVF        modbusprocess_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	RLCF        R1, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	RLCF        R1, 1 
	BCF         R0, 0 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+1 
	MOVLW       4
	MOVWF       FARG_EEPROM_get_Len+0 
	MOVLW       _TempBuff+0
	MOVWF       FARG_EEPROM_get_readbuffer+0 
	MOVLW       hi_addr(_TempBuff+0)
	MOVWF       FARG_EEPROM_get_readbuffer+1 
	CALL        _EEPROM_get+0, 0
;modbus.c,591 :: 		if(*(Ptr+i*2) != TempBuff.Temperature_F)
	MOVF        modbusprocess_i_L0+0, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	RLCF        R3, 1 
	RLCF        R4, 1 
	BCF         R3, 0 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       modbusprocess_Ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      modbusprocess_Ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORWF       _TempBuff+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__modbusprocess149
	MOVF        _TempBuff+0, 0 
	XORWF       R1, 0 
L__modbusprocess149:
	BTFSC       STATUS+0, 2 
	GOTO        L_modbusprocess99
;modbus.c,593 :: 		if((*(Ptr+i*2) == SPC_SYSTEMVALUE_OFF) || (*(Ptr+i*2) == SPC_SYSTEMVALUE_NONE))
	MOVF        modbusprocess_i_L0+0, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	RLCF        R3, 1 
	RLCF        R4, 1 
	BCF         R3, 0 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       modbusprocess_Ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      modbusprocess_Ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__modbusprocess150
	MOVLW       255
	XORWF       R1, 0 
L__modbusprocess150:
	BTFSC       STATUS+0, 2 
	GOTO        L__modbusprocess116
	MOVF        modbusprocess_i_L0+0, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	RLCF        R3, 1 
	RLCF        R4, 1 
	BCF         R3, 0 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       modbusprocess_Ptr_L0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      modbusprocess_Ptr_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__modbusprocess151
	MOVLW       254
	XORWF       R1, 0 
L__modbusprocess151:
	BTFSC       STATUS+0, 2 
	GOTO        L__modbusprocess116
	GOTO        L_modbusprocess102
L__modbusprocess116:
;modbus.c,594 :: 		*(Ptr+i*2+1) = *(Ptr+i*2);
	MOVF        modbusprocess_i_L0+0, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	RLCF        R3, 1 
	RLCF        R4, 1 
	BCF         R3, 0 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        modbusprocess_Ptr_L0+0, 0 
	ADDWF       R0, 1 
	MOVF        modbusprocess_Ptr_L0+1, 0 
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVFF       R0, FSR0
	MOVFF       R1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	GOTO        L_modbusprocess103
L_modbusprocess102:
;modbus.c,596 :: 		*(Ptr+i*2+1) = ConvertFtoC(*(Ptr+i*2));
	MOVF        modbusprocess_i_L0+0, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	RLCF        R3, 1 
	RLCF        R4, 1 
	BCF         R3, 0 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        modbusprocess_Ptr_L0+0, 0 
	ADDWF       R0, 1 
	MOVF        modbusprocess_Ptr_L0+1, 0 
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FLOC__modbusprocess+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__modbusprocess+1 
	MOVFF       R0, FSR0
	MOVFF       R1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ConvertFtoC_sourse+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ConvertFtoC_sourse+1 
	CALL        _ConvertFtoC+0, 0
	MOVFF       FLOC__modbusprocess+0, FSR1
	MOVFF       FLOC__modbusprocess+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
L_modbusprocess103:
;modbus.c,597 :: 		}
	GOTO        L_modbusprocess104
L_modbusprocess99:
;modbus.c,598 :: 		else if(*(Ptr+i*2+1) != TempBuff.Temperature_C)
	MOVF        modbusprocess_i_L0+0, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	RLCF        R3, 1 
	RLCF        R4, 1 
	BCF         R3, 0 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        modbusprocess_Ptr_L0+0, 0 
	ADDWF       R0, 1 
	MOVF        modbusprocess_Ptr_L0+1, 0 
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
	XORWF       _TempBuff+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__modbusprocess152
	MOVF        _TempBuff+2, 0 
	XORWF       R1, 0 
L__modbusprocess152:
	BTFSC       STATUS+0, 2 
	GOTO        L_modbusprocess105
;modbus.c,600 :: 		if((*(Ptr+i*2+1) == SPC_SYSTEMVALUE_OFF) || (*(Ptr+i*2+1) == SPC_SYSTEMVALUE_NONE))
	MOVF        modbusprocess_i_L0+0, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	RLCF        R3, 1 
	RLCF        R4, 1 
	BCF         R3, 0 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        modbusprocess_Ptr_L0+0, 0 
	ADDWF       R0, 1 
	MOVF        modbusprocess_Ptr_L0+1, 0 
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
	GOTO        L__modbusprocess153
	MOVLW       255
	XORWF       R1, 0 
L__modbusprocess153:
	BTFSC       STATUS+0, 2 
	GOTO        L__modbusprocess115
	MOVF        modbusprocess_i_L0+0, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	RLCF        R3, 1 
	RLCF        R4, 1 
	BCF         R3, 0 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        modbusprocess_Ptr_L0+0, 0 
	ADDWF       R0, 1 
	MOVF        modbusprocess_Ptr_L0+1, 0 
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
	GOTO        L__modbusprocess154
	MOVLW       254
	XORWF       R1, 0 
L__modbusprocess154:
	BTFSC       STATUS+0, 2 
	GOTO        L__modbusprocess115
	GOTO        L_modbusprocess108
L__modbusprocess115:
;modbus.c,601 :: 		*(Ptr+i*2) = *(Ptr+i*2+1);
	MOVF        modbusprocess_i_L0+0, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	RLCF        R3, 1 
	RLCF        R4, 1 
	BCF         R3, 0 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        modbusprocess_Ptr_L0+0, 0 
	ADDWF       R0, 1 
	MOVF        modbusprocess_Ptr_L0+1, 0 
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVFF       R0, FSR1
	MOVFF       R1, FSR1H
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	GOTO        L_modbusprocess109
L_modbusprocess108:
;modbus.c,603 :: 		*(Ptr+i*2) = ConvertCtoF(*(Ptr+i*2+1));
	MOVF        modbusprocess_i_L0+0, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	RLCF        R3, 1 
	RLCF        R4, 1 
	BCF         R3, 0 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       modbusprocess_Ptr_L0+0, 0 
	MOVWF       FLOC__modbusprocess+0 
	MOVF        R1, 0 
	ADDWFC      modbusprocess_Ptr_L0+1, 0 
	MOVWF       FLOC__modbusprocess+1 
	MOVLW       2
	ADDWF       FLOC__modbusprocess+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FLOC__modbusprocess+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ConvertCtoF_sourse+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ConvertCtoF_sourse+1 
	CALL        _ConvertCtoF+0, 0
	MOVFF       FLOC__modbusprocess+0, FSR1
	MOVFF       FLOC__modbusprocess+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
L_modbusprocess109:
;modbus.c,604 :: 		}
L_modbusprocess105:
L_modbusprocess104:
;modbus.c,588 :: 		for(i=0;i<4;i++)
	INCF        modbusprocess_i_L0+0, 1 
;modbus.c,605 :: 		}
	GOTO        L_modbusprocess96
L_modbusprocess97:
;modbus.c,607 :: 		ParametersChanged = 1;
	MOVLW       1
	MOVWF       _ParametersChanged+0 
;modbus.c,608 :: 		}
L_modbusprocess95:
;modbus.c,609 :: 		}
L_end_modbusprocess:
	RETURN      0
; end of _modbusprocess

_modbus_respond:

;modbus.c,616 :: 		void modbus_respond()
;modbus.c,618 :: 		LED_COMMUNICATION_FAIL = 1;
	BSF         LATE1_bit+0, BitPos(LATE1_bit+0) 
;modbus.c,619 :: 		USART_send(modbus_txdata, modbus_txn);
	MOVLW       _modbus_txdata+0
	MOVWF       FARG_USART_send_bufout+0 
	MOVLW       hi_addr(_modbus_txdata+0)
	MOVWF       FARG_USART_send_bufout+1 
	MOVF        _modbus_txn+0, 0 
	MOVWF       FARG_USART_send_len+0 
	CALL        _USART_send+0, 0
;modbus.c,620 :: 		LED_COMMUNICATION_FAIL = 0;
	BCF         LATE1_bit+0, BitPos(LATE1_bit+0) 
;modbus.c,621 :: 		modbus_txn = 0;
	CLRF        _modbus_txn+0 
	CLRF        _modbus_txn+1 
;modbus.c,622 :: 		modbus_rcn = 0;
	CLRF        _modbus_rcn+0 
	CLRF        _modbus_rcn+1 
;modbus.c,623 :: 		}
L_end_modbus_respond:
	RETURN      0
; end of _modbus_respond

_Copydata:

;modbus.c,655 :: 		void Copydata(UCHAR *source, UCHAR *target, char len)
;modbus.c,659 :: 		for(i=0; i<len; i++)
	CLRF        R1 
L_Copydata110:
	MOVF        FARG_Copydata_len+0, 0 
	SUBWF       R1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Copydata111
;modbus.c,660 :: 		*target = *source;
	MOVFF       FARG_Copydata_source+0, FSR0
	MOVFF       FARG_Copydata_source+1, FSR0H
	MOVFF       FARG_Copydata_target+0, FSR1
	MOVFF       FARG_Copydata_target+1, FSR1H
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;modbus.c,659 :: 		for(i=0; i<len; i++)
	INCF        R1, 1 
;modbus.c,660 :: 		*target = *source;
	GOTO        L_Copydata110
L_Copydata111:
;modbus.c,661 :: 		}
L_end_Copydata:
	RETURN      0
; end of _Copydata

_CRCChecksum:

;modbus.c,668 :: 		unsigned int CRCChecksum(unsigned char *chkbuf, unsigned char len)
;modbus.c,670 :: 		unsigned char    uchCRCHi = 0xff ;
	MOVLW       255
	MOVWF       CRCChecksum_uchCRCHi_L0+0 
	MOVLW       255
	MOVWF       CRCChecksum_uchCRCLo_L0+0 
;modbus.c,675 :: 		while (len)
L_CRCChecksum113:
	MOVF        FARG_CRCChecksum_len+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_CRCChecksum114
;modbus.c,677 :: 		uIndex = (unsigned int)(uchCRCHi ^ *chkbuf++) ;
	MOVFF       FARG_CRCChecksum_chkbuf+0, FSR2
	MOVFF       FARG_CRCChecksum_chkbuf+1, FSR2H
	MOVF        POSTINC2+0, 0 
	XORWF       CRCChecksum_uchCRCHi_L0+0, 0 
	MOVWF       R3 
	CLRF        R4 
	MOVLW       0
	XORWF       R4, 1 
	MOVLW       0
	MOVWF       R4 
	INFSNZ      FARG_CRCChecksum_chkbuf+0, 1 
	INCF        FARG_CRCChecksum_chkbuf+1, 1 
;modbus.c,678 :: 		uchCRCHi = (unsigned char)(uchCRCLo ^ CRCHi_exp[uIndex]) ;
	MOVLW       _CRCHi_exp+0
	ADDWF       R3, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_CRCHi_exp+0)
	ADDWFC      R4, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(_CRCHi_exp+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	XORWF       CRCChecksum_uchCRCLo_L0+0, 0 
	MOVWF       CRCChecksum_uchCRCHi_L0+0 
;modbus.c,679 :: 		uchCRCLo = CRCLo_exp[uIndex] ;
	MOVLW       _CRCLo_exp+0
	ADDWF       R3, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_CRCLo_exp+0)
	ADDWFC      R4, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(_CRCLo_exp+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, CRCChecksum_uchCRCLo_L0+0
;modbus.c,680 :: 		len-- ;
	DECF        FARG_CRCChecksum_len+0, 1 
;modbus.c,681 :: 		}
	GOTO        L_CRCChecksum113
L_CRCChecksum114:
;modbus.c,683 :: 		temp_code = (unsigned int) uchCRCHi;
	MOVF        CRCChecksum_uchCRCHi_L0+0, 0 
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
;modbus.c,684 :: 		temp_code = (unsigned int)(temp_code << 8);
	MOVF        R5, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        R0, 0 
	MOVWF       R5 
	MOVF        R1, 0 
	MOVWF       R6 
;modbus.c,685 :: 		return (unsigned int)(temp_code | uchCRCLo) ;
	MOVF        CRCChecksum_uchCRCLo_L0+0, 0 
	IORWF       R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVLW       0
	IORWF       R1, 1 
;modbus.c,686 :: 		}
L_end_CRCChecksum:
	RETURN      0
; end of _CRCChecksum

_SetModbusTxData:

;modbus.c,688 :: 		void SetModbusTxData(int TransData)
;modbus.c,692 :: 		modbus_txdata[modbus_txn] = modbus_rcdata[modbus_txn];
	MOVLW       _modbus_txdata+0
	ADDWF       _modbus_txn+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_modbus_txdata+0)
	ADDWFC      _modbus_txn+1, 0 
	MOVWF       FSR1H 
	MOVLW       _modbus_rcdata+0
	ADDWF       _modbus_txn+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_modbus_rcdata+0)
	ADDWFC      _modbus_txn+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;modbus.c,693 :: 		modbus_txn++;
	INFSNZ      _modbus_txn+0, 1 
	INCF        _modbus_txn+1, 1 
;modbus.c,694 :: 		modbus_txdata[modbus_txn] = modbus_rcdata[modbus_txn];
	MOVLW       _modbus_txdata+0
	ADDWF       _modbus_txn+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_modbus_txdata+0)
	ADDWFC      _modbus_txn+1, 0 
	MOVWF       FSR1H 
	MOVLW       _modbus_rcdata+0
	ADDWF       _modbus_txn+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_modbus_rcdata+0)
	ADDWFC      _modbus_txn+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;modbus.c,695 :: 		modbus_txn++;
	INFSNZ      _modbus_txn+0, 1 
	INCF        _modbus_txn+1, 1 
;modbus.c,697 :: 		modbus_txdata[modbus_txn++] = (TransData >> 8) & 0x00ff;
	MOVLW       _modbus_txdata+0
	ADDWF       _modbus_txn+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_modbus_txdata+0)
	ADDWFC      _modbus_txn+1, 0 
	MOVWF       FSR1H 
	MOVF        FARG_SetModbusTxData_TransData+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       FARG_SetModbusTxData_TransData+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       255
	ANDWF       R0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      _modbus_txn+0, 1 
	INCF        _modbus_txn+1, 1 
;modbus.c,698 :: 		modbus_txdata[modbus_txn++] = TransData & 0x00ff;
	MOVLW       _modbus_txdata+0
	ADDWF       _modbus_txn+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_modbus_txdata+0)
	ADDWFC      _modbus_txn+1, 0 
	MOVWF       FSR1H 
	MOVLW       255
	ANDWF       FARG_SetModbusTxData_TransData+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      _modbus_txn+0, 1 
	INCF        _modbus_txn+1, 1 
;modbus.c,700 :: 		CRCBuff = CRCChecksum(modbus_txdata, modbus_txn);
	MOVLW       _modbus_txdata+0
	MOVWF       FARG_CRCChecksum_chkbuf+0 
	MOVLW       hi_addr(_modbus_txdata+0)
	MOVWF       FARG_CRCChecksum_chkbuf+1 
	MOVF        _modbus_txn+0, 0 
	MOVWF       FARG_CRCChecksum_len+0 
	CALL        _CRCChecksum+0, 0
	MOVF        R0, 0 
	MOVWF       SetModbusTxData_CRCBuff_L0+0 
	MOVF        R1, 0 
	MOVWF       SetModbusTxData_CRCBuff_L0+1 
;modbus.c,701 :: 		modbus_txdata[modbus_txn++] = (CRCBuff >> 8) & 0xff;
	MOVLW       _modbus_txdata+0
	ADDWF       _modbus_txn+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_modbus_txdata+0)
	ADDWFC      _modbus_txn+1, 0 
	MOVWF       FSR1H 
	MOVF        R1, 0 
	MOVWF       R2 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	MOVWF       R3 
	MOVLW       255
	ANDWF       R2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      _modbus_txn+0, 1 
	INCF        _modbus_txn+1, 1 
;modbus.c,702 :: 		modbus_txdata[modbus_txn++] = CRCBuff & 0xff;
	MOVLW       _modbus_txdata+0
	ADDWF       _modbus_txn+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_modbus_txdata+0)
	ADDWFC      _modbus_txn+1, 0 
	MOVWF       FSR1H 
	MOVLW       255
	ANDWF       SetModbusTxData_CRCBuff_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      _modbus_txn+0, 1 
	INCF        _modbus_txn+1, 1 
;modbus.c,703 :: 		}
L_end_SetModbusTxData:
	RETURN      0
; end of _SetModbusTxData

modbus____?ag:

L_end_modbus___?ag:
	RETURN      0
; end of modbus____?ag
