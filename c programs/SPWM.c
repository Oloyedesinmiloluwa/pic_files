
const unsigned char SinLkUpTab[50]= {0, 8, 16, 24, 31, 39, 47, 55, 62, 70, 77, 85, 92, 99,
106, 113, 120, 127, 134, 141, 147, 153, 159, 165, 171, 177, 182, 188, 193, 198, 202, 207,
211, 215, 219, 223, 226, 229, 232, 235, 238, 240, 242, 244, 246, 247, 248, 249, 250, 250};
unsigned short cnt,inc,sqinc,cnt1, dec,toogle,flag;
void interrupt()
{   
 flag=1;
 portc.rd0=1;
//if(cnt==0 && dec==0){
TMR1IF_bit = 0; // clear TMR0IF
TMR1H = 0xFF; // Initialize Timer1 register
TMR1L = 0x05;
}
void main()
{

TRISB = 0; // designate PORTB pins as output
PORTC = 0; // set PORTC to 0
PORTB = 0; // set PORTC to 0
TRISC = 0; // designate PORTC pins as output
TRISA = 0; // designate PORTB pins as output
PORTA = 0; // set PORTA to 0
TMR1IF_bit = 0; // clear TMR1IF
TMR1H = 0xFF; // Initialize Timer1 register
TMR1L = 0x05;
TMR1IE_bit = 1; // enable Timer1 interrupT
INTCON.GIE=1;
PEIE_bit  =1;
//GIE_bit=1;
cnt = 0; // initialize cnt
dec=0;
flag=0;
PWM1_Init(20000);

T1CON= 0b00001001; // Timer1 settings
PWM1_Set_Duty(SinLkUpTab[cnt]);
PWM1_Start();
while(1){
if(flag==1)       //wait for interrupt
{   flag==0;
 portb=cnt;//porta.rc0 =cnt;

       if(cnt==0 && dec==1)
    {     portc.ra4=~portc.ra4;
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