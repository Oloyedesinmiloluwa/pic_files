

char i=0,j=0,data1;//,c,message[],num,text,plus;
void main() {
  UART1_Init(9600);               // Initialize UART module at 9600 bps
  Delay_ms(100);
  TRISD=0;
  portd=0;
 // Delay_ms(8000);
 do{
 portd.rd7=1;
 UART1_Write_Text("A\r\n"); /* Transmit AT to the module – GSM Modem sendsOK */
    Delay_ms(3000);
UART1_Write_Text("AT\r\n"); /* Transmit AT to the module – GSM Modem sendsOK */
  Delay_ms(2000); /* 2 sec delay */
  //UART1_Write_Text("AT+IPR=9600\r");
   while(UART1_Data_Ready())
  {
     data1=UART1_Read();
     EEPROM_Write(0x01+j,data1);
     j++;
     //Delay_ms(2000);
  }

UART1_Write_Text("ATE0\r\n"); /* Echo Off */
Delay_ms(2000); /* 2 sec delay */
UART1_Write_Text("ATD09032892040\r\n");
Delay_ms(8000);
  portd.rd7=0;
UART1_Write_Text("AT+CMGF=1\r\n"); /* Switch to text mode */
Delay_ms(2000); /* 2 sec delay */
UART1_Write_Text("AT+CMGS=\"09032892040\"\r\n"); /* Send SMS to a cell number */
Delay_ms(2000); /* 2 sec delay */
UART1_Write_Text("TEST DATA FROM RhydoLABZ-COCHIN"); /* Input SMS Data */
UART1_Write(0x1a); /* Ctrl-Z indicates end of SMS */
Delay_ms(2000); /* 2 sec delay */

i++     ;
}
while(i<4);
}
 /*//if(status==0){
 UART1_Write_Text("AT+CMGR=1\r\n") ;
  while(!Uart1_Data_Ready())
  Uart1_Read_Text(message,"#",400);
  for(c=1; c<StringLength; c++)
  {
     if(message[c]='+'){ 
     plus =1;
     char k;
     while(message[c]!='"'){
     num[k]= message[c]   ;
     k++;
     }
  }    */