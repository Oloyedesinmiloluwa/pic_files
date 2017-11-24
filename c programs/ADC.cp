#line 1 "C:/Users/Public/Documents/pic files/c programs/ADC.c"
sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D4 at RB0_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D7 at RB3_bit;

sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;
char READSAVE[7];
long v,Volt,i;

void main() {


 CMCON=0X07;
 TRISA=0x05;
 ADCON0=0;
 ADCON1=0x00;
 Lcd_Init();
 TRISB=0;
 PORTB=0;
 PORTA =0;
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 do{
 v=ADC_Read(0);
 Volt=v*4.89;
 Volt=(Volt/20)*120;
 Volt=volt/1000;
 longTostr(Volt,READSAVE);



 i++;
 Lcd_Out(1,1,"Voltage=") ;
 Lcd_Out(1,10,READSAVE);
 Lcd_Out(1,17,"V");
 }
 while(i<1) ;

}
