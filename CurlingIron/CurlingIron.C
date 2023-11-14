
#include	"SYSCFG.h"

//�궨��****************************************************
#define  unchar     unsigned char 
#define  unint      unsigned int
#define  unlong     unsigned long
#define bAD_KEY TRISA6

volatile long int  adcData;
volatile long int  theVoltage;
/*-------------------------------------------------
 *  �������� interrupt ISR
 *	���ܣ�  �жϴ�����������ʱ��0�жϺ��ⲿ�ж�
 *  ���룺  ��
 *  �����  ��
 --------------------------------------------------*/
void interrupt ISR(void)            	//PIC_HI-TECHʹ��
{ 

}
/*-------------------------------------------------
 *  ��������POWER_INITIAL
 *	���ܣ�  �ϵ�ϵͳ��ʼ��
 *  ���룺  ��
 *  �����  ��
 --------------------------------------------------*/	
void POWER_INITIAL (void) 
{
	 OSCCON = 0B01110001;	//16MHZ 1:1
	//BIT7~BIT4:��ʱ�ӣ�ϵͳʱ�ӣ���Ƶ��ѡ��0111(1:1),0110(1:2),0101(1:4),0100(1:8),0011(1:16),0010,(1:32),0001(1:64),1xxx(1:128),0000(32kHz LIRC)
	//BIT3:��������ʱ״̬λ��1������������FOSC<2:0>ָ�����ⲿʱ��֮�£�0�������������ڲ�����֮��
	//BIT2:�����ڲ�ʱ��״̬�� 1��HIRC is ready��0��HIRC is not ready
	//Bit1�������ڲ�ʱ��״̬��1��LIRC is ready��0��LIRC is not ready
	//Bit0:ϵͳʱ��ѡ��λ��1��ϵͳʱ��ѡ��Ϊ�ڲ�������0��ʱ��Դ��FOSC<2:0>����
    
    PCKEN |=0B00000001;      //ADģ��ʱ��ʹ��
    
	INTCON = 0;  			//�ݽ�ֹ�����ж�
    
	PORTA = 0B00000000;		
	TRISA = 0B11111111;		//PA������� 0-��� 1-����
	PORTB = 0B00000000;		
	TRISB = 0B11111111;		//PB������� 0-��� 1-����							
	PORTC = 0B00000000; 	
	TRISC = 0B11111111;		//PC������� 0-��� 1-����  	
    PORTD = 0B00000000;		
	TRISD = 0B11111111;		//PD������� 0-��� 1-����
	
	WPUA = 0B00000000;     	//PA�˿��������� 1-������ 0-������
	WPUB = 0B00000000;     	//PB�˿��������� 1-������ 0-������
	WPUC = 0B00000000;     	//PC�˿��������� 1-������ 0-������
	WPUD = 0B00000000;     	//PD�˿��������� 1-������ 0-������
    
    WPDA = 0B00000000;     	//PA�˿��������� 1-������ 0-������
	WPDB = 0B00000000;     	//PB�˿��������� 1-������ 0-������
	WPDC = 0B00000000;     	//PC�˿��������� 1-������ 0-������
	WPDD = 0B00000000;     	//PD�˿��������� 1-������ 0-������
    
    PSRC0  = 0B11111111;  	//PORTA,PORTBԴ�����������
    //BIT7~BIT6:PORTB[7:4]Դ������������,BIT5~BIT4:PORTB[3:0]Դ������������ 
    //BIT3~BIT2:PORTA[7:4]Դ������������,BIT1~BIT0:PORTA[3:0]Դ������������
    
    PSRC1  = 0B11111111;    //PORTC,PORTDԴ�����������    
    //BIT7~BIT6:PORTD[7:4]Դ������������,BIT5~BIT4:PORTD[3:0]Դ������������ 
    //BIT3~BIT2:PORTC[7:4]Դ������������,BIT1~BIT0:PORTC[3:0]Դ������������
    
    PSINK0 = 0B11111111;  	//PORTA������������ 0:��С��1:���
    PSINK1 = 0B11111111; 	//PORTB������������ 0:��С��1:���
    PSINK2 = 0B11111111;	//PORTC������������ 0:��С��1:���
    PSINK3 = 0B11111111;	//PORTD������������ 0:��С��1:��� 

	bAD_KEY = 1; // ����������Ϊ����ģʽ
}
/*------------------------------------------------- 
 *	�������ƣ�DelayUs
 *	���ܣ�   ����ʱ���� --16M-2T--��ſ�1%����.
 *	���������Time ��ʱʱ�䳤�� ��ʱʱ��Time Us
 *	���ز������� 
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
 *  ������: ADC_INITIAL
 *	���ܣ�  ADC��ʼ��
 *  ���룺  ��
 *  �����  ��
 --------------------------------------------------*/
void ADC_INITIAL(void) 
{
    
    ANSELA = 0B00010000;    //ģ������ã�AN4Ϊģ��ܽ�

	ADCON1 = 0B11100101; 	//�Ҷ��룬ת��ʱ��Fosc/64�����ο���ѹGND�����ο���ѹ�ڲ���ѹ(2V)
  	//BIT7: 
		//1 = �Ҷ��롣װ��ת�����ʱ��ADRESH�ĸ�4λ������Ϊ0; 
		//0 = ����롣װ��ת�����ʱ��ADRESL�ĵ�4λ������Ϊ0��
  
  	//BIT6~BIT4:ADCת��ʱ��ѡ��λ
		//000 = FOSC/2
		//001 = FOSC/8
		//010 = FOSC/32
		//011 = FRC����ר��RC�����ṩʱ�ӣ�
		//100 = FOSC/4
		//101 = FOSC/16
		//110 = FOSC/64
		//111 = FRC����ר��RC�����ṩʱ�ӣ�
	
	//BIT3~BIT2:ADC���ο���ѹ����λ��ʹ��PB6�����ⲿ�ο���ѹ���ⲿ���ݣ�
		//00 = Int Vref���ڲ��ο���ѹ��
		//01 = GND
		//10 = Int Vref + Ext Cap���ڲ��ο���ѹ + �ⲿ���ݣ�
		//11 = Ext Vref���ⲿ�ο���ѹ��

  	//BIT1~BIT0	ADC���ο���ѹ����λ��ʹ��PB5�����ⲿ�ο���ѹ���ⲿ���ݣ�
		//00 = Int Vref���ڲ��ο���ѹ��
		//01 = VDD
		//10 = Int Vref + Ext Cap���ڲ��ο���ѹ + �ⲿ���ݣ�
		//11 = Ext Vref���ⲿ�ο���ѹ��
                             
	ADCON0 = 0B01000000; 	//ѡ��ADת��ͨ��0��ʹ��ADC
  	//BIT7~BIT4:ADCģ��ͨ��ѡ��λ
		//0000 = AN0
		//0001 = AN1
		//0010 = AN2
		//0011 = AN3
		//0100 = AN4
		//0101 = AN5
		//0110 = AN6
		//0111 = AN7
		//1000 = 1/4 VDD
		//���ౣ��

    //BIT3:��λ����������������ADCУ׼����У׼��ɺ���Ӳ�����㡣
		//0 = У׼��ɡ�
		//1 = д1ʱУ׼ADC����Ϊ1ʱ��ζ��У׼���ڽ����С�

    //BIT2:	ADC�����ź�����ѡ��
		//��λ��������ADC�Ĵ�������
		//0 = �������趨GO/DONEλ������ADת��
		//1 = ��Ҫ�ⲿ�����źŴ����ſ�����ADת���������¼���λGO/DONEλ��
		//�ⲿ�����ź������ɼĴ���ETGSEL<2:0>��ETGTYP<1:0>������
  
    //BIT1:
    	//0 = A/Dת�����/δ���С�
		//1 = A/Dת�����ڽ��л�Ӳ��������ʱ���ڼ�����

    //BIT0:ʹ��ADC  
    	//0 = ADC����ֹ�Ҳ����Ĺ�������
		//1 = ADC��ʹ��
              
					   						   			 			
    ADCON2 = 0B01000000; 	//ѡ���ڲ����ο���ѹ2V�����ⲿ����Դ
    //BIT7~BIT6:ADC�ڲ��ο���ѹ����λ
		//00 = 0.5V
		//01 = 2V
		//10 = 3V
		//11 = float�����գ�
		
	//BIT5~BIT4:�ⲿ�����ź�����ѡ��
		//��ADEX��1����λ������Ӧ�ⲿ����������
		//00 = PWM �� ADC_ETR�ŵ��½���
		//01 = PWM �� ADC_ETR�ŵ�������
		//10 = һ��PWM���ڵ��е�
		//11 = һ��PWM���ڵ��յ�
		
	//BIT3:ADC�ⲿ������ʱ��������ֵ ��8λ
		
	//BIT2~BIT0:�ⲿ����Դѡ��
		//��ADEXΪ1����λѡ���ⲿ����ADC����Դ
		//ѡ��PWMԴʱ��Ҫ����TIMERΪPWM���ģʽ��ʹ�������
		//000 = PWM0
		//001 = PWM1
		//010 = PWM2
		//011 = PWM3
		//100 = PWM4
		//101 = PWM5
		//110 = PWM6
		//111 = ADC_ETR

    ADCON3 = 0B00000000; 
    //BIT7:ADC�ȽϽ����Ӧ����ɲ��ʹ��
		//0 = ��ֹ
		//1 = ADC��������ɲ������ʹ��
		
	//BIT6:ADC�Ƚ����������ѡ��λ
		//0 = ��ADC����ĸ߰�λ���ڻ����ADCMPH[7:0]��ADCMPOΪ1
		//1 = ��ADC����ĸ߰�λС��ADCMPH[7:0]��ADCMPOΪ1

	//BIT5:ADC����Ƚ�ʹ��λ
		//0 = ADC����ȽϹ��ܹر�
		//1 = ADC����ȽϹ��ܴ�
		
	//BIT4:ADC�ȽϽ�����λ
		//��λ���ADCMPOP�趨�ıȽ���������ÿ��ADת����������������
		
	//BIT3:ǰ���������ڽ�����ADC����ʹ��
		//1 = ����ADCת��
		//0 = ������ADCת��
		
	//BIT2:����λ
	//BIT1~BIT0 �ⲿLVD�ܽ�����ѡ��ֻ�е�LVDMΪ1ʱ����Ч
		//00 = ELVD0
		//01 = ELVD1
		//10 = ELVD2
		//11 = ELVD3

    ADDLY  = 0B00000000;    //�ⲿ����͢ʱ��û�õ�
    //ADC�ⲿ����������ʱ��������ֵ��λ
	//��8λ�Ĵ�����ADCON2.7���9λ���������������ⲿ��������ADC֮ǰ����һ���ӳ١��ӳټ����������ٿ�ʼADCת��
	//�ⲿ�ӳ�ʱ�� = (ADDLY+6)/FADC

    ADCMPH = 0B00000000;	//ADC�Ƚ���ֵ,��8λ������ADC�����8λ�Ƚϡ�


	ADCAL=1;                //У׼ADC, ע��㣺У׼Ҫ��������֮��
    NOP();
    while(ADCAL);       
    
    ADON=1; //ȫ��ADC
}                      
/*-------------------------------------------------
 *  ������: GET_ADC_DATA
 *	���ܣ�  ��ȡͨ��ADCֵ
 *  ���룺  adcChannel ͨ�����
 *  �����  INT����ADֵ(���β������˲�)
 --------------------------------------------------*/
unint GET_ADC_DATA (unchar adcChannel) 
{ 
	ADCON0 &= 0B00001111;        				   
    ADCON0 |= adcChannel<<4; 				//���¼���ͨ��ֵ
	DelayUs(40);                        	//͢ʱ�ȴ���ѹ�ȶ� Tst >10us
	GO = 1;             					//����ADC 
    NOP();
    NOP();
	while(GO);    							//�ȴ�ADCת�����

    return  (unint)(ADRESH<<8|ADRESL);      //����12λADֵ
} 
/*-------------------------------------------------
 *  ������: main
 *	���ܣ�  ������
 *  ���룺  ��
 *  �����  ��
 --------------------------------------------------*/
void main(void) 
{
	POWER_INITIAL();	            				//��ʼ��
	ADC_INITIAL();		            				//ADC��ʼ��	
	 
	while(1)
	{
		adcData = GET_ADC_DATA(4); 					//ͨ��4 ADֵ
		theVoltage = (unlong)adcData*2*1000/4096;	//��ѹ�Ŵ�1000��			
		NOP();
		NOP();
	}
}
