
_keyboard_get_value:

;Menuoperation.c,36 :: 		ULONG keyboard_get_value()
;Menuoperation.c,41 :: 		ReadQtKeys();
	CALL        _ReadQtKeys+0, 0
;Menuoperation.c,42 :: 		Key_Input.word = 0;
	CLRF        keyboard_get_value_Key_Input_L0+0 
	CLRF        keyboard_get_value_Key_Input_L0+1 
	CLRF        keyboard_get_value_Key_Input_L0+2 
	CLRF        keyboard_get_value_Key_Input_L0+3 
;Menuoperation.c,43 :: 		for(i=0; i<NUM_QT_KEY_BYTES; i++)
	CLRF        keyboard_get_value_i_L0+0 
L_keyboard_get_value0:
	MOVLW       3
	SUBWF       keyboard_get_value_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_keyboard_get_value1
;Menuoperation.c,45 :: 		Key_Input.byte[i] = GetQtKeys(i);
	MOVLW       keyboard_get_value_Key_Input_L0+0
	MOVWF       FLOC__keyboard_get_value+0 
	MOVLW       hi_addr(keyboard_get_value_Key_Input_L0+0)
	MOVWF       FLOC__keyboard_get_value+1 
	MOVF        keyboard_get_value_i_L0+0, 0 
	ADDWF       FLOC__keyboard_get_value+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__keyboard_get_value+1, 1 
	MOVF        keyboard_get_value_i_L0+0, 0 
	MOVWF       FARG_GetQtKeys_Index+0 
	CALL        _GetQtKeys+0, 0
	MOVFF       FLOC__keyboard_get_value+0, FSR1
	MOVFF       FLOC__keyboard_get_value+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Menuoperation.c,43 :: 		for(i=0; i<NUM_QT_KEY_BYTES; i++)
	INCF        keyboard_get_value_i_L0+0, 1 
;Menuoperation.c,46 :: 		}
	GOTO        L_keyboard_get_value0
L_keyboard_get_value1:
;Menuoperation.c,48 :: 		return Key_Input.word;
	MOVF        keyboard_get_value_Key_Input_L0+0, 0 
	MOVWF       R0 
	MOVF        keyboard_get_value_Key_Input_L0+1, 0 
	MOVWF       R1 
	MOVF        keyboard_get_value_Key_Input_L0+2, 0 
	MOVWF       R2 
	MOVF        keyboard_get_value_Key_Input_L0+3, 0 
	MOVWF       R3 
;Menuoperation.c,49 :: 		}
L_end_keyboard_get_value:
	RETURN      0
; end of _keyboard_get_value

_KeyVerify:

;Menuoperation.c,51 :: 		char KeyVerify(unsigned long KeyBuff)
;Menuoperation.c,57 :: 		char ret=0;
	CLRF        KeyVerify_ret_L0+0 
;Menuoperation.c,59 :: 		switch(KeyVerifyStatus)
	GOTO        L_KeyVerify3
;Menuoperation.c,61 :: 		case 0://idel
L_KeyVerify5:
;Menuoperation.c,62 :: 		if(KeyBuff != 0)
	MOVLW       0
	MOVWF       R0 
	XORWF       FARG_KeyVerify_KeyBuff+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__KeyVerify304
	MOVF        R0, 0 
	XORWF       FARG_KeyVerify_KeyBuff+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__KeyVerify304
	MOVF        R0, 0 
	XORWF       FARG_KeyVerify_KeyBuff+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__KeyVerify304
	MOVF        FARG_KeyVerify_KeyBuff+0, 0 
	XORLW       0
L__KeyVerify304:
	BTFSC       STATUS+0, 2 
	GOTO        L_KeyVerify6
;Menuoperation.c,64 :: 		KeyVerifyBUff = KeyBuff;
	MOVF        FARG_KeyVerify_KeyBuff+0, 0 
	MOVWF       KeyVerify_KeyVerifyBUff_L0+0 
	MOVF        FARG_KeyVerify_KeyBuff+1, 0 
	MOVWF       KeyVerify_KeyVerifyBUff_L0+1 
	MOVF        FARG_KeyVerify_KeyBuff+2, 0 
	MOVWF       KeyVerify_KeyVerifyBUff_L0+2 
	MOVF        FARG_KeyVerify_KeyBuff+3, 0 
	MOVWF       KeyVerify_KeyVerifyBUff_L0+3 
;Menuoperation.c,65 :: 		KeyVerifyStatus = 1;
	MOVLW       1
	MOVWF       KeyVerify_KeyVerifyStatus_L0+0 
;Menuoperation.c,66 :: 		KeyVerifyCount = 0;
	CLRF        KeyVerify_KeyVerifyCount_L0+0 
;Menuoperation.c,67 :: 		KeyHoldCount = 0;
	CLRF        KeyVerify_KeyHoldCount_L0+0 
;Menuoperation.c,68 :: 		KeyHoldEn = 0;
	CLRF        _KeyHoldEn+0 
;Menuoperation.c,69 :: 		KeyHoldStep = 1;
	MOVLW       1
	MOVWF       _KeyHoldStep+0 
	MOVLW       0
	MOVWF       _KeyHoldStep+1 
;Menuoperation.c,70 :: 		KeyHoldStepCount = 0;
	CLRF        KeyVerify_KeyHoldStepCount_L0+0 
	CLRF        KeyVerify_KeyHoldStepCount_L0+1 
;Menuoperation.c,71 :: 		ret=1;
	MOVLW       1
	MOVWF       KeyVerify_ret_L0+0 
;Menuoperation.c,72 :: 		}
	GOTO        L_KeyVerify7
L_KeyVerify6:
;Menuoperation.c,74 :: 		ret=0;
	CLRF        KeyVerify_ret_L0+0 
L_KeyVerify7:
;Menuoperation.c,75 :: 		break;
	GOTO        L_KeyVerify4
;Menuoperation.c,76 :: 		case 1://first push
L_KeyVerify8:
;Menuoperation.c,77 :: 		if(KeyVerifyBUff == KeyBuff)
	MOVF        KeyVerify_KeyVerifyBUff_L0+3, 0 
	XORWF       FARG_KeyVerify_KeyBuff+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__KeyVerify305
	MOVF        KeyVerify_KeyVerifyBUff_L0+2, 0 
	XORWF       FARG_KeyVerify_KeyBuff+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__KeyVerify305
	MOVF        KeyVerify_KeyVerifyBUff_L0+1, 0 
	XORWF       FARG_KeyVerify_KeyBuff+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__KeyVerify305
	MOVF        KeyVerify_KeyVerifyBUff_L0+0, 0 
	XORWF       FARG_KeyVerify_KeyBuff+0, 0 
L__KeyVerify305:
	BTFSS       STATUS+0, 2 
	GOTO        L_KeyVerify9
;Menuoperation.c,79 :: 		KeyVerifyCount++;
	INCF        KeyVerify_KeyVerifyCount_L0+0, 1 
;Menuoperation.c,80 :: 		if(KeyVerifyCount > 20)
	MOVF        KeyVerify_KeyVerifyCount_L0+0, 0 
	SUBLW       20
	BTFSC       STATUS+0, 0 
	GOTO        L_KeyVerify10
;Menuoperation.c,82 :: 		KeyVerifyCount = 0;
	CLRF        KeyVerify_KeyVerifyCount_L0+0 
;Menuoperation.c,83 :: 		ret = 1;
	MOVLW       1
	MOVWF       KeyVerify_ret_L0+0 
;Menuoperation.c,84 :: 		if((KeyBuff == KEY_VALUE_UP) || (KeyBuff == KEY_VALUE_DOWN))
	MOVLW       0
	MOVWF       R0 
	XORWF       FARG_KeyVerify_KeyBuff+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__KeyVerify306
	MOVF        R0, 0 
	XORWF       FARG_KeyVerify_KeyBuff+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__KeyVerify306
	MOVF        R0, 0 
	XORWF       FARG_KeyVerify_KeyBuff+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__KeyVerify306
	MOVF        FARG_KeyVerify_KeyBuff+0, 0 
	XORLW       16
L__KeyVerify306:
	BTFSC       STATUS+0, 2 
	GOTO        L__KeyVerify296
	MOVLW       0
	MOVWF       R0 
	XORWF       FARG_KeyVerify_KeyBuff+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__KeyVerify307
	MOVF        R0, 0 
	XORWF       FARG_KeyVerify_KeyBuff+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__KeyVerify307
	MOVF        R0, 0 
	XORWF       FARG_KeyVerify_KeyBuff+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__KeyVerify307
	MOVF        FARG_KeyVerify_KeyBuff+0, 0 
	XORLW       4
L__KeyVerify307:
	BTFSC       STATUS+0, 2 
	GOTO        L__KeyVerify296
	GOTO        L_KeyVerify13
L__KeyVerify296:
;Menuoperation.c,86 :: 		KeyHoldCount++;
	INCF        KeyVerify_KeyHoldCount_L0+0, 1 
;Menuoperation.c,87 :: 		if(KeyHoldCount > 5)
	MOVF        KeyVerify_KeyHoldCount_L0+0, 0 
	SUBLW       5
	BTFSC       STATUS+0, 0 
	GOTO        L_KeyVerify14
;Menuoperation.c,89 :: 		KeyVerifyStatus = 3;  //enable hold
	MOVLW       3
	MOVWF       KeyVerify_KeyVerifyStatus_L0+0 
;Menuoperation.c,90 :: 		}
L_KeyVerify14:
;Menuoperation.c,91 :: 		}
L_KeyVerify13:
;Menuoperation.c,92 :: 		}
	GOTO        L_KeyVerify15
L_KeyVerify10:
;Menuoperation.c,95 :: 		ret = 0;
	CLRF        KeyVerify_ret_L0+0 
;Menuoperation.c,96 :: 		}
L_KeyVerify15:
;Menuoperation.c,98 :: 		if(KeyErrorCount++ > 2000)
	MOVF        KeyVerify_KeyErrorCount_L0+0, 0 
	MOVWF       R1 
	INCF        KeyVerify_KeyErrorCount_L0+0, 1 
	MOVLW       128
	XORLW       7
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__KeyVerify308
	MOVF        R1, 0 
	SUBLW       208
L__KeyVerify308:
	BTFSC       STATUS+0, 0 
	GOTO        L_KeyVerify16
;Menuoperation.c,100 :: 		KeyErrorCount = 0;
	CLRF        KeyVerify_KeyErrorCount_L0+0 
;Menuoperation.c,101 :: 		KeyVerifyStatus = 4;
	MOVLW       4
	MOVWF       KeyVerify_KeyVerifyStatus_L0+0 
;Menuoperation.c,102 :: 		}
L_KeyVerify16:
;Menuoperation.c,103 :: 		}
	GOTO        L_KeyVerify17
L_KeyVerify9:
;Menuoperation.c,106 :: 		KeyVerifyCount = 0;
	CLRF        KeyVerify_KeyVerifyCount_L0+0 
;Menuoperation.c,107 :: 		KeyVerifyStatus = 2;  //enable quit touch
	MOVLW       2
	MOVWF       KeyVerify_KeyVerifyStatus_L0+0 
;Menuoperation.c,108 :: 		ret = 0;
	CLRF        KeyVerify_ret_L0+0 
;Menuoperation.c,109 :: 		}
L_KeyVerify17:
;Menuoperation.c,110 :: 		break;
	GOTO        L_KeyVerify4
;Menuoperation.c,111 :: 		case 2://quit touch
L_KeyVerify18:
;Menuoperation.c,112 :: 		KeyVerifyCount++;
	INCF        KeyVerify_KeyVerifyCount_L0+0, 1 
;Menuoperation.c,113 :: 		if(KeyVerifyCount > 5)
	MOVF        KeyVerify_KeyVerifyCount_L0+0, 0 
	SUBLW       5
	BTFSC       STATUS+0, 0 
	GOTO        L_KeyVerify19
;Menuoperation.c,115 :: 		KeyVerifyBUff = 0;
	CLRF        KeyVerify_KeyVerifyBUff_L0+0 
	CLRF        KeyVerify_KeyVerifyBUff_L0+1 
	CLRF        KeyVerify_KeyVerifyBUff_L0+2 
	CLRF        KeyVerify_KeyVerifyBUff_L0+3 
;Menuoperation.c,116 :: 		KeyVerifyStatus = 0;   //back to idel
	CLRF        KeyVerify_KeyVerifyStatus_L0+0 
;Menuoperation.c,117 :: 		KeyVerifyCount = 0;
	CLRF        KeyVerify_KeyVerifyCount_L0+0 
;Menuoperation.c,118 :: 		KeyHoldCount = 0;
	CLRF        KeyVerify_KeyHoldCount_L0+0 
;Menuoperation.c,119 :: 		KeyHoldEn = 0;
	CLRF        _KeyHoldEn+0 
;Menuoperation.c,120 :: 		KeyHoldStep = 1;
	MOVLW       1
	MOVWF       _KeyHoldStep+0 
	MOVLW       0
	MOVWF       _KeyHoldStep+1 
;Menuoperation.c,121 :: 		KeyHoldStepCount = 0;
	CLRF        KeyVerify_KeyHoldStepCount_L0+0 
	CLRF        KeyVerify_KeyHoldStepCount_L0+1 
;Menuoperation.c,122 :: 		ret=0;
	CLRF        KeyVerify_ret_L0+0 
;Menuoperation.c,123 :: 		}
	GOTO        L_KeyVerify20
L_KeyVerify19:
;Menuoperation.c,125 :: 		ret = 0;
	CLRF        KeyVerify_ret_L0+0 
L_KeyVerify20:
;Menuoperation.c,126 :: 		break;
	GOTO        L_KeyVerify4
;Menuoperation.c,127 :: 		case 3://hold
L_KeyVerify21:
;Menuoperation.c,128 :: 		if(KeyVerifyBUff == KeyBuff)
	MOVF        KeyVerify_KeyVerifyBUff_L0+3, 0 
	XORWF       FARG_KeyVerify_KeyBuff+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__KeyVerify309
	MOVF        KeyVerify_KeyVerifyBUff_L0+2, 0 
	XORWF       FARG_KeyVerify_KeyBuff+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__KeyVerify309
	MOVF        KeyVerify_KeyVerifyBUff_L0+1, 0 
	XORWF       FARG_KeyVerify_KeyBuff+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__KeyVerify309
	MOVF        KeyVerify_KeyVerifyBUff_L0+0, 0 
	XORWF       FARG_KeyVerify_KeyBuff+0, 0 
L__KeyVerify309:
	BTFSS       STATUS+0, 2 
	GOTO        L_KeyVerify22
;Menuoperation.c,132 :: 		KeyVerifyCount++;
	INCF        KeyVerify_KeyVerifyCount_L0+0, 1 
;Menuoperation.c,133 :: 		if(KeyVerifyCount > 4)
	MOVF        KeyVerify_KeyVerifyCount_L0+0, 0 
	SUBLW       4
	BTFSC       STATUS+0, 0 
	GOTO        L_KeyVerify23
;Menuoperation.c,135 :: 		KeyVerifyCount = 0;
	CLRF        KeyVerify_KeyVerifyCount_L0+0 
;Menuoperation.c,136 :: 		ret = 1;
	MOVLW       1
	MOVWF       KeyVerify_ret_L0+0 
;Menuoperation.c,137 :: 		KeyHoldEn = 1;
	MOVLW       1
	MOVWF       _KeyHoldEn+0 
;Menuoperation.c,138 :: 		}
	GOTO        L_KeyVerify24
L_KeyVerify23:
;Menuoperation.c,141 :: 		ret = 0;
	CLRF        KeyVerify_ret_L0+0 
;Menuoperation.c,142 :: 		KeyHoldEn = 0;
	CLRF        _KeyHoldEn+0 
;Menuoperation.c,143 :: 		}
L_KeyVerify24:
;Menuoperation.c,145 :: 		if(KeyErrorCount++ > 2000)
	MOVF        KeyVerify_KeyErrorCount_L0+0, 0 
	MOVWF       R1 
	INCF        KeyVerify_KeyErrorCount_L0+0, 1 
	MOVLW       128
	XORLW       7
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__KeyVerify310
	MOVF        R1, 0 
	SUBLW       208
L__KeyVerify310:
	BTFSC       STATUS+0, 0 
	GOTO        L_KeyVerify25
;Menuoperation.c,147 :: 		KeyErrorCount = 0;
	CLRF        KeyVerify_KeyErrorCount_L0+0 
;Menuoperation.c,148 :: 		KeyVerifyStatus = 4;
	MOVLW       4
	MOVWF       KeyVerify_KeyVerifyStatus_L0+0 
;Menuoperation.c,149 :: 		}
L_KeyVerify25:
;Menuoperation.c,150 :: 		}
	GOTO        L_KeyVerify26
L_KeyVerify22:
;Menuoperation.c,153 :: 		KeyVerifyBUff = 0;
	CLRF        KeyVerify_KeyVerifyBUff_L0+0 
	CLRF        KeyVerify_KeyVerifyBUff_L0+1 
	CLRF        KeyVerify_KeyVerifyBUff_L0+2 
	CLRF        KeyVerify_KeyVerifyBUff_L0+3 
;Menuoperation.c,154 :: 		KeyVerifyStatus = 0;   //back to idel
	CLRF        KeyVerify_KeyVerifyStatus_L0+0 
;Menuoperation.c,155 :: 		KeyVerifyCount = 0;
	CLRF        KeyVerify_KeyVerifyCount_L0+0 
;Menuoperation.c,156 :: 		KeyHoldCount = 0;
	CLRF        KeyVerify_KeyHoldCount_L0+0 
;Menuoperation.c,157 :: 		KeyHoldEn = 0;
	CLRF        _KeyHoldEn+0 
;Menuoperation.c,158 :: 		KeyHoldStep = 1;
	MOVLW       1
	MOVWF       _KeyHoldStep+0 
	MOVLW       0
	MOVWF       _KeyHoldStep+1 
;Menuoperation.c,159 :: 		KeyHoldStepCount = 0;
	CLRF        KeyVerify_KeyHoldStepCount_L0+0 
	CLRF        KeyVerify_KeyHoldStepCount_L0+1 
;Menuoperation.c,160 :: 		ret=0;
	CLRF        KeyVerify_ret_L0+0 
;Menuoperation.c,161 :: 		}
L_KeyVerify26:
;Menuoperation.c,162 :: 		break;
	GOTO        L_KeyVerify4
;Menuoperation.c,163 :: 		case 4://error
L_KeyVerify27:
;Menuoperation.c,164 :: 		KeyErrorCount = 0;
	CLRF        KeyVerify_KeyErrorCount_L0+0 
;Menuoperation.c,165 :: 		KeyVerifyBUff = 0;
	CLRF        KeyVerify_KeyVerifyBUff_L0+0 
	CLRF        KeyVerify_KeyVerifyBUff_L0+1 
	CLRF        KeyVerify_KeyVerifyBUff_L0+2 
	CLRF        KeyVerify_KeyVerifyBUff_L0+3 
;Menuoperation.c,166 :: 		KeyVerifyStatus = 0;   //back to idel
	CLRF        KeyVerify_KeyVerifyStatus_L0+0 
;Menuoperation.c,167 :: 		KeyVerifyCount = 0;
	CLRF        KeyVerify_KeyVerifyCount_L0+0 
;Menuoperation.c,168 :: 		KeyHoldCount = 0;
	CLRF        KeyVerify_KeyHoldCount_L0+0 
;Menuoperation.c,169 :: 		KeyHoldEn = 0;
	CLRF        _KeyHoldEn+0 
;Menuoperation.c,170 :: 		KeyHoldStep = 1;
	MOVLW       1
	MOVWF       _KeyHoldStep+0 
	MOVLW       0
	MOVWF       _KeyHoldStep+1 
;Menuoperation.c,171 :: 		KeyHoldStepCount = 0;
	CLRF        KeyVerify_KeyHoldStepCount_L0+0 
	CLRF        KeyVerify_KeyHoldStepCount_L0+1 
;Menuoperation.c,172 :: 		ret=0;
	CLRF        KeyVerify_ret_L0+0 
;Menuoperation.c,173 :: 		QT60Initial();
	CALL        _QT60Initial+0, 0
;Menuoperation.c,174 :: 		ReadQtSetup();
	CALL        _ReadQtSetup+0, 0
;Menuoperation.c,175 :: 		break;
	GOTO        L_KeyVerify4
;Menuoperation.c,176 :: 		}
L_KeyVerify3:
	MOVF        KeyVerify_KeyVerifyStatus_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_KeyVerify5
	MOVF        KeyVerify_KeyVerifyStatus_L0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_KeyVerify8
	MOVF        KeyVerify_KeyVerifyStatus_L0+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_KeyVerify18
	MOVF        KeyVerify_KeyVerifyStatus_L0+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_KeyVerify21
	MOVF        KeyVerify_KeyVerifyStatus_L0+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_KeyVerify27
L_KeyVerify4:
;Menuoperation.c,178 :: 		if(KeyHoldEn)
	MOVF        _KeyHoldEn+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_KeyVerify28
;Menuoperation.c,180 :: 		KeyHoldEn = 0;
	CLRF        _KeyHoldEn+0 
;Menuoperation.c,186 :: 		if(KeyHoldStepCount > 5)
	MOVLW       0
	MOVWF       R0 
	MOVF        KeyVerify_KeyHoldStepCount_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__KeyVerify311
	MOVF        KeyVerify_KeyHoldStepCount_L0+0, 0 
	SUBLW       5
L__KeyVerify311:
	BTFSC       STATUS+0, 0 
	GOTO        L_KeyVerify29
;Menuoperation.c,188 :: 		KeyHoldStepCount++;
	INFSNZ      KeyVerify_KeyHoldStepCount_L0+0, 1 
	INCF        KeyVerify_KeyHoldStepCount_L0+1, 1 
;Menuoperation.c,189 :: 		KeyHoldStep = 10;
	MOVLW       10
	MOVWF       _KeyHoldStep+0 
	MOVLW       0
	MOVWF       _KeyHoldStep+1 
;Menuoperation.c,190 :: 		}
	GOTO        L_KeyVerify30
L_KeyVerify29:
;Menuoperation.c,193 :: 		KeyHoldStepCount++;
	INFSNZ      KeyVerify_KeyHoldStepCount_L0+0, 1 
	INCF        KeyVerify_KeyHoldStepCount_L0+1, 1 
;Menuoperation.c,194 :: 		KeyHoldStep = 1;
	MOVLW       1
	MOVWF       _KeyHoldStep+0 
	MOVLW       0
	MOVWF       _KeyHoldStep+1 
;Menuoperation.c,195 :: 		}
L_KeyVerify30:
;Menuoperation.c,196 :: 		}
L_KeyVerify28:
;Menuoperation.c,198 :: 		return ret;
	MOVF        KeyVerify_ret_L0+0, 0 
	MOVWF       R0 
;Menuoperation.c,199 :: 		}
L_end_KeyVerify:
	RETURN      0
; end of _KeyVerify

_ErrorCheck:

;Menuoperation.c,201 :: 		void ErrorCheck(unsigned long KeyBuff)
;Menuoperation.c,205 :: 		if(ErrorDectect)
	MOVF        ErrorCheck_ErrorDectect_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_ErrorCheck31
;Menuoperation.c,207 :: 		if(KeyBuff == 0)
	MOVLW       0
	MOVWF       R0 
	XORWF       FARG_ErrorCheck_KeyBuff+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ErrorCheck313
	MOVF        R0, 0 
	XORWF       FARG_ErrorCheck_KeyBuff+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ErrorCheck313
	MOVF        R0, 0 
	XORWF       FARG_ErrorCheck_KeyBuff+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ErrorCheck313
	MOVF        FARG_ErrorCheck_KeyBuff+0, 0 
	XORLW       0
L__ErrorCheck313:
	BTFSS       STATUS+0, 2 
	GOTO        L_ErrorCheck32
;Menuoperation.c,209 :: 		ErrorDectect = 0;
	CLRF        ErrorCheck_ErrorDectect_L0+0 
;Menuoperation.c,210 :: 		ErrorDectectCount++;
	INCF        ErrorCheck_ErrorDectectCount_L0+0, 1 
;Menuoperation.c,211 :: 		}
	GOTO        L_ErrorCheck33
L_ErrorCheck32:
;Menuoperation.c,214 :: 		ErrorDectect = 0;
	CLRF        ErrorCheck_ErrorDectect_L0+0 
;Menuoperation.c,215 :: 		ErrorDectectCount = 0;
	CLRF        ErrorCheck_ErrorDectectCount_L0+0 
;Menuoperation.c,216 :: 		}
L_ErrorCheck33:
;Menuoperation.c,217 :: 		}
	GOTO        L_ErrorCheck34
L_ErrorCheck31:
;Menuoperation.c,220 :: 		if(KeyBuff != 0)
	MOVLW       0
	MOVWF       R0 
	XORWF       FARG_ErrorCheck_KeyBuff+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ErrorCheck314
	MOVF        R0, 0 
	XORWF       FARG_ErrorCheck_KeyBuff+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ErrorCheck314
	MOVF        R0, 0 
	XORWF       FARG_ErrorCheck_KeyBuff+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ErrorCheck314
	MOVF        FARG_ErrorCheck_KeyBuff+0, 0 
	XORLW       0
L__ErrorCheck314:
	BTFSC       STATUS+0, 2 
	GOTO        L_ErrorCheck35
;Menuoperation.c,222 :: 		ErrorDectect = 1;
	MOVLW       1
	MOVWF       ErrorCheck_ErrorDectect_L0+0 
;Menuoperation.c,223 :: 		ErrorDectectCount++;
	INCF        ErrorCheck_ErrorDectectCount_L0+0, 1 
;Menuoperation.c,224 :: 		}
	GOTO        L_ErrorCheck36
L_ErrorCheck35:
;Menuoperation.c,227 :: 		ErrorDectectCount = 0;
	CLRF        ErrorCheck_ErrorDectectCount_L0+0 
;Menuoperation.c,228 :: 		}
L_ErrorCheck36:
;Menuoperation.c,229 :: 		}
L_ErrorCheck34:
;Menuoperation.c,231 :: 		if(ErrorDectectCount >= 8)
	MOVLW       8
	SUBWF       ErrorCheck_ErrorDectectCount_L0+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_ErrorCheck37
;Menuoperation.c,233 :: 		ErrorDectectCount = 0;
	CLRF        ErrorCheck_ErrorDectectCount_L0+0 
;Menuoperation.c,234 :: 		ErrorDectect = 0;
	CLRF        ErrorCheck_ErrorDectect_L0+0 
;Menuoperation.c,235 :: 		QT60Reset();
	CALL        _QT60Reset+0, 0
;Menuoperation.c,238 :: 		}
L_ErrorCheck37:
;Menuoperation.c,239 :: 		}
L_end_ErrorCheck:
	RETURN      0
; end of _ErrorCheck

_EnableTimeout:

;Menuoperation.c,241 :: 		void EnableTimeout()
;Menuoperation.c,243 :: 		spc_system_flag.bite.default_diaped = 0;
	BCF         _spc_system_flag+1, 2 
;Menuoperation.c,244 :: 		spc_count.Timeout_count = 0;
	CLRF        _spc_count+4 
	CLRF        _spc_count+5 
;Menuoperation.c,245 :: 		}
L_end_EnableTimeout:
	RETURN      0
; end of _EnableTimeout

_ResetPSWSeq:

;Menuoperation.c,251 :: 		char ResetPSWSeq(char ResetStep)
;Menuoperation.c,253 :: 		if(reset_psw_en)
	MOVF        _reset_psw_en+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_ResetPSWSeq38
;Menuoperation.c,255 :: 		ResetPasswordStep = 0;
	CLRF        _ResetPasswordStep+0 
;Menuoperation.c,256 :: 		ResetPasswordCount = 0;
	CLRF        _ResetPasswordCount+0 
	CLRF        _ResetPasswordCount+1 
;Menuoperation.c,257 :: 		return 0;
	CLRF        R0 
	GOTO        L_end_ResetPSWSeq
;Menuoperation.c,258 :: 		}
L_ResetPSWSeq38:
;Menuoperation.c,261 :: 		if(ResetStep == PSWRESETSTEP1)
	MOVF        FARG_ResetPSWSeq_ResetStep+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_ResetPSWSeq40
;Menuoperation.c,263 :: 		if((ResetPasswordStep == 0)|| (ResetPasswordStep == 1))
	MOVF        _ResetPasswordStep+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__ResetPSWSeq297
	MOVF        _ResetPasswordStep+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__ResetPSWSeq297
	GOTO        L_ResetPSWSeq43
L__ResetPSWSeq297:
;Menuoperation.c,265 :: 		ResetPasswordStep++;
	INCF        _ResetPasswordStep+0, 1 
;Menuoperation.c,266 :: 		ResetPasswordCount = 0;
	CLRF        _ResetPasswordCount+0 
	CLRF        _ResetPasswordCount+1 
;Menuoperation.c,267 :: 		}
	GOTO        L_ResetPSWSeq44
L_ResetPSWSeq43:
;Menuoperation.c,270 :: 		ResetPasswordStep = 0;
	CLRF        _ResetPasswordStep+0 
;Menuoperation.c,271 :: 		ResetPasswordCount = 0;
	CLRF        _ResetPasswordCount+0 
	CLRF        _ResetPasswordCount+1 
;Menuoperation.c,272 :: 		}
L_ResetPSWSeq44:
;Menuoperation.c,273 :: 		return 0;
	CLRF        R0 
	GOTO        L_end_ResetPSWSeq
;Menuoperation.c,274 :: 		}
L_ResetPSWSeq40:
;Menuoperation.c,275 :: 		else if(ResetStep == PSWRESETSTEP2)
	MOVF        FARG_ResetPSWSeq_ResetStep+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_ResetPSWSeq46
;Menuoperation.c,277 :: 		if(ResetPasswordStep == 2)
	MOVF        _ResetPasswordStep+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_ResetPSWSeq47
;Menuoperation.c,279 :: 		ResetPasswordStep++;
	INCF        _ResetPasswordStep+0, 1 
;Menuoperation.c,280 :: 		ResetPasswordCount = 0;
	CLRF        _ResetPasswordCount+0 
	CLRF        _ResetPasswordCount+1 
;Menuoperation.c,281 :: 		return 0;
	CLRF        R0 
	GOTO        L_end_ResetPSWSeq
;Menuoperation.c,282 :: 		}
L_ResetPSWSeq47:
;Menuoperation.c,283 :: 		else if(ResetPasswordStep == 3)
	MOVF        _ResetPasswordStep+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_ResetPSWSeq49
;Menuoperation.c,285 :: 		ResetPasswordStep = 0;
	CLRF        _ResetPasswordStep+0 
;Menuoperation.c,286 :: 		ResetPasswordCount = 0;
	CLRF        _ResetPasswordCount+0 
	CLRF        _ResetPasswordCount+1 
;Menuoperation.c,287 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_ResetPSWSeq
;Menuoperation.c,288 :: 		}
L_ResetPSWSeq49:
;Menuoperation.c,291 :: 		ResetPasswordStep = 0;
	CLRF        _ResetPasswordStep+0 
;Menuoperation.c,292 :: 		ResetPasswordCount = 0;
	CLRF        _ResetPasswordCount+0 
	CLRF        _ResetPasswordCount+1 
;Menuoperation.c,293 :: 		return 0;
	CLRF        R0 
	GOTO        L_end_ResetPSWSeq
;Menuoperation.c,295 :: 		}
L_ResetPSWSeq46:
;Menuoperation.c,298 :: 		ResetPasswordStep = 0;
	CLRF        _ResetPasswordStep+0 
;Menuoperation.c,299 :: 		ResetPasswordCount = 0;
	CLRF        _ResetPasswordCount+0 
	CLRF        _ResetPasswordCount+1 
;Menuoperation.c,300 :: 		return 0;
	CLRF        R0 
;Menuoperation.c,303 :: 		}
L_end_ResetPSWSeq:
	RETURN      0
; end of _ResetPSWSeq

_SPCMenuOperation:

;Menuoperation.c,305 :: 		void SPCMenuOperation()
;Menuoperation.c,307 :: 		ULONG KeyValue=0;
	CLRF        SPCMenuOperation_KeyValue_L0+0 
	CLRF        SPCMenuOperation_KeyValue_L0+1 
	CLRF        SPCMenuOperation_KeyValue_L0+2 
	CLRF        SPCMenuOperation_KeyValue_L0+3 
	CLRF        SPCMenuOperation_bUpdate_L0+0 
;Menuoperation.c,311 :: 		KeyValue = keyboard_get_value();
	CALL        _keyboard_get_value+0, 0
	MOVF        R0, 0 
	MOVWF       SPCMenuOperation_KeyValue_L0+0 
	MOVF        R1, 0 
	MOVWF       SPCMenuOperation_KeyValue_L0+1 
	MOVF        R2, 0 
	MOVWF       SPCMenuOperation_KeyValue_L0+2 
	MOVF        R3, 0 
	MOVWF       SPCMenuOperation_KeyValue_L0+3 
;Menuoperation.c,312 :: 		KeyValue &= 0x000001ff;
	MOVLW       255
	ANDWF       R0, 1 
	MOVLW       1
	ANDWF       R1, 1 
	MOVLW       0
	ANDWF       R2, 1 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	MOVWF       SPCMenuOperation_KeyValue_L0+0 
	MOVF        R1, 0 
	MOVWF       SPCMenuOperation_KeyValue_L0+1 
	MOVF        R2, 0 
	MOVWF       SPCMenuOperation_KeyValue_L0+2 
	MOVF        R3, 0 
	MOVWF       SPCMenuOperation_KeyValue_L0+3 
;Menuoperation.c,314 :: 		bUpdate = KeyVerify(KeyValue);
	MOVF        R0, 0 
	MOVWF       FARG_KeyVerify_KeyBuff+0 
	MOVF        R1, 0 
	MOVWF       FARG_KeyVerify_KeyBuff+1 
	MOVF        R2, 0 
	MOVWF       FARG_KeyVerify_KeyBuff+2 
	MOVF        R3, 0 
	MOVWF       FARG_KeyVerify_KeyBuff+3 
	CALL        _KeyVerify+0, 0
	MOVF        R0, 0 
	MOVWF       SPCMenuOperation_bUpdate_L0+0 
;Menuoperation.c,315 :: 		ErrorCheck(KeyValue);
	MOVF        SPCMenuOperation_KeyValue_L0+0, 0 
	MOVWF       FARG_ErrorCheck_KeyBuff+0 
	MOVF        SPCMenuOperation_KeyValue_L0+1, 0 
	MOVWF       FARG_ErrorCheck_KeyBuff+1 
	MOVF        SPCMenuOperation_KeyValue_L0+2, 0 
	MOVWF       FARG_ErrorCheck_KeyBuff+2 
	MOVF        SPCMenuOperation_KeyValue_L0+3, 0 
	MOVWF       FARG_ErrorCheck_KeyBuff+3 
	CALL        _ErrorCheck+0, 0
;Menuoperation.c,317 :: 		if(bUpdate)
	MOVF        SPCMenuOperation_bUpdate_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCMenuOperation52
;Menuoperation.c,319 :: 		switch(KeyValue)
	GOTO        L_SPCMenuOperation53
;Menuoperation.c,321 :: 		case KEY_VALUE_UP:    //up key
L_SPCMenuOperation55:
;Menuoperation.c,323 :: 		ResetAutoAutho();
	CALL        _ResetAutoAutho+0, 0
;Menuoperation.c,324 :: 		if(spc_system_flag.bite.default_diaped == 1)
	BTFSS       _spc_system_flag+1, 2 
	GOTO        L_SPCMenuOperation56
;Menuoperation.c,326 :: 		ResetPSWSeq(PSWRESETSTEP1);
	CLRF        FARG_ResetPSWSeq_ResetStep+0 
	CALL        _ResetPSWSeq+0, 0
;Menuoperation.c,327 :: 		Reset_PSW(CMD_FORWARD,CMD_ADJUST);
	MOVLW       1
	MOVWF       FARG_Reset_PSW_direct+0 
	MOVLW       4
	MOVWF       FARG_Reset_PSW_cmd+0 
	CALL        _Reset_PSW+0, 0
;Menuoperation.c,328 :: 		return;
	GOTO        L_end_SPCMenuOperation
;Menuoperation.c,329 :: 		}
L_SPCMenuOperation56:
;Menuoperation.c,331 :: 		EnableTimeout();
	CALL        _EnableTimeout+0, 0
;Menuoperation.c,333 :: 		if(reset_psw_en)
	MOVF        _reset_psw_en+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCMenuOperation57
;Menuoperation.c,334 :: 		Reset_PSW(CMD_FORWARD,CMD_ADJUST);          //reset password
	MOVLW       1
	MOVWF       FARG_Reset_PSW_direct+0 
	MOVLW       4
	MOVWF       FARG_Reset_PSW_cmd+0 
	CALL        _Reset_PSW+0, 0
	GOTO        L_SPCMenuOperation58
L_SPCMenuOperation57:
;Menuoperation.c,335 :: 		else if(ChannelSelStat != CH_SEL_RESET)
	MOVF        _ChannelSelStat+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCMenuOperation59
;Menuoperation.c,336 :: 		ChannelConfig(CMD_FORWARD,CMD_ADJUST);
	MOVLW       1
	MOVWF       FARG_ChannelConfig_direct+0 
	MOVLW       4
	MOVWF       FARG_ChannelConfig_cmd+0 
	CALL        _ChannelConfig+0, 0
	GOTO        L_SPCMenuOperation60
L_SPCMenuOperation59:
;Menuoperation.c,337 :: 		else if(!(spc_system_flag.bite.alarm_actived))
	BTFSC       _spc_system_flag+1, 0 
	GOTO        L_SPCMenuOperation61
;Menuoperation.c,339 :: 		set_menu_info(CMD_FORWARD,CMD_ADJUST);       //for normal navigation
	MOVLW       1
	MOVWF       FARG_set_menu_info_direction+0 
	MOVLW       4
	MOVWF       FARG_set_menu_info_command+0 
	CALL        _set_menu_info+0, 0
;Menuoperation.c,340 :: 		if(spc_system_flag.bite.flashing_en)
	BTFSS       _spc_system_flag+1, 7 
	GOTO        L_SPCMenuOperation62
;Menuoperation.c,342 :: 		if(spc_system_flag.bite.flashing_state)
	BTFSS       _spc_system_flag+2, 1 
	GOTO        L_SPCMenuOperation63
;Menuoperation.c,343 :: 		spc_count.scanT = 0;
	CLRF        _spc_count+8 
	CLRF        _spc_count+9 
L_SPCMenuOperation63:
;Menuoperation.c,344 :: 		}
L_SPCMenuOperation62:
;Menuoperation.c,345 :: 		}
L_SPCMenuOperation61:
L_SPCMenuOperation60:
L_SPCMenuOperation58:
;Menuoperation.c,347 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
;Menuoperation.c,348 :: 		break;
	GOTO        L_SPCMenuOperation54
;Menuoperation.c,349 :: 		case KEY_VALUE_DOWN:
L_SPCMenuOperation64:
;Menuoperation.c,351 :: 		ResetAutoAutho();
	CALL        _ResetAutoAutho+0, 0
;Menuoperation.c,352 :: 		if(spc_system_flag.bite.default_diaped == 1)
	BTFSS       _spc_system_flag+1, 2 
	GOTO        L_SPCMenuOperation65
;Menuoperation.c,354 :: 		ResetPSWSeq(PSWRESETSTEPNONE);
	MOVLW       2
	MOVWF       FARG_ResetPSWSeq_ResetStep+0 
	CALL        _ResetPSWSeq+0, 0
;Menuoperation.c,355 :: 		Reset_PSW(CMD_BACKWARD,CMD_ADJUST);
	CLRF        FARG_Reset_PSW_direct+0 
	MOVLW       4
	MOVWF       FARG_Reset_PSW_cmd+0 
	CALL        _Reset_PSW+0, 0
;Menuoperation.c,356 :: 		return;
	GOTO        L_end_SPCMenuOperation
;Menuoperation.c,357 :: 		}
L_SPCMenuOperation65:
;Menuoperation.c,359 :: 		EnableTimeout();
	CALL        _EnableTimeout+0, 0
;Menuoperation.c,361 :: 		if(reset_psw_en)
	MOVF        _reset_psw_en+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCMenuOperation66
;Menuoperation.c,362 :: 		Reset_PSW(CMD_BACKWARD,CMD_ADJUST);                 //reset password
	CLRF        FARG_Reset_PSW_direct+0 
	MOVLW       4
	MOVWF       FARG_Reset_PSW_cmd+0 
	CALL        _Reset_PSW+0, 0
	GOTO        L_SPCMenuOperation67
L_SPCMenuOperation66:
;Menuoperation.c,363 :: 		else if(ChannelSelStat != CH_SEL_RESET)
	MOVF        _ChannelSelStat+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCMenuOperation68
;Menuoperation.c,364 :: 		ChannelConfig(CMD_BACKWARD,CMD_ADJUST);
	CLRF        FARG_ChannelConfig_direct+0 
	MOVLW       4
	MOVWF       FARG_ChannelConfig_cmd+0 
	CALL        _ChannelConfig+0, 0
	GOTO        L_SPCMenuOperation69
L_SPCMenuOperation68:
;Menuoperation.c,365 :: 		else if(!(spc_system_flag.bite.alarm_actived))
	BTFSC       _spc_system_flag+1, 0 
	GOTO        L_SPCMenuOperation70
;Menuoperation.c,367 :: 		set_menu_info(CMD_BACKWARD,CMD_ADJUST);             //for normal navigation
	CLRF        FARG_set_menu_info_direction+0 
	MOVLW       4
	MOVWF       FARG_set_menu_info_command+0 
	CALL        _set_menu_info+0, 0
;Menuoperation.c,368 :: 		if(spc_system_flag.bite.flashing_en)
	BTFSS       _spc_system_flag+1, 7 
	GOTO        L_SPCMenuOperation71
;Menuoperation.c,370 :: 		if(spc_system_flag.bite.flashing_state)
	BTFSS       _spc_system_flag+2, 1 
	GOTO        L_SPCMenuOperation72
;Menuoperation.c,371 :: 		spc_count.scanT = 0;
	CLRF        _spc_count+8 
	CLRF        _spc_count+9 
L_SPCMenuOperation72:
;Menuoperation.c,372 :: 		}
L_SPCMenuOperation71:
;Menuoperation.c,373 :: 		}
L_SPCMenuOperation70:
L_SPCMenuOperation69:
L_SPCMenuOperation67:
;Menuoperation.c,375 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
;Menuoperation.c,376 :: 		break;
	GOTO        L_SPCMenuOperation54
;Menuoperation.c,377 :: 		case KEY_VALUE_LEFT:
L_SPCMenuOperation73:
;Menuoperation.c,378 :: 		ResetPSWSeq(PSWRESETSTEPNONE);
	MOVLW       2
	MOVWF       FARG_ResetPSWSeq_ResetStep+0 
	CALL        _ResetPSWSeq+0, 0
;Menuoperation.c,379 :: 		ResetAutoAutho();
	CALL        _ResetAutoAutho+0, 0
;Menuoperation.c,380 :: 		if(spc_system_flag.bite.default_diaped == 1)
	BTFSS       _spc_system_flag+1, 2 
	GOTO        L_SPCMenuOperation74
;Menuoperation.c,381 :: 		return;
	GOTO        L_end_SPCMenuOperation
L_SPCMenuOperation74:
;Menuoperation.c,382 :: 		EnableTimeout();
	CALL        _EnableTimeout+0, 0
;Menuoperation.c,384 :: 		Scantime_DIS();
	CALL        _Scantime_DIS+0, 0
;Menuoperation.c,385 :: 		Flashing_DIS();
	CALL        _Flashing_DIS+0, 0
;Menuoperation.c,387 :: 		if(spc_system_flag.bite.alarm_actived)
	BTFSS       _spc_system_flag+1, 0 
	GOTO        L_SPCMenuOperation75
;Menuoperation.c,388 :: 		AlarmRoll(CMD_BACKWARD,ALARM_SUBINDEX);        //for alarm navigation
	CLRF        FARG_AlarmRoll_Forward+0 
	CLRF        FARG_AlarmRoll_Forward+1 
	MOVLW       1
	MOVWF       FARG_AlarmRoll_Alarmcmd+0 
	MOVLW       0
	MOVWF       FARG_AlarmRoll_Alarmcmd+1 
	CALL        _AlarmRoll+0, 0
	GOTO        L_SPCMenuOperation76
L_SPCMenuOperation75:
;Menuoperation.c,389 :: 		else if(spc_system_flag.bite.char_actived)
	BTFSS       _spc_system_flag+1, 3 
	GOTO        L_SPCMenuOperation77
;Menuoperation.c,390 :: 		set_menu_info(CMD_BACKWARD,CMD_SWITCH);        //for normal navigation
	CLRF        FARG_set_menu_info_direction+0 
	MOVLW       3
	MOVWF       FARG_set_menu_info_command+0 
	CALL        _set_menu_info+0, 0
	GOTO        L_SPCMenuOperation78
L_SPCMenuOperation77:
;Menuoperation.c,391 :: 		else if(reset_psw_en)
	MOVF        _reset_psw_en+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCMenuOperation79
;Menuoperation.c,392 :: 		Reset_PSW(NULL,CMD_SWITCH);                    //reset password
	CLRF        FARG_Reset_PSW_direct+0 
	MOVLW       3
	MOVWF       FARG_Reset_PSW_cmd+0 
	CALL        _Reset_PSW+0, 0
	GOTO        L_SPCMenuOperation80
L_SPCMenuOperation79:
;Menuoperation.c,393 :: 		else if(ChannelSelStat != CH_SEL_RESET)
	MOVF        _ChannelSelStat+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCMenuOperation81
;Menuoperation.c,395 :: 		if(ChannelSelStat == CH_SEL_ACTUAL)
	MOVF        _ChannelSelStat+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPCMenuOperation82
;Menuoperation.c,396 :: 		MenuRoll(CMD_FORWARD,MENU_IN_ACTUAL,INDEX);
	MOVLW       1
	MOVWF       FARG_MenuRoll_Forward+0 
	CLRF        FARG_MenuRoll_Para+0 
	MOVLW       4
	MOVWF       FARG_MenuRoll_Level+0 
	CALL        _MenuRoll+0, 0
	GOTO        L_SPCMenuOperation83
L_SPCMenuOperation82:
;Menuoperation.c,397 :: 		else if(ChannelSelStat == CH_SEL_PROG)
	MOVF        _ChannelSelStat+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_SPCMenuOperation84
;Menuoperation.c,398 :: 		MenuRoll(CMD_FORWARD,MENU_IN_PROGRAM,INDEX);
	MOVLW       1
	MOVWF       FARG_MenuRoll_Forward+0 
	MOVLW       1
	MOVWF       FARG_MenuRoll_Para+0 
	MOVLW       4
	MOVWF       FARG_MenuRoll_Level+0 
	CALL        _MenuRoll+0, 0
L_SPCMenuOperation84:
L_SPCMenuOperation83:
;Menuoperation.c,400 :: 		ChannelSelStat = CH_SEL_RESET;
	CLRF        _ChannelSelStat+0 
;Menuoperation.c,401 :: 		}
	GOTO        L_SPCMenuOperation85
L_SPCMenuOperation81:
;Menuoperation.c,403 :: 		MenuRoll(CMD_BACKWARD,NULL,THIRDINDEX);
	CLRF        FARG_MenuRoll_Forward+0 
	CLRF        FARG_MenuRoll_Para+0 
	MOVLW       6
	MOVWF       FARG_MenuRoll_Level+0 
	CALL        _MenuRoll+0, 0
L_SPCMenuOperation85:
L_SPCMenuOperation80:
L_SPCMenuOperation78:
L_SPCMenuOperation76:
;Menuoperation.c,405 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
;Menuoperation.c,406 :: 		break;
	GOTO        L_SPCMenuOperation54
;Menuoperation.c,407 :: 		case KEY_VALUE_RIGHT:
L_SPCMenuOperation86:
;Menuoperation.c,408 :: 		ResetPSWSeq(PSWRESETSTEPNONE);
	MOVLW       2
	MOVWF       FARG_ResetPSWSeq_ResetStep+0 
	CALL        _ResetPSWSeq+0, 0
;Menuoperation.c,409 :: 		ResetAutoAutho();
	CALL        _ResetAutoAutho+0, 0
;Menuoperation.c,410 :: 		if(spc_system_flag.bite.default_diaped == 1)
	BTFSS       _spc_system_flag+1, 2 
	GOTO        L_SPCMenuOperation87
;Menuoperation.c,411 :: 		return;
	GOTO        L_end_SPCMenuOperation
L_SPCMenuOperation87:
;Menuoperation.c,412 :: 		if(ChannelSelStat != CH_SEL_RESET)
	MOVF        _ChannelSelStat+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCMenuOperation88
;Menuoperation.c,414 :: 		if(ChannelSelStat == CH_SEL_ACTUAL)
	MOVF        _ChannelSelStat+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPCMenuOperation89
;Menuoperation.c,415 :: 		MenuRoll(CMD_FORWARD,MENU_IN_ACTUAL,INDEX);
	MOVLW       1
	MOVWF       FARG_MenuRoll_Forward+0 
	CLRF        FARG_MenuRoll_Para+0 
	MOVLW       4
	MOVWF       FARG_MenuRoll_Level+0 
	CALL        _MenuRoll+0, 0
	GOTO        L_SPCMenuOperation90
L_SPCMenuOperation89:
;Menuoperation.c,416 :: 		else if(ChannelSelStat == CH_SEL_PROG)
	MOVF        _ChannelSelStat+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_SPCMenuOperation91
;Menuoperation.c,417 :: 		MenuRoll(CMD_FORWARD,MENU_IN_PROGRAM,INDEX);
	MOVLW       1
	MOVWF       FARG_MenuRoll_Forward+0 
	MOVLW       1
	MOVWF       FARG_MenuRoll_Para+0 
	MOVLW       4
	MOVWF       FARG_MenuRoll_Level+0 
	CALL        _MenuRoll+0, 0
L_SPCMenuOperation91:
L_SPCMenuOperation90:
;Menuoperation.c,419 :: 		ChannelSelStat = CH_SEL_RESET;
	CLRF        _ChannelSelStat+0 
;Menuoperation.c,420 :: 		}
	GOTO        L_SPCMenuOperation92
L_SPCMenuOperation88:
;Menuoperation.c,423 :: 		rightkey_func();
	CALL        _rightkey_func+0, 0
;Menuoperation.c,424 :: 		}
L_SPCMenuOperation92:
;Menuoperation.c,425 :: 		EnableTimeout();
	CALL        _EnableTimeout+0, 0
;Menuoperation.c,426 :: 		break;
	GOTO        L_SPCMenuOperation54
;Menuoperation.c,427 :: 		case KEY_VALUE_ACTUAL:
L_SPCMenuOperation93:
;Menuoperation.c,428 :: 		ResetPSWSeq(PSWRESETSTEPNONE);
	MOVLW       2
	MOVWF       FARG_ResetPSWSeq_ResetStep+0 
	CALL        _ResetPSWSeq+0, 0
;Menuoperation.c,429 :: 		ResetAutoAutho();
	CALL        _ResetAutoAutho+0, 0
;Menuoperation.c,430 :: 		Alarmstat = 0;                                     //quit alarm display
	CLRF        _Alarmstat+0 
;Menuoperation.c,431 :: 		spc_system_flag.bite.char_actived = 0;             //quit ID or Password setting
	BCF         _spc_system_flag+1, 3 
;Menuoperation.c,432 :: 		reset_psw_en = 0;                                  //quit reset password
	CLRF        _reset_psw_en+0 
;Menuoperation.c,433 :: 		spc_system_flag.bite.char_flash = 0;               //stop flashing
	BCF         _spc_system_flag+3, 6 
;Menuoperation.c,434 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Menuoperation.c,435 :: 		Scantime_DIS();
	CALL        _Scantime_DIS+0, 0
;Menuoperation.c,436 :: 		Flashing_DIS();
	CALL        _Flashing_DIS+0, 0
;Menuoperation.c,437 :: 		if(ChannelSelStat!=CH_SEL_ACTUAL)
	MOVF        _ChannelSelStat+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCMenuOperation94
;Menuoperation.c,439 :: 		ChannelSelStat = CH_SEL_ACTUAL;
	MOVLW       1
	MOVWF       _ChannelSelStat+0 
;Menuoperation.c,440 :: 		ChannelConfig(CMD_FORWARD,CMD_RESET);
	MOVLW       1
	MOVWF       FARG_ChannelConfig_direct+0 
	MOVLW       2
	MOVWF       FARG_ChannelConfig_cmd+0 
	CALL        _ChannelConfig+0, 0
;Menuoperation.c,441 :: 		}
	GOTO        L_SPCMenuOperation95
L_SPCMenuOperation94:
;Menuoperation.c,443 :: 		MenuRoll(CMD_FORWARD,MENU_IN_ACTUAL,INDEX);         //for normal navigation
	MOVLW       1
	MOVWF       FARG_MenuRoll_Forward+0 
	CLRF        FARG_MenuRoll_Para+0 
	MOVLW       4
	MOVWF       FARG_MenuRoll_Level+0 
	CALL        _MenuRoll+0, 0
L_SPCMenuOperation95:
;Menuoperation.c,444 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
;Menuoperation.c,445 :: 		EnableTimeout();
	CALL        _EnableTimeout+0, 0
;Menuoperation.c,446 :: 		break;
	GOTO        L_SPCMenuOperation54
;Menuoperation.c,447 :: 		case KEY_VALUE_PROGRAM:
L_SPCMenuOperation96:
;Menuoperation.c,448 :: 		ResetPSWSeq(PSWRESETSTEPNONE);
	MOVLW       2
	MOVWF       FARG_ResetPSWSeq_ResetStep+0 
	CALL        _ResetPSWSeq+0, 0
;Menuoperation.c,449 :: 		ResetAutoAutho();
	CALL        _ResetAutoAutho+0, 0
;Menuoperation.c,450 :: 		EnableTimeout();
	CALL        _EnableTimeout+0, 0
;Menuoperation.c,451 :: 		Alarmstat = 0;                                       //quit alarm display
	CLRF        _Alarmstat+0 
;Menuoperation.c,452 :: 		spc_system_flag.bite.alarm_actived = 0;
	BCF         _spc_system_flag+1, 0 
;Menuoperation.c,453 :: 		spc_system_flag.bite.char_actived = 0;
	BCF         _spc_system_flag+1, 3 
;Menuoperation.c,454 :: 		spc_system_flag.bite.char_flash = 0;
	BCF         _spc_system_flag+3, 6 
;Menuoperation.c,455 :: 		reset_psw_en = 0;                                    //quit reset password
	CLRF        _reset_psw_en+0 
;Menuoperation.c,456 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Menuoperation.c,457 :: 		Flashing_DIS();
	CALL        _Flashing_DIS+0, 0
;Menuoperation.c,458 :: 		Scantime_DIS();
	CALL        _Scantime_DIS+0, 0
;Menuoperation.c,459 :: 		if(ChannelSelStat!=CH_SEL_PROG)
	MOVF        _ChannelSelStat+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCMenuOperation97
;Menuoperation.c,461 :: 		ChannelSelStat = CH_SEL_PROG;
	MOVLW       2
	MOVWF       _ChannelSelStat+0 
;Menuoperation.c,462 :: 		ChannelConfig(CMD_FORWARD,CMD_RESET);
	MOVLW       1
	MOVWF       FARG_ChannelConfig_direct+0 
	MOVLW       2
	MOVWF       FARG_ChannelConfig_cmd+0 
	CALL        _ChannelConfig+0, 0
;Menuoperation.c,463 :: 		}
	GOTO        L_SPCMenuOperation98
L_SPCMenuOperation97:
;Menuoperation.c,465 :: 		MenuRoll(CMD_FORWARD,MENU_IN_PROGRAM,INDEX);          //for normal navigation
	MOVLW       1
	MOVWF       FARG_MenuRoll_Forward+0 
	MOVLW       1
	MOVWF       FARG_MenuRoll_Para+0 
	MOVLW       4
	MOVWF       FARG_MenuRoll_Level+0 
	CALL        _MenuRoll+0, 0
L_SPCMenuOperation98:
;Menuoperation.c,466 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
;Menuoperation.c,467 :: 		break;
	GOTO        L_SPCMenuOperation54
;Menuoperation.c,468 :: 		case KEY_VALUE_ALARM:
L_SPCMenuOperation99:
;Menuoperation.c,469 :: 		ResetPSWSeq(PSWRESETSTEPNONE);
	MOVLW       2
	MOVWF       FARG_ResetPSWSeq_ResetStep+0 
	CALL        _ResetPSWSeq+0, 0
;Menuoperation.c,470 :: 		ResetAutoAutho();
	CALL        _ResetAutoAutho+0, 0
;Menuoperation.c,471 :: 		EnableTimeout();
	CALL        _EnableTimeout+0, 0
;Menuoperation.c,472 :: 		Menustat = 0;                                         //quit normal display
	CLRF        _Menustat+0 
;Menuoperation.c,473 :: 		spc_system_flag.bite.char_actived = 0;
	BCF         _spc_system_flag+1, 3 
;Menuoperation.c,474 :: 		spc_system_flag.bite.char_flash = 0;
	BCF         _spc_system_flag+3, 6 
;Menuoperation.c,475 :: 		reset_psw_en = 0;                                     //quit reset password
	CLRF        _reset_psw_en+0 
;Menuoperation.c,477 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Menuoperation.c,478 :: 		Flashing_DIS();
	CALL        _Flashing_DIS+0, 0
;Menuoperation.c,479 :: 		Scantime_DIS();
	CALL        _Scantime_DIS+0, 0
;Menuoperation.c,480 :: 		ChannelSelStat = CH_SEL_RESET;
	CLRF        _ChannelSelStat+0 
;Menuoperation.c,481 :: 		AlarmRoll(CMD_FORWARD,ALARM_INDEX);                   //for alarm navigation
	MOVLW       1
	MOVWF       FARG_AlarmRoll_Forward+0 
	MOVLW       0
	MOVWF       FARG_AlarmRoll_Forward+1 
	CLRF        FARG_AlarmRoll_Alarmcmd+0 
	CLRF        FARG_AlarmRoll_Alarmcmd+1 
	CALL        _AlarmRoll+0, 0
;Menuoperation.c,482 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
;Menuoperation.c,483 :: 		break;
	GOTO        L_SPCMenuOperation54
;Menuoperation.c,484 :: 		case KEY_VALUE_RESET:
L_SPCMenuOperation100:
;Menuoperation.c,485 :: 		ResetPSWSeq(PSWRESETSTEPNONE);
	MOVLW       2
	MOVWF       FARG_ResetPSWSeq_ResetStep+0 
	CALL        _ResetPSWSeq+0, 0
;Menuoperation.c,486 :: 		ResetAutoAutho();
	CALL        _ResetAutoAutho+0, 0
;Menuoperation.c,487 :: 		if(spc_system_flag.bite.default_diaped == 1)
	BTFSS       _spc_system_flag+1, 2 
	GOTO        L_SPCMenuOperation101
;Menuoperation.c,489 :: 		return;
	GOTO        L_end_SPCMenuOperation
;Menuoperation.c,490 :: 		}
L_SPCMenuOperation101:
;Menuoperation.c,492 :: 		EnableTimeout();
	CALL        _EnableTimeout+0, 0
;Menuoperation.c,494 :: 		Flashing_DIS();
	CALL        _Flashing_DIS+0, 0
;Menuoperation.c,495 :: 		if(spc_system_flag.bite.alarm_actived)
	BTFSS       _spc_system_flag+1, 0 
	GOTO        L_SPCMenuOperation102
;Menuoperation.c,496 :: 		AlarmRoll(NULL,CMD_RESET);                          //for alarm navigation
	CLRF        FARG_AlarmRoll_Forward+0 
	CLRF        FARG_AlarmRoll_Forward+1 
	MOVLW       2
	MOVWF       FARG_AlarmRoll_Alarmcmd+0 
	MOVLW       0
	MOVWF       FARG_AlarmRoll_Alarmcmd+1 
	CALL        _AlarmRoll+0, 0
	GOTO        L_SPCMenuOperation103
L_SPCMenuOperation102:
;Menuoperation.c,497 :: 		else if(reset_psw_en)
	MOVF        _reset_psw_en+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCMenuOperation104
;Menuoperation.c,498 :: 		Reset_PSW(NULL,CMD_RESET);                          //for reset password
	CLRF        FARG_Reset_PSW_direct+0 
	MOVLW       2
	MOVWF       FARG_Reset_PSW_cmd+0 
	CALL        _Reset_PSW+0, 0
	GOTO        L_SPCMenuOperation105
L_SPCMenuOperation104:
;Menuoperation.c,499 :: 		else if(ChannelSelStat != CH_SEL_RESET)
	MOVF        _ChannelSelStat+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCMenuOperation106
;Menuoperation.c,500 :: 		ChannelConfig(CMD_FORWARD,CMD_RESET);
	MOVLW       1
	MOVWF       FARG_ChannelConfig_direct+0 
	MOVLW       2
	MOVWF       FARG_ChannelConfig_cmd+0 
	CALL        _ChannelConfig+0, 0
	GOTO        L_SPCMenuOperation107
L_SPCMenuOperation106:
;Menuoperation.c,502 :: 		set_menu_info(NULL,CMD_RESET);                      //for normal navigation
	CLRF        FARG_set_menu_info_direction+0 
	MOVLW       2
	MOVWF       FARG_set_menu_info_command+0 
	CALL        _set_menu_info+0, 0
L_SPCMenuOperation107:
L_SPCMenuOperation105:
L_SPCMenuOperation103:
;Menuoperation.c,503 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
;Menuoperation.c,504 :: 		break;
	GOTO        L_SPCMenuOperation54
;Menuoperation.c,505 :: 		case KEY_VALUE_ENTER:
L_SPCMenuOperation108:
;Menuoperation.c,506 :: 		ResetAutoAutho();
	CALL        _ResetAutoAutho+0, 0
;Menuoperation.c,507 :: 		if(ResetPSWSeq(PSWRESETSTEP2))
	MOVLW       1
	MOVWF       FARG_ResetPSWSeq_ResetStep+0 
	CALL        _ResetPSWSeq+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCMenuOperation109
;Menuoperation.c,509 :: 		reset_psw_en = 1;
	MOVLW       1
	MOVWF       _reset_psw_en+0 
;Menuoperation.c,510 :: 		Reset_PSW(NULL,CMD_INIT);
	CLRF        FARG_Reset_PSW_direct+0 
	MOVLW       5
	MOVWF       FARG_Reset_PSW_cmd+0 
	CALL        _Reset_PSW+0, 0
;Menuoperation.c,511 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
;Menuoperation.c,512 :: 		return;
	GOTO        L_end_SPCMenuOperation
;Menuoperation.c,513 :: 		}
L_SPCMenuOperation109:
;Menuoperation.c,515 :: 		if(spc_system_flag.bite.default_diaped == 1)
	BTFSS       _spc_system_flag+1, 2 
	GOTO        L_SPCMenuOperation110
;Menuoperation.c,517 :: 		Reset_PSW(NULL,CMD_ENTER);
	CLRF        FARG_Reset_PSW_direct+0 
	MOVLW       1
	MOVWF       FARG_Reset_PSW_cmd+0 
	CALL        _Reset_PSW+0, 0
;Menuoperation.c,518 :: 		return;
	GOTO        L_end_SPCMenuOperation
;Menuoperation.c,519 :: 		}
L_SPCMenuOperation110:
;Menuoperation.c,521 :: 		if(spc_system_flag.bite.alarm_actived)
	BTFSS       _spc_system_flag+1, 0 
	GOTO        L_SPCMenuOperation111
;Menuoperation.c,522 :: 		return;
	GOTO        L_end_SPCMenuOperation
L_SPCMenuOperation111:
;Menuoperation.c,523 :: 		EnableTimeout();
	CALL        _EnableTimeout+0, 0
;Menuoperation.c,525 :: 		if(reset_psw_en)
	MOVF        _reset_psw_en+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCMenuOperation112
;Menuoperation.c,526 :: 		Reset_PSW(NULL,CMD_ENTER);                          //for reset password
	CLRF        FARG_Reset_PSW_direct+0 
	MOVLW       1
	MOVWF       FARG_Reset_PSW_cmd+0 
	CALL        _Reset_PSW+0, 0
	GOTO        L_SPCMenuOperation113
L_SPCMenuOperation112:
;Menuoperation.c,527 :: 		else if(ChannelSelStat != CH_SEL_RESET)
	MOVF        _ChannelSelStat+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCMenuOperation114
;Menuoperation.c,528 :: 		ChannelConfig(CMD_FORWARD,CMD_ENTER);
	MOVLW       1
	MOVWF       FARG_ChannelConfig_direct+0 
	MOVLW       1
	MOVWF       FARG_ChannelConfig_cmd+0 
	CALL        _ChannelConfig+0, 0
	GOTO        L_SPCMenuOperation115
L_SPCMenuOperation114:
;Menuoperation.c,531 :: 		set_menu_info(NULL,CMD_ENTER);                      //for normal navigation
	CLRF        FARG_set_menu_info_direction+0 
	MOVLW       1
	MOVWF       FARG_set_menu_info_command+0 
	CALL        _set_menu_info+0, 0
;Menuoperation.c,532 :: 		}
L_SPCMenuOperation115:
L_SPCMenuOperation113:
;Menuoperation.c,533 :: 		Flashing_DIS();
	CALL        _Flashing_DIS+0, 0
;Menuoperation.c,534 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
;Menuoperation.c,535 :: 		break;
	GOTO        L_SPCMenuOperation54
;Menuoperation.c,536 :: 		case KEY_CLEAR:
L_SPCMenuOperation116:
;Menuoperation.c,537 :: 		if(spc_system_flag.bite.default_diaped == 1)
	BTFSS       _spc_system_flag+1, 2 
	GOTO        L_SPCMenuOperation117
;Menuoperation.c,538 :: 		return;
	GOTO        L_end_SPCMenuOperation
L_SPCMenuOperation117:
;Menuoperation.c,540 :: 		KeyValueshape = 0;
	CLRF        _KeyValueshape+0 
	CLRF        _KeyValueshape+1 
	CLRF        _KeyValueshape+2 
	CLRF        _KeyValueshape+3 
;Menuoperation.c,541 :: 		break;
	GOTO        L_SPCMenuOperation54
;Menuoperation.c,542 :: 		}
L_SPCMenuOperation53:
	MOVLW       0
	MOVWF       R0 
	XORWF       SPCMenuOperation_KeyValue_L0+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPCMenuOperation318
	MOVF        R0, 0 
	XORWF       SPCMenuOperation_KeyValue_L0+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPCMenuOperation318
	MOVF        R0, 0 
	XORWF       SPCMenuOperation_KeyValue_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPCMenuOperation318
	MOVF        SPCMenuOperation_KeyValue_L0+0, 0 
	XORLW       16
L__SPCMenuOperation318:
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCMenuOperation55
	MOVLW       0
	MOVWF       R0 
	XORWF       SPCMenuOperation_KeyValue_L0+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPCMenuOperation319
	MOVF        R0, 0 
	XORWF       SPCMenuOperation_KeyValue_L0+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPCMenuOperation319
	MOVF        R0, 0 
	XORWF       SPCMenuOperation_KeyValue_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPCMenuOperation319
	MOVF        SPCMenuOperation_KeyValue_L0+0, 0 
	XORLW       4
L__SPCMenuOperation319:
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCMenuOperation64
	MOVLW       0
	MOVWF       R0 
	XORWF       SPCMenuOperation_KeyValue_L0+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPCMenuOperation320
	MOVF        R0, 0 
	XORWF       SPCMenuOperation_KeyValue_L0+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPCMenuOperation320
	MOVF        R0, 0 
	XORWF       SPCMenuOperation_KeyValue_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPCMenuOperation320
	MOVF        SPCMenuOperation_KeyValue_L0+0, 0 
	XORLW       64
L__SPCMenuOperation320:
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCMenuOperation73
	MOVLW       0
	MOVWF       R0 
	XORWF       SPCMenuOperation_KeyValue_L0+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPCMenuOperation321
	MOVF        R0, 0 
	XORWF       SPCMenuOperation_KeyValue_L0+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPCMenuOperation321
	MOVLW       1
	XORWF       SPCMenuOperation_KeyValue_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPCMenuOperation321
	MOVF        SPCMenuOperation_KeyValue_L0+0, 0 
	XORLW       0
L__SPCMenuOperation321:
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCMenuOperation86
	MOVLW       0
	MOVWF       R0 
	XORWF       SPCMenuOperation_KeyValue_L0+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPCMenuOperation322
	MOVF        R0, 0 
	XORWF       SPCMenuOperation_KeyValue_L0+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPCMenuOperation322
	MOVF        R0, 0 
	XORWF       SPCMenuOperation_KeyValue_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPCMenuOperation322
	MOVF        SPCMenuOperation_KeyValue_L0+0, 0 
	XORLW       128
L__SPCMenuOperation322:
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCMenuOperation93
	MOVLW       0
	MOVWF       R0 
	XORWF       SPCMenuOperation_KeyValue_L0+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPCMenuOperation323
	MOVF        R0, 0 
	XORWF       SPCMenuOperation_KeyValue_L0+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPCMenuOperation323
	MOVF        R0, 0 
	XORWF       SPCMenuOperation_KeyValue_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPCMenuOperation323
	MOVF        SPCMenuOperation_KeyValue_L0+0, 0 
	XORLW       32
L__SPCMenuOperation323:
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCMenuOperation96
	MOVLW       0
	MOVWF       R0 
	XORWF       SPCMenuOperation_KeyValue_L0+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPCMenuOperation324
	MOVF        R0, 0 
	XORWF       SPCMenuOperation_KeyValue_L0+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPCMenuOperation324
	MOVF        R0, 0 
	XORWF       SPCMenuOperation_KeyValue_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPCMenuOperation324
	MOVF        SPCMenuOperation_KeyValue_L0+0, 0 
	XORLW       2
L__SPCMenuOperation324:
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCMenuOperation99
	MOVLW       0
	MOVWF       R0 
	XORWF       SPCMenuOperation_KeyValue_L0+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPCMenuOperation325
	MOVF        R0, 0 
	XORWF       SPCMenuOperation_KeyValue_L0+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPCMenuOperation325
	MOVF        R0, 0 
	XORWF       SPCMenuOperation_KeyValue_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPCMenuOperation325
	MOVF        SPCMenuOperation_KeyValue_L0+0, 0 
	XORLW       1
L__SPCMenuOperation325:
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCMenuOperation100
	MOVLW       0
	MOVWF       R0 
	XORWF       SPCMenuOperation_KeyValue_L0+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPCMenuOperation326
	MOVF        R0, 0 
	XORWF       SPCMenuOperation_KeyValue_L0+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPCMenuOperation326
	MOVF        R0, 0 
	XORWF       SPCMenuOperation_KeyValue_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPCMenuOperation326
	MOVF        SPCMenuOperation_KeyValue_L0+0, 0 
	XORLW       8
L__SPCMenuOperation326:
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCMenuOperation108
	MOVLW       0
	MOVWF       R0 
	XORWF       SPCMenuOperation_KeyValue_L0+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPCMenuOperation327
	MOVF        R0, 0 
	XORWF       SPCMenuOperation_KeyValue_L0+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPCMenuOperation327
	MOVF        R0, 0 
	XORWF       SPCMenuOperation_KeyValue_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPCMenuOperation327
	MOVF        SPCMenuOperation_KeyValue_L0+0, 0 
	XORLW       0
L__SPCMenuOperation327:
	BTFSC       STATUS+0, 2 
	GOTO        L_SPCMenuOperation116
L_SPCMenuOperation54:
;Menuoperation.c,544 :: 		}
L_SPCMenuOperation52:
;Menuoperation.c,546 :: 		asm nop;
	NOP
;Menuoperation.c,547 :: 		}
L_end_SPCMenuOperation:
	RETURN      0
; end of _SPCMenuOperation

_MenuRoll:

;Menuoperation.c,554 :: 		void MenuRoll(UCHAR Forward,UCHAR Para,UCHAR Level)
;Menuoperation.c,556 :: 		UCHAR mainloop = 1;
	MOVLW       1
	MOVWF       MenuRoll_mainloop_L0+0 
;Menuoperation.c,560 :: 		spc_system_flag.bite.char_flash = 0;
	BCF         _spc_system_flag+3, 6 
;Menuoperation.c,562 :: 		Index_temp = SpcMenu[Menustat].index;
	MOVLW       19
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        _Menustat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       Menuoperation_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Menuoperation_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Menuoperation_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVF        R0, 0 
	MOVWF       TBLPTRL 
	MOVF        R1, 0 
	MOVWF       TBLPTRH 
	MOVF        R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, MenuRoll_Index_temp_L0+0
;Menuoperation.c,563 :: 		SubIndex_temp = SpcMenu[Menustat].subindex;
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, MenuRoll_SubIndex_temp_L0+0
;Menuoperation.c,564 :: 		ThirdIndex_temp = SpcMenu[Menustat].thirdindex;
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, MenuRoll_ThirdIndex_temp_L0+0
;Menuoperation.c,566 :: 		if(spc_system_flag.bite.default_diaped)
	BTFSS       _spc_system_flag+1, 2 
	GOTO        L_MenuRoll118
;Menuoperation.c,568 :: 		spc_system_flag.bite.default_diaped = 0;
	BCF         _spc_system_flag+1, 2 
;Menuoperation.c,569 :: 		if(Para == MENU_IN_ACTUAL)
	MOVF        FARG_MenuRoll_Para+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_MenuRoll119
;Menuoperation.c,571 :: 		Menustat = 0;
	CLRF        _Menustat+0 
;Menuoperation.c,572 :: 		mainloop = 0;
	CLRF        MenuRoll_mainloop_L0+0 
;Menuoperation.c,573 :: 		}
L_MenuRoll119:
;Menuoperation.c,574 :: 		}
	GOTO        L_MenuRoll120
L_MenuRoll118:
;Menuoperation.c,575 :: 		else if(spc_system_flag.bite.alarm_actived)
	BTFSS       _spc_system_flag+1, 0 
	GOTO        L_MenuRoll121
;Menuoperation.c,576 :: 		spc_system_flag.bite.alarm_actived = 0;
	BCF         _spc_system_flag+1, 0 
	GOTO        L_MenuRoll122
L_MenuRoll121:
;Menuoperation.c,577 :: 		else if((Level == INDEX) && (Para == SpcMenu[Menustat].index))
	MOVF        FARG_MenuRoll_Level+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_MenuRoll125
	MOVLW       19
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        _Menustat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       Menuoperation_SpcMenu+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(Menuoperation_SpcMenu+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(Menuoperation_SpcMenu+0)
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R1
	MOVF        FARG_MenuRoll_Para+0, 0 
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_MenuRoll125
L__MenuRoll300:
;Menuoperation.c,578 :: 		Level = SUBINDEX;
	MOVLW       5
	MOVWF       FARG_MenuRoll_Level+0 
L_MenuRoll125:
L_MenuRoll122:
L_MenuRoll120:
;Menuoperation.c,580 :: 		while(mainloop)
L_MenuRoll126:
	MOVF        MenuRoll_mainloop_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_MenuRoll127
;Menuoperation.c,582 :: 		if(Forward)
	MOVF        FARG_MenuRoll_Forward+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_MenuRoll128
;Menuoperation.c,584 :: 		Menustat++;
	INCF        _Menustat+0, 1 
;Menuoperation.c,585 :: 		Menustat = (Menustat%MAX_MENU_NUM);
	MOVLW       61
	MOVWF       R4 
	MOVF        _Menustat+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _Menustat+0 
;Menuoperation.c,586 :: 		}
	GOTO        L_MenuRoll129
L_MenuRoll128:
;Menuoperation.c,589 :: 		if(Menustat == 0)
	MOVF        _Menustat+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_MenuRoll130
;Menuoperation.c,590 :: 		Menustat = MAX_MENU_NUM-1;
	MOVLW       60
	MOVWF       _Menustat+0 
	GOTO        L_MenuRoll131
L_MenuRoll130:
;Menuoperation.c,592 :: 		Menustat--;
	DECF        _Menustat+0, 1 
L_MenuRoll131:
;Menuoperation.c,593 :: 		}
L_MenuRoll129:
;Menuoperation.c,595 :: 		Index_real = SpcMenu[Menustat].index;
	MOVLW       19
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        _Menustat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       Menuoperation_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Menuoperation_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Menuoperation_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVF        R0, 0 
	MOVWF       TBLPTRL 
	MOVF        R1, 0 
	MOVWF       TBLPTRH 
	MOVF        R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, MenuRoll_Index_real_L0+0
;Menuoperation.c,596 :: 		SubIndex_real = SpcMenu[Menustat].subindex;
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, MenuRoll_SubIndex_real_L0+0
;Menuoperation.c,597 :: 		ThirdIndex_real = SpcMenu[Menustat].thirdindex;
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, MenuRoll_ThirdIndex_real_L0+0
;Menuoperation.c,599 :: 		if(Level == INDEX)
	MOVF        FARG_MenuRoll_Level+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_MenuRoll132
;Menuoperation.c,601 :: 		if((Para == Index_real) && (SubIndex_real == 0) && (ThirdIndex_real == 0))
	MOVF        FARG_MenuRoll_Para+0, 0 
	XORWF       MenuRoll_Index_real_L0+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_MenuRoll135
	MOVF        MenuRoll_SubIndex_real_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_MenuRoll135
	MOVF        MenuRoll_ThirdIndex_real_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_MenuRoll135
L__MenuRoll299:
;Menuoperation.c,602 :: 		mainloop = 0;
	CLRF        MenuRoll_mainloop_L0+0 
	GOTO        L_MenuRoll136
L_MenuRoll135:
;Menuoperation.c,604 :: 		mainloop = 1;
	MOVLW       1
	MOVWF       MenuRoll_mainloop_L0+0 
L_MenuRoll136:
;Menuoperation.c,605 :: 		}
	GOTO        L_MenuRoll137
L_MenuRoll132:
;Menuoperation.c,606 :: 		else if(Level == SUBINDEX)
	MOVF        FARG_MenuRoll_Level+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_MenuRoll138
;Menuoperation.c,608 :: 		if(Index_temp == Index_real)
	MOVF        MenuRoll_Index_temp_L0+0, 0 
	XORWF       MenuRoll_Index_real_L0+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_MenuRoll139
;Menuoperation.c,610 :: 		if(ThirdIndex_real == 0)
	MOVF        MenuRoll_ThirdIndex_real_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_MenuRoll140
;Menuoperation.c,611 :: 		mainloop = 0;
	CLRF        MenuRoll_mainloop_L0+0 
	GOTO        L_MenuRoll141
L_MenuRoll140:
;Menuoperation.c,613 :: 		mainloop = 1;
	MOVLW       1
	MOVWF       MenuRoll_mainloop_L0+0 
L_MenuRoll141:
;Menuoperation.c,614 :: 		}
	GOTO        L_MenuRoll142
L_MenuRoll139:
;Menuoperation.c,616 :: 		mainloop = 1;
	MOVLW       1
	MOVWF       MenuRoll_mainloop_L0+0 
L_MenuRoll142:
;Menuoperation.c,617 :: 		}
	GOTO        L_MenuRoll143
L_MenuRoll138:
;Menuoperation.c,618 :: 		else if(Level == THIRDINDEX)
	MOVF        FARG_MenuRoll_Level+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_MenuRoll144
;Menuoperation.c,620 :: 		if(Index_temp == Index_real)
	MOVF        MenuRoll_Index_temp_L0+0, 0 
	XORWF       MenuRoll_Index_real_L0+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_MenuRoll145
;Menuoperation.c,622 :: 		if(ThirdIndex_temp == ThirdIndex_real)
	MOVF        MenuRoll_ThirdIndex_temp_L0+0, 0 
	XORWF       MenuRoll_ThirdIndex_real_L0+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_MenuRoll146
;Menuoperation.c,623 :: 		mainloop = 1;
	MOVLW       1
	MOVWF       MenuRoll_mainloop_L0+0 
L_MenuRoll146:
;Menuoperation.c,624 :: 		if((ThirdIndex_real == 0) && (Forward == 0))
	MOVF        MenuRoll_ThirdIndex_real_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_MenuRoll149
	MOVF        FARG_MenuRoll_Forward+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_MenuRoll149
L__MenuRoll298:
;Menuoperation.c,625 :: 		mainloop = 1;
	MOVLW       1
	MOVWF       MenuRoll_mainloop_L0+0 
	GOTO        L_MenuRoll150
L_MenuRoll149:
;Menuoperation.c,627 :: 		mainloop = 0;
	CLRF        MenuRoll_mainloop_L0+0 
L_MenuRoll150:
;Menuoperation.c,628 :: 		}
	GOTO        L_MenuRoll151
L_MenuRoll145:
;Menuoperation.c,630 :: 		mainloop = 1;
	MOVLW       1
	MOVWF       MenuRoll_mainloop_L0+0 
L_MenuRoll151:
;Menuoperation.c,631 :: 		}
L_MenuRoll144:
L_MenuRoll143:
L_MenuRoll137:
;Menuoperation.c,633 :: 		if(SpcMenu[Menustat].flag.bite.menu_active)
	MOVLW       19
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        _Menustat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       Menuoperation_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Menuoperation_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Menuoperation_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       3
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
	BTFSS       R0, 0 
	GOTO        L_MenuRoll152
;Menuoperation.c,634 :: 		mainloop |= 0;
	GOTO        L_MenuRoll153
L_MenuRoll152:
;Menuoperation.c,636 :: 		mainloop = 1;
	MOVLW       1
	MOVWF       MenuRoll_mainloop_L0+0 
L_MenuRoll153:
;Menuoperation.c,638 :: 		if(MainTainTempDisable(Cable_Channel) == 1)          //None
	MOVF        _Cable_Channel+0, 0 
	MOVWF       FARG_MainTainTempDisable_ChannelNum+0 
	CALL        _MainTainTempDisable+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_MenuRoll154
;Menuoperation.c,640 :: 		if(SpcMenu[Menustat].flag.bite.maintainnone_conflict)
	MOVLW       19
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        _Menustat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       Menuoperation_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Menuoperation_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Menuoperation_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       3
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
	BTFSS       R0, 2 
	GOTO        L_MenuRoll155
;Menuoperation.c,641 :: 		mainloop = 1;
	MOVLW       1
	MOVWF       MenuRoll_mainloop_L0+0 
	GOTO        L_MenuRoll156
L_MenuRoll155:
;Menuoperation.c,643 :: 		mainloop |= 0;
L_MenuRoll156:
;Menuoperation.c,644 :: 		}
L_MenuRoll154:
;Menuoperation.c,646 :: 		if(MainTainTempDisable(Cable_Channel) == 2)          //Off
	MOVF        _Cable_Channel+0, 0 
	MOVWF       FARG_MainTainTempDisable_ChannelNum+0 
	CALL        _MainTainTempDisable+0, 0
	MOVF        R0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_MenuRoll157
;Menuoperation.c,648 :: 		if(SpcMenu[Menustat].flag.bite.maintainoff_conflict)
	MOVLW       19
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        _Menustat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       Menuoperation_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Menuoperation_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Menuoperation_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       3
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
	BTFSS       R0, 3 
	GOTO        L_MenuRoll158
;Menuoperation.c,649 :: 		mainloop = 1;
	MOVLW       1
	MOVWF       MenuRoll_mainloop_L0+0 
	GOTO        L_MenuRoll159
L_MenuRoll158:
;Menuoperation.c,651 :: 		mainloop |= 0;
L_MenuRoll159:
;Menuoperation.c,652 :: 		}
L_MenuRoll157:
;Menuoperation.c,654 :: 		if(ProCtlEnable(Cable_Channel))
	MOVF        _Cable_Channel+0, 0 
	MOVWF       FARG_ProCtlEnable_ChannelNum+0 
	CALL        _ProCtlEnable+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_MenuRoll160
;Menuoperation.c,656 :: 		if(SpcMenu[Menustat].flag.bite.proportional_conflict)
	MOVLW       19
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        _Menustat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       Menuoperation_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Menuoperation_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Menuoperation_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       3
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
	BTFSS       R0, 4 
	GOTO        L_MenuRoll161
;Menuoperation.c,657 :: 		mainloop = 1;
	MOVLW       1
	MOVWF       MenuRoll_mainloop_L0+0 
	GOTO        L_MenuRoll162
L_MenuRoll161:
;Menuoperation.c,659 :: 		mainloop |= 0;
L_MenuRoll162:
;Menuoperation.c,660 :: 		}
L_MenuRoll160:
;Menuoperation.c,662 :: 		if(pSPCValue[0].SPCSetPoints.system_valueb.bite.usr_advanced == 0)
	BTFSC       _pSPCValue+139, 1 
	GOTO        L_MenuRoll163
;Menuoperation.c,664 :: 		if(SpcMenu[Menustat].flag.bite.advanced_req)
	MOVLW       19
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        _Menustat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       Menuoperation_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Menuoperation_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Menuoperation_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       3
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
	BTFSS       R0, 1 
	GOTO        L_MenuRoll164
;Menuoperation.c,665 :: 		mainloop = 1;
	MOVLW       1
	MOVWF       MenuRoll_mainloop_L0+0 
	GOTO        L_MenuRoll165
L_MenuRoll164:
;Menuoperation.c,667 :: 		mainloop |= 0;
L_MenuRoll165:
;Menuoperation.c,668 :: 		}
L_MenuRoll163:
;Menuoperation.c,670 :: 		if(SelfRegulaEnable(Cable_Channel))
	MOVF        _Cable_Channel+0, 0 
	MOVWF       FARG_SelfRegulaEnable_ChannelNum+0 
	CALL        _SelfRegulaEnable+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_MenuRoll166
;Menuoperation.c,672 :: 		if(SpcMenu[Menustat].flag.bite.SelfRegula_conflict)
	MOVLW       19
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        _Menustat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       Menuoperation_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Menuoperation_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Menuoperation_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       3
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
	BTFSS       R0, 5 
	GOTO        L_MenuRoll167
;Menuoperation.c,673 :: 		mainloop = 1;
	MOVLW       1
	MOVWF       MenuRoll_mainloop_L0+0 
	GOTO        L_MenuRoll168
L_MenuRoll167:
;Menuoperation.c,675 :: 		mainloop |= 0;
L_MenuRoll168:
;Menuoperation.c,676 :: 		}
	GOTO        L_MenuRoll169
L_MenuRoll166:
;Menuoperation.c,679 :: 		if(SpcMenu[Menustat].flag.bite.FoxResis_conflict)
	MOVLW       19
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        _Menustat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       Menuoperation_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Menuoperation_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Menuoperation_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       3
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
	BTFSS       R0, 6 
	GOTO        L_MenuRoll170
;Menuoperation.c,680 :: 		mainloop = 1;
	MOVLW       1
	MOVWF       MenuRoll_mainloop_L0+0 
	GOTO        L_MenuRoll171
L_MenuRoll170:
;Menuoperation.c,682 :: 		mainloop |= 0;
L_MenuRoll171:
;Menuoperation.c,683 :: 		}
L_MenuRoll169:
;Menuoperation.c,684 :: 		}
	GOTO        L_MenuRoll126
L_MenuRoll127:
;Menuoperation.c,686 :: 		set_menu_info(Forward,CMD_RESET);
	MOVF        FARG_MenuRoll_Forward+0, 0 
	MOVWF       FARG_set_menu_info_direction+0 
	MOVLW       2
	MOVWF       FARG_set_menu_info_command+0 
	CALL        _set_menu_info+0, 0
;Menuoperation.c,687 :: 		}
L_end_MenuRoll:
	RETURN      0
; end of _MenuRoll

_set_menu_info:

;Menuoperation.c,694 :: 		void set_menu_info(UCHAR direction,UCHAR command)
;Menuoperation.c,698 :: 		for(i=0; i<16; i++)
	CLRF        set_menu_info_i_L0+0 
L_set_menu_info172:
	MOVLW       16
	SUBWF       set_menu_info_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_set_menu_info173
;Menuoperation.c,699 :: 		Info_Line1[i] = SpcTxtLine1[Menustat][i];
	MOVLW       _Info_Line1+0
	MOVWF       FLOC__set_menu_info+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FLOC__set_menu_info+1 
	MOVF        set_menu_info_i_L0+0, 0 
	ADDWF       FLOC__set_menu_info+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__set_menu_info+1, 1 
	MOVLW       17
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        _Menustat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       Menuoperation_SpcTxtLine1+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Menuoperation_SpcTxtLine1+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Menuoperation_SpcTxtLine1+0)
	ADDWFC      R2, 1 
	MOVF        set_menu_info_i_L0+0, 0 
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
	MOVFF       FLOC__set_menu_info+0, FSR1
	MOVFF       FLOC__set_menu_info+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Menuoperation.c,698 :: 		for(i=0; i<16; i++)
	INCF        set_menu_info_i_L0+0, 1 
;Menuoperation.c,699 :: 		Info_Line1[i] = SpcTxtLine1[Menustat][i];
	GOTO        L_set_menu_info172
L_set_menu_info173:
;Menuoperation.c,701 :: 		temp = SpcMenu[Menustat].func_mark;
	MOVLW       19
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        _Menustat+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       Menuoperation_SpcMenu+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(Menuoperation_SpcMenu+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(Menuoperation_SpcMenu+0)
	ADDWFC      R2, 1 
	MOVLW       4
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, set_menu_info_temp_L0+0
;Menuoperation.c,703 :: 		switch(temp)
	GOTO        L_set_menu_info175
;Menuoperation.c,705 :: 		case FUNC_TITLE:
L_set_menu_info177:
;Menuoperation.c,706 :: 		TitleSet(direction,command);
	MOVF        FARG_set_menu_info_direction+0, 0 
	MOVWF       FARG_TitleSet_direct+0 
	MOVF        FARG_set_menu_info_command+0, 0 
	MOVWF       FARG_TitleSet_cmd+0 
	CALL        _TitleSet+0, 0
;Menuoperation.c,707 :: 		break;
	GOTO        L_set_menu_info176
;Menuoperation.c,708 :: 		case FUNC_CHANNEL:
L_set_menu_info178:
;Menuoperation.c,709 :: 		ChannelConfig(direction,command);
	MOVF        FARG_set_menu_info_direction+0, 0 
	MOVWF       FARG_ChannelConfig_direct+0 
	MOVF        FARG_set_menu_info_command+0, 0 
	MOVWF       FARG_ChannelConfig_cmd+0 
	CALL        _ChannelConfig+0, 0
;Menuoperation.c,710 :: 		break;
	GOTO        L_set_menu_info176
;Menuoperation.c,711 :: 		case FUNC_MAINT:
L_set_menu_info179:
;Menuoperation.c,712 :: 		MaintainTempSet(direction,command);
	MOVF        FARG_set_menu_info_direction+0, 0 
	MOVWF       FARG_MaintainTempSet_direct+0 
	MOVF        FARG_set_menu_info_command+0, 0 
	MOVWF       FARG_MaintainTempSet_cmd+0 
	CALL        _MaintainTempSet+0, 0
;Menuoperation.c,713 :: 		break;
	GOTO        L_set_menu_info176
;Menuoperation.c,714 :: 		case FUNC_LOWTEMP:
L_set_menu_info180:
;Menuoperation.c,715 :: 		LowTempAlarmSet(direction,command);
	MOVF        FARG_set_menu_info_direction+0, 0 
	MOVWF       FARG_LowTempAlarmSet_direct+0 
	MOVF        FARG_set_menu_info_command+0, 0 
	MOVWF       FARG_LowTempAlarmSet_cmd+0 
	CALL        _LowTempAlarmSet+0, 0
;Menuoperation.c,716 :: 		break;
	GOTO        L_set_menu_info176
;Menuoperation.c,717 :: 		case FUNC_HIGHTEMP:
L_set_menu_info181:
;Menuoperation.c,718 :: 		HighTempAlarmSet(direction,command);
	MOVF        FARG_set_menu_info_direction+0, 0 
	MOVWF       FARG_HighTempAlarmSet_direct+0 
	MOVF        FARG_set_menu_info_command+0, 0 
	MOVWF       FARG_HighTempAlarmSet_cmd+0 
	CALL        _HighTempAlarmSet+0, 0
;Menuoperation.c,719 :: 		break;
	GOTO        L_set_menu_info176
;Menuoperation.c,720 :: 		case FUNC_DEADBAND:
L_set_menu_info182:
;Menuoperation.c,721 :: 		DeadbandSet(direction,command);
	MOVF        FARG_set_menu_info_direction+0, 0 
	MOVWF       FARG_DeadbandSet_direct+0 
	MOVF        FARG_set_menu_info_command+0, 0 
	MOVWF       FARG_DeadbandSet_cmd+0 
	CALL        _DeadbandSet+0, 0
;Menuoperation.c,722 :: 		break;
	GOTO        L_set_menu_info176
;Menuoperation.c,723 :: 		case FUNC_HEATID:
L_set_menu_info183:
;Menuoperation.c,724 :: 		HeaterIDSet(direction,command);
	MOVF        FARG_set_menu_info_direction+0, 0 
	MOVWF       FARG_HeaterIDSet_direct+0 
	MOVF        FARG_set_menu_info_command+0, 0 
	MOVWF       FARG_HeaterIDSet_cmd+0 
	CALL        _HeaterIDSet+0, 0
;Menuoperation.c,725 :: 		break;
	GOTO        L_set_menu_info176
;Menuoperation.c,726 :: 		case FUNC_CHANGEPWD:
L_set_menu_info184:
;Menuoperation.c,727 :: 		PasswordEidtorSet(direction,command);
	MOVF        FARG_set_menu_info_direction+0, 0 
	MOVWF       FARG_PasswordEidtorSet_direct+0 
	MOVF        FARG_set_menu_info_command+0, 0 
	MOVWF       FARG_PasswordEidtorSet_cmd+0 
	CALL        _PasswordEidtorSet+0, 0
;Menuoperation.c,728 :: 		break;
	GOTO        L_set_menu_info176
;Menuoperation.c,729 :: 		case FUNC_RESET_MODULE:
L_set_menu_info185:
;Menuoperation.c,730 :: 		case FUNC_RESET:
L_set_menu_info186:
;Menuoperation.c,731 :: 		ResetSPCSet(direction,command);
	MOVF        FARG_set_menu_info_direction+0, 0 
	MOVWF       FARG_ResetSPCSet_direct+0 
	MOVF        FARG_set_menu_info_command+0, 0 
	MOVWF       FARG_ResetSPCSet_cmd+0 
	CALL        _ResetSPCSet+0, 0
;Menuoperation.c,732 :: 		break;
	GOTO        L_set_menu_info176
;Menuoperation.c,733 :: 		case FUNC_FLAGSET:            //Para_Flag_Set_Show
L_set_menu_info187:
;Menuoperation.c,734 :: 		Para_Flag_Set(direction,command);
	MOVF        FARG_set_menu_info_direction+0, 0 
	MOVWF       FARG_Para_Flag_Set_direct+0 
	MOVF        FARG_set_menu_info_command+0, 0 
	MOVWF       FARG_Para_Flag_Set_cmd+0 
	CALL        _Para_Flag_Set+0, 0
;Menuoperation.c,735 :: 		break;
	GOTO        L_set_menu_info176
;Menuoperation.c,736 :: 		case FUNC_INTSET:             //Para_int_Set
L_set_menu_info188:
;Menuoperation.c,737 :: 		Para_int_Set(direction,command);
	MOVF        FARG_set_menu_info_direction+0, 0 
	MOVWF       FARG_Para_int_Set_direct+0 
	MOVF        FARG_set_menu_info_command+0, 0 
	MOVWF       FARG_Para_int_Set_cmd+0 
	CALL        _Para_int_Set+0, 0
;Menuoperation.c,738 :: 		break;
	GOTO        L_set_menu_info176
;Menuoperation.c,739 :: 		case FUNC_SHOW:
L_set_menu_info189:
;Menuoperation.c,740 :: 		Para_show(direction,command);
	MOVF        FARG_set_menu_info_direction+0, 0 
	MOVWF       FARG_Para_show_direct+0 
	MOVF        FARG_set_menu_info_command+0, 0 
	MOVWF       FARG_Para_show_cmd+0 
	CALL        _Para_show+0, 0
;Menuoperation.c,741 :: 		break;
	GOTO        L_set_menu_info176
;Menuoperation.c,742 :: 		case FUNC_AUTHO:             //change users
L_set_menu_info190:
;Menuoperation.c,743 :: 		Authority_Set(direction,command);
	MOVF        FARG_set_menu_info_direction+0, 0 
	MOVWF       FARG_Authority_Set_direct+0 
	MOVF        FARG_set_menu_info_command+0, 0 
	MOVWF       FARG_Authority_Set_cmd+0 
	CALL        _Authority_Set+0, 0
;Menuoperation.c,744 :: 		break;
	GOTO        L_set_menu_info176
;Menuoperation.c,745 :: 		case FUNC_VERSION:
L_set_menu_info191:
;Menuoperation.c,746 :: 		Version_show(direction,command);
	MOVF        FARG_set_menu_info_direction+0, 0 
	MOVWF       FARG_Version_show_direct+0 
	MOVF        FARG_set_menu_info_command+0, 0 
	MOVWF       FARG_Version_show_cmd+0 
	CALL        _Version_show+0, 0
;Menuoperation.c,747 :: 		break;
	GOTO        L_set_menu_info176
;Menuoperation.c,748 :: 		}
L_set_menu_info175:
	MOVF        set_menu_info_temp_L0+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_set_menu_info177
	MOVF        set_menu_info_temp_L0+0, 0 
	XORLW       24
	BTFSC       STATUS+0, 2 
	GOTO        L_set_menu_info178
	MOVF        set_menu_info_temp_L0+0, 0 
	XORLW       25
	BTFSC       STATUS+0, 2 
	GOTO        L_set_menu_info179
	MOVF        set_menu_info_temp_L0+0, 0 
	XORLW       26
	BTFSC       STATUS+0, 2 
	GOTO        L_set_menu_info180
	MOVF        set_menu_info_temp_L0+0, 0 
	XORLW       27
	BTFSC       STATUS+0, 2 
	GOTO        L_set_menu_info181
	MOVF        set_menu_info_temp_L0+0, 0 
	XORLW       38
	BTFSC       STATUS+0, 2 
	GOTO        L_set_menu_info182
	MOVF        set_menu_info_temp_L0+0, 0 
	XORLW       36
	BTFSC       STATUS+0, 2 
	GOTO        L_set_menu_info183
	MOVF        set_menu_info_temp_L0+0, 0 
	XORLW       47
	BTFSC       STATUS+0, 2 
	GOTO        L_set_menu_info184
	MOVF        set_menu_info_temp_L0+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_set_menu_info185
	MOVF        set_menu_info_temp_L0+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_set_menu_info186
	MOVF        set_menu_info_temp_L0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_set_menu_info187
	MOVF        set_menu_info_temp_L0+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_set_menu_info188
	MOVF        set_menu_info_temp_L0+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_set_menu_info189
	MOVF        set_menu_info_temp_L0+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_set_menu_info190
	MOVF        set_menu_info_temp_L0+0, 0 
	XORLW       22
	BTFSC       STATUS+0, 2 
	GOTO        L_set_menu_info191
L_set_menu_info176:
;Menuoperation.c,750 :: 		asm nop;
	NOP
;Menuoperation.c,751 :: 		}
L_end_set_menu_info:
	RETURN      0
; end of _set_menu_info

_AlarmRoll_Index:

;Menuoperation.c,758 :: 		void AlarmRoll_Index(char trige)
;Menuoperation.c,763 :: 		if(spc_system_flag.bite.alarm_actived)
	BTFSS       _spc_system_flag+1, 0 
	GOTO        L_AlarmRoll_Index192
;Menuoperation.c,766 :: 		if(trige)
	MOVF        FARG_AlarmRoll_Index_trige+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_AlarmRoll_Index193
;Menuoperation.c,767 :: 		spc_system_flag.bite.alarm_displayed ^= TRUE;
	BTG         _spc_system_flag+0, 7 
L_AlarmRoll_Index193:
;Menuoperation.c,769 :: 		index = spc_system_flag.bite.alarm_displayed;
	MOVLW       0
	BTFSC       _spc_system_flag+0, 7 
	MOVLW       1
	MOVWF       AlarmRoll_Index_index_L0+0 
;Menuoperation.c,770 :: 		if(index)
	MOVF        AlarmRoll_Index_index_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_AlarmRoll_Index194
;Menuoperation.c,772 :: 		ALARM_NUM = pSPCAlarm.spclogs.num_logs;
	MOVF        _pSPCAlarm+81, 0 
	MOVWF       AlarmRoll_Index_ALARM_NUM_L0+0 
;Menuoperation.c,773 :: 		ALARM_UNIT = UNIT_LOG;
	MOVLW       13
	MOVWF       AlarmRoll_Index_ALARM_UNIT_L0+0 
;Menuoperation.c,775 :: 		if(ALARM_NUM >= MAX_LOGS)
	MOVLW       20
	SUBWF       _pSPCAlarm+81, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_AlarmRoll_Index195
;Menuoperation.c,777 :: 		for(i=0;i<16;i++)
	CLRF        AlarmRoll_Index_i_L0+0 
L_AlarmRoll_Index196:
	MOVLW       16
	SUBWF       AlarmRoll_Index_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_AlarmRoll_Index197
;Menuoperation.c,778 :: 		Info_Line1[i] = AlarmFullStr[i];
	MOVLW       _Info_Line1+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FSR1H 
	MOVF        AlarmRoll_Index_i_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       _AlarmFullStr+0
	ADDWF       AlarmRoll_Index_i_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_AlarmFullStr+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_AlarmFullStr+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Menuoperation.c,777 :: 		for(i=0;i<16;i++)
	INCF        AlarmRoll_Index_i_L0+0, 1 
;Menuoperation.c,778 :: 		Info_Line1[i] = AlarmFullStr[i];
	GOTO        L_AlarmRoll_Index196
L_AlarmRoll_Index197:
;Menuoperation.c,779 :: 		ClearStr(Info_Line2, 16);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_ClearStr_target+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_ClearStr_target+1 
	MOVLW       16
	MOVWF       FARG_ClearStr_len+0 
	MOVLW       0
	MOVWF       FARG_ClearStr_len+1 
	CALL        _ClearStr+0, 0
;Menuoperation.c,781 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
;Menuoperation.c,782 :: 		Delay_ms(1000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_AlarmRoll_Index199:
	DECFSZ      R13, 1, 1
	BRA         L_AlarmRoll_Index199
	DECFSZ      R12, 1, 1
	BRA         L_AlarmRoll_Index199
	DECFSZ      R11, 1, 1
	BRA         L_AlarmRoll_Index199
	NOP
;Menuoperation.c,783 :: 		}
L_AlarmRoll_Index195:
;Menuoperation.c,784 :: 		}
	GOTO        L_AlarmRoll_Index200
L_AlarmRoll_Index194:
;Menuoperation.c,787 :: 		ALARM_NUM = pSPCAlarm.spcalarms.num_alarms;
	MOVF        _pSPCAlarm+0, 0 
	MOVWF       AlarmRoll_Index_ALARM_NUM_L0+0 
;Menuoperation.c,788 :: 		ALARM_UNIT = UNIT_ALARM;
	MOVLW       12
	MOVWF       AlarmRoll_Index_ALARM_UNIT_L0+0 
;Menuoperation.c,790 :: 		if(ALARM_NUM >= MAX_LOGS)
	MOVLW       20
	SUBWF       _pSPCAlarm+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_AlarmRoll_Index201
;Menuoperation.c,792 :: 		for(i=0;i<16;i++)
	CLRF        AlarmRoll_Index_i_L0+0 
L_AlarmRoll_Index202:
	MOVLW       16
	SUBWF       AlarmRoll_Index_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_AlarmRoll_Index203
;Menuoperation.c,793 :: 		Info_Line1[i] = AlarmFullStr[i];
	MOVLW       _Info_Line1+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FSR1H 
	MOVF        AlarmRoll_Index_i_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       _AlarmFullStr+0
	ADDWF       AlarmRoll_Index_i_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_AlarmFullStr+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_AlarmFullStr+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Menuoperation.c,792 :: 		for(i=0;i<16;i++)
	INCF        AlarmRoll_Index_i_L0+0, 1 
;Menuoperation.c,793 :: 		Info_Line1[i] = AlarmFullStr[i];
	GOTO        L_AlarmRoll_Index202
L_AlarmRoll_Index203:
;Menuoperation.c,794 :: 		ClearStr(Info_Line2, 16);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_ClearStr_target+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_ClearStr_target+1 
	MOVLW       16
	MOVWF       FARG_ClearStr_len+0 
	MOVLW       0
	MOVWF       FARG_ClearStr_len+1 
	CALL        _ClearStr+0, 0
;Menuoperation.c,796 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
;Menuoperation.c,797 :: 		Delay_ms(1000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_AlarmRoll_Index205:
	DECFSZ      R13, 1, 1
	BRA         L_AlarmRoll_Index205
	DECFSZ      R12, 1, 1
	BRA         L_AlarmRoll_Index205
	DECFSZ      R11, 1, 1
	BRA         L_AlarmRoll_Index205
	NOP
;Menuoperation.c,798 :: 		}
L_AlarmRoll_Index201:
;Menuoperation.c,799 :: 		}
L_AlarmRoll_Index200:
;Menuoperation.c,801 :: 		SetAlarmStr(Info_Line1, ALARM_NUM, NULL, ALARM_UNIT, 7, ALARM_INDEX);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_SetAlarmStr_prt+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_SetAlarmStr_prt+1 
	MOVF        AlarmRoll_Index_ALARM_NUM_L0+0, 0 
	MOVWF       FARG_SetAlarmStr_datasouce+0 
	CLRF        FARG_SetAlarmStr_datatotle+0 
	MOVF        AlarmRoll_Index_ALARM_UNIT_L0+0, 0 
	MOVWF       FARG_SetAlarmStr_unitype+0 
	MOVLW       7
	MOVWF       FARG_SetAlarmStr_len+0 
	CLRF        FARG_SetAlarmStr_cmd+0 
	CALL        _SetAlarmStr+0, 0
;Menuoperation.c,802 :: 		ClearStr(Info_Line2, 16);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_ClearStr_target+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_ClearStr_target+1 
	MOVLW       16
	MOVWF       FARG_ClearStr_len+0 
	MOVLW       0
	MOVWF       FARG_ClearStr_len+1 
	CALL        _ClearStr+0, 0
;Menuoperation.c,803 :: 		}
	GOTO        L_AlarmRoll_Index206
L_AlarmRoll_Index192:
;Menuoperation.c,807 :: 		spc_system_flag.bite.alarm_actived = 1;
	BSF         _spc_system_flag+1, 0 
;Menuoperation.c,808 :: 		spc_system_flag.bite.alarm_displayed = 0;
	BCF         _spc_system_flag+0, 7 
;Menuoperation.c,809 :: 		ALARM_NUM = pSPCAlarm.spcalarms.num_alarms;
	MOVF        _pSPCAlarm+0, 0 
	MOVWF       AlarmRoll_Index_ALARM_NUM_L0+0 
;Menuoperation.c,810 :: 		ALARM_UNIT = UNIT_ALARM;
	MOVLW       12
	MOVWF       AlarmRoll_Index_ALARM_UNIT_L0+0 
;Menuoperation.c,812 :: 		if(ALARM_NUM >= MAX_LOGS)
	MOVLW       20
	SUBWF       _pSPCAlarm+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_AlarmRoll_Index207
;Menuoperation.c,814 :: 		for(i=0;i<16;i++)
	CLRF        AlarmRoll_Index_i_L0+0 
L_AlarmRoll_Index208:
	MOVLW       16
	SUBWF       AlarmRoll_Index_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_AlarmRoll_Index209
;Menuoperation.c,815 :: 		Info_Line1[i] = AlarmFullStr[i];
	MOVLW       _Info_Line1+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FSR1H 
	MOVF        AlarmRoll_Index_i_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       _AlarmFullStr+0
	ADDWF       AlarmRoll_Index_i_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_AlarmFullStr+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_AlarmFullStr+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Menuoperation.c,814 :: 		for(i=0;i<16;i++)
	INCF        AlarmRoll_Index_i_L0+0, 1 
;Menuoperation.c,815 :: 		Info_Line1[i] = AlarmFullStr[i];
	GOTO        L_AlarmRoll_Index208
L_AlarmRoll_Index209:
;Menuoperation.c,816 :: 		ClearStr(Info_Line2, 16);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_ClearStr_target+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_ClearStr_target+1 
	MOVLW       16
	MOVWF       FARG_ClearStr_len+0 
	MOVLW       0
	MOVWF       FARG_ClearStr_len+1 
	CALL        _ClearStr+0, 0
;Menuoperation.c,818 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
;Menuoperation.c,819 :: 		Delay_ms(1000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_AlarmRoll_Index211:
	DECFSZ      R13, 1, 1
	BRA         L_AlarmRoll_Index211
	DECFSZ      R12, 1, 1
	BRA         L_AlarmRoll_Index211
	DECFSZ      R11, 1, 1
	BRA         L_AlarmRoll_Index211
	NOP
;Menuoperation.c,820 :: 		}
L_AlarmRoll_Index207:
;Menuoperation.c,822 :: 		SetAlarmStr(Info_Line1, ALARM_NUM, NULL, ALARM_UNIT, 7, ALARM_INDEX);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_SetAlarmStr_prt+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_SetAlarmStr_prt+1 
	MOVF        AlarmRoll_Index_ALARM_NUM_L0+0, 0 
	MOVWF       FARG_SetAlarmStr_datasouce+0 
	CLRF        FARG_SetAlarmStr_datatotle+0 
	MOVF        AlarmRoll_Index_ALARM_UNIT_L0+0, 0 
	MOVWF       FARG_SetAlarmStr_unitype+0 
	MOVLW       7
	MOVWF       FARG_SetAlarmStr_len+0 
	CLRF        FARG_SetAlarmStr_cmd+0 
	CALL        _SetAlarmStr+0, 0
;Menuoperation.c,823 :: 		ClearStr(Info_Line2, 16);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_ClearStr_target+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_ClearStr_target+1 
	MOVLW       16
	MOVWF       FARG_ClearStr_len+0 
	MOVLW       0
	MOVWF       FARG_ClearStr_len+1 
	CALL        _ClearStr+0, 0
;Menuoperation.c,824 :: 		}
L_AlarmRoll_Index206:
;Menuoperation.c,825 :: 		Alarmstat = 0;
	CLRF        _Alarmstat+0 
;Menuoperation.c,826 :: 		return;
;Menuoperation.c,827 :: 		}
L_end_AlarmRoll_Index:
	RETURN      0
; end of _AlarmRoll_Index

_AlarmRoll:

;Menuoperation.c,834 :: 		void AlarmRoll(UINT Forward,UINT Alarmcmd)
;Menuoperation.c,836 :: 		UCHAR index,i=0;
	CLRF        AlarmRoll_i_L0+0 
	CLRF        AlarmRoll_AlarmTypeCount_L0+0 
	CLRF        AlarmRoll_AlarmTypeBuff_L0+0 
	CLRF        AlarmRoll_AlarmTypeBuff_L0+1 
	CLRF        AlarmRoll_AlarmTypeBuff_L0+2 
	CLRF        AlarmRoll_AlarmTypeBuff_L0+3 
;Menuoperation.c,841 :: 		if(Alarmcmd == ALARM_INDEX)
	MOVLW       0
	XORWF       FARG_AlarmRoll_Alarmcmd+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll332
	MOVLW       0
	XORWF       FARG_AlarmRoll_Alarmcmd+0, 0 
L__AlarmRoll332:
	BTFSS       STATUS+0, 2 
	GOTO        L_AlarmRoll212
;Menuoperation.c,843 :: 		AlarmRoll_Index(1);
	MOVLW       1
	MOVWF       FARG_AlarmRoll_Index_trige+0 
	CALL        _AlarmRoll_Index+0, 0
;Menuoperation.c,844 :: 		return;
	GOTO        L_end_AlarmRoll
;Menuoperation.c,845 :: 		}
L_AlarmRoll212:
;Menuoperation.c,846 :: 		else if(Alarmcmd == CMD_RESET)
	MOVLW       0
	XORWF       FARG_AlarmRoll_Alarmcmd+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll333
	MOVLW       2
	XORWF       FARG_AlarmRoll_Alarmcmd+0, 0 
L__AlarmRoll333:
	BTFSS       STATUS+0, 2 
	GOTO        L_AlarmRoll214
;Menuoperation.c,848 :: 		if(Alarmstat == 0)
	MOVF        _Alarmstat+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_AlarmRoll215
;Menuoperation.c,850 :: 		Alarm_SSR_off(0);
	CLRF        FARG_Alarm_SSR_off_ChannelNum+0 
	CALL        _Alarm_SSR_off+0, 0
;Menuoperation.c,851 :: 		return;
	GOTO        L_end_AlarmRoll
;Menuoperation.c,852 :: 		}
L_AlarmRoll215:
;Menuoperation.c,854 :: 		if(spc_system_flag.bite.alarm_displayed)  //showing log information
	BTFSS       _spc_system_flag+0, 7 
	GOTO        L_AlarmRoll216
;Menuoperation.c,856 :: 		if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
	BTFSC       _pSPCValue+139, 0 
	GOTO        L_AlarmRoll217
;Menuoperation.c,857 :: 		return;
	GOTO        L_end_AlarmRoll
L_AlarmRoll217:
;Menuoperation.c,859 :: 		if(pSPCAlarm.spclogs.num_logs > 1)
	MOVF        _pSPCAlarm+81, 0 
	SUBLW       1
	BTFSC       STATUS+0, 0 
	GOTO        L_AlarmRoll218
;Menuoperation.c,861 :: 		AlarmTypeBuff = pSPCAlarm.spclogs.log_typ[Alarmstat-1];
	DECF        _Alarmstat+0, 0 
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
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pSPCAlarm+82
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_pSPCAlarm+82)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       AlarmRoll_AlarmTypeBuff_L0+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       AlarmRoll_AlarmTypeBuff_L0+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       AlarmRoll_AlarmTypeBuff_L0+2 
	MOVF        POSTINC0+0, 0 
	MOVWF       AlarmRoll_AlarmTypeBuff_L0+3 
;Menuoperation.c,862 :: 		for(i=Alarmstat; i<pSPCAlarm.spclogs.num_logs; i++)
	MOVF        _Alarmstat+0, 0 
	MOVWF       AlarmRoll_i_L0+0 
L_AlarmRoll219:
	MOVF        _pSPCAlarm+81, 0 
	SUBWF       AlarmRoll_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_AlarmRoll220
;Menuoperation.c,863 :: 		pSPCAlarm.spclogs.log_typ[i-1] = pSPCAlarm.spclogs.log_typ[i];
	DECF        AlarmRoll_i_L0+0, 0 
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
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pSPCAlarm+82
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_pSPCAlarm+82)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        AlarmRoll_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pSPCAlarm+82
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_pSPCAlarm+82)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Menuoperation.c,862 :: 		for(i=Alarmstat; i<pSPCAlarm.spclogs.num_logs; i++)
	INCF        AlarmRoll_i_L0+0, 1 
;Menuoperation.c,863 :: 		pSPCAlarm.spclogs.log_typ[i-1] = pSPCAlarm.spclogs.log_typ[i];
	GOTO        L_AlarmRoll219
L_AlarmRoll220:
;Menuoperation.c,865 :: 		pSPCAlarm.spclogs.num_logs--;
	DECF        _pSPCAlarm+81, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _pSPCAlarm+81 
;Menuoperation.c,867 :: 		if(Alarmstat == (pSPCAlarm.spclogs.num_logs+1))
	MOVF        _pSPCAlarm+81, 0 
	ADDLW       1
	MOVWF       R1 
	CLRF        R2 
	MOVLW       0
	ADDWFC      R2, 1 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll334
	MOVF        R1, 0 
	XORWF       _Alarmstat+0, 0 
L__AlarmRoll334:
	BTFSS       STATUS+0, 2 
	GOTO        L_AlarmRoll222
;Menuoperation.c,868 :: 		Alarmstat = 1;
	MOVLW       1
	MOVWF       _Alarmstat+0 
L_AlarmRoll222:
;Menuoperation.c,869 :: 		}
	GOTO        L_AlarmRoll223
L_AlarmRoll218:
;Menuoperation.c,870 :: 		else if(pSPCAlarm.spclogs.num_logs == 1)
	MOVF        _pSPCAlarm+81, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_AlarmRoll224
;Menuoperation.c,872 :: 		AlarmTypeBuff = pSPCAlarm.spclogs.log_typ[Alarmstat-1];
	DECF        _Alarmstat+0, 0 
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
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pSPCAlarm+82
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_pSPCAlarm+82)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       AlarmRoll_AlarmTypeBuff_L0+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       AlarmRoll_AlarmTypeBuff_L0+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       AlarmRoll_AlarmTypeBuff_L0+2 
	MOVF        POSTINC0+0, 0 
	MOVWF       AlarmRoll_AlarmTypeBuff_L0+3 
;Menuoperation.c,873 :: 		pSPCAlarm.spclogs.num_logs = 0;
	CLRF        _pSPCAlarm+81 
;Menuoperation.c,874 :: 		Alarmstat = 0;
	CLRF        _Alarmstat+0 
;Menuoperation.c,875 :: 		AlarmRoll_Index(0);
	CLRF        FARG_AlarmRoll_Index_trige+0 
	CALL        _AlarmRoll_Index+0, 0
;Menuoperation.c,877 :: 		return;
	GOTO        L_end_AlarmRoll
;Menuoperation.c,878 :: 		}
L_AlarmRoll224:
;Menuoperation.c,880 :: 		return;
	GOTO        L_end_AlarmRoll
L_AlarmRoll223:
;Menuoperation.c,881 :: 		}
	GOTO        L_AlarmRoll226
L_AlarmRoll216:
;Menuoperation.c,884 :: 		if(pSPCAlarm.spcalarms.num_alarms > 1)
	MOVF        _pSPCAlarm+0, 0 
	SUBLW       1
	BTFSC       STATUS+0, 0 
	GOTO        L_AlarmRoll227
;Menuoperation.c,886 :: 		AlarmTypeBuff = pSPCAlarm.spcalarms.alarm_typ[Alarmstat-1];
	DECF        _Alarmstat+0, 0 
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
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pSPCAlarm+1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_pSPCAlarm+1)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       AlarmRoll_AlarmTypeBuff_L0+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       AlarmRoll_AlarmTypeBuff_L0+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       AlarmRoll_AlarmTypeBuff_L0+2 
	MOVF        POSTINC0+0, 0 
	MOVWF       AlarmRoll_AlarmTypeBuff_L0+3 
;Menuoperation.c,887 :: 		for(i=Alarmstat-1;i<pSPCAlarm.spcalarms.num_alarms;i++)
	MOVF        R3, 0 
	MOVWF       AlarmRoll_i_L0+0 
L_AlarmRoll228:
	MOVF        _pSPCAlarm+0, 0 
	SUBWF       AlarmRoll_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_AlarmRoll229
;Menuoperation.c,889 :: 		if(pSPCAlarm.spcalarms.alarm_typ[i] == AlarmTypeBuff)
	MOVF        AlarmRoll_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pSPCAlarm+1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_pSPCAlarm+1)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        R4, 0 
	XORWF       AlarmRoll_AlarmTypeBuff_L0+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll335
	MOVF        R3, 0 
	XORWF       AlarmRoll_AlarmTypeBuff_L0+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll335
	MOVF        R2, 0 
	XORWF       AlarmRoll_AlarmTypeBuff_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll335
	MOVF        R1, 0 
	XORWF       AlarmRoll_AlarmTypeBuff_L0+0, 0 
L__AlarmRoll335:
	BTFSS       STATUS+0, 2 
	GOTO        L_AlarmRoll231
;Menuoperation.c,890 :: 		AlarmTypeCount++;
	INCF        AlarmRoll_AlarmTypeCount_L0+0, 1 
L_AlarmRoll231:
;Menuoperation.c,887 :: 		for(i=Alarmstat-1;i<pSPCAlarm.spcalarms.num_alarms;i++)
	INCF        AlarmRoll_i_L0+0, 1 
;Menuoperation.c,891 :: 		}
	GOTO        L_AlarmRoll228
L_AlarmRoll229:
;Menuoperation.c,892 :: 		if(AlarmTypeCount == 1)
	MOVF        AlarmRoll_AlarmTypeCount_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_AlarmRoll232
;Menuoperation.c,894 :: 		switch(AlarmTypeBuff)
	GOTO        L_AlarmRoll233
;Menuoperation.c,897 :: 		case CH1_GFITRIP:
L_AlarmRoll235:
;Menuoperation.c,898 :: 		ForceSSROFFCondition[0] &= ~GFITRIPFORCEOFF;
	BCF         _ForceSSROFFCondition+0, 0 
;Menuoperation.c,899 :: 		alarmoperate(AlarmTypeBuff,DISALARM);
	MOVF        AlarmRoll_AlarmTypeBuff_L0+0, 0 
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVF        AlarmRoll_AlarmTypeBuff_L0+1, 0 
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVF        AlarmRoll_AlarmTypeBuff_L0+2, 0 
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVF        AlarmRoll_AlarmTypeBuff_L0+3, 0 
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	CLRF        FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
;Menuoperation.c,900 :: 		break;
	GOTO        L_AlarmRoll234
;Menuoperation.c,901 :: 		case CH2_GFITRIP:
L_AlarmRoll236:
;Menuoperation.c,902 :: 		ForceSSROFFCondition[1] &= ~GFITRIPFORCEOFF;
	BCF         _ForceSSROFFCondition+1, 0 
;Menuoperation.c,903 :: 		case SELFCHECKFAILURE:
L_AlarmRoll237:
;Menuoperation.c,904 :: 		case AUTOTESTALARM:
L_AlarmRoll238:
;Menuoperation.c,905 :: 		case CH1_GFITESTFAIL:
L_AlarmRoll239:
;Menuoperation.c,906 :: 		case CH2_GFITESTFAIL:
L_AlarmRoll240:
;Menuoperation.c,907 :: 		alarmoperate(AlarmTypeBuff,DISALARM);
	MOVF        AlarmRoll_AlarmTypeBuff_L0+0, 0 
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVF        AlarmRoll_AlarmTypeBuff_L0+1, 0 
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVF        AlarmRoll_AlarmTypeBuff_L0+2, 0 
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVF        AlarmRoll_AlarmTypeBuff_L0+3, 0 
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	CLRF        FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
;Menuoperation.c,908 :: 		break;
	GOTO        L_AlarmRoll234
;Menuoperation.c,909 :: 		default:
L_AlarmRoll241:
;Menuoperation.c,910 :: 		if(ActivedAlarms & AlarmTypeBuff)
	MOVF        AlarmRoll_AlarmTypeBuff_L0+0, 0 
	ANDWF       _ActivedAlarms+0, 0 
	MOVWF       R0 
	MOVF        AlarmRoll_AlarmTypeBuff_L0+1, 0 
	ANDWF       _ActivedAlarms+1, 0 
	MOVWF       R1 
	MOVF        AlarmRoll_AlarmTypeBuff_L0+2, 0 
	ANDWF       _ActivedAlarms+2, 0 
	MOVWF       R2 
	MOVF        AlarmRoll_AlarmTypeBuff_L0+3, 0 
	ANDWF       _ActivedAlarms+3, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_AlarmRoll242
;Menuoperation.c,911 :: 		return;
	GOTO        L_end_AlarmRoll
L_AlarmRoll242:
;Menuoperation.c,912 :: 		break;
	GOTO        L_AlarmRoll234
;Menuoperation.c,913 :: 		}
L_AlarmRoll233:
	MOVF        AlarmRoll_AlarmTypeBuff_L0+3, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll336
	MOVF        AlarmRoll_AlarmTypeBuff_L0+2, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll336
	MOVF        AlarmRoll_AlarmTypeBuff_L0+1, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll336
	MOVF        AlarmRoll_AlarmTypeBuff_L0+0, 0 
	XORLW       0
L__AlarmRoll336:
	BTFSC       STATUS+0, 2 
	GOTO        L_AlarmRoll235
	MOVF        AlarmRoll_AlarmTypeBuff_L0+3, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll337
	MOVF        AlarmRoll_AlarmTypeBuff_L0+2, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll337
	MOVF        AlarmRoll_AlarmTypeBuff_L0+1, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll337
	MOVF        AlarmRoll_AlarmTypeBuff_L0+0, 0 
	XORLW       0
L__AlarmRoll337:
	BTFSC       STATUS+0, 2 
	GOTO        L_AlarmRoll236
	MOVF        AlarmRoll_AlarmTypeBuff_L0+3, 0 
	XORLW       16
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll338
	MOVF        AlarmRoll_AlarmTypeBuff_L0+2, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll338
	MOVF        AlarmRoll_AlarmTypeBuff_L0+1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll338
	MOVF        AlarmRoll_AlarmTypeBuff_L0+0, 0 
	XORLW       0
L__AlarmRoll338:
	BTFSC       STATUS+0, 2 
	GOTO        L_AlarmRoll237
	MOVF        AlarmRoll_AlarmTypeBuff_L0+3, 0 
	XORLW       32
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll339
	MOVF        AlarmRoll_AlarmTypeBuff_L0+2, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll339
	MOVF        AlarmRoll_AlarmTypeBuff_L0+1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll339
	MOVF        AlarmRoll_AlarmTypeBuff_L0+0, 0 
	XORLW       0
L__AlarmRoll339:
	BTFSC       STATUS+0, 2 
	GOTO        L_AlarmRoll238
	MOVF        AlarmRoll_AlarmTypeBuff_L0+3, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll340
	MOVF        AlarmRoll_AlarmTypeBuff_L0+2, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll340
	MOVF        AlarmRoll_AlarmTypeBuff_L0+1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll340
	MOVF        AlarmRoll_AlarmTypeBuff_L0+0, 0 
	XORLW       0
L__AlarmRoll340:
	BTFSC       STATUS+0, 2 
	GOTO        L_AlarmRoll239
	MOVF        AlarmRoll_AlarmTypeBuff_L0+3, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll341
	MOVF        AlarmRoll_AlarmTypeBuff_L0+2, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll341
	MOVF        AlarmRoll_AlarmTypeBuff_L0+1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll341
	MOVF        AlarmRoll_AlarmTypeBuff_L0+0, 0 
	XORLW       0
L__AlarmRoll341:
	BTFSC       STATUS+0, 2 
	GOTO        L_AlarmRoll240
	GOTO        L_AlarmRoll241
L_AlarmRoll234:
;Menuoperation.c,914 :: 		}
L_AlarmRoll232:
;Menuoperation.c,916 :: 		for(i=Alarmstat; i<pSPCAlarm.spcalarms.num_alarms; i++)
	MOVF        _Alarmstat+0, 0 
	MOVWF       AlarmRoll_i_L0+0 
L_AlarmRoll243:
	MOVF        _pSPCAlarm+0, 0 
	SUBWF       AlarmRoll_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_AlarmRoll244
;Menuoperation.c,917 :: 		pSPCAlarm.spcalarms.alarm_typ[i-1] = pSPCAlarm.spcalarms.alarm_typ[i];
	DECF        AlarmRoll_i_L0+0, 0 
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
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pSPCAlarm+1
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_pSPCAlarm+1)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        AlarmRoll_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pSPCAlarm+1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_pSPCAlarm+1)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Menuoperation.c,916 :: 		for(i=Alarmstat; i<pSPCAlarm.spcalarms.num_alarms; i++)
	INCF        AlarmRoll_i_L0+0, 1 
;Menuoperation.c,917 :: 		pSPCAlarm.spcalarms.alarm_typ[i-1] = pSPCAlarm.spcalarms.alarm_typ[i];
	GOTO        L_AlarmRoll243
L_AlarmRoll244:
;Menuoperation.c,919 :: 		pSPCAlarm.spcalarms.num_alarms--;
	DECF        _pSPCAlarm+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _pSPCAlarm+0 
;Menuoperation.c,920 :: 		if(Alarmstat == (pSPCAlarm.spcalarms.num_alarms+1))
	MOVF        _pSPCAlarm+0, 0 
	ADDLW       1
	MOVWF       R1 
	CLRF        R2 
	MOVLW       0
	ADDWFC      R2, 1 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll342
	MOVF        R1, 0 
	XORWF       _Alarmstat+0, 0 
L__AlarmRoll342:
	BTFSS       STATUS+0, 2 
	GOTO        L_AlarmRoll246
;Menuoperation.c,921 :: 		Alarmstat = 1;
	MOVLW       1
	MOVWF       _Alarmstat+0 
L_AlarmRoll246:
;Menuoperation.c,923 :: 		if(pSPCAlarm.spclogs.num_logs == MAX_LOGS)
	MOVF        _pSPCAlarm+81, 0 
	XORLW       20
	BTFSS       STATUS+0, 2 
	GOTO        L_AlarmRoll247
;Menuoperation.c,925 :: 		for(i=0; i<MAX_LOGS-1; i++)
	CLRF        AlarmRoll_i_L0+0 
L_AlarmRoll248:
	MOVLW       19
	SUBWF       AlarmRoll_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_AlarmRoll249
;Menuoperation.c,926 :: 		pSPCAlarm.spclogs.log_typ[i] = pSPCAlarm.spclogs.log_typ[i+1];
	MOVF        AlarmRoll_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pSPCAlarm+82
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_pSPCAlarm+82)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        AlarmRoll_i_L0+0, 0 
	ADDLW       1
	MOVWF       R3 
	CLRF        R4 
	MOVLW       0
	ADDWFC      R4, 1 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pSPCAlarm+82
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_pSPCAlarm+82)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Menuoperation.c,925 :: 		for(i=0; i<MAX_LOGS-1; i++)
	INCF        AlarmRoll_i_L0+0, 1 
;Menuoperation.c,926 :: 		pSPCAlarm.spclogs.log_typ[i] = pSPCAlarm.spclogs.log_typ[i+1];
	GOTO        L_AlarmRoll248
L_AlarmRoll249:
;Menuoperation.c,928 :: 		pSPCAlarm.spclogs.log_typ[MAX_LOGS-1] = AlarmTypeBuff;
	MOVF        AlarmRoll_AlarmTypeBuff_L0+0, 0 
	MOVWF       _pSPCAlarm+158 
	MOVF        AlarmRoll_AlarmTypeBuff_L0+1, 0 
	MOVWF       _pSPCAlarm+159 
	MOVF        AlarmRoll_AlarmTypeBuff_L0+2, 0 
	MOVWF       _pSPCAlarm+160 
	MOVF        AlarmRoll_AlarmTypeBuff_L0+3, 0 
	MOVWF       _pSPCAlarm+161 
;Menuoperation.c,929 :: 		}
	GOTO        L_AlarmRoll251
L_AlarmRoll247:
;Menuoperation.c,932 :: 		pSPCAlarm.spclogs.log_typ[pSPCAlarm.spclogs.num_logs++] = AlarmTypeBuff;
	MOVF        _pSPCAlarm+81, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pSPCAlarm+82
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_pSPCAlarm+82)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        AlarmRoll_AlarmTypeBuff_L0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        AlarmRoll_AlarmTypeBuff_L0+1, 0 
	MOVWF       POSTINC1+0 
	MOVF        AlarmRoll_AlarmTypeBuff_L0+2, 0 
	MOVWF       POSTINC1+0 
	MOVF        AlarmRoll_AlarmTypeBuff_L0+3, 0 
	MOVWF       POSTINC1+0 
	MOVF        _pSPCAlarm+81, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _pSPCAlarm+81 
;Menuoperation.c,933 :: 		}
L_AlarmRoll251:
;Menuoperation.c,934 :: 		}
	GOTO        L_AlarmRoll252
L_AlarmRoll227:
;Menuoperation.c,935 :: 		else if(pSPCAlarm.spcalarms.num_alarms == 1)
	MOVF        _pSPCAlarm+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_AlarmRoll253
;Menuoperation.c,937 :: 		AlarmTypeBuff = pSPCAlarm.spcalarms.alarm_typ[Alarmstat-1];
	DECF        _Alarmstat+0, 0 
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
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pSPCAlarm+1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_pSPCAlarm+1)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       AlarmRoll_AlarmTypeBuff_L0+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       AlarmRoll_AlarmTypeBuff_L0+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       AlarmRoll_AlarmTypeBuff_L0+2 
	MOVF        POSTINC0+0, 0 
	MOVWF       AlarmRoll_AlarmTypeBuff_L0+3 
;Menuoperation.c,938 :: 		switch(AlarmTypeBuff)
	GOTO        L_AlarmRoll254
;Menuoperation.c,940 :: 		case CH1_GFITRIP:
L_AlarmRoll256:
;Menuoperation.c,941 :: 		ForceSSROFFCondition[0] &= ~GFITRIPFORCEOFF;
	BCF         _ForceSSROFFCondition+0, 0 
;Menuoperation.c,942 :: 		alarmoperate(AlarmTypeBuff,DISALARM);
	MOVF        AlarmRoll_AlarmTypeBuff_L0+0, 0 
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVF        AlarmRoll_AlarmTypeBuff_L0+1, 0 
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVF        AlarmRoll_AlarmTypeBuff_L0+2, 0 
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVF        AlarmRoll_AlarmTypeBuff_L0+3, 0 
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	CLRF        FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
;Menuoperation.c,943 :: 		break;
	GOTO        L_AlarmRoll255
;Menuoperation.c,944 :: 		case CH2_GFITRIP:
L_AlarmRoll257:
;Menuoperation.c,945 :: 		ForceSSROFFCondition[1] &= ~GFITRIPFORCEOFF;
	BCF         _ForceSSROFFCondition+1, 0 
;Menuoperation.c,946 :: 		case SELFCHECKFAILURE:
L_AlarmRoll258:
;Menuoperation.c,947 :: 		case AUTOTESTALARM:
L_AlarmRoll259:
;Menuoperation.c,948 :: 		case CH1_GFITESTFAIL:
L_AlarmRoll260:
;Menuoperation.c,949 :: 		case CH2_GFITESTFAIL:
L_AlarmRoll261:
;Menuoperation.c,950 :: 		alarmoperate(AlarmTypeBuff,DISALARM);
	MOVF        AlarmRoll_AlarmTypeBuff_L0+0, 0 
	MOVWF       FARG_alarmoperate_alarmcommand+0 
	MOVF        AlarmRoll_AlarmTypeBuff_L0+1, 0 
	MOVWF       FARG_alarmoperate_alarmcommand+1 
	MOVF        AlarmRoll_AlarmTypeBuff_L0+2, 0 
	MOVWF       FARG_alarmoperate_alarmcommand+2 
	MOVF        AlarmRoll_AlarmTypeBuff_L0+3, 0 
	MOVWF       FARG_alarmoperate_alarmcommand+3 
	CLRF        FARG_alarmoperate_active+0 
	CALL        _alarmoperate+0, 0
;Menuoperation.c,951 :: 		break;
	GOTO        L_AlarmRoll255
;Menuoperation.c,952 :: 		default:
L_AlarmRoll262:
;Menuoperation.c,953 :: 		if(ActivedAlarms & AlarmTypeBuff)
	MOVF        AlarmRoll_AlarmTypeBuff_L0+0, 0 
	ANDWF       _ActivedAlarms+0, 0 
	MOVWF       R0 
	MOVF        AlarmRoll_AlarmTypeBuff_L0+1, 0 
	ANDWF       _ActivedAlarms+1, 0 
	MOVWF       R1 
	MOVF        AlarmRoll_AlarmTypeBuff_L0+2, 0 
	ANDWF       _ActivedAlarms+2, 0 
	MOVWF       R2 
	MOVF        AlarmRoll_AlarmTypeBuff_L0+3, 0 
	ANDWF       _ActivedAlarms+3, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_AlarmRoll263
;Menuoperation.c,954 :: 		return;
	GOTO        L_end_AlarmRoll
L_AlarmRoll263:
;Menuoperation.c,955 :: 		break;
	GOTO        L_AlarmRoll255
;Menuoperation.c,956 :: 		}
L_AlarmRoll254:
	MOVF        AlarmRoll_AlarmTypeBuff_L0+3, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll343
	MOVF        AlarmRoll_AlarmTypeBuff_L0+2, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll343
	MOVF        AlarmRoll_AlarmTypeBuff_L0+1, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll343
	MOVF        AlarmRoll_AlarmTypeBuff_L0+0, 0 
	XORLW       0
L__AlarmRoll343:
	BTFSC       STATUS+0, 2 
	GOTO        L_AlarmRoll256
	MOVF        AlarmRoll_AlarmTypeBuff_L0+3, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll344
	MOVF        AlarmRoll_AlarmTypeBuff_L0+2, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll344
	MOVF        AlarmRoll_AlarmTypeBuff_L0+1, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll344
	MOVF        AlarmRoll_AlarmTypeBuff_L0+0, 0 
	XORLW       0
L__AlarmRoll344:
	BTFSC       STATUS+0, 2 
	GOTO        L_AlarmRoll257
	MOVF        AlarmRoll_AlarmTypeBuff_L0+3, 0 
	XORLW       16
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll345
	MOVF        AlarmRoll_AlarmTypeBuff_L0+2, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll345
	MOVF        AlarmRoll_AlarmTypeBuff_L0+1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll345
	MOVF        AlarmRoll_AlarmTypeBuff_L0+0, 0 
	XORLW       0
L__AlarmRoll345:
	BTFSC       STATUS+0, 2 
	GOTO        L_AlarmRoll258
	MOVF        AlarmRoll_AlarmTypeBuff_L0+3, 0 
	XORLW       32
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll346
	MOVF        AlarmRoll_AlarmTypeBuff_L0+2, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll346
	MOVF        AlarmRoll_AlarmTypeBuff_L0+1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll346
	MOVF        AlarmRoll_AlarmTypeBuff_L0+0, 0 
	XORLW       0
L__AlarmRoll346:
	BTFSC       STATUS+0, 2 
	GOTO        L_AlarmRoll259
	MOVF        AlarmRoll_AlarmTypeBuff_L0+3, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll347
	MOVF        AlarmRoll_AlarmTypeBuff_L0+2, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll347
	MOVF        AlarmRoll_AlarmTypeBuff_L0+1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll347
	MOVF        AlarmRoll_AlarmTypeBuff_L0+0, 0 
	XORLW       0
L__AlarmRoll347:
	BTFSC       STATUS+0, 2 
	GOTO        L_AlarmRoll260
	MOVF        AlarmRoll_AlarmTypeBuff_L0+3, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll348
	MOVF        AlarmRoll_AlarmTypeBuff_L0+2, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll348
	MOVF        AlarmRoll_AlarmTypeBuff_L0+1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__AlarmRoll348
	MOVF        AlarmRoll_AlarmTypeBuff_L0+0, 0 
	XORLW       0
L__AlarmRoll348:
	BTFSC       STATUS+0, 2 
	GOTO        L_AlarmRoll261
	GOTO        L_AlarmRoll262
L_AlarmRoll255:
;Menuoperation.c,958 :: 		pSPCAlarm.spcalarms.num_alarms = 0;
	CLRF        _pSPCAlarm+0 
;Menuoperation.c,959 :: 		Alarmstat = 0;
	CLRF        _Alarmstat+0 
;Menuoperation.c,961 :: 		AlarmRoll_Index(0);
	CLRF        FARG_AlarmRoll_Index_trige+0 
	CALL        _AlarmRoll_Index+0, 0
;Menuoperation.c,963 :: 		if(pSPCAlarm.spclogs.num_logs == MAX_LOGS)
	MOVF        _pSPCAlarm+81, 0 
	XORLW       20
	BTFSS       STATUS+0, 2 
	GOTO        L_AlarmRoll264
;Menuoperation.c,965 :: 		for(i=0; i<MAX_LOGS-1; i++)
	CLRF        AlarmRoll_i_L0+0 
L_AlarmRoll265:
	MOVLW       19
	SUBWF       AlarmRoll_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_AlarmRoll266
;Menuoperation.c,966 :: 		pSPCAlarm.spclogs.log_typ[i] = pSPCAlarm.spclogs.log_typ[i+1];
	MOVF        AlarmRoll_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pSPCAlarm+82
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_pSPCAlarm+82)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        AlarmRoll_i_L0+0, 0 
	ADDLW       1
	MOVWF       R3 
	CLRF        R4 
	MOVLW       0
	ADDWFC      R4, 1 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pSPCAlarm+82
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_pSPCAlarm+82)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Menuoperation.c,965 :: 		for(i=0; i<MAX_LOGS-1; i++)
	INCF        AlarmRoll_i_L0+0, 1 
;Menuoperation.c,966 :: 		pSPCAlarm.spclogs.log_typ[i] = pSPCAlarm.spclogs.log_typ[i+1];
	GOTO        L_AlarmRoll265
L_AlarmRoll266:
;Menuoperation.c,968 :: 		pSPCAlarm.spclogs.log_typ[MAX_LOGS-1] = AlarmTypeBuff;
	MOVF        AlarmRoll_AlarmTypeBuff_L0+0, 0 
	MOVWF       _pSPCAlarm+158 
	MOVF        AlarmRoll_AlarmTypeBuff_L0+1, 0 
	MOVWF       _pSPCAlarm+159 
	MOVF        AlarmRoll_AlarmTypeBuff_L0+2, 0 
	MOVWF       _pSPCAlarm+160 
	MOVF        AlarmRoll_AlarmTypeBuff_L0+3, 0 
	MOVWF       _pSPCAlarm+161 
;Menuoperation.c,969 :: 		}
	GOTO        L_AlarmRoll268
L_AlarmRoll264:
;Menuoperation.c,972 :: 		pSPCAlarm.spclogs.log_typ[pSPCAlarm.spclogs.num_logs++] = AlarmTypeBuff;
	MOVF        _pSPCAlarm+81, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pSPCAlarm+82
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_pSPCAlarm+82)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        AlarmRoll_AlarmTypeBuff_L0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        AlarmRoll_AlarmTypeBuff_L0+1, 0 
	MOVWF       POSTINC1+0 
	MOVF        AlarmRoll_AlarmTypeBuff_L0+2, 0 
	MOVWF       POSTINC1+0 
	MOVF        AlarmRoll_AlarmTypeBuff_L0+3, 0 
	MOVWF       POSTINC1+0 
	MOVF        _pSPCAlarm+81, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _pSPCAlarm+81 
;Menuoperation.c,973 :: 		}
L_AlarmRoll268:
;Menuoperation.c,974 :: 		return;
	GOTO        L_end_AlarmRoll
;Menuoperation.c,975 :: 		}
L_AlarmRoll253:
;Menuoperation.c,977 :: 		return;
	GOTO        L_end_AlarmRoll
L_AlarmRoll252:
;Menuoperation.c,978 :: 		}
L_AlarmRoll226:
;Menuoperation.c,979 :: 		}
	GOTO        L_AlarmRoll270
L_AlarmRoll214:
;Menuoperation.c,982 :: 		index = spc_system_flag.bite.alarm_displayed;
	MOVLW       0
	BTFSC       _spc_system_flag+0, 7 
	MOVLW       1
	MOVWF       AlarmRoll_index_L0+0 
;Menuoperation.c,983 :: 		if(index)
	MOVF        AlarmRoll_index_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_AlarmRoll271
;Menuoperation.c,985 :: 		ALARM_NUM = pSPCAlarm.spclogs.num_logs;
	MOVF        _pSPCAlarm+81, 0 
	MOVWF       AlarmRoll_ALARM_NUM_L0+0 
;Menuoperation.c,986 :: 		ALARM_UNIT = UNIT_LOG;
	MOVLW       13
	MOVWF       AlarmRoll_ALARM_UNIT_L0+0 
;Menuoperation.c,987 :: 		}
	GOTO        L_AlarmRoll272
L_AlarmRoll271:
;Menuoperation.c,990 :: 		ALARM_NUM = pSPCAlarm.spcalarms.num_alarms;
	MOVF        _pSPCAlarm+0, 0 
	MOVWF       AlarmRoll_ALARM_NUM_L0+0 
;Menuoperation.c,991 :: 		ALARM_UNIT = UNIT_ALARM;
	MOVLW       12
	MOVWF       AlarmRoll_ALARM_UNIT_L0+0 
;Menuoperation.c,992 :: 		}
L_AlarmRoll272:
;Menuoperation.c,994 :: 		if(ALARM_NUM == 0)
	MOVF        AlarmRoll_ALARM_NUM_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_AlarmRoll273
;Menuoperation.c,996 :: 		SetAlarmStr(Info_Line1, ALARM_NUM, NULL, ALARM_UNIT, 7, ALARM_INDEX);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_SetAlarmStr_prt+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_SetAlarmStr_prt+1 
	MOVF        AlarmRoll_ALARM_NUM_L0+0, 0 
	MOVWF       FARG_SetAlarmStr_datasouce+0 
	CLRF        FARG_SetAlarmStr_datatotle+0 
	MOVF        AlarmRoll_ALARM_UNIT_L0+0, 0 
	MOVWF       FARG_SetAlarmStr_unitype+0 
	MOVLW       7
	MOVWF       FARG_SetAlarmStr_len+0 
	CLRF        FARG_SetAlarmStr_cmd+0 
	CALL        _SetAlarmStr+0, 0
;Menuoperation.c,997 :: 		ClearStr(Info_Line2, 16);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_ClearStr_target+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_ClearStr_target+1 
	MOVLW       16
	MOVWF       FARG_ClearStr_len+0 
	MOVLW       0
	MOVWF       FARG_ClearStr_len+1 
	CALL        _ClearStr+0, 0
;Menuoperation.c,998 :: 		return;
	GOTO        L_end_AlarmRoll
;Menuoperation.c,999 :: 		}
L_AlarmRoll273:
;Menuoperation.c,1001 :: 		if(Forward)
	MOVF        FARG_AlarmRoll_Forward+0, 0 
	IORWF       FARG_AlarmRoll_Forward+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_AlarmRoll274
;Menuoperation.c,1003 :: 		if((Alarmstat >= ALARM_NUM) || (Alarmstat >= MAX_LOGS))
	MOVF        AlarmRoll_ALARM_NUM_L0+0, 0 
	SUBWF       _Alarmstat+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L__AlarmRoll301
	MOVLW       20
	SUBWF       _Alarmstat+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L__AlarmRoll301
	GOTO        L_AlarmRoll277
L__AlarmRoll301:
;Menuoperation.c,1004 :: 		Alarmstat = 1;
	MOVLW       1
	MOVWF       _Alarmstat+0 
	GOTO        L_AlarmRoll278
L_AlarmRoll277:
;Menuoperation.c,1006 :: 		Alarmstat++;
	INCF        _Alarmstat+0, 1 
L_AlarmRoll278:
;Menuoperation.c,1007 :: 		}
	GOTO        L_AlarmRoll279
L_AlarmRoll274:
;Menuoperation.c,1010 :: 		if(Alarmstat <= 1)
	MOVF        _Alarmstat+0, 0 
	SUBLW       1
	BTFSS       STATUS+0, 0 
	GOTO        L_AlarmRoll280
;Menuoperation.c,1011 :: 		Alarmstat = ALARM_NUM;
	MOVF        AlarmRoll_ALARM_NUM_L0+0, 0 
	MOVWF       _Alarmstat+0 
	GOTO        L_AlarmRoll281
L_AlarmRoll280:
;Menuoperation.c,1013 :: 		Alarmstat--;
	DECF        _Alarmstat+0, 1 
L_AlarmRoll281:
;Menuoperation.c,1014 :: 		}
L_AlarmRoll279:
;Menuoperation.c,1015 :: 		}
L_AlarmRoll270:
;Menuoperation.c,1016 :: 		set_alarm_info(Alarmstat);
	MOVF        _Alarmstat+0, 0 
	MOVWF       FARG_set_alarm_info_AlarmIndex+0 
	CALL        _set_alarm_info+0, 0
;Menuoperation.c,1017 :: 		}
L_end_AlarmRoll:
	RETURN      0
; end of _AlarmRoll

_set_alarm_info:

;Menuoperation.c,1024 :: 		void set_alarm_info(UCHAR AlarmIndex)
;Menuoperation.c,1027 :: 		volatile UINT Alarmtype=0;
	CLRF        set_alarm_info_Alarmtype_L0+0 
	CLRF        set_alarm_info_Alarmtype_L0+1 
;Menuoperation.c,1030 :: 		index = spc_system_flag.bite.alarm_displayed;
	MOVLW       0
	BTFSC       _spc_system_flag+0, 7 
	MOVLW       1
	MOVWF       set_alarm_info_index_L0+0 
;Menuoperation.c,1032 :: 		if(index)
	MOVF        set_alarm_info_index_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_set_alarm_info282
;Menuoperation.c,1034 :: 		ALARM_NUM = pSPCAlarm.spclogs.num_logs;
	MOVF        _pSPCAlarm+81, 0 
	MOVWF       set_alarm_info_ALARM_NUM_L0+0 
;Menuoperation.c,1035 :: 		ALARM_UNIT = UNIT_LOG;
	MOVLW       13
	MOVWF       set_alarm_info_ALARM_UNIT_L0+0 
;Menuoperation.c,1036 :: 		}
	GOTO        L_set_alarm_info283
L_set_alarm_info282:
;Menuoperation.c,1039 :: 		ALARM_NUM = pSPCAlarm.spcalarms.num_alarms;
	MOVF        _pSPCAlarm+0, 0 
	MOVWF       set_alarm_info_ALARM_NUM_L0+0 
;Menuoperation.c,1040 :: 		ALARM_UNIT = UNIT_ALARM;
	MOVLW       12
	MOVWF       set_alarm_info_ALARM_UNIT_L0+0 
;Menuoperation.c,1041 :: 		}
L_set_alarm_info283:
;Menuoperation.c,1043 :: 		SetAlarmStr(Info_Line1, AlarmIndex, ALARM_NUM, ALARM_UNIT, 7, ALARM_SUBINDEX);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_SetAlarmStr_prt+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_SetAlarmStr_prt+1 
	MOVF        FARG_set_alarm_info_AlarmIndex+0, 0 
	MOVWF       FARG_SetAlarmStr_datasouce+0 
	MOVF        set_alarm_info_ALARM_NUM_L0+0, 0 
	MOVWF       FARG_SetAlarmStr_datatotle+0 
	MOVF        set_alarm_info_ALARM_UNIT_L0+0, 0 
	MOVWF       FARG_SetAlarmStr_unitype+0 
	MOVLW       7
	MOVWF       FARG_SetAlarmStr_len+0 
	MOVLW       1
	MOVWF       FARG_SetAlarmStr_cmd+0 
	CALL        _SetAlarmStr+0, 0
;Menuoperation.c,1044 :: 		Alarmtype = GetAlarmType(AlarmIndex-1,index);
	DECF        FARG_set_alarm_info_AlarmIndex+0, 0 
	MOVWF       FARG_GetAlarmType_index+0 
	MOVF        set_alarm_info_index_L0+0, 0 
	MOVWF       FARG_GetAlarmType_cmd+0 
	CALL        _GetAlarmType+0, 0
	MOVF        R0, 0 
	MOVWF       set_alarm_info_Alarmtype_L0+0 
	MOVF        R1, 0 
	MOVWF       set_alarm_info_Alarmtype_L0+1 
;Menuoperation.c,1045 :: 		getParaChar(Info_Line2, Alarmtype+43);
	MOVLW       _Info_Line2+0
	MOVWF       FARG_getParaChar_ptr+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_getParaChar_ptr+1 
	MOVLW       43
	ADDWF       set_alarm_info_Alarmtype_L0+0, 0 
	MOVWF       FARG_getParaChar_locat+0 
	CALL        _getParaChar+0, 0
;Menuoperation.c,1046 :: 		}
L_end_set_alarm_info:
	RETURN      0
; end of _set_alarm_info

_GetAlarmType:

;Menuoperation.c,1053 :: 		UINT GetAlarmType(UCHAR index, char cmd)
;Menuoperation.c,1055 :: 		char index_bit=0;
	CLRF        GetAlarmType_index_bit_L0+0 
	CLRF        GetAlarmType_count_L0+0 
	CLRF        GetAlarmType_count_L0+1 
;Menuoperation.c,1057 :: 		while(count < 32)
L_GetAlarmType284:
	MOVLW       0
	SUBWF       GetAlarmType_count_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetAlarmType351
	MOVLW       32
	SUBWF       GetAlarmType_count_L0+0, 0 
L__GetAlarmType351:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetAlarmType285
;Menuoperation.c,1059 :: 		if(cmd)
	MOVF        FARG_GetAlarmType_cmd+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_GetAlarmType286
;Menuoperation.c,1060 :: 		index_bit = (pSPCAlarm.spclogs.log_typ[index] >> count) & 0x01;
	MOVF        FARG_GetAlarmType_index+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pSPCAlarm+82
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_pSPCAlarm+82)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R5 
	MOVF        POSTINC0+0, 0 
	MOVWF       R6 
	MOVF        POSTINC0+0, 0 
	MOVWF       R7 
	MOVF        POSTINC0+0, 0 
	MOVWF       R8 
	MOVF        GetAlarmType_count_L0+0, 0 
	MOVWF       R4 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	MOVF        R4, 0 
L__GetAlarmType352:
	BZ          L__GetAlarmType353
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	ADDLW       255
	GOTO        L__GetAlarmType352
L__GetAlarmType353:
	MOVLW       1
	ANDWF       R0, 0 
	MOVWF       GetAlarmType_index_bit_L0+0 
	GOTO        L_GetAlarmType287
L_GetAlarmType286:
;Menuoperation.c,1062 :: 		index_bit = (pSPCAlarm.spcalarms.alarm_typ[index] >> count) & 0x01;
	MOVF        FARG_GetAlarmType_index+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pSPCAlarm+1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_pSPCAlarm+1)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R5 
	MOVF        POSTINC0+0, 0 
	MOVWF       R6 
	MOVF        POSTINC0+0, 0 
	MOVWF       R7 
	MOVF        POSTINC0+0, 0 
	MOVWF       R8 
	MOVF        GetAlarmType_count_L0+0, 0 
	MOVWF       R4 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	MOVF        R4, 0 
L__GetAlarmType354:
	BZ          L__GetAlarmType355
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	ADDLW       255
	GOTO        L__GetAlarmType354
L__GetAlarmType355:
	MOVLW       1
	ANDWF       R0, 0 
	MOVWF       GetAlarmType_index_bit_L0+0 
L_GetAlarmType287:
;Menuoperation.c,1064 :: 		if(index_bit)
	MOVF        GetAlarmType_index_bit_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_GetAlarmType288
;Menuoperation.c,1065 :: 		return count;
	MOVF        GetAlarmType_count_L0+0, 0 
	MOVWF       R0 
	MOVF        GetAlarmType_count_L0+1, 0 
	MOVWF       R1 
	GOTO        L_end_GetAlarmType
L_GetAlarmType288:
;Menuoperation.c,1067 :: 		count++;
	INFSNZ      GetAlarmType_count_L0+0, 1 
	INCF        GetAlarmType_count_L0+1, 1 
;Menuoperation.c,1068 :: 		}
	GOTO        L_GetAlarmType284
L_GetAlarmType285:
;Menuoperation.c,1069 :: 		}
L_end_GetAlarmType:
	RETURN      0
; end of _GetAlarmType

_LCDUpdate:

;Menuoperation.c,1076 :: 		void LCDUpdate()
;Menuoperation.c,1078 :: 		LCD_output(Info_Line1,Info_Line2);
	MOVLW       _Info_Line1+0
	MOVWF       FARG_LCD_output_txt1+0 
	MOVLW       hi_addr(_Info_Line1+0)
	MOVWF       FARG_LCD_output_txt1+1 
	MOVLW       _Info_Line2+0
	MOVWF       FARG_LCD_output_txt2+0 
	MOVLW       hi_addr(_Info_Line2+0)
	MOVWF       FARG_LCD_output_txt2+1 
	CALL        _LCD_output+0, 0
;Menuoperation.c,1079 :: 		}
L_end_LCDUpdate:
	RETURN      0
; end of _LCDUpdate

_rightkey_func:

;Menuoperation.c,1086 :: 		void rightkey_func()
;Menuoperation.c,1088 :: 		Scantime_DIS();
	CALL        _Scantime_DIS+0, 0
;Menuoperation.c,1089 :: 		Flashing_DIS();
	CALL        _Flashing_DIS+0, 0
;Menuoperation.c,1091 :: 		if(spc_system_flag.bite.alarm_actived)
	BTFSS       _spc_system_flag+1, 0 
	GOTO        L_rightkey_func290
;Menuoperation.c,1092 :: 		AlarmRoll(CMD_FORWARD,ALARM_SUBINDEX);
	MOVLW       1
	MOVWF       FARG_AlarmRoll_Forward+0 
	MOVLW       0
	MOVWF       FARG_AlarmRoll_Forward+1 
	MOVLW       1
	MOVWF       FARG_AlarmRoll_Alarmcmd+0 
	MOVLW       0
	MOVWF       FARG_AlarmRoll_Alarmcmd+1 
	CALL        _AlarmRoll+0, 0
	GOTO        L_rightkey_func291
L_rightkey_func290:
;Menuoperation.c,1093 :: 		else if(spc_system_flag.bite.char_actived)
	BTFSS       _spc_system_flag+1, 3 
	GOTO        L_rightkey_func292
;Menuoperation.c,1094 :: 		set_menu_info(CMD_FORWARD,CMD_SWITCH);
	MOVLW       1
	MOVWF       FARG_set_menu_info_direction+0 
	MOVLW       3
	MOVWF       FARG_set_menu_info_command+0 
	CALL        _set_menu_info+0, 0
	GOTO        L_rightkey_func293
L_rightkey_func292:
;Menuoperation.c,1095 :: 		else if(reset_psw_en)
	MOVF        _reset_psw_en+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_rightkey_func294
;Menuoperation.c,1096 :: 		Reset_PSW(CMD_FORWARD,CMD_SWITCH);
	MOVLW       1
	MOVWF       FARG_Reset_PSW_direct+0 
	MOVLW       3
	MOVWF       FARG_Reset_PSW_cmd+0 
	CALL        _Reset_PSW+0, 0
	GOTO        L_rightkey_func295
L_rightkey_func294:
;Menuoperation.c,1099 :: 		MenuRoll(CMD_FORWARD,NULL,THIRDINDEX);
	MOVLW       1
	MOVWF       FARG_MenuRoll_Forward+0 
	CLRF        FARG_MenuRoll_Para+0 
	MOVLW       6
	MOVWF       FARG_MenuRoll_Level+0 
	CALL        _MenuRoll+0, 0
;Menuoperation.c,1100 :: 		}
L_rightkey_func295:
L_rightkey_func293:
L_rightkey_func291:
;Menuoperation.c,1102 :: 		LCDUpdate();
	CALL        _LCDUpdate+0, 0
;Menuoperation.c,1103 :: 		}
L_end_rightkey_func:
	RETURN      0
; end of _rightkey_func
