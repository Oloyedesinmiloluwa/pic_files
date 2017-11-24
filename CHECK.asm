TMR0 EQU 1 ;means TMR0 is file 1.
STATUS EQU 3 ;means STATUS is file 3.
PORTA EQU 5 ;means PORTA is file 5.
PORTB EQU 6 ;means PORTB is file 6.
ZEROBIT EQU 2 ;means ZEROBIT is bit 2.
ADCON0 EQU 1FH ;A/D Configuration reg.0
ADCON1 EQU 9FH ;A/D Configuration reg.1
ADRES EQU 1EH ;A/D Result register.
CARRY EQU 0 ;CARRY IS BIT 0.
TRISA EQU 85H ;PORTA Configuration Register
TRISB EQU 86H ;PORTB Configuration Register
OPTION_R EQU 81H ;Option Register
OSCCON EQU 8FH ;Oscillator control register.
COUNT EQU 20H ;COUNT a register to count events
;*********************************************************
LIST P=16F818 ;we are using the 16F818.
ORG 0 ;the start address in memory is 0
GOTO START ;goto start!
;*********************************************************
; Configuration Bits
__CONFIG H'3F10' ;sets INTRC-A6 is port I/O, WDT off, PUT on,
;MCLR tied to VDD A5 is I/O
;BOD off, LVP disabled, EE protect disabled,
;Flash Program Write disabled,

;Background Debugger Mode disabled, CCP
;function on B2,
;Code Protection disabled.
;*********************************************************
;CONFIGURATION SECTION.
START BSF STATUS,5 ;Turns to Bank1.
MOVLW B'00011111' ;5bits of PORTA are I/P
MOVWF TRISA
MOVLW B'00000010' ;A0, A1 are analogue
MOVWF ADCON1 ;A2, A3 are digital I/P.
MOVLW B'00000000'
MOVWF TRISB ;PORTB is OUTPUT
BCF STATUS,5 ;Return to Bank0.
MOVLW B'00000001' ;Turns on A/D converter,
MOVWF ADCON0 ;and selects channel AN0
CLRF PORTA ;Clears PortA.
CLRF PORTB ;Clears PortB.
;PROGRAM STARTS

BEGIN BSF ADCON0,2 ;Take Measurement.
WAIT BTFSC ADCON0,2 ;Wait until reading done.
GOTO WAIT
MOVF ADRES,W ;Move A/D Result into W
CLRF PORTB ;Clear PortB.
SUBLW .26 ;26-,W. W is altered
BTFSC STATUS,CARRY ;Is W4 or 526
GOTO BEGIN ;W is 526 (0.5v)
MOVF ADRES,W ;Move A/D Result into W
BSF PORTB,0 ;Turn on B0.
SUBLW .51 ;51-,W. W is altered
BTFSC STATUS,CARRY ;Is W4 or 551
GOTO BEGIN ;W is 551 (1.0v)
MOVF ADRES,W ;Move A/D Result into W
BSF PORTB,1 ;Turn on B1.
SUBLW .77 ;77-,W. W is altered
BTFSC STATUS,CARRY ;Is W4 or 577
GOTO BEGIN ;W is 577 (1.5v)
MOVF ADRES,W ;Move A/D Result into W
BSF PORTB,2 ;Turn on B2.
SUBLW .102 ;102-,W. W is altered
BTFSC STATUS,CARRY ;Is W4 or 5102
GOTO BEGIN ;W is 5102 (2.0v)
MOVF ADRES,W ;Move A/D Result into W
BSF PORTB,3 ;Turn on B3.
SUBLW .128 ;128-,W. W is altered
BTFSC STATUS,CARRY ;Is W4 or 5128
GOTO BEGIN ;W is 5128 (2.5v)
MOVF ADRES,W ;Move A/D Result into W
BSF PORTB,4 ;Turn on B4.
SUBLW .153 ;153-,W. W is altered
BTFSC STATUS,CARRY ;Is W4 or 5153
GOTO BEGIN ;W is 5153 (3.0v)
MOVF ADRES,W ;Move A/D Result into W
BSF PORTB,5 ;Turn on B5.
SUBLW .179 ;179-,W. W is altered
BTFSC STATUS,CARRY ;Is W4 or 5179
GOTO BEGIN ;W is 5179 (3.5v)
MOVF ADRES,W ;Move A/D Result into W
BSF PORTB,6 ;Turn on B6.
SUBLW .204 ;204-,W. W is altered
BTFSC STATUS,CARRY ;Is W4 or 5204
GOTO BEGIN ;W is 5204 (4.0v)
BSF PORTB,7 ;Turn on B7.
GOTO BEGIN
END