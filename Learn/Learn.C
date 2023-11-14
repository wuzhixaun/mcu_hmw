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

#define Max7219_pinCLK RB3 // ʱ���ź���
#define	Max7219_pinCS RC5 // ���ݼ�����
#define	Max7219_pinDIN RC6 // ���������� 

#define Max7219_pinCLK_TRIS TRISB3 //MAX7219ʱ���ź���
#define Max7219_pinCS_TRIS TRISC5 //���ݼ�����
#define Max7219_pinDIN_TRIS TRISC6 //����������
unsigned long int cout=0;

unsigned char IRbitNum = 0;		//���ڼ�¼���յ��ڼ�λ������
unsigned int IRbitTime = 0;		//���ڼ�ʱһλ��ʱ�䳤��
unsigned int IRbitTime1 = 0;		//���ڼ�ʱһλ��ʱ�䳤��
unsigned int IRbitTime2 = 0;		//���ڼ�ʱһλ��ʱ�䳤��
unsigned int IRbitTime3 = 0;		//���ڼ�ʱһλ��ʱ�䳤��



unsigned int ms10Cnt = 0;		//���ڼ�ʱһλ��ʱ�䳤��

#define DQ RA5     
#define DQ_DIR TRISA5                         //����18B20D�ڷ���Ĵ���
#define DQ_HIGH() DQ_DIR =1                   //�������ݿ�Ϊ����
#define DQ_LOW() DQ = 0; DQ_DIR = 0           //�������ݿ�Ϊ���



//===========================================================
//Variable definition
volatile char W_TMP  @ 0x70 ;//ϵͳռ�ò�����ɾ�����޸�
volatile char BSR_TMP  @ 0x71 ;//ϵͳռ�ò�����ɾ�����޸�

volatile  unchar receivedata[10] =0;
volatile  unchar senddata	=0;

volatile  unchar    toSend[11]={0x11,0x22,0x33,0x44,0x55,0x66,0x77,0x88,0x99,0xaa};
unchar    i=0;
volatile unchar    k;


/*-------------------------------------------------
 *  �������� interrupt ISR
 *	���ܣ�  �жϴ�����������ʱ��0�жϺ��ⲿ�ж�
 *  ���룺  ��
 *  �����  ��
 --------------------------------------------------*/
void interrupt ISR(void)   
{ 
  
	UART_Interrupt(); 
   
} 


// ����ͨ���ж�
void UART_Interrupt(void){
	
	//�жϴ���**********************
	if(URRXNE && RXNEF) 	  //�����ж�			
	{
		receivedata[k++] =URDATAL; 
		
		if(k >= 10)
		{
			k=0;
			NOP();
		} 
		NOP();
	} 
	//----------------------------
	if(TCEN && TCF) 		 //�����ж�
	{	
		TCF=1;		 //д1��0
		
		if(i<10)
		{
			URDATAL =toSend[i++];
		}
		else
		{
		  i=0;
		}
		NOP();
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
 *	�������ƣ�DelayUs
 *	���ܣ�   ����ʱ���� --16M-2T--��ſ�1%����.
 *	���������Time��ʱʱ�䳤�� ��ʱʱ��Time Us
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
 *	�������ƣ�DelayMs
 *	���ܣ�   ����ʱ����
 *	���������Time��ʱʱ�䳤�� ��ʱʱ��Time ms
 *	���ز������� 
 -------------------------------------------------*/
void DelayMs(unsigned char Time)
{
	unsigned char a,b;
	for(a=0;a<Time;a++)
	{
		for(b=0;b<5;b++)
		{
		 	DelayUs(197); //��1%
		}
	}
}
/*-------------------------------------------------
 *	�������ƣ�DelayS
 *	���ܣ�   ����ʱ����
 *	���������Time��ʱʱ�䳤�� ��ʱʱ��Time S
 *	���ز������� 
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
 * LCD����˸
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
 *  ��������POWER_INITIAL
 *	���ܣ�  �ϵ�ϵͳ��ʼ��
 *  ���룺  ��
 *  �����  ��
 --------------------------------------------------*/	
void POWER_INITIAL (void) 
{
	 
	OSCCON = 0B01110001;	//WDT 32KHZ IRCF=111=16MHZ
					 		//Bit0=1,ϵͳʱ��Ϊ�ڲ�����
					 		//Bit0=0,ʱ��Դ��FOSC<2��0>����������ѡ��ʱѡ��
	INTCON = 0;  			//�ݽ�ֹ�����ж�
    PCKEN |=0B00000001;      //ADģ��ʱ��ʹ��  		
	PORTA = 0B00000000;		
	TRISA = 0B11111111;		//PA������� 0-��� 1-����
	PORTB = 0B00000000;		
	TRISB = 0B11110111;		//PB������� 0-��� 1-����							
	PORTC = 0B00000000; 	
	TRISC = 0B01111111;		//PC������� 0-��� 1-����  	
    PORTD = 0B00000000;		
	TRISD = 0B11111000;		//PD������� 0-��� 1-����
	
	WPUA = 0B00000000;     	//PA�˿��������� 1-������ 0-������
	WPUB = 0B00000000;     	//PB�˿��������� 1-������ 0-������
	WPUC = 0B00001000;     	//PC�˿��������� 1-������ 0-������
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
	Max7219_pinCLK_TRIS = 0;
	Max7219_pinCS_TRIS = 0;
	Max7219_pinDIN_TRIS = 0;
    ANSELA = 0B00000000;    //ȫΪ���ֹܽ�
 
}



// ����
void button(void){
	// ��ȡ������PA0�ĵ��̣����µ͵�ƽ
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

// ���Ź�
void initWDT(){

	// �幷
	CLRWDT();
	// 
	MISC0 = 0x00; // Ĭ��ʱ��Ƶ��,32K
	//
	WDTCON = 0b00010111; //���Ź�Ԥ��Ƶ����λ1:1 ���Ź���ʱ������ѡ��65535 
						// ʱ�� t = 1/32k*65535*1 = 2.048s
}


//--------------------------------------------
//���ܣ���MAX7219(U3)д���ֽ�
//��ڲ�����DATA 
//���ڲ�������
//˵����
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

// ��
//-------------------------------------------
//���ܣ���MAX7219д������
//��ڲ�����address��ַ��dat����
//���ڲ�������
//˵����
void Write_Max7219(unsigned char address,unsigned char dat){
	Max7219_pinCS = 0;
	Write_Max7219_byte(address);           //д���ַ��������ܱ��
    Write_Max7219_byte(dat);               //д�����ݣ����������ʾ����
    Max7219_pinCS=1;
}


//-------------------------------------------
//���ܣ���ʼ��max7219
//��ڲ�������
//���ڲ�������
//˵��:

void Init_MAX7219(void)
{
 Write_Max7219(0x09, 0xff);       //���뷽ʽ��BCD��
 Write_Max7219(0x0a, 0x03);       //����
 Write_Max7219(0x0b, 0x07);       //ɨ����ޣ�4���������ʾ
 Write_Max7219(0x0c, 0x01);       //����ģʽ��0����ͨģʽ��1
 Write_Max7219(0x0f, 0x01);       //��ʾ���ԣ�1�����Խ�����������ʾ��0
}


/*-------------------------------------------------
 *  ������: ADC_INITIAL
 *	���ܣ�  ADC��ʼ��
 *  ���룺  ��
 *  �����  ��
 --------------------------------------------------*/

void initADC(void){
	// ��������Ϊ����
	TRISC0 = 1;
	TRISC1 = 1;

	ANSELA = 0B11100101;    //ģ������ã�AN2��AN1Ϊģ��ܽ�

	ADCON1 = 0B11100100; 	//�Ҷ��룬ת��ʱ��Fosc/64�����ο���ѹGND�����ο���ѹ�ڲ���ѹ(2V)
	ADCON0 = 0B00000000; 	//ѡ��ADת��ͨ��0��ʹ��ADC
	ADCON2 = 0B01000000; 	//ѡ���ڲ����ο���ѹ2V�����ⲿ����Դ
	ADCON3 = 0B00000000; 
	ADDLY  = 0B00000000;    //�ⲿ����͢ʱ��û�õ�
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
 *	�������ƣ�Time4Initial
 *	���ܣ�  
 *	���������
 *	���ز������� 
 -------------------------------------------------*/
void Time4Initial(void)
{
	PCKEN |=0B00001000;      //TIME4ģ��ʱ��ʹ��
    //CKOCON=0B00110000;
    //TCKSRC=0B00000011;		
    
    TIM4CR1	=0B00000101;
    //BIT7: 0��TIM1_ARR�Ĵ���û�л��壬�����Ա�ֱ��д��; 1��TIM1_ARR�Ĵ�����Ԥװ�ػ��������塣
    //BIT6:����
    //BIT5~BIT4:timer4ʱ��ѡ��λ��
        		//00��ϵͳʱ��/��ʱ��
				//01���ڲ���ʱ��HIRC
				//10��LPʱ�ӣ�ֻ�е�FOSCѡ��LPģʽʱ��������
				//11��XTʱ�ӣ�ֻ�е�FOSCѡ��XTģʽʱ��������

    //BIT3:
    //			0���ڷ��������¼�ʱ����������ֹͣ��
	//			1���ڷ�����һ�θ����¼�(���CENλ)ʱ��������ֹͣ��

    //BIT2:
   	// 		0�����UDIS�������������¼�����������һ�¼�����һ�������жϣ�
				//�Ĵ���������(����������/����)
				//��������UGλ
				//ʱ��/���������������ĸ���
	//		1�����UDIS�������������¼�����ֻ�е������¼�����ʱ�Ų��������жϣ���UIF��1��
				//�Ĵ���������(����������/����)

    //BIT1:
    //		0��һ�������¼���������������(UEV)�¼���
				//���������/����
				//�������������¼�
				//ʱ��/����ģʽ������������Ӳ����λ������ļĴ�����װ�����ǵ�Ԥװ��ֵ��
	//		1�������������¼���Ӱ�ӼĴ���(ARR��PSC��CCRx)�������ǵ�ֵ�����������UGλ��ʱ��/����������������һ��Ӳ����λ�����������Ԥ��Ƶ�������³�ʼ����

    // BIT0: 0����ֹ��������1��ʹ�ܼ�������


    TIM4IER	=0B00000001;
    //BIT0:  0����ֹ�����жϣ�1�����������жϡ�

    TIM4SR	=0B00000000;
    //BIT0:�����������¼�ʱ��λ��Ӳ����1����������д1��0
			//0���޸����¼�������
			//1�������¼��ȴ���Ӧ�����Ĵ���������ʱ��λ��Ӳ����1��
			//��TIM4_CR1�Ĵ�����UDIS=0�������������������ʱ��
			//��TIM4_CR1�Ĵ�����UDIS=0��URS=0��������TIM4_EGR�Ĵ�����UGλ�����Լ�����
			//CNT���³�ʼ��ʱ��
			//��TIM4_CR1�Ĵ�����UDIS=0��URS=0����������CNT�������¼����³�ʼ��ʱ��

    TIM4EGR	=0B00000000;
    //BIT0:��λ��������1����Ӳ���Զ���0��
	//0���޶�����
	//1�����³�ʼ����������������һ�������¼���ע��Ԥ��Ƶ���ļ�����Ҳ����0(����Ԥ��Ƶϵ������)���������ĶԳ�ģʽ�»�DIR=0(���ϼ���)�����������0����DIR=1(���¼���)�������ȡTIM1_ARR��ֵ��

    TIM4CNTR=0; //TIM4 8λ������
    
    TIM4PSCR=0B00000100;
    //Ԥ��Ƶ���������CK_PSCʱ�ӽ��з�Ƶ��
	//��������ʱ��Ƶ��fCK_CNT����fCK_PSC/2(PSC[2:0])��PSC[7:3]��Ӳ����0��
	//PSCR�����˵������¼�����ʱװ�뵱ǰԤ��Ƶ���Ĵ�����ֵ(�����������TIMx_EGR�Ĵ�����UGλ�����ļ���������¼�)������ζ����Ҫ�µ�Ԥ��Ƶֵ��Ч��������������¼�����CEN=0��

    TIM4ARR	=124; // Ƶ��= 16M/64*(256-124) Ȼ��ȡ�����������Ƕ�ʱ��ʱ�� = 1/Ƶ�� 
    //ARR�����˽�Ҫװ����ʵ�ʵ��Զ���װ�ؼĴ�����ֵ��
	//���Զ���װ�ص�ֵΪ��ʱ����������������

    INTCON |= 0B11000000;    //�����жϺ������ж�
  }


/*----------------------------------------------------
 *	�������ƣ�EEPROMread
 *	���ܣ�   ��EEPROM����
 *	���������EEAddr ���ȡ���ݵĵ�ַ
 *  ���ز�����ReEEPROMread ��Ӧ��ַ����������
 ----------------------------------------------------*/
unchar EEPROMread(unchar EEAddr)
{
	unchar ReEEPROMread;
    
    DRDEN=1;    
    NOP();
    NOP();      
   	EEADRL = EEAddr; // �ѵ�ַд�� EEADRL�Ĵ���

	// ���� EECON1 �Ĵ����� EEPGD �� CFGS ����λ
    CFGS =0;
    EEPGD=0; 
   	RD = 1;
    
	ReEEPROMread = EEDATL; 
    DRDEN=0;    	
	return ReEEPROMread;
}


/*---------------------------------------------------- 
 *	�������ƣ�EEPROMwrite
 *	���ܣ�   д���ݵ�EEPROM
 *	���������EEAddr ��Ҫд�����ݵĵ�ַ
 *	        Data ��Ҫд�������
 *	���ز�������
 ----------------------------------------------------*/
void EEPROMwrite(unchar EEAddr,unchar Data)
{
	
	while(GIE)					//�ȴ�GIEΪ0
		{GIE = 0;	}					//д���ݱ���ر��ж�
	EEADRL = EEAddr; 	 			//EEPROM�ĵ�ַ
	EEDATL = Data;		 			//EEPROM��д����  
      
    CFGS =0;                        //����EEPROM�洢��
    EEPGD=0;                        //
    
    WREN=1;                         //дʹ��
    
    EEIF = 0;
    EECON2=0x55;
    EECON2=0xAA;

	WR = 1;							//��λWR�������
    NOP();
    NOP();
    NOP();
    NOP();
	while(WR);      				//�ȴ�EEд�����
    WREN=0;
	GIE = 1;
}



// ��ʼ���¶ȴ�����
void Init_DS18B20(){
	unsigned char presence = 1,cnt =0;
	while(presence&&cnt<15){
		DQ_LOW() ;                                	//���������͵�ƽ
		DelayUs(503);	
		DQ_HIGH() ;
		DelayUs(40);
		if(DQ==1){
			presence = 1;
		}else{
			presence = 0;
		}
		DelayUs(430);
	}

}


unsigned char ReadOneChar(void)  			//�����������ȴӸ������͵�ƽ1us���ϣ���ʹ��������Ϊ�ߵ�ƽ���Ӷ��������ź�
{
	unsigned char i=0; 		//ÿ����������̵ĳ���ʱ��Ϊ60us������������֮�������1us���ϵĸߵ�ƽ�ָ���
	unsigned char dat=0; 
    static unsigned char j;
	for (i=8;i>0;i--) 		//һ���ֽ���8λ 
	{
		dat>>=1;
		DQ_LOW();
		NOP();NOP();NOP();NOP();NOP();NOP();
        DQ_HIGH();
        NOP();NOP();NOP();NOP();NOP();
        j = DQ;
		if(j==1) 
            dat|=0x80; 
		DelayUs(63);
	} 
	return(dat);
}
void WriteOneChar(unsigned char dat) 
{ 
    unsigned char i=0,temp; 		//�����ߴӸߵ�ƽ�����͵�ƽ������д��ʼ�źš�15us֮�ڽ�����д��λ�͵��������ϣ�
    for(i=8;i>0;i--) 		//��15~60us֮��������߽��в���������Ǹߵ�ƽ��д1����д0������ 
    {
        temp=dat&0x01; 
        DQ_LOW();
        NOP();NOP();NOP();NOP();NOP();
        if(temp == 1)
           DQ_HIGH();
        DelayUs(63);
         DQ_HIGH();
         NOP();NOP();
        dat>>=1;
    } 
}


// �¶ȶ�ȡ
unsigned int ReadTemperature(void) 
{
    unsigned char TLV;
    unsigned char THV,ge,shi,TZ,TX,shifen,baifen,qianfen,wanfen;
    unsigned int temperature,value,wd;
    GIE = 0;
    DQ_HIGH();
    Init_DS18B20(); 
    WriteOneChar(0xcc); 
    WriteOneChar(0x44);
    DelayMs(50);
    Init_DS18B20();
    WriteOneChar(0xcc);
    WriteOneChar(0xbe);
    
    TLV=ReadOneChar();
    THV=ReadOneChar();
    DQ_HIGH();
     GIE = 1;
    TZ = ((TLV>>4)|(THV<< 4))&0X3f;        //�¶���������
	TX = TLV << 4;                              //�¶�С������
	if (TZ > 100) TZ / 100;                     //����ʾ��λ
	ge = TZ % 10;                   			//�������ָ�λ
	shi = TZ / 10; 			                    //����ʮλ
	wd = 0;
	if (TX & 0x80) wd = wd + 5000;
	if (TX & 0x40) wd = wd + 2500;
	if (TX & 0x20) wd = wd + 1250;
	if (TX & 0x10) wd = wd + 625;                //����4��ָ���С������ת��ΪBCD����ʽ
    shifen = wd / 1000;                          //ʮ��λ
	baifen = (wd % 1000) / 100;                  //�ٷ�λ
	qianfen = (wd % 100) / 10;                   //ǧ��λ
	wanfen = wd % 10;                            //���λ
	NOP();
    temperature = shi*10+ge;
   
return temperature;	
}


/*-------------------------------------------------
 *  ������: UART_INITIAL
 *	���ܣ�  ������
 *  ���룺  ��
 *  �����  ��
 --------------------------------------------------*/
void UART_INITIAL(void)
{
	PCKEN |=0B00100000;	//��UARTʱ��
    TRISA7=1;//UART_RX
    TRISA6=0;//UART_TX
    
    URIER =0B00100001;  //ʹ�ܷ��ͽ�������ж�
    URLCR =0B00000001;  //8λ���ݣ�ֹͣλ1������żУ��
    URMCR =0B00011000;  // ����ʹ��/����ʹ�� ʹ�ܽӿڵķ��ͣ���Ӧ�� IO �ᱻ���� TX ����,�����ӿڽ��գ���Ӧ�� IO �ᱻ���� RX ����
    
    URDLL =104;         //9600������ = Fosc/16*[URDLH:URDLL]
    URDLH =0;
    TCF=1;     // �������״̬��־,1�����ݷ������
	INTCON=0B11000000; // ��ȫ���жϣ��������ж�
    UROD=1; // UART_TX �ܽŵĿ�©������ã�����Ч
    
    //TCF: ������ɱ�־
    //TXEF:1���ͼĴ���Ϊ��
    //RXNEF:1���ռĴ����ǿ�
}


/*-------------------------------------------------
 *  ������: main 
 *	���ܣ�  ������
 *  ���룺  ��
 *  �����  ��
 --------------------------------------------------*/
void main(void)
{

	POWER_INITIAL();		//ϵͳ��ʼ��


	Init_MAX7219();
	DelayMs(100);
	Write_Max7219(0x0f, 0x00);	  //��ʾ���ԣ�1�����Խ�����������ʾ��0

	while(1)
	{
		Write_Max7219(1,cout/100);
		Write_Max7219(2,cout%100/10);
		Write_Max7219(3,cout%10);
		cout = ReadTemperature(); 
 		DelayS(1);

	}
		  

}
