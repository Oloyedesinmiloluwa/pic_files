void main()
 {

	TRISB=0;
	PORTB=0;
	for( ;;)
{
	PORTB=0XFF    ;
	Delay_ms(1000)  ;
	PORTB=0        ;
        Delay_ms(1000) ;
}

}