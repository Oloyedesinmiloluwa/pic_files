
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;SPWM.c,6 :: 		void interrupt()
;SPWM.c,8 :: 		flag=1;
	MOVLW      1
	MOVWF      _flag+0
;SPWM.c,9 :: 		portc.rd0=1;
	BSF        PORTC+0, 0
;SPWM.c,11 :: 		TMR1IF_bit = 0; // clear TMR0IF
	BCF        TMR1IF_bit+0, 0
;SPWM.c,12 :: 		TMR1H = 0xFF; // Initialize Timer1 register
	MOVLW      255
	MOVWF      TMR1H+0
;SPWM.c,13 :: 		TMR1L = 0x05;
	MOVLW      5
	MOVWF      TMR1L+0
;SPWM.c,14 :: 		}
L__interrupt15:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;SPWM.c,15 :: 		void main()
;SPWM.c,18 :: 		TRISB = 0; // designate PORTB pins as output
	CLRF       TRISB+0
;SPWM.c,19 :: 		PORTC = 0; // set PORTC to 0
	CLRF       PORTC+0
;SPWM.c,20 :: 		PORTB = 0; // set PORTC to 0
	CLRF       PORTB+0
;SPWM.c,21 :: 		TRISC = 0; // designate PORTC pins as output
	CLRF       TRISC+0
;SPWM.c,22 :: 		TRISA = 0; // designate PORTB pins as output
	CLRF       TRISA+0
;SPWM.c,23 :: 		PORTA = 0; // set PORTA to 0
	CLRF       PORTA+0
;SPWM.c,24 :: 		TMR1IF_bit = 0; // clear TMR1IF
	BCF        TMR1IF_bit+0, 0
;SPWM.c,25 :: 		TMR1H = 0xFF; // Initialize Timer1 register
	MOVLW      255
	MOVWF      TMR1H+0
;SPWM.c,26 :: 		TMR1L = 0x05;
	MOVLW      5
	MOVWF      TMR1L+0
;SPWM.c,27 :: 		TMR1IE_bit = 1; // enable Timer1 interrupT
	BSF        TMR1IE_bit+0, 0
;SPWM.c,28 :: 		INTCON.GIE=1;
	BSF        INTCON+0, 7
;SPWM.c,29 :: 		PEIE_bit  =1;
	BSF        PEIE_bit+0, 6
;SPWM.c,31 :: 		cnt = 0; // initialize cnt
	CLRF       _cnt+0
;SPWM.c,32 :: 		dec=0;
	CLRF       _dec+0
;SPWM.c,33 :: 		flag=0;
	CLRF       _flag+0
;SPWM.c,34 :: 		PWM1_Init(20000);
	BCF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      249
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;SPWM.c,36 :: 		T1CON= 0b00001001; // Timer1 settings
	MOVLW      9
	MOVWF      T1CON+0
;SPWM.c,37 :: 		PWM1_Set_Duty(SinLkUpTab[cnt]);
	MOVF       _cnt+0, 0
	ADDLW      _SinLkUpTab+0
	MOVWF      R0+0
	MOVLW      hi_addr(_SinLkUpTab+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;SPWM.c,38 :: 		PWM1_Start();
	CALL       _PWM1_Start+0
;SPWM.c,39 :: 		while(1){
L_main0:
;SPWM.c,40 :: 		if(flag==1)       //wait for interrupt
	MOVF       _flag+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main2
;SPWM.c,42 :: 		portb=cnt;//porta.rc0 =cnt;
	MOVF       _cnt+0, 0
	MOVWF      PORTB+0
;SPWM.c,44 :: 		if(cnt==0 && dec==1)
	MOVF       _cnt+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main5
	MOVF       _dec+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main5
L__main14:
;SPWM.c,45 :: 		{     portc.ra4=~portc.ra4;
	MOVLW      16
	XORWF      PORTC+0, 1
;SPWM.c,46 :: 		dec=0;
	CLRF       _dec+0
;SPWM.c,47 :: 		toogle=~toogle;
	COMF       _toogle+0, 1
;SPWM.c,48 :: 		PWM1_Set_Duty(SinLkUpTab[cnt]);
	MOVF       _cnt+0, 0
	ADDLW      _SinLkUpTab+0
	MOVWF      R0+0
	MOVLW      hi_addr(_SinLkUpTab+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;SPWM.c,49 :: 		}
	GOTO       L_main6
L_main5:
;SPWM.c,52 :: 		if(cnt==49&&dec==0)
	MOVF       _cnt+0, 0
	XORLW      49
	BTFSS      STATUS+0, 2
	GOTO       L_main9
	MOVF       _dec+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main9
L__main13:
;SPWM.c,54 :: 		cnt=50;
	MOVLW      50
	MOVWF      _cnt+0
;SPWM.c,55 :: 		dec= 1;
	MOVLW      1
	MOVWF      _dec+0
;SPWM.c,56 :: 		}
L_main9:
;SPWM.c,57 :: 		if (dec==0)
	MOVF       _dec+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main10
;SPWM.c,59 :: 		cnt++;
	INCF       _cnt+0, 1
;SPWM.c,60 :: 		PWM1_Set_Duty(SinLkUpTab[cnt]);
	MOVF       _cnt+0, 0
	ADDLW      _SinLkUpTab+0
	MOVWF      R0+0
	MOVLW      hi_addr(_SinLkUpTab+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;SPWM.c,61 :: 		}
	GOTO       L_main11
L_main10:
;SPWM.c,62 :: 		else if (dec==1)
	MOVF       _dec+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main12
;SPWM.c,64 :: 		portc.ra3=~portc.ra3;
	MOVLW      8
	XORWF      PORTC+0, 1
;SPWM.c,65 :: 		cnt-=10;
	MOVLW      10
	SUBWF      _cnt+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _cnt+0
;SPWM.c,66 :: 		PWM1_Set_Duty(SinLkUpTab[cnt]);
	MOVLW      0
	MOVWF      R0+1
	MOVLW      _SinLkUpTab+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_SinLkUpTab+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;SPWM.c,68 :: 		}
L_main12:
L_main11:
;SPWM.c,69 :: 		}
L_main6:
;SPWM.c,70 :: 		}
L_main2:
;SPWM.c,71 :: 		}
	GOTO       L_main0
;SPWM.c,72 :: 		}
	GOTO       $+0
; end of _main
