TMR0	EQU	1
STATUS	EQU	3
PORTA	EQU	5
PORTB	EQU	6
ZEROBIT	EQU	2
TRISA	EQU	85H
TRISB	EQU	86H
OPTION_R EQU	81H
OSCCON	EQU	8FH
COUNT	EQU	20H
A1		EQU	21H
A2		EQU	22H
A3		EQU	23H
A4		EQU	24H
A5		EQU	25H
DISP1	EQU	26H
DISP2	EQU	27H
DISP3	EQU	28H
DISP4	EQU	29H
DISP5	EQU	30H
STILL	EQU	31H

	LIST	P=16F818	
	ORG		0
	GOTO	START

	__CONFIG H'3F10'

;SUBROUTINE
;1 second delay.
DELAYP5 CLRF TMR0 ;START TMR0.
LOOPB MOVF TMR0,W ;READ TMR0 INTO W.
		SUBLW .5 ;TIME-3
	BTFSS STATUS,ZEROBIT ;Check TIME-W � 0
	GOTO LOOPB ;Time is not � 3.
	NOP ;add extra delay
	NOP
	RETLW 0
DELAY3 CLRF TMR0 ;START TMR0.
LOOPC MOVF TMR0,W ;READ TMR0 INTO W.
		SUBLW .170 ;TIME-3
	BTFSS STATUS,ZEROBIT ;Check TIME-W � 0
	GOTO LOOPC ;Time is not � 3.
	NOP ;add extra delay
	NOP
	RETLW 0
SCANNING	
			MOVF	DISP1,W
			MOVWF	PORTB
			MOVLW	B'00000001'
			MOVWF	PORTA
			CALL	DELAYP5
			CLRF	PORTA
			MOVF	DISP2,W
			MOVWF	PORTB
			MOVLW	B'00000010'
			MOVWF	PORTA
			CALL	DELAYP5
			CLRF	PORTA
			MOVF	DISP3,W
			MOVWF	PORTB
			MOVLW	B'00000100'
			MOVWF	PORTA
			CALL	DELAYP5
			CLRF	PORTA
			MOVF	DISP4,W
			MOVWF	PORTB
			MOVLW	B'00001000'
			MOVWF	PORTA
			CALL	DELAYP5
			CLRF	PORTA
			MOVF	DISP5,W
			MOVWF	PORTB
			MOVLW	B'00010000'
			MOVWF	PORTA
			CALL	DELAYP5
			CLRF	PORTA
			
			GOTO	BACK2
WHILE1	
	MOVF	A1,W
	MOVWF	DISP1

	MOVF	A2,W
	MOVWF	A1
	MOVF	A3,W
	MOVWF	A2
	MOVF	A4,W
	MOVWF	A3
	MOVF	A5,W
	MOVWF	A4
	MOVLW	.255
	MOVWF	A5
	MOVLW	.50
	MOVWF	STILL
BACK2	DECFSZ	STILL
	GOTO	SCANNING
		MOVF	DISP4,W
			MOVWF	DISP5
			MOVF	DISP3,W
			MOVWF	DISP4
			MOVF	DISP2,W
			MOVWF	DISP3
			MOVF	DISP1,W
			MOVWF	DISP2
	
START BSF STATUS,5 
	MOVLW B'11100000' ;8 bits of PORTA are I/P
	MOVWF TRISA
	MOVLW B'00000000'
	MOVWF TRISB ;PORTB is OUTPUT

	MOVLW B'00000011' ;Prescaler is /256
	MOVWF OPTION_R ;TIMER is 1/32 secs.
	BCF STATUS,5 ;Return to Bank0.
	CLRF PORTA ;Clears PortA.
	CLRF PORTB
	CLRF DISP1
	CLRF DISP2
	CLRF DISP3
	CLRF DISP4
	CLRF DISP5
;PROGRAM STARTS
REPEAT	MOVLW	0C1H
	MOVWF	A1
	MOVLW	0B7H
	MOVWF	A2
	MOVLW	77H
	MOVWF	A3
	MOVLW	0B7H
	MOVWF	A4
	MOVLW	0C1H
	MOVWF	A5
HERE	MOVF	A1,W
	MOVWF	PORTB
	MOVLW	B'00010000'
			MOVWF	PORTA
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			MOVF	A2,W
			MOVWF	PORTB
			MOVLW	B'00001000'
			MOVWF	PORTA
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			MOVF	A3,W
			MOVWF	PORTB
			MOVLW	B'00000100'
			MOVWF	PORTA
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			MOVF	A4,W
			MOVWF	PORTB
			MOVLW	B'00000010'
			MOVWF	PORTA
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			MOVF	A5,W
			MOVWF	PORTB
			MOVLW	B'00000001'
			MOVWF	PORTA
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			GOTO	HERE
			
	END