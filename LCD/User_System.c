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
		 	Delay_Us(97); // �?%
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
 *  ������: Set_Vref0V5
 *	�����ڲ���ѹΪ0.5v
 */
void Set_Vref0V5(void)
{
	ADCON1 = 0B11010100; //BIT1:0  00ѡ����Vref
    ADCON2 = 0B00000000; //BIT7:6  00ѡ��0.5V
}
/*
 *  ������: Set_Vref0V5
 *	�����ڲ���ѹΪ0.2v
 */
void Set_Vref2V(void)
{
	ADCON1 = 0B11010100; //BIT1:0  00ѡ����Vref
    ADCON2 = 0B01000000; //BIT7:6  010ѡ��2V
}
void Set_Vref3V(void)
{
	ADCON1 = 0B11010100; //BIT1:0  00ѡ����Vref
    ADCON2 = 0B10000000; //BIT7:6  10ѡ��3V
}
void Set_Vref5V(void)
{
	ADCON1 = 0B11010101; //BIT1:0  01ѡVDD
    ADCON2 = 0B10000000; 
}

/*-------------------------------------------------
 *  ������: GET_ADC_DATA
 *	���ܣ�  ��ȡͨ��ADCֵ
 *  ���룺  adcChannel ͨ�����
 *  �����  INT����ADֵ(���β������˲�)
 --------------------------------------------------*/
unint Get_ADC_Data (unchar adcChannel) 
{ 
	ADCON0 &= 0B00001111;        				   
    ADCON0 |= adcChannel<<4; 				//���¼���ͨ��ֵ
	Delay_Us(40);                        	//͢ʱ�ȴ���ѹ�ȶ� Tst >10us
	GO = 1;             					//����ADC 
    NOP();
    NOP();
	while(GO);    							//�ȴ�ADCת�����

    return  (unint)(ADRESH<<8|ADRESL);      //����12λADֵ
} 
void ADC_INITIAL(void)
{
    ADCEN=1; //ADģ��ʱ��ʹ��
   
    ANSELA = 0B00010000; //ģ������ã�AN4Ϊģ��ܽ�
    ADCON1 = 0B11100100; 	//�Ҷ��룬ת��ʱ��Fosc/64�����ο���ѹGND�����ο���ѹ�ڲ���ѹ(2V)
    ADCON0 = 0B00000000; //ѡ��ADת��ͨ��0��ʹ��ADC
    ADCON2 = 0B01000000; //ѡ���ڲ����ο���2V�����ⲿ����Դ
    ADCON3 = 0B00000000; //ADC����ȽϹر�
    ADDLY  = 0B00000000;  //�ⲿ����͢ʱ��û�õ�
    ADCMPH = 0B00000000; //ADC�Ƚ���ֵ,��8λ������ADC�����8λ�Ƚϡ
    
    ADCAL = 1;           //У׼ADC, ע��㣺У׼Ҫ��������֮��
    NOP();
    while (ADCAL)
    
    ADON = 1;            //ȫ��ADC
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

    //��������
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
                         //Bit0=1,ϵͳʱ��Ϊ�ڲ�����
                         //Bit0=0,ʱ��Դ��FOSC<2��0>����������ѡ��ʱѡ��
                         
    AFP0 = 0B00000000;
	AFP1 = 0x00;
    TRISA = 0B01000000; // ����PA6����Ϊ����
    PORTA = 0B00000000; 
    WPUA  = 0B00000000;
    WPDA  = 0B00000000; 
    
	TRISB = 0B00000000; 
    PORTB = 0B00000000;
    WPUB  = 0B00111100; 
    WPDB  = 0B00111100; //PB�˿��������� 1-������ 0-������
    
    TRISC = 0B00000000; 
    PORTC = 0B00000000;
    
    TRISD = 0B00000000; 
    PORTD = 0B00000000;    
    
    WPUC  = 0B00000000; 
    WPDC  = 0B00000000; //PC�˿��������� 1-������ 0-������
    PSRC0  = 0B11111111;  	//PORTA,PORTBԴ�����������
    //BIT7~BIT6:PORTB[7:4]Դ������������,BIT5~BIT4:PORTB[3:0]Դ������������ 
    //BIT3~BIT2:PORTA[7:4]Դ������������,BIT1~BIT0:PORTA[3:0]Դ������������
    
    PSRC1  = 0B11111111;    //PORTC,PORTDԴ�����������    
    //BIT7~BIT6:PORTD[7:4]Դ������������,BIT5~BIT4:PORTD[3:0]Դ������������ 
    //BIT3~BIT2:PORTC[7:4]Դ������������,BIT1~BIT0:PORTC[3:0]Դ������������
    PSINK0 = 0B11111111; //PORTA������������ 0:��С��1:���
    PSINK1 = 0B11111111; //PORTB������������ 0:��С��1:���
    PSINK2 = 0B11111111; //PORTC������������ 0:��С��1:���
    PSINK3 = 0B11111111;	//PORTD������������ 0:��С��1:��� 
    UARTEN=0;
}
void WDT_INITIAL(void)
{
    CLRWDT();            //�忴�Ź�
    MISC0 = 0B00000000;  //���Ź�ʱ��32k
    WDTCON = 0B00001011; //WDTPS=1010=1:1024,Ԥ��Ƶ1:1
                         //��ʱʱ��=(1024*1)/32000=32ms
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
	PCKEN |=0B00000100;		//ʹ��timer2ʱ��ģ��
    CKOCON=0B00100000;
    TCKSRC=0B00010001;		//TIM1/TIM2ʱ��ΪHIRC
    
	TIM2PSCR=0B00000100;
    
    TIM2CR1 =0B10000101;	//Ԥ���������ض������ϼ�������������ʹ��

    TIM2IER =0B00000001;	//��ֹ�����ж�

    TIM2SR1 =0B00000000;
    TIM2SR2 = 0B00000000;
    TIM2EGR = 0B00000000;
    
    TIM2CCMR3 = 0B00000000;
    
    TIM2CCMR2 = 0B00000000;		
	//Bit7: ����λ��
   
    TIM2CCMR1 = 0B00000000;		

    TIM2CCER1 = 0B00000000; 	//�Ƚ�2�������ʹ�ܣ��͵�ƽ��Ч���Ƚ���1���ʹ�ܣ��͵�ƽ��Ч

    TIM2CCER2 = 0B00000000;
    
    TIM2CNTRH = 0B00000000;		//TIM2������
    TIM2CNTRL = 0B00000000;
    
    
    TIM2ARRH = 0x09;        	//�Զ����أ�����
    TIM2ARRL = 0xC4;
  
    
    TIM2CCR1H = 0x00;       	//PWM����
    TIM2CCR1L = 0x00;
    
    TIM2CCR2H = 0x00;
    TIM2CCR2L = 0x00;
    
    TIM2CCR3H = 0x00;
    TIM2CCR3L = 0x00;
  }
#endif

