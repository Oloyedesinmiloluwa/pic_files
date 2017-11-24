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
		BTFSS 	STATUS,ZEROBIT ; Check TIME-W¼0
		GOTO 	LOOPA 	;Time is not¼32.
		RETLW 	0 		;Time is 32, return.
; 0.5 second delay.

DELAYP5 CLRF 	TMR0 	;START TMR0.
LOOPB 	MOVF 	TMR0,W 	;READ TMR0 INTO W.
		SUBLW 	.16 	;TIME - 16
		BTFSS 	STATUS,ZEROBIT ; Check TIME-W¼0
		GOTO 	LOOPB 	;Time is not¼16.
		RETLW 	0 	;Time is 16, return.
;*********************************************************
;CONFIGURATION SECTION.
START 	BSF 	STATUS,5 ;Turns to Bank1.
		MOVLW 	B'00000000' 	;5bits of PORTA are I/P
		MOVWF 	TRISA
		MOVLW 	B'11111000'
		MOVWF 	TRISB 		;PORTB is OUTPUT
		MOVLW 	B'00000111' 	;Prescaler is /256
		MOVWF 	OPTION_R 	;TIMER is 1/32 secs.
		BCF 	STATUS,5 	;Return to Bank0.
		CLRF 	PORTA 		;Clears PortA.
		CLRF 	PORTB 		;Clears PortB.
;*********************************************************
COL1	BCF		PORTB,0
		BSF		PORTB,1
		BSF		PORTB,2
TEST1	BTFSS	PORTB,3
		GOTO	SET1
TEST4	BTFSS	PORTB,4
		GOTO	SET4
TEST7	BTFSS	PORTB,5
		GOTO	SET7
TEST11	BTFSS	PORTB,6
		GOTO	SET11
COL2	BCF		PORTB,1
		BSF		PORTB,0
		BSF		PORTB,2
TEST2	BTFSS	PORTB,3
		GOTO	SET2
TEST5	BTFSS	PORTB,4
		GOTO	SET5
TEST8	BTFSS	PORTB,5
		GOTO	SET8
TEST10	BTFSS	PORTB,6
		GOTO	SET10
COL3	BCF		PORTB,2
		BSF		PORTB,0
		BSF		PORTB,1
TEST3	BTFSS	PORTB,3
		GOTO	SET3
TEST6	BTFSS	PORTB,4
		GOTO	SET6
TEST9	BTFSS	PORTB,5
		GOTO	SET9
TEST12	BTFSS	PORTB,6
		GOTO	SET12	
		GOTO	COL1
SET1	MOVLW	.1
		MOVWF	PORTA
		GOTO 	TEST4
SET4	MOVLW	.4
		MOVWF	PORTA
		GOTO 	TEST7
SET7	MOVLW	.7
		MOVWF	PORTA
		GOTO 	TEST11
SET11	MOVLW	.11
		MOVWF	PORTA
		GOTO 	COL2
SET2	MOVLW	.2
		MOVWF	PORTA
		GOTO 	TEST4
SET5	MOVLW	.5
		MOVWF	PORTA
		GOTO 	TEST7
SET8	MOVLW	.8
		MOVWF	PORTA
		GOTO 	TEST11
SET10	MOVLW	.10
		MOVWF	PORTA
		GOTO 	COL3
SET3	MOVLW	.3
		MOVWF	PORTA
		GOTO 	TEST4
SET6	MOVLW	.6
		MOVWF	PORTA
		GOTO 	TEST7
SET9	MOVLW	.9
		MOVWF	PORTA
		GOTO 	TEST11
SET12	MOVLW	.12
		MOVWF	PORTA
		GOTO 	COL1
		END