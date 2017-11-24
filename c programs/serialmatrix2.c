


 unsigned short Buffer[5] = {0,0,0,0,0};



unsigned int speed, StringLength;
unsigned short i,count,flag=0 ;


void Delay_onesec(){
  Delay_ms(1000);
}


// Subroutine to load the stored message onto RAM



void main() {
 CMCON = 0x07;   // Disable comparators
// OPTION_REG  =0x05;
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


  UART1_Init(19200);               // Initialize UART module at 9600 bps
  Delay_ms(100);                  // Wait for UART module to stabilize


  while (1) {                     // Endless loop
    if (UART1_Data_Ready()) {     // If data is received,
      for (i=0; i<5; i++)
      {
      if(UART1_Read()==13)
      {   PORTD  =Buffer[0];
        PORTB=Buffer[1];
        PORTA  =Buffer[2];
        PORTC  =Buffer[3];
        i=0;
       break;
      }
      Buffer[i] = UART1_Read();     // read the received data,
       }
    }

       // i haven"t catered for ccp1
   }
   
   }