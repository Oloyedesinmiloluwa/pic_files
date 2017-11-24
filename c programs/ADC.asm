
_main:

;ADC.c,17 :: 		void main() {
;ADC.c,20 :: 		CMCON=0X07;
	MOVLW      7
	MOVWF      CMCON+0
;ADC.c,21 :: 		TRISA=0x05;
	MOVLW      5
	MOVWF      TRISA+0
;ADC.c,22 :: 		ADCON0=0;
	CLRF       ADCON0+0
;ADC.c,23 :: 		ADCON1=0x00;    //4
	CLRF       ADCON1+0
;ADC.c,24 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;ADC.c,25 :: 		TRISB=0;
	CLRF       TRISB+0
;ADC.c,26 :: 		PORTB=0;
	CLRF       PORTB+0
;ADC.c,27 :: 		PORTA =0;
	CLRF       PORTA+0
;ADC.c,28 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;ADC.c,29 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;ADC.c,31 :: 		do{
L_main0:
;ADC.c,32 :: 		v=ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _v+0
	MOVF       R0+1, 0
	MOVWF      _v+1
	CLRF       _v+2
	CLRF       _v+3
;ADC.c,33 :: 		Volt=v*4.89;
	MOVF       _v+0, 0
	MOVWF      R0+0
	MOVF       _v+1, 0
	MOVWF      R0+1
	MOVF       _v+2, 0
	MOVWF      R0+2
	MOVF       _v+3, 0
	MOVWF      R0+3
	CALL       _Longint2Double+0
	MOVLW      225
	MOVWF      R4+0
	MOVLW      122
	MOVWF      R4+1
	MOVLW      28
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	CALL       _Double2Longint+0
	MOVF       R0+0, 0
	MOVWF      _Volt+0
	MOVF       R0+1, 0
	MOVWF      _Volt+1
	MOVF       R0+2, 0
	MOVWF      _Volt+2
	MOVF       R0+3, 0
	MOVWF      _Volt+3
;ADC.c,34 :: 		Volt=(Volt/20)*120;
	MOVLW      20
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_S+0
	MOVLW      120
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      _Volt+0
	MOVF       R0+1, 0
	MOVWF      _Volt+1
	MOVF       R0+2, 0
	MOVWF      _Volt+2
	MOVF       R0+3, 0
	MOVWF      _Volt+3
;ADC.c,35 :: 		Volt=volt/1000;
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_S+0
	MOVF       R0+0, 0
	MOVWF      _Volt+0
	MOVF       R0+1, 0
	MOVWF      _Volt+1
	MOVF       R0+2, 0
	MOVWF      _Volt+2
	MOVF       R0+3, 0
	MOVWF      _Volt+3
;ADC.c,36 :: 		longTostr(Volt,READSAVE);
	MOVF       R0+0, 0
	MOVWF      FARG_LongToStr_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_LongToStr_input+1
	MOVF       R0+2, 0
	MOVWF      FARG_LongToStr_input+2
	MOVF       R0+3, 0
	MOVWF      FARG_LongToStr_input+3
	MOVLW      _READSAVE+0
	MOVWF      FARG_LongToStr_output+0
	CALL       _LongToStr+0
;ADC.c,40 :: 		i++;
	MOVF       _i+0, 0
	MOVWF      R0+0
	MOVF       _i+1, 0
	MOVWF      R0+1
	MOVF       _i+2, 0
	MOVWF      R0+2
	MOVF       _i+3, 0
	MOVWF      R0+3
	INCF       R0+0, 1
	BTFSC      STATUS+0, 2
	INCF       R0+1, 1
	BTFSC      STATUS+0, 2
	INCF       R0+2, 1
	BTFSC      STATUS+0, 2
	INCF       R0+3, 1
	MOVF       R0+0, 0
	MOVWF      _i+0
	MOVF       R0+1, 0
	MOVWF      _i+1
	MOVF       R0+2, 0
	MOVWF      _i+2
	MOVF       R0+3, 0
	MOVWF      _i+3
;ADC.c,41 :: 		Lcd_Out(1,1,"Voltage=") ;
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_ADC+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ADC.c,42 :: 		Lcd_Out(1,10,READSAVE);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      10
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _READSAVE+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ADC.c,43 :: 		Lcd_Out(1,17,"V");            // Write text in first row
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      17
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_ADC+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ADC.c,45 :: 		while(i<1)  ;
	MOVLW      128
	XORWF      _i+3, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main3
	MOVLW      0
	SUBWF      _i+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main3
	MOVLW      0
	SUBWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main3
	MOVLW      1
	SUBWF      _i+0, 0
L__main3:
	BTFSS      STATUS+0, 0
	GOTO       L_main0
;ADC.c,47 :: 		}
	GOTO       $+0
; end of _main
