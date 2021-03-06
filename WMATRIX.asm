TMR0	EQU	1
PCLATH	EQU	0AH
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
DISP41		EQU	67H
STILL	EQU	66H
DISP	EQU	68H

TSTATUS		EQU	69H
TW		EQU	6AH
TPORTB		EQU	6BH
TNUM	EQU	6CH		

COUNTER		EQU	6DH
NUM		EQU	6EH
COUNTER2 EQU	6FH
FLAG	EQU		2AH
ALPHA	EQU		2BH
DELAYCOUNT	EQU	2CH	
SHIFTCOUNT	EQU	2DH	
STORE	EQU		2EH
TTMR0	EQU		2FH
FILE1	EQU		3AH
FILE2	EQU		3BH
FILE3	EQU		3CH	
FILE4	EQU		3DH
FILE5	EQU		3EH
FILE6	EQU		3FH
FILE7	EQU		4AH
FILE8	EQU		4BH
FILE9	EQU		4CH
FILE10	EQU		4DH;REMOVE
FILE11	EQU		4EH
FILE12	EQU		4FH
FILE13	EQU		5AH
FILE14	EQU		5BH
FILE15	EQU		5CH
FILE16	EQU		5DH	
FILE17	EQU		5EH
FILE18	EQU		5FH
FILE19	EQU		7AH
FILE20	EQU		7BH
FILE21	EQU		7CH
FILE22	EQU		7DH
FILE23	EQU		7EH
FILE24	EQU		7FH
FILE25	EQU		0A0H
FILE26	EQU		0A1H
FILE27	EQU		0A2H
FILE28	EQU		0A3H
FILE29	EQU		0A4H
FILE30	EQU		0A5H
FILE31	EQU		0A6H
FILE32	EQU		0A7H
FILE33	EQU		0A8H
FILE34	EQU		0A9H
FILE35	EQU		0AAH
FILE31	EQU		0A6H
FILE32	EQU		0A7H
FILE33	EQU		0A8H
FILE34	EQU		0A9H
FILE35	EQU		0AAH
FILE36	EQU		0ABH
FILE37	EQU		0ACH
FILE38	EQU		0ADH
FILE39	EQU		0AEH
FILE40	EQU		0AFH




				; NUM IS FOR COUTIG CHARACTERS
						; COUNTER NUMBER OF BITS
						; COUNTER2	TO READ FROM THE FIRST ADDRESS
						; algorithm; write to eeprom
						;stop whe a eter key is pressed
						;skip if ESC is pressed
						;read ad save i ram cosecutively
						;decode ad display the stored characters

	LIST	P=16F877A
	ORG		2100H
	DE		00H
	ORG		0
	GOTO	START
	ORG		4
	GOTO	ISR
	__CONFIG	H'3F3A'
;SUBROUTINE
DELAYP15 CLRF TMR0 ;START TMR0.
LOOPB MOVF TMR0,W ;READ TMR0 INTO W.
		SUBLW .2 ;TIME-3  195
	BTFSS STATUS,ZEROBIT ;Check TIME-W � 0
	GOTO LOOPB ;Time is not � 3.
	RETLW 0


DELAYWAIT MOVLW	.255			;for waiti
		MOVWF	DELAYCOUNT
DEL3	DECFSZ	DELAYCOUNT
		GOTO 	DELAY4
		RETLW  	.0
DELAYP5 CLRF TMR0 ;START TMR0.
LOOPe MOVF TMR0,W ;READ TMR0 INTO W.
		SUBLW .2	;3  195
	BTFSS STATUS,ZEROBIT ;Check TIME-W � 0
	GOTO LOOPe ;Time is not � 3.
	RETLW 0
		
DELAY4 CLRF TMR0 ;START TMR0.
LOOPC MOVF TMR0,W ;READ TMR0 INTO W.
		SUBLW .255 ;TIME-3
	BTFSS STATUS,ZEROBIT ;Check TIME-W � 0
	GOTO LOOPC ;Time is not � 3.
	GOTO DEL3
;TO STORE INTO FILE
SKIPWAIT DECFSZ	COUNTER2
		GOTO	DELAYSKIP
		CLRF	COUNTER2
		GOTO	SKIPPED
DELAYSKIP	CALL	DELAYWAIT
		CALL	DELAYWAIT
	
		
DECDISP	
		MOVF	COUNTER2,W
		SUBWF	NUM,W
		BTFSS	STATUS,ZEROBIT
		GOTO 	JUMP
		CALL GAP
		CLRF	COUNTER2
		GOTO	DECDISP
JUMP		INCF	COUNTER2
			MOVF	COUNTER2,W
			ADDWF	PC
			NOP			
STARTOVER	GOTO	DECDISP1
			GOTO	DECDISP2
			GOTO	DECDISP3
			GOTO	DECDISP4
			GOTO	DECDISP5
			GOTO	DECDISP6
			GOTO	DECDISP7
			GOTO	DECDISP8
			GOTO	DECDISP9
			GOTO	DECDISP10
			GOTO	DECDISP11
			GOTO	DECDISP12
			GOTO	DECDISP13
			GOTO	DECDISP14
			GOTO	DECDISP15
			GOTO	DECDISP16
			GOTO	DECDISP17
			GOTO	DECDISP18
			GOTO	DECDISP19
			GOTO	DECDISP20
			GOTO	DECDISP21
			GOTO	DECDISP22
			GOTO	DECDISP23
			GOTO	DECDISP24
			GOTO	DECDISP25
			GOTO	DECDISP26
			GOTO	DECDISP27
			GOTO	DECDISP28
			GOTO	DECDISP29
			GOTO	DECDISP30
			GOTO	DECDISP31
			GOTO	DECDISP32
			GOTO	DECDISP33
			GOTO	DECDISP34
			GOTO	DECDISP35
			GOTO	DECDISP36
			GOTO	DECDISP37
			GOTO	DECDISP38
			GOTO	DECDISP39
			GOTO	DECDISP40
			
			GOTO	STARTOVER	;NO NEED REALLY
DECDISP1	MOVF	FILE1,W
			GOTO	ALPHABET
DECDISP2	MOVF	FILE2,W
			GOTO	ALPHABET
DECDISP3	MOVF	FILE3,W
			GOTO	ALPHABET
DECDISP4	MOVF	FILE4,W
			GOTO	ALPHABET
DECDISP5	MOVF	FILE5,W
			GOTO	ALPHABET
DECDISP6	MOVF	FILE6,W
			GOTO	ALPHABET
DECDISP7	MOVF	FILE7,W
			GOTO	ALPHABET
DECDISP8	MOVF	FILE8,W
			GOTO	ALPHABET
DECDISP9	MOVF	FILE9,W
			GOTO	ALPHABET
DECDISP10	MOVF	FILE10,W
			GOTO	ALPHABET
DECDISP11	MOVF	FILE11,W
			GOTO	ALPHABET
DECDISP12	MOVF	FILE12,W
			GOTO	ALPHABET
DECDISP13	MOVF	FILE13,W
			GOTO	ALPHABET
DECDISP14	MOVF	FILE14,W
			GOTO	ALPHABET
DECDISP15	MOVF	FILE15,W
			GOTO	ALPHABET
DECDISP16	MOVF	FILE16,W
			GOTO	ALPHABET
DECDISP17	MOVF	FILE17,W
			GOTO	ALPHABET
DECDISP18	MOVF	FILE18,W
			GOTO	ALPHABET
DECDISP19	MOVF	FILE19,W
			GOTO	ALPHABET
DECDISP20	MOVF	FILE20,W
			GOTO	ALPHABET
DECDISP21	MOVF	FILE21,W
			GOTO	ALPHABET
DECDISP22	MOVF	FILE22,W
			GOTO	ALPHABET
DECDISP23	MOVF	FILE23,W
			GOTO	ALPHABET
DECDISP24	MOVF	FILE24,W
			GOTO	ALPHABET
DECDISP25	BSF		STATUS,5
			MOVF	FILE25,W
			BCF		STATUS,5
			GOTO	ALPHABET
DECDISP26	BSF		STATUS,5
			MOVF	FILE26,W
			BCF		STATUS,5
			GOTO	ALPHABET
DECDISP27	BSF		STATUS,5
			MOVF	FILE27,W
			BCF		STATUS,5
			GOTO	ALPHABET
DECDISP28	BSF		STATUS,5
			MOVF	FILE28,W
			BCF		STATUS,5
			GOTO	ALPHABET
DECDISP29	BSF		STATUS,5
			MOVF	FILE29,W
			BCF		STATUS,5
			GOTO	ALPHABET
DECDISP30	BSF		STATUS,5
			MOVF	FILE30,W
			BCF		STATUS,5
			GOTO	ALPHABET
DECDISP31	BSF		STATUS,5
			MOVF	FILE31,W
			BCF		STATUS,5
			GOTO	ALPHABET
DECDISP32	BSF		STATUS,5
			MOVF	FILE32,W
			BCF		STATUS,5
			GOTO	ALPHABET
DECDISP33	BSF		STATUS,5
			MOVF	FILE33,W
			BCF		STATUS,5
			GOTO	ALPHABET
DECDISP34	BSF		STATUS,5
			MOVF	FILE34,W
			BCF		STATUS,5
			GOTO	ALPHABET
DECDISP35	BSF		STATUS,5
			MOVF	FILE35,W
			BCF		STATUS,5
			GOTO	ALPHABET
DECDISP36	BSF		STATUS,5
			MOVF	FILE36,W
			BCF		STATUS,5
			GOTO	ALPHABET
DECDISP37	BSF		STATUS,5
			MOVF	FILE37,W
			BCF		STATUS,5
			GOTO	ALPHABET
DECDISP38	BSF		STATUS,5
			MOVF	FILE38,W
			BCF		STATUS,5
			GOTO	ALPHABET
DECDISP39	BSF		STATUS,5
			MOVF	FILE39,W
			BCF		STATUS,5
			GOTO	ALPHABET
DECDISP40	BSF		STATUS,5
			MOVF	FILE40,W
			BCF		STATUS,5
			GOTO	ALPHABET
			
;STORE IN FILE SEQUENTIALLY
RAMSTORE	
			MOVF	COUNTER2,W
			ADDWF	PC
			GOTO	READLOOP
			GOTO	F1
			GOTO 	F2
			GOTO	F3
			GOTO	F4
			GOTO 	F5
			GOTO	F6
			GOTO	F7
			GOTO 	F8
			GOTO	F9	
			GOTO	F10
			GOTO 	F11
			GOTO	F12
			GOTO	F13
			GOTO 	F14
			GOTO	F15
			GOTO	F16
			GOTO 	F17
			GOTO	F18	
			GOTO	F19
			GOTO 	F20
			GOTO	F21
			GOTO	F22
			GOTO 	F23
			GOTO	F24
			GOTO	F25
			GOTO 	F26
			GOTO	F27
			GOTO	F28
			GOTO 	F29
			GOTO	F30
			GOTO	F31
			GOTO 	F32
			GOTO	F33
			GOTO	F34
			GOTO 	F35
			GOTO	F36	
			GOTO	F37
			GOTO 	F38
			GOTO	F39
			GOTO	F40
		

;TO READ THE DATA FROM KEYBOARD
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

WRITE
		INCF	NUM 
WRITENUM	BCF		INTCON,GIE
		BSF 	STATUS,5 ;BANK3
		BSF		STATUS,6
		BSF 	EECON1,WREN ;set WRITE ENABLE
		BCF 	STATUS,5 ;BANK0
		BCF		STATUS,6
		MOVF 	STORE,W ;move COUNT to EEDATA
		BSF		STATUS,6
		MOVWF 	EEDATA
		BCF		STATUS,6
		MOVF	NUM,W			;writi to the address 0
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
	CALL DELAYP5
		BSF		INTCON,GIE	; I PUT THIS THERE
		BCF		PIR1,CCP1IF
		MOVF	NUM,W
		SUBLW	.92
		BTFSC	STATUS,ZEROBIT
		GOTO	SKIPPED			;proceed to read
	CLRF	COUNTER
		GOTO	FORINT		


READ	
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
		GOTO	BIT0
		MOVF	COUNTER,W
		SUBLW	.3
		BTFSC	STATUS,ZEROBIT
		GOTO	BIT1
		MOVF	COUNTER,W
		SUBLW	.4
		BTFSC	STATUS,ZEROBIT
		GOTO	BIT2
		MOVF	COUNTER,W
		SUBLW	.5
		BTFSC	STATUS,ZEROBIT
		GOTO	BIT3
		MOVF	COUNTER,W
		SUBLW	.6
		BTFSC	STATUS,ZEROBIT
		GOTO	BIT4
		MOVF	COUNTER,W
		SUBLW	.7
		BTFSC	STATUS,ZEROBIT
		GOTO	BIT5
		MOVF	COUNTER,W
		SUBLW	.8
		BTFSC	STATUS,ZEROBIT
		GOTO	BIT6
		MOVF	COUNTER,W
		SUBLW	.9
		BTFSC	STATUS,ZEROBIT
		GOTO	BIT7
		MOVF	COUNTER,W
		SUBLW	.33
		BTFSS	STATUS,ZEROBIT
		GOTO	RESTORE
		BSF		FLAG,0				;INDICATE
		CLRF	COUNTER
		
 		RETLW .0;	GOTO	RESTORE;

ISR		MOVWF	TW
		SWAPF	STATUS,W
		MOVWF	TSTATUS
		MOVF	TMR0,W
		MOVWF	TTMR0
		MOVF	PORTB,W
		MOVWF	TPORTB
		; CHECK FOR OTHERS TO SAVE
		INCF	COUNTER			;increase counter here

		MOVF	COUNTER,W
		SUBLW	.1
		BTFSS	STATUS,ZEROBIT
		GOTO	RECEIVE
RESTORE
		MOVF	TPORTB,W
		MOVWF	PORTB
		SWAPF	TSTATUS,W
		MOVWF	STATUS
		MOVF	TTMR0,W
		MOVWF	TMR0
		MOVF	TW,W
		BCF		PIR1,CCP1IF
		RETFIE

SCANNING	BSF		PORTE,0; output
		;	CALL	DELAYP5
			BCF		PORTE,0
			MOVF	DISP1,W
			MOVWF	DISP
			CALL	SCANCOL

			BSF		PORTE,0
			
			BCF		PORTE,0
			MOVF	DISP2,W
			MOVWF	DISP
			CALL	SCANCOL
			BSF		PORTE,0
		
			BCF		PORTE,0
			MOVF	DISP3,W
			MOVWF	DISP
			CALL	SCANCOL
			BSF		PORTE,0

			BCF		PORTE,0
			MOVF	DISP4,W
			MOVWF	DISP
			CALL	SCANCOL
			BSF		PORTE,0

			BCF		PORTE,0
			MOVF	DISP5,W
			MOVWF	DISP
			CALL	SCANCOL
			BSF		PORTE,0

			BCF		PORTE,0
			MOVF	DISP6,W
			MOVWF	DISP
			CALL	SCANCOL
			BSF		PORTE,0
	
			BCF		PORTE,0
			MOVF	DISP7,W
			MOVWF	DISP
			CALL	SCANCOL
			BSF		PORTE,0

			BCF		PORTE,0
			MOVF	DISP8,W
			MOVWF	DISP
			CALL	SCANCOL
			BSF		PORTE,0

			BCF		PORTE,0
			MOVF	DISP9,W
			MOVWF	DISP
			CALL	SCANCOL
			BSF		PORTE,0

			BCF		PORTE,0
			MOVF	DISP10,W
			MOVWF	DISP
			CALL	SCANCOL
			BSF		PORTE,0
	
			BCF		PORTE,0
			MOVF	DISP11,W
			MOVWF	DISP
			CALL	SCANCOL
			BSF		PORTE,0

			BCF		PORTE,0
			MOVF	DISP12,W
			MOVWF	DISP
			CALL	SCANCOL
			BSF		PORTE,0

			BCF		PORTE,0
			MOVF	DISP13,W
			MOVWF	DISP
			CALL	SCANCOL
			BSF		PORTE,0

			BCF		PORTE,0
			MOVF	DISP14,W
			MOVWF	DISP
			CALL	SCANCOL
			BSF		PORTE,0

			BCF		PORTE,0
			MOVF	DISP15,W
			MOVWF	DISP
			CALL	SCANCOL
			BSF		PORTE,0

			BCF		PORTE,0
			MOVF	DISP16,W
			MOVWF	DISP
			CALL	SCANCOL
			BSF		PORTE,0
	
			BCF		PORTE,0
			MOVF	DISP17,W
			MOVWF	DISP
			CALL	SCANCOL
			BSF		PORTE,0

			BCF		PORTE,0
			MOVF	DISP18,W
			MOVWF	DISP
			CALL	SCANCOL
			BSF		PORTE,0

			BCF		PORTE,0
			MOVF	DISP19,W
			MOVWF	DISP
			CALL	SCANCOL
			BSF		PORTE,0

			BCF		PORTE,0
			MOVF	DISP20,W
			MOVWF	DISP
			CALL	SCANCOL
			BSF		PORTE,0

			BCF		PORTE,0
			MOVF	DISP21,W
			MOVWF	DISP
			CALL	SCANCOL
			BSF		PORTE,0

			BCF		PORTE,0
			MOVF	DISP22,W
			MOVWF	DISP
			CALL	SCANCOL
			BSF		PORTE,0

			BCF		PORTE,0
			MOVF	DISP23,W
			MOVWF	DISP
			CALL	SCANCOL
			BSF		PORTE,0
	
			BCF		PORTE,0
			MOVF	DISP24,W
			MOVWF	DISP
			CALL	SCANCOL
			BSF		PORTE,0

			BCF		PORTE,0
			MOVF	DISP25,W
			MOVWF	DISP
			CALL	SCANCOL
			BSF		PORTE,0

			BCF		PORTE,0
			MOVF	DISP26,W
			MOVWF	DISP
			CALL	SCANCOL
			BSF		PORTE,0

			BCF		PORTE,0
			MOVF	DISP27,W
			MOVWF	DISP
			CALL	SCANCOL
			BSF		PORTE,0

			BCF		PORTE,0
			MOVF	DISP28,W
			MOVWF	DISP
			CALL	SCANCOL
			BSF		PORTE,0

			BCF		PORTE,0
			MOVF	DISP29,W
			MOVWF	DISP
			CALL	SCANCOL
			BSF		PORTE,0

			BCF		PORTE,0
			MOVF	DISP30,W
			MOVWF	DISP
			CALL	SCANCOL
			BSF		PORTE,0
			BCF		PORTE,0
;SCANWAIT	BTFSS	PORTE,1		;frOM the second microcontroller
;			GOTO	SCANWAIT
			MOVLW	B'10000000'
			MOVWF	PORTD
			MOVF	DISP31,W
			MOVWF	DISP
			CALL	SCANCOL
			CLRF	PORTD
;GOTO	BACK2
			MOVLW	B'01000000'
			MOVWF	PORTD
			MOVF	DISP32,W
			MOVWF	DISP
			CALL	SCANCOL

			MOVLW	B'00100000'
			MOVWF	PORTD
			MOVF	DISP33,W
			MOVWF	DISP
			CALL	SCANCOL
		
			
			MOVLW	B'00010000'
			MOVWF	PORTD
			MOVF	DISP34,W
			MOVWF	DISP
			CALL	SCANCOL
		

			MOVLW	B'00001000'
			MOVWF	PORTD
			MOVF	DISP35,W
			MOVWF	DISP
			CALL	SCANCOL
		
			MOVLW	B'00000100'
			MOVWF	PORTD
			MOVF	DISP36,W
			MOVWF	DISP
			CALL	SCANCOL
		

			MOVLW	B'00000010'
			MOVWF	PORTD
			MOVF	DISP37,W
			MOVWF	DISP
			CALL	SCANCOL
			
			
			MOVLW	B'00000001'
			MOVWF	PORTD
			MOVF	DISP38,W
			MOVWF	DISP
			CALL	SCANCOL
			CLRF	PORTD
;	GOTO BACK

			MOVLW	B'00000001'
			MOVWF	PORTA
			MOVF	DISP39,W
			MOVWF	DISP
			CALL	SCANCOL
			
			MOVLW	B'00000010'
			MOVWF	PORTA
			MOVF	DISP40,W
			MOVWF	DISP
			CALL	SCANCOL
		;	CLRF	PORTA
			MOVLW	B'00000100'
			MOVWF	PORTA
			MOVF	DISP41,W
			MOVWF	DISP
			CALL	SCANCOL
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
	MOVLW	.8		; CHANGE SPEED
	MOVWF	STILL
BACK2	DECFSZ	STILL
	GOTO	SCANNING
			MOVF	DISP40,W
			MOVWF	DISP41
			MOVF	DISP39,W
			MOVWF	DISP40
			MOVF	DISP38,W
			MOVWF	DISP39
			MOVF	DISP37,W
			MOVWF	DISP38
			MOVF	DISP36,W
			MOVWF	DISP37
			MOVF	DISP35,W
			MOVWF	DISP36
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
	GOTO	D			
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
D	MOVF	ALPHA,W
	SUBLW	23H
	BTFSS	STATUS,ZEROBIT
	GOTO	E
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
					;REMMOVE
	GOTO	DECDISP
E	MOVF	ALPHA,W
	SUBLW	24H
	BTFSS	STATUS,ZEROBIT
	GOTO	F
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
					;REMOVE
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
	CALL	WHILE1
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

M	MOVF	ALPHA,W
	SUBLW	3AH
	BTFSS	STATUS,ZEROBIT
	GOTO	N
	MOVLW	01H
	MOVWF	C1
	MOVLW	0BFH
	MOVWF	C2
	MOVLW	0DFH
	MOVWF	C3
	MOVLW	0BFH
	MOVWF	C4
	MOVLW	01H
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
N	MOVF	ALPHA,W
	SUBLW	31H
	BTFSS	STATUS,ZEROBIT
	GOTO	O
	MOVLW	01H
	MOVWF	C1
	MOVLW	0BFH
	MOVWF	C2
	MOVLW	0DFH
	MOVWF	C3
	MOVLW	0EFH
	MOVWF	C4
	MOVLW	01H
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
	MOVLW	83H
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
P	MOVF	ALPHA,W
	SUBLW	4DH
	BTFSS	STATUS,ZEROBIT
	GOTO	Q
	MOVLW	01H
	MOVWF	C1
	MOVLW	6FH
	MOVWF	C2
	MOVLW	6FH
	MOVWF	C3
	MOVLW	6FH
	MOVWF	C4
	MOVLW	9FH
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
	MOVLW	75H
	MOVWF	C3
	MOVLW	79H
	MOVWF	C4
	MOVLW	81H
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
R	MOVF	ALPHA,W
	SUBLW	2DH
	BTFSS	STATUS,ZEROBIT
	GOTO	S
	MOVLW	01H
	MOVWF	C1
	MOVLW	06FH
	MOVWF	C2
	MOVLW	6FH
	MOVWF	C3
	MOVLW	6FH
	MOVWF	C4
	MOVLW	91H
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
S	MOVF	ALPHA,W
	SUBLW	1BH
	BTFSS	STATUS,ZEROBIT
	GOTO	T
	MOVLW	9BH
	MOVWF	C1
	MOVLW	06DH
	MOVWF	C2
	MOVLW	6DH
	MOVWF	C3
	MOVLW	06DH
	MOVWF	C4
	MOVLW	0B3H
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
T	MOVF	ALPHA,W
	SUBLW	2CH
	BTFSS	STATUS,ZEROBIT
	GOTO	U
	MOVLW	7FH
	MOVWF	C1
	MOVLW	07FH
	MOVWF	C2
	MOVLW	01H
	MOVWF	C3
	MOVLW	07FH
	MOVWF	C4
	MOVLW	07FH
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
U	MOVF	ALPHA,W
	SUBLW	3CH
	BTFSS	STATUS,ZEROBIT
	GOTO	V
	MOVLW	03H
	MOVWF	C1
	MOVLW	0FDH
	MOVWF	C2
	MOVLW	0FDH
	MOVWF	C3
	MOVLW	0FDH
	MOVWF	C4
	MOVLW	03H
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
V	MOVF	ALPHA,W
	SUBLW	2AH
	BTFSS	STATUS,ZEROBIT
	GOTO	W
	MOVLW	07H
	MOVWF	C1
	MOVLW	0FBH
	MOVWF	C2
	MOVLW	0FDH
	MOVWF	C3
	MOVLW	0FBH
	MOVWF	C4
	MOVLW	07H
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
W	MOVF	ALPHA,W
	SUBLW	1DH
	BTFSS	STATUS,ZEROBIT
	GOTO	X
	MOVLW	01H
	MOVWF	C1
	MOVLW	0FBH
	MOVWF	C2
	MOVLW	0F7H
	MOVWF	C3
	MOVLW	0FBH
	MOVWF	C4
	MOVLW	01H
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
X	MOVF	ALPHA,W
	SUBLW	22H
	BTFSS	STATUS,ZEROBIT
	GOTO	Y
	MOVLW	39H
	MOVWF	C1
	MOVLW	0D7H
	MOVWF	C2
	MOVLW	0EFH
	MOVWF	C3
	MOVLW	0D7H
	MOVWF	C4
	MOVLW	39H
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
Y	MOVF	ALPHA,W
	SUBLW	35H
	BTFSS	STATUS,ZEROBIT
	GOTO	Z
	MOVLW	3FH
	MOVWF	C1
	MOVLW	0DFH
	MOVWF	C2
	MOVLW	0E1H
	MOVWF	C3
	MOVLW	0DFH
	MOVWF	C4
	MOVLW	03FH
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
Z	MOVF	ALPHA,W
	SUBLW	1AH
	BTFSS	STATUS,ZEROBIT
	GOTO	M0
	MOVLW	79H
	MOVWF	C1
	MOVLW	075H
	MOVWF	C2
	MOVLW	6DH
	MOVWF	C3
	MOVLW	05DH
	MOVWF	C4
	MOVLW	03DH
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
	MOVLW	083H
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
M1	MOVF	ALPHA,W
	SUBLW	16H
	BTFSS	STATUS,ZEROBIT
	GOTO	M2
	MOVLW	0DDH
	MOVWF	C1
	MOVLW	0BDH
	MOVWF	C2
	MOVLW	01H
	MOVWF	C3
	MOVLW	0FDH
	MOVWF	C4
	MOVLW	0FDH
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
M2	MOVF	ALPHA,W
	SUBLW	1EH
	BTFSS	STATUS,ZEROBIT
	GOTO	M3
	MOVLW	0BDH
	MOVWF	C1
	MOVLW	079H
	MOVWF	C2
	MOVLW	75H
	MOVWF	C3
	MOVLW	06DH
	MOVWF	C4
	MOVLW	09DH
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
M3	MOVF	ALPHA,W
	SUBLW	26H
	BTFSS	STATUS,ZEROBIT
	GOTO	M4
	MOVLW	7BH
	MOVWF	C1
	MOVLW	07DH
	MOVWF	C2
	MOVLW	5DH
	MOVWF	C3
	MOVLW	04DH
	MOVWF	C4
	MOVLW	33H
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
M4	MOVF	ALPHA,W
	SUBLW	25H
	BTFSS	STATUS,ZEROBIT
	GOTO	M5
	MOVLW	0CFH
	MOVWF	C1
	MOVLW	0AFH
	MOVWF	C2
	MOVLW	6FH
	MOVWF	C3
	MOVLW	0EFH
	MOVWF	C4
	MOVLW	01H
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
M5	MOVF	ALPHA,W
	SUBLW	2EH
	BTFSS	STATUS,ZEROBIT
	GOTO	M6
	MOVLW	00BH
	MOVWF	C1
	MOVLW	05DH
	MOVWF	C2
	MOVLW	5DH
	MOVWF	C3
	MOVLW	05DH
	MOVWF	C4
	MOVLW	063H
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
M6	MOVF	ALPHA,W
	SUBLW	36H
	BTFSS	STATUS,ZEROBIT
	GOTO	M7
	MOVLW	83H
	MOVWF	C1
	MOVLW	06DH
	MOVWF	C2
	MOVLW	6DH
	MOVWF	C3
	MOVLW	06DH
	MOVWF	C4
	MOVLW	0B3H
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
M7	MOVF	ALPHA,W
	SUBLW	3DH
	BTFSS	STATUS,ZEROBIT
	GOTO	M8
	MOVLW	79H
	MOVWF	C1
	MOVLW	077H
	MOVWF	C2
	MOVLW	6FH
	MOVWF	C3
	MOVLW	05FH
	MOVWF	C4
	MOVLW	03FH
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
M8	MOVF	ALPHA,W
	SUBLW	3EH
	BTFSS	STATUS,ZEROBIT
	GOTO	M9
	MOVLW	93H
	MOVWF	C1
	MOVLW	06DH
	MOVWF	C2
	MOVLW	6DH
	MOVWF	C3
	MOVLW	06DH
	MOVWF	C4
	MOVLW	093H
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP
M9	MOVF	ALPHA,W
	SUBLW	46H
	BTFSS	STATUS,ZEROBIT
	GOTO	SPC
	MOVLW	9BH
	MOVWF	C1
	MOVLW	06DH
	MOVWF	C2
	MOVLW	6DH
	MOVWF	C3
	MOVLW	06DH
	MOVWF	C4
	MOVLW	083H
	MOVWF	C5
	CALL	WHILE1
	GOTO	DECDISP

SPC	MOVF	ALPHA,W
	SUBLW	29H
	BTFSS	STATUS,ZEROBIT
	GOTO	DECDISP		;INSERT NOTHING
	MOVLW	0FFH
	MOVWF	C1
	MOVLW	0FFH
	MOVWF	C2
	MOVLW	0FFH
	MOVWF	C3
	MOVLW	0FFH
	MOVWF	C4
	MOVLW	0FFH
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

Gg	MOVLW	83H
	MOVWF	C1
	MOVLW	07DH
	MOVWF	C2
	MOVLW	065H
	MOVWF	C3
	MOVLW	06DH
	MOVWF	C4
	MOVLW	0A3H
	MOVWF	C5
	GOTO	WHILE1
			RETURN

Oo	
	MOVLW	83H
	MOVWF	C1
	MOVLW	07DH
	MOVWF	C2
	MOVLW	7DH
	MOVWF	C3
	MOVLW	07DH
	MOVWF	C4
	MOVLW	83H
	MOVWF	C5
	GOTO	WHILE1
	RETURN
Dd	MOVLW	01H
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
	RETURN
F1			MOVF	STORE,W
			MOVWF	FILE1
			RETURN
F2			MOVF	STORE,W
			MOVWF	FILE2
			RETURN
F3			MOVF	STORE,W
			MOVWF	FILE3
			RETURN
F4			MOVF	STORE,W
			MOVWF	FILE4
			RETURN
F5			MOVF	STORE,W
			MOVWF	FILE5
			RETURN
F6			MOVF	STORE,W
			MOVWF	FILE6
			RETURN
F7			MOVF	STORE,W
			MOVWF	FILE7
			RETURN
F8			MOVF	STORE,W
			MOVWF	FILE8
			RETURN
F9			MOVF	STORE,W
			MOVWF	FILE9
			RETURN
F10			MOVF	STORE,W
			MOVWF	FILE10
			RETURN
F11			MOVF	STORE,W
			MOVWF	FILE11
			RETURN
F12			MOVF	STORE,W
			MOVWF	FILE12
			RETURN
F13			MOVF	STORE,W
			MOVWF	FILE13
			RETURN
F14			MOVF	STORE,W
			MOVWF	FILE14
			RETURN
F15			MOVF	STORE,W
			MOVWF	FILE15
			RETURN
F16			MOVF	STORE,W
			MOVWF	FILE16
			RETURN
F17			MOVF	STORE,W
			MOVWF	FILE17
			RETURN
F18			MOVF	STORE,W
			MOVWF	FILE18
			RETURN
F19			MOVF	STORE,W
			MOVWF	FILE19
			RETURN
F20			MOVF	STORE,W
			MOVWF	FILE20
			RETURN
F21			MOVF	STORE,W
			MOVWF	FILE21
			RETURN
F22			MOVF	STORE,W
			MOVWF	FILE22
			RETURN
F23			MOVF	STORE,W
			MOVWF	FILE23
			RETURN
F24			MOVF	STORE,W
			MOVWF	FILE24
			RETURN




F25			MOVF	STORE,W
			BSF		STATUS,5
			MOVWF	FILE25
			BCF		STATUS,5
			RETURN
F26			MOVF	STORE,W
			BSF		STATUS,5
			MOVWF	FILE26
			BCF		STATUS,5
			RETURN
F27			MOVF	STORE,W
			BSF		STATUS,5
			MOVWF	FILE27
			BCF		STATUS,5
			RETURN
F28			MOVF	STORE,W
			BSF		STATUS,5
			MOVWF	FILE28
			BCF		STATUS,5
			RETURN
F29			MOVF	STORE,W
			BSF		STATUS,5
			MOVWF	FILE29
			BCF		STATUS,5
			RETURN
F30			MOVF	STORE,W
			BSF		STATUS,5
			MOVWF	FILE30
			BCF		STATUS,5
			RETURN
F31			MOVF	STORE,W
			BSF		STATUS,5
			MOVWF	FILE31
			BCF		STATUS,5
			RETURN
F32			MOVF	STORE,W
			BSF		STATUS,5
			MOVWF	FILE32
			BCF		STATUS,5
			RETURN
F33			MOVF	STORE,W
			BSF		STATUS,5
			MOVWF	FILE33
			BCF		STATUS,5
			RETURN
F34			MOVF	STORE,W
			BSF		STATUS,5
			MOVWF	FILE34
			BCF		STATUS,5
			RETURN
F35			MOVF	STORE,W
			BSF		STATUS,5
			MOVWF	FILE35
			BCF		STATUS,5
			RETURN
F36			MOVF	STORE,W
			BSF		STATUS,5
			MOVWF	FILE36
			BCF		STATUS,5
			RETURN
F37			MOVF	STORE,W
			BSF		STATUS,5
			MOVWF	FILE37
			BCF		STATUS,5
			RETURN
F38			MOVF	STORE,W
			BSF		STATUS,5
			MOVWF	FILE38
			BCF		STATUS,5
			RETURN
F39			MOVF	STORE,W
			BSF		STATUS,5
			MOVWF	FILE39
			BCF		STATUS,5
			RETURN
F40			MOVF	STORE,W
			BSF		STATUS,5
			MOVWF	FILE40
			BCF		STATUS,5
			RETURN

			BCF		STATUS,5
			RETURN
CLOCK1		BSF		PORTE,1
			BCF		PORTE,1
			RETLW	0
CLOCK2		BSF		PORTE,0
			BCF		PORTE,0
			RETLW	0

SCANCOL	;	MOVF	DISP,W	
;			IORLW	0FEH ;11111110
;			MOVWF	PORTB
;			CALL	DELAYP5
			MOVF	DISP,W
			IORLW	0FDH ;11111101
			MOVWF	PORTB
			CALL	DELAYP5
;	RETURN
			MOVF	DISP,W
			IORLW	0FBH ;11111011
			MOVWF	PORTB
			CALL	DELAYP5
;SCANCOL
			MOVF	DISP,W
			IORLW	0F7H ;11110111
			MOVWF	PORTB
			CALL	DELAYP5	
			MOVF	DISP,W
			IORLW	0EFH ;11101111
			MOVWF	PORTB
			CALL	DELAYP5
	;RETURN
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
			CALL 	DELAYP5
			RETLW	0

GAP		CALL SP
		CALL SP
		CALL SP
		CALL SP
		CALL SP
		CALL SP
		CALL SP
		RETURN
START	CLRF	STATUS
		MOVLW	.4
		MOVWF	CCP1CON
		BSF		STATUS,5
		MOVLW	.1
		MOVWF	TRISB
		MOVLW	0F8H
		MOVWF	TRISA
		MOVLW	.4		;B'00000100'
		MOVWF	TRISC
		MOVLW	.0
		MOVWF	TRISD
		MOVLW	.0						;10
		MOVWF	TRISE
		MOVLW	05H
		MOVWF	OPTION_R
		BSF		PIE1,CCP1IE
		CLRF	STATUS
		CLRF	PORTA
		CLRF	PORTC
		CLRF	PORTD		
		CLRF	PORTE
		CLRF	COUNTER
		CLRF	COUNTER2
;	MOVLW	.255
;		MOVWF	COUNTER2
		CLRF	NUM
		CLRF	FLAG
		CLRF	STORE
		CLRF	SHIFTCOUNT
		
		CLRF	INTCON
		
		BCF		PIR1,CCP1IF
	

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
	MOVLW	.255
	MOVWF	DISP41
	CALL	DELAYWAIT
		BSF		INTCON,GIE
		BSF		INTCON,PEIE
		
;PROGRAM STARTS
BEGIN	CALL 	Gg
		CALL 	Oo 
		CALL 	Oo
		CALL 	Dd
		CALL	SP
		CALL 	Gg
		CALL 	Oo
		CALL 	Dd
		BTFSC	PORTA,4
		GOTO	SKIPPED
		BCF		FLAG,0
FORINT 	BTFSS	FLAG,0		;WAIT FOR INPUT
		GOTO	FORINT  
		BCF		FLAG,0	
		CLRF	COUNTER2
		CALL Dd
		MOVF	STORE,W
		SUBLW	76H	;ESC KEY
		BTFSC	STATUS,ZEROBIT	
		GOTO	FORINT		


	; END OF INPUT WHEN ENTER IS PRESSED
		MOVF	STORE,W
		SUBLW	5AH	;ENTER KEY
		BTFSS	STATUS,ZEROBIT	
		GOTO	WRITE		;WRITE 
FINISH	MOVF	NUM,W		
		MOVWF	STORE		;STORE NUM
		MOVLW	.92
		MOVWF	NUM
		GOTO	WRITENUM	;TO SAVE NUM at address 0
SKIPPED BCF		INTCON,GIE
		BCF		INTCON,PEIE
		MOVLW	.92
		MOVWF	COUNTER2
		CALL	READNUM		;TO READ NUM AND SAVE IN NUM
		CLRF	COUNTER2
		MOVF	STORE,W	;	Not really needed
		MOVWF	NUM			;saved
READLOOP CALL	READ
		MOVLW	HIGH(RAMSTORE)
		MOVWF	PCLATH
		CALL	RAMSTORE	;READS INTO RAM
		CALL	DELAYP5
		CALL 	DELAYP5
	
		GOTO	READLOOP
SAVED	GOTO	DECDISP		;DECODE AND DISPLAY
		
END