
_Delay_onesec:

;ledc2matrix.c,12 :: 		void Delay_onesec(){
;ledc2matrix.c,13 :: 		Delay_ms(1000);
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
;ledc2matrix.c,14 :: 		}
	RETURN
; end of _Delay_onesec

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;ledc2matrix.c,19 :: 		void interrupt()
;ledc2matrix.c,21 :: 		if(PIR1.CCP1IF);
	BTFSS      PIR1+0, 2
	GOTO       L_interrupt1
L_interrupt1:
;ledc2matrix.c,23 :: 		flag=2;
	MOVLW      2
	MOVWF      _flag+0
;ledc2matrix.c,25 :: 		PIR1.CCP1IF=0;
	BCF        PIR1+0, 2
;ledc2matrix.c,34 :: 		}
L__interrupt6:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;ledc2matrix.c,35 :: 		void main() {
;ledc2matrix.c,36 :: 		CMCON = 0x07;   // Disable comparators
	MOVLW      7
	MOVWF      CMCON+0
;ledc2matrix.c,37 :: 		OPTION_REG  =0x05;
	MOVLW      5
	MOVWF      OPTION_REG+0
;ledc2matrix.c,38 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;ledc2matrix.c,39 :: 		TRISC = 0x04;
	MOVLW      4
	MOVWF      TRISC+0
;ledc2matrix.c,40 :: 		TRISB = 0x00;
	CLRF       TRISB+0
;ledc2matrix.c,41 :: 		TRISA = 0x00;
	CLRF       TRISA+0
;ledc2matrix.c,42 :: 		TRISE = 0x01;
	MOVLW      1
	MOVWF      TRISE+0
;ledc2matrix.c,43 :: 		PORTA=0x00;
	CLRF       PORTA+0
;ledc2matrix.c,44 :: 		PORTB=0x00;
	CLRF       PORTB+0
;ledc2matrix.c,45 :: 		PORTD=0x00;
	CLRF       PORTD+0
;ledc2matrix.c,46 :: 		PORTC=0x00;
	CLRF       PORTC+0
;ledc2matrix.c,47 :: 		PORTE=0x00;
	CLRF       PORTE+0
;ledc2matrix.c,48 :: 		INTCON = 0;
	CLRF       INTCON+0
;ledc2matrix.c,49 :: 		PIE1 =  0b00000100;
	MOVLW      4
	MOVWF      PIE1+0
;ledc2matrix.c,50 :: 		CCP1CON =0x04;
	MOVLW      4
	MOVWF      CCP1CON+0
;ledc2matrix.c,51 :: 		INTCON = 0b11000000;
	MOVLW      192
	MOVWF      INTCON+0
;ledc2matrix.c,52 :: 		PIR1.CCP1IF=0;
	BCF        PIR1+0, 2
;ledc2matrix.c,57 :: 		do
L_main2:
;ledc2matrix.c,59 :: 		portd++   ;
	INCF       PORTD+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      PORTD+0
;ledc2matrix.c,60 :: 		delay_ms(1000)    ;
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
;ledc2matrix.c,63 :: 		while(1==1);
	GOTO       L_main2
;ledc2matrix.c,129 :: 		}
	GOTO       $+0
; end of _main
