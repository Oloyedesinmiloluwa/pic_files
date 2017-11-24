#line 1 "C:/Users/Public/Documents/pic files/c programs/ledc2matrix.c"



 unsigned short Buffer[5] = {0,0,0,0,0};



unsigned int speed, StringLength;
unsigned short i,count,flag=0 ;


void Delay_onesec(){
 Delay_ms(1000);
}




 void interrupt()
{
 if(PIR1.CCP1IF);
 {
 flag=2;
 }
 PIR1.CCP1IF=0;
#line 34 "C:/Users/Public/Documents/pic files/c programs/ledc2matrix.c"
}
void main() {
 CMCON = 0x07;
 OPTION_REG =0x05;
 TRISD = 0x00;
 TRISC = 0x04;
 TRISB = 0x00;
 TRISA = 0x00;
 TRISE = 0x01;
 PORTA=0x00;
 PORTB=0x00;
 PORTD=0x00;
 PORTC=0x00;
 PORTE=0x00;
 INTCON = 0;
 PIE1 = 0b00000100;
 CCP1CON =0x04;
 INTCON = 0b11000000;
 PIR1.CCP1IF=0;
#line 57 "C:/Users/Public/Documents/pic files/c programs/ledc2matrix.c"
 do
 {
 portd++ ;
 delay_ms(1000) ;

 }
 while(1==1);
#line 129 "C:/Users/Public/Documents/pic files/c programs/ledc2matrix.c"
 }
