
_Delay_onesec:

;serialmatrix2.c,12 :: 		void Delay_onesec(){
;serialmatrix2.c,13 :: 		Delay_ms(1000);
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_Delay_onesec0:
	DECFSZ     R13+0, 1
	GOTO       L_Delay_onesec0
	DECFSZ     R12+0, 1
	GOTO       L_Delay_onesec0
	DECFSZ     R11+0, 1
	GOTO       L_Delay_onesec0
	NOP
;serialmatrix2.c,14 :: 		}
	RETURN
; end of _Delay_onesec

_main:

;serialmatrix2.c,21 :: 		void main() {
;serialmatrix2.c,22 :: 		CMCON = 0x07;   // Disable comparators
	MOVLW      7
	MOVWF      CMCON+0
;serialmatrix2.c,24 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;serialmatrix2.c,25 :: 		TRISC = 0x80;
	MOVLW      128
	MOVWF      TRISC+0
;serialmatrix2.c,26 :: 		TRISB = 0x00;
	CLRF       TRISB+0
;serialmatrix2.c,27 :: 		TRISA = 0x00;
	CLRF       TRISA+0
;serialmatrix2.c,28 :: 		TRISE = 0x01;
	MOVLW      1
	MOVWF      TRISE+0
;serialmatrix2.c,29 :: 		PORTA=0x00;
	CLRF       PORTA+0
;serialmatrix2.c,30 :: 		PORTB=0x00;
	CLRF       PORTB+0
;serialmatrix2.c,31 :: 		PORTD=0x00;
	CLRF       PORTD+0
;serialmatrix2.c,32 :: 		PORTC=0x00;
	CLRF       PORTC+0
;serialmatrix2.c,33 :: 		PORTE=0x00;
	CLRF       PORTE+0
;serialmatrix2.c,36 :: 		UART1_Init(19200);               // Initialize UART module at 9600 bps
	MOVLW      64
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;serialmatrix2.c,37 :: 		Delay_ms(100);                  // Wait for UART module to stabilize
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
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
;serialmatrix2.c,40 :: 		while (1) {                     // Endless loop
L_main2:
;serialmatrix2.c,41 :: 		if (UART1_Data_Ready()) {     // If data is received,
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main4
;serialmatrix2.c,42 :: 		for (i=0; i<5; i++)
	CLRF       _i+0
L_main5:
	MOVLW      5
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main6
;serialmatrix2.c,44 :: 		if(UART1_Read()==13)
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	XORLW      13
	BTFSS      STATUS+0, 2
	GOTO       L_main8
;serialmatrix2.c,45 :: 		{   PORTD  =Buffer[0];
	MOVF       _Buffer+0, 0
	MOVWF      PORTD+0
;serialmatrix2.c,46 :: 		PORTB=Buffer[1];
	MOVF       _Buffer+1, 0
	MOVWF      PORTB+0
;serialmatrix2.c,47 :: 		PORTA  =Buffer[2];
	MOVF       _Buffer+2, 0
	MOVWF      PORTA+0
;serialmatrix2.c,48 :: 		PORTC  =Buffer[3];
	MOVF       _Buffer+3, 0
	MOVWF      PORTC+0
;serialmatrix2.c,49 :: 		i=0;
	CLRF       _i+0
;serialmatrix2.c,50 :: 		break;
	GOTO       L_main6
;serialmatrix2.c,51 :: 		}
L_main8:
;serialmatrix2.c,52 :: 		Buffer[i] = UART1_Read();     // read the received data,
	MOVF       _i+0, 0
	ADDLW      _Buffer+0
	MOVWF      FLOC__main+0
	CALL       _UART1_Read+0
	MOVF       FLOC__main+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;serialmatrix2.c,42 :: 		for (i=0; i<5; i++)
	INCF       _i+0, 1
;serialmatrix2.c,53 :: 		}
	GOTO       L_main5
L_main6:
;serialmatrix2.c,54 :: 		}
L_main4:
;serialmatrix2.c,57 :: 		}
	GOTO       L_main2
;serialmatrix2.c,59 :: 		}
	GOTO       $+0
; end of _main
