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
//===========================================================
//Variable definition
volatile char W_TMP  @ 0x70 ;//ϵͳռ�ò�����ɾ�����޸�
volatile char BSR_TMP  @ 0x71 ;//ϵͳռ�ò�����ɾ�����޸�
void user_isr();//�û��жϳ��򣬲���ɾ��
//===========================================================

//===========================================================
//Function name��interrupt ISR
//parameters����
//returned value����
//===========================================================
void interrupt ISR(void)
{
#asm;//ϵͳ���ò�����ɾ�����޸�
	NOP;//ϵͳ���ò�����ɾ�����޸�
	NOP;//ϵͳ���ò�����ɾ�����޸�
	NOP;//ϵͳ���ò�����ɾ�����޸�
	NOP;//ϵͳ���ò�����ɾ�����޸�
	NOP;//ϵͳ���ò�����ɾ�����޸�
	NOP;//ϵͳ���ò�����ɾ�����޸�
	NOP;//ϵͳ���ò�����ɾ�����޸�
	NOP;//ϵͳ���ò�����ɾ�����޸�
	NOP;//ϵͳ���ò�����ɾ�����޸�
	NOP;//ϵͳ���ò�����ɾ�����޸�
	NOP;//ϵͳ���ò�����ɾ�����޸�
	NOP;//ϵͳ���ò�����ɾ�����޸�
	NOP;//ϵͳ���ò�����ɾ�����޸�
	NOP;//ϵͳ���ò�����ɾ�����޸�
	NOP;//ϵͳ���ò�����ɾ�����޸�
	NOP;//ϵͳ���ò�����ɾ�����޸�
	NOP;//ϵͳ���ò�����ɾ�����޸�
	NOP;//ϵͳ���ò�����ɾ�����޸�
	NOP;//ϵͳ���ò�����ɾ�����޸�
	NOP;//ϵͳ���ò�����ɾ�����޸�
	NOP;//ϵͳ���ò�����ɾ�����޸�
#endasm;//ϵͳ���ò�����ɾ�����޸�
	user_isr(); //�û��жϺ���
}
void user_isr() //�û��жϺ���
{
}
//===========================================================
//Function name��main
//parameters����
//returned value����
//===========================================================
main()
{
}
//===========================================================