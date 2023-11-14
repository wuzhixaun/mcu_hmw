//Deviec:FT62F08X
//-----------------------Variable---------------------------------
		_Flash_Code		EQU		7DH
		_Flash_BZ		EQU		7CH
		_Dis_Data		EQU		28H
		_Time_1ms		EQU		27H
		_Time_1s		EQU		20H
		_Sm_Code		EQU		26H
		_adcData		EQU		24H
		_theVoltage		EQU		22H
//		___lmul@product		EQU		78H
//		___lmul@multiplier		EQU		70H
//		___lmul@multiplicand		EQU		74H
//		Get_ADC_Data@adcChannel		EQU		75H
//		Get_ADC_Data@adcChannel		EQU		75H
//		Get_ADC_Data@adcChannel		EQU		75H
//		Delay_Us@Time		EQU		70H
//		Delay_Us@a		EQU		71H
//		Delay_Us@Time		EQU		70H
//		Delay_Us@Time		EQU		70H
//-----------------------Variable END---------------------------------

		MOVLP 	0H 			//0000 	0180
		LJUMP 	13H 			//0001 	3813
		ORG		0003H
		NOP 					//0003 	1000
		LDWI 	1H 			//0004 	0001
		BSR 	7EH, 0H 			//0005 	247E
		MOVLP 	0H 			//0006 	0180

		//;User_Isr.c: 17: if(T2UIE&T2UIF)
		MOVLB 	6H 			//0007 	1026
		BTSS 	DH, 0H 			//0008 	2C0D
		ANDWI 	0H 			//0009 	0900
		BTSS 	EH, 0H 			//000A 	2C0E
		ANDWI 	0H 			//000B 	0900
		BTSS 	9H, 0H 			//000C 	2C09
		LJUMP 	11H 			//000D 	3811

		//;User_Isr.c: 18: {
		//;User_Isr.c: 19: T2UIF= 1;
		BSR 	EH, 0H 			//000E 	240E

		//;User_Isr.c: 21: LCD_Flash();
		MOVLP 	1H 			//000F 	0181
		LCALL 	117H 			//0010 	3117
		BCR 	7EH, 0H 			//0011 	207E
		RETI 					//0012 	1009
		MOVLP 	0H 			//0013 	0180
		LJUMP 	15H 			//0014 	3815
		CLRF 	7CH 			//0015 	11FC
		CLRF 	7DH 			//0016 	11FD
		MOVLB 	0H 			//0017 	1020
		CLRF 	20H 			//0018 	11A0
		CLRF 	21H 			//0019 	11A1
		CLRF 	22H 			//001A 	11A2
		CLRF 	23H 			//001B 	11A3
		CLRF 	24H 			//001C 	11A4
		CLRF 	25H 			//001D 	11A5
		CLRF 	26H 			//001E 	11A6
		CLRF 	27H 			//001F 	11A7
		CLRF 	28H 			//0020 	11A8
		BCR 	7EH, 0H 			//0021 	207E
		MOVLB 	0H 			//0022 	1020
		LJUMP 	24H 			//0023 	3824

		//;User_Main.C: 188: System_Init();
		LCALL 	77H 			//0024 	3077
		MOVLP 	0H 			//0025 	0180

		//;User_Main.C: 189: while(1)
		CLRWDT 			//0026 	1064

		//;User_Main.C: 193: adcData = Get_ADC_Data(4);
		LDWI 	4H 			//0027 	0004
		LCALL 	57H 			//0028 	3057
		MOVLP 	0H 			//0029 	0180
		LDR 	73H, 0H 			//002A 	1873
		MOVLB 	0H 			//002B 	1020
		STR 	25H 			//002C 	10A5
		LDR 	72H, 0H 			//002D 	1872
		STR 	24H 			//002E 	10A4

		//;User_Main.C: 194: theVoltage = (unlong)adcData*2*1000/4096;
		LDR 	24H, 0H 			//002F 	1824
		STR 	70H 			//0030 	10F0
		LDR 	25H, 0H 			//0031 	1825
		STR 	71H 			//0032 	10F1
		LDWI 	3H 			//0033 	0003
		CLRF 	72H 			//0034 	11F2
		CLRF 	73H 			//0035 	11F3
		LSLF 	70H, 1H 		//0036 	05F0
		RLR 	71H, 1H 			//0037 	1DF1
		RLR 	72H, 1H 			//0038 	1DF2
		RLR 	73H, 1H 			//0039 	1DF3
		CLRF 	77H 			//003A 	11F7
		CLRF 	76H 			//003B 	11F6
		STR 	75H 			//003C 	10F5
		LDWI 	E8H 			//003D 	00E8
		STR 	74H 			//003E 	10F4
		LCALL 	D0H 			//003F 	30D0
		MOVLP 	0H 			//0040 	0180
		LDR 	70H, 0H 			//0041 	1870
		STR 	29H 			//0042 	10A9
		LDR 	71H, 0H 			//0043 	1871
		STR 	2AH 			//0044 	10AA
		LDR 	72H, 0H 			//0045 	1872
		STR 	2BH 			//0046 	10AB
		LDR 	73H, 0H 			//0047 	1873
		STR 	2CH 			//0048 	10AC
		LDWI 	CH 			//0049 	000C
		LSRF 	2CH, 1H 		//004A 	06AC
		RRR 	2BH, 1H 			//004B 	1CAB
		RRR 	2AH, 1H 			//004C 	1CAA
		RRR 	29H, 1H 			//004D 	1CA9
		DECRSZ 	9H, 1H 		//004E 	1B89
		LJUMP 	4AH 			//004F 	384A
		LDR 	2AH, 0H 			//0050 	182A
		STR 	23H 			//0051 	10A3
		LDR 	29H, 0H 			//0052 	1829
		STR 	22H 			//0053 	10A2

		//;User_Main.C: 195: __nop();
		NOP 					//0054 	1000

		//;User_Main.C: 196: __nop();
		NOP 					//0055 	1000
		LJUMP 	26H 			//0056 	3826
		STR 	75H 			//0057 	10F5

		//;User_System.c: 78: ADCON0 &= 0B00001111;
		LDWI 	FH 			//0058 	000F
		MOVLB 	1H 			//0059 	1021
		ANDWR 	1DH, 1H 		//005A 	159D

		//;User_System.c: 79: ADCON0 |= adcChannel<<4;
		SWAPR 	75H, 0H 		//005B 	1E75
		ANDWI 	F0H 			//005C 	09F0
		IORWR 	1DH, 1H 		//005D 	149D

		//;User_System.c: 80: Delay_Us(40);
		LDWI 	28H 			//005E 	0028
		LCALL 	6EH 			//005F 	306E
		MOVLP 	0H 			//0060 	0180

		//;User_System.c: 81: GO = 1;
		MOVLB 	1H 			//0061 	1021
		BSR 	1DH, 1H 			//0062 	249D

		//;User_System.c: 82: __nop();
		NOP 					//0063 	1000

		//;User_System.c: 83: __nop();
		NOP 					//0064 	1000

		//;User_System.c: 84: while(GO);
		MOVLB 	1H 			//0065 	1021
		BTSC 	1DH, 1H 		//0066 	289D
		LJUMP 	65H 			//0067 	3865

		//;User_System.c: 86: return (unint)(ADRESH<<8|ADRESL);
		LDR 	1CH, 0H 			//0068 	181C
		STR 	73H 			//0069 	10F3
		CLRF 	72H 			//006A 	11F2
		LDR 	1BH, 0H 			//006B 	181B
		IORWR 	72H, 1H 		//006C 	14F2
		RET 					//006D 	1008
		STR 	70H 			//006E 	10F0

		//;User_System.c: 12: unsigned char a;
		//;User_System.c: 13: for(a=0;a<Time;a++)
		CLRF 	71H 			//006F 	11F1
		LDR 	70H, 0H 			//0070 	1870
		SUBWR 	71H, 0H 		//0071 	1271
		BTSC 	3H, 0H 			//0072 	2803
		RET 					//0073 	1008

		//;User_System.c: 14: {
		//;User_System.c: 15: __nop();
		NOP 					//0074 	1000
		INCR 	71H, 1H 		//0075 	1AF1
		LJUMP 	70H 			//0076 	3870

		//;User_System.c: 132: GPIO_Init();
		LCALL 	99H 			//0077 	3099
		MOVLP 	0H 			//0078 	0180

		//;User_System.c: 133: ADC_INITIAL();
		LCALL 	81H 			//0079 	3081
		MOVLP 	0H 			//007A 	0180

		//;User_System.c: 134: WDT_INITIAL();
		LCALL 	C9H 			//007B 	30C9
		MOVLP 	0H 			//007C 	0180

		//;User_System.c: 135: PWM2_Init();
		LCALL 	F5H 			//007D 	30F5

		//;User_System.c: 136: INTCON = 0B11000000;
		LDWI 	C0H 			//007E 	00C0
		STR 	BH 			//007F 	108B
		RET 					//0080 	1008

		//;User_System.c: 90: ADCEN=1;
		BSR 	1AH, 0H 			//0081 	241A

		//;User_System.c: 92: ANSELA = 0B00010000;
		LDWI 	10H 			//0082 	0010
		MOVLB 	3H 			//0083 	1023
		STR 	17H 			//0084 	1097

		//;User_System.c: 93: ADCON1 = 0B11100100;
		LDWI 	E4H 			//0085 	00E4
		MOVLB 	1H 			//0086 	1021
		STR 	1EH 			//0087 	109E

		//;User_System.c: 94: ADCON0 = 0B00000000;
		CLRF 	1DH 			//0088 	119D

		//;User_System.c: 95: ADCON2 = 0B01000000;
		LDWI 	40H 			//0089 	0040
		STR 	1FH 			//008A 	109F

		//;User_System.c: 96: ADCON3 = 0B00000000;
		MOVLB 	8H 			//008B 	1028
		CLRF 	1AH 			//008C 	119A

		//;User_System.c: 97: ADDLY = 0B00000000;
		MOVLB 	0H 			//008D 	1020
		CLRF 	1FH 			//008E 	119F

		//;User_System.c: 98: ADCMPH = 0B00000000;
		MOVLB 	8H 			//008F 	1028
		CLRF 	1BH 			//0090 	119B

		//;User_System.c: 100: ADCAL = 1;
		MOVLB 	1H 			//0091 	1021
		BSR 	1DH, 3H 			//0092 	259D

		//;User_System.c: 101: __nop();
		NOP 					//0093 	1000

		//;User_System.c: 102: while (ADCAL)
		MOVLB 	1H 			//0094 	1021
		BTSS 	1DH, 3H 		//0095 	2D9D
		RET 					//0096 	1008

		//;User_System.c: 104: ADON = 1;
		BSR 	1DH, 0H 			//0097 	241D
		LJUMP 	94H 			//0098 	3894

		//;User_System.c: 140: OSCCON = 0B01110001;
		LDWI 	71H 			//0099 	0071
		MOVLB 	1H 			//009A 	1021
		STR 	19H 			//009B 	1099

		//;User_System.c: 144: AFP0 = 0B00000000;
		MOVLB 	3H 			//009C 	1023
		CLRF 	1EH 			//009D 	119E

		//;User_System.c: 145: AFP1 = 0x00;
		CLRF 	1FH 			//009E 	119F

		//;User_System.c: 146: TRISA = 0B01000000;
		LDWI 	40H 			//009F 	0040
		MOVLB 	1H 			//00A0 	1021
		STR 	CH 			//00A1 	108C

		//;User_System.c: 147: PORTA = 0B00000000;
		MOVLB 	0H 			//00A2 	1020
		CLRF 	CH 			//00A3 	118C

		//;User_System.c: 148: WPUA = 0B00000000;
		MOVLB 	3H 			//00A4 	1023
		CLRF 	CH 			//00A5 	118C

		//;User_System.c: 149: WPDA = 0B00000000;
		MOVLB 	4H 			//00A6 	1024
		CLRF 	CH 			//00A7 	118C

		//;User_System.c: 151: TRISB = 0B00000000;
		MOVLB 	1H 			//00A8 	1021
		CLRF 	DH 			//00A9 	118D

		//;User_System.c: 152: PORTB = 0B00000000;
		MOVLB 	0H 			//00AA 	1020
		CLRF 	DH 			//00AB 	118D

		//;User_System.c: 153: WPUB = 0B00111100;
		LDWI 	3CH 			//00AC 	003C
		MOVLB 	3H 			//00AD 	1023
		STR 	DH 			//00AE 	108D

		//;User_System.c: 154: WPDB = 0B00111100;
		MOVLB 	4H 			//00AF 	1024
		STR 	DH 			//00B0 	108D

		//;User_System.c: 156: TRISC = 0B00000000;
		MOVLB 	1H 			//00B1 	1021
		CLRF 	EH 			//00B2 	118E

		//;User_System.c: 157: PORTC = 0B00000000;
		MOVLB 	0H 			//00B3 	1020
		CLRF 	EH 			//00B4 	118E

		//;User_System.c: 159: TRISD = 0B00000000;
		MOVLB 	1H 			//00B5 	1021
		CLRF 	FH 			//00B6 	118F

		//;User_System.c: 160: PORTD = 0B00000000;
		MOVLB 	0H 			//00B7 	1020
		CLRF 	FH 			//00B8 	118F

		//;User_System.c: 162: WPUC = 0B00000000;
		MOVLB 	3H 			//00B9 	1023
		CLRF 	EH 			//00BA 	118E

		//;User_System.c: 163: WPDC = 0B00000000;
		MOVLB 	4H 			//00BB 	1024
		CLRF 	EH 			//00BC 	118E

		//;User_System.c: 164: PSRC0 = 0B11111111;
		LDWI 	FFH 			//00BD 	00FF
		MOVLB 	2H 			//00BE 	1022
		STR 	1AH 			//00BF 	109A

		//;User_System.c: 168: PSRC1 = 0B11111111;
		STR 	1BH 			//00C0 	109B

		//;User_System.c: 171: PSINK0 = 0B11111111;
		MOVLB 	3H 			//00C1 	1023
		STR 	1AH 			//00C2 	109A

		//;User_System.c: 172: PSINK1 = 0B11111111;
		STR 	1BH 			//00C3 	109B

		//;User_System.c: 173: PSINK2 = 0B11111111;
		STR 	1CH 			//00C4 	109C

		//;User_System.c: 174: PSINK3 = 0B11111111;
		STR 	1DH 			//00C5 	109D

		//;User_System.c: 175: UARTEN=0;
		MOVLB 	1H 			//00C6 	1021
		BCR 	1AH, 5H 			//00C7 	229A
		RET 					//00C8 	1008
		CLRWDT 			//00C9 	1064

		//;User_System.c: 180: MISC0 = 0B00000000;
		MOVLB 	2H 			//00CA 	1022
		CLRF 	1CH 			//00CB 	119C

		//;User_System.c: 181: WDTCON = 0B00001011;
		LDWI 	BH 			//00CC 	000B
		MOVLB 	1H 			//00CD 	1021
		STR 	17H 			//00CE 	1097
		RET 					//00CF 	1008
		CLRF 	78H 			//00D0 	11F8
		CLRF 	79H 			//00D1 	11F9
		CLRF 	7AH 			//00D2 	11FA
		CLRF 	7BH 			//00D3 	11FB
		BTSS 	70H, 0H 		//00D4 	2C70
		LJUMP 	DEH 			//00D5 	38DE
		LDR 	74H, 0H 			//00D6 	1874
		ADDWR 	78H, 1H 		//00D7 	17F8
		LDR 	75H, 0H 			//00D8 	1875
		ADDWFC 	79H, 1H 		//00D9 	0DF9
		LDR 	76H, 0H 			//00DA 	1876
		ADDWFC 	7AH, 1H 		//00DB 	0DFA
		LDR 	77H, 0H 			//00DC 	1877
		ADDWFC 	7BH, 1H 		//00DD 	0DFB
		LSLF 	74H, 1H 		//00DE 	05F4
		RLR 	75H, 1H 			//00DF 	1DF5
		RLR 	76H, 1H 			//00E0 	1DF6
		RLR 	77H, 1H 			//00E1 	1DF7
		LSRF 	73H, 1H 		//00E2 	06F3
		RRR 	72H, 1H 			//00E3 	1CF2
		RRR 	71H, 1H 			//00E4 	1CF1
		RRR 	70H, 1H 			//00E5 	1CF0
		LDR 	73H, 0H 			//00E6 	1873
		IORWR 	72H, 0H 		//00E7 	1472
		IORWR 	71H, 0H 		//00E8 	1471
		IORWR 	70H, 0H 		//00E9 	1470
		BTSS 	3H, 2H 			//00EA 	2D03
		LJUMP 	D4H 			//00EB 	38D4
		LDR 	7BH, 0H 			//00EC 	187B
		STR 	73H 			//00ED 	10F3
		LDR 	7AH, 0H 			//00EE 	187A
		STR 	72H 			//00EF 	10F2
		LDR 	79H, 0H 			//00F0 	1879
		STR 	71H 			//00F1 	10F1
		LDR 	78H, 0H 			//00F2 	1878
		STR 	70H 			//00F3 	10F0
		RET 					//00F4 	1008

		//;User_System.c: 220: PCKEN |=0B00000100;
		BSR 	1AH, 2H 			//00F5 	251A

		//;User_System.c: 221: CKOCON=0B00100000;
		LDWI 	20H 			//00F6 	0020
		STR 	15H 			//00F7 	1095

		//;User_System.c: 222: TCKSRC=0B00010001;
		LDWI 	11H 			//00F8 	0011
		MOVLB 	6H 			//00F9 	1026
		STR 	1FH 			//00FA 	109F

		//;User_System.c: 224: TIM2PSCR=0B00000100;
		LDWI 	4H 			//00FB 	0004
		STR 	18H 			//00FC 	1098

		//;User_System.c: 226: TIM2CR1 =0B10000101;
		LDWI 	85H 			//00FD 	0085
		STR 	CH 			//00FE 	108C

		//;User_System.c: 228: TIM2IER =0B00000001;
		LDWI 	1H 			//00FF 	0001
		STR 	DH 			//0100 	108D

		//;User_System.c: 230: TIM2SR1 =0B00000000;
		CLRF 	EH 			//0101 	118E

		//;User_System.c: 231: TIM2SR2 = 0B00000000;
		CLRF 	FH 			//0102 	118F

		//;User_System.c: 232: TIM2EGR = 0B00000000;
		CLRF 	10H 			//0103 	1190

		//;User_System.c: 234: TIM2CCMR3 = 0B00000000;
		CLRF 	13H 			//0104 	1193

		//;User_System.c: 236: TIM2CCMR2 = 0B00000000;
		CLRF 	12H 			//0105 	1192

		//;User_System.c: 239: TIM2CCMR1 = 0B00000000;
		CLRF 	11H 			//0106 	1191

		//;User_System.c: 241: TIM2CCER1 = 0B00000000;
		CLRF 	14H 			//0107 	1194

		//;User_System.c: 243: TIM2CCER2 = 0B00000000;
		CLRF 	15H 			//0108 	1195

		//;User_System.c: 245: TIM2CNTRH = 0B00000000;
		CLRF 	16H 			//0109 	1196

		//;User_System.c: 246: TIM2CNTRL = 0B00000000;
		CLRF 	17H 			//010A 	1197

		//;User_System.c: 249: TIM2ARRH = 0x09;
		LDWI 	9H 			//010B 	0009
		STR 	19H 			//010C 	1099

		//;User_System.c: 250: TIM2ARRL = 0xC4;
		LDWI 	C4H 			//010D 	00C4
		STR 	1AH 			//010E 	109A

		//;User_System.c: 253: TIM2CCR1H = 0x00;
		CLRF 	1BH 			//010F 	119B

		//;User_System.c: 254: TIM2CCR1L = 0x00;
		CLRF 	1CH 			//0110 	119C

		//;User_System.c: 256: TIM2CCR2H = 0x00;
		CLRF 	1DH 			//0111 	119D

		//;User_System.c: 257: TIM2CCR2L = 0x00;
		CLRF 	1EH 			//0112 	119E

		//;User_System.c: 259: TIM2CCR3H = 0x00;
		MOVLB 	5H 			//0113 	1025
		CLRF 	1EH 			//0114 	119E

		//;User_System.c: 260: TIM2CCR3L = 0x00;
		CLRF 	1FH 			//0115 	119F
		RET 					//0116 	1008

		//;User_Main.C: 9: Flash_BZ = !Flash_BZ;
		LDWI 	1H 			//0117 	0001
		XORWR 	7CH, 1H 		//0118 	16FC

		//;User_Main.C: 10: switch(Flash_Code)
		LJUMP 	152H 			//0119 	3952

		//;User_Main.C: 11: {
		//;User_Main.C: 12: case 0:
		//;User_Main.C: 13: TRISB4 = 1;
		MOVLB 	1H 			//011A 	1021
		BSR 	DH, 4H 			//011B 	260D

		//;User_Main.C: 14: TRISB3 = 1;
		BSR 	DH, 3H 			//011C 	258D

		//;User_Main.C: 15: TRISB2 = 1;
		BSR 	DH, 2H 			//011D 	250D

		//;User_Main.C: 17: TRISB5 = 0;
		BCR 	DH, 5H 			//011E 	228D

		//;User_Main.C: 18: if(Flash_BZ==0)
		BTSC 	7CH, 0H 		//011F 	287C
		LJUMP 	124H 			//0120 	3924

		//;User_Main.C: 19: {
		//;User_Main.C: 20: PB5 = 1;
		MOVLB 	0H 			//0121 	1020
		BSR 	DH, 5H 			//0122 	268D

		//;User_Main.C: 22: PB7 = 0;
		//;User_Main.C: 23: PC0 = 0;
		//;User_Main.C: 24: PA1 = 0;
		//;User_Main.C: 25: PA0 = 0;
		//;User_Main.C: 26: PB0 = 0;
		//;User_Main.C: 27: PB1 = 0;
		//;User_Main.C: 28: PD3 = 0;
		//;User_Main.C: 29: PD2 = 0;
		//;User_Main.C: 30: PD1 = 0;
		//;User_Main.C: 31: PC6 = 0;
		//;User_Main.C: 32: PC5 = 0;
		//;User_Main.C: 33: PC4 = 0;
		//;User_Main.C: 35: }
		LJUMP 	161H 			//0123 	3961

		//;User_Main.C: 36: else
		//;User_Main.C: 37: {
		//;User_Main.C: 38: PB5 = 0;
		MOVLB 	0H 			//0124 	1020
		BCR 	DH, 5H 			//0125 	228D

		//;User_Main.C: 40: PB7 = 1;
		//;User_Main.C: 41: PC0 = 1;
		//;User_Main.C: 42: PA1 = 1;
		//;User_Main.C: 43: PA0 = 1;
		//;User_Main.C: 44: PB0 = 1;
		//;User_Main.C: 45: PB1 = 1;
		//;User_Main.C: 46: PD3 = 1;
		//;User_Main.C: 47: PD2 = 1;
		//;User_Main.C: 48: PD1 = 1;
		//;User_Main.C: 49: PC6 = 1;
		//;User_Main.C: 50: PC5 = 1;
		//;User_Main.C: 51: PC4 = 1;
		LCALL 	16EH 			//0126 	316E

		//;User_Main.C: 52: Flash_Code++;
		INCR 	7DH, 1H 		//0127 	1AFD
		RET 					//0128 	1008

		//;User_Main.C: 55: case 1:
		//;User_Main.C: 56: TRISB5 = 1;
		MOVLB 	1H 			//0129 	1021
		BSR 	DH, 5H 			//012A 	268D

		//;User_Main.C: 57: TRISB3 = 1;
		BSR 	DH, 3H 			//012B 	258D

		//;User_Main.C: 58: TRISB2 = 1;
		BSR 	DH, 2H 			//012C 	250D

		//;User_Main.C: 60: TRISB4 = 0;
		BCR 	DH, 4H 			//012D 	220D

		//;User_Main.C: 61: if(Flash_BZ==0)
		BTSC 	7CH, 0H 		//012E 	287C
		LJUMP 	133H 			//012F 	3933

		//;User_Main.C: 62: {
		//;User_Main.C: 63: PB4 = 1;
		MOVLB 	0H 			//0130 	1020
		BSR 	DH, 4H 			//0131 	260D

		//;User_Main.C: 65: PB7 = 0;
		//;User_Main.C: 66: PC0 = 0;
		//;User_Main.C: 67: PA1 = 0;
		//;User_Main.C: 68: PA0 = 0;
		//;User_Main.C: 69: PB0 = 0;
		//;User_Main.C: 70: PB1 = 0;
		//;User_Main.C: 71: PD3 = 0;
		//;User_Main.C: 72: PD2 = 0;
		//;User_Main.C: 73: PD1 = 0;
		//;User_Main.C: 74: PC6 = 0;
		//;User_Main.C: 75: PC5 = 0;
		//;User_Main.C: 76: PC4 = 0;
		//;User_Main.C: 77: }
		LJUMP 	161H 			//0132 	3961

		//;User_Main.C: 78: else
		//;User_Main.C: 79: {
		//;User_Main.C: 80: PB4 = 0;
		MOVLB 	0H 			//0133 	1020
		BCR 	DH, 4H 			//0134 	220D
		LJUMP 	126H 			//0135 	3926

		//;User_Main.C: 97: case 2:
		//;User_Main.C: 93: PC4 = 1;
		//;User_Main.C: 92: PC5 = 1;
		//;User_Main.C: 91: PC6 = 1;
		//;User_Main.C: 90: PD1 = 1;
		//;User_Main.C: 89: PD2 = 1;
		//;User_Main.C: 88: PD3 = 1;
		//;User_Main.C: 87: PB1 = 1;
		//;User_Main.C: 86: PB0 = 1;
		//;User_Main.C: 85: PA0 = 1;
		//;User_Main.C: 84: PA1 = 1;
		//;User_Main.C: 83: PC0 = 1;
		//;User_Main.C: 82: PB7 = 1;
		//;User_Main.C: 98: TRISB5 = 1;
		MOVLB 	1H 			//0136 	1021
		BSR 	DH, 5H 			//0137 	268D

		//;User_Main.C: 99: TRISB4 = 1;
		BSR 	DH, 4H 			//0138 	260D

		//;User_Main.C: 100: TRISB2 = 1;
		BSR 	DH, 2H 			//0139 	250D

		//;User_Main.C: 102: TRISB3 = 0;
		BCR 	DH, 3H 			//013A 	218D

		//;User_Main.C: 103: if(Flash_BZ==0)
		BTSC 	7CH, 0H 		//013B 	287C
		LJUMP 	140H 			//013C 	3940

		//;User_Main.C: 104: {
		//;User_Main.C: 105: PB3 = 1;
		MOVLB 	0H 			//013D 	1020
		BSR 	DH, 3H 			//013E 	258D

		//;User_Main.C: 107: PB7 = 0;
		//;User_Main.C: 108: PC0 = 0;
		//;User_Main.C: 109: PA1 = 0;
		//;User_Main.C: 110: PA0 = 0;
		//;User_Main.C: 111: PB0 = 0;
		//;User_Main.C: 112: PB1 = 0;
		//;User_Main.C: 113: PD3 = 0;
		//;User_Main.C: 114: PD2 = 0;
		//;User_Main.C: 115: PD1 = 0;
		//;User_Main.C: 116: PC6 = 0;
		//;User_Main.C: 117: PC5 = 0;
		//;User_Main.C: 118: PC4 = 0;
		//;User_Main.C: 120: }
		LJUMP 	161H 			//013F 	3961

		//;User_Main.C: 121: else
		//;User_Main.C: 122: {
		//;User_Main.C: 124: PB3 = 0;
		MOVLB 	0H 			//0140 	1020
		BCR 	DH, 3H 			//0141 	218D
		LJUMP 	126H 			//0142 	3926

		//;User_Main.C: 141: case 3:
		//;User_Main.C: 137: PC4 = 1;
		//;User_Main.C: 136: PC5 = 1;
		//;User_Main.C: 135: PC6 = 1;
		//;User_Main.C: 134: PD1 = 1;
		//;User_Main.C: 133: PD2 = 1;
		//;User_Main.C: 132: PD3 = 1;
		//;User_Main.C: 131: PB1 = 1;
		//;User_Main.C: 130: PB0 = 1;
		//;User_Main.C: 129: PA0 = 1;
		//;User_Main.C: 128: PA1 = 1;
		//;User_Main.C: 127: PC0 = 1;
		//;User_Main.C: 126: PB7 = 1;
		//;User_Main.C: 142: TRISB5 = 1;
		MOVLB 	1H 			//0143 	1021
		BSR 	DH, 5H 			//0144 	268D

		//;User_Main.C: 143: TRISB4 = 1;
		BSR 	DH, 4H 			//0145 	260D

		//;User_Main.C: 144: TRISB3 = 1;
		BSR 	DH, 3H 			//0146 	258D

		//;User_Main.C: 146: TRISB2 = 0;
		BCR 	DH, 2H 			//0147 	210D

		//;User_Main.C: 147: if(Flash_BZ==0)
		BTSC 	7CH, 0H 		//0148 	287C
		LJUMP 	14DH 			//0149 	394D

		//;User_Main.C: 148: {
		//;User_Main.C: 149: PB2 = 1;
		MOVLB 	0H 			//014A 	1020
		BSR 	DH, 2H 			//014B 	250D

		//;User_Main.C: 151: PB7 = 0;
		//;User_Main.C: 152: PC0 = 0;
		//;User_Main.C: 153: PA1 = 0;
		//;User_Main.C: 154: PA0 = 0;
		//;User_Main.C: 155: PB0 = 0;
		//;User_Main.C: 156: PB1 = 0;
		//;User_Main.C: 157: PD3 = 0;
		//;User_Main.C: 158: PD2 = 0;
		//;User_Main.C: 159: PD1 = 0;
		//;User_Main.C: 160: PC6 = 0;
		//;User_Main.C: 161: PC5 = 0;
		//;User_Main.C: 162: PC4 = 0;
		//;User_Main.C: 163: }
		LJUMP 	161H 			//014C 	3961

		//;User_Main.C: 164: else
		//;User_Main.C: 165: {
		//;User_Main.C: 166: PB2 = 0;
		MOVLB 	0H 			//014D 	1020
		BCR 	DH, 2H 			//014E 	210D

		//;User_Main.C: 168: PB7 = 1;
		//;User_Main.C: 169: PC0 = 1;
		//;User_Main.C: 170: PA1 = 1;
		//;User_Main.C: 171: PA0 = 1;
		//;User_Main.C: 172: PB0 = 1;
		//;User_Main.C: 173: PB1 = 1;
		//;User_Main.C: 174: PD3 = 1;
		//;User_Main.C: 175: PD2 = 1;
		//;User_Main.C: 176: PD1 = 1;
		//;User_Main.C: 177: PC6 = 1;
		//;User_Main.C: 178: PC5 = 1;
		//;User_Main.C: 179: PC4 = 1;
		LCALL 	16EH 			//014F 	316E

		//;User_Main.C: 180: Flash_Code=0;
		CLRF 	7DH 			//0150 	11FD
		RET 					//0151 	1008
		LDR 	7DH, 0H 			//0152 	187D
		XORWI 	0H 			//0153 	0A00
		BTSC 	3H, 2H 			//0154 	2903
		LJUMP 	11AH 			//0155 	391A
		XORWI 	1H 			//0156 	0A01
		BTSC 	3H, 2H 			//0157 	2903
		LJUMP 	129H 			//0158 	3929
		XORWI 	3H 			//0159 	0A03
		BTSC 	3H, 2H 			//015A 	2903
		LJUMP 	136H 			//015B 	3936
		XORWI 	1H 			//015C 	0A01
		BTSC 	3H, 2H 			//015D 	2903
		LJUMP 	143H 			//015E 	3943
		LJUMP 	160H 			//015F 	3960
		RET 					//0160 	1008
		BCR 	DH, 7H 			//0161 	238D
		BCR 	EH, 0H 			//0162 	200E
		BCR 	CH, 1H 			//0163 	208C
		BCR 	CH, 0H 			//0164 	200C
		BCR 	DH, 0H 			//0165 	200D
		BCR 	DH, 1H 			//0166 	208D
		BCR 	FH, 3H 			//0167 	218F
		BCR 	FH, 2H 			//0168 	210F
		BCR 	FH, 1H 			//0169 	208F
		BCR 	EH, 6H 			//016A 	230E
		BCR 	EH, 5H 			//016B 	228E
		BCR 	EH, 4H 			//016C 	220E
		RET 					//016D 	1008
		BSR 	DH, 7H 			//016E 	278D
		BSR 	EH, 0H 			//016F 	240E
		BSR 	CH, 1H 			//0170 	248C
		BSR 	CH, 0H 			//0171 	240C
		BSR 	DH, 0H 			//0172 	240D
		BSR 	DH, 1H 			//0173 	248D
		BSR 	FH, 3H 			//0174 	258F
		BSR 	FH, 2H 			//0175 	250F
		BSR 	FH, 1H 			//0176 	248F
		BSR 	EH, 6H 			//0177 	270E
		BSR 	EH, 5H 			//0178 	268E
		BSR 	EH, 4H 			//0179 	260E
		RET 					//017A 	1008
			END
