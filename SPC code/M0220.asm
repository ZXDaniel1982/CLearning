
_nybble:

;M0220.c,10 :: 		void nybble()
;M0220.c,12 :: 		LCD_EN = 1;
	BSF         LATF7_bit+0, BitPos(LATF7_bit+0) 
;M0220.c,13 :: 		Delay_us(50);
	MOVLW       83
	MOVWF       R13, 0
L_nybble0:
	DECFSZ      R13, 1, 1
	BRA         L_nybble0
;M0220.c,14 :: 		LCD_EN = 0;
	BCF         LATF7_bit+0, BitPos(LATF7_bit+0) 
;M0220.c,15 :: 		Delay_us(50);
	MOVLW       83
	MOVWF       R13, 0
L_nybble1:
	DECFSZ      R13, 1, 1
	BRA         L_nybble1
;M0220.c,16 :: 		}
L_end_nybble:
	RETURN      0
; end of _nybble

_writecom:

;M0220.c,23 :: 		void writecom(unsigned char command)
;M0220.c,25 :: 		LATE7_bit = (command >> 7) & 0x01;
	MOVLW       7
	MOVWF       R1 
	MOVF        FARG_writecom_command+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__writecom15:
	BZ          L__writecom16
	RRCF        R0, 1 
	BCF         R0, 7 
	ADDLW       255
	GOTO        L__writecom15
L__writecom16:
	MOVLW       1
	ANDWF       R0, 1 
	BTFSC       R0, 0 
	GOTO        L__writecom17
	BCF         LATE7_bit+0, BitPos(LATE7_bit+0) 
	GOTO        L__writecom18
L__writecom17:
	BSF         LATE7_bit+0, BitPos(LATE7_bit+0) 
L__writecom18:
;M0220.c,26 :: 		LATE6_bit = (command >> 6) & 0x01;
	MOVLW       6
	MOVWF       R1 
	MOVF        FARG_writecom_command+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__writecom19:
	BZ          L__writecom20
	RRCF        R0, 1 
	BCF         R0, 7 
	ADDLW       255
	GOTO        L__writecom19
L__writecom20:
	MOVLW       1
	ANDWF       R0, 1 
	BTFSC       R0, 0 
	GOTO        L__writecom21
	BCF         LATE6_bit+0, BitPos(LATE6_bit+0) 
	GOTO        L__writecom22
L__writecom21:
	BSF         LATE6_bit+0, BitPos(LATE6_bit+0) 
L__writecom22:
;M0220.c,27 :: 		LATE5_bit = (command >> 5) & 0x01;
	MOVLW       5
	MOVWF       R1 
	MOVF        FARG_writecom_command+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__writecom23:
	BZ          L__writecom24
	RRCF        R0, 1 
	BCF         R0, 7 
	ADDLW       255
	GOTO        L__writecom23
L__writecom24:
	MOVLW       1
	ANDWF       R0, 1 
	BTFSC       R0, 0 
	GOTO        L__writecom25
	BCF         LATE5_bit+0, BitPos(LATE5_bit+0) 
	GOTO        L__writecom26
L__writecom25:
	BSF         LATE5_bit+0, BitPos(LATE5_bit+0) 
L__writecom26:
;M0220.c,28 :: 		LATE4_bit = (command >> 4) & 0x01;
	MOVF        FARG_writecom_command+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVLW       1
	ANDWF       R0, 1 
	BTFSC       R0, 0 
	GOTO        L__writecom27
	BCF         LATE4_bit+0, BitPos(LATE4_bit+0) 
	GOTO        L__writecom28
L__writecom27:
	BSF         LATE4_bit+0, BitPos(LATE4_bit+0) 
L__writecom28:
;M0220.c,29 :: 		LATF5_bit = 0;      //LCD_RS = 0;
	BCF         LATF5_bit+0, BitPos(LATF5_bit+0) 
;M0220.c,30 :: 		nybble();
	CALL        _nybble+0, 0
;M0220.c,32 :: 		LATE7_bit = (command >> 3) & 0x01;
	MOVF        FARG_writecom_command+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVLW       1
	ANDWF       R0, 1 
	BTFSC       R0, 0 
	GOTO        L__writecom29
	BCF         LATE7_bit+0, BitPos(LATE7_bit+0) 
	GOTO        L__writecom30
L__writecom29:
	BSF         LATE7_bit+0, BitPos(LATE7_bit+0) 
L__writecom30:
;M0220.c,33 :: 		LATE6_bit = (command >> 2) & 0x01;
	MOVF        FARG_writecom_command+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVLW       1
	ANDWF       R0, 1 
	BTFSC       R0, 0 
	GOTO        L__writecom31
	BCF         LATE6_bit+0, BitPos(LATE6_bit+0) 
	GOTO        L__writecom32
L__writecom31:
	BSF         LATE6_bit+0, BitPos(LATE6_bit+0) 
L__writecom32:
;M0220.c,34 :: 		LATE5_bit = (command >> 1) & 0x01;
	MOVF        FARG_writecom_command+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVLW       1
	ANDWF       R0, 1 
	BTFSC       R0, 0 
	GOTO        L__writecom33
	BCF         LATE5_bit+0, BitPos(LATE5_bit+0) 
	GOTO        L__writecom34
L__writecom33:
	BSF         LATE5_bit+0, BitPos(LATE5_bit+0) 
L__writecom34:
;M0220.c,35 :: 		LATE4_bit = command & 0x01;
	MOVLW       1
	ANDWF       FARG_writecom_command+0, 0 
	MOVWF       R0 
	BTFSC       R0, 0 
	GOTO        L__writecom35
	BCF         LATE4_bit+0, BitPos(LATE4_bit+0) 
	GOTO        L__writecom36
L__writecom35:
	BSF         LATE4_bit+0, BitPos(LATE4_bit+0) 
L__writecom36:
;M0220.c,36 :: 		nybble();
	CALL        _nybble+0, 0
;M0220.c,37 :: 		}
L_end_writecom:
	RETURN      0
; end of _writecom

_writedata:

;M0220.c,44 :: 		void writedata(unsigned char adata)
;M0220.c,46 :: 		LATE7_bit = (adata >> 7) & 0x01;
	MOVLW       7
	MOVWF       R1 
	MOVF        FARG_writedata_adata+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__writedata38:
	BZ          L__writedata39
	RRCF        R0, 1 
	BCF         R0, 7 
	ADDLW       255
	GOTO        L__writedata38
L__writedata39:
	MOVLW       1
	ANDWF       R0, 1 
	BTFSC       R0, 0 
	GOTO        L__writedata40
	BCF         LATE7_bit+0, BitPos(LATE7_bit+0) 
	GOTO        L__writedata41
L__writedata40:
	BSF         LATE7_bit+0, BitPos(LATE7_bit+0) 
L__writedata41:
;M0220.c,47 :: 		LATE6_bit = (adata >> 6) & 0x01;
	MOVLW       6
	MOVWF       R1 
	MOVF        FARG_writedata_adata+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__writedata42:
	BZ          L__writedata43
	RRCF        R0, 1 
	BCF         R0, 7 
	ADDLW       255
	GOTO        L__writedata42
L__writedata43:
	MOVLW       1
	ANDWF       R0, 1 
	BTFSC       R0, 0 
	GOTO        L__writedata44
	BCF         LATE6_bit+0, BitPos(LATE6_bit+0) 
	GOTO        L__writedata45
L__writedata44:
	BSF         LATE6_bit+0, BitPos(LATE6_bit+0) 
L__writedata45:
;M0220.c,48 :: 		LATE5_bit = (adata >> 5) & 0x01;
	MOVLW       5
	MOVWF       R1 
	MOVF        FARG_writedata_adata+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__writedata46:
	BZ          L__writedata47
	RRCF        R0, 1 
	BCF         R0, 7 
	ADDLW       255
	GOTO        L__writedata46
L__writedata47:
	MOVLW       1
	ANDWF       R0, 1 
	BTFSC       R0, 0 
	GOTO        L__writedata48
	BCF         LATE5_bit+0, BitPos(LATE5_bit+0) 
	GOTO        L__writedata49
L__writedata48:
	BSF         LATE5_bit+0, BitPos(LATE5_bit+0) 
L__writedata49:
;M0220.c,49 :: 		LATE4_bit = (adata >> 4) & 0x01;
	MOVF        FARG_writedata_adata+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVLW       1
	ANDWF       R0, 1 
	BTFSC       R0, 0 
	GOTO        L__writedata50
	BCF         LATE4_bit+0, BitPos(LATE4_bit+0) 
	GOTO        L__writedata51
L__writedata50:
	BSF         LATE4_bit+0, BitPos(LATE4_bit+0) 
L__writedata51:
;M0220.c,50 :: 		LCD_RS = 1;
	BSF         LATF5_bit+0, BitPos(LATF5_bit+0) 
;M0220.c,51 :: 		nybble();
	CALL        _nybble+0, 0
;M0220.c,53 :: 		LATE7_bit = (adata >> 3) & 0x01;
	MOVF        FARG_writedata_adata+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVLW       1
	ANDWF       R0, 1 
	BTFSC       R0, 0 
	GOTO        L__writedata52
	BCF         LATE7_bit+0, BitPos(LATE7_bit+0) 
	GOTO        L__writedata53
L__writedata52:
	BSF         LATE7_bit+0, BitPos(LATE7_bit+0) 
L__writedata53:
;M0220.c,54 :: 		LATE6_bit = (adata >> 2) & 0x01;
	MOVF        FARG_writedata_adata+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVLW       1
	ANDWF       R0, 1 
	BTFSC       R0, 0 
	GOTO        L__writedata54
	BCF         LATE6_bit+0, BitPos(LATE6_bit+0) 
	GOTO        L__writedata55
L__writedata54:
	BSF         LATE6_bit+0, BitPos(LATE6_bit+0) 
L__writedata55:
;M0220.c,55 :: 		LATE5_bit = (adata >> 1) & 0x01;
	MOVF        FARG_writedata_adata+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVLW       1
	ANDWF       R0, 1 
	BTFSC       R0, 0 
	GOTO        L__writedata56
	BCF         LATE5_bit+0, BitPos(LATE5_bit+0) 
	GOTO        L__writedata57
L__writedata56:
	BSF         LATE5_bit+0, BitPos(LATE5_bit+0) 
L__writedata57:
;M0220.c,56 :: 		LATE4_bit = adata & 0x01;
	MOVLW       1
	ANDWF       FARG_writedata_adata+0, 0 
	MOVWF       R0 
	BTFSC       R0, 0 
	GOTO        L__writedata58
	BCF         LATE4_bit+0, BitPos(LATE4_bit+0) 
	GOTO        L__writedata59
L__writedata58:
	BSF         LATE4_bit+0, BitPos(LATE4_bit+0) 
L__writedata59:
;M0220.c,57 :: 		nybble();
	CALL        _nybble+0, 0
;M0220.c,58 :: 		}
L_end_writedata:
	RETURN      0
; end of _writedata

_LcdOut:

;M0220.c,65 :: 		void LcdOut(char num,char *line)
;M0220.c,70 :: 		if(num == 1) com = 0x01;
	MOVF        FARG_LcdOut_num+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LcdOut2
	MOVLW       1
	MOVWF       LcdOut_com_L0+0 
	GOTO        L_LcdOut3
L_LcdOut2:
;M0220.c,71 :: 		else if(num == 2) com = 0xc0;
	MOVF        FARG_LcdOut_num+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_LcdOut4
	MOVLW       192
	MOVWF       LcdOut_com_L0+0 
L_LcdOut4:
L_LcdOut3:
;M0220.c,73 :: 		writecom(com);
	MOVF        LcdOut_com_L0+0, 0 
	MOVWF       FARG_writecom_command+0 
	CALL        _writecom+0, 0
;M0220.c,75 :: 		for(i=0;i<16;i++)
	CLRF        LcdOut_i_L0+0 
L_LcdOut5:
	MOVLW       16
	SUBWF       LcdOut_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_LcdOut6
;M0220.c,78 :: 		writedata(line[i]);
	MOVF        LcdOut_i_L0+0, 0 
	ADDWF       FARG_LcdOut_line+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_LcdOut_line+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_writedata_adata+0 
	CALL        _writedata+0, 0
;M0220.c,75 :: 		for(i=0;i<16;i++)
	INCF        LcdOut_i_L0+0, 1 
;M0220.c,79 :: 		}
	GOTO        L_LcdOut5
L_LcdOut6:
;M0220.c,80 :: 		}
L_end_LcdOut:
	RETURN      0
; end of _LcdOut

_LCD_output:

;M0220.c,87 :: 		void LCD_output(UCHAR *txt1,UCHAR *txt2)
;M0220.c,90 :: 		LcdOut(1, txt1);
	MOVLW       1
	MOVWF       FARG_LcdOut_num+0 
	MOVF        FARG_LCD_output_txt1+0, 0 
	MOVWF       FARG_LcdOut_line+0 
	MOVF        FARG_LCD_output_txt1+1, 0 
	MOVWF       FARG_LcdOut_line+1 
	CALL        _LcdOut+0, 0
;M0220.c,91 :: 		LcdOut(2, txt2);
	MOVLW       2
	MOVWF       FARG_LcdOut_num+0 
	MOVF        FARG_LCD_output_txt2+0, 0 
	MOVWF       FARG_LcdOut_line+0 
	MOVF        FARG_LCD_output_txt2+1, 0 
	MOVWF       FARG_LcdOut_line+1 
	CALL        _LcdOut+0, 0
;M0220.c,95 :: 		if(spc_system_flag.bite.char_flash)
	BTFSS       _spc_system_flag+3, 6 
	GOTO        L_LCD_output8
;M0220.c,97 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;M0220.c,98 :: 		Lcd_Cmd(_LCD_SECOND_ROW);
	MOVLW       192
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;M0220.c,99 :: 		if(char_flash_loca > 1)
	MOVF        _char_flash_loca+0, 0 
	SUBLW       1
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_output9
;M0220.c,101 :: 		for(i=0; i<char_flash_loca-1; i++)
	CLRF        LCD_output_i_L0+0 
L_LCD_output10:
	DECF        _char_flash_loca+0, 0 
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
	GOTO        L__LCD_output62
	MOVF        R1, 0 
	SUBWF       LCD_output_i_L0+0, 0 
L__LCD_output62:
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_output11
;M0220.c,102 :: 		Lcd_Cmd(_LCD_MOVE_CURSOR_RIGHT);
	MOVLW       20
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;M0220.c,101 :: 		for(i=0; i<char_flash_loca-1; i++)
	INCF        LCD_output_i_L0+0, 1 
;M0220.c,102 :: 		Lcd_Cmd(_LCD_MOVE_CURSOR_RIGHT);
	GOTO        L_LCD_output10
L_LCD_output11:
;M0220.c,103 :: 		}
L_LCD_output9:
;M0220.c,105 :: 		Lcd_Cmd(_LCD_BLINK_CURSOR_ON);
	MOVLW       15
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;M0220.c,106 :: 		}
L_LCD_output8:
;M0220.c,107 :: 		}
L_end_LCD_output:
	RETURN      0
; end of _LCD_output
