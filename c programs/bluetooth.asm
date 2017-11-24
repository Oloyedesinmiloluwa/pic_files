
_main:

;bluetooth.c,2 :: 		void main() {
;bluetooth.c,4 :: 		TrisD=0x00;
	CLRF       TRISD+0
;bluetooth.c,5 :: 		portd=0x00;
	CLRF       PORTD+0
;bluetooth.c,6 :: 		UART1_Init(9600);
	MOVLW      129
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;bluetooth.c,7 :: 		Delay_ms(100);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	DECFSZ     R11+0, 1
	GOTO       L_main0
	NOP
	NOP
;bluetooth.c,8 :: 		portd.rd6=1;
	BSF        PORTD+0, 6
;bluetooth.c,17 :: 		do
L_main1:
;bluetooth.c,19 :: 		if(UART1_Data_Ready())
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main4
;bluetooth.c,21 :: 		data1 = UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _data1+0
;bluetooth.c,22 :: 		portd.rd7=1;
	BSF        PORTD+0, 7
;bluetooth.c,23 :: 		delay_ms(1000);
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	DECFSZ     R11+0, 1
	GOTO       L_main5
	NOP
;bluetooth.c,24 :: 		portd.rd7=0;
	BCF        PORTD+0, 7
;bluetooth.c,25 :: 		delay_ms(1000);
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_main6:
	DECFSZ     R13+0, 1
	GOTO       L_main6
	DECFSZ     R12+0, 1
	GOTO       L_main6
	DECFSZ     R11+0, 1
	GOTO       L_main6
	NOP
;bluetooth.c,28 :: 		if (data1=='1') {
	MOVF       _data1+0, 0
	XORLW      49
	BTFSS      STATUS+0, 2
	GOTO       L_main7
;bluetooth.c,29 :: 		if(Portd.rd0==0)
	BTFSC      PORTD+0, 0
	GOTO       L_main8
;bluetooth.c,30 :: 		Portd.rd0=1  ;
	BSF        PORTD+0, 0
	GOTO       L_main9
L_main8:
;bluetooth.c,32 :: 		Portd.rd0=0  ;
	BCF        PORTD+0, 0
L_main9:
;bluetooth.c,33 :: 		}
L_main7:
;bluetooth.c,34 :: 		if (data1=='2') {
	MOVF       _data1+0, 0
	XORLW      50
	BTFSS      STATUS+0, 2
	GOTO       L_main10
;bluetooth.c,35 :: 		if(Portd.rd1==0)
	BTFSC      PORTD+0, 1
	GOTO       L_main11
;bluetooth.c,36 :: 		Portd.rd1=1  ;
	BSF        PORTD+0, 1
	GOTO       L_main12
L_main11:
;bluetooth.c,38 :: 		Portd.rd1=0  ;
	BCF        PORTD+0, 1
L_main12:
;bluetooth.c,39 :: 		}
L_main10:
;bluetooth.c,40 :: 		if (data1=='3') {
	MOVF       _data1+0, 0
	XORLW      51
	BTFSS      STATUS+0, 2
	GOTO       L_main13
;bluetooth.c,41 :: 		if(Portd.rd2==0)
	BTFSC      PORTD+0, 2
	GOTO       L_main14
;bluetooth.c,42 :: 		Portd.rd2=1  ;
	BSF        PORTD+0, 2
	GOTO       L_main15
L_main14:
;bluetooth.c,44 :: 		Portd.rd2=0  ;
	BCF        PORTD+0, 2
L_main15:
;bluetooth.c,45 :: 		}
L_main13:
;bluetooth.c,46 :: 		if (data1=='4') {
	MOVF       _data1+0, 0
	XORLW      52
	BTFSS      STATUS+0, 2
	GOTO       L_main16
;bluetooth.c,47 :: 		if(Portd.rd3==0)
	BTFSC      PORTD+0, 3
	GOTO       L_main17
;bluetooth.c,48 :: 		Portd.rd3=1  ;
	BSF        PORTD+0, 3
	GOTO       L_main18
L_main17:
;bluetooth.c,50 :: 		Portd.rd3=0  ;
	BCF        PORTD+0, 3
L_main18:
;bluetooth.c,51 :: 		}
L_main16:
;bluetooth.c,52 :: 		if (data1=='5') {
	MOVF       _data1+0, 0
	XORLW      53
	BTFSS      STATUS+0, 2
	GOTO       L_main19
;bluetooth.c,53 :: 		if(Portd.rd4==0)
	BTFSC      PORTD+0, 4
	GOTO       L_main20
;bluetooth.c,54 :: 		Portd.rd4=1  ;
	BSF        PORTD+0, 4
	GOTO       L_main21
L_main20:
;bluetooth.c,56 :: 		Portd.rd4=0  ;
	BCF        PORTD+0, 4
L_main21:
;bluetooth.c,57 :: 		}
L_main19:
;bluetooth.c,64 :: 		}
L_main4:
;bluetooth.c,70 :: 		while(1)   ;
	GOTO       L_main1
;bluetooth.c,71 :: 		}
	GOTO       $+0
; end of _main
