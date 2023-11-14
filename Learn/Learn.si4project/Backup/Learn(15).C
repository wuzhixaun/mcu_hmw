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

#define  LED8	RD2  
#define  LED7	RD1  
#define  LED6	RD0  
#define  LED5	RC7 

//===========================================================
//Variable definition
volatile char W_TMP  @ 0x70 ;//系统占用不可以删除和修改
volatile char BSR_TMP  @ 0x71 ;//系统占用不可以删除和修改
void user_isr();//用户中断程序，不可删除
//===========================================================

//===========================================================
//Function name：interrupt ISR
//parameters：无
//returned value：无
//===========================================================
void interrupt ISR(void)
{
#asm;//系统设置不可以删除和修改
	NOP;//系统设置不可以删除和修改
	NOP;//系统设置不可以删除和修改
	NOP;//系统设置不可以删除和修改
	NOP;//系统设置不可以删除和修改
	NOP;//系统设置不可以删除和修改
	NOP;//系统设置不可以删除和修改
	NOP;//系统设置不可以删除和修改
	NOP;//系统设置不可以删除和修改
	NOP;//系统设置不可以删除和修改
	NOP;//系统设置不可以删除和修改
	NOP;//系统设置不可以删除和修改
	NOP;//系统设置不可以删除和修改
	NOP;//系统设置不可以删除和修改
	NOP;//系统设置不可以删除和修改
	NOP;//系统设置不可以删除和修改
	NOP;//系统设置不可以删除和修改
	NOP;//系统设置不可以删除和修改
	NOP;//系统设置不可以删除和修改
	NOP;//系统设置不可以删除和修改
	NOP;//系统设置不可以删除和修改
	NOP;//系统设置不可以删除和修改
#endasm;//系统设置不可以删除和修改
	user_isr(); //用户中断函数
}
void user_isr() //用户中断函数
{
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
    
	PORTA = 0B00000000;	     // 
	TRISA = 0B11111111;		//PA输入输出 0-输出 1-输入. PA0改成输入
	PORTB = 0B00000000;		
	TRISB = 0B11111111;		//PB输入输出 0-输出 1-输入							
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
	MISC0 = 0x00; // 默认时钟频率
	//
	WDTCON = 0b00010110; //看门狗预分频设置位1:1 看门狗定时器周期选择65535 
}

/*-------------------------------------------------
 *  函数名: main 
 *	功能：  主函数
 *  输入：  无
 *  输出：  无
 --------------------------------------------------*/
void main(void)
{
	unsigned char i;
	POWER_INITIAL();		//系统初始化
	initWDT();
	for (i = 0;i<8;i++)
	{
		LATC7 = 1; // LED5 
		DelayMs(100);
		LATC7 = 0; // LED5 
		DelayMs(100);
	}

	while(1)
	{
		LATD0 = 1; // LED5 
		DelayMs(100);
		LATD0 = 0; // LED5 
		DelayMs(100);
	}
}

