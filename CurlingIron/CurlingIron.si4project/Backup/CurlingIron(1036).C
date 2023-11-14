
#include	"SYSCFG.h"

//宏定义****************************************************
#define  unchar     unsigned char 
#define  unint      unsigned int
#define  unlong     unsigned long
#define bAD_KEY TRISA6

volatile long int  adcData;
volatile long int  theVoltage;
/*-------------------------------------------------
 *  函数名： interrupt ISR
 *	功能：  中断处理，包括定时器0中断和外部中断
 *  输入：  无
 *  输出：  无
 --------------------------------------------------*/
void interrupt ISR(void)            	//PIC_HI-TECH使用
{ 

}
/*-------------------------------------------------
 *  函数名：POWER_INITIAL
 *	功能：  上电系统初始化
 *  输入：  无
 *  输出：  无
 --------------------------------------------------*/	
void POWER_INITIAL (void) 
{
	 OSCCON = 0B01110001;	//16MHZ 1:1
	//BIT7~BIT4:主时钟（系统时钟）分频比选择。0111(1:1),0110(1:2),0101(1:4),0100(1:8),0011(1:16),0010,(1:32),0001(1:64),1xxx(1:128),0000(32kHz LIRC)
	//BIT3:振荡器起振超时状态位。1：器件运行在FOSC<2:0>指定的外部时钟之下；0：器件运行在内部振荡器之下
	//BIT2:高速内部时钟状态。 1：HIRC is ready；0：HIRC is not ready
	//Bit1：低速内部时钟状态。1：LIRC is ready；0：LIRC is not ready
	//Bit0:系统时钟选择位。1：系统时钟选择为内部振荡器；0：时钟源由FOSC<2:0>决定
    
    PCKEN |=0B00000001;      //AD模块时钟使能
    
	INTCON = 0;  			//暂禁止所有中断
    
	PORTA = 0B00000000;		
	TRISA = 0B11111111;		//PA输入输出 0-输出 1-输入
	PORTB = 0B00000000;		
	TRISB = 0B11111111;		//PB输入输出 0-输出 1-输入							
	PORTC = 0B00000000; 	
	TRISC = 0B11111111;		//PC输入输出 0-输出 1-输入  	
    PORTD = 0B00000000;		
	TRISD = 0B11111111;		//PD输入输出 0-输出 1-输入
	
	WPUA = 0B00000000;     	//PA端口上拉控制 1-开上拉 0-关上拉
	WPUB = 0B00000000;     	//PB端口上拉控制 1-开上拉 0-关上拉
	WPUC = 0B00000000;     	//PC端口上拉控制 1-开上拉 0-关上拉
	WPUD = 0B00000000;     	//PD端口上拉控制 1-开上拉 0-关上拉
    
    WPDA = 0B00000000;     	//PA端口上拉控制 1-开下拉 0-关下拉
	WPDB = 0B00000000;     	//PB端口上拉控制 1-开下拉 0-关下拉
	WPDC = 0B00000000;     	//PC端口上拉控制 1-开下拉 0-关下拉
	WPDD = 0B00000000;     	//PD端口上拉控制 1-开下拉 0-关下拉
    
    PSRC0  = 0B11111111;  	//PORTA,PORTB源电流设置最大
    //BIT7~BIT6:PORTB[7:4]源电流能力控制,BIT5~BIT4:PORTB[3:0]源电流能力控制 
    //BIT3~BIT2:PORTA[7:4]源电流能力控制,BIT1~BIT0:PORTA[3:0]源电流能力控制
    
    PSRC1  = 0B11111111;    //PORTC,PORTD源电流设置最大    
    //BIT7~BIT6:PORTD[7:4]源电流能力控制,BIT5~BIT4:PORTD[3:0]源电流能力控制 
    //BIT3~BIT2:PORTC[7:4]源电流能力控制,BIT1~BIT0:PORTC[3:0]源电流能力控制
    
    PSINK0 = 0B11111111;  	//PORTA灌电流设置最大 0:最小，1:最大
    PSINK1 = 0B11111111; 	//PORTB灌电流设置最大 0:最小，1:最大
    PSINK2 = 0B11111111;	//PORTC灌电流设置最大 0:最小，1:最大
    PSINK3 = 0B11111111;	//PORTD灌电流设置最大 0:最小，1:最大 

	bAD_KEY = 1; // 将引脚设置为输入模式
}
/*------------------------------------------------- 
 *	函数名称：DelayUs
 *	功能：   短延时函数 --16M-2T--大概快1%左右.
 *	输入参数：Time 延时时间长度 延时时长Time Us
 *	返回参数：无 
 -------------------------------------------------*/
void DelayUs(unsigned char Time)
{
	unsigned char a;
	for(a=0;a<Time;a++)
	{
		NOP();
	}
}  
/*-------------------------------------------------
 *  函数名: ADC_INITIAL
 *	功能：  ADC初始化
 *  输入：  无
 *  输出：  无
 --------------------------------------------------*/
void ADC_INITIAL(void) 
{
    
    ANSELA = 0B00010000;    //模拟口设置，AN4为模拟管脚

	ADCON1 = 0B11100100; 	//右对齐，转换时钟Fosc/64，负参考电压GND，正参考电压内部电压(2V)
  	//BIT7: 
		//1 = 右对齐。装入转换结果时，ADRESH的高4位被设置为0; 
		//0 = 左对齐。装入转换结果时，ADRESL的低4位被设置为0。
  
  	//BIT6~BIT4:ADC转换时钟选择位
		//000 = FOSC/2
		//001 = FOSC/8
		//010 = FOSC/32
		//011 = FRC（由专用RC振荡器提供时钟）
		//100 = FOSC/4
		//101 = FOSC/16
		//110 = FOSC/64
		//111 = FRC（由专用RC振荡器提供时钟）
	
	//BIT3~BIT2:ADC负参考电压配置位（使用PB6连接外部参考电压或外部电容）
		//00 = Int Vref（内部参考电压）
		//01 = GND
		//10 = Int Vref + Ext Cap（内部参考电压 + 外部电容）
		//11 = Ext Vref（外部参考电压）

  	//BIT1~BIT0	ADC正参考电压配置位（使用PB5连接外部参考电压或外部电容）
		//00 = Int Vref（内部参考电压）
		//01 = VDD
		//10 = Int Vref + Ext Cap（内部参考电压 + 外部电容）
		//11 = Ext Vref（外部参考电压）
                             
	ADCON0 = 0B00000000; 	//选择AD转换通道0，使能ADC
  	//BIT7~BIT4:ADC模拟通道选择位
		//0000 = AN0
		//0001 = AN1
		//0010 = AN2
		//0011 = AN3
		//0100 = AN4
		//0101 = AN5
		//0110 = AN6
		//0111 = AN7
		//1000 = 1/4 VDD
		//其余保留

    //BIT3:该位由软件设置来启动ADC校准。当校准完成后，由硬件清零。
		//0 = 校准完成。
		//1 = 写1时校准ADC，读为1时意味着校准仍在进行中。

    //BIT2:	ADC触发信号类型选择
		//该位决定启动ADC的触发条件
		//0 = 当软件设定GO/DONE位，启动AD转换
		//1 = 需要外部触发信号触发才可启动AD转换，触发事件置位GO/DONE位。
		//外部触发信号条件由寄存器ETGSEL<2:0>和ETGTYP<1:0>决定。
  
    //BIT1:
    	//0 = A/D转换完成/未进行。
		//1 = A/D转换正在进行或硬件触发延时正在计数。

    //BIT0:使能ADC  
    	//0 = ADC被禁止且不消耗工作电流
		//1 = ADC被使能
              
					   						   			 			
    ADCON2 = 0B01000000; 	//选择内部正参考电压2V，无外部触发源
    //BIT7~BIT6:ADC内部参考电压配置位
		//00 = 0.5V
		//01 = 2V
		//10 = 3V
		//11 = float（悬空）
		
	//BIT5~BIT4:外部触发信号类型选择
		//当ADEX置1，该位决定响应外部触发的类型
		//00 = PWM 或 ADC_ETR脚的下降沿
		//01 = PWM 或 ADC_ETR脚的上升沿
		//10 = 一个PWM周期的中点
		//11 = 一个PWM周期的终点
		
	//BIT3:ADC外部触发延时计数器阈值 第8位
		
	//BIT2~BIT0:外部触发源选择
		//当ADEX为1，该位选择外部触发ADC的来源
		//选择PWM源时需要配置TIMER为PWM输出模式并使能输出。
		//000 = PWM0
		//001 = PWM1
		//010 = PWM2
		//011 = PWM3
		//100 = PWM4
		//101 = PWM5
		//110 = PWM6
		//111 = ADC_ETR

    ADCON3 = 0B00000000; 
    //BIT7:ADC比较结果响应故障刹车使能
		//0 = 禁止
		//1 = ADC触发故障刹车功能使能
		
	//BIT6:ADC比较器输出极性选择位
		//0 = 若ADC结果的高八位大于或等于ADCMPH[7:0]，ADCMPO为1
		//1 = 若ADC结果的高八位小于ADCMPH[7:0]，ADCMPO为1

	//BIT5:ADC结果比较使能位
		//0 = ADC结果比较功能关闭
		//1 = ADC结果比较功能打开
		
	//BIT4:ADC比较结果输出位
		//该位输出ADCMPOP设定的比较输出结果。每次AD转换结束都会更新输出
		
	//BIT3:前沿消隐周期结束后，ADC触发使能
		//1 = 触发ADC转换
		//0 = 不触发ADC转换
		
	//BIT2:保留位
	//BIT1~BIT0 外部LVD管脚输入选择，只有当LVDM为1时才有效
		//00 = ELVD0
		//01 = ELVD1
		//10 = ELVD2
		//11 = ELVD3

    ADDLY  = 0B00000000;    //外部触发廷时，没用到
    //ADC外部触发启动延时计数器阈值低位
	//该8位寄存器与ADCON2.7组成9位计数器，用于在外部触发启动ADC之前加入一段延迟。延迟计数器结束再开始ADC转换
	//外部延迟时间 = (ADDLY+6)/FADC

    ADCMPH = 0B00000000;	//ADC比较阈值,仅8位，用于ADC结果高8位比较。


	ADCAL=1;                //校准ADC, 注意点：校准要放在配置之后
    NOP();
    while(ADCAL);       
    
    ADON=1; //全能ADC
}                      
/*-------------------------------------------------
 *  函数名: GET_ADC_DATA
 *	功能：  读取通道ADC值
 *  输入：  adcChannel 通道序号
 *  输出：  INT类型AD值(单次采样无滤波)
 --------------------------------------------------*/
unint GET_ADC_DATA (unchar adcChannel) 
{ 
	ADCON0 &= 0B00001111;        				   
    ADCON0 |= adcChannel<<4; 				//重新加载通道值
	DelayUs(40);                        	//廷时等待电压稳定 Tst >10us
	GO = 1;             					//启动ADC 
    NOP();
    NOP();
	while(GO);    							//等待ADC转换完成

    return  (unint)(ADRESH<<8|ADRESL);      //整合12位AD值
} 
/*-------------------------------------------------
 *  函数名: main
 *	功能：  主函数
 *  输入：  无
 *  输出：  无
 --------------------------------------------------*/
void main(void) 
{
	POWER_INITIAL();	            				//初始化
	ADC_INITIAL();		            				//ADC初始化	
	 
	while(1)
	{
		adcData = GET_ADC_DATA(4); 					//通道4 AD值
		theVoltage = (unlong)adcData*2*1000/4096;	//电压放大1000倍			
		NOP();
		NOP();
	}
}

