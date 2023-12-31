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
		 	Delay_Us(97); // 蹇?%
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
 *  函数名: Set_Vref0V5
 *	设置内部电压为0.5v
 */
void Set_Vref0V5(void)
{
	ADCON1 = 0B11010100; //BIT1:0  00选择内Vref
    ADCON2 = 0B00000000; //BIT7:6  00选择0.5V
}
/*
 *  函数名: Set_Vref0V5
 *	设置内部电压为0.2v
 */
void Set_Vref2V(void)
{
	ADCON1 = 0B11010100; //BIT1:0  00选择内Vref
    ADCON2 = 0B01000000; //BIT7:6  010选择2V
}
void Set_Vref3V(void)
{
	ADCON1 = 0B11010100; //BIT1:0  00选择内Vref
    ADCON2 = 0B10000000; //BIT7:6  10选择3V
}
void Set_Vref5V(void)
{
	ADCON1 = 0B11010101; //BIT1:0  01选VDD
    ADCON2 = 0B10000000; 
}

/*-------------------------------------------------
 *  函数名: GET_ADC_DATA
 *	功能：  读取通道ADC值
 *  输入：  adcChannel 通道序号
 *  输出：  INT类型AD值(单次采样无滤波)
 --------------------------------------------------*/
unint Get_ADC_Data (unchar adcChannel) 
{ 
	ADCON0 &= 0B00001111;        				   
    ADCON0 |= adcChannel<<4; 				//重新加载通道值
	Delay_Us(40);                        	//廷时等待电压稳定 Tst >10us
	GO = 1;             					//启动ADC 
    NOP();
    NOP();
	while(GO);    							//等待ADC转换完成

    return  (unint)(ADRESH<<8|ADRESL);      //整合12位AD值
} 
void ADC_INITIAL(void)
{
    ADCEN=1; //AD模块时钟使能
   
    ANSELA = 0B00010000; //模拟口设置，AN4为模拟管脚
    ADCON1 = 0B11100100; 	//右对齐，转换时钟Fosc/64，负参考电压GND，正参考电压内部电压(2V)
    ADCON0 = 0B00000000; //选择AD转换通道0，使能ADC
    ADCON2 = 0B01000000; //选择内部正参考电2V，无外部触发源
    ADCON3 = 0B00000000; //ADC结果比较关闭
    ADDLY  = 0B00000000;  //外部触发廷时，没用到
    ADCMPH = 0B00000000; //ADC比较阈值,仅8位，用于ADC结果高8位比较�
    
    ADCAL = 1;           //校准ADC, 注意点：校准要放在配置之后
    NOP();
    while (ADCAL)
    
    ADON = 1;            //全能ADC
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

    //线性区域
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
                         //Bit0=1,系统时钟为内部振荡器
                         //Bit0=0,时钟源由FOSC<2：0>决定即编译选项时选择
                         
    AFP0 = 0B00000000;
	AFP1 = 0x00;
    TRISA = 0B01000000; // 设置PA6引脚为输入
    PORTA = 0B00000000; 
    WPUA  = 0B00000000;
    WPDA  = 0B00000000; 
    
	TRISB = 0B00000000; 
    PORTB = 0B00000000;
    WPUB  = 0B00111100; 
    WPDB  = 0B00111100; //PB端口上拉控制 1-开下拉 0-关下拉
    
    TRISC = 0B00000000; 
    PORTC = 0B00000000;
    
    TRISD = 0B00000000; 
    PORTD = 0B00000000;    
    
    WPUC  = 0B00000000; 
    WPDC  = 0B00000000; //PC端口上拉控制 1-开下拉 0-关下拉
    PSRC0  = 0B11111111;  	//PORTA,PORTB源电流设置最大
    //BIT7~BIT6:PORTB[7:4]源电流能力控制,BIT5~BIT4:PORTB[3:0]源电流能力控制 
    //BIT3~BIT2:PORTA[7:4]源电流能力控制,BIT1~BIT0:PORTA[3:0]源电流能力控制
    
    PSRC1  = 0B11111111;    //PORTC,PORTD源电流设置最大    
    //BIT7~BIT6:PORTD[7:4]源电流能力控制,BIT5~BIT4:PORTD[3:0]源电流能力控制 
    //BIT3~BIT2:PORTC[7:4]源电流能力控制,BIT1~BIT0:PORTC[3:0]源电流能力控制
    PSINK0 = 0B11111111; //PORTA灌电流设置最大 0:最小，1:最大
    PSINK1 = 0B11111111; //PORTB灌电流设置最大 0:最小，1:最大
    PSINK2 = 0B11111111; //PORTC灌电流设置最大 0:最小，1:最大
    PSINK3 = 0B11111111;	//PORTD灌电流设置最大 0:最小，1:最大 
    UARTEN=0;
}
void WDT_INITIAL(void)
{
    CLRWDT();            //清看门狗
    MISC0 = 0B00000000;  //看门狗时钟32k
    WDTCON = 0B00001011; //WDTPS=1010=1:1024,预分频1:1
                         //定时时间=(1024*1)/32000=32ms
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
	PCKEN |=0B00000100;		//使能timer2时钟模块
    CKOCON=0B00100000;
    TCKSRC=0B00010001;		//TIM1/TIM2时钟为HIRC
    
	TIM2PSCR=0B00000100;
    
    TIM2CR1 =0B10000101;	//预载允许，边沿对齐向上计数器，计数器使能

    TIM2IER =0B00000001;	//禁止所有中断

    TIM2SR1 =0B00000000;
    TIM2SR2 = 0B00000000;
    TIM2EGR = 0B00000000;
    
    TIM2CCMR3 = 0B00000000;
    
    TIM2CCMR2 = 0B00000000;		
	//Bit7: 保留位。
   
    TIM2CCMR1 = 0B00000000;		

    TIM2CCER1 = 0B00000000; 	//比较2互补输出使能，低电平有效；比较器1输出使能，低电平有效

    TIM2CCER2 = 0B00000000;
    
    TIM2CNTRH = 0B00000000;		//TIM2计数器
    TIM2CNTRL = 0B00000000;
    
    
    TIM2ARRH = 0x09;        	//自动重载，周期
    TIM2ARRL = 0xC4;
  
    
    TIM2CCR1H = 0x00;       	//PWM脉宽
    TIM2CCR1L = 0x00;
    
    TIM2CCR2H = 0x00;
    TIM2CCR2L = 0x00;
    
    TIM2CCR3H = 0x00;
    TIM2CCR3L = 0x00;
  }
#endif

