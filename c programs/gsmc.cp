#line 1 "C:/Users/Public/Documents/pic files/c programs/gsmc.c"


char i=0,j=0,data1;
void main() {
 UART1_Init(9600);
 Delay_ms(100);
 TRISD=0;
 portd=0;

 do{
 portd.rd7=1;
 UART1_Write_Text("A\r\n");
 Delay_ms(3000);
UART1_Write_Text("AT\r\n");
 Delay_ms(2000);

 while(UART1_Data_Ready())
 {
 data1=UART1_Read();
 EEPROM_Write(0x01+j,data1);
 j++;

 }

UART1_Write_Text("ATE0\r\n");
Delay_ms(2000);
UART1_Write_Text("ATD09032892040\r\n");
Delay_ms(8000);
 portd.rd7=0;
UART1_Write_Text("AT+CMGF=1\r\n");
Delay_ms(2000);
UART1_Write_Text("AT+CMGS=\"09032892040\"\r\n");
Delay_ms(2000);
UART1_Write_Text("TEST DATA FROM RhydoLABZ-COCHIN");
UART1_Write(0x1a);
Delay_ms(2000);

i++ ;
}
while(i<4);
}
