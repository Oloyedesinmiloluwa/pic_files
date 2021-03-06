TMR0	EQU	1
PC		EQU	2
STATUS	EQU	3
PORTA	EQU	5
PORTB	EQU	6
PORTC	EQU	7
PORTD	EQU	8
PORTE	EQU	9
TRISA	EQU	85H
TRISB	EQU	86H
TRISC	EQU	87H
TRISD	EQU	88H
TRISE	EQU	89H
OPTION_R	EQU 81H
ZEROBIT	EQU	2
COUNT	EQU	20H
C1		EQU	21H
C2		EQU	22H
C3		EQU	23H
C4		EQU	24H
C5		EQU	25H
DISP1	EQU	26H
DISP2	EQU	27H
DISP3	EQU	28H
DISP4	EQU	29H
DISP5	EQU	30H
DISP6	EQU	31H
DISP7	EQU	32H	
DISP8	EQU	33H
DISP9	EQU	34H
DISP10	EQU	35H
DISP11	EQU	36H
DISP12	EQU	37H
DISP13	EQU	38H
DISP14	EQU	39H
DISP15	EQU	40H
DISP16	EQU	41H
DISP17	EQU	42H	
DISP18	EQU	43H
DISP19	EQU	44H
DISP20	EQU	45H
DISP21	EQU	46H
DISP22	EQU	47H
DISP23	EQU	48H
DISP24	EQU	49H
DISP25	EQU	50H
DISP26	EQU	51H
DISP27	EQU	52H	
DISP28	EQU	53H
DISP29	EQU	54H
DISP30	EQU	55H
DISP31	EQU	56H
DISP32		EQU	57H
DISP33		EQU	58H
DISP34		EQU	59H
DISP35		EQU	60H
DISP36		EQU	61H
DISP37		EQU	62H
DISP38		EQU	63H
DISP39		EQU	64H
DISP40		EQU	65H
STILL	EQU	66H
COUNT1	EQU	67H
DISP	EQU	68H
CCP1CON	EQU	17H
INTCON	EQU 0BH
GIE		EQU	7
PIE1	EQU	8CH
PIR1	EQU	0CH
PEIE	EQU	6
CCP1IF	EQU	2
CCP1IE	EQU	2
EDGE	EQU	0
READY	EQU	1
EEDATA		EQU	0CH
EEADR		EQU	0DH
EECON1		EQU	8CH
EECON2		EQU	8DH
RD EQU 0 ;read bit in EECON1
WR EQU 1 ;Write bit in EECON1
WREN EQU 2
TSTATUS		EQU	69H
TW		EQU	6AH
TPORTB		EQU	6BH
TNUM	EQU	6CH		
COUNTER		EQU	6DH
NUM		EQU	6EH
COUNTER2 EQU	6FH
FILE1	EQU		5AH
FILE2	EQU		5BH
FILE3	EQU		5CH
STORE	EQU		5DH
FLAG	EQU		5EH
ALPHA	EQU		5FH
DELAYCOUNT	EQU	4AH	
SHIFTCOUNT	EQU	4BH					; NUM IS FOR COUTIG CHARACTERS
						; COUNTER NUMBER OF BITS
						; COUNTER2	TO READ FROM THE FIRST ADDRESS
						; algorithm; write to eeprom
						;stop whe a special key is pressed
						;read ad save i ram cosecutively
						;decode ad display the stored characters

	LIST	P=16F877
	ORG		2100H
	DE		00H
	ORG		0
	GOTO	START
	ORG		4
	GOTO	ISR
	__CONFIG	H'3F3A'
;SUBROUTINE
DELAYP5 CLRF TMR0 ;START TMR0.
LOOPB MOVF TMR0,W ;READ TMR0 INTO W.
		SUBLW .2 ;TIME-3  195
	BTFSS STATUS,ZEROBIT ;Check TIME-W � 0
	GOTO LOOPB ;Time is not � 3.
	RETLW 0
DELAY3 MOVLW	.10
		MOVWF	DELAYCOUNT
		DECFSZ	DELAYCOUNT
		CALL 	DELAY4
		RETLW  	.0
		
DELAY4 CLRF TMR0 ;START TMR0.
LOOPC MOVF TMR0,W ;READ TMR0 INTO W.
		SUBLW .255 ;TIME-3
	BTFSS STATUS,ZEROBIT ;Check TIME-W � 0
	GOTO LOOPC ;Time is not � 3.
	NOP ;add extra delay
	NOP
	RETLW 0

F1			MOVF	STORE,W
			MOVWF	FILE1
			GOTO	READLOOP
F2			MOVF	STORE,W
			MOVWF	FILE2
			GOTO	READLOOP
F3			MOVF	STORE,W
			MOVWF	FILE3
			GOTO	READLOOP
DECDISP	
		MOVF	COUNTER2,W
		SUBWF	NUM,W
		BTFSC	STATUS,ZEROBIT
		GOTO	STARTOVER
		INCF	COUNTER2
			MOVF	COUNTER2,W
			ADDWF	PC
			NOP			
STARTOVER	GOTO	DECDISP1;FAULT;DECDISP1
			GOTO	DECDISP2
			GOTO	DECDISP3
			;
			;
			GOTO	STARTOVER	; WHEN IT IS LAST FIGURE CLEAR COUTER2 ALSO REPEAT
DECDISP1	MOVF	FILE1,W
		;	MOVWF	PORTB
		;	GOTO	DECDISP1
			GOTO	ALPHABET
		;	GOTO	DECDISP1	;REMOVE LATER
DECDISP2	MOVF	FILE2,W
			GOTO	ALPHABET
DECDISP3	MOVF	FILE3,W
			GOTO	ALPHABET
			.
			.
			.
			.
			GOTO	DECDISP1

RAMSTORE	;MOVF	COUNTER2,W
			;SUBWF	NUM
			;BTFSC	STATUS,ZEROBIT
			;GOTO	CLEAR	
			MOVF	COUNTER2,W
			ADDWF	PC
			GOTO	READLOOP
			GOTO	F1
			GOTO 	F2
			GOTO	F3	
			;YOU CA STOP HERE READ WILL TAKECARE OF IT
CLEAR		CLRF	COUNTER2		;FOR DECDISP
			GOTO	SAVED
BIT0	BCF		STORE,0
		BTFSC	PORTB,0
		BSF		STORE,0
		GOTO	RESTORE
BIT1	BCF		STORE,1
		BTFSC	PORTB,0
		BSF		STORE,1
		GOTO	RESTORE
BIT2	BCF		STORE,2
		BTFSC	PORTB,0
		BSF		STORE,2
		GOTO	RESTORE
BIT3	BCF		STORE,3
		BTFSC	PORTB,0
		BSF		STORE,3
		GOTO	RESTORE
BIT4	BCF		STORE,4
		BTFSC	PORTB,0
		BSF		STORE,4
		GOTO	RESTORE
BIT5	BCF		STORE,5
		BTFSC	PORTB,0
		BSF		STORE,5
		GOTO	RESTORE
BIT6	BCF		STORE,6
		BTFSC	PORTB,0
		BSF		STORE,6
		GOTO	RESTORE
BIT7	BCF		STORE,7
		BTFSC	PORTB,0
		BSF		STORE,7
		GOTO	RESTORE

WRITE	MOVF	SHIFTCOUNT,W		;TO OMIT SHIFT VALUE
		SUBLW	.2
		BTFSS	STATUS,ZEROBIT
		GOTO	FORINT
		CLRF	SHIFTCOUNT
		INCF	NUM 
		BCF		INTCON,GIE
		BSF 	STATUS,5 ;BANK3
		BSF		STATUS,6
		BSF 	EECON1,WREN ;set WRITE ENABLE
		BCF 	STATUS,5 ;BANK0
		BCF		STATUS,6
WRITENUM MOVF 	STORE,W ;move COUNT to EEDATA
		BSF		STATUS,6
		MOVWF 	EEDATA
		BCF		STATUS,6
		MOVF	NUM,W
		BSF		STATUS,6
		MOVWF 	EEADR
		BSF 	STATUS,5 ;BANK3  
		MOVLW 	55H ;55 and AA initiates write cycle
		MOVWF 	EECON2
		MOVLW 	0AAH
		MOVWF 	EECON2
		BSF 	EECON1,WR ;WRITE data to EEADR 0
		
WRDONE 	BTFSC 	EECON1,WR
		GOTO 	WRDONE 
		BCF 	EECON1,WREN
		BCF 	STATUS,5 ;BANK0
		BCF		STATUS,6
		BSF		INTCON,GIE	; I PUT THIS THERE
		BCF		PIR1,CCP1IF
		MOVF	NUM,W
		SUBLW	.0
		BTFSC	STATUS,ZEROBIT
		GOTO	SKIPPED
		GOTO	FORINT		


READ		;MOVF		COUNTER2,W
		;MOVWF	PORTB
	;GOTO	READ
		
		MOVF	COUNTER2,W
		SUBWF	NUM,W
		BTFSS	STATUS,ZEROBIT
		GOTO	GO_ON
		CLRF	COUNTER2
		GOTO	SAVED
GO_ON	INCF	COUNTER2		;TO READ FROM EEPROM SEQUENTIALLY
READNUM	MOVF	COUNTER2,W
		BSF		STATUS,6
		MOVWF	EEADR
		BSF STATUS,5 ;BANK3
		BSF EECON1,RD
		BCF STATUS,5 ;BANK1
		MOVF EEDATA,W
		BCF		STATUS,6	;BANK0
		MOVWF STORE
		RETURN

RECEIVE	
		MOVF	COUNTER,W
		SUBLW	.2
		BTFSC	STATUS,ZEROBIT
		GOTO	BIT7
		MOVF	COUNTER,W
		SUBLW	.3
		BTFSC	STATUS,ZEROBIT
		GOTO	BIT6
		MOVF	COUNTER,W
		SUBLW	.4
		BTFSC	STATUS,ZEROBIT
		GOTO	BIT5
		MOVF	COUNTER,W
		SUBLW	.5
		BTFSC	STATUS,ZEROBIT
		GOTO	BIT4
		MOVF	COUNTER,W
		SUBLW	.6
		BTFSC	STATUS,ZEROBIT
		GOTO	BIT3
		MOVF	COUNTER,W
		SUBLW	.7
		BTFSC	STATUS,ZEROBIT
		GOTO	BIT2
		MOVF	COUNTER,W
		SUBLW	.8
		BTFSC	STATUS,ZEROBIT
		GOTO	BIT1
		MOVF	COUNTER,W
		SUBLW	.9
		BTFSC	STATUS,ZEROBIT
		GOTO	BIT0
		MOVF	COUNTER,W
		SUBLW	.11
		BTFSS	STATUS,ZEROBIT
		GOTO	RESTORE
		BSF		FLAG,0				;INDICATE
		CLRF	COUNTER
	;	INCF	NUM		;COUNTS CHARACTER
		RETLW	.0
ISR		MOVWF	TW
		SWAPF	STATUS,W
		MOVWF	TSTATUS
		MOVF	PORTB,W
		MOVWF	TPORTB
	;	MOVF	NUM,W
	;	MOVWF	TNUM
		; CHECK FOR OTHERS TO SAVE
		CALL	E
		INCF	COUNTER			;increase counter here
	;	MOVF	COUNTER,W
	;	MOVWF	PORTB
	;	CALL	DELAY3
	;	CLRF	PORTB

		MOVF	COUNTER,W
		SUBLW	.1
		BTFSS	STATUS,ZEROBIT
		GOTO	RECEIVE
RESTORE	;MOVF	TNUM,W
	;	MOVWF	NUM
		MOVF	TPORTB,W
		MOVWF	PORTB
		SWAPF	TSTATUS,W
		MOVWF	STATUS
		MOVF	TW,W
		BCF		PIR1,CCP1IF
		RETFIE

SCANNING	BSF		PORTE,2
			BCF		PORTE,2
			MOVF	DISP1,W
			MOVWF	PORTB
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB

			CALL	CLOCK1
			MOVF	DISP2,W
			MOVWF	PORTB
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			
			CALL	CLOCK1
			MOVF	DISP3,W
			MOVWF	PORTB
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			
			CALL	CLOCK1
			MOVF	DISP4,W
			MOVWF	PORTB
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			
			CALL	CLOCK1
			MOVF	DISP5,W
			MOVWF	PORTB
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			
			CALL	CLOCK1
			MOVF	DISP6,W
			MOVWF	PORTB
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			
			CALL	CLOCK1
			MOVF	DISP7,W
			MOVWF	PORTB
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			
			CALL	CLOCK1
			MOVF	DISP8,W
			MOVWF	PORTB
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			
			CALL	CLOCK1
			MOVF	DISP9,W
			MOVWF	PORTB
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			
			CALL	CLOCK1
			CALL	CLOCK2

			MOVF	DISP10,W
			MOVWF	PORTB
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB

			CALL	CLOCK2
			MOVF	DISP11,W
			MOVWF	PORTB
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB

			CALL	CLOCK2
			MOVF	DISP12,W
			MOVWF	PORTB
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			CALL	CLOCK2
			MOVF	DISP13,W
			MOVWF	PORTB
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			
			CALL	CLOCK2
			MOVF	DISP14,W
			MOVWF	PORTB
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			
			CALL	CLOCK2
			MOVF	DISP15,W
			MOVWF	PORTB
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			
			CALL	CLOCK2
			MOVF	DISP16,W
			MOVWF	PORTB
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			
			CALL	CLOCK2
			MOVF	DISP17,W
			MOVWF	PORTB
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			
			CALL	CLOCK2
			MOVF	DISP18,W
			MOVWF	PORTB
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			CALL	CLOCK2

			MOVF	DISP19,W
			MOVWF	PORTB
			MOVLW	B'10000000'
			MOVWF	PORTD
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			MOVF	DISP20,W
			MOVWF	PORTB
			MOVLW	B'01000000'
			MOVWF	PORTD
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			MOVF	DISP21,W
			MOVWF	PORTB
			MOVLW	B'00100000'
			MOVWF	PORTD
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			MOVF	DISP22,W
			MOVWF	PORTB
			MOVLW	B'00010000'
			MOVWF	PORTD
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			MOVF	DISP23,W
			MOVWF	PORTB
			MOVLW	B'00001000'
			MOVWF	PORTD
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			MOVF	DISP24,W
			MOVWF	PORTB
			MOVLW	B'00000100'
			MOVWF	PORTD
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			MOVF	DISP25,W
			MOVWF	PORTB
			MOVLW	B'00000010'
			MOVWF	PORTD
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			MOVF	DISP26,W
			MOVWF	PORTB
			MOVLW	B'00000001'
			MOVWF	PORTD
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			CLRF	PORTD

			MOVF	DISP27,W
			MOVWF	PORTB
			MOVLW	B'10000000'
			MOVWF	PORTC
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			MOVF	DISP28,W
			MOVWF	PORTB
			MOVLW	B'01000000'
			MOVWF	PORTC
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			MOVF	DISP29,W
			MOVWF	PORTB
			MOVLW	B'00100000'
			MOVWF	PORTC
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			MOVF	DISP30,W
			MOVWF	PORTB
			MOVLW	B'00010000'
			MOVWF	PORTC
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			MOVF	DISP31,W
			MOVWF	PORTB
			MOVLW	B'00001000'
			MOVWF	PORTC
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			MOVF	DISP32,W
			MOVWF	PORTB
			MOVLW	B'00000001' ;MAKING ROOM FOR INTERRUPT
			MOVWF	PORTC
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			MOVF	DISP33,W
			MOVWF	PORTB
			MOVLW	B'00000010'
			MOVWF	PORTC
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			CLRF	PORTC
			
			MOVF	DISP34,W
			MOVWF	PORTB
			MOVLW	B'00000001'
			MOVWF	PORTA
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			MOVF	DISP35,W
			MOVWF	PORTB
			MOVLW	B'00000010'
			MOVWF	PORTA
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			CLRF	PORTA
			GOTO BACK2

WHILE1	
		MOVLW	.7
		MOVWF	COUNT
BACK	DECFSZ	COUNT
		GOTO	BUFFER
		RETLW	0

BUFFER	MOVF	C1,W
	MOVWF	DISP1

	MOVF	C2,W
	MOVWF	C1
	MOVF	C3,W
	MOVWF	C2
	MOVF	C4,W
	MOVWF	C3
	MOVF	C5,W
	MOVWF	C4
	MOVLW	.255
	MOVWF	C5
	MOVLW	.20
	MOVWF	STILL
BACK2	DECFSZ	STILL
	GOTO	SCANNING
			MOVF	DISP34,W
			MOVWF	DISP35
			MOVF	DISP33,W
			MOVWF	DISP34
			MOVF	DISP32,W
			MOVWF	DISP33
			MOVF	DISP31,W
			MOVWF	DISP32
			MOVF	DISP30,W
			MOVWF	DISP31
			MOVF	DISP29,W
			MOVWF	DISP30
			MOVF	DISP28,W
			MOVWF	DISP29
			MOVF	DISP27,W
			MOVWF	DISP28
			MOVF	DISP26,W
			MOVWF	DISP27
			MOVF	DISP25,W
			MOVWF	DISP26
			MOVF	DISP24,W
			MOVWF	DISP25
			MOVF	DISP23,W
			MOVWF	DISP24
			MOVF	DISP22,W
			MOVWF	DISP23
			MOVF	DISP21,W
			MOVWF	DISP22
			MOVF	DISP20,W
			MOVWF	DISP21
			MOVF	DISP19,W
			MOVWF	DISP20
			MOVF	DISP18,W
			MOVWF	DISP19
			MOVF	DISP17,W
			MOVWF	DISP18
			MOVF	DISP16,W
			MOVWF	DISP17
			MOVF	DISP15,W
			MOVWF	DISP16
			MOVF	DISP14,W
			MOVWF	DISP15
			MOVF	DISP13,W
			MOVWF	DISP14
			MOVF	DISP12,W
			MOVWF	DISP13
			MOVF	DISP11,W
			MOVWF	DISP12		
			MOVF	DISP10,W
			MOVWF	DISP11
			MOVF	DISP9,W
			MOVWF	DISP10
			MOVF	DISP8,W
			MOVWF	DISP9
			MOVF	DISP7,W
			MOVWF	DISP8
			MOVF	DISP6,W
			MOVWF	DISP7
			MOVF	DISP5,W
			MOVWF	DISP6
			MOVF	DISP4,W
			MOVWF	DISP5
			MOVF	DISP3,W
			MOVWF	DISP4
			MOVF	DISP2,W
			MOVWF	DISP3
			MOVF	DISP1,W
			MOVWF	DISP2	
	GOTO	BACK

ALPHABET
A	MOVWF	ALPHA
	SUBLW	1CH
	BTFSS	STATUS,ZEROBIT
	GOTO	BB	
	MOVLW	0C1H
	MOVWF	C1
	MOVLW	0B7H
	MOVWF	C2
	MOVLW	77H
	MOVWF	C3
	MOVLW	0B7H
	MOVWF	C4
	MOVLW	0C1H
	MOVWF	C5
	
	CALL	WHILE1
	GOTO	DECDISP

BB	MOVF	ALPHA,W
	SUBLW	32H
	BTFSS	STATUS,ZEROBIT
	GOTO	C	
	MOVLW	01H
	MOVWF	C1
	MOVLW	06DH
	MOVWF	C2
	MOVLW	6DH
	MOVWF	C3
	MOVLW	06DH
	MOVWF	C4
	MOVLW	93H
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
C	MOVF	ALPHA,W
	SUBLW	21H
	BTFSS	STATUS,ZEROBIT
;	GOTO	DEFAULT	
	MOVLW	83H
	MOVWF	C1
	MOVLW	07DH
	MOVWF	C2
	MOVLW	7DH
	MOVWF	C3
	MOVLW	07DH
	MOVWF	C4
	MOVLW	0BBH
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
D	;MOVF	ALPHA,W
	;SUBLW	23H
	;BTFSS	STATUS,ZEROBIT
	;GOTO	E
	MOVLW	01H
	MOVWF	C1
	MOVLW	07DH
	MOVWF	C2
	MOVLW	07DH
	MOVWF	C3
	MOVLW	0BBH
	MOVWF	C4
	MOVLW	0C7H
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
E	;MOVF	ALPHA,W
	;SUBLW	24H
	;BTFSS	STATUS,ZEROBIT
	;GOTO	F
	MOVLW	01H
	MOVWF	C1
	MOVLW	06DH
	MOVWF	C2
	MOVLW	06DH
	MOVWF	C3
	MOVLW	06DH
	MOVWF	C4
	MOVLW	7DH
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
F	MOVF	ALPHA,W
	SUBLW	2BH
	BTFSS	STATUS,ZEROBIT
	GOTO	G
	MOVLW	01H
	MOVWF	C1
	MOVLW	6FH
	MOVWF	C2
	MOVLW	6FH
	MOVWF	C3
	MOVLW	6FH
	MOVWF	C4
	MOVLW	7FH
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
G	MOVF	ALPHA,W
	SUBLW	34H
	BTFSS	STATUS,ZEROBIT
	GOTO	H
	MOVLW	83H
	MOVWF	C1
	MOVLW	07DH
	MOVWF	C2
	MOVLW	065H
	MOVWF	C3
	MOVLW	06DH
	MOVWF	C4
	MOVLW	0A3H
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
			
H	MOVF	ALPHA,W
	SUBLW	33H
	BTFSS	STATUS,ZEROBIT
	GOTO	I
	MOVLW	01H
	MOVWF	C1
	MOVLW	0EFH
	MOVWF	C2
	MOVLW	0EFH
	MOVWF	C3
	MOVLW	0EFH
	MOVWF	C4
	MOVLW	01H
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
I	MOVF	ALPHA,W
	SUBLW	43H
	BTFSS	STATUS,ZEROBIT
	GOTO	J
	MOVLW	7DH
	MOVWF	C1
	MOVLW	07DH
	MOVWF	C2
	MOVLW	01H
	MOVWF	C3
	MOVLW	07DH
	MOVWF	C4
	MOVLW	7DH
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP

J	MOVF	ALPHA,W
	SUBLW	3BH
	BTFSS	STATUS,ZEROBIT
	GOTO	K
	MOVLW	0F3H
	MOVWF	C1
	MOVLW	7DH
	MOVWF	C2
	MOVLW	7DH
	MOVWF	C3
	MOVLW	03H
	MOVWF	C4
	MOVLW	7FH
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
K	MOVF	ALPHA,W
	SUBLW	42H
	BTFSS	STATUS,ZEROBIT
	GOTO	L
	MOVLW	01H
	MOVWF	C1
	MOVLW	0EFH
	MOVWF	C2
	MOVLW	0D7H
	MOVWF	C3
	MOVLW	0BBH
	MOVWF	C4
	MOVLW	7DH
	MOVWF	C5
	GOTO	WHILE1
	GOTO	DECDISP
L	MOVF	ALPHA,W
	SUBLW	4BH
	BTFSS	STATUS,ZEROBIT
	GOTO	M
	MOVLW	01H
	MOVWF	C1
	MOVLW	0FDH
	MOVWF	C2
	MOVLW	0FDH
	MOVWF	C3
	MOVLW	0FDH
	MOVWF	C4
	MOVLW	0FDH
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
//
M	MOVF	ALPHA,W
	SUBLW	3AH
	BTFSS	STATUS,ZEROBIT
	GOTO	N
	MOVLW	83H
	MOVWF	C1
	MOVLW	07DH
	MOVWF	C2
	MOVLW	7DH
	MOVWF	C3
	MOVLW	07DH
	MOVWF	C4
	MOVLW	0BBH
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
N	MOVF	ALPHA,W
	SUBLW	31H
	BTFSS	STATUS,ZEROBIT
	GOTO	O
	MOVLW	83H
	MOVWF	C1
	MOVLW	07DH
	MOVWF	C2
	MOVLW	7DH
	MOVWF	C3
	MOVLW	07DH
	MOVWF	C4
	MOVLW	0BBH
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
O	MOVF	ALPHA,W
	SUBLW	44H
	BTFSS	STATUS,ZEROBIT
	GOTO	P
	MOVLW	83H
	MOVWF	C1
	MOVLW	07DH
	MOVWF	C2
	MOVLW	7DH
	MOVWF	C3
	MOVLW	07DH
	MOVWF	C4
	MOVLW	0BBH
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
P	MOVF	ALPHA,W
	SUBLW	4DH
	BTFSS	STATUS,ZEROBIT
	GOTO	Q
	MOVLW	83H
	MOVWF	C1
	MOVLW	07DH
	MOVWF	C2
	MOVLW	7DH
	MOVWF	C3
	MOVLW	07DH
	MOVWF	C4
	MOVLW	0BBH
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
Q	MOVF	ALPHA,W
	SUBLW	15H
	BTFSS	STATUS,ZEROBIT
	GOTO	R
	MOVLW	83H
	MOVWF	C1
	MOVLW	07DH
	MOVWF	C2
	MOVLW	7DH
	MOVWF	C3
	MOVLW	07DH
	MOVWF	C4
	MOVLW	0BBH
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
R	MOVF	ALPHA,W
	SUBLW	2DH
	BTFSS	STATUS,ZEROBIT
	GOTO	S
	MOVLW	83H
	MOVWF	C1
	MOVLW	07DH
	MOVWF	C2
	MOVLW	7DH
	MOVWF	C3
	MOVLW	07DH
	MOVWF	C4
	MOVLW	0BBH
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
S	MOVF	ALPHA,W
	SUBLW	1BH
	BTFSS	STATUS,ZEROBIT
	GOTO	T
	MOVLW	83H
	MOVWF	C1
	MOVLW	07DH
	MOVWF	C2
	MOVLW	7DH
	MOVWF	C3
	MOVLW	07DH
	MOVWF	C4
	MOVLW	0BBH
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
T	MOVF	ALPHA,W
	SUBLW	2CH
	BTFSS	STATUS,ZEROBIT
	GOTO	U
	MOVLW	83H
	MOVWF	C1
	MOVLW	07DH
	MOVWF	C2
	MOVLW	7DH
	MOVWF	C3
	MOVLW	07DH
	MOVWF	C4
	MOVLW	0BBH
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
U	MOVF	ALPHA,W
	SUBLW	3CH
	BTFSS	STATUS,ZEROBIT
	GOTO	V
	MOVLW	83H
	MOVWF	C1
	MOVLW	07DH
	MOVWF	C2
	MOVLW	7DH
	MOVWF	C3
	MOVLW	07DH
	MOVWF	C4
	MOVLW	0BBH
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
V	MOVF	ALPHA,W
	SUBLW	2AH
	BTFSS	STATUS,ZEROBIT
	GOTO	N
	MOVLW	83H
	MOVWF	C1
	MOVLW	07DH
	MOVWF	C2
	MOVLW	7DH
	MOVWF	C3
	MOVLW	07DH
	MOVWF	C4
	MOVLW	0BBH
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
W	MOVF	ALPHA,W
	SUBLW	1DH
	BTFSS	STATUS,ZEROBIT
	GOTO	X
	MOVLW	83H
	MOVWF	C1
	MOVLW	07DH
	MOVWF	C2
	MOVLW	7DH
	MOVWF	C3
	MOVLW	07DH
	MOVWF	C4
	MOVLW	0BBH
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
X	MOVF	ALPHA,W
	SUBLW	22H
	BTFSS	STATUS,ZEROBIT
	GOTO	Y
	MOVLW	83H
	MOVWF	C1
	MOVLW	07DH
	MOVWF	C2
	MOVLW	7DH
	MOVWF	C3
	MOVLW	07DH
	MOVWF	C4
	MOVLW	0BBH
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
Y	MOVF	ALPHA,W
	SUBLW	35H
	BTFSS	STATUS,ZEROBIT
	GOTO	Z
	MOVLW	83H
	MOVWF	C1
	MOVLW	07DH
	MOVWF	C2
	MOVLW	7DH
	MOVWF	C3
	MOVLW	07DH
	MOVWF	C4
	MOVLW	0BBH
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
Z	MOVF	ALPHA,W
	SUBLW	1AH
	BTFSS	STATUS,ZEROBIT
	GOTO	M0
	MOVLW	83H
	MOVWF	C1
	MOVLW	07DH
	MOVWF	C2
	MOVLW	7DH
	MOVWF	C3
	MOVLW	07DH
	MOVWF	C4
	MOVLW	0BBH
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
M0	MOVF	ALPHA,W
	SUBLW	45H
	BTFSS	STATUS,ZEROBIT
	GOTO	M1
	MOVLW	83H
	MOVWF	C1
	MOVLW	07DH
	MOVWF	C2
	MOVLW	7DH
	MOVWF	C3
	MOVLW	07DH
	MOVWF	C4
	MOVLW	0BBH
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
M1	MOVF	ALPHA,W
	SUBLW	16H
	BTFSS	STATUS,ZEROBIT
	GOTO	M2
	MOVLW	83H
	MOVWF	C1
	MOVLW	07DH
	MOVWF	C2
	MOVLW	7DH
	MOVWF	C3
	MOVLW	07DH
	MOVWF	C4
	MOVLW	0BBH
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
M2	MOVF	ALPHA,W
	SUBLW	1EH
	BTFSS	STATUS,ZEROBIT
	GOTO	M3
	MOVLW	83H
	MOVWF	C1
	MOVLW	07DH
	MOVWF	C2
	MOVLW	7DH
	MOVWF	C3
	MOVLW	07DH
	MOVWF	C4
	MOVLW	0BBH
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
M3	MOVF	ALPHA,W
	SUBLW	26H
	BTFSS	STATUS,ZEROBIT
	GOTO	M4
	MOVLW	83H
	MOVWF	C1
	MOVLW	07DH
	MOVWF	C2
	MOVLW	7DH
	MOVWF	C3
	MOVLW	07DH
	MOVWF	C4
	MOVLW	0BBH
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
M4	MOVF	ALPHA,W
	SUBLW	25H
	BTFSS	STATUS,ZEROBIT
	GOTO	M5
	MOVLW	83H
	MOVWF	C1
	MOVLW	07DH
	MOVWF	C2
	MOVLW	7DH
	MOVWF	C3
	MOVLW	07DH
	MOVWF	C4
	MOVLW	0BBH
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
M5	MOVF	ALPHA,W
	SUBLW	2EH
	BTFSS	STATUS,ZEROBIT
	GOTO	M6
	MOVLW	83H
	MOVWF	C1
	MOVLW	07DH
	MOVWF	C2
	MOVLW	7DH
	MOVWF	C3
	MOVLW	07DH
	MOVWF	C4
	MOVLW	0BBH
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
M6	MOVF	ALPHA,W
	SUBLW	36H
	BTFSS	STATUS,ZEROBIT
	GOTO	M7
	MOVLW	83H
	MOVWF	C1
	MOVLW	07DH
	MOVWF	C2
	MOVLW	7DH
	MOVWF	C3
	MOVLW	07DH
	MOVWF	C4
	MOVLW	0BBH
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
M7	MOVF	ALPHA,W
	SUBLW	3DH
	BTFSS	STATUS,ZEROBIT
	GOTO	M8
	MOVLW	83H
	MOVWF	C1
	MOVLW	07DH
	MOVWF	C2
	MOVLW	7DH
	MOVWF	C3
	MOVLW	07DH
	MOVWF	C4
	MOVLW	0BBH
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
M8	MOVF	ALPHA,W
	SUBLW	3EH
	BTFSS	STATUS,ZEROBIT
	GOTO	M9
	MOVLW	83H
	MOVWF	C1
	MOVLW	07DH
	MOVWF	C2
	MOVLW	7DH
	MOVWF	C3
	MOVLW	07DH
	MOVWF	C4
	MOVLW	0BBH
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
M9	MOVF	ALPHA,W
	SUBLW	46H
	BTFSS	STATUS,ZEROBIT
	GOTO	SP
	MOVLW	83H
	MOVWF	C1
	MOVLW	07DH
	MOVWF	C2
	MOVLW	7DH
	MOVWF	C3
	MOVLW	07DH
	MOVWF	C4
	MOVLW	0BBH
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP

SP	MOVLW	0FFH
	MOVWF	C1
	MOVLW	0FFH
	MOVWF	C2
	MOVLW	0FFH
	MOVWF	C3
	MOVLW	0FFH
	MOVWF	C4
	MOVLW	0FFH
	MOVWF	C5
	GOTO	WHILE1
			RETURN
	BSF		FLAG,1			;for lowcase

LOWALPHA			
a		BTFSC	FLAG,1				;read or write, if write proceed else goto read
		GOTO	R_a
		MOVF	STORE,W
		SUBLW						;put alphaets code
		BTFSS	STATUS,ZEROBIT
		GOTO	bb
		MOVLW	.1					;IT IS a 
		MOVWF	STORE
		GOTO	WRITE
R_a		MOVF	STORE,W
		SUBLW	.1
		BTFSS	STATUS,ZEROBIT
		GOTO	R_bb
	
		MOVLW	01H
		MOVWF	C1
		MOVLW	07DH
		MOVWF	C2
		MOVLW	07DH
		MOVWF	C3
		MOVLW	0BBH
		MOVWF	C4
		MOVLW	0C7H
		MOVWF	C5
		GOTO	WHILE1
		GOTO	DECDISP
				
bb		MOVF	STORE,W
		SUBLW				
		BTFSS	STATUS,ZEROBIT
		GOTO	bb
		MOVLW	.1				
		MOVWF	STORE
		GOTO	WRITE
R_b		MOVF	STORE,W
		SUBLW	.2
		BTFSS	STATUS,ZEROBIT
		GOTO	R_bb
	
		MOVLW	01H
		MOVWF	C1
		MOVLW	07DH
		MOVWF	C2
		MOVLW	07DH
		MOVWF	C3
		MOVLW	0BBH
		MOVWF	C4
		MOVLW	0C7H
		MOVWF	C5
		GOTO	WHILE1

CLOCK1		BSF		PORTE,1
			BCF		PORTE,1
			RETLW	0
CLOCK2		BSF		PORTE,0
			BCF		PORTE,0
			RETLW	0

SCANCOL		MOVF	DISP,W	
			IORLW	0FEH ;11111110
			MOVWF	PORTB
			CALL	DELAYP5
			MOVF	DISP,W
			IORLW	0FDH ;11111101
			MOVWF	PORTB
			CALL	DELAYP5
			MOVF	DISP,W
			IORLW	0FBH ;11111011
			MOVWF	PORTB
			CALL	DELAYP5
			MOVF	DISP,W
			IORLW	0F7H ;11110111
			MOVWF	PORTB
			CALL	DELAYP5	
			MOVF	DISP,W
			IORLW	0EFH ;11101111
			MOVWF	PORTB
			CALL	DELAYP5
			MOVF	DISP,W
			IORLW	0DFH ;11011111
			MOVWF	PORTB
			CALL	DELAYP5
			MOVF	DISP,W
			IORLW	0BFH ;10111111
			MOVWF	PORTB
			CALL	DELAYP5
			MOVF	DISP,W
			IORLW	07FH ;01111111
			MOVWF	PORTB
			CALL	DELAYP5
			MOVLW	B'11111111'
			MOVWF	PORTB
			RETLW	0

GAP			CALL SP
		CALL SP
		CALL SP
		CALL SP
		CALL SP
		CALL SP
		CALL SP
		RETURN
START	
		BSF		STATUS,5
		MOVLW	.0
		MOVWF	TRISB
		MOVLW	.0
		MOVWF	TRISA
		MOVLW	.4
		MOVWF	TRISC
		MOVLW	.0
		MOVWF	TRISD
		MOVLW	.0
		MOVWF	TRISE
		MOVLW	07H
		MOVWF	OPTION_R
		BSF		PIE1,CCP1IE
		CLRF	STATUS
		CLRF	PORTA
		CLRF	PORTC
		CLRF	PORTD		
		CLRF	PORTE
		CLRF	COUNTER
		CLRF	COUNTER2
		CLRF	NUM
		CLRF	FLAG
		CLRF	SHIFTCOUNT
		MOVLW	.4
		MOVWF	CCP1CON
		CLRF	INTCON
		
		BCF		PIR1,CCP1IF
		BSF		INTCON,GIE
		BSF		INTCON,PEIE

	MOVLW	.255
	MOVWF	PORTB
	MOVLW	.255
	MOVWF	DISP1
	MOVLW	.255
	MOVWF	DISP2
	MOVLW	.255
	MOVWF	DISP3
	MOVLW	.255
	MOVWF	DISP4
	MOVLW	.255
	MOVWF	DISP5
	MOVLW	.255
	MOVWF	DISP6
	MOVLW	.255
	MOVWF	DISP7
	MOVLW	.255
	MOVWF	DISP8
	MOVLW	.255
	MOVWF	DISP9
	MOVLW	.255
	MOVWF	DISP10
	MOVLW	.255
	MOVWF	DISP11
	MOVLW	.255
	MOVWF	DISP12
	MOVLW	.255
	MOVWF	DISP13
	MOVLW	.255
	MOVWF	DISP14
	MOVLW	.255
	MOVWF	DISP15
	MOVLW	.255
	MOVWF	DISP16
	MOVLW	.255
	MOVWF	DISP17
	MOVLW	.255
	MOVWF	DISP18
	MOVLW	.255
	MOVWF	DISP19
	MOVLW	.255
	MOVWF	DISP20
	MOVLW	.255
	MOVWF	DISP21
	MOVLW	.255
	MOVWF	DISP22
	MOVLW	.255
	MOVWF	DISP23
	MOVLW	.255
	MOVWF	DISP24
	MOVLW	.255
	MOVWF	DISP25
	MOVLW	.255
	MOVWF	DISP26
	MOVLW	.255
	MOVWF	DISP27
	MOVLW	.255
	MOVWF	DISP28
	MOVLW	.255
	MOVWF	DISP29
	MOVLW	.255
	MOVWF	DISP30
	MOVLW	.255
	MOVWF	DISP31
	MOVLW	.255
	MOVWF	DISP32
	MOVLW	.255
	MOVWF	DISP33
	MOVLW	.255
	MOVWF	DISP34
	MOVLW	.255
	MOVWF	DISP35
	MOVLW	.255
	MOVWF	DISP36
	MOVLW	.255
	MOVWF	DISP37
	MOVLW	.255
	MOVWF	DISP38
	MOVLW	.255
	MOVWF	DISP39
	MOVLW	.255
	MOVWF	DISP40
	
;PROGRAM STARTS

	BEGIN		;GOTO DEFAULT	;WELCOME MESSAGE
		CALL	DELAY3			;to wait for input NOT READY
		MOVF	STORE,W
		SUBLW	76H		;ESC KEY VALUE
		BTFSS	STATUS,ZEROBIT
		GOTO	SKIPPED
		BCF		FLAG,0
	;	BCF		FLAG,1			;TO CHECK FOR WRITE OR READ
		
FORINT BTFSS	FLAG,0		;WAIT FOR INPUT
		GOTO	FORINT  
		BCF		FLAG,0
		CALL D
	; END OF INPUT WHEN ENTER IS PRESSED
		MOVF	STORE,W
		SUBLW	00H;5AH	ENTER KEY
		BTFSC	STATUS,ZEROBIT
		GOTO	FINISH		;END OF INPUT
	; SHIFT OR UNSHIFTED
		MOVF	STORE,W
		SUBLW	11H	;12H	; SHIFT
		BTFSS	STATUS,ZEROBIT
		GOTO	LOWALPHA	;WRITE LOWCASE`
		INCF	SHIFTCOUNT
		GOTO	WRITE		;WRITE UPPERCASE, IF SHIFT IS PRESSED
				
FINISH	MOVF	NUM,W		
		MOVWF	STORE
		CLRF	NUM
		GOTO	WRITENUM	;TO SAVE NUM
SKIPPED BCF		INTCON,GIE
		BCF		INTCON,PEIE
		CLRF	COUNTER2
		CALL	READNUM		;TO READ NUM
		MOVLW	.1
		MOVWF	NUM
READLOOP CALL	READ	
		GOTO	RAMSTORE	;READS INTO RAM
SAVED	GOTO	DECDISP		;DECODE AND DISPLAY
		

	
DEFAULT	
		CALL F
		CALL E
		CALL E
		CALL D
		CALL SP
		CALL SP
	GOTO FORINT
		CALL H
		CALL A
		CALL I
		CALL L
		call SP
		call	BB
		call	A
		call	BB
		call	A
		call GAP
			GOTO	FORINT	;FOR INTERRUPT	
	END