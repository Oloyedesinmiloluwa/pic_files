
_main:

;LED BLINK.c,1 :: 		void main()
;LED BLINK.c,4 :: 		TRISB=0;
	CLRF       TRISB+0
;LED BLINK.c,5 :: 		PORTB=0;
	CLRF       PORTB+0
;LED BLINK.c,6 :: 		for( ;;)
L_main0:
;LED BLINK.c,8 :: 		PORTB=0XFF    ;
	MOVLW      255
	MOVWF      PORTB+0
;LED BLINK.c,9 :: 		Delay_ms(1000)  ;
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	DECFSZ     R11+0, 1
	GOTO       L_main3
	NOP
;LED BLINK.c,10 :: 		PORTB=0        ;
	CLRF       PORTB+0
;LED BLINK.c,11 :: 		Delay_ms(1000) ;
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_main4:
	DECFSZ     R13+0, 1
	GOTO       L_main4
	DECFSZ     R12+0, 1
	GOTO       L_main4
	DECFSZ     R11+0, 1
	GOTO       L_main4
	NOP
;LED BLINK.c,12 :: 		}
	GOTO       L_main0
;LED BLINK.c,14 :: 		}
	GOTO       $+0
; end of _main
