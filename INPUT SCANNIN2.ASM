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
DELAYP5	CLRF	TMR0
LOOPA	MOVF	TMR0,W
	SUBLW	.16
	BTFSS	STATUS,ZEROBIT
	GOTO	LOOPA
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

LIGHT0	BSF		PORTB,1
		BSF		PORTB,2
		BSF		PORTB,3
		CALL	DELAYP25
		BCF		PORTB,1
		BCF		PORTB,2
		BCF		PORTB,3
		CALL	DELAYP25
		RETLW	0
LIGHT1	BSF		PORTB,0
		BSF		PORTB,2
		BSF		PORTB,3
		CALL	DELAYP25
		BCF		PORTB,0
		BCF		PORTB,2
		BCF		PORTB,3
		CALL	DELAYP25
		RETLW	0
LIGHT2	BSF		PORTB,1
		BSF		PORTB,0
		BSF		PORTB,3
		CALL	DELAYP25
		BCF		PORTB,1
		BCF		PORTB,0
		BCF		PORTB,3
		CALL	DELAYP25
		RETLW	0
LIGHT3	BSF		PORTB,1
		BSF		PORTB,2
		BSF		PORTB,0
		CALL	DELAYP25
		BCF		PORTB,1
		BCF		PORTB,2
		BCF		PORTB,0
		CALL	DELAYP25
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
SW0		BTFSC	PORTA,0
		GOTO	TURN0
		BCF		PORTB,0
		
SW1		BTFSC	PORTA,1
		GOTO	TURN1
		BCF		PORTB,1

SW2		BTFSC	PORTA,2
		GOTO	TURN2
		BCF		PORTB,2
SW3		BTFSC	PORTA,3
		GOTO	TURN3
		BCF		PORTB,3
		GOTO	SW0

TURN0	BSF		PORTB,0
		CALL	LIGHT0
		GOTO	SW1
TURN1	BSF		PORTB,1
		CALL	LIGHT1
		GOTO	SW2
TURN2	BSF		PORTB,2
		CALL	LIGHT2
		GOTO	SW3
TURN3	BSF		PORTB,3
		CALL	LIGHT3
		GOTO	SW0
		END


