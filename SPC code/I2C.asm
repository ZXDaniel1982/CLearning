
_I2CInitial:

;I2C.c,17 :: 		void I2CInitial()
;I2C.c,19 :: 		I2C_CLK_DIRECT = 0;
	BCF         TRISC3_bit+0, BitPos(TRISC3_bit+0) 
;I2C.c,20 :: 		I2C_CLK_WRITE = 1;
	BSF         LATC3_bit+0, BitPos(LATC3_bit+0) 
;I2C.c,21 :: 		I2C_SDA_DIRECT = 0;
	BCF         TRISC4_bit+0, BitPos(TRISC4_bit+0) 
;I2C.c,22 :: 		I2C_SDA_WRITE = 1;
	BSF         LATC4_bit+0, BitPos(LATC4_bit+0) 
;I2C.c,23 :: 		Delay_us(25);
	MOVLW       41
	MOVWF       R13, 0
L_I2CInitial0:
	DECFSZ      R13, 1, 1
	BRA         L_I2CInitial0
	NOP
;I2C.c,24 :: 		}
L_end_I2CInitial:
	RETURN      0
; end of _I2CInitial

_I2CStart:

;I2C.c,26 :: 		void I2CStart()
;I2C.c,28 :: 		I2C_SDA_WRITE = 0;
	BCF         LATC4_bit+0, BitPos(LATC4_bit+0) 
;I2C.c,29 :: 		Delay_us(50);
	MOVLW       83
	MOVWF       R13, 0
L_I2CStart1:
	DECFSZ      R13, 1, 1
	BRA         L_I2CStart1
;I2C.c,30 :: 		I2C_CLK_WRITE = 0;
	BCF         LATC3_bit+0, BitPos(LATC3_bit+0) 
;I2C.c,31 :: 		Delay_us(50);
	MOVLW       83
	MOVWF       R13, 0
L_I2CStart2:
	DECFSZ      R13, 1, 1
	BRA         L_I2CStart2
;I2C.c,32 :: 		}
L_end_I2CStart:
	RETURN      0
; end of _I2CStart

_I2CStop:

;I2C.c,34 :: 		void I2CStop()
;I2C.c,36 :: 		I2C_CLK_WRITE = 1;
	BSF         LATC3_bit+0, BitPos(LATC3_bit+0) 
;I2C.c,37 :: 		Delay_us(50);
	MOVLW       83
	MOVWF       R13, 0
L_I2CStop3:
	DECFSZ      R13, 1, 1
	BRA         L_I2CStop3
;I2C.c,38 :: 		I2C_SDA_WRITE = 1;
	BSF         LATC4_bit+0, BitPos(LATC4_bit+0) 
;I2C.c,39 :: 		Delay_us(50);
	MOVLW       83
	MOVWF       R13, 0
L_I2CStop4:
	DECFSZ      R13, 1, 1
	BRA         L_I2CStop4
;I2C.c,40 :: 		}
L_end_I2CStop:
	RETURN      0
; end of _I2CStop

_I2CSendBit:

;I2C.c,42 :: 		void I2CSendBit(char BitData)
;I2C.c,44 :: 		I2C_SDA_WRITE = BitData;
	BTFSC       FARG_I2CSendBit_BitData+0, 0 
	GOTO        L__I2CSendBit87
	BCF         LATC4_bit+0, BitPos(LATC4_bit+0) 
	GOTO        L__I2CSendBit88
L__I2CSendBit87:
	BSF         LATC4_bit+0, BitPos(LATC4_bit+0) 
L__I2CSendBit88:
;I2C.c,45 :: 		Delay_us(50);
	MOVLW       83
	MOVWF       R13, 0
L_I2CSendBit5:
	DECFSZ      R13, 1, 1
	BRA         L_I2CSendBit5
;I2C.c,46 :: 		I2C_CLK_WRITE = 1;
	BSF         LATC3_bit+0, BitPos(LATC3_bit+0) 
;I2C.c,47 :: 		Delay_us(50);
	MOVLW       83
	MOVWF       R13, 0
L_I2CSendBit6:
	DECFSZ      R13, 1, 1
	BRA         L_I2CSendBit6
;I2C.c,48 :: 		I2C_CLK_WRITE = 0;
	BCF         LATC3_bit+0, BitPos(LATC3_bit+0) 
;I2C.c,49 :: 		Delay_us(50);
	MOVLW       83
	MOVWF       R13, 0
L_I2CSendBit7:
	DECFSZ      R13, 1, 1
	BRA         L_I2CSendBit7
;I2C.c,50 :: 		}
L_end_I2CSendBit:
	RETURN      0
; end of _I2CSendBit

_I2CGetAckFromSlave:

;I2C.c,52 :: 		void I2CGetAckFromSlave()
;I2C.c,56 :: 		I2C_SDA_DIRECT = 1;
	BSF         TRISC4_bit+0, BitPos(TRISC4_bit+0) 
;I2C.c,57 :: 		Delay_us(50);
	MOVLW       83
	MOVWF       R13, 0
L_I2CGetAckFromSlave8:
	DECFSZ      R13, 1, 1
	BRA         L_I2CGetAckFromSlave8
;I2C.c,58 :: 		I2C_CLK_WRITE = 1;
	BSF         LATC3_bit+0, BitPos(LATC3_bit+0) 
;I2C.c,59 :: 		Delay_us(50);
	MOVLW       83
	MOVWF       R13, 0
L_I2CGetAckFromSlave9:
	DECFSZ      R13, 1, 1
	BRA         L_I2CGetAckFromSlave9
;I2C.c,60 :: 		AckFromSlave = I2C_SDA_READ;
	MOVLW       0
	BTFSC       RC4_bit+0, BitPos(RC4_bit+0) 
	MOVLW       1
	MOVWF       R0 
;I2C.c,61 :: 		I2C_CLK_WRITE = 0;
	BCF         LATC3_bit+0, BitPos(LATC3_bit+0) 
;I2C.c,62 :: 		Delay_us(50);
	MOVLW       83
	MOVWF       R13, 0
L_I2CGetAckFromSlave10:
	DECFSZ      R13, 1, 1
	BRA         L_I2CGetAckFromSlave10
;I2C.c,63 :: 		I2C_SDA_DIRECT = 0;
	BCF         TRISC4_bit+0, BitPos(TRISC4_bit+0) 
;I2C.c,64 :: 		Delay_us(50);
	MOVLW       83
	MOVWF       R13, 0
L_I2CGetAckFromSlave11:
	DECFSZ      R13, 1, 1
	BRA         L_I2CGetAckFromSlave11
;I2C.c,65 :: 		}
L_end_I2CGetAckFromSlave:
	RETURN      0
; end of _I2CGetAckFromSlave

_I2CSendByte:

;I2C.c,68 :: 		void I2CSendByte(unsigned char ByteData)
;I2C.c,73 :: 		for(i=0;i<8;i++)
	CLRF        I2CSendByte_i_L0+0 
L_I2CSendByte12:
	MOVLW       8
	SUBWF       I2CSendByte_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_I2CSendByte13
;I2C.c,75 :: 		if((ByteData << i) & 0x80)
	MOVF        I2CSendByte_i_L0+0, 0 
	MOVWF       R0 
	MOVF        FARG_I2CSendByte_ByteData+0, 0 
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R0, 0 
L__I2CSendByte91:
	BZ          L__I2CSendByte92
	RLCF        R2, 1 
	BCF         R2, 0 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__I2CSendByte91
L__I2CSendByte92:
	BTFSS       R2, 7 
	GOTO        L_I2CSendByte15
;I2C.c,76 :: 		SendBit = 1;
	MOVLW       1
	MOVWF       I2CSendByte_SendBit_L0+0 
	GOTO        L_I2CSendByte16
L_I2CSendByte15:
;I2C.c,78 :: 		SendBit = 0;
	CLRF        I2CSendByte_SendBit_L0+0 
L_I2CSendByte16:
;I2C.c,80 :: 		I2CSendBit(SendBit);
	MOVF        I2CSendByte_SendBit_L0+0, 0 
	MOVWF       FARG_I2CSendBit_BitData+0 
	CALL        _I2CSendBit+0, 0
;I2C.c,73 :: 		for(i=0;i<8;i++)
	INCF        I2CSendByte_i_L0+0, 1 
;I2C.c,81 :: 		}
	GOTO        L_I2CSendByte12
L_I2CSendByte13:
;I2C.c,82 :: 		I2CGetAckFromSlave();
	CALL        _I2CGetAckFromSlave+0, 0
;I2C.c,83 :: 		}
L_end_I2CSendByte:
	RETURN      0
; end of _I2CSendByte

_I2CReadBit:

;I2C.c,85 :: 		char I2CReadBit()
;I2C.c,89 :: 		I2C_CLK_WRITE = 1;
	BSF         LATC3_bit+0, BitPos(LATC3_bit+0) 
;I2C.c,90 :: 		Delay_us(50);
	MOVLW       83
	MOVWF       R13, 0
L_I2CReadBit17:
	DECFSZ      R13, 1, 1
	BRA         L_I2CReadBit17
;I2C.c,91 :: 		BitData = I2C_SDA_READ;
	MOVLW       0
	BTFSC       RC4_bit+0, BitPos(RC4_bit+0) 
	MOVLW       1
	MOVWF       R1 
;I2C.c,92 :: 		I2C_CLK_WRITE = 0;
	BCF         LATC3_bit+0, BitPos(LATC3_bit+0) 
;I2C.c,93 :: 		Delay_us(50);
	MOVLW       83
	MOVWF       R13, 0
L_I2CReadBit18:
	DECFSZ      R13, 1, 1
	BRA         L_I2CReadBit18
;I2C.c,95 :: 		return BitData;
	MOVF        R1, 0 
	MOVWF       R0 
;I2C.c,96 :: 		}
L_end_I2CReadBit:
	RETURN      0
; end of _I2CReadBit

_I2CSendAckToSlave:

;I2C.c,98 :: 		void I2CSendAckToSlave(char AckType)
;I2C.c,102 :: 		I2C_SDA_DIRECT = 0;
	BCF         TRISC4_bit+0, BitPos(TRISC4_bit+0) 
;I2C.c,103 :: 		Delay_us(50);
	MOVLW       83
	MOVWF       R13, 0
L_I2CSendAckToSlave19:
	DECFSZ      R13, 1, 1
	BRA         L_I2CSendAckToSlave19
;I2C.c,104 :: 		I2C_SDA_WRITE = AckType;
	BTFSC       FARG_I2CSendAckToSlave_AckType+0, 0 
	GOTO        L__I2CSendAckToSlave95
	BCF         LATC4_bit+0, BitPos(LATC4_bit+0) 
	GOTO        L__I2CSendAckToSlave96
L__I2CSendAckToSlave95:
	BSF         LATC4_bit+0, BitPos(LATC4_bit+0) 
L__I2CSendAckToSlave96:
;I2C.c,105 :: 		Delay_us(50);
	MOVLW       83
	MOVWF       R13, 0
L_I2CSendAckToSlave20:
	DECFSZ      R13, 1, 1
	BRA         L_I2CSendAckToSlave20
;I2C.c,106 :: 		I2C_CLK_WRITE = 1;
	BSF         LATC3_bit+0, BitPos(LATC3_bit+0) 
;I2C.c,107 :: 		Delay_us(50);
	MOVLW       83
	MOVWF       R13, 0
L_I2CSendAckToSlave21:
	DECFSZ      R13, 1, 1
	BRA         L_I2CSendAckToSlave21
;I2C.c,108 :: 		I2C_CLK_WRITE = 0;
	BCF         LATC3_bit+0, BitPos(LATC3_bit+0) 
;I2C.c,109 :: 		Delay_us(50);
	MOVLW       83
	MOVWF       R13, 0
L_I2CSendAckToSlave22:
	DECFSZ      R13, 1, 1
	BRA         L_I2CSendAckToSlave22
;I2C.c,110 :: 		}
L_end_I2CSendAckToSlave:
	RETURN      0
; end of _I2CSendAckToSlave

_I2CReadByte:

;I2C.c,112 :: 		unsigned char I2CReadByte(char AckCmd)
;I2C.c,116 :: 		unsigned char ByteData = 0;;
	CLRF        I2CReadByte_ByteData_L0+0 
;I2C.c,118 :: 		I2C_SDA_DIRECT = 1;
	BSF         TRISC4_bit+0, BitPos(TRISC4_bit+0) 
;I2C.c,119 :: 		Delay_us(25);
	MOVLW       41
	MOVWF       R13, 0
L_I2CReadByte23:
	DECFSZ      R13, 1, 1
	BRA         L_I2CReadByte23
	NOP
;I2C.c,121 :: 		for(i=0;i<8;i++)
	CLRF        I2CReadByte_i_L0+0 
L_I2CReadByte24:
	MOVLW       8
	SUBWF       I2CReadByte_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_I2CReadByte25
;I2C.c,123 :: 		ReadBit = I2CReadBit();
	CALL        _I2CReadBit+0, 0
	MOVF        R0, 0 
	MOVWF       I2CReadByte_ReadBit_L0+0 
;I2C.c,124 :: 		ByteData |= (ReadBit << (7-i));
	MOVF        I2CReadByte_i_L0+0, 0 
	SUBLW       7
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       R1 
	MOVF        I2CReadByte_ReadBit_L0+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__I2CReadByte98:
	BZ          L__I2CReadByte99
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__I2CReadByte98
L__I2CReadByte99:
	MOVF        R0, 0 
	IORWF       I2CReadByte_ByteData_L0+0, 1 
;I2C.c,121 :: 		for(i=0;i<8;i++)
	INCF        I2CReadByte_i_L0+0, 1 
;I2C.c,125 :: 		}
	GOTO        L_I2CReadByte24
L_I2CReadByte25:
;I2C.c,126 :: 		I2CSendAckToSlave(AckCmd);
	MOVF        FARG_I2CReadByte_AckCmd+0, 0 
	MOVWF       FARG_I2CSendAckToSlave_AckType+0 
	CALL        _I2CSendAckToSlave+0, 0
;I2C.c,128 :: 		return ByteData;
	MOVF        I2CReadByte_ByteData_L0+0, 0 
	MOVWF       R0 
;I2C.c,129 :: 		}
L_end_I2CReadByte:
	RETURN      0
; end of _I2CReadByte

_I2C_get:

;I2C.c,170 :: 		void I2C_get(UCHAR QTAddress,UCHAR QTRegister,UCHAR *Keystate,UCHAR Length)
;I2C.c,174 :: 		I2CStart();
	CALL        _I2CStart+0, 0
;I2C.c,175 :: 		I2CSendByte((QTAddress << 1) + I2C_WRITE_FLAG);      //117*2=234    17*2=34
	MOVF        FARG_I2C_get_QTAddress+0, 0 
	MOVWF       FARG_I2CSendByte_ByteData+0 
	RLCF        FARG_I2CSendByte_ByteData+0, 1 
	BCF         FARG_I2CSendByte_ByteData+0, 0 
	CALL        _I2CSendByte+0, 0
;I2C.c,176 :: 		I2CSendByte(QTRegister);
	MOVF        FARG_I2C_get_QTRegister+0, 0 
	MOVWF       FARG_I2CSendByte_ByteData+0 
	CALL        _I2CSendByte+0, 0
;I2C.c,177 :: 		I2CStop();
	CALL        _I2CStop+0, 0
;I2C.c,178 :: 		asm nop;
	NOP
;I2C.c,179 :: 		Delay_us(2);
	MOVLW       3
	MOVWF       R13, 0
L_I2C_get27:
	DECFSZ      R13, 1, 1
	BRA         L_I2C_get27
;I2C.c,181 :: 		I2CStart();
	CALL        _I2CStart+0, 0
;I2C.c,182 :: 		I2CSendByte((QTAddress << 1) + I2C_READ_FLAG);      //117*2+1=235
	MOVF        FARG_I2C_get_QTAddress+0, 0 
	MOVWF       FARG_I2CSendByte_ByteData+0 
	RLCF        FARG_I2CSendByte_ByteData+0, 1 
	BCF         FARG_I2CSendByte_ByteData+0, 0 
	INCF        FARG_I2CSendByte_ByteData+0, 1 
	CALL        _I2CSendByte+0, 0
;I2C.c,184 :: 		for(j=0;j<Length-1;j++)
	CLRF        I2C_get_j_L0+0 
L_I2C_get28:
	DECF        FARG_I2C_get_Length+0, 0 
	MOVWF       R1 
	CLRF        R2 
	MOVLW       0
	SUBWFB      R2, 1 
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__I2C_get101
	MOVF        R1, 0 
	SUBWF       I2C_get_j_L0+0, 0 
L__I2C_get101:
	BTFSC       STATUS+0, 0 
	GOTO        L_I2C_get29
;I2C.c,186 :: 		*(Keystate+j) = I2CReadByte(0);
	MOVF        I2C_get_j_L0+0, 0 
	ADDWF       FARG_I2C_get_Keystate+0, 0 
	MOVWF       FLOC__I2C_get+0 
	MOVLW       0
	ADDWFC      FARG_I2C_get_Keystate+1, 0 
	MOVWF       FLOC__I2C_get+1 
	CLRF        FARG_I2CReadByte_AckCmd+0 
	CALL        _I2CReadByte+0, 0
	MOVFF       FLOC__I2C_get+0, FSR1
	MOVFF       FLOC__I2C_get+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;I2C.c,184 :: 		for(j=0;j<Length-1;j++)
	INCF        I2C_get_j_L0+0, 1 
;I2C.c,187 :: 		}
	GOTO        L_I2C_get28
L_I2C_get29:
;I2C.c,188 :: 		*(Keystate+Length-1) = I2CReadByte(1);
	MOVF        FARG_I2C_get_Length+0, 0 
	ADDWF       FARG_I2C_get_Keystate+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      FARG_I2C_get_Keystate+1, 0 
	MOVWF       R1 
	MOVLW       1
	SUBWF       R0, 0 
	MOVWF       FLOC__I2C_get+0 
	MOVLW       0
	SUBWFB      R1, 0 
	MOVWF       FLOC__I2C_get+1 
	MOVLW       1
	MOVWF       FARG_I2CReadByte_AckCmd+0 
	CALL        _I2CReadByte+0, 0
	MOVFF       FLOC__I2C_get+0, FSR1
	MOVFF       FLOC__I2C_get+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;I2C.c,190 :: 		I2CStop();
	CALL        _I2CStop+0, 0
;I2C.c,191 :: 		asm nop;
	NOP
;I2C.c,192 :: 		}
L_end_I2C_get:
	RETURN      0
; end of _I2C_get

_I2C_write:

;I2C.c,222 :: 		unsigned char Length)
;I2C.c,233 :: 		I2CStart();
	CALL        _I2CStart+0, 0
;I2C.c,234 :: 		I2CSendByte(QTAddress * 2 + I2C_WRITE_FLAG);
	MOVF        FARG_I2C_write_QTAddress+0, 0 
	MOVWF       FARG_I2CSendByte_ByteData+0 
	RLCF        FARG_I2CSendByte_ByteData+0, 1 
	BCF         FARG_I2CSendByte_ByteData+0, 0 
	CALL        _I2CSendByte+0, 0
;I2C.c,235 :: 		I2CSendByte(QTRegister);
	MOVF        FARG_I2C_write_QTRegister+0, 0 
	MOVWF       FARG_I2CSendByte_ByteData+0 
	CALL        _I2CSendByte+0, 0
;I2C.c,237 :: 		for(i=0;i<Length;i++)
	CLRF        I2C_write_i_L0+0 
L_I2C_write31:
	MOVF        FARG_I2C_write_Length+0, 0 
	SUBWF       I2C_write_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_I2C_write32
;I2C.c,239 :: 		I2CSendByte(*(Keystate+i));
	MOVF        I2C_write_i_L0+0, 0 
	ADDWF       FARG_I2C_write_Keystate+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_I2C_write_Keystate+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_I2CSendByte_ByteData+0 
	CALL        _I2CSendByte+0, 0
;I2C.c,240 :: 		Delay_ms(200);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_I2C_write34:
	DECFSZ      R13, 1, 1
	BRA         L_I2C_write34
	DECFSZ      R12, 1, 1
	BRA         L_I2C_write34
	DECFSZ      R11, 1, 1
	BRA         L_I2C_write34
	NOP
	NOP
;I2C.c,237 :: 		for(i=0;i<Length;i++)
	INCF        I2C_write_i_L0+0, 1 
;I2C.c,241 :: 		}
	GOTO        L_I2C_write31
L_I2C_write32:
;I2C.c,242 :: 		I2CStop();
	CALL        _I2CStop+0, 0
;I2C.c,243 :: 		}
L_end_I2C_write:
	RETURN      0
; end of _I2C_write

_I2C_send:

;I2C.c,250 :: 		void I2C_send(UCHAR DataToSlave)
;I2C.c,253 :: 		dummy =  SSP1BUF;
	MOVF        SSP1BUF+0, 0 
	MOVWF       I2C_send_dummy_L0+0 
;I2C.c,255 :: 		SSP1BUF = DataToSlave;
	MOVF        FARG_I2C_send_DataToSlave+0, 0 
	MOVWF       SSP1BUF+0 
;I2C.c,256 :: 		WaitSlaveACK();
	CALL        _WaitSlaveACK+0, 0
;I2C.c,257 :: 		}
L_end_I2C_send:
	RETURN      0
; end of _I2C_send

_I2C_receive:

;I2C.c,265 :: 		UCHAR I2C_receive()
;I2C.c,268 :: 		unsigned int protect=0xffff;
	MOVLW       255
	MOVWF       I2C_receive_protect_L0+0 
	MOVLW       255
	MOVWF       I2C_receive_protect_L0+1 
;I2C.c,270 :: 		RCEN_SSP1CON2_bit = 1;
	BSF         RCEN_SSP1CON2_bit+0, BitPos(RCEN_SSP1CON2_bit+0) 
;I2C.c,271 :: 		while((!(BF_SSP1STAT_bit)) && (--protect));
L_I2C_receive35:
	BTFSC       BF_SSP1STAT_bit+0, BitPos(BF_SSP1STAT_bit+0) 
	GOTO        L_I2C_receive36
	MOVLW       1
	SUBWF       I2C_receive_protect_L0+0, 1 
	MOVLW       0
	SUBWFB      I2C_receive_protect_L0+1, 1 
	MOVF        I2C_receive_protect_L0+0, 0 
	IORWF       I2C_receive_protect_L0+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_I2C_receive36
L__I2C_receive76:
	GOTO        L_I2C_receive35
L_I2C_receive36:
;I2C.c,272 :: 		protect = 0xffff;
	MOVLW       255
	MOVWF       I2C_receive_protect_L0+0 
	MOVLW       255
	MOVWF       I2C_receive_protect_L0+1 
;I2C.c,273 :: 		DataFromSlave = SSP1BUF;
	MOVF        SSP1BUF+0, 0 
	MOVWF       R1 
;I2C.c,274 :: 		while((!(SSP1IF_bit)) && (--protect));
L_I2C_receive39:
	BTFSC       SSP1IF_bit+0, BitPos(SSP1IF_bit+0) 
	GOTO        L_I2C_receive40
	MOVLW       1
	SUBWF       I2C_receive_protect_L0+0, 1 
	MOVLW       0
	SUBWFB      I2C_receive_protect_L0+1, 1 
	MOVF        I2C_receive_protect_L0+0, 0 
	IORWF       I2C_receive_protect_L0+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_I2C_receive40
L__I2C_receive75:
	GOTO        L_I2C_receive39
L_I2C_receive40:
;I2C.c,275 :: 		SSP1IF_bit = 0;
	BCF         SSP1IF_bit+0, BitPos(SSP1IF_bit+0) 
;I2C.c,277 :: 		if(protect == 0)
	MOVLW       0
	XORWF       I2C_receive_protect_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__I2C_receive105
	MOVLW       0
	XORWF       I2C_receive_protect_L0+0, 0 
L__I2C_receive105:
	BTFSS       STATUS+0, 2 
	GOTO        L_I2C_receive43
;I2C.c,280 :: 		I2CError = 1;
	MOVLW       1
	MOVWF       _I2CError+0 
;I2C.c,281 :: 		}
L_I2C_receive43:
;I2C.c,283 :: 		return DataFromSlave;
	MOVF        R1, 0 
	MOVWF       R0 
;I2C.c,284 :: 		}
L_end_I2C_receive:
	RETURN      0
; end of _I2C_receive

_I2C_start:

;I2C.c,291 :: 		void I2C_start()
;I2C.c,293 :: 		unsigned int protect = 0xffff;
	MOVLW       255
	MOVWF       I2C_start_protect_L0+0 
	MOVLW       255
	MOVWF       I2C_start_protect_L0+1 
;I2C.c,295 :: 		SEN_SSP1CON2_bit = 1;
	BSF         SEN_SSP1CON2_bit+0, BitPos(SEN_SSP1CON2_bit+0) 
;I2C.c,296 :: 		while((!(SSP1IF_bit)) && (--protect));
L_I2C_start44:
	BTFSC       SSP1IF_bit+0, BitPos(SSP1IF_bit+0) 
	GOTO        L_I2C_start45
	MOVLW       1
	SUBWF       I2C_start_protect_L0+0, 1 
	MOVLW       0
	SUBWFB      I2C_start_protect_L0+1, 1 
	MOVF        I2C_start_protect_L0+0, 0 
	IORWF       I2C_start_protect_L0+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_I2C_start45
L__I2C_start77:
	GOTO        L_I2C_start44
L_I2C_start45:
;I2C.c,297 :: 		SSP1IF_bit = 0;
	BCF         SSP1IF_bit+0, BitPos(SSP1IF_bit+0) 
;I2C.c,299 :: 		if(protect == 0)
	MOVLW       0
	XORWF       I2C_start_protect_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__I2C_start107
	MOVLW       0
	XORWF       I2C_start_protect_L0+0, 0 
L__I2C_start107:
	BTFSS       STATUS+0, 2 
	GOTO        L_I2C_start48
;I2C.c,302 :: 		I2CError = 1;
	MOVLW       1
	MOVWF       _I2CError+0 
;I2C.c,303 :: 		}
L_I2C_start48:
;I2C.c,304 :: 		}
L_end_I2C_start:
	RETURN      0
; end of _I2C_start

_I2C_stop:

;I2C.c,311 :: 		void I2C_stop()
;I2C.c,313 :: 		unsigned int protect = 0xffff;
	MOVLW       255
	MOVWF       I2C_stop_protect_L0+0 
	MOVLW       255
	MOVWF       I2C_stop_protect_L0+1 
;I2C.c,316 :: 		PEN_SSP1CON2_bit = 1;
	BSF         PEN_SSP1CON2_bit+0, BitPos(PEN_SSP1CON2_bit+0) 
;I2C.c,317 :: 		while((!(SSP1IF_bit)) && (--protect));
L_I2C_stop49:
	BTFSC       SSP1IF_bit+0, BitPos(SSP1IF_bit+0) 
	GOTO        L_I2C_stop50
	MOVLW       1
	SUBWF       I2C_stop_protect_L0+0, 1 
	MOVLW       0
	SUBWFB      I2C_stop_protect_L0+1, 1 
	MOVF        I2C_stop_protect_L0+0, 0 
	IORWF       I2C_stop_protect_L0+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_I2C_stop50
L__I2C_stop78:
	GOTO        L_I2C_stop49
L_I2C_stop50:
;I2C.c,318 :: 		SSP1IF_bit = 0;
	BCF         SSP1IF_bit+0, BitPos(SSP1IF_bit+0) 
;I2C.c,320 :: 		if(protect == 0)
	MOVLW       0
	XORWF       I2C_stop_protect_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__I2C_stop109
	MOVLW       0
	XORWF       I2C_stop_protect_L0+0, 0 
L__I2C_stop109:
	BTFSS       STATUS+0, 2 
	GOTO        L_I2C_stop53
;I2C.c,323 :: 		I2CError = 1;
	MOVLW       1
	MOVWF       _I2CError+0 
;I2C.c,324 :: 		}
L_I2C_stop53:
;I2C.c,325 :: 		}
L_end_I2C_stop:
	RETURN      0
; end of _I2C_stop

_WaitI2CIdel:

;I2C.c,332 :: 		void WaitI2CIdel()
;I2C.c,335 :: 		SSP1CON2_Idel = SEN + RSEN + PEN + RCEN + ACKEN;
	MOVLW       185
	MOVWF       R2 
;I2C.c,336 :: 		while((SSP1CON2 & SSP1CON2_Idel) | R_W_SSP1STAT_bit);
L_WaitI2CIdel54:
	MOVF        R2, 0 
	ANDWF       SSP1CON2+0, 0 
	MOVWF       R1 
	CLRF        R0 
	BTFSC       R_W_SSP1STAT_bit+0, BitPos(R_W_SSP1STAT_bit+0) 
	INCF        R0, 1 
	MOVF        R1, 0 
	IORWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_WaitI2CIdel55
	GOTO        L_WaitI2CIdel54
L_WaitI2CIdel55:
;I2C.c,337 :: 		}
L_end_WaitI2CIdel:
	RETURN      0
; end of _WaitI2CIdel

_WaitSlaveACK:

;I2C.c,344 :: 		void WaitSlaveACK()
;I2C.c,346 :: 		unsigned int protect = 0xffff;
	MOVLW       255
	MOVWF       WaitSlaveACK_protect_L0+0 
	MOVLW       255
	MOVWF       WaitSlaveACK_protect_L0+1 
;I2C.c,348 :: 		while((!(SSP1IF_bit)) && (--protect));
L_WaitSlaveACK56:
	BTFSC       SSP1IF_bit+0, BitPos(SSP1IF_bit+0) 
	GOTO        L_WaitSlaveACK57
	MOVLW       1
	SUBWF       WaitSlaveACK_protect_L0+0, 1 
	MOVLW       0
	SUBWFB      WaitSlaveACK_protect_L0+1, 1 
	MOVF        WaitSlaveACK_protect_L0+0, 0 
	IORWF       WaitSlaveACK_protect_L0+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_WaitSlaveACK57
L__WaitSlaveACK80:
	GOTO        L_WaitSlaveACK56
L_WaitSlaveACK57:
;I2C.c,349 :: 		SSP1IF_bit = 0;
	BCF         SSP1IF_bit+0, BitPos(SSP1IF_bit+0) 
;I2C.c,350 :: 		protect = 0xffff;
	MOVLW       255
	MOVWF       WaitSlaveACK_protect_L0+0 
	MOVLW       255
	MOVWF       WaitSlaveACK_protect_L0+1 
;I2C.c,352 :: 		while((ACKSTAT_SSP1CON2_bit) && (--protect));
L_WaitSlaveACK60:
	BTFSS       ACKSTAT_SSP1CON2_bit+0, BitPos(ACKSTAT_SSP1CON2_bit+0) 
	GOTO        L_WaitSlaveACK61
	MOVLW       1
	SUBWF       WaitSlaveACK_protect_L0+0, 1 
	MOVLW       0
	SUBWFB      WaitSlaveACK_protect_L0+1, 1 
	MOVF        WaitSlaveACK_protect_L0+0, 0 
	IORWF       WaitSlaveACK_protect_L0+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_WaitSlaveACK61
L__WaitSlaveACK79:
	GOTO        L_WaitSlaveACK60
L_WaitSlaveACK61:
;I2C.c,353 :: 		ACKSTAT_SSP1CON2_bit = 1;
	BSF         ACKSTAT_SSP1CON2_bit+0, BitPos(ACKSTAT_SSP1CON2_bit+0) 
;I2C.c,355 :: 		if(protect == 0)
	MOVLW       0
	XORWF       WaitSlaveACK_protect_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WaitSlaveACK112
	MOVLW       0
	XORWF       WaitSlaveACK_protect_L0+0, 0 
L__WaitSlaveACK112:
	BTFSS       STATUS+0, 2 
	GOTO        L_WaitSlaveACK64
;I2C.c,358 :: 		I2CError = 1;
	MOVLW       1
	MOVWF       _I2CError+0 
;I2C.c,359 :: 		}
L_WaitSlaveACK64:
;I2C.c,360 :: 		}
L_end_WaitSlaveACK:
	RETURN      0
; end of _WaitSlaveACK

_SendACKToSlave:

;I2C.c,367 :: 		void SendACKToSlave()
;I2C.c,369 :: 		unsigned int protect = 0xffff;
	MOVLW       255
	MOVWF       SendACKToSlave_protect_L0+0 
	MOVLW       255
	MOVWF       SendACKToSlave_protect_L0+1 
;I2C.c,372 :: 		ACKEN_SSP1CON2_bit = 1;
	BSF         ACKEN_SSP1CON2_bit+0, BitPos(ACKEN_SSP1CON2_bit+0) 
;I2C.c,373 :: 		ACKDT_SSP1CON2_bit = 0;
	BCF         ACKDT_SSP1CON2_bit+0, BitPos(ACKDT_SSP1CON2_bit+0) 
;I2C.c,374 :: 		while((!(SSP1IF_bit)) && (--protect));
L_SendACKToSlave65:
	BTFSC       SSP1IF_bit+0, BitPos(SSP1IF_bit+0) 
	GOTO        L_SendACKToSlave66
	MOVLW       1
	SUBWF       SendACKToSlave_protect_L0+0, 1 
	MOVLW       0
	SUBWFB      SendACKToSlave_protect_L0+1, 1 
	MOVF        SendACKToSlave_protect_L0+0, 0 
	IORWF       SendACKToSlave_protect_L0+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_SendACKToSlave66
L__SendACKToSlave81:
	GOTO        L_SendACKToSlave65
L_SendACKToSlave66:
;I2C.c,375 :: 		SSP1IF_bit = 0;
	BCF         SSP1IF_bit+0, BitPos(SSP1IF_bit+0) 
;I2C.c,377 :: 		if(protect == 0)
	MOVLW       0
	XORWF       SendACKToSlave_protect_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SendACKToSlave114
	MOVLW       0
	XORWF       SendACKToSlave_protect_L0+0, 0 
L__SendACKToSlave114:
	BTFSS       STATUS+0, 2 
	GOTO        L_SendACKToSlave69
;I2C.c,380 :: 		I2CError = 1;
	MOVLW       1
	MOVWF       _I2CError+0 
;I2C.c,381 :: 		}
L_SendACKToSlave69:
;I2C.c,382 :: 		}
L_end_SendACKToSlave:
	RETURN      0
; end of _SendACKToSlave

_SendNACKToSlave:

;I2C.c,389 :: 		void SendNACKToSlave()
;I2C.c,391 :: 		unsigned int protect = 0xffff;
	MOVLW       255
	MOVWF       SendNACKToSlave_protect_L0+0 
	MOVLW       255
	MOVWF       SendNACKToSlave_protect_L0+1 
;I2C.c,394 :: 		ACKEN_SSP1CON2_bit = 1;
	BSF         ACKEN_SSP1CON2_bit+0, BitPos(ACKEN_SSP1CON2_bit+0) 
;I2C.c,395 :: 		ACKDT_SSP1CON2_bit = 1;
	BSF         ACKDT_SSP1CON2_bit+0, BitPos(ACKDT_SSP1CON2_bit+0) 
;I2C.c,396 :: 		while((!(SSP1IF_bit)) && (--protect));
L_SendNACKToSlave70:
	BTFSC       SSP1IF_bit+0, BitPos(SSP1IF_bit+0) 
	GOTO        L_SendNACKToSlave71
	MOVLW       1
	SUBWF       SendNACKToSlave_protect_L0+0, 1 
	MOVLW       0
	SUBWFB      SendNACKToSlave_protect_L0+1, 1 
	MOVF        SendNACKToSlave_protect_L0+0, 0 
	IORWF       SendNACKToSlave_protect_L0+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_SendNACKToSlave71
L__SendNACKToSlave82:
	GOTO        L_SendNACKToSlave70
L_SendNACKToSlave71:
;I2C.c,397 :: 		SSP1IF_bit = 0;
	BCF         SSP1IF_bit+0, BitPos(SSP1IF_bit+0) 
;I2C.c,399 :: 		if(protect == 0)
	MOVLW       0
	XORWF       SendNACKToSlave_protect_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SendNACKToSlave116
	MOVLW       0
	XORWF       SendNACKToSlave_protect_L0+0, 0 
L__SendNACKToSlave116:
	BTFSS       STATUS+0, 2 
	GOTO        L_SendNACKToSlave74
;I2C.c,402 :: 		I2CError = 1;
	MOVLW       1
	MOVWF       _I2CError+0 
;I2C.c,403 :: 		}
L_SendNACKToSlave74:
;I2C.c,404 :: 		}
L_end_SendNACKToSlave:
	RETURN      0
; end of _SendNACKToSlave
