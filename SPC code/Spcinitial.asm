
_SPC_Initial:

;Spcinitial.c,23 :: 		void SPC_Initial()
;Spcinitial.c,25 :: 		System_clock_initial();
	CALL        _System_clock_initial+0, 0
;Spcinitial.c,26 :: 		Timer_initial();
	CALL        _Timer_initial+0, 0
;Spcinitial.c,27 :: 		Port_initial();
	CALL        _Port_initial+0, 0
;Spcinitial.c,28 :: 		Spi_initial();
	CALL        _Spi_initial+0, 0
;Spcinitial.c,32 :: 		Uart_initial();
	CALL        _Uart_initial+0, 0
;Spcinitial.c,33 :: 		ADC_initial();
	CALL        _ADC_initial+0, 0
;Spcinitial.c,34 :: 		LCD_initial();
	CALL        _LCD_initial+0, 0
;Spcinitial.c,36 :: 		}
L_end_SPC_Initial:
	RETURN      0
; end of _SPC_Initial

_QT60Initial:

;Spcinitial.c,38 :: 		void QT60Initial()
;Spcinitial.c,40 :: 		setkeyhold();          //enable hold mode for all keys
	CALL        _setkeyhold+0, 0
;Spcinitial.c,41 :: 		Delay_ms(200);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_QT60Initial0:
	DECFSZ      R13, 1, 1
	BRA         L_QT60Initial0
	DECFSZ      R12, 1, 1
	BRA         L_QT60Initial0
	DECFSZ      R11, 1, 1
	BRA         L_QT60Initial0
	NOP
	NOP
;Spcinitial.c,42 :: 		setkeysence();         //set key sensitive
	CALL        _setkeysence+0, 0
;Spcinitial.c,43 :: 		Delay_ms(200);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_QT60Initial1:
	DECFSZ      R13, 1, 1
	BRA         L_QT60Initial1
	DECFSZ      R12, 1, 1
	BRA         L_QT60Initial1
	DECFSZ      R11, 1, 1
	BRA         L_QT60Initial1
	NOP
	NOP
;Spcinitial.c,44 :: 		setkeysenceaks();      //disable muli-key detection
	CALL        _setkeysenceaks+0, 0
;Spcinitial.c,45 :: 		Delay_ms(200);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_QT60Initial2:
	DECFSZ      R13, 1, 1
	BRA         L_QT60Initial2
	DECFSZ      R12, 1, 1
	BRA         L_QT60Initial2
	DECFSZ      R11, 1, 1
	BRA         L_QT60Initial2
	NOP
	NOP
;Spcinitial.c,46 :: 		enablekeys();          //disable keys that not used*/
	CALL        _enablekeys+0, 0
;Spcinitial.c,47 :: 		calikey();             //calibrate keys
	CALL        _calikey+0, 0
;Spcinitial.c,48 :: 		}
L_end_QT60Initial:
	RETURN      0
; end of _QT60Initial

_QT60Reset:

;Spcinitial.c,50 :: 		void QT60Reset()
;Spcinitial.c,52 :: 		calikey();
	CALL        _calikey+0, 0
;Spcinitial.c,53 :: 		}
L_end_QT60Reset:
	RETURN      0
; end of _QT60Reset

_GlobalInterrupt_diable:

;Spcinitial.c,60 :: 		void GlobalInterrupt_diable()
;Spcinitial.c,62 :: 		GIE_bit = FALSE;       //全局中断关闭
	BCF         GIE_bit+0, BitPos(GIE_bit+0) 
;Spcinitial.c,63 :: 		}
L_end_GlobalInterrupt_diable:
	RETURN      0
; end of _GlobalInterrupt_diable

_GlobalInterrupt_enable:

;Spcinitial.c,65 :: 		void GlobalInterrupt_enable()
;Spcinitial.c,67 :: 		GIE_bit = TRUE;       //全局中断打开
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;Spcinitial.c,68 :: 		}
L_end_GlobalInterrupt_enable:
	RETURN      0
; end of _GlobalInterrupt_enable

_System_clock_initial:

;Spcinitial.c,75 :: 		void System_clock_initial()
;Spcinitial.c,77 :: 		OSCCON = PRIMARY_OSC;       //00 = Primary oscillator
	CLRF        OSCCON+0 
;Spcinitial.c,78 :: 		while(!(OSCCON & OSTS));    //wait for clock to stable
L_System_clock_initial3:
	BTFSC       OSCCON+0, 3 
	GOTO        L_System_clock_initial4
	GOTO        L_System_clock_initial3
L_System_clock_initial4:
;Spcinitial.c,79 :: 		}
L_end_System_clock_initial:
	RETURN      0
; end of _System_clock_initial

_Timer_initial:

;Spcinitial.c,89 :: 		void Timer_initial()
;Spcinitial.c,91 :: 		T0CON = 0;
	CLRF        T0CON+0 
;Spcinitial.c,92 :: 		PSA_bit = 1;     //set timer0 as 16bit timer
	BSF         PSA_bit+0, BitPos(PSA_bit+0) 
;Spcinitial.c,97 :: 		TMR0H = 0XFC;
	MOVLW       252
	MOVWF       TMR0H+0 
;Spcinitial.c,98 :: 		TMR0L = 0xCD;
	MOVLW       205
	MOVWF       TMR0L+0 
;Spcinitial.c,99 :: 		TMR0IE_bit = 1;
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;Spcinitial.c,100 :: 		TMR0IP_bit = 1;
	BSF         TMR0IP_bit+0, BitPos(TMR0IP_bit+0) 
;Spcinitial.c,101 :: 		TMR0IF_bit = 0;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;Spcinitial.c,102 :: 		TMR0ON_bit = 1;
	BSF         TMR0ON_bit+0, BitPos(TMR0ON_bit+0) 
;Spcinitial.c,103 :: 		}
L_end_Timer_initial:
	RETURN      0
; end of _Timer_initial

_Port_initial:

;Spcinitial.c,110 :: 		void Port_initial()
;Spcinitial.c,113 :: 		TRISG1_bit = 0;
	BCF         TRISG1_bit+0, BitPos(TRISG1_bit+0) 
;Spcinitial.c,116 :: 		PORTE = 0;
	CLRF        PORTE+0 
;Spcinitial.c,117 :: 		TRISE = 0;
	CLRF        TRISE+0 
;Spcinitial.c,119 :: 		PORTF = 0;
	CLRF        PORTF+0 
;Spcinitial.c,120 :: 		TRISF &= ~(RS + LCD_RW_BIT + E);
	MOVLW       31
	ANDWF       TRISF+0, 1 
;Spcinitial.c,121 :: 		LATF6_bit = 0;                         //always set RW as 0
	BCF         LATF6_bit+0, BitPos(LATF6_bit+0) 
;Spcinitial.c,123 :: 		TRISB3_bit = 1;
	BSF         TRISB3_bit+0, BitPos(TRISB3_bit+0) 
;Spcinitial.c,124 :: 		TRISD7_bit = 1;
	BSF         TRISD7_bit+0, BitPos(TRISD7_bit+0) 
;Spcinitial.c,126 :: 		TRISB4_bit = 0;
	BCF         TRISB4_bit+0, BitPos(TRISB4_bit+0) 
;Spcinitial.c,127 :: 		TRISB5_bit = 0;
	BCF         TRISB5_bit+0, BitPos(TRISB5_bit+0) 
;Spcinitial.c,128 :: 		TRISB1_bit = 0;
	BCF         TRISB1_bit+0, BitPos(TRISB1_bit+0) 
;Spcinitial.c,129 :: 		TRISB2_bit = 0;
	BCF         TRISB2_bit+0, BitPos(TRISB2_bit+0) 
;Spcinitial.c,131 :: 		TRISF2_bit = 0;
	BCF         TRISF2_bit+0, BitPos(TRISF2_bit+0) 
;Spcinitial.c,132 :: 		TRISF1_bit = 0;
	BCF         TRISF1_bit+0, BitPos(TRISF1_bit+0) 
;Spcinitial.c,136 :: 		TRISC2_bit = 0;
	BCF         TRISC2_bit+0, BitPos(TRISC2_bit+0) 
;Spcinitial.c,137 :: 		LATC2_bit = 0;
	BCF         LATC2_bit+0, BitPos(LATC2_bit+0) 
;Spcinitial.c,138 :: 		TRISC5_bit = 0;
	BCF         TRISC5_bit+0, BitPos(TRISC5_bit+0) 
;Spcinitial.c,139 :: 		LATC5_bit = 0;
	BCF         LATC5_bit+0, BitPos(LATC5_bit+0) 
;Spcinitial.c,142 :: 		TRISC3_bit = 0;
	BCF         TRISC3_bit+0, BitPos(TRISC3_bit+0) 
;Spcinitial.c,143 :: 		LATC3_bit = 1;
	BSF         LATC3_bit+0, BitPos(LATC3_bit+0) 
;Spcinitial.c,144 :: 		TRISC4_bit = 0;
	BCF         TRISC4_bit+0, BitPos(TRISC4_bit+0) 
;Spcinitial.c,145 :: 		LATC4_bit = 1;
	BSF         LATC4_bit+0, BitPos(LATC4_bit+0) 
;Spcinitial.c,146 :: 		Delay_ms(2);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_Port_initial5:
	DECFSZ      R13, 1, 1
	BRA         L_Port_initial5
	DECFSZ      R12, 1, 1
	BRA         L_Port_initial5
	NOP
	NOP
;Spcinitial.c,148 :: 		TRISB0_bit = 1;   //change pin
	BSF         TRISB0_bit+0, BitPos(TRISB0_bit+0) 
;Spcinitial.c,149 :: 		INTEDG0_bit = 1;
	BSF         INTEDG0_bit+0, BitPos(INTEDG0_bit+0) 
;Spcinitial.c,150 :: 		INT0IE_bit = 1;
	BSF         INT0IE_bit+0, BitPos(INT0IE_bit+0) 
;Spcinitial.c,157 :: 		}
L_end_Port_initial:
	RETURN      0
; end of _Port_initial

_Spi_initial:

;Spcinitial.c,164 :: 		void Spi_initial()
;Spcinitial.c,166 :: 		TRISD &= ~(GFIC_CHANNEL1 + RTD_CHANNEL1 + GFIC_CHANNEL2 + RTD_CHANNEL2);     //   BIT1 + BIT3
	MOVLW       240
	ANDWF       TRISD+0, 1 
;Spcinitial.c,168 :: 		SSP2CON1 &= ~SSPEN;
	BCF         SSP2CON1+0, 5 
;Spcinitial.c,169 :: 		TRISD &= ~(SDO2 + SCK2);
	MOVLW       175
	ANDWF       TRISD+0, 1 
;Spcinitial.c,170 :: 		TRISD |= SDI2;
	BSF         TRISD+0, 5 
;Spcinitial.c,171 :: 		SSP2CON1 = SSPEN + SPI_MASTER_16FOSC + CKP;
	MOVLW       49
	MOVWF       SSP2CON1+0 
;Spcinitial.c,172 :: 		SSP2STAT = SMP;
	MOVLW       128
	MOVWF       SSP2STAT+0 
;Spcinitial.c,174 :: 		LATD |= (GFIC_CHANNEL1 + RTD_CHANNEL1 + GFIC_CHANNEL2 + RTD_CHANNEL2);
	MOVLW       15
	IORWF       LATD+0, 1 
;Spcinitial.c,175 :: 		}
L_end_Spi_initial:
	RETURN      0
; end of _Spi_initial

_I2C_initial:

;Spcinitial.c,182 :: 		void I2C_initial()
;Spcinitial.c,185 :: 		TRISC3_bit = 1;   //clk
	BSF         TRISC3_bit+0, BitPos(TRISC3_bit+0) 
;Spcinitial.c,186 :: 		TRISC4_bit = 1;   //data
	BSF         TRISC4_bit+0, BitPos(TRISC4_bit+0) 
;Spcinitial.c,188 :: 		SSP1CON1 = 0x28;
	MOVLW       40
	MOVWF       SSP1CON1+0 
;Spcinitial.c,189 :: 		SSP1CON2 = 0;
	CLRF        SSP1CON2+0 
;Spcinitial.c,190 :: 		SSP1ADD = 63;
	MOVLW       63
	MOVWF       SSP1ADD+0 
;Spcinitial.c,191 :: 		SSP1STAT = 0x80;
	MOVLW       128
	MOVWF       SSP1STAT+0 
;Spcinitial.c,192 :: 		SSPEN_SSP1CON1_bit = 1;
	BSF         SSPEN_SSP1CON1_bit+0, BitPos(SSPEN_SSP1CON1_bit+0) 
;Spcinitial.c,200 :: 		}
L_end_I2C_initial:
	RETURN      0
; end of _I2C_initial

_Uart_initial:

;Spcinitial.c,207 :: 		void Uart_initial()
;Spcinitial.c,209 :: 		TRISF3_bit = 0;
	BCF         TRISF3_bit+0, BitPos(TRISF3_bit+0) 
;Spcinitial.c,210 :: 		TRISF4_bit = 0;
	BCF         TRISF4_bit+0, BitPos(TRISF4_bit+0) 
;Spcinitial.c,212 :: 		SYNC_TXSTA_bit = 0;
	BCF         SYNC_TXSTA_bit+0, BitPos(SYNC_TXSTA_bit+0) 
;Spcinitial.c,213 :: 		SPEN_RCSTA_bit = 1;
	BSF         SPEN_RCSTA_bit+0, BitPos(SPEN_RCSTA_bit+0) 
;Spcinitial.c,214 :: 		CREN_RCSTA_bit = 1;
	BSF         CREN_RCSTA_bit+0, BitPos(CREN_RCSTA_bit+0) 
;Spcinitial.c,215 :: 		RC1IE_bit = 1;
	BSF         RC1IE_bit+0, BitPos(RC1IE_bit+0) 
;Spcinitial.c,216 :: 		TRISC7_bit = 1;
	BSF         TRISC7_bit+0, BitPos(TRISC7_bit+0) 
;Spcinitial.c,217 :: 		TRISC6_bit = 0;
	BCF         TRISC6_bit+0, BitPos(TRISC6_bit+0) 
;Spcinitial.c,218 :: 		BRG16_bit = 0;
	BCF         BRG16_bit+0, BitPos(BRG16_bit+0) 
;Spcinitial.c,220 :: 		switch(pSPCValue[Cable_Channel].SPCSetPoints.system_valueb.bite.baud)
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
	GOTO        L_Uart_initial6
;Spcinitial.c,222 :: 		case BAUDRATE_1200:
L_Uart_initial8:
;Spcinitial.c,223 :: 		SPBRGH1 = 1;
	MOVLW       1
	MOVWF       SPBRGH1+0 
;Spcinitial.c,224 :: 		SPBRG1 = 0X03;
	MOVLW       3
	MOVWF       SPBRG1+0 
;Spcinitial.c,225 :: 		break;
	GOTO        L_Uart_initial7
;Spcinitial.c,226 :: 		case BAUDRATE_2400:
L_Uart_initial9:
;Spcinitial.c,227 :: 		SPBRGH1 = 0;
	CLRF        SPBRGH1+0 
;Spcinitial.c,228 :: 		SPBRG1 = 0X81;
	MOVLW       129
	MOVWF       SPBRG1+0 
;Spcinitial.c,229 :: 		break;
	GOTO        L_Uart_initial7
;Spcinitial.c,230 :: 		case BAUDRATE_4800:
L_Uart_initial10:
;Spcinitial.c,231 :: 		SPBRGH1 = 0;
	CLRF        SPBRGH1+0 
;Spcinitial.c,232 :: 		SPBRG1 = 0X40;
	MOVLW       64
	MOVWF       SPBRG1+0 
;Spcinitial.c,233 :: 		break;
	GOTO        L_Uart_initial7
;Spcinitial.c,234 :: 		case BAUDRATE_9600:
L_Uart_initial11:
;Spcinitial.c,235 :: 		SPBRGH1 = 0;
	CLRF        SPBRGH1+0 
;Spcinitial.c,236 :: 		SPBRG1 = 0X20;
	MOVLW       32
	MOVWF       SPBRG1+0 
;Spcinitial.c,237 :: 		break;
	GOTO        L_Uart_initial7
;Spcinitial.c,238 :: 		case BAUDRATE_19200:
L_Uart_initial12:
;Spcinitial.c,239 :: 		SPBRGH1 = 0;
	CLRF        SPBRGH1+0 
;Spcinitial.c,240 :: 		SPBRG1 = 0X0F;
	MOVLW       15
	MOVWF       SPBRG1+0 
;Spcinitial.c,241 :: 		break;
	GOTO        L_Uart_initial7
;Spcinitial.c,242 :: 		}
L_Uart_initial6:
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVLW       112
	ANDWF       POSTINC0+0, 0 
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
	BTFSC       STATUS+0, 2 
	GOTO        L_Uart_initial8
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVLW       112
	ANDWF       POSTINC0+0, 0 
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
	BTFSC       STATUS+0, 2 
	GOTO        L_Uart_initial9
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVLW       112
	ANDWF       POSTINC0+0, 0 
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
	GOTO        L_Uart_initial10
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVLW       112
	ANDWF       POSTINC0+0, 0 
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
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_Uart_initial11
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVLW       112
	ANDWF       POSTINC0+0, 0 
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
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_Uart_initial12
L_Uart_initial7:
;Spcinitial.c,244 :: 		TXEN_TXSTA_bit = 1;
	BSF         TXEN_TXSTA_bit+0, BitPos(TXEN_TXSTA_bit+0) 
;Spcinitial.c,245 :: 		RC1IE_bit = 1;
	BSF         RC1IE_bit+0, BitPos(RC1IE_bit+0) 
;Spcinitial.c,246 :: 		PEIE_bit = 1;
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;Spcinitial.c,248 :: 		en485rx();
	CALL        _en485rx+0, 0
;Spcinitial.c,250 :: 		}
L_end_Uart_initial:
	RETURN      0
; end of _Uart_initial

_ADC_initial:

;Spcinitial.c,257 :: 		void ADC_initial()
;Spcinitial.c,259 :: 		TRISA0_bit = 1;
	BSF         TRISA0_bit+0, BitPos(TRISA0_bit+0) 
;Spcinitial.c,260 :: 		TRISA1_bit = 1;
	BSF         TRISA1_bit+0, BitPos(TRISA1_bit+0) 
;Spcinitial.c,261 :: 		ADCON1 = 0x0d;  //AN0 AN1
	MOVLW       13
	MOVWF       ADCON1+0 
;Spcinitial.c,263 :: 		ADCON2 = B2 + B0 + B5;  //8Tad Focs/16
	MOVLW       7
	MOVWF       ADCON2+0 
;Spcinitial.c,264 :: 		ADFM_bit = 1;
	BSF         ADFM_bit+0, BitPos(ADFM_bit+0) 
;Spcinitial.c,265 :: 		ADON_bit = 1;
	BSF         ADON_bit+0, BitPos(ADON_bit+0) 
;Spcinitial.c,266 :: 		}
L_end_ADC_initial:
	RETURN      0
; end of _ADC_initial

_LCD_initial:

;Spcinitial.c,273 :: 		void LCD_initial()
;Spcinitial.c,276 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;Spcinitial.c,277 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Spcinitial.c,278 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Spcinitial.c,279 :: 		}
L_end_LCD_initial:
	RETURN      0
; end of _LCD_initial

_selftest:

;Spcinitial.c,286 :: 		void selftest()
;Spcinitial.c,290 :: 		LED_HEATER_ON = 1;
	BSF         LATE3_bit+0, BitPos(LATE3_bit+0) 
;Spcinitial.c,291 :: 		LED_SYSTEM_FAIL = 1;
	BSF         LATE2_bit+0, BitPos(LATE2_bit+0) 
;Spcinitial.c,292 :: 		LED_ALARM = 1;
	BSF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;Spcinitial.c,293 :: 		LED_COMMUNICATION_FAIL = 1;
	BSF         LATE1_bit+0, BitPos(LATE1_bit+0) 
;Spcinitial.c,295 :: 		MemeSet(Info_Line1, 0x14, 16);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_MemeSet_target+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_MemeSet_target+1 
	MOVLW       20
	MOVWF       FARG_MemeSet_Transdata+0 
	MOVLW       16
	MOVWF       FARG_MemeSet_len+0 
	MOVLW       0
	MOVWF       FARG_MemeSet_len+1 
	CALL        _MemeSet+0, 0
;Spcinitial.c,296 :: 		MemeSet(Info_Line2, 0x14, 16);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_MemeSet_target+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_MemeSet_target+1 
	MOVLW       20
	MOVWF       FARG_MemeSet_Transdata+0 
	MOVLW       16
	MOVWF       FARG_MemeSet_len+0 
	MOVLW       0
	MOVWF       FARG_MemeSet_len+1 
	CALL        _MemeSet+0, 0
;Spcinitial.c,297 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
;Spcinitial.c,299 :: 		Delay_ms(2000);
	MOVLW       51
	MOVWF       R11, 0
	MOVLW       187
	MOVWF       R12, 0
	MOVLW       223
	MOVWF       R13, 0
L_selftest13:
	DECFSZ      R13, 1, 1
	BRA         L_selftest13
	DECFSZ      R12, 1, 1
	BRA         L_selftest13
	DECFSZ      R11, 1, 1
	BRA         L_selftest13
	NOP
	NOP
;Spcinitial.c,301 :: 		LED_HEATER_ON = 0;
	BCF         LATE3_bit+0, BitPos(LATE3_bit+0) 
;Spcinitial.c,302 :: 		LED_SYSTEM_FAIL = 0;
	BCF         LATE2_bit+0, BitPos(LATE2_bit+0) 
;Spcinitial.c,303 :: 		LED_ALARM = 0;
	BCF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;Spcinitial.c,304 :: 		LED_COMMUNICATION_FAIL = 0;
	BCF         LATE1_bit+0, BitPos(LATE1_bit+0) 
;Spcinitial.c,306 :: 		MemeSet(Info_Line1, ' ', 16);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_MemeSet_target+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_MemeSet_target+1 
	MOVLW       32
	MOVWF       FARG_MemeSet_Transdata+0 
	MOVLW       16
	MOVWF       FARG_MemeSet_len+0 
	MOVLW       0
	MOVWF       FARG_MemeSet_len+1 
	CALL        _MemeSet+0, 0
;Spcinitial.c,307 :: 		MemeSet(Info_Line2, ' ', 16);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_MemeSet_target+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_MemeSet_target+1 
	MOVLW       32
	MOVWF       FARG_MemeSet_Transdata+0 
	MOVLW       16
	MOVWF       FARG_MemeSet_len+0 
	MOVLW       0
	MOVWF       FARG_MemeSet_len+1 
	CALL        _MemeSet+0, 0
;Spcinitial.c,308 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
;Spcinitial.c,310 :: 		Delay_ms(2000);
	MOVLW       51
	MOVWF       R11, 0
	MOVLW       187
	MOVWF       R12, 0
	MOVLW       223
	MOVWF       R13, 0
L_selftest14:
	DECFSZ      R13, 1, 1
	BRA         L_selftest14
	DECFSZ      R12, 1, 1
	BRA         L_selftest14
	DECFSZ      R11, 1, 1
	BRA         L_selftest14
	NOP
	NOP
;Spcinitial.c,311 :: 		for(i=0; i<16; i++) Info_Line1[i] = Version_title[i];
	CLRF        selftest_i_L0+0 
L_selftest15:
	MOVLW       16
	SUBWF       selftest_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_selftest16
	MOVLW       _Info_Line1+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FSR1H 
	MOVF        selftest_i_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       Spcinitial_Version_title+0
	ADDWF       selftest_i_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(Spcinitial_Version_title+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(Spcinitial_Version_title+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        selftest_i_L0+0, 1 
	GOTO        L_selftest15
L_selftest16:
;Spcinitial.c,312 :: 		for(i=0; i<16; i++) Info_Line2[i] = Version_content[i];
	CLRF        selftest_i_L0+0 
L_selftest18:
	MOVLW       16
	SUBWF       selftest_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_selftest19
	MOVLW       _Info_Line2+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FSR1H 
	MOVF        selftest_i_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       Spcinitial_Version_content+0
	ADDWF       selftest_i_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(Spcinitial_Version_content+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(Spcinitial_Version_content+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        selftest_i_L0+0, 1 
	GOTO        L_selftest18
L_selftest19:
;Spcinitial.c,313 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
;Spcinitial.c,314 :: 		Delay_ms(2000);
	MOVLW       51
	MOVWF       R11, 0
	MOVLW       187
	MOVWF       R12, 0
	MOVLW       223
	MOVWF       R13, 0
L_selftest21:
	DECFSZ      R13, 1, 1
	BRA         L_selftest21
	DECFSZ      R12, 1, 1
	BRA         L_selftest21
	DECFSZ      R11, 1, 1
	BRA         L_selftest21
	NOP
	NOP
;Spcinitial.c,315 :: 		}
L_end_selftest:
	RETURN      0
; end of _selftest

_SelfCheck:

;Spcinitial.c,317 :: 		void SelfCheck()
;Spcinitial.c,319 :: 		char RTDACheck=0,RTDBCheck=0,i;
	CLRF        SelfCheck_RTDACheck_L0+0 
	CLRF        SelfCheck_RTDBCheck_L0+0 
	CLRF        SelfCheck_SystemFailureEn_L0+0 
	CLRF        SelfCheck_GFITestBUff_L0+0 
	CLRF        SelfCheck_GFITestBUff_L0+1 
	CLRF        SelfCheck_GFITestBUff_L0+2 
	CLRF        SelfCheck_GFITestBUff_L0+3 
;Spcinitial.c,325 :: 		for(i=0;i<16;i++)
	CLRF        SelfCheck_i_L0+0 
L_SelfCheck22:
	MOVLW       16
	SUBWF       SelfCheck_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SelfCheck23
;Spcinitial.c,327 :: 		Info_Line1[i] = Selfcheck_str[i];
	MOVLW       _Info_Line1+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FSR1H 
	MOVF        SelfCheck_i_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       Spcinitial_Selfcheck_str+0
	ADDWF       SelfCheck_i_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(Spcinitial_Selfcheck_str+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(Spcinitial_Selfcheck_str+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Spcinitial.c,325 :: 		for(i=0;i<16;i++)
	INCF        SelfCheck_i_L0+0, 1 
;Spcinitial.c,328 :: 		}
	GOTO        L_SelfCheck22
L_SelfCheck23:
;Spcinitial.c,329 :: 		ClearStr(Info_Line2, 16);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_ClearStr_target+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_ClearStr_target+1 
	MOVLW       16
	MOVWF       FARG_ClearStr_len+0 
	MOVLW       0
	MOVWF       FARG_ClearStr_len+1 
	CALL        _ClearStr+0, 0
;Spcinitial.c,330 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
;Spcinitial.c,332 :: 		QT60Initial();
	CALL        _QT60Initial+0, 0
;Spcinitial.c,334 :: 		freqency = 60;
	MOVLW       60
	MOVWF       _freqency+0 
	MOVLW       0
	MOVWF       _freqency+1 
;Spcinitial.c,335 :: 		freq_pori = 83;
	MOVLW       83
	MOVWF       _freq_pori+0 
	MOVLW       0
	MOVWF       _freq_pori+1 
;Spcinitial.c,338 :: 		for(i=0;i<2;i++)
	CLRF        SelfCheck_i_L0+0 
L_SelfCheck25:
	MOVLW       2
	SUBWF       SelfCheck_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SelfCheck26
;Spcinitial.c,340 :: 		RTDACheck = 0;
	CLRF        SelfCheck_RTDACheck_L0+0 
;Spcinitial.c,341 :: 		RTDBCheck = 0;
	CLRF        SelfCheck_RTDBCheck_L0+0 
;Spcinitial.c,343 :: 		tempa_ptr = (signed int *)(&pSPCValue[i].SPCActual.TemperatureA);
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SelfCheck_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _pSPCValue+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_pSPCValue+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       4
	ADDWF       R2, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       SelfCheck_tempa_ptr_L0+0 
	MOVF        R1, 0 
	MOVWF       SelfCheck_tempa_ptr_L0+1 
;Spcinitial.c,344 :: 		tempb_ptr = (signed int *)(&pSPCValue[i].SPCActual.TemperatureB);
	MOVLW       8
	ADDWF       R2, 0 
	MOVWF       SelfCheck_tempb_ptr_L0+0 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       SelfCheck_tempb_ptr_L0+1 
;Spcinitial.c,347 :: 		GetTemperature(&pSPCValue[i].SPCActual.TemperatureA, i);
	MOVF        R0, 0 
	MOVWF       FARG_GetTemperature_RTDA_ptr+0 
	MOVF        R1, 0 
	MOVWF       FARG_GetTemperature_RTDA_ptr+1 
	MOVF        SelfCheck_i_L0+0, 0 
	MOVWF       FARG_GetTemperature_ChannelNum+0 
	CALL        _GetTemperature+0, 0
;Spcinitial.c,349 :: 		if((*tempa_ptr == RTD_SHORT) || (*tempa_ptr == RTD_OPNE))
	MOVFF       SelfCheck_tempa_ptr_L0+0, FSR0
	MOVFF       SelfCheck_tempa_ptr_L0+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__SelfCheck72
	MOVLW       255
	XORWF       R1, 0 
L__SelfCheck72:
	BTFSC       STATUS+0, 2 
	GOTO        L__SelfCheck56
	MOVFF       SelfCheck_tempa_ptr_L0+0, FSR0
	MOVFF       SelfCheck_tempa_ptr_L0+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__SelfCheck73
	MOVLW       253
	XORWF       R1, 0 
L__SelfCheck73:
	BTFSC       STATUS+0, 2 
	GOTO        L__SelfCheck56
	GOTO        L_SelfCheck30
L__SelfCheck56:
;Spcinitial.c,350 :: 		RTDACheck = 1;
	MOVLW       1
	MOVWF       SelfCheck_RTDACheck_L0+0 
L_SelfCheck30:
;Spcinitial.c,351 :: 		if((*tempb_ptr == RTD_SHORT) || (*tempb_ptr == RTD_OPNE))
	MOVFF       SelfCheck_tempb_ptr_L0+0, FSR0
	MOVFF       SelfCheck_tempb_ptr_L0+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__SelfCheck74
	MOVLW       255
	XORWF       R1, 0 
L__SelfCheck74:
	BTFSC       STATUS+0, 2 
	GOTO        L__SelfCheck55
	MOVFF       SelfCheck_tempb_ptr_L0+0, FSR0
	MOVFF       SelfCheck_tempb_ptr_L0+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       127
	BTFSS       STATUS+0, 2 
	GOTO        L__SelfCheck75
	MOVLW       253
	XORWF       R1, 0 
L__SelfCheck75:
	BTFSC       STATUS+0, 2 
	GOTO        L__SelfCheck55
	GOTO        L_SelfCheck33
L__SelfCheck55:
;Spcinitial.c,352 :: 		RTDBCheck = 1;
	MOVLW       1
	MOVWF       SelfCheck_RTDBCheck_L0+0 
L_SelfCheck33:
;Spcinitial.c,354 :: 		if(RTDACheck)
	MOVF        SelfCheck_RTDACheck_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SelfCheck34
;Spcinitial.c,356 :: 		if(RTDBCheck || (pSPCValue[i].SPCSetPoints.system_valueb.bite.rtd_opr == ONE_RTD_MOD))
	MOVF        SelfCheck_RTDBCheck_L0+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__SelfCheck54
	MOVLW       142
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SelfCheck_i_L0+0, 0 
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
	MOVLW       112
	ANDWF       R0, 0 
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
	BTFSC       STATUS+0, 2 
	GOTO        L__SelfCheck54
	GOTO        L_SelfCheck37
L__SelfCheck54:
;Spcinitial.c,357 :: 		SystemFailureEn = 1;
	MOVLW       1
	MOVWF       SelfCheck_SystemFailureEn_L0+0 
L_SelfCheck37:
;Spcinitial.c,358 :: 		}
L_SelfCheck34:
;Spcinitial.c,338 :: 		for(i=0;i<2;i++)
	INCF        SelfCheck_i_L0+0, 1 
;Spcinitial.c,359 :: 		}
	GOTO        L_SelfCheck25
L_SelfCheck26:
;Spcinitial.c,362 :: 		LATC2_bit = 1;      //SSR on
	BSF         LATC2_bit+0, BitPos(LATC2_bit+0) 
;Spcinitial.c,363 :: 		Delay_ms(1000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_SelfCheck38:
	DECFSZ      R13, 1, 1
	BRA         L_SelfCheck38
	DECFSZ      R12, 1, 1
	BRA         L_SelfCheck38
	DECFSZ      R11, 1, 1
	BRA         L_SelfCheck38
	NOP
;Spcinitial.c,364 :: 		LATF2_bit = 1;      //GFI generater on
	BSF         LATF2_bit+0, BitPos(LATF2_bit+0) 
;Spcinitial.c,365 :: 		Delay_ms(500);
	MOVLW       13
	MOVWF       R11, 0
	MOVLW       175
	MOVWF       R12, 0
	MOVLW       182
	MOVWF       R13, 0
L_SelfCheck39:
	DECFSZ      R13, 1, 1
	BRA         L_SelfCheck39
	DECFSZ      R12, 1, 1
	BRA         L_SelfCheck39
	DECFSZ      R11, 1, 1
	BRA         L_SelfCheck39
	NOP
;Spcinitial.c,367 :: 		for(i=0;i<5;i++)
	CLRF        SelfCheck_i_L0+0 
L_SelfCheck40:
	MOVLW       5
	SUBWF       SelfCheck_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SelfCheck41
;Spcinitial.c,369 :: 		GFITestBUff += GetGFI(GFIC_CHANNEL1,GFI_AD_COMMND);
	MOVLW       2
	MOVWF       FARG_GetGFI_ChannelSelect+0 
	MOVLW       224
	MOVWF       FARG_GetGFI_cmd+0 
	CALL        _GetGFI+0, 0
	MOVF        R0, 0 
	ADDWF       SelfCheck_GFITestBUff_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SelfCheck_GFITestBUff_L0+1, 1 
	MOVLW       0
	ADDWFC      SelfCheck_GFITestBUff_L0+2, 1 
	ADDWFC      SelfCheck_GFITestBUff_L0+3, 1 
;Spcinitial.c,367 :: 		for(i=0;i<5;i++)
	INCF        SelfCheck_i_L0+0, 1 
;Spcinitial.c,370 :: 		}
	GOTO        L_SelfCheck40
L_SelfCheck41:
;Spcinitial.c,371 :: 		GFITestValue = ConvertADtoGFI(GFITestBUff/5, 0);
	MOVLW       5
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	MOVF        SelfCheck_GFITestBUff_L0+0, 0 
	MOVWF       R0 
	MOVF        SelfCheck_GFITestBUff_L0+1, 0 
	MOVWF       R1 
	MOVF        SelfCheck_GFITestBUff_L0+2, 0 
	MOVWF       R2 
	MOVF        SelfCheck_GFITestBUff_L0+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_ConvertADtoGFI_ADcurrent+0 
	MOVF        R1, 0 
	MOVWF       FARG_ConvertADtoGFI_ADcurrent+1 
	CLRF        FARG_ConvertADtoGFI_ChannelNum+0 
	CALL        _ConvertADtoGFI+0, 0
;Spcinitial.c,373 :: 		if(GFITestValue < 20)
	MOVLW       128
	XORWF       R1, 0 
	MOVWF       R2 
	MOVLW       128
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SelfCheck76
	MOVLW       20
	SUBWF       R0, 0 
L__SelfCheck76:
	BTFSC       STATUS+0, 0 
	GOTO        L_SelfCheck43
;Spcinitial.c,374 :: 		SystemFailureEn = 1;
	MOVLW       1
	MOVWF       SelfCheck_SystemFailureEn_L0+0 
L_SelfCheck43:
;Spcinitial.c,376 :: 		LATC2_bit = 0;
	BCF         LATC2_bit+0, BitPos(LATC2_bit+0) 
;Spcinitial.c,377 :: 		LATF2_bit = 0;
	BCF         LATF2_bit+0, BitPos(LATF2_bit+0) 
;Spcinitial.c,380 :: 		GFITestBUff = 0;
	CLRF        SelfCheck_GFITestBUff_L0+0 
	CLRF        SelfCheck_GFITestBUff_L0+1 
	CLRF        SelfCheck_GFITestBUff_L0+2 
	CLRF        SelfCheck_GFITestBUff_L0+3 
;Spcinitial.c,381 :: 		LATC5_bit = 1;      //SSR on
	BSF         LATC5_bit+0, BitPos(LATC5_bit+0) 
;Spcinitial.c,382 :: 		Delay_ms(1000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_SelfCheck44:
	DECFSZ      R13, 1, 1
	BRA         L_SelfCheck44
	DECFSZ      R12, 1, 1
	BRA         L_SelfCheck44
	DECFSZ      R11, 1, 1
	BRA         L_SelfCheck44
	NOP
;Spcinitial.c,383 :: 		LATF1_bit = 1;      //GFI generater on
	BSF         LATF1_bit+0, BitPos(LATF1_bit+0) 
;Spcinitial.c,384 :: 		Delay_ms(500);
	MOVLW       13
	MOVWF       R11, 0
	MOVLW       175
	MOVWF       R12, 0
	MOVLW       182
	MOVWF       R13, 0
L_SelfCheck45:
	DECFSZ      R13, 1, 1
	BRA         L_SelfCheck45
	DECFSZ      R12, 1, 1
	BRA         L_SelfCheck45
	DECFSZ      R11, 1, 1
	BRA         L_SelfCheck45
	NOP
;Spcinitial.c,386 :: 		for(i=0;i<5;i++)
	CLRF        SelfCheck_i_L0+0 
L_SelfCheck46:
	MOVLW       5
	SUBWF       SelfCheck_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SelfCheck47
;Spcinitial.c,388 :: 		GFITestBUff += GetGFI(GFIC_CHANNEL2,GFI_AD_COMMND);
	MOVLW       1
	MOVWF       FARG_GetGFI_ChannelSelect+0 
	MOVLW       224
	MOVWF       FARG_GetGFI_cmd+0 
	CALL        _GetGFI+0, 0
	MOVF        R0, 0 
	ADDWF       SelfCheck_GFITestBUff_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SelfCheck_GFITestBUff_L0+1, 1 
	MOVLW       0
	ADDWFC      SelfCheck_GFITestBUff_L0+2, 1 
	ADDWFC      SelfCheck_GFITestBUff_L0+3, 1 
;Spcinitial.c,386 :: 		for(i=0;i<5;i++)
	INCF        SelfCheck_i_L0+0, 1 
;Spcinitial.c,389 :: 		}
	GOTO        L_SelfCheck46
L_SelfCheck47:
;Spcinitial.c,390 :: 		GFITestValue = ConvertADtoGFI(GFITestBUff/5, 1);
	MOVLW       5
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	MOVF        SelfCheck_GFITestBUff_L0+0, 0 
	MOVWF       R0 
	MOVF        SelfCheck_GFITestBUff_L0+1, 0 
	MOVWF       R1 
	MOVF        SelfCheck_GFITestBUff_L0+2, 0 
	MOVWF       R2 
	MOVF        SelfCheck_GFITestBUff_L0+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_ConvertADtoGFI_ADcurrent+0 
	MOVF        R1, 0 
	MOVWF       FARG_ConvertADtoGFI_ADcurrent+1 
	MOVLW       1
	MOVWF       FARG_ConvertADtoGFI_ChannelNum+0 
	CALL        _ConvertADtoGFI+0, 0
;Spcinitial.c,392 :: 		if(GFITestValue < 20)
	MOVLW       128
	XORWF       R1, 0 
	MOVWF       R2 
	MOVLW       128
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SelfCheck77
	MOVLW       20
	SUBWF       R0, 0 
L__SelfCheck77:
	BTFSC       STATUS+0, 0 
	GOTO        L_SelfCheck49
;Spcinitial.c,393 :: 		SystemFailureEn = 1;
	MOVLW       1
	MOVWF       SelfCheck_SystemFailureEn_L0+0 
L_SelfCheck49:
;Spcinitial.c,395 :: 		LATC5_bit = 0;
	BCF         LATC5_bit+0, BitPos(LATC5_bit+0) 
;Spcinitial.c,396 :: 		LATF1_bit = 0;
	BCF         LATF1_bit+0, BitPos(LATF1_bit+0) 
;Spcinitial.c,399 :: 		Delay_ms(2000);
	MOVLW       51
	MOVWF       R11, 0
	MOVLW       187
	MOVWF       R12, 0
	MOVLW       223
	MOVWF       R13, 0
L_SelfCheck50:
	DECFSZ      R13, 1, 1
	BRA         L_SelfCheck50
	DECFSZ      R12, 1, 1
	BRA         L_SelfCheck50
	DECFSZ      R11, 1, 1
	BRA         L_SelfCheck50
	NOP
	NOP
;Spcinitial.c,400 :: 		if(SystemFailureEn)
	MOVF        SelfCheck_SystemFailureEn_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SelfCheck51
;Spcinitial.c,402 :: 		if(!(ActivedAlarms & SELFCHECKFAILURE))
	BTFSC       _ActivedAlarms+3, 4 
	GOTO        L_SelfCheck52
;Spcinitial.c,403 :: 		alarmoperate(SELFCHECKFAILURE,ENALARM);
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVLW       0
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVLW       16
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	MOVLW       1
	MOVWF       FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
L_SelfCheck52:
;Spcinitial.c,405 :: 		LED_SYSTEM_FAIL = 1;
	BSF         LATE2_bit+0, BitPos(LATE2_bit+0) 
;Spcinitial.c,406 :: 		getParaChar(Info_Line1, ALARM_SELFCHECKFAIL_STR);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       71
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Spcinitial.c,407 :: 		ClearStr(Info_Line2, 16);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_ClearStr_target+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_ClearStr_target+1 
	MOVLW       16
	MOVWF       FARG_ClearStr_len+0 
	MOVLW       0
	MOVWF       FARG_ClearStr_len+1 
	CALL        _ClearStr+0, 0
;Spcinitial.c,408 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
;Spcinitial.c,409 :: 		}
L_SelfCheck51:
;Spcinitial.c,410 :: 		Delay_ms(2000);
	MOVLW       51
	MOVWF       R11, 0
	MOVLW       187
	MOVWF       R12, 0
	MOVLW       223
	MOVWF       R13, 0
L_SelfCheck53:
	DECFSZ      R13, 1, 1
	BRA         L_SelfCheck53
	DECFSZ      R12, 1, 1
	BRA         L_SelfCheck53
	DECFSZ      R11, 1, 1
	BRA         L_SelfCheck53
	NOP
	NOP
;Spcinitial.c,411 :: 		asm nop;
	NOP
;Spcinitial.c,412 :: 		}
L_end_SelfCheck:
	RETURN      0
; end of _SelfCheck
