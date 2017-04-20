
_MCP3202_GET_AD_ONCE:

;MCP3202.c,11 :: 		UINT MCP3202_GET_AD_ONCE(UCHAR Spi_Channel,UCHAR Spi_AD_CMD)
;MCP3202.c,17 :: 		LATD &= ~Spi_Channel;          //chip select
	COMF        FARG_MCP3202_GET_AD_ONCE_Spi_Channel+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       LATD+0, 1 
;MCP3202.c,19 :: 		for(i=0; i<0xff; i++);
	CLRF        R8 
	CLRF        R9 
L_MCP3202_GET_AD_ONCE0:
	MOVLW       0
	SUBWF       R9, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__MCP3202_GET_AD_ONCE17
	MOVLW       255
	SUBWF       R8, 0 
L__MCP3202_GET_AD_ONCE17:
	BTFSC       STATUS+0, 0 
	GOTO        L_MCP3202_GET_AD_ONCE1
	INFSNZ      R8, 1 
	INCF        R9, 1 
	GOTO        L_MCP3202_GET_AD_ONCE0
L_MCP3202_GET_AD_ONCE1:
;MCP3202.c,21 :: 		SSP2BUF = 0x01;
	MOVLW       1
	MOVWF       SSP2BUF+0 
;MCP3202.c,22 :: 		while(!(SSP2IF_bit));
L_MCP3202_GET_AD_ONCE3:
	BTFSC       SSP2IF_bit+0, BitPos(SSP2IF_bit+0) 
	GOTO        L_MCP3202_GET_AD_ONCE4
	GOTO        L_MCP3202_GET_AD_ONCE3
L_MCP3202_GET_AD_ONCE4:
;MCP3202.c,23 :: 		SSP2IF_bit = 0;
	BCF         SSP2IF_bit+0, BitPos(SSP2IF_bit+0) 
;MCP3202.c,25 :: 		dummy = SSP2BUF;
	MOVF        SSP2BUF+0, 0 
	MOVWF       R10 
;MCP3202.c,27 :: 		SSP2BUF = Spi_AD_CMD;        //  1110 0000
	MOVF        FARG_MCP3202_GET_AD_ONCE_Spi_AD_CMD+0, 0 
	MOVWF       SSP2BUF+0 
;MCP3202.c,28 :: 		while(!(SSP2IF_bit));
L_MCP3202_GET_AD_ONCE5:
	BTFSC       SSP2IF_bit+0, BitPos(SSP2IF_bit+0) 
	GOTO        L_MCP3202_GET_AD_ONCE6
	GOTO        L_MCP3202_GET_AD_ONCE5
L_MCP3202_GET_AD_ONCE6:
;MCP3202.c,29 :: 		SSP2IF_bit = 0;
	BCF         SSP2IF_bit+0, BitPos(SSP2IF_bit+0) 
;MCP3202.c,31 :: 		rcdataH = SSP2BUF & 0x0f;
	MOVLW       15
	ANDWF       SSP2BUF+0, 0 
	MOVWF       R4 
	CLRF        R5 
	MOVLW       0
	ANDWF       R5, 1 
	MOVLW       0
	MOVWF       R5 
;MCP3202.c,32 :: 		temp = rcdataH & 0x0f;
	MOVLW       15
	ANDWF       R4, 0 
	MOVWF       R2 
	MOVF        R5, 0 
	MOVWF       R3 
	MOVLW       0
	ANDWF       R3, 1 
;MCP3202.c,33 :: 		temp = temp << 8;
	MOVF        R2, 0 
	MOVWF       R3 
	CLRF        R2 
;MCP3202.c,35 :: 		SSP2BUF = 0;
	CLRF        SSP2BUF+0 
;MCP3202.c,36 :: 		while(!(SSP2IF_bit));
L_MCP3202_GET_AD_ONCE7:
	BTFSC       SSP2IF_bit+0, BitPos(SSP2IF_bit+0) 
	GOTO        L_MCP3202_GET_AD_ONCE8
	GOTO        L_MCP3202_GET_AD_ONCE7
L_MCP3202_GET_AD_ONCE8:
;MCP3202.c,37 :: 		SSP2IF_bit = 0;
	BCF         SSP2IF_bit+0, BitPos(SSP2IF_bit+0) 
;MCP3202.c,39 :: 		rcdataL = SSP2BUF;
	MOVF        SSP2BUF+0, 0 
	MOVWF       R6 
	MOVLW       0
	MOVWF       R7 
;MCP3202.c,40 :: 		temp |= rcdataL;
	MOVF        R6, 0 
	IORWF       R2, 1 
	MOVF        R7, 0 
	IORWF       R3, 1 
;MCP3202.c,42 :: 		LATD |= Spi_Channel;
	MOVF        FARG_MCP3202_GET_AD_ONCE_Spi_Channel+0, 0 
	IORWF       LATD+0, 1 
;MCP3202.c,44 :: 		asm nop;
	NOP
;MCP3202.c,46 :: 		return temp;
	MOVF        R2, 0 
	MOVWF       R0 
	MOVF        R3, 0 
	MOVWF       R1 
;MCP3202.c,47 :: 		}
L_end_MCP3202_GET_AD_ONCE:
	RETURN      0
; end of _MCP3202_GET_AD_ONCE

_MCP3202_GET_AD:

;MCP3202.c,55 :: 		UINT MCP3202_GET_AD(UCHAR Spi_Channel,UCHAR Spi_AD_CMD, char NumOfSample)
;MCP3202.c,58 :: 		unsigned int rcdata,rcdatamax=0,rcdatamin=0;
	CLRF        MCP3202_GET_AD_rcdatamax_L0+0 
	CLRF        MCP3202_GET_AD_rcdatamax_L0+1 
	CLRF        MCP3202_GET_AD_rcdatamin_L0+0 
	CLRF        MCP3202_GET_AD_rcdatamin_L0+1 
	CLRF        MCP3202_GET_AD_rcdatatemp_L0+0 
	CLRF        MCP3202_GET_AD_rcdatatemp_L0+1 
	CLRF        MCP3202_GET_AD_rcdatatemp_L0+2 
	CLRF        MCP3202_GET_AD_rcdatatemp_L0+3 
;MCP3202.c,61 :: 		for(i=0; i<NumOfSample; i++)
	CLRF        MCP3202_GET_AD_i_L0+0 
L_MCP3202_GET_AD9:
	MOVF        FARG_MCP3202_GET_AD_NumOfSample+0, 0 
	SUBWF       MCP3202_GET_AD_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_MCP3202_GET_AD10
;MCP3202.c,63 :: 		rcdata = MCP3202_GET_AD_ONCE(Spi_Channel,Spi_AD_CMD);
	MOVF        FARG_MCP3202_GET_AD_Spi_Channel+0, 0 
	MOVWF       FARG_MCP3202_GET_AD_ONCE_Spi_Channel+0 
	MOVF        FARG_MCP3202_GET_AD_Spi_AD_CMD+0, 0 
	MOVWF       FARG_MCP3202_GET_AD_ONCE_Spi_AD_CMD+0 
	CALL        _MCP3202_GET_AD_ONCE+0, 0
	MOVF        R0, 0 
	MOVWF       MCP3202_GET_AD_rcdata_L0+0 
	MOVF        R1, 0 
	MOVWF       MCP3202_GET_AD_rcdata_L0+1 
;MCP3202.c,64 :: 		rcdatatemp += (unsigned long)rcdata;
	MOVLW       0
	MOVWF       R2 
	MOVWF       R3 
	MOVF        R0, 0 
	ADDWF       MCP3202_GET_AD_rcdatatemp_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      MCP3202_GET_AD_rcdatatemp_L0+1, 1 
	MOVF        R2, 0 
	ADDWFC      MCP3202_GET_AD_rcdatatemp_L0+2, 1 
	MOVF        R3, 0 
	ADDWFC      MCP3202_GET_AD_rcdatatemp_L0+3, 1 
;MCP3202.c,66 :: 		if(i==0)
	MOVF        MCP3202_GET_AD_i_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_MCP3202_GET_AD12
;MCP3202.c,68 :: 		rcdatamax = rcdata;
	MOVF        MCP3202_GET_AD_rcdata_L0+0, 0 
	MOVWF       MCP3202_GET_AD_rcdatamax_L0+0 
	MOVF        MCP3202_GET_AD_rcdata_L0+1, 0 
	MOVWF       MCP3202_GET_AD_rcdatamax_L0+1 
;MCP3202.c,69 :: 		rcdatamin = rcdata;
	MOVF        MCP3202_GET_AD_rcdata_L0+0, 0 
	MOVWF       MCP3202_GET_AD_rcdatamin_L0+0 
	MOVF        MCP3202_GET_AD_rcdata_L0+1, 0 
	MOVWF       MCP3202_GET_AD_rcdatamin_L0+1 
;MCP3202.c,70 :: 		}
	GOTO        L_MCP3202_GET_AD13
L_MCP3202_GET_AD12:
;MCP3202.c,73 :: 		if(rcdata > rcdatamax) rcdatamax = rcdata;
	MOVF        MCP3202_GET_AD_rcdata_L0+1, 0 
	SUBWF       MCP3202_GET_AD_rcdatamax_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__MCP3202_GET_AD19
	MOVF        MCP3202_GET_AD_rcdata_L0+0, 0 
	SUBWF       MCP3202_GET_AD_rcdatamax_L0+0, 0 
L__MCP3202_GET_AD19:
	BTFSC       STATUS+0, 0 
	GOTO        L_MCP3202_GET_AD14
	MOVF        MCP3202_GET_AD_rcdata_L0+0, 0 
	MOVWF       MCP3202_GET_AD_rcdatamax_L0+0 
	MOVF        MCP3202_GET_AD_rcdata_L0+1, 0 
	MOVWF       MCP3202_GET_AD_rcdatamax_L0+1 
L_MCP3202_GET_AD14:
;MCP3202.c,74 :: 		if(rcdata < rcdatamin) rcdatamin = rcdata;
	MOVF        MCP3202_GET_AD_rcdatamin_L0+1, 0 
	SUBWF       MCP3202_GET_AD_rcdata_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__MCP3202_GET_AD20
	MOVF        MCP3202_GET_AD_rcdatamin_L0+0, 0 
	SUBWF       MCP3202_GET_AD_rcdata_L0+0, 0 
L__MCP3202_GET_AD20:
	BTFSC       STATUS+0, 0 
	GOTO        L_MCP3202_GET_AD15
	MOVF        MCP3202_GET_AD_rcdata_L0+0, 0 
	MOVWF       MCP3202_GET_AD_rcdatamin_L0+0 
	MOVF        MCP3202_GET_AD_rcdata_L0+1, 0 
	MOVWF       MCP3202_GET_AD_rcdatamin_L0+1 
L_MCP3202_GET_AD15:
;MCP3202.c,75 :: 		}
L_MCP3202_GET_AD13:
;MCP3202.c,61 :: 		for(i=0; i<NumOfSample; i++)
	INCF        MCP3202_GET_AD_i_L0+0, 1 
;MCP3202.c,76 :: 		}
	GOTO        L_MCP3202_GET_AD9
L_MCP3202_GET_AD10:
;MCP3202.c,77 :: 		rcdata = (unsigned int)((rcdatatemp-rcdatamax-rcdatamin)/98.0);
	MOVF        MCP3202_GET_AD_rcdatatemp_L0+0, 0 
	MOVWF       R0 
	MOVF        MCP3202_GET_AD_rcdatatemp_L0+1, 0 
	MOVWF       R1 
	MOVF        MCP3202_GET_AD_rcdatatemp_L0+2, 0 
	MOVWF       R2 
	MOVF        MCP3202_GET_AD_rcdatatemp_L0+3, 0 
	MOVWF       R3 
	MOVF        MCP3202_GET_AD_rcdatamax_L0+0, 0 
	SUBWF       R0, 1 
	MOVF        MCP3202_GET_AD_rcdatamax_L0+1, 0 
	SUBWFB      R1, 1 
	MOVLW       0
	SUBWFB      R2, 1 
	SUBWFB      R3, 1 
	MOVF        MCP3202_GET_AD_rcdatamin_L0+0, 0 
	SUBWF       R0, 1 
	MOVF        MCP3202_GET_AD_rcdatamin_L0+1, 0 
	SUBWFB      R1, 1 
	MOVLW       0
	SUBWFB      R2, 1 
	SUBWFB      R3, 1 
	CALL        _Longword2Double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       68
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       MCP3202_GET_AD_rcdata_L0+0 
	MOVF        R1, 0 
	MOVWF       MCP3202_GET_AD_rcdata_L0+1 
;MCP3202.c,78 :: 		return rcdata;
;MCP3202.c,79 :: 		}
L_end_MCP3202_GET_AD:
	RETURN      0
; end of _MCP3202_GET_AD
