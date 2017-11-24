; HEADER84.ASM for 16F84. This sets PORTA as an INPUT 
; and PORTB as an OUTPUT (NB 0 means output).
;The OPTION Register is set to /256 to give timing pulses of 1/32 of a second.
;1second and 0.5 second delays are included in the subroutine section.
;*******************************************************
; EQUATES SECTION
TMR0 		EQU 1 		;means TMR0 is file 1.
STATUS 		EQU 3 		;means STATUS is file 3.
PORTA 		EQU 5 		;means PORTA is file 5.
PORTB 		EQU 6 		;means PORTB is file 6.
TRISA 		EQU 85H 	;TRISA (the PORTA I/O selection) is file 85H
TRISB 		EQU 86H 	;TRISB (the PORTB I/O selection) is file 86H
OPTION_R 	EQU 81H 	;the OPTION register is file 81H
ZEROBIT 	EQU 2 		;means ZEROBIT is bit 2.
COUNT 		EQU 0CH 	; COUNT is file 0C, a register to count events.
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
; 1 second delay.
DELAY1 	CLRF 	TMR0 	;START TMR0.
LOOPA 	MOVF 	TMR0,W 	;READ TMR0 INTO W.
		SUBLW 	.32 	;TIME - 32
		BTFSS 	STATUS,ZEROBIT ; Check TIME-W�0
		GOTO 	LOOPA 	;Time is not�32.
		RETLW 	0 		;Time is 32, return.
; 0.5 second delay.

DELAYP5 CLRF 	TMR0 	;START TMR0.
LOOPB 	MOVF 	TMR0,W 	;READ TMR0 INTO W.
		SUBLW 	.16 	;TIME - 16
		BTFSS 	STATUS,ZEROBIT ; Check TIME-W�0
		GOTO 	LOOPB 	;Time is not�16.
		RETLW 	0 	;Time is 16, return.
;*********************************************************
;CONFIGURATION SECTION.
START 	BSF 	STATUS,5 ;Turns to Bank1.
		MOVLW 	B'00000000' 	;5bits of PORTA are I/P
		MOVWF 	TRISA
		MOVLW 	B'11111111'
		MOVWF 	TRISB 		;PORTB is OUTPUT
		MOVLW 	B'00000111' 	;Prescaler is /256
		MOVWF 	OPTION_R 	;TIMER is 1/32 secs.
		BCF 	STATUS,5 	;Return to Bank0.
		CLRF 	PORTA 		;Clears PortA.
		CLRF 	PORTB 		;Clears PortB.
;*********************************************************
;Program starts now.
TEST0	MOVF	PORTB,W
		SUBLW	B'00000000'
		BTFSC	STATUS,ZEROBIT
		GOTO	COND1
TEST1	MOVF	PORTB,W
		SUBLW	B'00000001'
		BTFSC	STATUS,ZEROBIT
		GOTO	COND2
TEST2	MOVF	PORTB,W
		SUBLW	B'00000010'
		BTFSC	STATUS,ZEROBIT
		GOTO	COND3
TEST3	MOVF	PORTB,W
		SUBLW	B'00000011'
		BTFSC	STATUS,ZEROBIT
		GOTO	COND4
		GOTO	TEST0
COND1	BCF		PORTA,0
		BSF		PORTA,1
		GOTO	TEST1
COND2	BSF		PORTA,0
		BCF		PORTA,1
		GOTO	TEST2
COND3	BSF		PORTA,0
		BSF		PORTA,1
		GOTO	TEST3
COND4	BSF		PORTA,0
		BCF		PORTA,1
		GOTO	TEST0
END