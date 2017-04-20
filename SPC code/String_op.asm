
_getParaChar:

;String_op.c,9 :: 		void getParaChar(char *ptr, char locat)
;String_op.c,12 :: 		for(i=0;i<16;i++)
	CLRF        getParaChar_i_L0+0 
L_getParaChar0:
	MOVLW       16
	SUBWF       getParaChar_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_getParaChar1
;String_op.c,13 :: 		*(ptr+i) = ParaChar[locat][i];
	MOVF        getParaChar_i_L0+0, 0 
	ADDWF       FARG_getParaChar_ptr+0, 0 
	MOVWF       FLOC__getParaChar+0 
	MOVLW       0
	ADDWFC      FARG_getParaChar_ptr+1, 0 
	MOVWF       FLOC__getParaChar+1 
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        FARG_getParaChar_locat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       String_op_ParaChar+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(String_op_ParaChar+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(String_op_ParaChar+0)
	ADDWFC      R2, 1 
	MOVF        getParaChar_i_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVFF       FLOC__getParaChar+0, FSR1
	MOVFF       FLOC__getParaChar+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;String_op.c,12 :: 		for(i=0;i<16;i++)
	INCF        getParaChar_i_L0+0, 1 
;String_op.c,13 :: 		*(ptr+i) = ParaChar[locat][i];
	GOTO        L_getParaChar0
L_getParaChar1:
;String_op.c,14 :: 		}
L_end_getParaChar:
	RETURN      0
; end of _getParaChar

_ClearStr:

;String_op.c,21 :: 		void ClearStr(char *target, int len)
;String_op.c,24 :: 		for(i=0; i<len; i++)
	CLRF        R1 
	CLRF        R2 
L_ClearStr3:
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_ClearStr_len+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ClearStr11
	MOVF        FARG_ClearStr_len+0, 0 
	SUBWF       R1, 0 
L__ClearStr11:
	BTFSC       STATUS+0, 0 
	GOTO        L_ClearStr4
;String_op.c,25 :: 		*(target+i) = ' ';
	MOVF        R1, 0 
	ADDWF       FARG_ClearStr_target+0, 0 
	MOVWF       FSR1 
	MOVF        R2, 0 
	ADDWFC      FARG_ClearStr_target+1, 0 
	MOVWF       FSR1H 
	MOVLW       32
	MOVWF       POSTINC1+0 
;String_op.c,24 :: 		for(i=0; i<len; i++)
	INFSNZ      R1, 1 
	INCF        R2, 1 
;String_op.c,25 :: 		*(target+i) = ' ';
	GOTO        L_ClearStr3
L_ClearStr4:
;String_op.c,26 :: 		}
L_end_ClearStr:
	RETURN      0
; end of _ClearStr

_MemeSet:

;String_op.c,28 :: 		void MemeSet(char *target, char Transdata, int len)
;String_op.c,31 :: 		for(i=0; i<len; i++)
	CLRF        R1 
	CLRF        R2 
L_MemeSet6:
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_MemeSet_len+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__MemeSet13
	MOVF        FARG_MemeSet_len+0, 0 
	SUBWF       R1, 0 
L__MemeSet13:
	BTFSC       STATUS+0, 0 
	GOTO        L_MemeSet7
;String_op.c,32 :: 		*(target+i) = Transdata;
	MOVF        R1, 0 
	ADDWF       FARG_MemeSet_target+0, 0 
	MOVWF       FSR1 
	MOVF        R2, 0 
	ADDWFC      FARG_MemeSet_target+1, 0 
	MOVWF       FSR1H 
	MOVF        FARG_MemeSet_Transdata+0, 0 
	MOVWF       POSTINC1+0 
;String_op.c,31 :: 		for(i=0; i<len; i++)
	INFSNZ      R1, 1 
	INCF        R2, 1 
;String_op.c,32 :: 		*(target+i) = Transdata;
	GOTO        L_MemeSet6
L_MemeSet7:
;String_op.c,33 :: 		}
L_end_MemeSet:
	RETURN      0
; end of _MemeSet
