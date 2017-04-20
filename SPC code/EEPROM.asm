
_EEPROM_get:

;EEPROM.c,10 :: 		void EEPROM_get(UINT EEPROM_READ_ADDRESS,UCHAR Len,UCHAR *readbuffer)
;EEPROM.c,14 :: 		for(i=0; i<Len; i++)
	CLRF        EEPROM_get_i_L0+0 
	CLRF        EEPROM_get_i_L0+1 
L_EEPROM_get0:
	MOVLW       0
	SUBWF       EEPROM_get_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__EEPROM_get9
	MOVF        FARG_EEPROM_get_Len+0, 0 
	SUBWF       EEPROM_get_i_L0+0, 0 
L__EEPROM_get9:
	BTFSC       STATUS+0, 0 
	GOTO        L_EEPROM_get1
;EEPROM.c,15 :: 		*(readbuffer+i) = EEPROM_Read(EEPROM_READ_ADDRESS+i);
	MOVF        EEPROM_get_i_L0+0, 0 
	ADDWF       FARG_EEPROM_get_readbuffer+0, 0 
	MOVWF       FLOC__EEPROM_get+0 
	MOVF        EEPROM_get_i_L0+1, 0 
	ADDWFC      FARG_EEPROM_get_readbuffer+1, 0 
	MOVWF       FLOC__EEPROM_get+1 
	MOVF        EEPROM_get_i_L0+0, 0 
	ADDWF       FARG_EEPROM_get_EEPROM_READ_ADDRESS+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVF        EEPROM_get_i_L0+1, 0 
	ADDWFC      FARG_EEPROM_get_EEPROM_READ_ADDRESS+1, 0 
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVFF       FLOC__EEPROM_get+0, FSR1
	MOVFF       FLOC__EEPROM_get+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;EEPROM.c,14 :: 		for(i=0; i<Len; i++)
	INFSNZ      EEPROM_get_i_L0+0, 1 
	INCF        EEPROM_get_i_L0+1, 1 
;EEPROM.c,15 :: 		*(readbuffer+i) = EEPROM_Read(EEPROM_READ_ADDRESS+i);
	GOTO        L_EEPROM_get0
L_EEPROM_get1:
;EEPROM.c,16 :: 		}
L_end_EEPROM_get:
	RETURN      0
; end of _EEPROM_get

_EEPROM_set:

;EEPROM.c,23 :: 		void EEPROM_set(UINT EEPROM_WRITE_ADDRESS,UCHAR Len,UCHAR *writebuffer)
;EEPROM.c,27 :: 		for(i=0; i<Len; i++)
	CLRF        EEPROM_set_i_L0+0 
	CLRF        EEPROM_set_i_L0+1 
L_EEPROM_set3:
	MOVLW       0
	SUBWF       EEPROM_set_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__EEPROM_set11
	MOVF        FARG_EEPROM_set_Len+0, 0 
	SUBWF       EEPROM_set_i_L0+0, 0 
L__EEPROM_set11:
	BTFSC       STATUS+0, 0 
	GOTO        L_EEPROM_set4
;EEPROM.c,29 :: 		EEPROM_Write(EEPROM_WRITE_ADDRESS+i,*(writebuffer+i));
	MOVF        EEPROM_set_i_L0+0, 0 
	ADDWF       FARG_EEPROM_set_EEPROM_WRITE_ADDRESS+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        EEPROM_set_i_L0+1, 0 
	ADDWFC      FARG_EEPROM_set_EEPROM_WRITE_ADDRESS+1, 0 
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        EEPROM_set_i_L0+0, 0 
	ADDWF       FARG_EEPROM_set_writebuffer+0, 0 
	MOVWF       FSR0 
	MOVF        EEPROM_set_i_L0+1, 0 
	ADDWFC      FARG_EEPROM_set_writebuffer+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;EEPROM.c,27 :: 		for(i=0; i<Len; i++)
	INFSNZ      EEPROM_set_i_L0+0, 1 
	INCF        EEPROM_set_i_L0+1, 1 
;EEPROM.c,30 :: 		}
	GOTO        L_EEPROM_set3
L_EEPROM_set4:
;EEPROM.c,31 :: 		}
L_end_EEPROM_set:
	RETURN      0
; end of _EEPROM_set

_SPCIfFirstRun:

;EEPROM.c,38 :: 		UCHAR SPCIfFirstRun()
;EEPROM.c,42 :: 		temp = EEPROM_Read(0x00);
	CLRF        FARG_EEPROM_Read_address+0 
	CLRF        FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       SPCIfFirstRun_temp_L0+0 
;EEPROM.c,44 :: 		if(temp == 0x55)
	MOVF        SPCIfFirstRun_temp_L0+0, 0 
	XORLW       85
	BTFSS       STATUS+0, 2 
	GOTO        L_SPCIfFirstRun6
;EEPROM.c,45 :: 		return FALSE;
	CLRF        R0 
	GOTO        L_end_SPCIfFirstRun
L_SPCIfFirstRun6:
;EEPROM.c,48 :: 		EEPROM_Write(0x00,0x55);
	CLRF        FARG_EEPROM_Write_address+0 
	CLRF        FARG_EEPROM_Write_address+1 
	MOVLW       85
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;EEPROM.c,49 :: 		return TRUE;
	MOVLW       1
	MOVWF       R0 
;EEPROM.c,51 :: 		}
L_end_SPCIfFirstRun:
	RETURN      0
; end of _SPCIfFirstRun
