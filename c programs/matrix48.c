
 sbit PS2_Data            at RC0_bit;
sbit PS2_Clock           at RC1_bit;
sbit PS2_Data_Direction  at TRISC0_bit;
sbit PS2_Clock_Direction at TRISC1_bit;
 unsigned short Buffer[8][6] = {
                              {0,0,0,0,0,0},
                              {0,0,0,0,0,0},
                              {0,0,0,0,0,0},
                              {0,0,0,0,0,0},
                              {0,0,0,0,0,0},
                              {0,0,0,0,0,0},
                              {0,0,0,0,0,0},
                              {0,0,0,0,0,0}

                             };

unsigned int speed, StringLength;
unsigned short i, l, k, row, scroll, temp, shift_step=2;
unsigned short keydata = 0, special = 0, down = 0,key=0;
unsigned short m;

//const unsigned char default_message[]="CCAA ";

char message[400], index,data1;

void Send_Data(unsigned short rw){
 unsigned short Mask, t, num, Fflag;
 for (num = 0; num < 6; num++) {
  Mask = 0x01;

  for (t=0; t<8; t++){              //each bit

   Fflag = Buffer[rw][num] & Mask;
   if(Fflag==0) PORTD.b0 = 0;
   else PORTD.b0 = 1;

   PORTD.b1 = 1    ;    //to
   PORTD.b1 = 0;


   Mask = Mask << 1;
  }
  }
      PORTD.b2 = 1    ;    //to
   PORTD.b2 = 0;
}
  const unsigned short CharData[][7] ={
{0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000},
{0b00000000, 0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00000000, 0b00000100},
{0b00000000, 0b00001010, 0b00001010, 0b00001010, 0b00000000, 0b00000000, 0b00000000},
{0b00000000, 0b00000000, 0b00001010, 0b00011111, 0b00001010, 0b00011111, 0b00001010}, //#
{0b00000000, 0b00000000, 0b00001110, 0b00010100, 0b00001110, 0b00000101, 0b00001110},
{0b00000000, 0b00010000, 0b00010010, 0b00000100, 0b00001000, 0b00010010, 0b00000010},
{0b00000000, 0b00000000, 0b00001000, 0b00010100, 0b00001000, 0b00010100, 0b00001010},
{0b00000000, 0b00000100, 0b00000100, 0b00000100, 0b00000000, 0b00000000, 0b00000000},
{0b00000000, 0b00000100, 0b00001000, 0b00001000, 0b00001000, 0b00000100, 0b00000000},
{0b00000000, 0b00001000, 0b00000100, 0b00000100, 0b00000100, 0b00001000, 0b00000000},
{0b00000000, 0b00000000, 0b00001010, 0b00000100, 0b00001110, 0b00000100, 0b00001010},
{0b00000000, 0b00000000, 0b00000100, 0b00000100, 0b00011111, 0b00000100, 0b00000100},
{0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000110, 0b00000100, 0b00001000}, //,
{0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00011110, 0b00000000, 0b00000000},
{0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00001100, 0b00001100},   //.
{0b00000000, 0b00000000, 0b00000010, 0b00000100, 0b00001000, 0b00010000, 0b00000000},
{0b00000100, 0b00000100, 0b00001010, 0b00001010, 0b00001010, 0b00001010, 0b00000100},
{0b00000000, 0b00000100, 0b00001100, 0b00000100, 0b00000100, 0b00000100, 0b00001110},
{0b00000000, 0b00001100, 0b00010010, 0b00000010, 0b00000100, 0b00001000, 0b00011110},
{0b00000000, 0b00011110, 0b00000010, 0b00001100, 0b00000010, 0b00010010, 0b00001100}, //
{0b00000000, 0b00000100, 0b00001100, 0b00010100, 0b00011110, 0b00000100, 0b00000100},
{0b00000000, 0b00011110, 0b00010000, 0b00011100, 0b00000010, 0b00010010, 0b00001100},
{0b00000000, 0b00001100, 0b00010000, 0b00011100, 0b00010010, 0b00010010, 0b00001100},
{0b00000000, 0b00011110, 0b00000010, 0b00000100, 0b00000100, 0b00001000, 0b00001000},
{0b00000000, 0b00001100, 0b00010010, 0b00001100, 0b00010010, 0b00010010, 0b00001100},
{0b00000000, 0b00001100, 0b00010010, 0b00010010, 0b00001110, 0b00000010, 0b00001100},
{0b00000000, 0b00000000, 0b00001100, 0b00001100, 0b00000000, 0b00001100, 0b00001100},
{0b00000000, 0b00000000, 0b00001100, 0b00001100, 0b00000000, 0b00001100, 0b00001000}, //;
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
{0b00000000, 0b00001110, 0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00000100}, //t
{0b00000000, 0b00010010, 0b00010010, 0b00010010, 0b00010010, 0b00010010, 0b00001100},
{0b00000000, 0b00010010, 0b00010010, 0b00010010, 0b00010010, 0b00001100, 0b00001100},
{0b00000000, 0b00010010, 0b00010010, 0b00010010, 0b00011110, 0b00011110, 0b00010010},
{0b00000000, 0b00010010, 0b00010010, 0b00001100, 0b00001100, 0b00010010, 0b00010010},
{0b00000000, 0b00001010, 0b00001010, 0b00001010, 0b00000100, 0b00000100, 0b00000100},
{0b00000000, 0b00011110, 0b00000010, 0b00000100, 0b00001000, 0b00010000, 0b00011110},//z
};
unsigned short Find_StrLength(){
  return strlen(message);
}

void Save_Message(){
  EEPROM_Write(0x01, StringLength);
  for(i=0; i<StringLength; i++){
    EEPROM_Write(i+2, message[i]);
     Delay_ms(5);
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
}
// Subroutine to load the stored message onto RAM
void Load_Data(){
 for (k=0; k<StringLength+5; k++){
  message[k] = EEPROM_Read(k+2);
   Delay_ms(5);
 }
}

void main() {
 //CMCON = 0x07;   // Disable comparators
 //OPTION_REG  =0x05;
 TRISD = 0x00;
 //TRISC = 0b00000011;
// PS2_Data_Direction  =1;
//PS2_Clock_Direction =1;
 TRISE = 0x00;
 TRISB = 0x00;
// TRISA = 0xF8;
 ADCON0=0x00;
 PORTB=0x00;
 PORTD=0x00;
 PORTE=0x00;
 UART1_Init(115200);
  Delay_ms(100);
 Ps2_Config();
                                           // Init PS/2 Keyboard
  Delay_ms(100);
 /* if(portd.rd7!=0) {     //   needs a high to allow input
 do{
  if(Ps2_Key_Read(&keydata, &special, &down)) {

      if (down && (keydata == 13)) {
           StringLength = Find_StrLength();
           Save_Message();
            //portd.rd4 =0;
            key=0;
         }

     else if (down && !special && keydata) {
        message[key]=keydata;
        // portd.rd4 =1;
         key++;
      }
      if (down && (keydata == 16))
         key--;
    }
    Delay_ms(1);
    }
     while(keydata!=13 );
     }                  */
          //StringLength = Find_StrLength();     //remove later
          //Save_Message();
   StringLength = EEPROM_Read(0x01);
  Load_Data();  // Read stored data and save into RAM

 do {
 for (k=0; k<StringLength+5; k++){
  for (scroll=0; scroll<(8/shift_step); scroll++) {
   for (row=0; row<7; row++){
   
    if(Ps2_Key_Read(&keydata, &special, &down)) {
      if (down && (keydata == 34)) {
      PORTB= 0;
     // message[]="";
     //while( keydata != 34);
  do{
  if(Ps2_Key_Read(&keydata, &special, &down)) {

      if (down && (keydata == 13)) {
          // StringLength = Find_StrLength();
            StringLength =  key;
            Save_Message();

            key=0;
         }

     else if (down && !special && keydata) {
        message[key]=keydata;

         key++;
      }
       if (down && (keydata == 16))
         key--;
    }
    Delay_ms(1);
    }
     while(keydata!=13 );             //key!=0 && down==0
       StringLength = EEPROM_Read(0x01);
       Load_Data();
       k=0;
       scroll=0;
       row=0;

       for(l=0; l<8; l++){
       Buffer[l][5] =0;
        Buffer[l][4] =0;
         Buffer[l][3] =0;
         Buffer[l][2] =0;
         Buffer[l][1] =0;
         Buffer[l][0] =0;
        }
    }
    }    //for ps2_read

     if(UART1_Data_Ready())
     {

     data1 = UART1_Read();
    // EEPROM_Write(0x00,data1);

     if(data1=='k')  {
     UART1_Write('y');
     PORTB= 0;

     while(!UART1_Data_Ready());
     UART1_Read_Text(message,"#",255);
      StringLength = Find_StrLength();
      Save_Message();
       StringLength = EEPROM_Read(0x01);
       Load_Data();
       k=0;
       scroll=0;
       row=0;

       for(l=0; l<8; l++){
       Buffer[l][5] =0; //forgot in d first project
        Buffer[l][4] =0;
         Buffer[l][3] =0;
         Buffer[l][2] =0;
         Buffer[l][1] =0;
         Buffer[l][0] =0;
        }
     }
     }
   
     index = message[k];
     if(index <32 || index > 90 )
     {index = 32;
     }
     temp = CharData[index-32][row];
     //temp2 = CharData[index-32][row];
     Buffer[row][5] = (Buffer[row][5] << Shift_Step) | (Buffer[row][4] >> (8-Shift_Step));
     Buffer[row][4] = (Buffer[row][4] << Shift_Step) | (Buffer[row][3] >> (8-Shift_Step));
     Buffer[row][3] = (Buffer[row][3] << Shift_Step) | (Buffer[row][2] >> (8-Shift_Step));
     Buffer[row][2] = (Buffer[row][2] << Shift_Step) | (Buffer[row][1] >> (8-Shift_Step));
     Buffer[row][1] = (Buffer[row][1] << Shift_Step) | (Buffer[row][0] >> (8-Shift_Step));
     Buffer[row][0] = (Buffer[row][0] << Shift_Step)| (temp >> ((8-shift_step)-scroll*shift_step));
   }
   speed = 5;
   for(l=0; l<speed;l++){
     m = 1;
     for (i=0; i<7; i++) {    //each row
       Send_Data(i);

        LATB=m;

       m = m << 1;
       Delay_us(1000);
     }  // i
   } // l
  } // scroll
 } // k

} while(1);
}
//tested with key @ledshift 48 COL