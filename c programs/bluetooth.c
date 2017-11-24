char message[80],data1,i=0;
void main() {
  //uart1_inIt();
  TrisD=0x00;
  portd=0x00;
  UART1_Init(9600);
  Delay_ms(100);
    portd.rd6=1;
  /*   UART1_Write_Text("AT\r\n");
     Delay_ms(2000);
      UART1_Write_Text("AT+NAMESunnol\r\n");
     Delay_ms(2000);
     //you have to restart the module
     //no need since its just once
     UART1_Write_Text("AT+PIN1111\r\n");
     Delay_ms(2000);     */
  do
  {
     if(UART1_Data_Ready())
     {
           data1 = UART1_Read();
            portd.rd7=1;
            delay_ms(1000);
             portd.rd7=0;
              delay_ms(1000);
          //    i++;
          //    EEPROM_Write(0x01+i,data1);
           if (data1=='1') {
           if(Portd.rd0==0)
              Portd.rd0=1  ;
              else
              Portd.rd0=0  ;
              }
           if (data1=='2') {
           if(Portd.rd1==0)
              Portd.rd1=1  ;
              else
              Portd.rd1=0  ;
              }
              if (data1=='3') {
           if(Portd.rd2==0)
              Portd.rd2=1  ;
              else
              Portd.rd2=0  ;
              }
              if (data1=='4') {
           if(Portd.rd3==0)
              Portd.rd3=1  ;
              else
              Portd.rd3=0  ;
              }
              if (data1=='5') {
           if(Portd.rd4==0)
              Portd.rd4=1  ;
              else
              Portd.rd4=0  ;
              }
            /*  if (data1==35) {
           if(Portd.rd5==0)
              Portd.rd5=1  ;
              else
              Portd.rd5=0  ;
              }              */
     }
  /*   if(UART1_Data_Ready())
     {
           UART1_Read_Text( message,"#",80)
     }        */
  }
  while(1)   ;
}