#line 1 "C:/Users/Public/Documents/pic files/c programs/interrupt.c"






unsigned short datr;
char j=0,x=1,m=0,letter=0;
#line 19 "C:/Users/Public/Documents/pic files/c programs/interrupt.c"
void interrupt()
{
 datr ++;
if(datr==3)
{

 PORTD.b1=1;
 PORTC.rd0=1;

 }


 PIR1.CCP1IF=0;
}
void main()
{
CMCON = 0x07;
 TRISD = 0x00;
 TRISC = 0x00;

 TRISB = 0b00000000;
 PORTB=0x00;
 PORTD=0x00;
 PORTC=0x00;
 delay_ms(100);
 PIE1 = 0b00000100;
 CCP1CON =0x04;
 INTCON = 0b11000000;
 PIR1.CCP1IF=0;
 while(1==1) ;

}
