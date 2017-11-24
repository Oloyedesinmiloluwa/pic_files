
_Send_Data:

;ledshift.c,26 :: 		void Send_Data(unsigned short rw){
;ledshift.c,28 :: 		for (num = 0; num < 5; num++) {
	CLRF       Send_Data_num_L0+0
L_Send_Data0:
	MOVLW      5
	SUBWF      Send_Data_num_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Send_Data1
;ledshift.c,29 :: 		Mask = 0x01;
	MOVLW      1
	MOVWF      Send_Data_Mask_L0+0
;ledshift.c,31 :: 		for (t=0; t<8; t++){              //each bit
	CLRF       Send_Data_t_L0+0
L_Send_Data3:
	MOVLW      8
	SUBWF      Send_Data_t_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Send_Data4
;ledshift.c,33 :: 		Fflag = Buffer[rw][num] & Mask;
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
;ledshift.c,34 :: 		if(Fflag==0) PORTD.b0 = 0;
	MOVF       R1+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_Send_Data6
	BCF        PORTD+0, 0
	GOTO       L_Send_Data7
L_Send_Data6:
;ledshift.c,35 :: 		else PORTD.b0 = 1;
	BSF        PORTD+0, 0
L_Send_Data7:
;ledshift.c,37 :: 		PORTD.b1 = 1    ;    //to
	BSF        PORTD+0, 1
;ledshift.c,38 :: 		PORTD.b1 = 0;
	BCF        PORTD+0, 1
;ledshift.c,41 :: 		Mask = Mask << 1;
	RLF        Send_Data_Mask_L0+0, 1
	BCF        Send_Data_Mask_L0+0, 0
;ledshift.c,31 :: 		for (t=0; t<8; t++){              //each bit
	INCF       Send_Data_t_L0+0, 1
;ledshift.c,42 :: 		}
	GOTO       L_Send_Data3
L_Send_Data4:
;ledshift.c,28 :: 		for (num = 0; num < 5; num++) {
	INCF       Send_Data_num_L0+0, 1
;ledshift.c,43 :: 		}
	GOTO       L_Send_Data0
L_Send_Data1:
;ledshift.c,44 :: 		PORTD.b2 = 1    ;    //to
	BSF        PORTD+0, 2
;ledshift.c,45 :: 		PORTD.b2 = 0;
	BCF        PORTD+0, 2
;ledshift.c,46 :: 		}
	RETURN
; end of _Send_Data

_Find_StrLength:

;ledshift.c,140 :: 		unsigned short Find_StrLength(){
;ledshift.c,141 :: 		return strlen(message);
	MOVLW      _message+0
	MOVWF      FARG_strlen_s+0
	CALL       _strlen+0
;ledshift.c,142 :: 		}
	RETURN
; end of _Find_StrLength

_Save_Message:

;ledshift.c,144 :: 		void Save_Message(){
;ledshift.c,145 :: 		EEPROM_Write(0x01, StringLength);
	MOVLW      1
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _StringLength+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;ledshift.c,146 :: 		Delay_ms(5);
	MOVLW      33
	MOVWF      R12+0
	MOVLW      118
	MOVWF      R13+0
L_Save_Message8:
	DECFSZ     R13+0, 1
	GOTO       L_Save_Message8
	DECFSZ     R12+0, 1
	GOTO       L_Save_Message8
	NOP
;ledshift.c,147 :: 		for(i=0; i<StringLength; i++){
	CLRF       _i+0
L_Save_Message9:
	MOVF       _StringLength+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__Save_Message83
	MOVF       _StringLength+0, 0
	SUBWF      _i+0, 0
L__Save_Message83:
	BTFSC      STATUS+0, 0
	GOTO       L_Save_Message10
;ledshift.c,148 :: 		EEPROM_Write(i+2, message[i]);
	MOVLW      2
	ADDWF      _i+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _i+0, 0
	ADDLW      _message+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;ledshift.c,149 :: 		Delay_ms(5);
	MOVLW      33
	MOVWF      R12+0
	MOVLW      118
	MOVWF      R13+0
L_Save_Message12:
	DECFSZ     R13+0, 1
	GOTO       L_Save_Message12
	DECFSZ     R12+0, 1
	GOTO       L_Save_Message12
	NOP
;ledshift.c,147 :: 		for(i=0; i<StringLength; i++){
	INCF       _i+0, 1
;ledshift.c,150 :: 		}
	GOTO       L_Save_Message9
L_Save_Message10:
;ledshift.c,152 :: 		EEPROM_Write(i+2, 32);
	MOVLW      2
	ADDWF      _i+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      32
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;ledshift.c,153 :: 		Delay_ms(5);
	MOVLW      33
	MOVWF      R12+0
	MOVLW      118
	MOVWF      R13+0
L_Save_Message13:
	DECFSZ     R13+0, 1
	GOTO       L_Save_Message13
	DECFSZ     R12+0, 1
	GOTO       L_Save_Message13
	NOP
;ledshift.c,154 :: 		EEPROM_Write(i+3, 32);
	MOVLW      3
	ADDWF      _i+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      32
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;ledshift.c,155 :: 		Delay_ms(5);
	MOVLW      33
	MOVWF      R12+0
	MOVLW      118
	MOVWF      R13+0
L_Save_Message14:
	DECFSZ     R13+0, 1
	GOTO       L_Save_Message14
	DECFSZ     R12+0, 1
	GOTO       L_Save_Message14
	NOP
;ledshift.c,156 :: 		EEPROM_Write(i+4, 32);
	MOVLW      4
	ADDWF      _i+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      32
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;ledshift.c,157 :: 		Delay_ms(5);
	MOVLW      33
	MOVWF      R12+0
	MOVLW      118
	MOVWF      R13+0
L_Save_Message15:
	DECFSZ     R13+0, 1
	GOTO       L_Save_Message15
	DECFSZ     R12+0, 1
	GOTO       L_Save_Message15
	NOP
;ledshift.c,158 :: 		EEPROM_Write(i+5, 32);
	MOVLW      5
	ADDWF      _i+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      32
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;ledshift.c,159 :: 		Delay_ms(5);
	MOVLW      33
	MOVWF      R12+0
	MOVLW      118
	MOVWF      R13+0
L_Save_Message16:
	DECFSZ     R13+0, 1
	GOTO       L_Save_Message16
	DECFSZ     R12+0, 1
	GOTO       L_Save_Message16
	NOP
;ledshift.c,160 :: 		}
	RETURN
; end of _Save_Message

_Load_Data:

;ledshift.c,162 :: 		void Load_Data(){
;ledshift.c,163 :: 		for (k=0; k<StringLength+4; k++){
	CLRF       _k+0
L_Load_Data17:
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
	GOTO       L__Load_Data84
	MOVF       R1+0, 0
	SUBWF      _k+0, 0
L__Load_Data84:
	BTFSC      STATUS+0, 0
	GOTO       L_Load_Data18
;ledshift.c,164 :: 		message[k] = EEPROM_Read(k+2);
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
;ledshift.c,165 :: 		Delay_ms(5);
	MOVLW      33
	MOVWF      R12+0
	MOVLW      118
	MOVWF      R13+0
L_Load_Data20:
	DECFSZ     R13+0, 1
	GOTO       L_Load_Data20
	DECFSZ     R12+0, 1
	GOTO       L_Load_Data20
	NOP
;ledshift.c,163 :: 		for (k=0; k<StringLength+4; k++){
	INCF       _k+0, 1
;ledshift.c,166 :: 		}
	GOTO       L_Load_Data17
L_Load_Data18:
;ledshift.c,167 :: 		}
	RETURN
; end of _Load_Data

_keyboard:

;ledshift.c,168 :: 		void  keyboard(){
;ledshift.c,171 :: 		do{
L_keyboard21:
;ledshift.c,172 :: 		if(Ps2_Key_Read(&keydata, &special, &down)) {
	MOVLW      _keydata+0
	MOVWF      FARG_Ps2_Key_Read_value+0
	MOVLW      _special+0
	MOVWF      FARG_Ps2_Key_Read_special+0
	MOVLW      _down+0
	MOVWF      FARG_Ps2_Key_Read_pressed+0
	CALL       _Ps2_Key_Read+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_keyboard24
;ledshift.c,174 :: 		if (down && (keydata == 13)) {
	MOVF       _down+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_keyboard27
	MOVF       _keydata+0, 0
	XORLW      13
	BTFSS      STATUS+0, 2
	GOTO       L_keyboard27
L__keyboard78:
;ledshift.c,176 :: 		StringLength =  key;
	MOVF       _key+0, 0
	MOVWF      _StringLength+0
	CLRF       _StringLength+1
;ledshift.c,177 :: 		Save_Message();
	CALL       _Save_Message+0
;ledshift.c,179 :: 		key=0;
	CLRF       _key+0
;ledshift.c,180 :: 		}
	GOTO       L_keyboard28
L_keyboard27:
;ledshift.c,182 :: 		else if (down && !special && keydata) {
	MOVF       _down+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_keyboard31
	MOVF       _special+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_keyboard31
	MOVF       _keydata+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_keyboard31
L__keyboard77:
;ledshift.c,183 :: 		message[key]=keydata;
	MOVF       _key+0, 0
	ADDLW      _message+0
	MOVWF      FSR
	MOVF       _keydata+0, 0
	MOVWF      INDF+0
;ledshift.c,185 :: 		key++;
	INCF       _key+0, 1
;ledshift.c,186 :: 		}
L_keyboard31:
L_keyboard28:
;ledshift.c,187 :: 		if (down && (keydata == 16))
	MOVF       _down+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_keyboard34
	MOVF       _keydata+0, 0
	XORLW      16
	BTFSS      STATUS+0, 2
	GOTO       L_keyboard34
L__keyboard76:
;ledshift.c,188 :: 		key--;
	DECF       _key+0, 1
L_keyboard34:
;ledshift.c,189 :: 		}
L_keyboard24:
;ledshift.c,190 :: 		Delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_keyboard35:
	DECFSZ     R13+0, 1
	GOTO       L_keyboard35
	DECFSZ     R12+0, 1
	GOTO       L_keyboard35
;ledshift.c,192 :: 		while(keydata!=13 );             //key!=0 && down==0
	MOVF       _keydata+0, 0
	XORLW      13
	BTFSS      STATUS+0, 2
	GOTO       L_keyboard21
;ledshift.c,193 :: 		StringLength = EEPROM_Read(0x01);
	MOVLW      1
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _StringLength+0
	CLRF       _StringLength+1
;ledshift.c,194 :: 		Load_Data();
	CALL       _Load_Data+0
;ledshift.c,195 :: 		k=0;
	CLRF       _k+0
;ledshift.c,196 :: 		scroll=0;
	CLRF       _scroll+0
;ledshift.c,197 :: 		row=0;
	CLRF       _row+0
;ledshift.c,199 :: 		for(l=0; l<8; l++){
	CLRF       _l+0
L_keyboard36:
	MOVLW      8
	SUBWF      _l+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_keyboard37
;ledshift.c,200 :: 		Buffer[l][4] =0;
	MOVF       _l+0, 0
	MOVWF      R0+0
	MOVLW      5
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVLW      _Buffer+0
	ADDWF      R0+0, 1
	MOVLW      4
	ADDWF      R0+0, 0
	MOVWF      FSR
	CLRF       INDF+0
;ledshift.c,201 :: 		Buffer[l][3] =0;
	MOVF       _l+0, 0
	MOVWF      R0+0
	MOVLW      5
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVLW      _Buffer+0
	ADDWF      R0+0, 1
	MOVLW      3
	ADDWF      R0+0, 0
	MOVWF      FSR
	CLRF       INDF+0
;ledshift.c,202 :: 		Buffer[l][2] =0;
	MOVF       _l+0, 0
	MOVWF      R0+0
	MOVLW      5
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVLW      _Buffer+0
	ADDWF      R0+0, 1
	MOVLW      2
	ADDWF      R0+0, 0
	MOVWF      FSR
	CLRF       INDF+0
;ledshift.c,203 :: 		Buffer[l][1] =0;
	MOVF       _l+0, 0
	MOVWF      R0+0
	MOVLW      5
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVLW      _Buffer+0
	ADDWF      R0+0, 1
	INCF       R0+0, 0
	MOVWF      FSR
	CLRF       INDF+0
;ledshift.c,204 :: 		Buffer[l][0] =0;
	MOVF       _l+0, 0
	MOVWF      R0+0
	MOVLW      5
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVF       R0+0, 0
	ADDLW      _Buffer+0
	MOVWF      FSR
	CLRF       INDF+0
;ledshift.c,199 :: 		for(l=0; l<8; l++){
	INCF       _l+0, 1
;ledshift.c,205 :: 		}
	GOTO       L_keyboard36
L_keyboard37:
;ledshift.c,209 :: 		}
	RETURN
; end of _keyboard

_main:

;ledshift.c,210 :: 		void main() {
;ledshift.c,213 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;ledshift.c,217 :: 		TRISE = 0x00;
	CLRF       TRISE+0
;ledshift.c,218 :: 		TRISB = 0x00;
	CLRF       TRISB+0
;ledshift.c,220 :: 		ADCON0=0x00;
	CLRF       ADCON0+0
;ledshift.c,221 :: 		PORTB=0x00;
	CLRF       PORTB+0
;ledshift.c,222 :: 		PORTD=0x00;
	CLRF       PORTD+0
;ledshift.c,223 :: 		PORTE=0x00;
	CLRF       PORTE+0
;ledshift.c,225 :: 		Ps2_Config();                                        // Init PS/2 Keyboard
	CALL       _Ps2_Config+0
;ledshift.c,226 :: 		Delay_ms(100);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main39:
	DECFSZ     R13+0, 1
	GOTO       L_main39
	DECFSZ     R12+0, 1
	GOTO       L_main39
	DECFSZ     R11+0, 1
	GOTO       L_main39
	NOP
	NOP
;ledshift.c,252 :: 		StringLength = EEPROM_Read(0x01);
	MOVLW      1
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _StringLength+0
	CLRF       _StringLength+1
;ledshift.c,253 :: 		Delay_ms(5);
	MOVLW      33
	MOVWF      R12+0
	MOVLW      118
	MOVWF      R13+0
L_main40:
	DECFSZ     R13+0, 1
	GOTO       L_main40
	DECFSZ     R12+0, 1
	GOTO       L_main40
	NOP
;ledshift.c,254 :: 		Load_Data();  // Read stored data and save into RAM
	CALL       _Load_Data+0
;ledshift.c,255 :: 		if(fcount==1)
	MOVF       _fcount+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main41
;ledshift.c,256 :: 		{  StringLength = 21;
	MOVLW      21
	MOVWF      _StringLength+0
	MOVLW      0
	MOVWF      _StringLength+1
;ledshift.c,257 :: 		shift_step= 1;
	MOVLW      1
	MOVWF      _shift_step+0
;ledshift.c,258 :: 		}
L_main41:
;ledshift.c,260 :: 		do {
L_main42:
;ledshift.c,261 :: 		for (k=0; k<StringLength+4; k++){
	CLRF       _k+0
L_main45:
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
	GOTO       L__main85
	MOVF       R1+0, 0
	SUBWF      _k+0, 0
L__main85:
	BTFSC      STATUS+0, 0
	GOTO       L_main46
;ledshift.c,262 :: 		for (scroll=0; scroll<(8/shift_step); scroll++) {
	CLRF       _scroll+0
L_main48:
	MOVF       _shift_step+0, 0
	MOVWF      R4+0
	MOVLW      8
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R0+0, 0
	SUBWF      _scroll+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main49
;ledshift.c,263 :: 		for (row=0; row<7; row++){
	CLRF       _row+0
L_main51:
	MOVLW      7
	SUBWF      _row+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main52
;ledshift.c,265 :: 		if(Ps2_Key_Read(&keydata, &special, &down)&& fcount==2) {
	MOVLW      _keydata+0
	MOVWF      FARG_Ps2_Key_Read_value+0
	MOVLW      _special+0
	MOVWF      FARG_Ps2_Key_Read_special+0
	MOVLW      _down+0
	MOVWF      FARG_Ps2_Key_Read_pressed+0
	CALL       _Ps2_Key_Read+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main56
	MOVF       _fcount+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_main56
L__main82:
;ledshift.c,266 :: 		if (down && (keydata == 34)) {
	MOVF       _down+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main59
	MOVF       _keydata+0, 0
	XORLW      34
	BTFSS      STATUS+0, 2
	GOTO       L_main59
L__main81:
;ledshift.c,267 :: 		PORTB= 0;
	CLRF       PORTB+0
;ledshift.c,268 :: 		keyboard();
	CALL       _keyboard+0
;ledshift.c,269 :: 		}
L_main59:
;ledshift.c,270 :: 		}
L_main56:
;ledshift.c,271 :: 		if(fcount==1)
	MOVF       _fcount+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main60
;ledshift.c,272 :: 		index = default_message[k];
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
	GOTO       L_main61
L_main60:
;ledshift.c,274 :: 		{ index = message[k];
	MOVF       _k+0, 0
	ADDLW      _message+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      _index+0
;ledshift.c,275 :: 		if(index <32 || index > 90 )
	MOVLW      32
	SUBWF      R1+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L__main80
	MOVF       _index+0, 0
	SUBLW      90
	BTFSS      STATUS+0, 0
	GOTO       L__main80
	GOTO       L_main64
L__main80:
;ledshift.c,276 :: 		{index = 32;
	MOVLW      32
	MOVWF      _index+0
;ledshift.c,277 :: 		}
L_main64:
;ledshift.c,278 :: 		}
L_main61:
;ledshift.c,279 :: 		temp = CharData[index-32][row];
	MOVLW      32
	SUBWF      _index+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVLW      7
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
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
;ledshift.c,281 :: 		Buffer[row][4] = (Buffer[row][4] << Shift_Step) | (Buffer[row][3] >> (8-Shift_Step));
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
L__main86:
	BTFSC      STATUS+0, 2
	GOTO       L__main87
	RLF        R3+0, 1
	BCF        R3+0, 0
	ADDLW      255
	GOTO       L__main86
L__main87:
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
L__main88:
	BTFSC      STATUS+0, 2
	GOTO       L__main89
	RRF        R0+0, 1
	BCF        R0+0, 7
	ADDLW      255
	GOTO       L__main88
L__main89:
	MOVF       R3+0, 0
	IORWF      R0+0, 1
	MOVF       R4+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;ledshift.c,282 :: 		Buffer[row][3] = (Buffer[row][3] << Shift_Step) | (Buffer[row][2] >> (8-Shift_Step));
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
L__main90:
	BTFSC      STATUS+0, 2
	GOTO       L__main91
	RLF        R3+0, 1
	BCF        R3+0, 0
	ADDLW      255
	GOTO       L__main90
L__main91:
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
L__main92:
	BTFSC      STATUS+0, 2
	GOTO       L__main93
	RRF        R0+0, 1
	BCF        R0+0, 7
	ADDLW      255
	GOTO       L__main92
L__main93:
	MOVF       R3+0, 0
	IORWF      R0+0, 1
	MOVF       R4+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;ledshift.c,283 :: 		Buffer[row][2] = (Buffer[row][2] << Shift_Step) | (Buffer[row][1] >> (8-Shift_Step));
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
L__main94:
	BTFSC      STATUS+0, 2
	GOTO       L__main95
	RLF        R3+0, 1
	BCF        R3+0, 0
	ADDLW      255
	GOTO       L__main94
L__main95:
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
L__main96:
	BTFSC      STATUS+0, 2
	GOTO       L__main97
	RRF        R0+0, 1
	BCF        R0+0, 7
	ADDLW      255
	GOTO       L__main96
L__main97:
	MOVF       R3+0, 0
	IORWF      R0+0, 1
	MOVF       R4+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;ledshift.c,284 :: 		Buffer[row][1] = (Buffer[row][1] << Shift_Step) | (Buffer[row][0] >> (8-Shift_Step));
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
L__main98:
	BTFSC      STATUS+0, 2
	GOTO       L__main99
	RLF        R3+0, 1
	BCF        R3+0, 0
	ADDLW      255
	GOTO       L__main98
L__main99:
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
L__main100:
	BTFSC      STATUS+0, 2
	GOTO       L__main101
	RRF        R0+0, 1
	BCF        R0+0, 7
	ADDLW      255
	GOTO       L__main100
L__main101:
	MOVF       R3+0, 0
	IORWF      R0+0, 1
	MOVF       R4+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;ledshift.c,285 :: 		Buffer[row][0] = (Buffer[row][0] << Shift_Step)| (temp >> ((8-shift_step)-scroll*shift_step));
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
L__main102:
	BTFSC      STATUS+0, 2
	GOTO       L__main103
	RLF        FLOC__main+2, 1
	BCF        FLOC__main+2, 0
	ADDLW      255
	GOTO       L__main102
L__main103:
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
L__main104:
	BTFSC      STATUS+0, 2
	GOTO       L__main105
	RRF        R0+0, 1
	BCF        R0+0, 7
	ADDLW      255
	GOTO       L__main104
L__main105:
	MOVF       FLOC__main+2, 0
	IORWF      R0+0, 1
	MOVF       FLOC__main+3, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;ledshift.c,263 :: 		for (row=0; row<7; row++){
	INCF       _row+0, 1
;ledshift.c,286 :: 		}
	GOTO       L_main51
L_main52:
;ledshift.c,287 :: 		speed = 6;
	MOVLW      6
	MOVWF      _speed+0
	MOVLW      0
	MOVWF      _speed+1
;ledshift.c,288 :: 		for(l=0; l<speed;l++){
	CLRF       _l+0
L_main65:
	MOVF       _speed+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main106
	MOVF       _speed+0, 0
	SUBWF      _l+0, 0
L__main106:
	BTFSC      STATUS+0, 0
	GOTO       L_main66
;ledshift.c,289 :: 		m = 1;
	MOVLW      1
	MOVWF      _m+0
;ledshift.c,290 :: 		for (i=0; i<7; i++) {    //each row
	CLRF       _i+0
L_main68:
	MOVLW      7
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main69
;ledshift.c,291 :: 		Send_Data(i);
	MOVF       _i+0, 0
	MOVWF      FARG_Send_Data_rw+0
	CALL       _Send_Data+0
;ledshift.c,293 :: 		PORTB=m;
	MOVF       _m+0, 0
	MOVWF      PORTB+0
;ledshift.c,295 :: 		m = m << 1;
	RLF        _m+0, 1
	BCF        _m+0, 0
;ledshift.c,296 :: 		Delay_us(1000);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_main71:
	DECFSZ     R13+0, 1
	GOTO       L_main71
	DECFSZ     R12+0, 1
	GOTO       L_main71
;ledshift.c,290 :: 		for (i=0; i<7; i++) {    //each row
	INCF       _i+0, 1
;ledshift.c,297 :: 		}  // i
	GOTO       L_main68
L_main69:
;ledshift.c,288 :: 		for(l=0; l<speed;l++){
	INCF       _l+0, 1
;ledshift.c,298 :: 		} // l
	GOTO       L_main65
L_main66:
;ledshift.c,262 :: 		for (scroll=0; scroll<(8/shift_step); scroll++) {
	INCF       _scroll+0, 1
;ledshift.c,299 :: 		} // scroll
	GOTO       L_main48
L_main49:
;ledshift.c,304 :: 		if(fcount==1 && k==21)
	MOVF       _fcount+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main74
	MOVF       _k+0, 0
	XORLW      21
	BTFSS      STATUS+0, 2
	GOTO       L_main74
L__main79:
;ledshift.c,306 :: 		fcount=2;
	MOVLW      2
	MOVWF      _fcount+0
;ledshift.c,307 :: 		Shift_Step=2;
	MOVLW      2
	MOVWF      _shift_step+0
;ledshift.c,308 :: 		{StringLength = EEPROM_Read(0x01);
	MOVLW      1
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _StringLength+0
	CLRF       _StringLength+1
;ledshift.c,309 :: 		Delay_ms(5);
	MOVLW      33
	MOVWF      R12+0
	MOVLW      118
	MOVWF      R13+0
L_main75:
	DECFSZ     R13+0, 1
	GOTO       L_main75
	DECFSZ     R12+0, 1
	GOTO       L_main75
	NOP
;ledshift.c,310 :: 		k=StringLength+4;
	MOVLW      4
	ADDWF      _StringLength+0, 0
	MOVWF      _k+0
;ledshift.c,313 :: 		}
L_main74:
;ledshift.c,261 :: 		for (k=0; k<StringLength+4; k++){
	INCF       _k+0, 1
;ledshift.c,314 :: 		} // k
	GOTO       L_main45
L_main46:
;ledshift.c,316 :: 		} while(1);
	GOTO       L_main42
;ledshift.c,317 :: 		}
	GOTO       $+0
; end of _main
