
_Send_Data:

;serialmatrix1.c,23 :: 		void Send_Data(unsigned short rw){
;serialmatrix1.c,25 :: 		for (num = 0; num < 5; num++) {
	CLRF       Send_Data_num_L0+0
L_Send_Data0:
	MOVLW      5
	SUBWF      Send_Data_num_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Send_Data1
;serialmatrix1.c,26 :: 		if(num==4)
	MOVF       Send_Data_num_L0+0, 0
	XORLW      4
	BTFSS      STATUS+0, 2
	GOTO       L_Send_Data3
;serialmatrix1.c,28 :: 		EBuffer=Buffer[rw][3]<<2      ;
	MOVF       FARG_Send_Data_rw+0, 0
	MOVWF      R0+0
	MOVLW      5
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVF       R0+0, 0
	ADDLW      _Buffer+0
	MOVWF      R2+0
	MOVLW      3
	ADDWF      R2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      Send_Data_EBuffer_L0+0
	RLF        Send_Data_EBuffer_L0+0, 1
	BCF        Send_Data_EBuffer_L0+0, 0
	RLF        Send_Data_EBuffer_L0+0, 1
	BCF        Send_Data_EBuffer_L0+0, 0
;serialmatrix1.c,29 :: 		EBuffer.rd0 = Buffer[rw][2].rd6      ;
	MOVLW      2
	ADDWF      R2+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	BTFSC      R0+0, 6
	GOTO       L__Send_Data35
	BCF        Send_Data_EBuffer_L0+0, 0
	GOTO       L__Send_Data36
L__Send_Data35:
	BSF        Send_Data_EBuffer_L0+0, 0
L__Send_Data36:
;serialmatrix1.c,30 :: 		EBuffer.rd1 = Buffer[rw][2].rd7      ;
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	BTFSC      R0+0, 7
	GOTO       L__Send_Data37
	BCF        Send_Data_EBuffer_L0+0, 1
	GOTO       L__Send_Data38
L__Send_Data37:
	BSF        Send_Data_EBuffer_L0+0, 1
L__Send_Data38:
;serialmatrix1.c,31 :: 		EEBuffer.rd0 =  Buffer[rw][4].rd6    ;
	MOVLW      4
	ADDWF      R2+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	BTFSC      R0+0, 6
	GOTO       L__Send_Data39
	BCF        Send_Data_EEBuffer_L0+0, 0
	GOTO       L__Send_Data40
L__Send_Data39:
	BSF        Send_Data_EEBuffer_L0+0, 0
L__Send_Data40:
;serialmatrix1.c,32 :: 		EEBuffer.rd1 =  Buffer[rw][4].rd7    ;
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	BTFSC      R0+0, 7
	GOTO       L__Send_Data41
	BCF        Send_Data_EEBuffer_L0+0, 1
	GOTO       L__Send_Data42
L__Send_Data41:
	BSF        Send_Data_EEBuffer_L0+0, 1
L__Send_Data42:
;serialmatrix1.c,33 :: 		UART1_Write(13)  ;
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;serialmatrix1.c,34 :: 		PORTD  =EBuffer;
	MOVF       Send_Data_EBuffer_L0+0, 0
	MOVWF      PORTD+0
;serialmatrix1.c,35 :: 		PORTA  =EEBuffer;
	MOVF       Send_Data_EEBuffer_L0+0, 0
	MOVWF      PORTA+0
;serialmatrix1.c,37 :: 		return;
	RETURN
;serialmatrix1.c,38 :: 		}  //if
L_Send_Data3:
;serialmatrix1.c,39 :: 		UART1_Write(Buffer[rw][num]);
	MOVF       FARG_Send_Data_rw+0, 0
	MOVWF      R0+0
	MOVLW      5
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVLW      _Buffer+0
	ADDWF      R0+0, 1
	MOVF       Send_Data_num_L0+0, 0
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;serialmatrix1.c,25 :: 		for (num = 0; num < 5; num++) {
	INCF       Send_Data_num_L0+0, 1
;serialmatrix1.c,41 :: 		}
	GOTO       L_Send_Data0
L_Send_Data1:
;serialmatrix1.c,42 :: 		}
	RETURN
; end of _Send_Data

_Delay_onesec:

;serialmatrix1.c,145 :: 		void Delay_onesec(){
;serialmatrix1.c,146 :: 		Delay_ms(1000);
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_Delay_onesec4:
	DECFSZ     R13+0, 1
	GOTO       L_Delay_onesec4
	DECFSZ     R12+0, 1
	GOTO       L_Delay_onesec4
	DECFSZ     R11+0, 1
	GOTO       L_Delay_onesec4
	NOP
;serialmatrix1.c,147 :: 		}
	RETURN
; end of _Delay_onesec

_Find_StrLength:

;serialmatrix1.c,148 :: 		unsigned short Find_StrLength(){
;serialmatrix1.c,149 :: 		return strlen(message);
	MOVLW      _message+0
	MOVWF      FARG_strlen_s+0
	CALL       _strlen+0
;serialmatrix1.c,150 :: 		}
	RETURN
; end of _Find_StrLength

_Save_Message:

;serialmatrix1.c,152 :: 		void Save_Message(){
;serialmatrix1.c,153 :: 		EEPROM_Write(0x00, 1);
	CLRF       FARG_EEPROM_Write_Address+0
	MOVLW      1
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;serialmatrix1.c,154 :: 		EEPROM_Write(0x01, StringLength);
	MOVLW      1
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _StringLength+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;serialmatrix1.c,155 :: 		for(i=0; i<StringLength; i++){
	CLRF       _i+0
L_Save_Message5:
	MOVF       _StringLength+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__Save_Message43
	MOVF       _StringLength+0, 0
	SUBWF      _i+0, 0
L__Save_Message43:
	BTFSC      STATUS+0, 0
	GOTO       L_Save_Message6
;serialmatrix1.c,156 :: 		EEPROM_Write(i+2, message[i]);
	MOVLW      2
	ADDWF      _i+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _i+0, 0
	ADDLW      _message+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;serialmatrix1.c,155 :: 		for(i=0; i<StringLength; i++){
	INCF       _i+0, 1
;serialmatrix1.c,157 :: 		}
	GOTO       L_Save_Message5
L_Save_Message6:
;serialmatrix1.c,158 :: 		EEPROM_Write(i+2, 32);
	MOVLW      2
	ADDWF      _i+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      32
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;serialmatrix1.c,159 :: 		EEPROM_Write(i+3, 32);
	MOVLW      3
	ADDWF      _i+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      32
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;serialmatrix1.c,160 :: 		EEPROM_Write(i+4, 32);
	MOVLW      4
	ADDWF      _i+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      32
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;serialmatrix1.c,161 :: 		EEPROM_Write(i+5, 32);
	MOVLW      5
	ADDWF      _i+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      32
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;serialmatrix1.c,163 :: 		}
	RETURN
; end of _Save_Message

_Load_Data:

;serialmatrix1.c,167 :: 		void Load_Data(){
;serialmatrix1.c,168 :: 		for (k=0; k<StringLength+4; k++){
	CLRF       _k+0
L_Load_Data8:
	MOVLW      4
	ADDWF      _StringLength+0, 0
	MOVWF      R1+0
	MOVF       _StringLength+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R1+1
	MOVF       R1+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__Load_Data44
	MOVF       R1+0, 0
	SUBWF      _k+0, 0
L__Load_Data44:
	BTFSC      STATUS+0, 0
	GOTO       L_Load_Data9
;serialmatrix1.c,169 :: 		message[k] = EEPROM_Read(k+2);
	MOVF       _k+0, 0
	ADDLW      _message+0
	MOVWF      FLOC__Load_Data+0
	MOVLW      2
	ADDWF      _k+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       FLOC__Load_Data+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;serialmatrix1.c,168 :: 		for (k=0; k<StringLength+4; k++){
	INCF       _k+0, 1
;serialmatrix1.c,170 :: 		}
	GOTO       L_Load_Data8
L_Load_Data9:
;serialmatrix1.c,171 :: 		}
	RETURN
; end of _Load_Data

_main:

;serialmatrix1.c,173 :: 		void main() {
;serialmatrix1.c,176 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;serialmatrix1.c,177 :: 		TRISC = 0x80;
	MOVLW      128
	MOVWF      TRISC+0
;serialmatrix1.c,178 :: 		TRISE = 0x00;
	CLRF       TRISE+0
;serialmatrix1.c,179 :: 		TRISB = 0x00;
	CLRF       TRISB+0
;serialmatrix1.c,181 :: 		ADCON0=0x00;
	CLRF       ADCON0+0
;serialmatrix1.c,182 :: 		PORTB=0x00;
	CLRF       PORTB+0
;serialmatrix1.c,183 :: 		PORTD=0x00;
	CLRF       PORTD+0
;serialmatrix1.c,184 :: 		PORTC=0x00;
	CLRF       PORTC+0
;serialmatrix1.c,189 :: 		UART1_Init(19200);               // Initialize UART module at 9600 bps
	MOVLW      64
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;serialmatrix1.c,190 :: 		Delay_ms(100);                  // Wait for UART module to stabilize
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
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
;serialmatrix1.c,196 :: 		UserIP = EEPROM_Read(0x00);
	CLRF       FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _UserIP+0
;serialmatrix1.c,198 :: 		if(UserIP == 1) {
	MOVF       R0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main12
;serialmatrix1.c,199 :: 		StringLength = EEPROM_Read(0x01);
	MOVLW      1
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _StringLength+0
	CLRF       _StringLength+1
;serialmatrix1.c,200 :: 		Load_Data();  // Read stored data and save into RAM
	CALL       _Load_Data+0
;serialmatrix1.c,201 :: 		}
	GOTO       L_main13
L_main12:
;serialmatrix1.c,202 :: 		else  StringLength = 156;
	MOVLW      156
	MOVWF      _StringLength+0
	CLRF       _StringLength+1
L_main13:
;serialmatrix1.c,204 :: 		do {
L_main14:
;serialmatrix1.c,205 :: 		for (k=0; k<StringLength+4; k++){
	CLRF       _k+0
L_main17:
	MOVLW      4
	ADDWF      _StringLength+0, 0
	MOVWF      R1+0
	MOVF       _StringLength+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R1+1
	MOVF       R1+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main45
	MOVF       R1+0, 0
	SUBWF      _k+0, 0
L__main45:
	BTFSC      STATUS+0, 0
	GOTO       L_main18
;serialmatrix1.c,206 :: 		for (scroll=0; scroll<(8/shift_step); scroll++) {
	CLRF       _scroll+0
L_main20:
	MOVF       _shift_step+0, 0
	MOVWF      R4+0
	MOVLW      8
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R0+0, 0
	SUBWF      _scroll+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main21
;serialmatrix1.c,207 :: 		for (row=0; row<8; row++){
	CLRF       _row+0
L_main23:
	MOVLW      8
	SUBWF      _row+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main24
;serialmatrix1.c,208 :: 		if(UserIP == 1) index = message[k];
	MOVF       _UserIP+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main26
	MOVF       _k+0, 0
	ADDLW      _message+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      _index+0
	GOTO       L_main27
L_main26:
;serialmatrix1.c,209 :: 		else index = default_message[k];
	MOVF       _k+0, 0
	ADDLW      _default_message+0
	MOVWF      R0+0
	MOVLW      hi_addr(_default_message+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      _index+0
L_main27:
;serialmatrix1.c,210 :: 		temp = CharData[index-32][row];
	MOVLW      32
	SUBWF      _index+0, 0
	MOVWF      R3+0
	CLRF       R3+1
	BTFSS      STATUS+0, 0
	DECF       R3+1, 1
	MOVLW      3
	MOVWF      R2+0
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__main46:
	BTFSC      STATUS+0, 2
	GOTO       L__main47
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__main46
L__main47:
	MOVLW      _CharData+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_CharData+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       _row+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      _temp+0
;serialmatrix1.c,211 :: 		Buffer[row][4] = (Buffer[row][4] << Shift_Step) | (Buffer[row][3] >> (8-Shift_Step));
	MOVF       _row+0, 0
	MOVWF      R0+0
	MOVLW      5
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVF       R0+0, 0
	ADDLW      _Buffer+0
	MOVWF      R2+0
	MOVLW      4
	ADDWF      R2+0, 0
	MOVWF      R4+0
	MOVF       R4+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVF       _shift_step+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
	MOVWF      R3+0
	MOVF       R0+0, 0
L__main48:
	BTFSC      STATUS+0, 2
	GOTO       L__main49
	RLF        R3+0, 1
	BCF        R3+0, 0
	ADDLW      255
	GOTO       L__main48
L__main49:
	MOVLW      3
	ADDWF      R2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R2+0
	MOVF       _shift_step+0, 0
	SUBLW      8
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      R1+0
	MOVF       R2+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
L__main50:
	BTFSC      STATUS+0, 2
	GOTO       L__main51
	RRF        R0+0, 1
	BCF        R0+0, 7
	ADDLW      255
	GOTO       L__main50
L__main51:
	MOVF       R3+0, 0
	IORWF      R0+0, 1
	MOVF       R4+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;serialmatrix1.c,212 :: 		Buffer[row][3] = (Buffer[row][3] << Shift_Step) | (Buffer[row][2] >> (8-Shift_Step));
	MOVF       _row+0, 0
	MOVWF      R0+0
	MOVLW      5
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVF       R0+0, 0
	ADDLW      _Buffer+0
	MOVWF      R2+0
	MOVLW      3
	ADDWF      R2+0, 0
	MOVWF      R4+0
	MOVF       R4+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVF       _shift_step+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
	MOVWF      R3+0
	MOVF       R0+0, 0
L__main52:
	BTFSC      STATUS+0, 2
	GOTO       L__main53
	RLF        R3+0, 1
	BCF        R3+0, 0
	ADDLW      255
	GOTO       L__main52
L__main53:
	MOVLW      2
	ADDWF      R2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R2+0
	MOVF       _shift_step+0, 0
	SUBLW      8
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      R1+0
	MOVF       R2+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
L__main54:
	BTFSC      STATUS+0, 2
	GOTO       L__main55
	RRF        R0+0, 1
	BCF        R0+0, 7
	ADDLW      255
	GOTO       L__main54
L__main55:
	MOVF       R3+0, 0
	IORWF      R0+0, 1
	MOVF       R4+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;serialmatrix1.c,213 :: 		Buffer[row][2] = (Buffer[row][2] << Shift_Step) | (Buffer[row][1] >> (8-Shift_Step));
	MOVF       _row+0, 0
	MOVWF      R0+0
	MOVLW      5
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVF       R0+0, 0
	ADDLW      _Buffer+0
	MOVWF      R2+0
	MOVLW      2
	ADDWF      R2+0, 0
	MOVWF      R4+0
	MOVF       R4+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVF       _shift_step+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
	MOVWF      R3+0
	MOVF       R0+0, 0
L__main56:
	BTFSC      STATUS+0, 2
	GOTO       L__main57
	RLF        R3+0, 1
	BCF        R3+0, 0
	ADDLW      255
	GOTO       L__main56
L__main57:
	INCF       R2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R2+0
	MOVF       _shift_step+0, 0
	SUBLW      8
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      R1+0
	MOVF       R2+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
L__main58:
	BTFSC      STATUS+0, 2
	GOTO       L__main59
	RRF        R0+0, 1
	BCF        R0+0, 7
	ADDLW      255
	GOTO       L__main58
L__main59:
	MOVF       R3+0, 0
	IORWF      R0+0, 1
	MOVF       R4+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;serialmatrix1.c,214 :: 		Buffer[row][1] = (Buffer[row][1] << Shift_Step) | (Buffer[row][0] >> (8-Shift_Step));
	MOVF       _row+0, 0
	MOVWF      R0+0
	MOVLW      5
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVF       R0+0, 0
	ADDLW      _Buffer+0
	MOVWF      R2+0
	INCF       R2+0, 0
	MOVWF      R4+0
	MOVF       R4+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVF       _shift_step+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
	MOVWF      R3+0
	MOVF       R0+0, 0
L__main60:
	BTFSC      STATUS+0, 2
	GOTO       L__main61
	RLF        R3+0, 1
	BCF        R3+0, 0
	ADDLW      255
	GOTO       L__main60
L__main61:
	MOVF       R2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R2+0
	MOVF       _shift_step+0, 0
	SUBLW      8
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      R1+0
	MOVF       R2+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
L__main62:
	BTFSC      STATUS+0, 2
	GOTO       L__main63
	RRF        R0+0, 1
	BCF        R0+0, 7
	ADDLW      255
	GOTO       L__main62
L__main63:
	MOVF       R3+0, 0
	IORWF      R0+0, 1
	MOVF       R4+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;serialmatrix1.c,215 :: 		Buffer[row][0] = (Buffer[row][0] << Shift_Step)| (temp >> ((8-shift_step)-scroll*shift_step));
	MOVF       _row+0, 0
	MOVWF      R0+0
	MOVLW      5
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVLW      _Buffer+0
	ADDWF      R0+0, 1
	MOVF       R0+0, 0
	MOVWF      FLOC__main+3
	MOVF       R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVF       _shift_step+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
	MOVWF      FLOC__main+2
	MOVF       R0+0, 0
L__main64:
	BTFSC      STATUS+0, 2
	GOTO       L__main65
	RLF        FLOC__main+2, 1
	BCF        FLOC__main+2, 0
	ADDLW      255
	GOTO       L__main64
L__main65:
	MOVF       _shift_step+0, 0
	SUBLW      8
	MOVWF      FLOC__main+0
	CLRF       FLOC__main+1
	BTFSS      STATUS+0, 0
	DECF       FLOC__main+1, 1
	MOVF       _scroll+0, 0
	MOVWF      R0+0
	MOVF       _shift_step+0, 0
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVF       R0+0, 0
	SUBWF      FLOC__main+0, 0
	MOVWF      R0+0
	MOVF       R0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      FLOC__main+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      R1+0
	MOVF       _temp+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
L__main66:
	BTFSC      STATUS+0, 2
	GOTO       L__main67
	RRF        R0+0, 1
	BCF        R0+0, 7
	ADDLW      255
	GOTO       L__main66
L__main67:
	MOVF       FLOC__main+2, 0
	IORWF      R0+0, 1
	MOVF       FLOC__main+3, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;serialmatrix1.c,207 :: 		for (row=0; row<8; row++){
	INCF       _row+0, 1
;serialmatrix1.c,216 :: 		}
	GOTO       L_main23
L_main24:
;serialmatrix1.c,217 :: 		speed = 10;
	MOVLW      10
	MOVWF      _speed+0
	MOVLW      0
	MOVWF      _speed+1
;serialmatrix1.c,218 :: 		for(l=0; l<speed;l++){
	CLRF       _l+0
L_main28:
	MOVF       _speed+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main68
	MOVF       _speed+0, 0
	SUBWF      _l+0, 0
L__main68:
	BTFSC      STATUS+0, 0
	GOTO       L_main29
;serialmatrix1.c,219 :: 		m = 1;
	MOVLW      1
	MOVWF      _m+0
;serialmatrix1.c,220 :: 		for (i=0; i<8; i++) {    //each row
	CLRF       _i+0
L_main31:
	MOVLW      8
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main32
;serialmatrix1.c,221 :: 		Send_Data(i);
	MOVF       _i+0, 0
	MOVWF      FARG_Send_Data_rw+0
	CALL       _Send_Data+0
;serialmatrix1.c,223 :: 		PORTB=~m;
	COMF       _m+0, 0
	MOVWF      PORTB+0
;serialmatrix1.c,224 :: 		m = m << 1;
	RLF        _m+0, 1
	BCF        _m+0, 0
;serialmatrix1.c,225 :: 		Delay_us(1000);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_main34:
	DECFSZ     R13+0, 1
	GOTO       L_main34
	DECFSZ     R12+0, 1
	GOTO       L_main34
;serialmatrix1.c,220 :: 		for (i=0; i<8; i++) {    //each row
	INCF       _i+0, 1
;serialmatrix1.c,226 :: 		}  // i
	GOTO       L_main31
L_main32:
;serialmatrix1.c,218 :: 		for(l=0; l<speed;l++){
	INCF       _l+0, 1
;serialmatrix1.c,227 :: 		} // l
	GOTO       L_main28
L_main29:
;serialmatrix1.c,206 :: 		for (scroll=0; scroll<(8/shift_step); scroll++) {
	INCF       _scroll+0, 1
;serialmatrix1.c,228 :: 		} // scroll
	GOTO       L_main20
L_main21:
;serialmatrix1.c,205 :: 		for (k=0; k<StringLength+4; k++){
	INCF       _k+0, 1
;serialmatrix1.c,229 :: 		} // k
	GOTO       L_main17
L_main18:
;serialmatrix1.c,231 :: 		} while(1);
	GOTO       L_main14
;serialmatrix1.c,232 :: 		}
	GOTO       $+0
; end of _main
