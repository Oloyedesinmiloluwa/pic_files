
_Send_Data:

;matrix48.c,27 :: 		void Send_Data(unsigned short rw){
;matrix48.c,29 :: 		for (num = 0; num < 6; num++) {
	CLRF        Send_Data_num_L0+0 
L_Send_Data0:
	MOVLW       6
	SUBWF       Send_Data_num_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Send_Data1
;matrix48.c,30 :: 		Mask = 0x01;
	MOVLW       1
	MOVWF       Send_Data_Mask_L0+0 
;matrix48.c,32 :: 		for (t=0; t<8; t++){              //each bit
	CLRF        Send_Data_t_L0+0 
L_Send_Data3:
	MOVLW       8
	SUBWF       Send_Data_t_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Send_Data4
;matrix48.c,34 :: 		Fflag = Buffer[rw][num] & Mask;
	MOVF        FARG_Send_Data_rw+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       6
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Buffer+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Buffer+0)
	ADDWFC      R1, 1 
	MOVF        Send_Data_num_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        Send_Data_Mask_L0+0, 0 
	ANDWF       POSTINC0+0, 0 
	MOVWF       R1 
;matrix48.c,35 :: 		if(Fflag==0) PORTD.b0 = 0;
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Send_Data6
	BCF         PORTD+0, 0 
	GOTO        L_Send_Data7
L_Send_Data6:
;matrix48.c,36 :: 		else PORTD.b0 = 1;
	BSF         PORTD+0, 0 
L_Send_Data7:
;matrix48.c,38 :: 		PORTD.b1 = 1    ;    //to
	BSF         PORTD+0, 1 
;matrix48.c,39 :: 		PORTD.b1 = 0;
	BCF         PORTD+0, 1 
;matrix48.c,42 :: 		Mask = Mask << 1;
	RLCF        Send_Data_Mask_L0+0, 1 
	BCF         Send_Data_Mask_L0+0, 0 
;matrix48.c,32 :: 		for (t=0; t<8; t++){              //each bit
	INCF        Send_Data_t_L0+0, 1 
;matrix48.c,43 :: 		}
	GOTO        L_Send_Data3
L_Send_Data4:
;matrix48.c,29 :: 		for (num = 0; num < 6; num++) {
	INCF        Send_Data_num_L0+0, 1 
;matrix48.c,44 :: 		}
	GOTO        L_Send_Data0
L_Send_Data1:
;matrix48.c,45 :: 		PORTD.b2 = 1    ;    //to
	BSF         PORTD+0, 2 
;matrix48.c,46 :: 		PORTD.b2 = 0;
	BCF         PORTD+0, 2 
;matrix48.c,47 :: 		}
	RETURN      0
; end of _Send_Data

_Find_StrLength:

;matrix48.c,109 :: 		unsigned short Find_StrLength(){
;matrix48.c,110 :: 		return strlen(message);
	MOVLW       _message+0
	MOVWF       FARG_strlen_s+0 
	MOVLW       hi_addr(_message+0)
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
;matrix48.c,111 :: 		}
	RETURN      0
; end of _Find_StrLength

_Save_Message:

;matrix48.c,113 :: 		void Save_Message(){
;matrix48.c,114 :: 		EEPROM_Write(0x01, StringLength);
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _StringLength+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;matrix48.c,115 :: 		for(i=0; i<StringLength; i++){
	CLRF        _i+0 
L_Save_Message8:
	MOVLW       0
	MOVWF       R0 
	MOVF        _StringLength+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Save_Message79
	MOVF        _StringLength+0, 0 
	SUBWF       _i+0, 0 
L__Save_Message79:
	BTFSC       STATUS+0, 0 
	GOTO        L_Save_Message9
;matrix48.c,116 :: 		EEPROM_Write(i+2, message[i]);
	MOVLW       2
	ADDWF       _i+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       _message+0
	MOVWF       FSR0L 
	MOVLW       hi_addr(_message+0)
	MOVWF       FSR0H 
	MOVF        _i+0, 0 
	ADDWF       FSR0L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;matrix48.c,117 :: 		Delay_ms(5);
	MOVLW       33
	MOVWF       R12, 0
	MOVLW       118
	MOVWF       R13, 0
L_Save_Message11:
	DECFSZ      R13, 1, 1
	BRA         L_Save_Message11
	DECFSZ      R12, 1, 1
	BRA         L_Save_Message11
	NOP
;matrix48.c,115 :: 		for(i=0; i<StringLength; i++){
	INCF        _i+0, 1 
;matrix48.c,118 :: 		}
	GOTO        L_Save_Message8
L_Save_Message9:
;matrix48.c,120 :: 		EEPROM_Write(i+2, 32);
	MOVLW       2
	ADDWF       _i+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       32
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;matrix48.c,121 :: 		Delay_ms(5);
	MOVLW       33
	MOVWF       R12, 0
	MOVLW       118
	MOVWF       R13, 0
L_Save_Message12:
	DECFSZ      R13, 1, 1
	BRA         L_Save_Message12
	DECFSZ      R12, 1, 1
	BRA         L_Save_Message12
	NOP
;matrix48.c,122 :: 		EEPROM_Write(i+3, 32);
	MOVLW       3
	ADDWF       _i+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       32
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;matrix48.c,123 :: 		Delay_ms(5);
	MOVLW       33
	MOVWF       R12, 0
	MOVLW       118
	MOVWF       R13, 0
L_Save_Message13:
	DECFSZ      R13, 1, 1
	BRA         L_Save_Message13
	DECFSZ      R12, 1, 1
	BRA         L_Save_Message13
	NOP
;matrix48.c,124 :: 		EEPROM_Write(i+4, 32);
	MOVLW       4
	ADDWF       _i+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       32
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;matrix48.c,125 :: 		Delay_ms(5);
	MOVLW       33
	MOVWF       R12, 0
	MOVLW       118
	MOVWF       R13, 0
L_Save_Message14:
	DECFSZ      R13, 1, 1
	BRA         L_Save_Message14
	DECFSZ      R12, 1, 1
	BRA         L_Save_Message14
	NOP
;matrix48.c,126 :: 		EEPROM_Write(i+5, 32);
	MOVLW       5
	ADDWF       _i+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       32
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;matrix48.c,127 :: 		Delay_ms(5);
	MOVLW       33
	MOVWF       R12, 0
	MOVLW       118
	MOVWF       R13, 0
L_Save_Message15:
	DECFSZ      R13, 1, 1
	BRA         L_Save_Message15
	DECFSZ      R12, 1, 1
	BRA         L_Save_Message15
	NOP
;matrix48.c,128 :: 		EEPROM_Write(i+6, 32);
	MOVLW       6
	ADDWF       _i+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       32
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;matrix48.c,129 :: 		Delay_ms(5);
	MOVLW       33
	MOVWF       R12, 0
	MOVLW       118
	MOVWF       R13, 0
L_Save_Message16:
	DECFSZ      R13, 1, 1
	BRA         L_Save_Message16
	DECFSZ      R12, 1, 1
	BRA         L_Save_Message16
	NOP
;matrix48.c,130 :: 		}
	RETURN      0
; end of _Save_Message

_Load_Data:

;matrix48.c,132 :: 		void Load_Data(){
;matrix48.c,133 :: 		for (k=0; k<StringLength+5; k++){
	CLRF        _k+0 
L_Load_Data17:
	MOVLW       5
	ADDWF       _StringLength+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _StringLength+1, 0 
	MOVWF       R2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Load_Data80
	MOVF        R1, 0 
	SUBWF       _k+0, 0 
L__Load_Data80:
	BTFSC       STATUS+0, 0 
	GOTO        L_Load_Data18
;matrix48.c,134 :: 		message[k] = EEPROM_Read(k+2);
	MOVLW       _message+0
	MOVWF       FLOC__Load_Data+0 
	MOVLW       hi_addr(_message+0)
	MOVWF       FLOC__Load_Data+1 
	MOVF        _k+0, 0 
	ADDWF       FLOC__Load_Data+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__Load_Data+1, 1 
	MOVLW       2
	ADDWF       _k+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVFF       FLOC__Load_Data+0, FSR1L
	MOVFF       FLOC__Load_Data+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;matrix48.c,135 :: 		Delay_ms(5);
	MOVLW       33
	MOVWF       R12, 0
	MOVLW       118
	MOVWF       R13, 0
L_Load_Data20:
	DECFSZ      R13, 1, 1
	BRA         L_Load_Data20
	DECFSZ      R12, 1, 1
	BRA         L_Load_Data20
	NOP
;matrix48.c,133 :: 		for (k=0; k<StringLength+5; k++){
	INCF        _k+0, 1 
;matrix48.c,136 :: 		}
	GOTO        L_Load_Data17
L_Load_Data18:
;matrix48.c,137 :: 		}
	RETURN      0
; end of _Load_Data

_main:

;matrix48.c,139 :: 		void main() {
;matrix48.c,142 :: 		TRISD = 0x00;
	CLRF        TRISD+0 
;matrix48.c,146 :: 		TRISE = 0x00;
	CLRF        TRISE+0 
;matrix48.c,147 :: 		TRISB = 0x00;
	CLRF        TRISB+0 
;matrix48.c,149 :: 		ADCON0=0x00;
	CLRF        ADCON0+0 
;matrix48.c,150 :: 		PORTB=0x00;
	CLRF        PORTB+0 
;matrix48.c,151 :: 		PORTD=0x00;
	CLRF        PORTD+0 
;matrix48.c,152 :: 		PORTE=0x00;
	CLRF        PORTE+0 
;matrix48.c,153 :: 		UART1_Init(115200);
	MOVLW       10
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;matrix48.c,154 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main21:
	DECFSZ      R13, 1, 1
	BRA         L_main21
	DECFSZ      R12, 1, 1
	BRA         L_main21
	DECFSZ      R11, 1, 1
	BRA         L_main21
	NOP
	NOP
;matrix48.c,155 :: 		Ps2_Config();
	CALL        _Ps2_Config+0, 0
;matrix48.c,157 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main22:
	DECFSZ      R13, 1, 1
	BRA         L_main22
	DECFSZ      R12, 1, 1
	BRA         L_main22
	DECFSZ      R11, 1, 1
	BRA         L_main22
	NOP
	NOP
;matrix48.c,183 :: 		StringLength = EEPROM_Read(0x01);
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _StringLength+0 
	MOVLW       0
	MOVWF       _StringLength+1 
;matrix48.c,184 :: 		Load_Data();  // Read stored data and save into RAM
	CALL        _Load_Data+0, 0
;matrix48.c,186 :: 		do {
L_main23:
;matrix48.c,187 :: 		for (k=0; k<StringLength+5; k++){
	CLRF        _k+0 
L_main26:
	MOVLW       5
	ADDWF       _StringLength+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _StringLength+1, 0 
	MOVWF       R2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main81
	MOVF        R1, 0 
	SUBWF       _k+0, 0 
L__main81:
	BTFSC       STATUS+0, 0 
	GOTO        L_main27
;matrix48.c,188 :: 		for (scroll=0; scroll<(8/shift_step); scroll++) {
	CLRF        _scroll+0 
L_main29:
	MOVF        _shift_step+0, 0 
	MOVWF       R4 
	MOVLW       8
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R0, 0 
	SUBWF       _scroll+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main30
;matrix48.c,189 :: 		for (row=0; row<7; row++){
	CLRF        _row+0 
L_main32:
	MOVLW       7
	SUBWF       _row+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main33
;matrix48.c,191 :: 		if(Ps2_Key_Read(&keydata, &special, &down)) {
	MOVLW       _keydata+0
	MOVWF       FARG_Ps2_Key_Read_value+0 
	MOVLW       hi_addr(_keydata+0)
	MOVWF       FARG_Ps2_Key_Read_value+1 
	MOVLW       _special+0
	MOVWF       FARG_Ps2_Key_Read_special+0 
	MOVLW       hi_addr(_special+0)
	MOVWF       FARG_Ps2_Key_Read_special+1 
	MOVLW       _down+0
	MOVWF       FARG_Ps2_Key_Read_pressed+0 
	MOVLW       hi_addr(_down+0)
	MOVWF       FARG_Ps2_Key_Read_pressed+1 
	CALL        _Ps2_Key_Read+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main35
;matrix48.c,192 :: 		if (down && (keydata == 34)) {
	MOVF        _down+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main38
	MOVF        _keydata+0, 0 
	XORLW       34
	BTFSS       STATUS+0, 2 
	GOTO        L_main38
L__main78:
;matrix48.c,193 :: 		PORTB= 0;
	CLRF        PORTB+0 
;matrix48.c,196 :: 		do{
L_main39:
;matrix48.c,197 :: 		if(Ps2_Key_Read(&keydata, &special, &down)) {
	MOVLW       _keydata+0
	MOVWF       FARG_Ps2_Key_Read_value+0 
	MOVLW       hi_addr(_keydata+0)
	MOVWF       FARG_Ps2_Key_Read_value+1 
	MOVLW       _special+0
	MOVWF       FARG_Ps2_Key_Read_special+0 
	MOVLW       hi_addr(_special+0)
	MOVWF       FARG_Ps2_Key_Read_special+1 
	MOVLW       _down+0
	MOVWF       FARG_Ps2_Key_Read_pressed+0 
	MOVLW       hi_addr(_down+0)
	MOVWF       FARG_Ps2_Key_Read_pressed+1 
	CALL        _Ps2_Key_Read+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main42
;matrix48.c,199 :: 		if (down && (keydata == 13)) {
	MOVF        _down+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main45
	MOVF        _keydata+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_main45
L__main77:
;matrix48.c,201 :: 		StringLength =  key;
	MOVF        _key+0, 0 
	MOVWF       _StringLength+0 
	MOVLW       0
	MOVWF       _StringLength+1 
;matrix48.c,202 :: 		Save_Message();
	CALL        _Save_Message+0, 0
;matrix48.c,204 :: 		key=0;
	CLRF        _key+0 
;matrix48.c,205 :: 		}
	GOTO        L_main46
L_main45:
;matrix48.c,207 :: 		else if (down && !special && keydata) {
	MOVF        _down+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main49
	MOVF        _special+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main49
	MOVF        _keydata+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main49
L__main76:
;matrix48.c,208 :: 		message[key]=keydata;
	MOVLW       _message+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(_message+0)
	MOVWF       FSR1H 
	MOVF        _key+0, 0 
	ADDWF       FSR1L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVF        _keydata+0, 0 
	MOVWF       POSTINC1+0 
;matrix48.c,210 :: 		key++;
	INCF        _key+0, 1 
;matrix48.c,211 :: 		}
L_main49:
L_main46:
;matrix48.c,212 :: 		if (down && (keydata == 16))
	MOVF        _down+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main52
	MOVF        _keydata+0, 0 
	XORLW       16
	BTFSS       STATUS+0, 2 
	GOTO        L_main52
L__main75:
;matrix48.c,213 :: 		key--;
	DECF        _key+0, 1 
L_main52:
;matrix48.c,214 :: 		}
L_main42:
;matrix48.c,215 :: 		Delay_ms(1);
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       125
	MOVWF       R13, 0
L_main53:
	DECFSZ      R13, 1, 1
	BRA         L_main53
	DECFSZ      R12, 1, 1
	BRA         L_main53
;matrix48.c,217 :: 		while(keydata!=13 );             //key!=0 && down==0
	MOVF        _keydata+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_main39
;matrix48.c,218 :: 		StringLength = EEPROM_Read(0x01);
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _StringLength+0 
	MOVLW       0
	MOVWF       _StringLength+1 
;matrix48.c,219 :: 		Load_Data();
	CALL        _Load_Data+0, 0
;matrix48.c,220 :: 		k=0;
	CLRF        _k+0 
;matrix48.c,221 :: 		scroll=0;
	CLRF        _scroll+0 
;matrix48.c,222 :: 		row=0;
	CLRF        _row+0 
;matrix48.c,224 :: 		for(l=0; l<8; l++){
	CLRF        _l+0 
L_main54:
	MOVLW       8
	SUBWF       _l+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main55
;matrix48.c,225 :: 		Buffer[l][5] =0;
	MOVF        _l+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       6
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Buffer+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Buffer+0)
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;matrix48.c,226 :: 		Buffer[l][4] =0;
	MOVF        _l+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       6
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Buffer+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Buffer+0)
	ADDWFC      R1, 1 
	MOVLW       4
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;matrix48.c,227 :: 		Buffer[l][3] =0;
	MOVF        _l+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       6
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Buffer+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Buffer+0)
	ADDWFC      R1, 1 
	MOVLW       3
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;matrix48.c,228 :: 		Buffer[l][2] =0;
	MOVF        _l+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       6
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Buffer+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Buffer+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;matrix48.c,229 :: 		Buffer[l][1] =0;
	MOVF        _l+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       6
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Buffer+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Buffer+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;matrix48.c,230 :: 		Buffer[l][0] =0;
	MOVF        _l+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       6
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Buffer+0
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       hi_addr(_Buffer+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;matrix48.c,224 :: 		for(l=0; l<8; l++){
	INCF        _l+0, 1 
;matrix48.c,231 :: 		}
	GOTO        L_main54
L_main55:
;matrix48.c,232 :: 		}
L_main38:
;matrix48.c,233 :: 		}    //for ps2_read
L_main35:
;matrix48.c,235 :: 		if(UART1_Data_Ready())
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main57
;matrix48.c,238 :: 		data1 = UART1_Read();
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _data1+0 
;matrix48.c,241 :: 		if(data1=='k')  {
	MOVF        R0, 0 
	XORLW       107
	BTFSS       STATUS+0, 2 
	GOTO        L_main58
;matrix48.c,242 :: 		UART1_Write('y');
	MOVLW       121
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;matrix48.c,243 :: 		PORTB= 0;
	CLRF        PORTB+0 
;matrix48.c,245 :: 		while(!UART1_Data_Ready());
L_main59:
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main60
	GOTO        L_main59
L_main60:
;matrix48.c,246 :: 		UART1_Read_Text(message,"#",255);
	MOVLW       _message+0
	MOVWF       FARG_UART1_Read_Text_Output+0 
	MOVLW       hi_addr(_message+0)
	MOVWF       FARG_UART1_Read_Text_Output+1 
	MOVLW       ?lstr1_matrix48+0
	MOVWF       FARG_UART1_Read_Text_Delimiter+0 
	MOVLW       hi_addr(?lstr1_matrix48+0)
	MOVWF       FARG_UART1_Read_Text_Delimiter+1 
	MOVLW       255
	MOVWF       FARG_UART1_Read_Text_Attempts+0 
	CALL        _UART1_Read_Text+0, 0
;matrix48.c,247 :: 		StringLength = Find_StrLength();
	CALL        _Find_StrLength+0, 0
	MOVF        R0, 0 
	MOVWF       _StringLength+0 
	MOVLW       0
	MOVWF       _StringLength+1 
;matrix48.c,248 :: 		Save_Message();
	CALL        _Save_Message+0, 0
;matrix48.c,249 :: 		StringLength = EEPROM_Read(0x01);
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _StringLength+0 
	MOVLW       0
	MOVWF       _StringLength+1 
;matrix48.c,250 :: 		Load_Data();
	CALL        _Load_Data+0, 0
;matrix48.c,251 :: 		k=0;
	CLRF        _k+0 
;matrix48.c,252 :: 		scroll=0;
	CLRF        _scroll+0 
;matrix48.c,253 :: 		row=0;
	CLRF        _row+0 
;matrix48.c,255 :: 		for(l=0; l<8; l++){
	CLRF        _l+0 
L_main61:
	MOVLW       8
	SUBWF       _l+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main62
;matrix48.c,256 :: 		Buffer[l][4] =0;
	MOVF        _l+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       6
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Buffer+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Buffer+0)
	ADDWFC      R1, 1 
	MOVLW       4
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;matrix48.c,257 :: 		Buffer[l][3] =0;
	MOVF        _l+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       6
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Buffer+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Buffer+0)
	ADDWFC      R1, 1 
	MOVLW       3
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;matrix48.c,258 :: 		Buffer[l][2] =0;
	MOVF        _l+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       6
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Buffer+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Buffer+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;matrix48.c,259 :: 		Buffer[l][1] =0;
	MOVF        _l+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       6
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Buffer+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Buffer+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;matrix48.c,260 :: 		Buffer[l][0] =0;
	MOVF        _l+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       6
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Buffer+0
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       hi_addr(_Buffer+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;matrix48.c,255 :: 		for(l=0; l<8; l++){
	INCF        _l+0, 1 
;matrix48.c,261 :: 		}
	GOTO        L_main61
L_main62:
;matrix48.c,262 :: 		}
L_main58:
;matrix48.c,263 :: 		}
L_main57:
;matrix48.c,265 :: 		index = message[k];
	MOVLW       _message+0
	MOVWF       FSR0L 
	MOVLW       hi_addr(_message+0)
	MOVWF       FSR0H 
	MOVF        _k+0, 0 
	ADDWF       FSR0L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       _index+0 
;matrix48.c,266 :: 		if(index <32 || index > 90 )
	MOVLW       32
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L__main74
	MOVF        _index+0, 0 
	SUBLW       90
	BTFSS       STATUS+0, 0 
	GOTO        L__main74
	GOTO        L_main66
L__main74:
;matrix48.c,267 :: 		{index = 32;
	MOVLW       32
	MOVWF       _index+0 
;matrix48.c,268 :: 		}
L_main66:
;matrix48.c,269 :: 		temp = CharData[index-32][row];
	MOVLW       32
	SUBWF       _index+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       _CharData+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_CharData+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(_CharData+0)
	ADDWFC      R2, 1 
	MOVF        _row+0, 0 
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, _temp+0
;matrix48.c,271 :: 		Buffer[row][5] = (Buffer[row][5] << Shift_Step) | (Buffer[row][4] >> (8-Shift_Step));
	MOVF        _row+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       6
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Buffer+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_Buffer+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       5
	ADDWF       R2, 0 
	MOVWF       R5 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R6 
	MOVFF       R5, FSR0L
	MOVFF       R6, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        _shift_step+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
	MOVWF       R4 
	MOVF        R0, 0 
L__main82:
	BZ          L__main83
	RLCF        R4, 1 
	BCF         R4, 0 
	ADDLW       255
	GOTO        L__main82
L__main83:
	MOVLW       4
	ADDWF       R2, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        _shift_step+0, 0 
	SUBLW       8
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
	MOVWF       R1 
	MOVF        R2, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__main84:
	BZ          L__main85
	RRCF        R0, 1 
	BCF         R0, 7 
	ADDLW       255
	GOTO        L__main84
L__main85:
	MOVF        R4, 0 
	IORWF       R0, 1 
	MOVFF       R5, FSR1L
	MOVFF       R6, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;matrix48.c,272 :: 		Buffer[row][4] = (Buffer[row][4] << Shift_Step) | (Buffer[row][3] >> (8-Shift_Step));
	MOVF        _row+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       6
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Buffer+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_Buffer+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       4
	ADDWF       R2, 0 
	MOVWF       R5 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R6 
	MOVFF       R5, FSR0L
	MOVFF       R6, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        _shift_step+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
	MOVWF       R4 
	MOVF        R0, 0 
L__main86:
	BZ          L__main87
	RLCF        R4, 1 
	BCF         R4, 0 
	ADDLW       255
	GOTO        L__main86
L__main87:
	MOVLW       3
	ADDWF       R2, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        _shift_step+0, 0 
	SUBLW       8
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
	MOVWF       R1 
	MOVF        R2, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__main88:
	BZ          L__main89
	RRCF        R0, 1 
	BCF         R0, 7 
	ADDLW       255
	GOTO        L__main88
L__main89:
	MOVF        R4, 0 
	IORWF       R0, 1 
	MOVFF       R5, FSR1L
	MOVFF       R6, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;matrix48.c,273 :: 		Buffer[row][3] = (Buffer[row][3] << Shift_Step) | (Buffer[row][2] >> (8-Shift_Step));
	MOVF        _row+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       6
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Buffer+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_Buffer+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       3
	ADDWF       R2, 0 
	MOVWF       R5 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R6 
	MOVFF       R5, FSR0L
	MOVFF       R6, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        _shift_step+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
	MOVWF       R4 
	MOVF        R0, 0 
L__main90:
	BZ          L__main91
	RLCF        R4, 1 
	BCF         R4, 0 
	ADDLW       255
	GOTO        L__main90
L__main91:
	MOVLW       2
	ADDWF       R2, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        _shift_step+0, 0 
	SUBLW       8
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
	MOVWF       R1 
	MOVF        R2, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__main92:
	BZ          L__main93
	RRCF        R0, 1 
	BCF         R0, 7 
	ADDLW       255
	GOTO        L__main92
L__main93:
	MOVF        R4, 0 
	IORWF       R0, 1 
	MOVFF       R5, FSR1L
	MOVFF       R6, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;matrix48.c,274 :: 		Buffer[row][2] = (Buffer[row][2] << Shift_Step) | (Buffer[row][1] >> (8-Shift_Step));
	MOVF        _row+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       6
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Buffer+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_Buffer+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       2
	ADDWF       R2, 0 
	MOVWF       R5 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R6 
	MOVFF       R5, FSR0L
	MOVFF       R6, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        _shift_step+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
	MOVWF       R4 
	MOVF        R0, 0 
L__main94:
	BZ          L__main95
	RLCF        R4, 1 
	BCF         R4, 0 
	ADDLW       255
	GOTO        L__main94
L__main95:
	MOVLW       1
	ADDWF       R2, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        _shift_step+0, 0 
	SUBLW       8
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
	MOVWF       R1 
	MOVF        R2, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__main96:
	BZ          L__main97
	RRCF        R0, 1 
	BCF         R0, 7 
	ADDLW       255
	GOTO        L__main96
L__main97:
	MOVF        R4, 0 
	IORWF       R0, 1 
	MOVFF       R5, FSR1L
	MOVFF       R6, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;matrix48.c,275 :: 		Buffer[row][1] = (Buffer[row][1] << Shift_Step) | (Buffer[row][0] >> (8-Shift_Step));
	MOVF        _row+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       6
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Buffer+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_Buffer+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       1
	ADDWF       R2, 0 
	MOVWF       R5 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R6 
	MOVFF       R5, FSR0L
	MOVFF       R6, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        _shift_step+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
	MOVWF       R4 
	MOVF        R0, 0 
L__main98:
	BZ          L__main99
	RLCF        R4, 1 
	BCF         R4, 0 
	ADDLW       255
	GOTO        L__main98
L__main99:
	MOVFF       R2, FSR0L
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        _shift_step+0, 0 
	SUBLW       8
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
	MOVWF       R1 
	MOVF        R2, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__main100:
	BZ          L__main101
	RRCF        R0, 1 
	BCF         R0, 7 
	ADDLW       255
	GOTO        L__main100
L__main101:
	MOVF        R4, 0 
	IORWF       R0, 1 
	MOVFF       R5, FSR1L
	MOVFF       R6, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;matrix48.c,276 :: 		Buffer[row][0] = (Buffer[row][0] << Shift_Step)| (temp >> ((8-shift_step)-scroll*shift_step));
	MOVF        _row+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       6
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Buffer+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Buffer+0)
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       FSR1L 
	MOVF        R1, 0 
	MOVWF       FSR1H 
	MOVFF       R0, FSR0L
	MOVFF       R1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        _shift_step+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
	MOVWF       R4 
	MOVF        R0, 0 
L__main102:
	BZ          L__main103
	RLCF        R4, 1 
	BCF         R4, 0 
	ADDLW       255
	GOTO        L__main102
L__main103:
	MOVF        _shift_step+0, 0 
	SUBLW       8
	MOVWF       R2 
	CLRF        R3 
	MOVLW       0
	SUBWFB      R3, 1 
	MOVF        _scroll+0, 0 
	MULWF       _shift_step+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	SUBWF       R2, 0 
	MOVWF       R0 
	MOVF        R1, 0 
	SUBWFB      R3, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       R1 
	MOVF        _temp+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__main104:
	BZ          L__main105
	RRCF        R0, 1 
	BCF         R0, 7 
	ADDLW       255
	GOTO        L__main104
L__main105:
	MOVF        R4, 0 
	IORWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;matrix48.c,189 :: 		for (row=0; row<7; row++){
	INCF        _row+0, 1 
;matrix48.c,277 :: 		}
	GOTO        L_main32
L_main33:
;matrix48.c,278 :: 		speed = 5;
	MOVLW       5
	MOVWF       _speed+0 
	MOVLW       0
	MOVWF       _speed+1 
;matrix48.c,279 :: 		for(l=0; l<speed;l++){
	CLRF        _l+0 
L_main67:
	MOVLW       0
	MOVWF       R0 
	MOVF        _speed+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main106
	MOVF        _speed+0, 0 
	SUBWF       _l+0, 0 
L__main106:
	BTFSC       STATUS+0, 0 
	GOTO        L_main68
;matrix48.c,280 :: 		m = 1;
	MOVLW       1
	MOVWF       _m+0 
;matrix48.c,281 :: 		for (i=0; i<7; i++) {    //each row
	CLRF        _i+0 
L_main70:
	MOVLW       7
	SUBWF       _i+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main71
;matrix48.c,282 :: 		Send_Data(i);
	MOVF        _i+0, 0 
	MOVWF       FARG_Send_Data_rw+0 
	CALL        _Send_Data+0, 0
;matrix48.c,284 :: 		LATB=m;
	MOVF        _m+0, 0 
	MOVWF       LATB+0 
;matrix48.c,286 :: 		m = m << 1;
	RLCF        _m+0, 1 
	BCF         _m+0, 0 
;matrix48.c,287 :: 		Delay_us(1000);
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       125
	MOVWF       R13, 0
L_main73:
	DECFSZ      R13, 1, 1
	BRA         L_main73
	DECFSZ      R12, 1, 1
	BRA         L_main73
;matrix48.c,281 :: 		for (i=0; i<7; i++) {    //each row
	INCF        _i+0, 1 
;matrix48.c,288 :: 		}  // i
	GOTO        L_main70
L_main71:
;matrix48.c,279 :: 		for(l=0; l<speed;l++){
	INCF        _l+0, 1 
;matrix48.c,289 :: 		} // l
	GOTO        L_main67
L_main68:
;matrix48.c,188 :: 		for (scroll=0; scroll<(8/shift_step); scroll++) {
	INCF        _scroll+0, 1 
;matrix48.c,290 :: 		} // scroll
	GOTO        L_main29
L_main30:
;matrix48.c,187 :: 		for (k=0; k<StringLength+5; k++){
	INCF        _k+0, 1 
;matrix48.c,291 :: 		} // k
	GOTO        L_main26
L_main27:
;matrix48.c,293 :: 		} while(1);
	GOTO        L_main23
;matrix48.c,294 :: 		}
	GOTO        $+0
; end of _main
