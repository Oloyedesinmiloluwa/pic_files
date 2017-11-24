
_Move_Delay:

;LCD.c,24 :: 		void Move_Delay() {                  // Function used for text moving
;LCD.c,25 :: 		Delay_ms(500);                     // You can change the moving speed here
	MOVLW      13
	MOVWF      R11+0
	MOVLW      175
	MOVWF      R12+0
	MOVLW      182
	MOVWF      R13+0
L_Move_Delay0:
	DECFSZ     R13+0, 1
	GOTO       L_Move_Delay0
	DECFSZ     R12+0, 1
	GOTO       L_Move_Delay0
	DECFSZ     R11+0, 1
	GOTO       L_Move_Delay0
	NOP
;LCD.c,26 :: 		}
	RETURN
; end of _Move_Delay

_main:

;LCD.c,28 :: 		void main(){
;LCD.c,31 :: 		Lcd_Init();                        // Initialize LCD
	CALL       _Lcd_Init+0
;LCD.c,33 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;LCD.c,34 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;LCD.c,35 :: 		Lcd_Out(1,6,txt3);                 // Write text in first row
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt3+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;LCD.c,37 :: 		Lcd_Out(2,6,txt4);                 // Write text in second row
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt4+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;LCD.c,38 :: 		Delay_ms(2000);
	MOVLW      51
	MOVWF      R11+0
	MOVLW      187
	MOVWF      R12+0
	MOVLW      223
	MOVWF      R13+0
L_main1:
	DECFSZ     R13+0, 1
	GOTO       L_main1
	DECFSZ     R12+0, 1
	GOTO       L_main1
	DECFSZ     R11+0, 1
	GOTO       L_main1
	NOP
	NOP
;LCD.c,39 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;LCD.c,41 :: 		Lcd_Out(1,1,txt1);                 // Write text in first row
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;LCD.c,42 :: 		Lcd_Out(2,5,txt2);                 // Write text in second row
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;LCD.c,44 :: 		Delay_ms(2000);
	MOVLW      51
	MOVWF      R11+0
	MOVLW      187
	MOVWF      R12+0
	MOVLW      223
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	DECFSZ     R11+0, 1
	GOTO       L_main2
	NOP
	NOP
;LCD.c,47 :: 		for(i=0; i<4; i++) {               // Move text to the right 4 times
	CLRF       _i+0
L_main3:
	MOVLW      4
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main4
;LCD.c,48 :: 		Lcd_Cmd(_LCD_SHIFT_RIGHT);
	MOVLW      28
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;LCD.c,49 :: 		Move_Delay();
	CALL       _Move_Delay+0
;LCD.c,47 :: 		for(i=0; i<4; i++) {               // Move text to the right 4 times
	INCF       _i+0, 1
;LCD.c,50 :: 		}
	GOTO       L_main3
L_main4:
;LCD.c,52 :: 		while(1) {                         // Endless loop
L_main6:
;LCD.c,53 :: 		for(i=0; i<8; i++) {             // Move text to the left 7 times
	CLRF       _i+0
L_main8:
	MOVLW      8
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main9
;LCD.c,54 :: 		Lcd_Cmd(_LCD_SHIFT_LEFT);
	MOVLW      24
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;LCD.c,55 :: 		Move_Delay();
	CALL       _Move_Delay+0
;LCD.c,53 :: 		for(i=0; i<8; i++) {             // Move text to the left 7 times
	INCF       _i+0, 1
;LCD.c,56 :: 		}
	GOTO       L_main8
L_main9:
;LCD.c,58 :: 		for(i=0; i<8; i++) {             // Move text to the right 7 times
	CLRF       _i+0
L_main11:
	MOVLW      8
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main12
;LCD.c,59 :: 		Lcd_Cmd(_LCD_SHIFT_RIGHT);
	MOVLW      28
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;LCD.c,60 :: 		Move_Delay();
	CALL       _Move_Delay+0
;LCD.c,58 :: 		for(i=0; i<8; i++) {             // Move text to the right 7 times
	INCF       _i+0, 1
;LCD.c,61 :: 		}
	GOTO       L_main11
L_main12:
;LCD.c,62 :: 		}
	GOTO       L_main6
;LCD.c,63 :: 		}
	GOTO       $+0
; end of _main
