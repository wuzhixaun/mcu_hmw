#ifndef _USER_MAIN_FILE
#define _USER_MAIN_FILE

#include "User_Include.h"
volatile unint  adcData;
volatile unint  theVoltage;
void LCD_Flash(void)
{
    Flash_BZ = !Flash_BZ;
		switch(Flash_Code)
		{
			case 0:
			COM2_STATE = IO_IN;
			COM3_STATE = IO_IN;
			COM4_STATE = IO_IN;
			
			COM1_STATE = IO_OUT;
			if(Flash_BZ==0)
			{
				COM1 = 1;
				
				SEG1 = 0;
				SEG2 = 0;
				SEG3 = 0;
				SEG4 = 0;
				SEG5 = 0;
				SEG6 = 0;
				SEG7 = 0;
				SEG8 = 0;
				SEG9 = 0;
				SEG10 = 0;
				SEG11 = 0;
				SEG12 = 0;

			}
			else
			{
				COM1 = 0;
				
				SEG1 = 1;
				SEG2 = 1;
				SEG3 = 1;
				SEG4 = 1;
				SEG5 = 1;
				SEG6 = 1;
				SEG7 = 1;
				SEG8 = 1;
				SEG9 = 1;
				SEG10 = 1;
				SEG11 = 1;
				SEG12 = 1;
				Flash_Code++;
			}
			break;
			case 1:
			COM1_STATE = IO_IN;
			COM3_STATE = IO_IN;
			COM4_STATE = IO_IN;
			
			COM2_STATE = IO_OUT;
			if(Flash_BZ==0)
			{
				COM2 = 1;
				
				SEG1 = 0;
				SEG2 = 0;
				SEG3 = 0;
				SEG4 = 0;
				SEG5 = 0;
				SEG6 = 0;
				SEG7 = 0;
				SEG8 = 0;
				SEG9 = 0;
				SEG10 = 0;
				SEG11 = 0;
				SEG12 = 0;
			}
			else
			{
				COM2 = 0;
				
				SEG1 = 1;
				SEG2 = 1;
				SEG3 = 1;
				SEG4 = 1;
				SEG5 = 1;
				SEG6 = 1;
				SEG7 = 1;
				SEG8 = 1;
				SEG9 = 1;
				SEG10 = 1;
				SEG11 = 1;
				SEG12 = 1;
				Flash_Code++;
			}
			break;
			case 2:
            COM1_STATE = IO_IN;
			COM2_STATE = IO_IN;
			COM4_STATE = IO_IN;
			
			COM3_STATE = IO_OUT;
			if(Flash_BZ==0)
			{	
				COM3 = 1;
				
				SEG1 = 0;
				SEG2 = 0;
				SEG3 = 0;
				SEG4 = 0;
				SEG5 = 0;
				SEG6 = 0;
				SEG7 = 0;
				SEG8 = 0;
				SEG9 = 0;
				SEG10 = 0;
				SEG11 = 0;
				SEG12 = 0;
            
            }
			else
			{
				
				COM3 = 0;
				
				SEG1 = 1;
				SEG2 = 1;
				SEG3 = 1;
				SEG4 = 1;
				SEG5 = 1;
				SEG6 = 1;
				SEG7 = 1;
				SEG8 = 1;
				SEG9 = 1;
				SEG10 = 1;
				SEG11 = 1;
				SEG12 = 1;
				Flash_Code++;
			}
			break;
			case 3:
            COM1_STATE = IO_IN;
			COM2_STATE = IO_IN;
			COM3_STATE = IO_IN;
			
			COM4_STATE = IO_OUT;
			if(Flash_BZ==0)
			{
				COM4 = 1;
				
				SEG1 = 0;
				SEG2 = 0;
				SEG3 = 0;
				SEG4 = 0;
				SEG5 = 0;
				SEG6 = 0;
				SEG7 = 0;
				SEG8 = 0;
				SEG9 = 0;
				SEG10 = 0;
				SEG11 = 0;
				SEG12 = 0;
			}
			else
			{
				COM4 = 0;
				
				SEG1 = 1;
				SEG2 = 1;
				SEG3 = 1;
				SEG4 = 1;
				SEG5 = 1;
				SEG6 = 1;
				SEG7 = 1;
				SEG8 = 1;
				SEG9 = 1;
				SEG10 = 1;
				SEG11 = 1;
				SEG12 = 1;
				Flash_Code=0;
			}
			
			break;
		}
}
void main(void)
{
	System_Init();		//系统初始化
	while(1)
	{   
		CLRWDT();  //清看门狗
        
        adcData =  Get_ADC_Data(4);
        theVoltage = (unlong)adcData*2*1000/4096;	//电压放大1000倍	
        NOP();
		NOP();
   	}
}
#endif
