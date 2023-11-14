#ifndef __USER_HEAD_H
#define __USER_HEAD_H


extern void System_Init(void);
extern void Delay_Ms(unsigned char Time);
extern void Delay_Us(unsigned char Time);

extern unchar EEPROMread(unchar EEAddr);
extern void EEPROMwrite(unchar EEAddr,unchar Data);

extern void Set_Vref0V5(void);
extern void Set_Vref2V(void);
extern void Set_Vref3V(void);
extern void Set_Vref5V(void);
extern unint Get_ADC_Data (u8 ADC_Channel);

extern void LCD_Flash(void);

#endif
