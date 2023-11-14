//Deviec:FT62F08X
//-----------------------Variable---------------------------------
		_adcData		EQU		24H
		_theVoltage		EQU		20H
//		___lmul@product		EQU		78H
//		___lmul@multiplier		EQU		70H
//		___lmul@multiplicand		EQU		74H
//		GET_ADC_DATA@adcChannel		EQU		75H
//		GET_ADC_DATA@adcChannel		EQU		75H
//		GET_ADC_DATA@adcChannel		EQU		75H
//		DelayUs@Time		EQU		70H
//		DelayUs@a		EQU		71H
//		DelayUs@Time		EQU		70H
//		DelayUs@Time		EQU		70H
//-----------------------Variable END---------------------------------

		MOVLP 	0H 			//0000 	0180
		LJUMP 	8H 			//0001 	3808
		ORG		0003H
		NOP 					//0003 	1000
		BSR 	7EH, 0H 			//0004 	247E
		MOVLP 	0H 			//0005 	0180
		BCR 	7EH, 0H 			//0006 	207E
		RETI 					//0007 	1009
		MOVLP 	0H 			//0008 	0180
		LJUMP 	AH 			//0009 	380A
		MOVLB 	0H 			//000A 	1020
		CLRF 	20H 			//000B 	11A0
		CLRF 	21H 			//000C 	11A1
		CLRF 	22H 			//000D 	11A2
		CLRF 	23H 			//000E 	11A3
		CLRF 	24H 			//000F 	11A4
		CLRF 	25H 			//0010 	11A5
		CLRF 	26H 			//0011 	11A6
		CLRF 	27H 			//0012 	11A7
		BCR 	7EH, 0H 			//0013 	207E
		MOVLB 	0H 			//0014 	1020
		LJUMP 	16H 			//0015 	3816

		//;CurlingIron.C: 254: POWER_INITIAL();
		LCALL 	85H 			//0016 	3085
		MOVLP 	0H 			//0017 	0180

		//;CurlingIron.C: 255: ADC_INITIAL();
		LCALL 	4EH 			//0018 	304E
		MOVLP 	0H 			//0019 	0180

		//;CurlingIron.C: 257: while(1)
		//;CurlingIron.C: 258: {
		//;CurlingIron.C: 259: adcData = GET_ADC_DATA(4);
		LDWI 	4H 			//001A 	0004
		LCALL 	65H 			//001B 	3065
		MOVLP 	0H 			//001C 	0180
		LDR 	72H, 0H 			//001D 	1872
		MOVLB 	0H 			//001E 	1020
		STR 	24H 			//001F 	10A4
		LDR 	73H, 0H 			//0020 	1873
		STR 	25H 			//0021 	10A5
		CLRF 	26H 			//0022 	11A6
		CLRF 	27H 			//0023 	11A7

		//;CurlingIron.C: 260: theVoltage = (unsigned long)adcData*2*1000/4096;
		LSLF 	24H, 0H 		//0024 	0524
		STR 	70H 			//0025 	10F0
		RLR 	25H, 0H 			//0026 	1D25
		STR 	71H 			//0027 	10F1
		RLR 	26H, 0H 			//0028 	1D26
		STR 	72H 			//0029 	10F2
		RLR 	27H, 0H 			//002A 	1D27
		STR 	73H 			//002B 	10F3
		LDWI 	3H 			//002C 	0003
		CLRF 	77H 			//002D 	11F7
		CLRF 	76H 			//002E 	11F6
		STR 	75H 			//002F 	10F5
		LDWI 	E8H 			//0030 	00E8
		STR 	74H 			//0031 	10F4
		LCALL 	B0H 			//0032 	30B0
		MOVLP 	0H 			//0033 	0180
		LDR 	70H, 0H 			//0034 	1870
		STR 	28H 			//0035 	10A8
		LDR 	71H, 0H 			//0036 	1871
		STR 	29H 			//0037 	10A9
		LDR 	72H, 0H 			//0038 	1872
		STR 	2AH 			//0039 	10AA
		LDR 	73H, 0H 			//003A 	1873
		STR 	2BH 			//003B 	10AB
		LDWI 	CH 			//003C 	000C
		LSRF 	2BH, 1H 		//003D 	06AB
		RRR 	2AH, 1H 			//003E 	1CAA
		RRR 	29H, 1H 			//003F 	1CA9
		RRR 	28H, 1H 			//0040 	1CA8
		DECRSZ 	9H, 1H 		//0041 	1B89
		LJUMP 	3DH 			//0042 	383D
		LDR 	2BH, 0H 			//0043 	182B
		STR 	23H 			//0044 	10A3
		LDR 	2AH, 0H 			//0045 	182A
		STR 	22H 			//0046 	10A2
		LDR 	29H, 0H 			//0047 	1829
		STR 	21H 			//0048 	10A1
		LDR 	28H, 0H 			//0049 	1828
		STR 	20H 			//004A 	10A0

		//;CurlingIron.C: 261: __nop();
		NOP 					//004B 	1000

		//;CurlingIron.C: 262: __nop();
		NOP 					//004C 	1000
		LJUMP 	1AH 			//004D 	381A

		//;CurlingIron.C: 98: ANSELA = 0B00010000;
		LDWI 	10H 			//004E 	0010
		MOVLB 	3H 			//004F 	1023
		STR 	17H 			//0050 	1097

		//;CurlingIron.C: 100: ADCON1 = 0B11100101;
		LDWI 	E5H 			//0051 	00E5
		MOVLB 	1H 			//0052 	1021
		STR 	1EH 			//0053 	109E

		//;CurlingIron.C: 127: ADCON0 = 0B01000000;
		LDWI 	40H 			//0054 	0040
		STR 	1DH 			//0055 	109D

		//;CurlingIron.C: 159: ADCON2 = 0B01000000;
		STR 	1FH 			//0056 	109F

		//;CurlingIron.C: 187: ADCON3 = 0B00000000;
		MOVLB 	8H 			//0057 	1028
		CLRF 	1AH 			//0058 	119A

		//;CurlingIron.C: 214: ADDLY = 0B00000000;
		MOVLB 	0H 			//0059 	1020
		CLRF 	1FH 			//005A 	119F

		//;CurlingIron.C: 219: ADCMPH = 0B00000000;
		MOVLB 	8H 			//005B 	1028
		CLRF 	1BH 			//005C 	119B

		//;CurlingIron.C: 222: ADCAL=1;
		MOVLB 	1H 			//005D 	1021
		BSR 	1DH, 3H 			//005E 	259D

		//;CurlingIron.C: 223: __nop();
		NOP 					//005F 	1000

		//;CurlingIron.C: 224: while(ADCAL);
		MOVLB 	1H 			//0060 	1021
		BTSC 	1DH, 3H 		//0061 	299D
		LJUMP 	60H 			//0062 	3860

		//;CurlingIron.C: 226: ADON=1;
		BSR 	1DH, 0H 			//0063 	241D
		RET 					//0064 	1008
		STR 	75H 			//0065 	10F5

		//;CurlingIron.C: 236: ADCON0 &= 0B00001111;
		LDWI 	FH 			//0066 	000F
		MOVLB 	1H 			//0067 	1021
		ANDWR 	1DH, 1H 		//0068 	159D

		//;CurlingIron.C: 237: ADCON0 |= adcChannel<<4;
		SWAPR 	75H, 0H 		//0069 	1E75
		ANDWI 	F0H 			//006A 	09F0
		IORWR 	1DH, 1H 		//006B 	149D

		//;CurlingIron.C: 238: DelayUs(40);
		LDWI 	28H 			//006C 	0028
		LCALL 	7CH 			//006D 	307C
		MOVLP 	0H 			//006E 	0180

		//;CurlingIron.C: 239: GO = 1;
		MOVLB 	1H 			//006F 	1021
		BSR 	1DH, 1H 			//0070 	249D

		//;CurlingIron.C: 240: __nop();
		NOP 					//0071 	1000

		//;CurlingIron.C: 241: __nop();
		NOP 					//0072 	1000

		//;CurlingIron.C: 242: while(GO);
		MOVLB 	1H 			//0073 	1021
		BTSC 	1DH, 1H 		//0074 	289D
		LJUMP 	73H 			//0075 	3873

		//;CurlingIron.C: 244: return (unsigned int)(ADRESH<<8|ADRESL);
		LDR 	1CH, 0H 			//0076 	181C
		STR 	73H 			//0077 	10F3
		CLRF 	72H 			//0078 	11F2
		LDR 	1BH, 0H 			//0079 	181B
		IORWR 	72H, 1H 		//007A 	14F2
		RET 					//007B 	1008
		STR 	70H 			//007C 	10F0

		//;CurlingIron.C: 83: unsigned char a;
		//;CurlingIron.C: 84: for(a=0;a<Time;a++)
		CLRF 	71H 			//007D 	11F1
		LDR 	70H, 0H 			//007E 	1870
		SUBWR 	71H, 0H 		//007F 	1271
		BTSC 	3H, 0H 			//0080 	2803
		RET 					//0081 	1008

		//;CurlingIron.C: 85: {
		//;CurlingIron.C: 86: __nop();
		NOP 					//0082 	1000
		INCR 	71H, 1H 		//0083 	1AF1
		LJUMP 	7EH 			//0084 	387E

		//;CurlingIron.C: 30: OSCCON = 0B01110001;
		LDWI 	71H 			//0085 	0071
		MOVLB 	1H 			//0086 	1021
		STR 	19H 			//0087 	1099

		//;CurlingIron.C: 37: PCKEN |=0B00000001;
		BSR 	1AH, 0H 			//0088 	241A

		//;CurlingIron.C: 39: INTCON = 0;
		CLRF 	BH 			//0089 	118B

		//;CurlingIron.C: 41: PORTA = 0B00000000;
		MOVLB 	0H 			//008A 	1020
		CLRF 	CH 			//008B 	118C

		//;CurlingIron.C: 42: TRISA = 0B11111111;
		LDWI 	FFH 			//008C 	00FF
		MOVLB 	1H 			//008D 	1021
		STR 	CH 			//008E 	108C

		//;CurlingIron.C: 43: PORTB = 0B00000000;
		MOVLB 	0H 			//008F 	1020
		CLRF 	DH 			//0090 	118D

		//;CurlingIron.C: 44: TRISB = 0B11111111;
		MOVLB 	1H 			//0091 	1021
		STR 	DH 			//0092 	108D

		//;CurlingIron.C: 45: PORTC = 0B00000000;
		MOVLB 	0H 			//0093 	1020
		CLRF 	EH 			//0094 	118E

		//;CurlingIron.C: 46: TRISC = 0B11111111;
		MOVLB 	1H 			//0095 	1021
		STR 	EH 			//0096 	108E

		//;CurlingIron.C: 47: PORTD = 0B00000000;
		MOVLB 	0H 			//0097 	1020
		CLRF 	FH 			//0098 	118F

		//;CurlingIron.C: 48: TRISD = 0B11111111;
		MOVLB 	1H 			//0099 	1021
		STR 	FH 			//009A 	108F

		//;CurlingIron.C: 50: WPUA = 0B00000000;
		MOVLB 	3H 			//009B 	1023
		CLRF 	CH 			//009C 	118C

		//;CurlingIron.C: 51: WPUB = 0B00000000;
		CLRF 	DH 			//009D 	118D

		//;CurlingIron.C: 52: WPUC = 0B00000000;
		CLRF 	EH 			//009E 	118E

		//;CurlingIron.C: 53: WPUD = 0B00000000;
		CLRF 	FH 			//009F 	118F

		//;CurlingIron.C: 55: WPDA = 0B00000000;
		MOVLB 	4H 			//00A0 	1024
		CLRF 	CH 			//00A1 	118C

		//;CurlingIron.C: 56: WPDB = 0B00000000;
		CLRF 	DH 			//00A2 	118D

		//;CurlingIron.C: 57: WPDC = 0B00000000;
		CLRF 	EH 			//00A3 	118E

		//;CurlingIron.C: 58: WPDD = 0B00000000;
		CLRF 	FH 			//00A4 	118F

		//;CurlingIron.C: 60: PSRC0 = 0B11111111;
		MOVLB 	2H 			//00A5 	1022
		STR 	1AH 			//00A6 	109A

		//;CurlingIron.C: 64: PSRC1 = 0B11111111;
		STR 	1BH 			//00A7 	109B

		//;CurlingIron.C: 68: PSINK0 = 0B11111111;
		MOVLB 	3H 			//00A8 	1023
		STR 	1AH 			//00A9 	109A

		//;CurlingIron.C: 69: PSINK1 = 0B11111111;
		STR 	1BH 			//00AA 	109B

		//;CurlingIron.C: 70: PSINK2 = 0B11111111;
		STR 	1CH 			//00AB 	109C

		//;CurlingIron.C: 71: PSINK3 = 0B11111111;
		STR 	1DH 			//00AC 	109D

		//;CurlingIron.C: 73: TRISA6 = 1;
		MOVLB 	1H 			//00AD 	1021
		BSR 	CH, 6H 			//00AE 	270C
		RET 					//00AF 	1008
		CLRF 	78H 			//00B0 	11F8
		CLRF 	79H 			//00B1 	11F9
		CLRF 	7AH 			//00B2 	11FA
		CLRF 	7BH 			//00B3 	11FB
		BTSS 	70H, 0H 		//00B4 	2C70
		LJUMP 	BEH 			//00B5 	38BE
		LDR 	74H, 0H 			//00B6 	1874
		ADDWR 	78H, 1H 		//00B7 	17F8
		LDR 	75H, 0H 			//00B8 	1875
		ADDWFC 	79H, 1H 		//00B9 	0DF9
		LDR 	76H, 0H 			//00BA 	1876
		ADDWFC 	7AH, 1H 		//00BB 	0DFA
		LDR 	77H, 0H 			//00BC 	1877
		ADDWFC 	7BH, 1H 		//00BD 	0DFB
		LSLF 	74H, 1H 		//00BE 	05F4
		RLR 	75H, 1H 			//00BF 	1DF5
		RLR 	76H, 1H 			//00C0 	1DF6
		RLR 	77H, 1H 			//00C1 	1DF7
		LSRF 	73H, 1H 		//00C2 	06F3
		RRR 	72H, 1H 			//00C3 	1CF2
		RRR 	71H, 1H 			//00C4 	1CF1
		RRR 	70H, 1H 			//00C5 	1CF0
		LDR 	73H, 0H 			//00C6 	1873
		IORWR 	72H, 0H 		//00C7 	1472
		IORWR 	71H, 0H 		//00C8 	1471
		IORWR 	70H, 0H 		//00C9 	1470
		BTSS 	3H, 2H 			//00CA 	2D03
		LJUMP 	B4H 			//00CB 	38B4
		LDR 	7BH, 0H 			//00CC 	187B
		STR 	73H 			//00CD 	10F3
		LDR 	7AH, 0H 			//00CE 	187A
		STR 	72H 			//00CF 	10F2
		LDR 	79H, 0H 			//00D0 	1879
		STR 	71H 			//00D1 	10F1
		LDR 	78H, 0H 			//00D2 	1878
		STR 	70H 			//00D3 	10F0
		RET 					//00D4 	1008
			END
