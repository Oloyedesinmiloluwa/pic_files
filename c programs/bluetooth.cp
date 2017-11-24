#line 1 "C:/Users/Public/Documents/pic files/c programs/bluetooth.c"
char message[80],data1,i=0;
void main() {

 TrisD=0x00;
 portd=0x00;
 UART1_Init(9600);
 Delay_ms(100);
 portd.rd6=1;
#line 17 "C:/Users/Public/Documents/pic files/c programs/bluetooth.c"
 do
 {
 if(UART1_Data_Ready())
 {
 data1 = UART1_Read();
 portd.rd7=1;
 delay_ms(1000);
 portd.rd7=0;
 delay_ms(1000);


 if (data1=='1') {
 if(Portd.rd0==0)
 Portd.rd0=1 ;
 else
 Portd.rd0=0 ;
 }
 if (data1=='2') {
 if(Portd.rd1==0)
 Portd.rd1=1 ;
 else
 Portd.rd1=0 ;
 }
 if (data1=='3') {
 if(Portd.rd2==0)
 Portd.rd2=1 ;
 else
 Portd.rd2=0 ;
 }
 if (data1=='4') {
 if(Portd.rd3==0)
 Portd.rd3=1 ;
 else
 Portd.rd3=0 ;
 }
 if (data1=='5') {
 if(Portd.rd4==0)
 Portd.rd4=1 ;
 else
 Portd.rd4=0 ;
 }
#line 64 "C:/Users/Public/Documents/pic files/c programs/bluetooth.c"
 }
#line 69 "C:/Users/Public/Documents/pic files/c programs/bluetooth.c"
 }
 while(1) ;
}
