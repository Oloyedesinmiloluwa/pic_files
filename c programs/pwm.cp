#line 1 "C:/Users/Public/Documents/pic files/c programs/pwm.c"
char duty1,duty2;
 const unsigned char sinT[50]={0,8,16,24,31,39,47,55,62,70,77,85,92,99,106,113,120,127,134,141,147,153,159,165,171,177,182,188,193,198,202,207,211,215,219,223,226,229,232,235,238,240,242,244,246,247,248,249,250,250};
void interrupt(){


}
void main() {
 PORTB = 0;
 TRISB = 0;
 PORTC = 0;
 TRISC = 0;
 T1CON=0b00000001;
 TMR1IF_BIT=0;
 TMR1H=0XFF;
 TMR1L=76;
 TMR1IE_BIT=1;
 PWM1_Init(2000);
 PWM2_Init(2000);
 duty1 =50; duty2=50;
 pwm1_start();
 pwm2_start();
 pwm1_set_duty(duty1);
 pwm2_set_duty(duty2);

}
