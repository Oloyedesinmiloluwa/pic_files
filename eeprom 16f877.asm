TMR0 		EQU 1 		;means TMR0 is file 1.
STATUS 		EQU 3 		;means STATUS is file 3.
PORTA 		EQU 5 		;means PORTA is file 5.
PORTB 		EQU 6 	
PORTC		EQU	7
PORTD		EQU	8
PORTE		EQU	9

TRISA 		EQU 85H 	;TRISA (the PORTA I/O selection) is file 85H
TRISB 		EQU 86H 	;TRISB (the PORTB I/O selection) is file 86H
TRISC		EQU	87H
TRISD		EQU	88H
TRISE		EQU	89H
OPTION_R 	EQU 81H 	;the OPTION register is file 81H
ZEROBIT 	EQU 2 		;means ZEROBIT is bit 2.
COUNT 		EQU 0CH 	; COUNT is file 0C, a register to count events.
STORE		EQU	0DH
EEDATA		EQU	0CH
EEADR		EQU	0DH
EECON1		EQU	8CH
EECON2		EQU	8DH
RD			EQU	0
WR			EQU	1
WREN		EQU	2
WRERR		EQU 3
INTCON		EQU 0BH
GIE			EQU 7
;*********************************************************
LIST 	P=16F877 ;we are using the 16F84.
ORG 	0 	;the start address in memory is 0
GOTO 	START ;goto start!
;******************************************************************
; Configuration Bits
__CONFIG H'3F3A' ;selects LP oscillator, WDT off, PUT on,
;Code Protection disabled.
;*****************************************************
;SUBROUTINE SECTION.
DELAYP1	CLRF	TMR0
LOOPA	MOVF	TMR0,W
		SUBLW	.2
		BTFSS	STATUS,ZEROBIT
		GOTO	LOOPA
		RETLW	0
READ	BSF		STATUS,6
	;	MOVLW	0
		MOVF	STORE,W
		MOVWF	EEADR
		BSF		STATUS,5
		BSF		STATUS,6
		BSF		EECON1,RD
		BCF		STATUS,5
	
		MOVF	EEDATA,W
		BCF		STATUS,6
		MOVWF	COUNT
		RETLW	0
WRITE	BSF		STATUS,5	;BANK3
		BSF		STATUS,6
	;	BCF		INTCON,GIE
		BSF		EECON1,WREN
		BCF		STATUS,5	;BANK2
		BCF		STATUS,6
		MOVF	COUNT,W
		BSF		STATUS,6
		MOVWF	EEDATA
	;	MOVLW	0
		MOVF	STORE,W
		MOVWF	EEADR
		BSF		STATUS,5	;BANK3
		
		MOVLW	55H
		MOVWF	EECON2
		MOVLW	0AAH
		MOVWF	EECON2
		BSF		EECON1,WR
		
 DONE	BTFSC	EECON1,WR
		GOTO	DONE
		
		BCF		EECON1,WREN
		BCF		STATUS,5
		BCF		STATUS,6

		RETLW	0
		
	
		
;*********************************************************
;CONFIGURATION SECTION.
START 	BSF 	STATUS,5 ;Turns to Bank1.
		MOVLW 	B'00011111' 	;5bits of PORTA are I/P
		MOVWF 	TRISA
		MOVLW 	B'00000000'
		MOVWF 	TRISB 
		MOVLW 	B'00000011'
		MOVWF 	TRISE 		;PORTB is OUTPUT
		MOVLW 	B'00000111' 	;Prescaler is /256
		MOVWF 	OPTION_R 	;TIMER is 1/32 secs.
		BCF 	STATUS,5 	;Return to Bank0.
		CLRF 	PORTA 		;Clears PortA.
		CLRF 	PORTB 		;Clears PortB.
		CLRF	PORTC
		MOVLW	1
		MOVWF	STORE
		;CLRF	COUNT
;PROGRAM STARTS
		CALL	READ
		MOVF	COUNT,W
		MOVWF	PORTB
		CALL	DELAYP1
		CLRF	PORTB
		CALL	DELAYP1
	;	GOTO	AD
		
PRESS	BTFSS	PORTC,0
		GOTO	PRESS
		CALL	DELAYP1
RE LEASE	BTFSC	PORTC,0
		GOTO	RELEASE
		CALL	DELAYP1
		INCF	COUNT
AD		MOVF	COUNT,W
	;	CALL	WRITE
	MOVWF	PORTB
		CALL	DELAYP1
		CLRF	PORTB
		CALL	DELAYP1
		GOTO	AD
		GOTO	PRESS	
		END