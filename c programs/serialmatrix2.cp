#line 1 "C:/Users/Public/Documents/pic files/c programs/serialmatrix2.c"



 unsigned short Buffer[5] = {0,0,0,0,0};



unsigned int speed, StringLength;
unsigned short i,count,flag=0 ;


void Delay_onesec(){
 Delay_ms(1000);
}






void main() {
 CMCON = 0x07;

 TRISD = 0x00;
 TRISC = 0x80;
 TRISB = 0x00;
 TRISA = 0x00;
 TRISE = 0x01;
 PORTA=0x00;
 PORTB=0x00;
 PORTD=0x00;
 PORTC=0x00;
 PORTE=0x00;


 UART1_Init(19200);
 Delay_ms(100);


 while (1) {
 if (UART1_Data_Ready()) {
 for (i=0; i<5; i++)
 {
 if(UART1_Read()==13)
 { PORTD =Buffer[0];
 PORTB=Buffer[1];
 PORTA =Buffer[2];
 PORTC =Buffer[3];
 i=0;
 break;
 }
 Buffer[i] = UART1_Read();
 }
 }


 }

 }
