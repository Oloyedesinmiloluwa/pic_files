
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;pwm.c,3 :: 		void interrupt(){
;pwm.c,6 :: 		}
L__interrupt0:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;pwm.c,7 :: 		void main() {
;pwm.c,8 :: 		PORTB = 0;                          // set PORTB to 0
	CLRF       PORTB+0
;pwm.c,9 :: 		TRISB = 0;                          // designate PORTB pins as output
	CLRF       TRISB+0
;pwm.c,10 :: 		PORTC = 0;                          // set PORTC to 0
	CLRF       PORTC+0
;pwm.c,11 :: 		TRISC = 0;
	CLRF       TRISC+0
;pwm.c,12 :: 		T1CON=0b00000001;
	MOVLW      1
	MOVWF      T1CON+0
;pwm.c,13 :: 		TMR1IF_BIT=0;
	BCF        TMR1IF_bit+0, 0
;pwm.c,14 :: 		TMR1H=0XFF;
	MOVLW      255
	MOVWF      TMR1H+0
;pwm.c,15 :: 		TMR1L=76;
	MOVLW      76
	MOVWF      TMR1L+0
;pwm.c,16 :: 		TMR1IE_BIT=1;
	BSF        TMR1IE_bit+0, 0
;pwm.c,17 :: 		PWM1_Init(2000);                    // Initialize PWM1 module at 5KHz
	BSF        T2CON+0, 0
	BSF        T2CON+0, 1
	MOVLW      156
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;pwm.c,18 :: 		PWM2_Init(2000);
	BSF        T2CON+0, 0
	BSF        T2CON+0, 1
	MOVLW      156
	MOVWF      PR2+0
	CALL       _PWM2_Init+0
;pwm.c,19 :: 		duty1 =50; duty2=50;
	MOVLW      50
	MOVWF      _duty1+0
	MOVLW      50
	MOVWF      _duty2+0
;pwm.c,20 :: 		pwm1_start();
	CALL       _PWM1_Start+0
;pwm.c,21 :: 		pwm2_start();
	CALL       _PWM2_Start+0
;pwm.c,22 :: 		pwm1_set_duty(duty1);
	MOVF       _duty1+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;pwm.c,23 :: 		pwm2_set_duty(duty2);
	MOVF       _duty2+0, 0
	MOVWF      FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;pwm.c,25 :: 		}
	GOTO       $+0
; end of _main
