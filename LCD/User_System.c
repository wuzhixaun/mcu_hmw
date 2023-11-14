#ifndef _USER_SYSTEM_FILE
#define _USER_SYSTEM_FILE

#include "User_Include.h"
void PWM2_Init(void);
void pwm1_init(void);
void GPIO_Init(void);
void WDT_INITIAL(void);

void Delay_Us(unsigned char Time)
{
	unsigned char a;
	for(a=0;a<Time;a++)
	{
		NOP();
	}
}                  
void Delay_Ms(unsigned char Time)
{
	unsigned char a,b;
	for(a=0;a<Time;a++)
	{
		for(b=0;b<5;b++)
		{
		 	Delay_Us(97); // å¿?%
		}
	}
}
void Delay_S(unsigned char Time)
{
	unsigned char a,b;
	for(a=0;a<Time;a++)
	{
		for(b=0;b<10;b++)
		{
		 	Delay_Ms(100); //
		}
	}
}

/*
 *  º¯ÊýÃû: Set_Vref0V5
 *	ÉèÖÃÄÚ²¿µçÑ¹Îª0.5v
 */
void Set_Vref0V5(void)
{
	ADCON1 = 0B11010100; //BIT1:0  00Ñ¡ÔñÄÚVref
    ADCON2 = 0B00000000; //BIT7:6  00Ñ¡Ôñ0.5V
}
/*
 *  º¯ÊýÃû: Set_Vref0V5
 *	ÉèÖÃÄÚ²¿µçÑ¹Îª0.2v
 */
void Set_Vref2V(void)
{
	ADCON1 = 0B11010100; //BIT1:0  00Ñ¡ÔñÄÚVref
    ADCON2 = 0B01000000; //BIT7:6  010Ñ¡Ôñ2V
}
void Set_Vref3V(void)
{
	ADCON1 = 0B11010100; //BIT1:0  00Ñ¡ÔñÄÚVref
    ADCON2 = 0B10000000; //BIT7:6  10Ñ¡Ôñ3V
}
void Set_Vref5V(void)
{
	ADCON1 = 0B11010101; //BIT1:0  01Ñ¡VDD
    ADCON2 = 0B10000000; 
}

/*-------------------------------------------------
 *  º¯ÊýÃû: GET_ADC_DATA
 *	¹¦ÄÜ£º  ¶ÁÈ¡Í¨µÀADCÖµ
 *  ÊäÈë£º  adcChannel Í¨µÀÐòºÅ
 *  Êä³ö£º  INTÀàÐÍADÖµ(µ¥´Î²ÉÑùÎÞÂË²¨)
 --------------------------------------------------*/
unint Get_ADC_Data (unchar adcChannel) 
{ 
	ADCON0 &= 0B00001111;        				   
    ADCON0 |= adcChannel<<4; 				//ÖØÐÂ¼ÓÔØÍ¨µÀÖµ
	Delay_Us(40);                        	//Í¢Ê±µÈ´ýµçÑ¹ÎÈ¶¨ Tst >10us
	GO = 1;             					//Æô¶¯ADC 
    NOP();
    NOP();
	while(GO);    							//µÈ´ýADC×ª»»Íê³É

    return  (unint)(ADRESH<<8|ADRESL);      //ÕûºÏ12Î»ADÖµ
} 
void ADC_INITIAL(void)
{
    ADCEN=1; //ADÄ£¿éÊ±ÖÓÊ¹ÄÜ
   
    ANSELA = 0B00010000; //Ä£Äâ¿ÚÉèÖÃ£¬AN4ÎªÄ£Äâ¹Ü½Å
    ADCON1 = 0B11100100; 	//ÓÒ¶ÔÆë£¬×ª»»Ê±ÖÓFosc/64£¬¸º²Î¿¼µçÑ¹GND£¬Õý²Î¿¼µçÑ¹ÄÚ²¿µçÑ¹(2V)
    ADCON0 = 0B00000000; //Ñ¡ÔñAD×ª»»Í¨µÀ0£¬Ê¹ÄÜADC
    ADCON2 = 0B01000000; //Ñ¡ÔñÄÚ²¿Õý²Î¿¼µç2V£¬ÎÞÍâ²¿´¥·¢Ô´
    ADCON3 = 0B00000000; //ADC½á¹û±È½Ï¹Ø±Õ
    ADDLY  = 0B00000000;  //Íâ²¿´¥·¢Í¢Ê±£¬Ã»ÓÃµ½
    ADCMPH = 0B00000000; //ADC±È½ÏãÐÖµ,½ö8Î»£¬ÓÃÓÚADC½á¹û¸ß8Î»±È½Ï¡
    
    ADCAL = 1;           //Ð£×¼ADC, ×¢Òâµã£ºÐ£×¼Òª·ÅÔÚÅäÖÃÖ®ºó
    NOP();
    while (ADCAL)
    
    ADON = 1;            //È«ÄÜADC
}
void Clr_Ram(void)
{
    FSR0H = 0; //BANK0 0x070-0x7F
    for (FSR0L = 0x70; FSR0L < 0x80; FSR0L++)
    {
        INDF0 = 0;
    }

    FSR0H = 3; //BANK6 0x320-0x32F
    for (FSR0L = 0x20; FSR0L < 0x33; FSR0L++)
    {
        INDF0 = 0;
    }

    //ÏßÐÔÇøÓò
    for (FSR0H = 0x20; FSR0H < 0x30; FSR0H++)
    {
        for (FSR0L = 0x00; FSR0L < 0xFF; FSR0L++)
        {
            INDF0 = 0;
        }
        INDF0 = 0;
    }
}
void System_Init(void)
{
	GPIO_Init();
	ADC_INITIAL();
	WDT_INITIAL();
    PWM2_Init();
    INTCON = 0B11000000;
}
void GPIO_Init(void)
{
    OSCCON = 0B01110001; //WDT 32KHZ IRCF=111=16MHZ
                         //Bit0=1,ÏµÍ³Ê±ÖÓÎªÄÚ²¿Õñµ´Æ÷
                         //Bit0=0,Ê±ÖÓÔ´ÓÉFOSC<2£º0>¾ö¶¨¼´±àÒëÑ¡ÏîÊ±Ñ¡Ôñ
                         
    AFP0 = 0B00000000;
	AFP1 = 0x00;
    TRISA = 0B01000000; // ÉèÖÃPA6Òý½ÅÎªÊäÈë
    PORTA = 0B00000000; 
    WPUA  = 0B00000000;
    WPDA  = 0B00000000; 
    
	TRISB = 0B00000000; 
    PORTB = 0B00000000;
    WPUB  = 0B00111100; 
    WPDB  = 0B00111100; //PB¶Ë¿ÚÉÏÀ­¿ØÖÆ 1-¿ªÏÂÀ­ 0-¹ØÏÂÀ­
    
    TRISC = 0B00000000; 
    PORTC = 0B00000000;
    
    TRISD = 0B00000000; 
    PORTD = 0B00000000;    
    
    WPUC  = 0B00000000; 
    WPDC  = 0B00000000; //PC¶Ë¿ÚÉÏÀ­¿ØÖÆ 1-¿ªÏÂÀ­ 0-¹ØÏÂÀ­
    PSRC0  = 0B11111111;  	//PORTA,PORTBÔ´µçÁ÷ÉèÖÃ×î´ó
    //BIT7~BIT6:PORTB[7:4]Ô´µçÁ÷ÄÜÁ¦¿ØÖÆ,BIT5~BIT4:PORTB[3:0]Ô´µçÁ÷ÄÜÁ¦¿ØÖÆ 
    //BIT3~BIT2:PORTA[7:4]Ô´µçÁ÷ÄÜÁ¦¿ØÖÆ,BIT1~BIT0:PORTA[3:0]Ô´µçÁ÷ÄÜÁ¦¿ØÖÆ
    
    PSRC1  = 0B11111111;    //PORTC,PORTDÔ´µçÁ÷ÉèÖÃ×î´ó    
    //BIT7~BIT6:PORTD[7:4]Ô´µçÁ÷ÄÜÁ¦¿ØÖÆ,BIT5~BIT4:PORTD[3:0]Ô´µçÁ÷ÄÜÁ¦¿ØÖÆ 
    //BIT3~BIT2:PORTC[7:4]Ô´µçÁ÷ÄÜÁ¦¿ØÖÆ,BIT1~BIT0:PORTC[3:0]Ô´µçÁ÷ÄÜÁ¦¿ØÖÆ
    PSINK0 = 0B11111111; //PORTA¹àµçÁ÷ÉèÖÃ×î´ó 0:×îÐ¡£¬1:×î´ó
    PSINK1 = 0B11111111; //PORTB¹àµçÁ÷ÉèÖÃ×î´ó 0:×îÐ¡£¬1:×î´ó
    PSINK2 = 0B11111111; //PORTC¹àµçÁ÷ÉèÖÃ×î´ó 0:×îÐ¡£¬1:×î´ó
    PSINK3 = 0B11111111;	//PORTD¹àµçÁ÷ÉèÖÃ×î´ó 0:×îÐ¡£¬1:×î´ó 
    UARTEN=0;
}
void WDT_INITIAL(void)
{
    CLRWDT();            //Çå¿´ÃÅ¹·
    MISC0 = 0B00000000;  //¿´ÃÅ¹·Ê±ÖÓ32k
    WDTCON = 0B00001011; //WDTPS=1010=1:1024,Ô¤·ÖÆµ1:1
                         //¶¨Ê±Ê±¼ä=(1024*1)/32000=32ms
}
u8 EEPROMread(uchar EEAddr)
{
    u8 ReEEPROMread;

    NOP();
    NOP();
    EEADRL = EEAddr;
    CFGS = 0;
    EEPGD = 0;
    RD = 1;
    Delay_Us(4);
    ReEEPROMread = EEDATL;
    return ReEEPROMread;
}

void EEPROMwrite(uchar EEAddr,uchar Data)
{
    GIE = 0; 
    while (GIE);     
    EEADRL = EEAddr; 
    EEDATL = Data;  
    CFGS = 0;  
    EEPGD = 0; 
    WREN = 1;
    EEIF = 0;
    EECON2 = 0x55;
    EECON2 = 0xAA;
    WR = 1; 
    NOP();
    NOP();
    while (WR);
    WREN = 0;
    GIE = 1;
}
void PWM2_Init(void)
{
	PCKEN |=0B00000100;		//Ê¹ÄÜtimer2Ê±ÖÓÄ£¿é
    CKOCON=0B00100000;
    TCKSRC=0B00010001;		//TIM1/TIM2Ê±ÖÓÎªHIRC
    
	TIM2PSCR=0B00000100;
    
    TIM2CR1 =0B10000101;	//Ô¤ÔØÔÊÐí£¬±ßÑØ¶ÔÆëÏòÉÏ¼ÆÊýÆ÷£¬¼ÆÊýÆ÷Ê¹ÄÜ

    TIM2IER =0B00000001;	//½ûÖ¹ËùÓÐÖÐ¶Ï

    TIM2SR1 =0B00000000;
    TIM2SR2 = 0B00000000;
    TIM2EGR = 0B00000000;
    
    TIM2CCMR3 = 0B00000000;
    
    TIM2CCMR2 = 0B00000000;		
	//Bit7: ±£ÁôÎ»¡£
   
    TIM2CCMR1 = 0B00000000;		

    TIM2CCER1 = 0B00000000; 	//±È½Ï2»¥²¹Êä³öÊ¹ÄÜ£¬µÍµçÆ½ÓÐÐ§£»±È½ÏÆ÷1Êä³öÊ¹ÄÜ£¬µÍµçÆ½ÓÐÐ§

    TIM2CCER2 = 0B00000000;
    
    TIM2CNTRH = 0B00000000;		//TIM2¼ÆÊýÆ÷
    TIM2CNTRL = 0B00000000;
    
    
    TIM2ARRH = 0x09;        	//×Ô¶¯ÖØÔØ£¬ÖÜÆÚ
    TIM2ARRL = 0xC4;
  
    
    TIM2CCR1H = 0x00;       	//PWMÂö¿í
    TIM2CCR1L = 0x00;
    
    TIM2CCR2H = 0x00;
    TIM2CCR2L = 0x00;
    
    TIM2CCR3H = 0x00;
    TIM2CCR3L = 0x00;
  }
#endif

