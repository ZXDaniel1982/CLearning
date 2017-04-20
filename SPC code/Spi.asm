
_Spi_send:

;Spi.c,10 :: 		void Spi_send(UCHAR SpiTXdata)
;Spi.c,14 :: 		dummy = SSP2BUF;
	MOVF        SSP2BUF+0, 0 
	MOVWF       R0 
;Spi.c,15 :: 		SSP2BUF = SpiTXdata;
	MOVF        FARG_Spi_send_SpiTXdata+0, 0 
	MOVWF       SSP2BUF+0 
;Spi.c,16 :: 		while(!(SSP2IF_bit));
L_Spi_send0:
	BTFSC       SSP2IF_bit+0, BitPos(SSP2IF_bit+0) 
	GOTO        L_Spi_send1
	GOTO        L_Spi_send0
L_Spi_send1:
;Spi.c,17 :: 		SSP2IF_bit = 0;
	BCF         SSP2IF_bit+0, BitPos(SSP2IF_bit+0) 
;Spi.c,18 :: 		}
L_end_Spi_send:
	RETURN      0
; end of _Spi_send

_Spi_receive:

;Spi.c,25 :: 		UCHAR Spi_receive(UCHAR SpiCommand)
;Spi.c,30 :: 		dummy = SSP2BUF;
	MOVF        SSP2BUF+0, 0 
	MOVWF       R1 
;Spi.c,31 :: 		SSP2BUF = SpiCommand;
	MOVF        FARG_Spi_receive_SpiCommand+0, 0 
	MOVWF       SSP2BUF+0 
;Spi.c,32 :: 		while(!(SSP2IF_bit));
L_Spi_receive2:
	BTFSC       SSP2IF_bit+0, BitPos(SSP2IF_bit+0) 
	GOTO        L_Spi_receive3
	GOTO        L_Spi_receive2
L_Spi_receive3:
;Spi.c,33 :: 		SSP2IF_bit = 0;
	BCF         SSP2IF_bit+0, BitPos(SSP2IF_bit+0) 
;Spi.c,34 :: 		SpiRCdata = SSP2BUF;
	MOVF        SSP2BUF+0, 0 
	MOVWF       R2 
;Spi.c,36 :: 		return(SpiRCdata);
	MOVF        R2, 0 
	MOVWF       R0 
;Spi.c,37 :: 		}
L_end_Spi_receive:
	RETURN      0
; end of _Spi_receive
