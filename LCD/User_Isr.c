#ifndef _USER_ISR_FILE
#define _USER_ISR_FILE

#include "User_Include.h"
volatile u8 Time_1ms=0;
volatile u16 Time_1s=0;

volatile u8 Sm_Code=0;

void interrupt ISR(void)//�жϴ���    
{ 

    //����һ��Get_ADC_Data (BAT2_Channel);��ʱ24.4us
    //Send_Data();//ִ��ʱ��6.2uS
    //Led_Display(); //ִ��ʱ��13.5uS
    
   if(T2UIE&T2UIF)//2.5ms
    {
		T2UIF= 1;
        
        LCD_Flash();
    }
} 

#endif

 