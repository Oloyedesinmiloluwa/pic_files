
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;interrupt.c,19 :: 		void interrupt()
;interrupt.c,21 :: 		datr ++;
	INCF       _datr+0, 1
;interrupt.c,22 :: 		if(datr==3)
	MOVF       _datr+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt0
;interrupt.c,25 :: 		PORTD.b1=1;
	BSF        PORTD+0, 1
;interrupt.c,26 :: 		PORTC.rd0=1;
	BSF        PORTC+0, 0
;interrupt.c,28 :: 		}
L_interrupt0:
;interrupt.c,31 :: 		PIR1.CCP1IF=0;
	BCF        PIR1+0, 2
;interrupt.c,32 :: 		}
L__interrupt4:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;interrupt.c,33 :: 		void main()
;interrupt.c,35 :: 		CMCON = 0x07;   // Disable comparators
	MOVLW      7
	MOVWF      CMCON+0
;interrupt.c,36 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;interrupt.c,37 :: 		TRISC = 0x00;
	CLRF       TRISC+0
;interrupt.c,39 :: 		TRISB  = 0b00000000;  // PORTB is now all output
	CLRF       TRISB+0
;interrupt.c,40 :: 		PORTB=0x00;
	CLRF       PORTB+0
;interrupt.c,41 :: 		PORTD=0x00;
	CLRF       PORTD+0
;interrupt.c,42 :: 		PORTC=0x00;
	CLRF       PORTC+0
;interrupt.c,43 :: 		delay_ms(100);
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
;interrupt.c,44 :: 		PIE1 =  0b00000100;
	MOVLW      4
	MOVWF      PIE1+0
;interrupt.c,45 :: 		CCP1CON =0x04;
	MOVLW      4
	MOVWF      CCP1CON+0
;interrupt.c,46 :: 		INTCON = 0b11000000;
	MOVLW      192
	MOVWF      INTCON+0
;interrupt.c,47 :: 		PIR1.CCP1IF=0;
	BCF        PIR1+0, 2
;interrupt.c,48 :: 		while(1==1)  ;
L_main2:
	GOTO       L_main2
;interrupt.c,50 :: 		}
	GOTO       $+0
; end of _main
