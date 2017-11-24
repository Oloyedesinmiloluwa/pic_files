 //#include <16f877a.h>
//#byte intcon=0x0b
//#byte portb=0x06
//#byte portd=0x08 // Display Data
//#define ex_int_f intcon.1 // external interrupt flag bit
#define data_line portb.1 // PS2D = RB1
unsigned short datr;
char j=0,x=1,m=0,letter=0;
/* The interrupt routine:
1- Variable (j) to count the number of input
stream
2- Variable (letter) to store the received bits
3- Variable (m) to count the number of make-
break code bits
*/
//#int_ext


void interrupt()
{       
        datr ++;
if(datr==3)
{
    //PORTD=0xFF;
    PORTD.b1=1;
    PORTC.rd0=1;
    //PORTD.rd
   }
  //  Delay_ms(1000);
    //PORTD=0;
    PIR1.CCP1IF=0;
}
void main()
{
CMCON = 0x07;   // Disable comparators
 TRISD = 0x00;
 TRISC = 0x00;
 //TRISB = 0x00;
 TRISB  = 0b00000000;  // PORTB is now all output
 PORTB=0x00;
 PORTD=0x00;
 PORTC=0x00;
 delay_ms(100);
      PIE1 =  0b00000100;
      CCP1CON =0x04;
      INTCON = 0b11000000;
      PIR1.CCP1IF=0;
        while(1==1)  ;

}
