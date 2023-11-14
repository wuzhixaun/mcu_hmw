//Deviec:FT62F08X
//-----------------------Variable---------------------------------
		_BZ_1A		EQU		76H
		_BZ_1B		EQU		76H
		_BZ_1C		EQU		76H
		_BZ_1D		EQU		76H
		_BZ_1E		EQU		75H
		_BZ_1F		EQU		75H
		_BZ_1G		EQU		75H
		_BZ_2A		EQU		75H
		_BZ_2B		EQU		75H
		_BZ_2C		EQU		75H
		_BZ_2D		EQU		75H
		_BZ_2E		EQU		75H
		_BZ_2F		EQU		74H
		_BZ_2G		EQU		74H
		_BZ_3A		EQU		74H
		_BZ_3B		EQU		74H
		_BZ_3C		EQU		74H
		_BZ_3D		EQU		74H
		_BZ_3E		EQU		74H
		_BZ_3F		EQU		74H
		_BZ_3G		EQU		73H
		_BZ_4A		EQU		73H
		_BZ_4B		EQU		73H
		_BZ_4C		EQU		73H
		_BZ_4D		EQU		73H
		_BZ_4E		EQU		73H
		_BZ_4F		EQU		73H
		_BZ_4G		EQU		73H
		_BZ_5A		EQU		72H
		_BZ_5B		EQU		72H
		_BZ_5C		EQU		72H
		_BZ_5D		EQU		72H
		_BZ_5E		EQU		72H
		_BZ_5F		EQU		72H
		_BZ_5G		EQU		72H
		_BZ_T1		EQU		72H
		_BZ_T2		EQU		71H
		_BZ_T3		EQU		71H
		_BZ_S1		EQU		71H
		_BZ_S2		EQU		71H
		_BZ_S3		EQU		71H
		_BZ_S4		EQU		71H
		_BZ_S5		EQU		71H
		_BZ_S6		EQU		71H
		_BZ_S7		EQU		70H
		_BZ_S8		EQU		70H
		_BZ_S9		EQU		70H
		_BZ_S10		EQU		70H
		_BZ_S11		EQU		70H
		_BZ_S12		EQU		70H
		_BZ_S13		EQU		70H
		_BZ_S14		EQU		70H
		_Step		EQU		77H
//-----------------------Variable END---------------------------------

		MOVLP 	0H 			//0000 	0180
		LJUMP 	FH 			//0001 	380F
		ORG		0003H
		NOP 					//0003 	1000
		BSR 	7EH, 0H 			//0004 	247E
		MOVLP 	0H 			//0005 	0180

		//;Lcd.C: 55: if(T2UIE && T2UIF)
		MOVLB 	6H 			//0006 	1026
		BTSC 	DH, 0H 			//0007 	280D
		BTSS 	EH, 0H 			//0008 	2C0E
		LJUMP 	DH 			//0009 	380D

		//;Lcd.C: 56: {
		//;Lcd.C: 57: T2UIF = 1;
		BSR 	EH, 0H 			//000A 	240E

		//;Lcd.C: 58: LCD_Flash();
		MOVLP 	0H 			//000B 	0180
		LCALL 	67H 			//000C 	3067
		BCR 	7EH, 0H 			//000D 	207E
		RETI 					//000E 	1009
		MOVLP 	0H 			//000F 	0180
		LJUMP 	11H 			//0010 	3811
		CLRF 	70H 			//0011 	11F0
		CLRF 	71H 			//0012 	11F1
		CLRF 	72H 			//0013 	11F2
		CLRF 	73H 			//0014 	11F3
		CLRF 	74H 			//0015 	11F4
		CLRF 	75H 			//0016 	11F5
		CLRF 	76H 			//0017 	11F6
		CLRF 	77H 			//0018 	11F7
		BCR 	7EH, 0H 			//0019 	207E
		MOVLB 	0H 			//001A 	1020
		LJUMP 	1CH 			//001B 	381C

		//;Lcd.C: 408: POWER_INITIAL();
		LCALL 	22H 			//001C 	3022
		MOVLP 	0H 			//001D 	0180

		//;Lcd.C: 409: Time2Initial();
		LCALL 	4DH 			//001E 	304D
		MOVLP 	0H 			//001F 	0180

		//;Lcd.C: 412: {
		//;Lcd.C: 413: __nop();
		NOP 					//0020 	1000
		LJUMP 	20H 			//0021 	3820

		//;Lcd.C: 70: OSCCON = 0B01110001;
		LDWI 	71H 			//0022 	0071
		MOVLB 	1H 			//0023 	1021
		STR 	19H 			//0024 	1099

		//;Lcd.C: 73: INTCON = 0B01000000;
		LDWI 	40H 			//0025 	0040
		STR 	BH 			//0026 	108B

		//;Lcd.C: 75: PORTA = 0B00000000;
		MOVLB 	0H 			//0027 	1020
		CLRF 	CH 			//0028 	118C

		//;Lcd.C: 76: TRISA = 0B00000000;
		MOVLB 	1H 			//0029 	1021
		CLRF 	CH 			//002A 	118C

		//;Lcd.C: 77: PORTB = 0B00000000;
		MOVLB 	0H 			//002B 	1020
		CLRF 	DH 			//002C 	118D

		//;Lcd.C: 78: TRISB = 0B00000000;
		MOVLB 	1H 			//002D 	1021
		CLRF 	DH 			//002E 	118D

		//;Lcd.C: 79: PORTC = 0B00000000;
		MOVLB 	0H 			//002F 	1020
		CLRF 	EH 			//0030 	118E

		//;Lcd.C: 80: TRISC = 0B00000000;
		MOVLB 	1H 			//0031 	1021
		CLRF 	EH 			//0032 	118E

		//;Lcd.C: 81: PORTD = 0B00000000;
		MOVLB 	0H 			//0033 	1020
		CLRF 	FH 			//0034 	118F

		//;Lcd.C: 82: TRISD = 0B00000000;
		MOVLB 	1H 			//0035 	1021
		CLRF 	FH 			//0036 	118F

		//;Lcd.C: 84: WPUA = 0B00000000;
		MOVLB 	3H 			//0037 	1023
		CLRF 	CH 			//0038 	118C

		//;Lcd.C: 85: WPUB = 0B00000000;
		CLRF 	DH 			//0039 	118D

		//;Lcd.C: 86: WPUC = 0B00001000;
		LDWI 	8H 			//003A 	0008
		STR 	EH 			//003B 	108E

		//;Lcd.C: 87: WPUD = 0B00000000;
		CLRF 	FH 			//003C 	118F

		//;Lcd.C: 89: WPDA = 0B00000000;
		MOVLB 	4H 			//003D 	1024
		CLRF 	CH 			//003E 	118C

		//;Lcd.C: 90: WPDB = 0B00000000;
		CLRF 	DH 			//003F 	118D

		//;Lcd.C: 91: WPDC = 0B00000000;
		CLRF 	EH 			//0040 	118E

		//;Lcd.C: 92: WPDD = 0B00000000;
		CLRF 	FH 			//0041 	118F

		//;Lcd.C: 94: PSRC0 = 0B11111111;
		LDWI 	FFH 			//0042 	00FF
		MOVLB 	2H 			//0043 	1022
		STR 	1AH 			//0044 	109A

		//;Lcd.C: 98: PSRC1 = 0B11111111;
		STR 	1BH 			//0045 	109B

		//;Lcd.C: 102: PSINK0 = 0B11111111;
		MOVLB 	3H 			//0046 	1023
		STR 	1AH 			//0047 	109A

		//;Lcd.C: 103: PSINK1 = 0B11111111;
		STR 	1BH 			//0048 	109B

		//;Lcd.C: 104: PSINK2 = 0B11111111;
		STR 	1CH 			//0049 	109C

		//;Lcd.C: 105: PSINK3 = 0B11111111;
		STR 	1DH 			//004A 	109D

		//;Lcd.C: 107: ANSELA = 0B00000000;
		CLRF 	17H 			//004B 	1197
		RET 					//004C 	1008

		//;Lcd.C: 166: PCKEN |=0B00000100;
		MOVLB 	1H 			//004D 	1021
		BSR 	1AH, 2H 			//004E 	251A

		//;Lcd.C: 167: CKOCON=0B00100000;
		LDWI 	20H 			//004F 	0020
		STR 	15H 			//0050 	1095

		//;Lcd.C: 168: TCKSRC=0B00110000;
		LDWI 	30H 			//0051 	0030
		MOVLB 	6H 			//0052 	1026
		STR 	1FH 			//0053 	109F

		//;Lcd.C: 192: TIM2PSCR=0B00000010;
		LDWI 	2H 			//0054 	0002
		STR 	18H 			//0055 	1098

		//;Lcd.C: 193: TIM2CR1 =0B10000101;
		LDWI 	85H 			//0056 	0085
		STR 	CH 			//0057 	108C

		//;Lcd.C: 226: TIM2IER =0B00000001;
		LDWI 	1H 			//0058 	0001
		STR 	DH 			//0059 	108D

		//;Lcd.C: 385: TIM2ARRH =0x09;
		LDWI 	9H 			//005A 	0009
		STR 	19H 			//005B 	1099

		//;Lcd.C: 386: TIM2ARRL =0xC4;
		LDWI 	C4H 			//005C 	00C4
		STR 	1AH 			//005D 	109A

		//;Lcd.C: 389: TIM2CCR1H =0x00;
		CLRF 	1BH 			//005E 	119B

		//;Lcd.C: 390: TIM2CCR1L =0x00;
		CLRF 	1CH 			//005F 	119C

		//;Lcd.C: 392: TIM2CCR2H =0x00;
		CLRF 	1DH 			//0060 	119D

		//;Lcd.C: 393: TIM2CCR2L =0x00;
		CLRF 	1EH 			//0061 	119E

		//;Lcd.C: 395: TIM2CCR3H =0B00000000;
		MOVLB 	5H 			//0062 	1025
		CLRF 	1EH 			//0063 	119E

		//;Lcd.C: 396: TIM2CCR3L =0B00000000;
		CLRF 	1FH 			//0064 	119F

		//;Lcd.C: 398: GIE =1;
		BSR 	BH, 7H 			//0065 	278B
		RET 					//0066 	1008

		//;Lcd.C: 5: TRISB5=1;WPUB5=1;WPDB5=1;;
		MOVLB 	1H 			//0067 	1021
		BSR 	DH, 5H 			//0068 	268D
		MOVLB 	3H 			//0069 	1023
		BSR 	DH, 5H 			//006A 	268D
		MOVLB 	4H 			//006B 	1024
		BSR 	DH, 5H 			//006C 	268D

		//;Lcd.C: 6: TRISB4=1;WPUB4=1;WPDB4=1;;
		MOVLB 	1H 			//006D 	1021
		BSR 	DH, 4H 			//006E 	260D
		MOVLB 	3H 			//006F 	1023
		BSR 	DH, 4H 			//0070 	260D
		MOVLB 	4H 			//0071 	1024
		BSR 	DH, 4H 			//0072 	260D

		//;Lcd.C: 7: TRISB3=1;WPUB3=1;WPDB3=1;;
		MOVLB 	1H 			//0073 	1021
		BSR 	DH, 3H 			//0074 	258D
		MOVLB 	3H 			//0075 	1023
		BSR 	DH, 3H 			//0076 	258D
		MOVLB 	4H 			//0077 	1024
		BSR 	DH, 3H 			//0078 	258D

		//;Lcd.C: 8: TRISB2=1;WPUB2=1;WPDB2=1;;
		MOVLB 	1H 			//0079 	1021
		BSR 	DH, 2H 			//007A 	250D
		MOVLB 	3H 			//007B 	1023
		BSR 	DH, 2H 			//007C 	250D
		MOVLB 	4H 			//007D 	1024
		BSR 	DH, 2H 			//007E 	250D

		//;Lcd.C: 9: __nop();
		NOP 					//007F 	1000

		//;Lcd.C: 10: __nop();
		NOP 					//0080 	1000

		//;Lcd.C: 11: Step++;
		INCR 	77H, 1H 		//0081 	1AF7

		//;Lcd.C: 12: if(Step==1)
		DECRSZ 	77H, 0H 		//0082 	1B77
		LJUMP 	90H 			//0083 	3890

		//;Lcd.C: 13: {
		//;Lcd.C: 14: if(BZ_S5) PB6=0; else PB6=1;
		BTSS 	71H, 1H 		//0084 	2CF1
		LJUMP 	89H 			//0085 	3889
		MOVLB 	0H 			//0086 	1020
		BCR 	DH, 6H 			//0087 	230D
		LJUMP 	8BH 			//0088 	388B
		MOVLB 	0H 			//0089 	1020
		BSR 	DH, 6H 			//008A 	270D

		//;Lcd.C: 16: TRISB5=0;PB5=1;
		MOVLB 	1H 			//008B 	1021
		BCR 	DH, 5H 			//008C 	228D
		MOVLB 	0H 			//008D 	1020
		BSR 	DH, 5H 			//008E 	268D

		//;Lcd.C: 17: }
		RET 					//008F 	1008

		//;Lcd.C: 18: else if(Step==2)
		LDWI 	2H 			//0090 	0002
		XORWR 	77H, 0H 		//0091 	1677
		BTSS 	3H, 2H 			//0092 	2D03
		LJUMP 	A0H 			//0093 	38A0

		//;Lcd.C: 19: {
		//;Lcd.C: 20: if(BZ_S5==0) PB6=0; else PB6=1;
		BTSC 	71H, 1H 		//0094 	28F1
		LJUMP 	99H 			//0095 	3899
		MOVLB 	0H 			//0096 	1020
		BCR 	DH, 6H 			//0097 	230D
		LJUMP 	9BH 			//0098 	389B
		MOVLB 	0H 			//0099 	1020
		BSR 	DH, 6H 			//009A 	270D

		//;Lcd.C: 22: TRISB5=0;PB5=0;
		MOVLB 	1H 			//009B 	1021
		BCR 	DH, 5H 			//009C 	228D
		MOVLB 	0H 			//009D 	1020
		BCR 	DH, 5H 			//009E 	228D

		//;Lcd.C: 23: }
		RET 					//009F 	1008

		//;Lcd.C: 24: else if(Step==3)
		LDWI 	3H 			//00A0 	0003
		XORWR 	77H, 0H 		//00A1 	1677
		BTSC 	3H, 2H 			//00A2 	2903
		RET 					//00A3 	1008

		//;Lcd.C: 28: else if(Step==4)
		LDWI 	4H 			//00A4 	0004
		XORWR 	77H, 0H 		//00A5 	1677
		BTSC 	3H, 2H 			//00A6 	2903
		RET 					//00A7 	1008

		//;Lcd.C: 32: else if(Step==5)
		LDWI 	5H 			//00A8 	0005
		XORWR 	77H, 0H 		//00A9 	1677
		BTSC 	3H, 2H 			//00AA 	2903
		RET 					//00AB 	1008

		//;Lcd.C: 36: else if(Step==6)
		LDWI 	6H 			//00AC 	0006
		XORWR 	77H, 0H 		//00AD 	1677
		BTSC 	3H, 2H 			//00AE 	2903
		RET 					//00AF 	1008

		//;Lcd.C: 40: else if(Step==7)
		LDWI 	7H 			//00B0 	0007
		XORWR 	77H, 0H 		//00B1 	1677
		BTSS 	3H, 2H 			//00B2 	2D03

		//;Lcd.C: 44: else{
		//;Lcd.C: 46: Step=0;
		CLRF 	77H 			//00B3 	11F7
		RET 					//00B4 	1008
			END
