//Project: Learn.prj
// Device: FT62F08X
// Memory: Flash 8KX14b, EEPROM 256X8b, SRAM 1KX8b
// Author: 
//Company: 
//Version:
//   Date: 
//===========================================================
//===========================================================
#include	"SYSCFG.h"

#define  unchar     unsigned char 
#define  unint      unsigned int
#define  unlong     unsigned long

#define  LED8	RD2  
#define  LED7	RD1  
#define  LED6	RD0  
#define  LED5	RC7 

#define Max7219_pinCLK RB3 // 时钟信号线
#define	Max7219_pinCS RC5 // 数据加载线
#define	Max7219_pinDIN RC6 // 数据输入线 

#define Max7219_pinCLK_TRIS TRISB3 //MAX7219时钟信号线
#define Max7219_pinCS_TRIS TRISC5 //数据加载线
#define Max7219_pinDIN_TRIS TRISC6 //数据输入线
unsigned long int cout=0;

unsigned char IRbitNum = 0;		//用于记录接收到第几位数据了
unsigned int IRbitTime = 0;		//用于计时一位的时间长短
unsigned int IRbitTime1 = 0;		//用于计时一位的时间长短
unsigned int IRbitTime2 = 0;		//用于计时一位的时间长短
unsigned int IRbitTime3 = 0;		//用于计时一位的时间长短



unsigned int ms10Cnt = 0;		//用于计时一位的时间长短


//===========================================================
//Variable definition
volatile char W_TMP  @ 0x70 ;//系统占用不可以删除和修改
volatile char BSR_TMP  @ 0x71 ;//系统占用不可以删除和修改
void user_isr();//用户中断程序，不可删除
//===========================================================


/*-------------------------------------------------
 *  函数名： interrupt ISR
 *	功能：  中断处理，包括定时器0中断和外部中断
 *  输入：  无
 *  输出：  无
 --------------------------------------------------*/
void interrupt ISR(void)   
{ 
  //定时器4的中断处理**********************
	if(T4UIE && T4UIF)                	
	{
		T4UIF = 1;                    	//写1清零标志位  
         
		IRbitTime ++;
		IRbitTime1 ++;
		IRbitTime2 ++;
		IRbitTime3 ++;
	} 
    
   
} 


void Led5work(void){
	if(IRbitTime> 1000)
   {
    	//T4UIE = 0;
        IRbitTime = 0;
		LED5 ^=1;
   }

}


void Led6work(void){
	if(IRbitTime1> 3000)
   {
    	//T4UIE = 0;
        IRbitTime1 = 0;
		LED6 ^=1;
   }

}

void Led7work(void){
	if(IRbitTime2> 5000)
   {
    	//T4UIE = 0;
        IRbitTime2 = 0;
		LED7 ^=1;
   }

}

void Led8work(void){
	if(IRbitTime3> 6000)
   {
    	//T4UIE = 0;
        IRbitTime3 = 0;
		LED8 ^=1;
   }

}








/*------------------------------------------------- 
 *	函数名称：DelayUs
 *	功能：   短延时函数 --16M-2T--大概快1%左右.
 *	输入参数：Time延时时间长度 延时时长Time Us
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
 *	函数名称：DelayMs
 *	功能：   短延时函数
 *	输入参数：Time延时时间长度 延时时长Time ms
 *	返回参数：无 
 -------------------------------------------------*/
void DelayMs(unsigned char Time)
{
	unsigned char a,b;
	for(a=0;a<Time;a++)
	{
		for(b=0;b<5;b++)
		{
		 	DelayUs(197); //快1%
		}
	}
}
/*-------------------------------------------------
 *	函数名称：DelayS
 *	功能：   短延时函数
 *	输入参数：Time延时时间长度 延时时长Time S
 *	返回参数：无 
 -------------------------------------------------*/
void DelayS(unsigned char Time)
{
	unsigned char a,b;
	for(a=0;a<Time;a++)
	{
		for(b=0;b<10;b++)
		{
		 	DelayMs(100); 
		}
	}
}

/**
 * LCD灯闪烁
 */
void LCD(){
	LATC7 = 1; // LED5 
	LATD0 = 0; // LED6
	LATD1 = 1; // LED7
	LATD2 = 0; // LED8
	DelayMs(250);
	DelayMs(250);
	LATC7 = 0; // LED5 
	LATD0 = 1; // LED6
	LATD1 = 0; // LED7
	LATD2 = 1; // LED8
	DelayMs(250);
	DelayMs(250);

}


/*-------------------------------------------------
 *  函数名：POWER_INITIAL
 *	功能：  上电系统初始化
 *  输入：  无
 *  输出：  无
 --------------------------------------------------*/	
void POWER_INITIAL (void) 
{
	 
	OSCCON = 0B01110001;	//WDT 32KHZ IRCF=111=16MHZ
					 		//Bit0=1,系统时钟为内部振荡器
					 		//Bit0=0,时钟源由FOSC<2：0>决定即编译选项时选择
	INTCON = 0;  			//暂禁止所有中断
    PCKEN |=0B00000001;      //AD模块时钟使能  		
	PORTA = 0B00000000;		
	TRISA = 0B11111111;		//PA输入输出 0-输出 1-输入
	PORTB = 0B00000000;		
	TRISB = 0B11110111;		//PB输入输出 0-输出 1-输入							
	PORTC = 0B00000000; 	
	TRISC = 0B01111111;		//PC输入输出 0-输出 1-输入  	
    PORTD = 0B00000000;		
	TRISD = 0B11111000;		//PD输入输出 0-输出 1-输入
	
	WPUA = 0B00000000;     	//PA端口上拉控制 1-开上拉 0-关上拉
	WPUB = 0B00000000;     	//PB端口上拉控制 1-开上拉 0-关上拉
	WPUC = 0B00001000;     	//PC端口上拉控制 1-开上拉 0-关上拉
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
	Max7219_pinCLK_TRIS = 0;
	Max7219_pinCS_TRIS = 0;
	Max7219_pinDIN_TRIS = 0;
    ANSELA = 0B00000000;    //全为数字管脚
 
}



// 按键
void button(void){
	// 读取按键的PA0的店铺，按下低电平
	if(RA0 == 0){
		RC7 = 1; // LED5 
	}else{
		RC7 = 0; // LED5 
	}

	if(RB0 == 0){
		RD0 = 1; // LED5 
	}else{
		RD0 = 0; // LED5 
	}

	if(RB1 == 0){
		RD1 = 1; // LED5 
	}else{
		RD1 = 0; // LED5 
	}

	if(RD3 == 0){
		RD2 = 1; // LED5 
	}else{
		RD2 = 0; // LED5 
	}
	
	
}

// 看门狗
void initWDT(){

	// 清狗
	CLRWDT();
	// 
	MISC0 = 0x00; // 默认时钟频率,32K
	//
	WDTCON = 0b00010111; //看门狗预分频设置位1:1 看门狗定时器周期选择65535 
						// 时间 t = 1/32k*65535*1 = 2.048s
}


//--------------------------------------------
//功能：向MAX7219(U3)写入字节
//入口参数：DATA 
//出口参数：无
//说明：
void Write_Max7219_byte(unsigned char DATA)  {
	unsigned char i ;
	Max7219_pinCS = 0;
	for(i=8;i>=1;i--){
		Max7219_pinCLK=0;
		if(DATA & 0x80){
			Max7219_pinDIN=1;
		}else{
			Max7219_pinDIN=0;
		}

		DATA = DATA<<1;
		Max7219_pinCLK=1;
	}
	
}

// 对
//-------------------------------------------
//功能：向MAX7219写入数据
//入口参数：address地址、dat参数
//出口参数：无
//说明：
void Write_Max7219(unsigned char address,unsigned char dat){
	Max7219_pinCS = 0;
	Write_Max7219_byte(address);           //写入地址，即数码管编号
    Write_Max7219_byte(dat);               //写入数据，即数码管显示数字
    Max7219_pinCS=1;
}


//-------------------------------------------
//功能：初始化max7219
//入口参数：无
//出口参数：无
//说明:

void Init_MAX7219(void)
{
 Write_Max7219(0x09, 0xff);       //译码方式：BCD码
 Write_Max7219(0x0a, 0x03);       //亮度
 Write_Max7219(0x0b, 0x07);       //扫描界限；4个数码管显示
 Write_Max7219(0x0c, 0x01);       //掉电模式：0，普通模式：1
 Write_Max7219(0x0f, 0x01);       //显示测试：1；测试结束，正常显示：0
}


/*-------------------------------------------------
 *  函数名: ADC_INITIAL
 *	功能：  ADC初始化
 *  输入：  无
 *  输出：  无
 --------------------------------------------------*/

void initADC(void){
	// 配置引脚为输入
	TRISC0 = 1;
	TRISC1 = 1;

	ANSELA = 0B11100101;    //模拟口设置，AN2、AN1为模拟管脚

	ADCON1 = 0B11100100; 	//右对齐，转换时钟Fosc/64，负参考电压GND，正参考电压内部电压(2V)
	ADCON0 = 0B00000000; 	//选择AD转换通道0，使能ADC
	ADCON2 = 0B01000000; 	//选择内部正参考电压2V，无外部触发源
	ADCON3 = 0B00000000; 
	ADDLY  = 0B00000000;    //外部触发廷时，没用到
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
 *	函数名称：Time4Initial
 *	功能：  
 *	输入参数：
 *	返回参数：无 
 -------------------------------------------------*/
void Time4Initial(void)
{
	PCKEN |=0B00001000;      //TIME4模块时钟使能
    //CKOCON=0B00110000;
    //TCKSRC=0B00000011;		
    
    TIM4CR1	=0B00000101;
    //BIT7: 0：TIM1_ARR寄存器没有缓冲，它可以被直接写入; 1：TIM1_ARR寄存器由预装载缓冲器缓冲。
    //BIT6:保留
    //BIT5~BIT4:timer4时钟选择位。
        		//00：系统时钟/主时钟
				//01：内部快时钟HIRC
				//10：LP时钟，只有当FOSC选择LP模式时才有意义
				//11：XT时钟，只有当FOSC选择XT模式时才有意义

    //BIT3:
    //			0：在发生更新事件时，计数器不停止；
	//			1：在发生下一次更新事件(清除CEN位)时，计数器停止。

    //BIT2:
   	// 		0：如果UDIS允许产生更新事件，则下述任一事件产生一个更新中断：
				//寄存器被更新(计数器上溢/下溢)
				//软件设置UG位
				//时钟/触发控制器产生的更新
	//		1：如果UDIS允许产生更新事件，则只有当下列事件发生时才产生更新中断，并UIF置1：
				//寄存器被更新(计数器上溢/下溢)

    //BIT1:
    //		0：一旦下列事件发生，产生更新(UEV)事件：
				//计数器溢出/下溢
				//产生软件更新事件
				//时钟/触发模式控制器产生的硬件复位被缓存的寄存器被装入它们的预装载值。
	//		1：不产生更新事件，影子寄存器(ARR、PSC、CCRx)保持它们的值。如果设置了UG位或时钟/触发控制器发出了一个硬件复位，则计数器和预分频器被重新初始化。

    // BIT0: 0：禁止计数器；1：使能计数器。


    TIM4IER	=0B00000001;
    //BIT0:  0：禁止更新中断；1：允许更新中断。

    TIM4SR	=0B00000000;
    //BIT0:当产生更新事件时该位由硬件置1。它由软件写1清0
			//0：无更新事件产生；
			//1：更新事件等待响应。当寄存器被更新时该位由硬件置1：
			//若TIM4_CR1寄存器的UDIS=0，当计数器上溢或下溢时；
			//若TIM4_CR1寄存器的UDIS=0、URS=0，当设置TIM4_EGR寄存器的UG位软件对计数器
			//CNT重新初始化时；
			//若TIM4_CR1寄存器的UDIS=0、URS=0，当计数器CNT被触发事件重新初始化时。

    TIM4EGR	=0B00000000;
    //BIT0:该位由软件置1，由硬件自动清0。
	//0：无动作；
	//1：重新初始化计数器，并产生一个更新事件。注意预分频器的计数器也被清0(但是预分频系数不变)。若在中心对称模式下或DIR=0(向上计数)则计数器被清0；若DIR=1(向下计数)则计数器取TIM1_ARR的值。

    TIM4CNTR=0; //TIM4 8位计数器
    
    TIM4PSCR=0B00000100;
    //预分频器对输入的CK_PSC时钟进行分频。
	//计数器的时钟频率fCK_CNT等于fCK_PSC/2(PSC[2:0])。PSC[7:3]由硬件清0。
	//PSCR包含了当更新事件产生时装入当前预分频器寄存器的值(包括由于清除TIMx_EGR寄存器的UG位产生的计数器清除事件)。这意味着如要新的预分频值生效，必须产生更新事件或者CEN=0。

    TIM4ARR	=124; // 频率= 16M/64*(256-124) 然后取倒数，差不多就是定时器时间 = 1/频率 
    //ARR包含了将要装载入实际的自动重装载寄存器的值。
	//当自动重装载的值为空时，计数器不工作。

    INTCON |= 0B11000000;    //开总中断和外设中断
  }



/*-------------------------------------------------
 *  函数名: main 
 *	功能：  主函数
 *  输入：  无
 *  输出：  无
 --------------------------------------------------*/
void main(void)
{

	POWER_INITIAL();		//系统初始化
	Time4Initial();

	while(1)
	{
		Led5work();
		Led6work();
		Led7work();
		Led8work();
	}
		

}

