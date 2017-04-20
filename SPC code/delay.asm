
_delayMS:

;delay.c,10 :: 		void delayMS(unsigned int delayCounter)
;delay.c,13 :: 		for(j=0; j<delayCounter; j++)
	CLRF        R3 
	CLRF        R4 
L_delayMS0:
	MOVF        FARG_delayMS_delayCounter+1, 0 
	SUBWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__delayMS15
	MOVF        FARG_delayMS_delayCounter+0, 0 
	SUBWF       R3, 0 
L__delayMS15:
	BTFSC       STATUS+0, 0 
	GOTO        L_delayMS1
;delay.c,15 :: 		for(i=0; i<5000; i++);
	CLRF        R1 
	CLRF        R2 
L_delayMS3:
	MOVLW       19
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__delayMS16
	MOVLW       136
	SUBWF       R1, 0 
L__delayMS16:
	BTFSC       STATUS+0, 0 
	GOTO        L_delayMS4
	INFSNZ      R1, 1 
	INCF        R2, 1 
	GOTO        L_delayMS3
L_delayMS4:
;delay.c,13 :: 		for(j=0; j<delayCounter; j++)
	INFSNZ      R3, 1 
	INCF        R4, 1 
;delay.c,16 :: 		}
	GOTO        L_delayMS0
L_delayMS1:
;delay.c,17 :: 		}
	RETURN      0
; end of _delayMS

_Delay:

;delay.c,19 :: 		void Delay()
;delay.c,23 :: 		for(i = 0; i < 0xffff; i++);
	CLRF        R1 
	CLRF        R2 
L_Delay6:
	MOVLW       255
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Delay17
	MOVLW       255
	SUBWF       R1, 0 
L__Delay17:
	BTFSC       STATUS+0, 0 
	GOTO        L_Delay7
	INFSNZ      R1, 1 
	INCF        R2, 1 
	GOTO        L_Delay6
L_Delay7:
;delay.c,24 :: 		for(i = 0; i < 0xffff; i++);
	CLRF        R1 
	CLRF        R2 
L_Delay9:
	MOVLW       255
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Delay18
	MOVLW       255
	SUBWF       R1, 0 
L__Delay18:
	BTFSC       STATUS+0, 0 
	GOTO        L_Delay10
	INFSNZ      R1, 1 
	INCF        R2, 1 
	GOTO        L_Delay9
L_Delay10:
;delay.c,25 :: 		for(i = 0; i < 0xffff; i++);
	CLRF        R1 
	CLRF        R2 
L_Delay12:
	MOVLW       255
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Delay19
	MOVLW       255
	SUBWF       R1, 0 
L__Delay19:
	BTFSC       STATUS+0, 0 
	GOTO        L_Delay13
	INFSNZ      R1, 1 
	INCF        R2, 1 
	GOTO        L_Delay12
L_Delay13:
;delay.c,26 :: 		}
	RETURN      0
; end of _Delay
