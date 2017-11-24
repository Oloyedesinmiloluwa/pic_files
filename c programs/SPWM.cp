#line 1 "C:/Users/Public/Documents/pic files/c programs/SPWM.c"

const unsigned char SinLkUpTab[50]= {0, 8, 16, 24, 31, 39, 47, 55, 62, 70, 77, 85, 92, 99,
106, 113, 120, 127, 134, 141, 147, 153, 159, 165, 171, 177, 182, 188, 193, 198, 202, 207,
211, 215, 219, 223, 226, 229, 232, 235, 238, 240, 242, 244, 246, 247, 248, 249, 250, 250};
unsigned short cnt,inc,sqinc,cnt1, dec,toogle,flag;
void interrupt()
{
 flag=1;
 portc.rd0=1;

TMR1IF_bit = 0;
TMR1H = 0xFF;
TMR1L = 0x05;
}
void main()
{

TRISB = 0;
PORTC = 0;
PORTB = 0;
TRISC = 0;
TRISA = 0;
PORTA = 0;
TMR1IF_bit = 0;
TMR1H = 0xFF;
TMR1L = 0x05;
TMR1IE_bit = 1;
INTCON.GIE=1;
PEIE_bit =1;

cnt = 0;
dec=0;
flag=0;
PWM1_Init(20000);

T1CON= 0b00001001;
PWM1_Set_Duty(SinLkUpTab[cnt]);
PWM1_Start();
while(1){
if(flag==1)
{ flag==0;
 portb=cnt;

 if(cnt==0 && dec==1)
 { portc.ra4=~portc.ra4;
 dec=0;
 toogle=~toogle;
 PWM1_Set_Duty(SinLkUpTab[cnt]);
 }
 else
 {
 if(cnt==49&&dec==0)
 {
 cnt=50;
 dec= 1;
 }
 if (dec==0)
 {
 cnt++;
 PWM1_Set_Duty(SinLkUpTab[cnt]);
 }
 else if (dec==1)
 {
 portc.ra3=~portc.ra3;
 cnt-=10;
 PWM1_Set_Duty(SinLkUpTab[cnt]);

 }
 }
}
}
}
