
_main:

;gsmc.c,4 :: 		void main() {
;gsmc.c,5 :: 		UART1_Init(9600);               // Initialize UART module at 9600 bps
	MOVLW      129
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;gsmc.c,6 :: 		Delay_ms(100);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	DECFSZ     R11+0, 1
	GOTO       L_main0
	NOP
	NOP
;gsmc.c,7 :: 		TRISD=0;
	CLRF       TRISD+0
;gsmc.c,8 :: 		portd=0;
	CLRF       PORTD+0
;gsmc.c,10 :: 		do{
L_main1:
;gsmc.c,11 :: 		portd.rd7=1;
	BSF        PORTD+0, 7
;gsmc.c,12 :: 		UART1_Write_Text("A\r\n"); /* Transmit AT to the module – GSM Modem sendsOK */
	MOVLW      ?lstr1_gsmc+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;gsmc.c,13 :: 		Delay_ms(3000);
	MOVLW      77
	MOVWF      R11+0
	MOVLW      25
	MOVWF      R12+0
	MOVLW      79
	MOVWF      R13+0
L_main4:
	DECFSZ     R13+0, 1
	GOTO       L_main4
	DECFSZ     R12+0, 1
	GOTO       L_main4
	DECFSZ     R11+0, 1
	GOTO       L_main4
	NOP
	NOP
;gsmc.c,14 :: 		UART1_Write_Text("AT\r\n"); /* Transmit AT to the module – GSM Modem sendsOK */
	MOVLW      ?lstr2_gsmc+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;gsmc.c,15 :: 		Delay_ms(2000); /* 2 sec delay */
	MOVLW      51
	MOVWF      R11+0
	MOVLW      187
	MOVWF      R12+0
	MOVLW      223
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	DECFSZ     R11+0, 1
	GOTO       L_main5
	NOP
	NOP
;gsmc.c,17 :: 		while(UART1_Data_Ready())
L_main6:
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main7
;gsmc.c,19 :: 		data1=UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _data1+0
;gsmc.c,20 :: 		EEPROM_Write(0x01+j,data1);
	INCF       _j+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       R0+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;gsmc.c,21 :: 		j++;
	INCF       _j+0, 1
;gsmc.c,23 :: 		}
	GOTO       L_main6
L_main7:
;gsmc.c,25 :: 		UART1_Write_Text("ATE0\r\n"); /* Echo Off */
	MOVLW      ?lstr3_gsmc+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;gsmc.c,26 :: 		Delay_ms(2000); /* 2 sec delay */
	MOVLW      51
	MOVWF      R11+0
	MOVLW      187
	MOVWF      R12+0
	MOVLW      223
	MOVWF      R13+0
L_main8:
	DECFSZ     R13+0, 1
	GOTO       L_main8
	DECFSZ     R12+0, 1
	GOTO       L_main8
	DECFSZ     R11+0, 1
	GOTO       L_main8
	NOP
	NOP
;gsmc.c,27 :: 		UART1_Write_Text("ATD09032892040\r\n");
	MOVLW      ?lstr4_gsmc+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;gsmc.c,28 :: 		Delay_ms(8000);
	MOVLW      203
	MOVWF      R11+0
	MOVLW      236
	MOVWF      R12+0
	MOVLW      132
	MOVWF      R13+0
L_main9:
	DECFSZ     R13+0, 1
	GOTO       L_main9
	DECFSZ     R12+0, 1
	GOTO       L_main9
	DECFSZ     R11+0, 1
	GOTO       L_main9
	NOP
;gsmc.c,29 :: 		portd.rd7=0;
	BCF        PORTD+0, 7
;gsmc.c,30 :: 		UART1_Write_Text("AT+CMGF=1\r\n"); /* Switch to text mode */
	MOVLW      ?lstr5_gsmc+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;gsmc.c,31 :: 		Delay_ms(2000); /* 2 sec delay */
	MOVLW      51
	MOVWF      R11+0
	MOVLW      187
	MOVWF      R12+0
	MOVLW      223
	MOVWF      R13+0
L_main10:
	DECFSZ     R13+0, 1
	GOTO       L_main10
	DECFSZ     R12+0, 1
	GOTO       L_main10
	DECFSZ     R11+0, 1
	GOTO       L_main10
	NOP
	NOP
;gsmc.c,32 :: 		UART1_Write_Text("AT+CMGS=\"09032892040\"\r\n"); /* Send SMS to a cell number */
	MOVLW      ?lstr6_gsmc+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;gsmc.c,33 :: 		Delay_ms(2000); /* 2 sec delay */
	MOVLW      51
	MOVWF      R11+0
	MOVLW      187
	MOVWF      R12+0
	MOVLW      223
	MOVWF      R13+0
L_main11:
	DECFSZ     R13+0, 1
	GOTO       L_main11
	DECFSZ     R12+0, 1
	GOTO       L_main11
	DECFSZ     R11+0, 1
	GOTO       L_main11
	NOP
	NOP
;gsmc.c,34 :: 		UART1_Write_Text("TEST DATA FROM RhydoLABZ-COCHIN"); /* Input SMS Data */
	MOVLW      ?lstr7_gsmc+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;gsmc.c,35 :: 		UART1_Write(0x1a); /* Ctrl-Z indicates end of SMS */
	MOVLW      26
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;gsmc.c,36 :: 		Delay_ms(2000); /* 2 sec delay */
	MOVLW      51
	MOVWF      R11+0
	MOVLW      187
	MOVWF      R12+0
	MOVLW      223
	MOVWF      R13+0
L_main12:
	DECFSZ     R13+0, 1
	GOTO       L_main12
	DECFSZ     R12+0, 1
	GOTO       L_main12
	DECFSZ     R11+0, 1
	GOTO       L_main12
	NOP
	NOP
;gsmc.c,38 :: 		i++     ;
	INCF       _i+0, 1
;gsmc.c,40 :: 		while(i<4);
	MOVLW      4
	SUBWF      _i+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main1
;gsmc.c,41 :: 		}
	GOTO       $+0
; end of _main
