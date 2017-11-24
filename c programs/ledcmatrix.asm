
_Send_Data:

;ledcmatrix.c,27 :: 		void Send_Data(unsigned short rw){
;ledcmatrix.c,29 :: 		for (num = 0; num < 5; num++) {
	CLRF       Send_Data_num_L0+0
L_Send_Data0:
	MOVLW      5
	SUBWF      Send_Data_num_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Send_Data1
;ledcmatrix.c,30 :: 		Mask = 0x01;
	MOVLW      1
	MOVWF      Send_Data_Mask_L0+0
;ledcmatrix.c,32 :: 		for (t=0; t<8; t++){              //each bit
	CLRF       Send_Data_t_L0+0
L_Send_Data3:
	MOVLW      8
	SUBWF      Send_Data_t_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Send_Data4
;ledcmatrix.c,33 :: 		if(num==3&&t==6)
	MOVF       Send_Data_num_L0+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_Send_Data8
	MOVF       Send_Data_t_L0+0, 0
	XORLW      6
	BTFSS      STATUS+0, 2
	GOTO       L_Send_Data8
L__Send_Data42:
;ledcmatrix.c,35 :: 		EBuffer=Buffer[rw][3]<<2      ;
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
;ledcmatrix.c,36 :: 		EBuffer.rd0 = Buffer[rw][2].rd6      ;
	MOVLW      2
	ADDWF      R2+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	BTFSC      R0+0, 6
	GOTO       L__Send_Data43
	BCF        Send_Data_EBuffer_L0+0, 0
	GOTO       L__Send_Data44
L__Send_Data43:
	BSF        Send_Data_EBuffer_L0+0, 0
L__Send_Data44:
;ledcmatrix.c,37 :: 		EBuffer.rd1 = Buffer[rw][2].rd7      ;
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	BTFSC      R0+0, 7
	GOTO       L__Send_Data45
	BCF        Send_Data_EBuffer_L0+0, 1
	GOTO       L__Send_Data46
L__Send_Data45:
	BSF        Send_Data_EBuffer_L0+0, 1
L__Send_Data46:
;ledcmatrix.c,38 :: 		EEBuffer.rd0 =  Buffer[rw][4].rd6    ;
	MOVLW      4
	ADDWF      R2+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	BTFSC      R0+0, 6
	GOTO       L__Send_Data47
	BCF        Send_Data_EEBuffer_L0+0, 0
	GOTO       L__Send_Data48
L__Send_Data47:
	BSF        Send_Data_EEBuffer_L0+0, 0
L__Send_Data48:
;ledcmatrix.c,39 :: 		EEBuffer.rd1 =  Buffer[rw][4].rd7    ;
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	BTFSC      R0+0, 7
	GOTO       L__Send_Data49
	BCF        Send_Data_EEBuffer_L0+0, 1
	GOTO       L__Send_Data50
L__Send_Data49:
	BSF        Send_Data_EEBuffer_L0+0, 1
L__Send_Data50:
;ledcmatrix.c,40 :: 		PORTC.b0 = 1    ;    //to alert the sec IC
	BSF        PORTC+0, 0
;ledcmatrix.c,42 :: 		PORTC.b0 = 0;
	BCF        PORTC+0, 0
;ledcmatrix.c,44 :: 		PORTD  =EBuffer;
	MOVF       Send_Data_EBuffer_L0+0, 0
	MOVWF      PORTD+0
;ledcmatrix.c,45 :: 		PORTA  =EEBuffer;
	MOVF       Send_Data_EEBuffer_L0+0, 0
	MOVWF      PORTA+0
;ledcmatrix.c,47 :: 		return;
	RETURN
;ledcmatrix.c,48 :: 		}  //if
L_Send_Data8:
;ledcmatrix.c,49 :: 		Fflag = Buffer[rw][num] & Mask;
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
	MOVF       Send_Data_Mask_L0+0, 0
	ANDWF      INDF+0, 0
	MOVWF      R1+0
;ledcmatrix.c,50 :: 		if(Fflag==0) PORTC.b1 = 0;
	MOVF       R1+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_Send_Data9
	BCF        PORTC+0, 1
	GOTO       L_Send_Data10
L_Send_Data9:
;ledcmatrix.c,51 :: 		else PORTC.b1 = 1;
	BSF        PORTC+0, 1
L_Send_Data10:
;ledcmatrix.c,52 :: 		PORTC.b0 = 1    ;    //to
	BSF        PORTC+0, 0
;ledcmatrix.c,54 :: 		PORTC.b0 = 0;
	BCF        PORTC+0, 0
;ledcmatrix.c,56 :: 		Mask = Mask << 1;
	RLF        Send_Data_Mask_L0+0, 1
	BCF        Send_Data_Mask_L0+0, 0
;ledcmatrix.c,32 :: 		for (t=0; t<8; t++){              //each bit
	INCF       Send_Data_t_L0+0, 1
;ledcmatrix.c,58 :: 		}
	GOTO       L_Send_Data3
L_Send_Data4:
;ledcmatrix.c,29 :: 		for (num = 0; num < 5; num++) {
	INCF       Send_Data_num_L0+0, 1
;ledcmatrix.c,59 :: 		}
	GOTO       L_Send_Data0
L_Send_Data1:
;ledcmatrix.c,72 :: 		}
	RETURN
; end of _Send_Data

_Delay_onesec:

;ledcmatrix.c,172 :: 		void Delay_onesec(){
;ledcmatrix.c,173 :: 		Delay_ms(1000);
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_Delay_onesec11:
	DECFSZ     R13+0, 1
	GOTO       L_Delay_onesec11
	DECFSZ     R12+0, 1
	GOTO       L_Delay_onesec11
	DECFSZ     R11+0, 1
	GOTO       L_Delay_onesec11
	NOP
;ledcmatrix.c,174 :: 		}
	RETURN
; end of _Delay_onesec

_Find_StrLength:

;ledcmatrix.c,175 :: 		unsigned short Find_StrLength(){
;ledcmatrix.c,176 :: 		return strlen(message);
	MOVLW      _message+0
	MOVWF      FARG_strlen_s+0
	CALL       _strlen+0
;ledcmatrix.c,177 :: 		}
	RETURN
; end of _Find_StrLength

_Save_Message:

;ledcmatrix.c,179 :: 		void Save_Message(){
;ledcmatrix.c,180 :: 		EEPROM_Write(0x00, 1);
	CLRF       FARG_EEPROM_Write_Address+0
	MOVLW      1
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;ledcmatrix.c,181 :: 		EEPROM_Write(0x01, StringLength);
	MOVLW      1
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _StringLength+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;ledcmatrix.c,182 :: 		for(i=0; i<StringLength; i++){
	CLRF       _i+0
L_Save_Message12:
	MOVF       _StringLength+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__Save_Message51
	MOVF       _StringLength+0, 0
	SUBWF      _i+0, 0
L__Save_Message51:
	BTFSC      STATUS+0, 0
	GOTO       L_Save_Message13
;ledcmatrix.c,183 :: 		EEPROM_Write(i+2, message[i]);
	MOVLW      2
	ADDWF      _i+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _i+0, 0
	ADDLW      _message+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;ledcmatrix.c,182 :: 		for(i=0; i<StringLength; i++){
	INCF       _i+0, 1
;ledcmatrix.c,184 :: 		}
	GOTO       L_Save_Message12
L_Save_Message13:
;ledcmatrix.c,185 :: 		EEPROM_Write(i+2, 32);
	MOVLW      2
	ADDWF      _i+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      32
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;ledcmatrix.c,186 :: 		EEPROM_Write(i+3, 32);
	MOVLW      3
	ADDWF      _i+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      32
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;ledcmatrix.c,187 :: 		EEPROM_Write(i+4, 32);
	MOVLW      4
	ADDWF      _i+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      32
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;ledcmatrix.c,188 :: 		EEPROM_Write(i+5, 32);
	MOVLW      5
	ADDWF      _i+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      32
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;ledcmatrix.c,190 :: 		}
	RETURN
; end of _Save_Message

_Load_Data:

;ledcmatrix.c,194 :: 		void Load_Data(){
;ledcmatrix.c,195 :: 		for (k=0; k<StringLength+4; k++){
	CLRF       _k+0
L_Load_Data15:
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
	GOTO       L__Load_Data52
	MOVF       R1+0, 0
	SUBWF      _k+0, 0
L__Load_Data52:
	BTFSC      STATUS+0, 0
	GOTO       L_Load_Data16
;ledcmatrix.c,196 :: 		message[k] = EEPROM_Read(k+2);
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
;ledcmatrix.c,195 :: 		for (k=0; k<StringLength+4; k++){
	INCF       _k+0, 1
;ledcmatrix.c,197 :: 		}
	GOTO       L_Load_Data15
L_Load_Data16:
;ledcmatrix.c,198 :: 		}
	RETURN
; end of _Load_Data

_main:

;ledcmatrix.c,200 :: 		void main() {
;ledcmatrix.c,202 :: 		OPTION_REG  =0x05;
	MOVLW      5
	MOVWF      OPTION_REG+0
;ledcmatrix.c,203 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;ledcmatrix.c,204 :: 		TRISC = 0x00;
	CLRF       TRISC+0
;ledcmatrix.c,205 :: 		TRISE = 0x00;
	CLRF       TRISE+0
;ledcmatrix.c,206 :: 		TRISB = 0x00;
	CLRF       TRISB+0
;ledcmatrix.c,208 :: 		ADCON0=0x00;
	CLRF       ADCON0+0
;ledcmatrix.c,209 :: 		PORTB=0x00;
	CLRF       PORTB+0
;ledcmatrix.c,210 :: 		PORTD=0x00;
	CLRF       PORTD+0
;ledcmatrix.c,211 :: 		PORTC=0x00;
	CLRF       PORTC+0
;ledcmatrix.c,214 :: 		PORTE=0xFF;
	MOVLW      255
	MOVWF      PORTE+0
;ledcmatrix.c,216 :: 		PIE1 =  0b00000100;
	MOVLW      4
	MOVWF      PIE1+0
;ledcmatrix.c,217 :: 		CCP1CON =0x04;
	MOVLW      4
	MOVWF      CCP1CON+0
;ledcmatrix.c,218 :: 		INTCON = 0b11000000;
	MOVLW      192
	MOVWF      INTCON+0
;ledcmatrix.c,219 :: 		PIR1.CCP1IF=0;
	BCF        PIR1+0, 2
;ledcmatrix.c,221 :: 		UserIP = EEPROM_Read(0x00);
	CLRF       FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _UserIP+0
;ledcmatrix.c,223 :: 		if(UserIP == 1) {
	MOVF       R0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main18
;ledcmatrix.c,224 :: 		StringLength = EEPROM_Read(0x01);
	MOVLW      1
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _StringLength+0
	CLRF       _StringLength+1
;ledcmatrix.c,225 :: 		Load_Data();  // Read stored data and save into RAM
	CALL       _Load_Data+0
;ledcmatrix.c,226 :: 		}
	GOTO       L_main19
L_main18:
;ledcmatrix.c,227 :: 		else  StringLength = 156;
	MOVLW      156
	MOVWF      _StringLength+0
	CLRF       _StringLength+1
L_main19:
;ledcmatrix.c,228 :: 		PORTC.b0 = 1    ;    //to
	BSF        PORTC+0, 0
;ledcmatrix.c,229 :: 		PORTC.b0 = 0;
	BCF        PORTC+0, 0
;ledcmatrix.c,230 :: 		Delay_us(1000);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_main20:
	DECFSZ     R13+0, 1
	GOTO       L_main20
	DECFSZ     R12+0, 1
	GOTO       L_main20
;ledcmatrix.c,231 :: 		PORTC.b0 = 1    ;    //to
	BSF        PORTC+0, 0
;ledcmatrix.c,232 :: 		PORTC.b0 = 0;
	BCF        PORTC+0, 0
;ledcmatrix.c,233 :: 		do {
L_main21:
;ledcmatrix.c,234 :: 		for (k=0; k<StringLength+4; k++){
	CLRF       _k+0
L_main24:
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
	GOTO       L__main53
	MOVF       R1+0, 0
	SUBWF      _k+0, 0
L__main53:
	BTFSC      STATUS+0, 0
	GOTO       L_main25
;ledcmatrix.c,235 :: 		for (scroll=0; scroll<(8/shift_step); scroll++) {
	CLRF       _scroll+0
L_main27:
	MOVF       _shift_step+0, 0
	MOVWF      R4+0
	MOVLW      8
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R0+0, 0
	SUBWF      _scroll+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main28
;ledcmatrix.c,236 :: 		for (row=0; row<8; row++){
	CLRF       _row+0
L_main30:
	MOVLW      8
	SUBWF      _row+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main31
;ledcmatrix.c,237 :: 		if(UserIP == 1) index = message[k];
	MOVF       _UserIP+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main33
	MOVF       _k+0, 0
	ADDLW      _message+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      _index+0
	GOTO       L_main34
L_main33:
;ledcmatrix.c,238 :: 		else index = default_message[k];
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
L_main34:
;ledcmatrix.c,239 :: 		temp = CharData[index-32][row];
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
L__main54:
	BTFSC      STATUS+0, 2
	GOTO       L__main55
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__main54
L__main55:
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
;ledcmatrix.c,240 :: 		Buffer[row][4] = (Buffer[row][4] << Shift_Step) | (Buffer[row][3] >> (8-Shift_Step));
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
L__main56:
	BTFSC      STATUS+0, 2
	GOTO       L__main57
	RLF        R3+0, 1
	BCF        R3+0, 0
	ADDLW      255
	GOTO       L__main56
L__main57:
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
;ledcmatrix.c,241 :: 		Buffer[row][3] = (Buffer[row][3] << Shift_Step) | (Buffer[row][2] >> (8-Shift_Step));
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
L__main60:
	BTFSC      STATUS+0, 2
	GOTO       L__main61
	RLF        R3+0, 1
	BCF        R3+0, 0
	ADDLW      255
	GOTO       L__main60
L__main61:
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
;ledcmatrix.c,242 :: 		Buffer[row][2] = (Buffer[row][2] << Shift_Step) | (Buffer[row][1] >> (8-Shift_Step));
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
L__main64:
	BTFSC      STATUS+0, 2
	GOTO       L__main65
	RLF        R3+0, 1
	BCF        R3+0, 0
	ADDLW      255
	GOTO       L__main64
L__main65:
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
L__main66:
	BTFSC      STATUS+0, 2
	GOTO       L__main67
	RRF        R0+0, 1
	BCF        R0+0, 7
	ADDLW      255
	GOTO       L__main66
L__main67:
	MOVF       R3+0, 0
	IORWF      R0+0, 1
	MOVF       R4+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;ledcmatrix.c,243 :: 		Buffer[row][1] = (Buffer[row][1] << Shift_Step) | (Buffer[row][0] >> (8-Shift_Step));
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
L__main68:
	BTFSC      STATUS+0, 2
	GOTO       L__main69
	RLF        R3+0, 1
	BCF        R3+0, 0
	ADDLW      255
	GOTO       L__main68
L__main69:
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
L__main70:
	BTFSC      STATUS+0, 2
	GOTO       L__main71
	RRF        R0+0, 1
	BCF        R0+0, 7
	ADDLW      255
	GOTO       L__main70
L__main71:
	MOVF       R3+0, 0
	IORWF      R0+0, 1
	MOVF       R4+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;ledcmatrix.c,244 :: 		Buffer[row][0] = (Buffer[row][0] << Shift_Step)| (temp >> ((8-shift_step)-scroll*shift_step));
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
L__main72:
	BTFSC      STATUS+0, 2
	GOTO       L__main73
	RLF        FLOC__main+2, 1
	BCF        FLOC__main+2, 0
	ADDLW      255
	GOTO       L__main72
L__main73:
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
L__main74:
	BTFSC      STATUS+0, 2
	GOTO       L__main75
	RRF        R0+0, 1
	BCF        R0+0, 7
	ADDLW      255
	GOTO       L__main74
L__main75:
	MOVF       FLOC__main+2, 0
	IORWF      R0+0, 1
	MOVF       FLOC__main+3, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;ledcmatrix.c,236 :: 		for (row=0; row<8; row++){
	INCF       _row+0, 1
;ledcmatrix.c,245 :: 		}
	GOTO       L_main30
L_main31:
;ledcmatrix.c,246 :: 		speed = 10;
	MOVLW      10
	MOVWF      _speed+0
	MOVLW      0
	MOVWF      _speed+1
;ledcmatrix.c,247 :: 		for(l=0; l<speed;l++){
	CLRF       _l+0
L_main35:
	MOVF       _speed+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main76
	MOVF       _speed+0, 0
	SUBWF      _l+0, 0
L__main76:
	BTFSC      STATUS+0, 0
	GOTO       L_main36
;ledcmatrix.c,248 :: 		m = 1;
	MOVLW      1
	MOVWF      _m+0
;ledcmatrix.c,249 :: 		for (i=0; i<8; i++) {    //each row
	CLRF       _i+0
L_main38:
	MOVLW      8
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main39
;ledcmatrix.c,250 :: 		Send_Data(i);
	MOVF       _i+0, 0
	MOVWF      FARG_Send_Data_rw+0
	CALL       _Send_Data+0
;ledcmatrix.c,252 :: 		PORTB=~m;
	COMF       _m+0, 0
	MOVWF      PORTB+0
;ledcmatrix.c,253 :: 		m = m << 1;
	RLF        _m+0, 1
	BCF        _m+0, 0
;ledcmatrix.c,254 :: 		Delay_us(1000);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_main41:
	DECFSZ     R13+0, 1
	GOTO       L_main41
	DECFSZ     R12+0, 1
	GOTO       L_main41
;ledcmatrix.c,249 :: 		for (i=0; i<8; i++) {    //each row
	INCF       _i+0, 1
;ledcmatrix.c,255 :: 		}  // i
	GOTO       L_main38
L_main39:
;ledcmatrix.c,247 :: 		for(l=0; l<speed;l++){
	INCF       _l+0, 1
;ledcmatrix.c,256 :: 		} // l
	GOTO       L_main35
L_main36:
;ledcmatrix.c,235 :: 		for (scroll=0; scroll<(8/shift_step); scroll++) {
	INCF       _scroll+0, 1
;ledcmatrix.c,257 :: 		} // scroll
	GOTO       L_main27
L_main28:
;ledcmatrix.c,234 :: 		for (k=0; k<StringLength+4; k++){
	INCF       _k+0, 1
;ledcmatrix.c,258 :: 		} // k
	GOTO       L_main24
L_main25:
;ledcmatrix.c,260 :: 		} while(1);
	GOTO       L_main21
;ledcmatrix.c,261 :: 		}
	GOTO       $+0
; end of _main
