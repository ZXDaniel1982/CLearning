
_USART_send:

;usart.c,11 :: 		void USART_send(UCHAR *bufout, char len)
;usart.c,15 :: 		en485tx();
	CALL        _en485tx+0, 0
;usart.c,17 :: 		for(i=0; i<len; i++)
	CLRF        USART_send_i_L0+0 
L_USART_send0:
	MOVF        FARG_USART_send_len+0, 0 
	SUBWF       USART_send_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_USART_send1
;usart.c,19 :: 		TXREG1 = *(bufout+i);
	MOVF        USART_send_i_L0+0, 0 
	ADDWF       FARG_USART_send_bufout+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_USART_send_bufout+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       TXREG1+0 
;usart.c,20 :: 		while(!(UART1_Tx_Idle()));
L_USART_send3:
	CALL        _UART1_Tx_Idle+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_USART_send4
	GOTO        L_USART_send3
L_USART_send4:
;usart.c,17 :: 		for(i=0; i<len; i++)
	INCF        USART_send_i_L0+0, 1 
;usart.c,21 :: 		}
	GOTO        L_USART_send0
L_USART_send1:
;usart.c,22 :: 		en485rx();
	CALL        _en485rx+0, 0
;usart.c,23 :: 		}
L_end_USART_send:
	RETURN      0
; end of _USART_send

_en485rx:

;usart.c,30 :: 		void en485rx()      //使能485接收
;usart.c,32 :: 		RE = 0;
	BCF         LATF4_bit+0, BitPos(LATF4_bit+0) 
;usart.c,33 :: 		DE = 0;
	BCF         LATF3_bit+0, BitPos(LATF3_bit+0) 
;usart.c,34 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_en485rx5:
	DECFSZ      R13, 1, 1
	BRA         L_en485rx5
	DECFSZ      R12, 1, 1
	BRA         L_en485rx5
	DECFSZ      R11, 1, 1
	BRA         L_en485rx5
	NOP
	NOP
;usart.c,35 :: 		}
L_end_en485rx:
	RETURN      0
; end of _en485rx

_en485tx:

;usart.c,37 :: 		void en485tx()      //使能485发送
;usart.c,39 :: 		RE = 1;
	BSF         LATF4_bit+0, BitPos(LATF4_bit+0) 
;usart.c,40 :: 		DE = 1;
	BSF         LATF3_bit+0, BitPos(LATF3_bit+0) 
;usart.c,41 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_en485tx6:
	DECFSZ      R13, 1, 1
	BRA         L_en485tx6
	DECFSZ      R12, 1, 1
	BRA         L_en485tx6
	DECFSZ      R11, 1, 1
	BRA         L_en485tx6
	NOP
	NOP
;usart.c,42 :: 		}
L_end_en485tx:
	RETURN      0
; end of _en485tx

_CommunicationErrorCheck:

;usart.c,44 :: 		void CommunicationErrorCheck()
;usart.c,46 :: 		if(OERR_RCSTA_bit)
	BTFSS       OERR_RCSTA_bit+0, BitPos(OERR_RCSTA_bit+0) 
	GOTO        L_CommunicationErrorCheck7
;usart.c,48 :: 		CREN_RCSTA_bit = 0;
	BCF         CREN_RCSTA_bit+0, BitPos(CREN_RCSTA_bit+0) 
;usart.c,49 :: 		Delay_ms(10);
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_CommunicationErrorCheck8:
	DECFSZ      R13, 1, 1
	BRA         L_CommunicationErrorCheck8
	DECFSZ      R12, 1, 1
	BRA         L_CommunicationErrorCheck8
	NOP
;usart.c,50 :: 		CREN_RCSTA_bit = 1;
	BSF         CREN_RCSTA_bit+0, BitPos(CREN_RCSTA_bit+0) 
;usart.c,51 :: 		}
L_CommunicationErrorCheck7:
;usart.c,52 :: 		}
L_end_CommunicationErrorCheck:
	RETURN      0
; end of _CommunicationErrorCheck
