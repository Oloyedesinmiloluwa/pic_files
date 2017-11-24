;HEADER FOR 16F84
STATUS	EQU	3
PORTA	EQU	5
PORTB	EQU	6
TMR0	EQU	1
TRISA	EQU	85H
TRISB	EQU	86H
ZEROBIT	EQU	2
COUNT	EQU	0CH
OPTION_R EQU	81H

	LIST P=16F84
	ORG 0
	GOTO	START

__CONFIG H'3FF0'

;SUBROUTINE SECTION
;3/32 second delay.
	DELAY CLRF TMR0 ;START TMR0.
LOOPA MOVF TMR0,W ;READ TMR0 INTO W.
	SUBLW .3 ;TIME - 3
	BTFSS STATUS, ZEROBIT ;Check TIME-W�0
	GOTO LOOPA ;Time is not�3.
RETLW 0 ;Time is 3, return.

DELAYP1	CLRF	TMR0
LOOPQ	MOVF	TMR0,W
	SUBLW	.3
	BTFSS	STATUS,ZEROBIT
	GOTO	LOOPQ
	RETLW	0



DELAYP25 CLRF	TMR0
LOOPB	MOVF	TMR0,W
	SUBLW	.8
	BTFSS	STATUS,ZEROBIT
	GOTO	LOOPB
	RETLW	0

DELAY1	CLRF	TMR0
LOOPC	MOVF	TMR0,W
	SUBLW	.32
	BTFSS	STATUS,ZEROBIT
	GOTO	LOOPC
	RETLW	0
DELAY125 CLRF	TMR0
LOOPD	MOVF	TMR0,W
	SUBLW	.4
	BTFSS	STATUS,ZEROBIT
	GOTO	LOOPD
	RETLW	0
DELAY2	MOVLW	.2
	MOVWF	COUNT
DEC	CALL	DELAY1
	DECFSZ	COUNT
	GOTO	DEC																						
	RETLW	0
	
	;CONFIGURATION SECTION
START	BSF	STATUS,5
	MOVLW	B'00000111'
	MOVWF	TRISA
	MOVLW	B'00000000'
	MOVWF	TRISB
	MOVLW	B'00000111'
	MOVWF	OPTION_R
	BCF	STATUS,5
	CLRF	PORTA
	CLRF	PORTB

;PROGRAM STARTS NOW
BEGIN	MOVLW	.4
		MOVWF	COUNT
CHECK	BTFSS	PORTA,0
		GOTO	CHECK
		CALL	DELAYP1
		BCF		PORTB,0
CHECK1	BTFSC	PORTA,0
		GOTO	CHECK1
		CALL	DELAYP1
		DECFSZ	COUNT
		GOTO	CHECK
		BSF		PORTB,0
		BCF		PORTB,1
	
		GOTO	BEGIN
END