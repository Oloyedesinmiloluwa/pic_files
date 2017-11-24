#line 1 "C:/Users/Public/Documents/pic files/c programs/led18shift.c"

 sbit PS2_Data at RC0_bit;
sbit PS2_Clock at RC1_bit;
sbit PS2_Data_Direction at TRISC0_bit;
sbit PS2_Clock_Direction at TRISC1_bit;

 unsigned int Buffer[8][5] = {
 {0,0,0,0,0},
 {0,0,0,0,0},
 {0,0,0,0,0},
 {0,0,0,0,0},
 {0,0,0,0,0},
 {0,0,0,0,0},
 {0,0,0,0,0},
 {0,0,0,0,0}
 };


unsigned short i, l, k, row, scroll, temp,temp2, shift_step=1;
unsigned short keydata = 0, special = 0, down = 0,key=0;
unsigned short m,speed, StringLength;



char message[400]="JESUS", index,index2,data1;

void Send_Data(unsigned short rw){
 unsigned int Mask,Fflag;
 unsigned short t, num;
 for (num = 0; num < 4; num++) {
 Mask = 0x01;

 for (t=0; t<10; t++){

 Fflag = Buffer[rw][num] & Mask;
 if(Fflag==0) PORTD.b0 = 0;
 else PORTD.b0 = 1;

 PORTD.b1 = 1 ;
 PORTD.b1 = 0;


 Mask = Mask << 1;
 }
 }
 PORTD.b2 = 1 ;
 PORTD.b2 = 0;
}
 const unsigned short CharData[][7] ={
{0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000},
{0b00000000, 0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00000000, 0b00000100},
{0b00000000, 0b00001010, 0b00001010, 0b00001010, 0b00000000, 0b00000000, 0b00000000},
{0b00000000, 0b00000000, 0b00001010, 0b00011111, 0b00001010, 0b00011111, 0b00001010},
{0b00000000, 0b00000000, 0b00001110, 0b00010100, 0b00001110, 0b00000101, 0b00001110},
{0b00000000, 0b00010000, 0b00010010, 0b00000100, 0b00001000, 0b00010010, 0b00000010},
{0b00000000, 0b00000000, 0b00001000, 0b00010100, 0b00001000, 0b00010100, 0b00001010},
{0b00000000, 0b00000100, 0b00000100, 0b00000100, 0b00000000, 0b00000000, 0b00000000},
{0b00000000, 0b00000100, 0b00001000, 0b00001000, 0b00001000, 0b00000100, 0b00000000},
{0b00000000, 0b00001000, 0b00000100, 0b00000100, 0b00000100, 0b00001000, 0b00000000},
{0b00000000, 0b00000000, 0b00001010, 0b00000100, 0b00001110, 0b00000100, 0b00001010},
{0b00000000, 0b00000000, 0b00000100, 0b00000100, 0b00011111, 0b00000100, 0b00000100},
{0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000110, 0b00000100, 0b00001000},
{0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00011110, 0b00000000, 0b00000000},
{0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00001100, 0b00001100},
{0b00000000, 0b00000000, 0b00000010, 0b00000100, 0b00001000, 0b00010000, 0b00000000},
{0b00000100, 0b00000100, 0b00001010, 0b00001010, 0b00001010, 0b00001010, 0b00000100},
{0b00000000, 0b00000100, 0b00001100, 0b00000100, 0b00000100, 0b00000100, 0b00001110},
{0b00000000, 0b00001100, 0b00010010, 0b00000010, 0b00000100, 0b00001000, 0b00011110},
{0b00000000, 0b00011110, 0b00000010, 0b00001100, 0b00000010, 0b00010010, 0b00001100},
{0b00000000, 0b00000100, 0b00001100, 0b00010100, 0b00011110, 0b00000100, 0b00000100},
{0b00000000, 0b00011110, 0b00010000, 0b00011100, 0b00000010, 0b00010010, 0b00001100},
{0b00000000, 0b00001100, 0b00010000, 0b00011100, 0b00010010, 0b00010010, 0b00001100},
{0b00000000, 0b00011110, 0b00000010, 0b00000100, 0b00000100, 0b00001000, 0b00001000},
{0b00000000, 0b00001100, 0b00010010, 0b00001100, 0b00010010, 0b00010010, 0b00001100},
{0b00000000, 0b00001100, 0b00010010, 0b00010010, 0b00001110, 0b00000010, 0b00001100},
{0b00000000, 0b00000000, 0b00001100, 0b00001100, 0b00000000, 0b00001100, 0b00001100},
{0b00000000, 0b00000000, 0b00001100, 0b00001100, 0b00000000, 0b00001100, 0b00001000},
{0b00000000, 0b00000000, 0b00000010, 0b00000100, 0b00001000, 0b00000100, 0b00000010},
{0b00000000, 0b00000000, 0b00000000, 0b00011110, 0b00000000, 0b00011110, 0b00000000},
{0b00000000, 0b00000000, 0b00001000, 0b00000100, 0b00000010, 0b00000100, 0b00001000},
{0b00000000, 0b00000100, 0b00001010, 0b00000010, 0b00000100, 0b00000000, 0b00000100},
{0b00000000, 0b00001100, 0b00010010, 0b00010110, 0b00010110, 0b00010000, 0b00001100},
{0b00000000, 0b00001100, 0b00010010, 0b00010010, 0b00011110, 0b00010010, 0b00010010},
{0b00000000, 0b00011100, 0b00010010, 0b00011100, 0b00010010, 0b00010010, 0b00011100},
{0b00000000, 0b00001100, 0b00010010, 0b00010000, 0b00010000, 0b00010010, 0b00001100},
{0b00000000, 0b00011100, 0b00010010, 0b00010010, 0b00010010, 0b00010010, 0b00011100},
{0b00000000, 0b00011110, 0b00010000, 0b00011100, 0b00010000, 0b00010000, 0b00011110},
{0b00000000, 0b00011110, 0b00010000, 0b00011100, 0b00010000, 0b00010000, 0b00010000},
{0b00000000, 0b00001100, 0b00010010, 0b00010000, 0b00010110, 0b00010010, 0b00001110},
{0b00000000, 0b00010010, 0b00010010, 0b00011110, 0b00010010, 0b00010010, 0b00010010},
{0b00000000, 0b00001110, 0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00001110},
{0b00000000, 0b00000010, 0b00000010, 0b00000010, 0b00000010, 0b00010010, 0b00001100},
{0b00000000, 0b00010010, 0b00010100, 0b00011000, 0b00011000, 0b00010100, 0b00010010},
{0b00000000, 0b00010000, 0b00010000, 0b00010000, 0b00010000, 0b00010000, 0b00011110},
{0b00000000, 0b00010010, 0b00011110, 0b00011110, 0b00010010, 0b00010010, 0b00010010},
{0b00000000, 0b00010010, 0b00011010, 0b00011010, 0b00010110, 0b00010110, 0b00010010},
{0b00000000, 0b00001100, 0b00010010, 0b00010010, 0b00010010, 0b00010010, 0b00001100},
{0b00000000, 0b00011100, 0b00010010, 0b00010010, 0b00011100, 0b00010000, 0b00010000},
{0b00000000, 0b00001100, 0b00010010, 0b00010010, 0b00010010, 0b00011010, 0b00001100},
{0b00000000, 0b00011100, 0b00010010, 0b00010010, 0b00011100, 0b00010100, 0b00010010},
{0b00000000, 0b00001100, 0b00010010, 0b00001000, 0b00000100, 0b00010010, 0b00001100},
{0b00000000, 0b00001110, 0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00000100},
{0b00000000, 0b00010010, 0b00010010, 0b00010010, 0b00010010, 0b00010010, 0b00001100},
{0b00000000, 0b00010010, 0b00010010, 0b00010010, 0b00010010, 0b00001100, 0b00001100},
{0b00000000, 0b00010010, 0b00010010, 0b00010010, 0b00011110, 0b00011110, 0b00010010},
{0b00000000, 0b00010010, 0b00010010, 0b00001100, 0b00001100, 0b00010010, 0b00010010},
{0b00000000, 0b00001010, 0b00001010, 0b00001010, 0b00000100, 0b00000100, 0b00000100},
{0b00000000, 0b00011110, 0b00000010, 0b00000100, 0b00001000, 0b00010000, 0b00011110},
{0b00000000, 0b00001110, 0b00001000, 0b00001000, 0b00001000, 0b00001000, 0b00001110},
{0b00000000, 0b00000000, 0b00010000, 0b00001000, 0b00000100, 0b00000010, 0b00000000},
{0b00000000, 0b00001110, 0b00000010, 0b00000010, 0b00000010, 0b00000010, 0b00001110},
{0b00000000, 0b00000100, 0b00001010, 0b00000000, 0b00000000, 0b00000000, 0b00000000},
{0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00011110},
{0b00000000, 0b00001000, 0b00000100, 0b00000000, 0b00000000, 0b00000000, 0b00000000},
{0b00000000, 0b00000000, 0b00000000, 0b00001110, 0b00010010, 0b00010110, 0b00001010},
{0b00000000, 0b00010000, 0b00010000, 0b00011100, 0b00010010, 0b00010010, 0b00011100},
{0b00000000, 0b00000000, 0b00000000, 0b00011100, 0b00010000, 0b00010000, 0b00001100},
{0b00000000, 0b00000010, 0b00000010, 0b00001110, 0b00010010, 0b00010010, 0b00001110},
{0b00000000, 0b00000000, 0b00000000, 0b00001100, 0b00010110, 0b00011000, 0b00001100},
{0b00000000, 0b00000100, 0b00001010, 0b00001000, 0b00011100, 0b00001000, 0b00001000},
{0b00000000, 0b00000000, 0b00001110, 0b00010010, 0b00001100, 0b00010000, 0b00001110},
{0b00000000, 0b00010000, 0b00010000, 0b00011100, 0b00010010, 0b00010010, 0b00010010},
{0b00000000, 0b00000100, 0b00000000, 0b00001100, 0b00000100, 0b00000100, 0b00001110},
{0b00000000, 0b00000010, 0b00000000, 0b00000010, 0b00000010, 0b00001010, 0b00000100},
{0b00000000, 0b00010000, 0b00010000, 0b00010100, 0b00011000, 0b00010100, 0b00010010},
{0b00000000, 0b00001100, 0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00001110},
{0b00000000, 0b00000000, 0b00000000, 0b00010100, 0b00011110, 0b00010010, 0b00010010},
{0b00000000, 0b00000000, 0b00000000, 0b00001100, 0b00010010, 0b00010010, 0b00010010},
{0b00000000, 0b00000000, 0b00000000, 0b00001100, 0b00010010, 0b00010010, 0b00001100},
{0b00000000, 0b00000000, 0b00011100, 0b00010010, 0b00010010, 0b00011100, 0b00010000},
{0b00000000, 0b00000000, 0b00001110, 0b00010010, 0b00010010, 0b00001110, 0b00000010},
{0b00000000, 0b00000000, 0b00000000, 0b00011100, 0b00010010, 0b00010000, 0b00010000},
{0b00000000, 0b00000000, 0b00000000, 0b00001110, 0b00011000, 0b00000110, 0b00011100},
{0b00000000, 0b00001000, 0b00001000, 0b00011100, 0b00001000, 0b00001000, 0b00000110},
{0b00000000, 0b00000000, 0b00000000, 0b00010010, 0b00010010, 0b00010010, 0b00001110},
{0b00000000, 0b00000000, 0b00000000, 0b00001010, 0b00001010, 0b00001010, 0b00000100},
{0b00000000, 0b00000000, 0b00000000, 0b00010010, 0b00010010, 0b00011110, 0b00011110},
{0b00000000, 0b00000000, 0b00000000, 0b00010010, 0b00001100, 0b00001100, 0b00010010},
{0b00000000, 0b00000000, 0b00010010, 0b00010010, 0b00001010, 0b00000100, 0b00001000},
{0b00000000, 0b00000000, 0b00000000, 0b00011110, 0b00000100, 0b00001000, 0b00011110},
};
void Delay_onesec(){
 Delay_ms(1000);
}
unsigned short Find_StrLength(){
 return strlen(message);
}

void Save_Message(){

 EEPROM_Write(0x01, StringLength);
 for(i=0; i<StringLength; i++){
 EEPROM_Write(i+2, message[i]);
 Delay_ms(20);
 }

 EEPROM_Write(i+2, 32);
 Delay_ms(5);
 EEPROM_Write(i+3, 32);
 Delay_ms(5);
 EEPROM_Write(i+4, 32);
 Delay_ms(5);
 EEPROM_Write(i+5, 32);
 Delay_ms(5);
 EEPROM_Write(i+6, 32);
 Delay_ms(5);
 EEPROM_Write(i+7, 32);
 Delay_ms(5);
 EEPROM_Write(i+8, 32);
 Delay_ms(5);

}

void Load_Data(){
 for (k=0; k<StringLength+7; k++){
 message[k] = EEPROM_Read(k+2);
 Delay_ms(20);
 }
}
void keyboard(){




 do{
 if(Ps2_Key_Read(&keydata, &special, &down)) {

 if (down && (keydata == 13)) {
 StringLength = Find_StrLength();
 Save_Message();

 key=0;
 }

 else if (down && !special && keydata) {
 message[key]=keydata;

 key++;
 }
 }
 Delay_ms(1);
 }
 while(keydata!=13 );

 }
void main() {


 TRISD = 0x00;



 TRISE = 0x00;
 TRISB = 0x00;


 ADCON0=0x00;
 PORTB=0x00;
 PORTD=0x00;
 PORTE=0x00;


 Ps2_Config();
 Delay_ms(100);
#line 268 "C:/Users/Public/Documents/pic files/c programs/led18shift.c"
 StringLength = EEPROM_Read(0x01);

 Load_Data();

 do {
 for (k=0; k<StringLength+7; k+=2){
 for (scroll=0; scroll<(10/shift_step); scroll++) {
 for (row=0; row<7; row++){
 if(Ps2_Key_Read(&keydata, &special, &down)) {
 if (down && (keydata == 34)) {
 PORTB= 0;

 do{
 if(Ps2_Key_Read(&keydata, &special, &down)) {

 if (down && (keydata == 13)) {
 StringLength = Find_StrLength();
 Save_Message();

 key=0;
 }

 else if (down && !special && keydata) {
 message[key]=keydata;

 key++;
 }
 }
 Delay_ms(1);
 }
 while(keydata!=13 );
 StringLength = EEPROM_Read(0x01);
 Load_Data();
 k=0;
 scroll=0;
 row=0;

 for(l=0; l<8; l++){
 Buffer[l][4] =0;
 Buffer[l][3] =0;
 Buffer[l][2] =0;
 Buffer[l][1] =0;
 Buffer[l][0] =0;
 }
 }
 }
#line 344 "C:/Users/Public/Documents/pic files/c programs/led18shift.c"
 index = message[k];
 index2= message[k+1];
 temp = CharData[index-32][row];
 temp2 = CharData[index2-32][row];

 Buffer[row][3] = (Buffer[row][3] << Shift_Step) | (Buffer[row][2] >> (10-Shift_Step));
 Buffer[row][2] = (Buffer[row][2] << Shift_Step) | (Buffer[row][1] >> (10-Shift_Step));
 Buffer[row][1] = (Buffer[row][1] << Shift_Step) | (Buffer[row][0] >> (10-Shift_Step));


 if(scroll<5)

 Buffer[row][0] = (Buffer[row][0] << Shift_Step)| (temp >> ((5-shift_step)-scroll*shift_step));
 else
 Buffer[row][0] = (Buffer[row][0] << Shift_Step)| (temp2 >> 9-scroll);


 }
 speed = 5;
 for(l=0; l<speed;l++){
 m = 1;
 for (i=0; i<7; i++) {

 Send_Data(i);
 PORTB= m;

 m = m << 1;
 Delay_us(1000);
 }
 }
 }
 }

} while(1);
}
