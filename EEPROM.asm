TMR0 		EQU 1 		;means TMR0 is file 1.
STATUS 		EQU 3 		;means STATUS is file 3.
PORTA 		EQU 5 		;means PORTA is file 5.
PORTB 		EQU 6 		;means PORTB is file 6.
TRISA 		EQU 85H 	;TRISA (the PORTA I/O selection) is file 85H
TRISB 		EQU 86H 	;TRISB (the PORTB I/O selection) is file 86H
OPTION_R 	EQU 81H 	;the OPTION register is file 81H
ZEROBIT 	EQU 2 		;means ZEROBIT is bit 2.
COUNT 		EQU 0CH 	; COUNT is file 0C, a register to count events.
EEDATA		EQU	8
EEADR		EQU	9
EECON1		EQU	8
EECON2		EQU	9
RD			EQU	0
WR			EQU	1
WREN		EQU	2
;*********************************************************
LIST 	P=16F84 ;we are using the 16F84.
ORG 	0 	;the start address in memory is 0
GOTO 	START ;goto start!
;******************************************************************
; Configuration Bits
__CONFIG H'3FF0' ;selects LP oscillator, WDT off, PUT on,
;Code Protection disabled.
;*****************************************************
;SUBROUTINE SECTION.
DELAYP1	CLRF	TMR0
LOOPA	MOVF	TMR0,W
		SUBLW	.3
		BTFSS	STATUS,ZEROBIT
		GOTO	LOOPA
		RETLW	0
READ	MOVLW	0
		MOVWF	EEADR
		BSF		STATUS,5
		BSF		EECON1,RD
		BCF		STATUS,5
		MOVF	EEDATA,W
		MOVWF	COUNT
		RETLW	0
WRITE	BSF		STATUS,5
		BSF		EECON1,WREN
		BCF		STATUS,5
		MOVF	COUNT,W
		MOVWF	EEDATA
		MOVLW	0
		MOVWF	EEADR
		BSF		STATUS,5
		MOVLW	55H
		MOVWF	EECON2
		MOVLW	0AAH
		MOVWF	EECON2
		BSF		EECON1,WR
;DONE	BTFSC	EECON1,WR
		;GOTO	DONE
		BCF		EECON1,WREN
		BCF		STATUS,5
		RETLW	0
		
	
		
;*********************************************************
;CONFIGURATION SECTION.
START 	BSF 	STATUS,5 ;Turns to Bank1.
		MOVLW 	B'00011111' 	;5bits of PORTA are I/P
		MOVWF 	TRISA
		MOVLW 	B'00000000'
		MOVWF 	TRISB 		;PORTB is OUTPUT
		MOVLW 	B'00000111' 	;Prescaler is /256
		MOVWF 	OPTION_R 	;TIMER is 1/32 secs.
		BCF 	STATUS,5 	;Return to Bank0.
		CLRF 	PORTA 		;Clears PortA.
		CLRF 	PORTB 		;Clears PortB.
;PROGRAM STARTS
		CALL	READ
		MOVF	COUNT,W
		MOVWF	PORTB
PRESS	BTFSS	PORTA,0
		GOTO	PRESS
		CALL	DELAYP1
RELEASE	BTFSC	PORTA,0
		GOTO	RELEASE
		CALL	DELAYP1
		INCF	COUNT
		MOVF	COUNT,W
		MOVWF	PORTB
		CALL	WRITE	
		GOTO	PRESS	
		END