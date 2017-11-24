


 unsigned short Buffer[5] = {0,0,0,0,0};



unsigned int speed, StringLength;
unsigned short i,count,flag=0 ;


void Delay_onesec(){
  Delay_ms(1000);
}


// Subroutine to load the stored message onto RAM

  void interrupt()
{     
      if(PIR1.CCP1IF);
       {
           flag=2;
       }
       PIR1.CCP1IF=0;
   /* if(0==flag)
      { portd=3;
      }
      else      */
    //  portd=2  ;
   // flag++ ;

   // portd=3;
}
void main() {
 CMCON = 0x07;   // Disable comparators
 OPTION_REG  =0x05;
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
 PIE1 =  0b00000100;
      CCP1CON =0x04;
      INTCON = 0b11000000;
      PIR1.CCP1IF=0;
      /*if(flag ==2)
      portd=255;
      else*/
      //flag ++;
      do
      {
      portd++   ;
      delay_ms(1000)    ;
      //portd=flag; 
      }
      while(flag==1);
 /*if(flag!=31)
        {
          if(flag<9)
          i=0 ;
          else if(flag>8&&flag<17)
          i=1;
           else if(flag>17&&flag<25)
           i=2;
           else if(flag>25&&flag<31)
           i=3;
         if (flag==1)
         {     //bitset(portd,1);
                      ;
          if( PORTE.rd0==0)
          Buffer[i].rd0=0   ;
          else Buffer[i].rd0=1;
         }
         if (flag==2)
         {
          if( PORTE.rd0==0)
          Buffer[i].rd1=0   ;
          else Buffer[i].rd1=1;
         }
         if (flag==3)
         {
          if( PORTE.rd0==0)
          Buffer[i].rd2=0   ;
          else Buffer[i].rd2=1;
         }
         if (flag==4)
         {
          if( PORTE.rd0==0)
          Buffer[i].rd3=0   ;
          else Buffer[i].rd3=1;
         }
         if (flag==5)
         {
          if( PORTE.rd0==0)
          Buffer[i].rd4=0   ;
          else Buffer[i].rd4=1;
         }
         if (flag==6)
         {
          if( PORTE.rd0==0)
          Buffer[i].rd5=0   ;
          else Buffer[i].rd5=1;
         }
         if (flag==7)
         {
          if( PORTE.rd0==0)
          Buffer[i].rd6=0   ;
          else Buffer[i].rd6=1;
         }
       }
       else
       {
        PORTD  =Buffer[0];
        PORTA=0;
        PORTC  =Buffer[1];
        PORTB  =Buffer[2];
        flag=0;

       }    */
      // while(1)  ;
       // i haven"t catered for ccp1
   }