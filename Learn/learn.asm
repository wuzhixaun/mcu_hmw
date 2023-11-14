//Deviec:FT62F08X
//-----------------------Variable---------------------------------
		_cout		EQU		2DH
		_W_TMP		EQU		70H
		_BSR_TMP		EQU		71H
//		___llmod@counter		EQU		7AH
//		___llmod@divisor		EQU		72H
//		___llmod@dividend		EQU		76H
//		___lldiv@quotient		EQU		28H
//		___lldiv@counter		EQU		2CH
//		___lldiv@divisor		EQU		20H
//		___lldiv@dividend		EQU		24H
//		ReadTemperature@wd		EQU		2BH
//		ReadTemperature@temperature		EQU		23H
//		ReadTemperature@TX		EQU		2AH
//		ReadTemperature@TZ		EQU		29H
//		ReadTemperature@TLV		EQU		28H
//		ReadTemperature@shi		EQU		27H
//		ReadTemperature@ge		EQU		26H
//		ReadTemperature@THV		EQU		25H
//		___wmul@product		EQU		76H
//		___wmul@multiplier		EQU		72H
//		___wmul@multiplicand		EQU		74H
//		___lwmod@counter		EQU		76H
//		___lwmod@divisor		EQU		72H
//		___lwmod@dividend		EQU		74H
//		___lwdiv@quotient		EQU		7BH
//		___lwdiv@counter		EQU		7DH
//		___lwdiv@divisor		EQU		77H
//		___lwdiv@dividend		EQU		79H
//		___lbmod@dividend		EQU		74H
//		___lbmod@rem		EQU		76H
//		___lbmod@counter		EQU		75H
//		___lbmod@dividend		EQU		74H
//		___lbmod@divisor		EQU		72H
//		___lbmod@dividend		EQU		74H
//		___lbdiv@dividend		EQU		73H
//		___lbdiv@quotient		EQU		75H
//		___lbdiv@counter		EQU		74H
//		___lbdiv@dividend		EQU		73H
//		___lbdiv@divisor		EQU		72H
//		___lbdiv@dividend		EQU		73H
//		WriteOneChar@dat		EQU		74H
//		WriteOneChar@i		EQU		76H
//		WriteOneChar@temp		EQU		75H
//		WriteOneChar@dat		EQU		74H
//		WriteOneChar@dat		EQU		74H
//		ReadOneChar@i		EQU		75H
//		ReadOneChar@dat		EQU		74H
//		ReadOneChar@j		EQU		31H
//		Init_DS18B20@presence		EQU		75H
//		Init_DS18B20@cnt		EQU		74H
//		Write_Max7219@address		EQU		7CH
//		Write_Max7219@address		EQU		7CH
//		Write_Max7219@dat		EQU		7BH
//		Write_Max7219@address		EQU		7CH
//		Write_Max7219_byte@DATA		EQU		72H
//		Write_Max7219_byte@i		EQU		73H
//		Write_Max7219_byte@DATA		EQU		72H
//		Write_Max7219_byte@DATA		EQU		72H
//		DelayS@Time		EQU		77H
//		DelayS@b		EQU		79H
//		DelayS@a		EQU		78H
//		DelayS@Time		EQU		77H
//		DelayS@Time		EQU		77H
//		DelayMs@Time		EQU		74H
//		DelayMs@b		EQU		76H
//		DelayMs@a		EQU		75H
//		DelayMs@Time		EQU		74H
//		DelayMs@Time		EQU		74H
//		DelayUs@Time		EQU		72H
//		DelayUs@a		EQU		73H
//		DelayUs@Time		EQU		72H
//		DelayUs@Time		EQU		72H
//-----------------------Variable END---------------------------------

		MOVLP 	0H 			//0000 	0180
		LJUMP 	DH 			//0001 	380D
		ORG		0003H
		NOP 					//0003 	1000
		BSR 	7EH, 0H 			//0004 	247E
		MOVLP 	0H 			//0005 	0180

		//;Learn.C: 64: if(T4UIE && T4UIF)
		MOVLB 	2H 			//0006 	1022
		BTSC 	12H, 0H 		//0007 	2812
		BTSS 	13H, 0H 		//0008 	2C13
		LJUMP 	BH 			//0009 	380B

		//;Learn.C: 71: IRbitTime3 ++;
		BSR 	13H, 0H 			//000A 	2413
		BCR 	7EH, 0H 			//000B 	207E
		RETI 					//000C 	1009
		MOVLP 	0H 			//000D 	0180
		LJUMP 	FH 			//000E 	380F
		MOVLB 	0H 			//000F 	1020
		CLRF 	2DH 			//0010 	11AD
		CLRF 	2EH 			//0011 	11AE
		CLRF 	2FH 			//0012 	11AF
		CLRF 	30H 			//0013 	11B0
		CLRF 	31H 			//0014 	11B1
		BCR 	7EH, 0H 			//0015 	207E
		MOVLB 	0H 			//0016 	1020
		LJUMP 	30H 			//0017 	3830

		//;Learn.C: 336: Write_Max7219(0x09, 0xff);
		LDWI 	FFH 			//0018 	00FF
		STR 	7BH 			//0019 	10FB
		LDWI 	9H 			//001A 	0009
		LCALL 	83H 			//001B 	3083
		MOVLP 	0H 			//001C 	0180

		//;Learn.C: 337: Write_Max7219(0x0a, 0x03);
		LDWI 	3H 			//001D 	0003
		STR 	7BH 			//001E 	10FB
		LDWI 	AH 			//001F 	000A
		LCALL 	83H 			//0020 	3083
		MOVLP 	0H 			//0021 	0180

		//;Learn.C: 338: Write_Max7219(0x0b, 0x07);
		LDWI 	7H 			//0022 	0007
		STR 	7BH 			//0023 	10FB
		LDWI 	BH 			//0024 	000B
		LCALL 	83H 			//0025 	3083
		MOVLP 	0H 			//0026 	0180
		LDWI 	CH 			//0027 	000C

		//;Learn.C: 339: Write_Max7219(0x0c, 0x01);
		CLRF 	7BH 			//0028 	11FB
		INCR 	7BH, 1H 		//0029 	1AFB
		LCALL 	83H 			//002A 	3083
		MOVLP 	0H 			//002B 	0180
		LDWI 	FH 			//002C 	000F

		//;Learn.C: 340: Write_Max7219(0x0f, 0x01);
		CLRF 	7BH 			//002D 	11FB
		INCR 	7BH, 1H 		//002E 	1AFB
		LJUMP 	83H 			//002F 	3883

		//;Learn.C: 635: POWER_INITIAL();
		LCALL 	283H 			//0030 	3283
		MOVLP 	0H 			//0031 	0180

		//;Learn.C: 638: Init_MAX7219();
		LCALL 	18H 			//0032 	3018
		MOVLP 	0H 			//0033 	0180

		//;Learn.C: 639: DelayMs(100);
		LDWI 	64H 			//0034 	0064
		LCALL 	261H 			//0035 	3261
		MOVLP 	0H 			//0036 	0180
		LDWI 	FH 			//0037 	000F

		//;Learn.C: 640: Write_Max7219(0x0f, 0x00);
		CLRF 	7BH 			//0038 	11FB
		LCALL 	83H 			//0039 	3083
		MOVLP 	0H 			//003A 	0180

		//;Learn.C: 642: while(1)
		//;Learn.C: 643: {
		//;Learn.C: 644: Write_Max7219(1,cout/100);
		LDWI 	64H 			//003B 	0064
		MOVLB 	0H 			//003C 	1020
		LCALL 	30CH 			//003D 	330C
		MOVLP 	0H 			//003E 	0180
		LDR 	30H, 0H 			//003F 	1830
		STR 	27H 			//0040 	10A7
		LDR 	2FH, 0H 			//0041 	182F
		STR 	26H 			//0042 	10A6
		LDR 	2EH, 0H 			//0043 	182E
		STR 	25H 			//0044 	10A5
		LDR 	2DH, 0H 			//0045 	182D
		STR 	24H 			//0046 	10A4
		LCALL 	8DH 			//0047 	308D
		MOVLP 	0H 			//0048 	0180
		LDR 	20H, 0H 			//0049 	1820
		STR 	7BH 			//004A 	10FB
		LDWI 	1H 			//004B 	0001
		LCALL 	83H 			//004C 	3083
		MOVLP 	0H 			//004D 	0180

		//;Learn.C: 645: Write_Max7219(2,cout%100/10);
		LDWI 	AH 			//004E 	000A
		LCALL 	30CH 			//004F 	330C
		MOVLP 	0H 			//0050 	0180
		LCALL 	2FCH 			//0051 	32FC
		MOVLP 	0H 			//0052 	0180
		LDWI 	64H 			//0053 	0064
		STR 	72H 			//0054 	10F2
		CLRF 	73H 			//0055 	11F3
		CLRF 	74H 			//0056 	11F4
		CLRF 	75H 			//0057 	11F5
		LCALL 	CCH 			//0058 	30CC
		MOVLP 	0H 			//0059 	0180
		LDR 	75H, 0H 			//005A 	1875
		STR 	27H 			//005B 	10A7
		LDR 	74H, 0H 			//005C 	1874
		STR 	26H 			//005D 	10A6
		LDR 	73H, 0H 			//005E 	1873
		STR 	25H 			//005F 	10A5
		LDR 	72H, 0H 			//0060 	1872
		STR 	24H 			//0061 	10A4
		LCALL 	8DH 			//0062 	308D
		MOVLP 	0H 			//0063 	0180
		LDR 	20H, 0H 			//0064 	1820
		STR 	7BH 			//0065 	10FB
		LDWI 	2H 			//0066 	0002
		LCALL 	83H 			//0067 	3083
		MOVLP 	0H 			//0068 	0180

		//;Learn.C: 646: Write_Max7219(3,cout%10);
		LDWI 	AH 			//0069 	000A
		STR 	72H 			//006A 	10F2
		CLRF 	73H 			//006B 	11F3
		CLRF 	74H 			//006C 	11F4
		CLRF 	75H 			//006D 	11F5
		LCALL 	2FCH 			//006E 	32FC
		MOVLP 	0H 			//006F 	0180
		LCALL 	CCH 			//0070 	30CC
		MOVLP 	0H 			//0071 	0180
		LDR 	72H, 0H 			//0072 	1872
		STR 	7BH 			//0073 	10FB
		LDWI 	3H 			//0074 	0003
		LCALL 	83H 			//0075 	3083
		MOVLP 	0H 			//0076 	0180

		//;Learn.C: 647: cout = ReadTemperature();
		LCALL 	113H 			//0077 	3113
		MOVLP 	0H 			//0078 	0180
		LDR 	20H, 0H 			//0079 	1820
		STR 	2DH 			//007A 	10AD
		LDR 	21H, 0H 			//007B 	1821
		STR 	2EH 			//007C 	10AE
		LDWI 	1H 			//007D 	0001
		CLRF 	2FH 			//007E 	11AF
		CLRF 	30H 			//007F 	11B0

		//;Learn.C: 648: DelayS(1);
		LCALL 	272H 			//0080 	3272
		MOVLP 	0H 			//0081 	0180
		LJUMP 	3BH 			//0082 	383B
		STR 	7CH 			//0083 	10FC

		//;Learn.C: 321: RC5 = 0;
		MOVLB 	0H 			//0084 	1020
		BCR 	EH, 5H 			//0085 	228E

		//;Learn.C: 322: Write_Max7219_byte(address);
		LDR 	7CH, 0H 			//0086 	187C
		LCALL 	102H 			//0087 	3102
		MOVLP 	0H 			//0088 	0180

		//;Learn.C: 323: Write_Max7219_byte(dat);
		LDR 	7BH, 0H 			//0089 	187B
		LCALL 	102H 			//008A 	3102

		//;Learn.C: 324: RC5=1;
		BSR 	EH, 5H 			//008B 	268E
		RET 					//008C 	1008
		CLRF 	28H 			//008D 	11A8
		CLRF 	29H 			//008E 	11A9
		CLRF 	2AH 			//008F 	11AA
		CLRF 	2BH 			//0090 	11AB
		LDR 	23H, 0H 			//0091 	1823
		IORWR 	22H, 0H 		//0092 	1422
		IORWR 	21H, 0H 		//0093 	1421
		IORWR 	20H, 0H 		//0094 	1420
		BTSC 	3H, 2H 			//0095 	2903
		LJUMP 	C3H 			//0096 	38C3
		CLRF 	2CH 			//0097 	11AC
		INCR 	2CH, 1H 		//0098 	1AAC
		BTSC 	23H, 7H 		//0099 	2BA3
		LJUMP 	A0H 			//009A 	38A0
		LSLF 	20H, 1H 		//009B 	05A0
		RLR 	21H, 1H 			//009C 	1DA1
		RLR 	22H, 1H 			//009D 	1DA2
		RLR 	23H, 1H 			//009E 	1DA3
		LJUMP 	98H 			//009F 	3898
		LSLF 	28H, 1H 		//00A0 	05A8
		RLR 	29H, 1H 			//00A1 	1DA9
		RLR 	2AH, 1H 			//00A2 	1DAA
		RLR 	2BH, 1H 			//00A3 	1DAB
		LDR 	23H, 0H 			//00A4 	1823
		SUBWR 	27H, 0H 		//00A5 	1227
		BTSS 	3H, 2H 			//00A6 	2D03
		LJUMP 	B2H 			//00A7 	38B2
		LDR 	22H, 0H 			//00A8 	1822
		SUBWR 	26H, 0H 		//00A9 	1226
		BTSS 	3H, 2H 			//00AA 	2D03
		LJUMP 	B2H 			//00AB 	38B2
		LDR 	21H, 0H 			//00AC 	1821
		SUBWR 	25H, 0H 		//00AD 	1225
		BTSS 	3H, 2H 			//00AE 	2D03
		LJUMP 	B2H 			//00AF 	38B2
		LDR 	20H, 0H 			//00B0 	1820
		SUBWR 	24H, 0H 		//00B1 	1224
		BTSS 	3H, 0H 			//00B2 	2C03
		LJUMP 	BDH 			//00B3 	38BD
		LDR 	20H, 0H 			//00B4 	1820
		SUBWR 	24H, 1H 		//00B5 	12A4
		LDR 	21H, 0H 			//00B6 	1821
		SUBWFB 	25H, 1H 		//00B7 	0BA5
		LDR 	22H, 0H 			//00B8 	1822
		SUBWFB 	26H, 1H 		//00B9 	0BA6
		LDR 	23H, 0H 			//00BA 	1823
		SUBWFB 	27H, 1H 		//00BB 	0BA7
		BSR 	28H, 0H 			//00BC 	2428
		LSRF 	23H, 1H 		//00BD 	06A3
		RRR 	22H, 1H 			//00BE 	1CA2
		RRR 	21H, 1H 			//00BF 	1CA1
		RRR 	20H, 1H 			//00C0 	1CA0
		DECRSZ 	2CH, 1H 		//00C1 	1BAC
		LJUMP 	A0H 			//00C2 	38A0
		LDR 	2BH, 0H 			//00C3 	182B
		STR 	23H 			//00C4 	10A3
		LDR 	2AH, 0H 			//00C5 	182A
		STR 	22H 			//00C6 	10A2
		LDR 	29H, 0H 			//00C7 	1829
		STR 	21H 			//00C8 	10A1
		LDR 	28H, 0H 			//00C9 	1828
		STR 	20H 			//00CA 	10A0
		RET 					//00CB 	1008
		LDR 	75H, 0H 			//00CC 	1875
		IORWR 	74H, 0H 		//00CD 	1474
		IORWR 	73H, 0H 		//00CE 	1473
		IORWR 	72H, 0H 		//00CF 	1472
		BTSC 	3H, 2H 			//00D0 	2903
		LJUMP 	F9H 			//00D1 	38F9
		CLRF 	7AH 			//00D2 	11FA
		INCR 	7AH, 1H 		//00D3 	1AFA
		BTSC 	75H, 7H 		//00D4 	2BF5
		LJUMP 	DBH 			//00D5 	38DB
		LSLF 	72H, 1H 		//00D6 	05F2
		RLR 	73H, 1H 			//00D7 	1DF3
		RLR 	74H, 1H 			//00D8 	1DF4
		RLR 	75H, 1H 			//00D9 	1DF5
		LJUMP 	D3H 			//00DA 	38D3
		LDR 	75H, 0H 			//00DB 	1875
		SUBWR 	79H, 0H 		//00DC 	1279
		BTSS 	3H, 2H 			//00DD 	2D03
		LJUMP 	E9H 			//00DE 	38E9
		LDR 	74H, 0H 			//00DF 	1874
		SUBWR 	78H, 0H 		//00E0 	1278
		BTSS 	3H, 2H 			//00E1 	2D03
		LJUMP 	E9H 			//00E2 	38E9
		LDR 	73H, 0H 			//00E3 	1873
		SUBWR 	77H, 0H 		//00E4 	1277
		BTSS 	3H, 2H 			//00E5 	2D03
		LJUMP 	E9H 			//00E6 	38E9
		LDR 	72H, 0H 			//00E7 	1872
		SUBWR 	76H, 0H 		//00E8 	1276
		BTSS 	3H, 0H 			//00E9 	2C03
		LJUMP 	F3H 			//00EA 	38F3
		LDR 	72H, 0H 			//00EB 	1872
		SUBWR 	76H, 1H 		//00EC 	12F6
		LDR 	73H, 0H 			//00ED 	1873
		SUBWFB 	77H, 1H 		//00EE 	0BF7
		LDR 	74H, 0H 			//00EF 	1874
		SUBWFB 	78H, 1H 		//00F0 	0BF8
		LDR 	75H, 0H 			//00F1 	1875
		SUBWFB 	79H, 1H 		//00F2 	0BF9
		LSRF 	75H, 1H 		//00F3 	06F5
		RRR 	74H, 1H 			//00F4 	1CF4
		RRR 	73H, 1H 			//00F5 	1CF3
		RRR 	72H, 1H 			//00F6 	1CF2
		DECRSZ 	7AH, 1H 		//00F7 	1BFA
		LJUMP 	DBH 			//00F8 	38DB
		LDR 	79H, 0H 			//00F9 	1879
		STR 	75H 			//00FA 	10F5
		LDR 	78H, 0H 			//00FB 	1878
		STR 	74H 			//00FC 	10F4
		LDR 	77H, 0H 			//00FD 	1877
		STR 	73H 			//00FE 	10F3
		LDR 	76H, 0H 			//00FF 	1876
		STR 	72H 			//0100 	10F2
		RET 					//0101 	1008
		STR 	72H 			//0102 	10F2

		//;Learn.C: 298: unsigned char i ;
		//;Learn.C: 299: RC5 = 0;
		BCR 	EH, 5H 			//0103 	228E

		//;Learn.C: 300: for(i=8;i>=1;i--){
		LDWI 	8H 			//0104 	0008
		STR 	73H 			//0105 	10F3

		//;Learn.C: 301: RB3=0;
		BCR 	DH, 3H 			//0106 	218D

		//;Learn.C: 302: if(DATA & 0x80){
		BTSS 	72H, 7H 		//0107 	2FF2
		LJUMP 	10BH 			//0108 	390B

		//;Learn.C: 303: RC6=1;
		BSR 	EH, 6H 			//0109 	270E

		//;Learn.C: 304: }else{
		LJUMP 	10CH 			//010A 	390C

		//;Learn.C: 305: RC6=0;
		BCR 	EH, 6H 			//010B 	230E

		//;Learn.C: 306: }
		//;Learn.C: 308: DATA = DATA<<1;
		LSLF 	72H, 1H 		//010C 	05F2

		//;Learn.C: 309: RB3=1;
		BSR 	DH, 3H 			//010D 	258D
		DECR 	73H, 1H 		//010E 	13F3
		LDR 	73H, 0H 			//010F 	1873
		BTSC 	3H, 2H 			//0110 	2903
		RET 					//0111 	1008
		LJUMP 	106H 			//0112 	3906

		//;Learn.C: 586: unsigned char TLV;
		//;Learn.C: 587: unsigned char THV,ge,shi,TZ,TX,shifen,baifen,qianfen,wanfen;
		//;Learn.C: 588: unsigned int temperature,value,wd;
		//;Learn.C: 589: GIE = 0;
		BCR 	BH, 7H 			//0113 	238B

		//;Learn.C: 590: TRISA5 =1;
		MOVLB 	1H 			//0114 	1021
		BSR 	CH, 5H 			//0115 	268C

		//;Learn.C: 591: Init_DS18B20();
		LCALL 	211H 			//0116 	3211
		MOVLP 	0H 			//0117 	0180

		//;Learn.C: 592: WriteOneChar(0xcc);
		LDWI 	CCH 			//0118 	00CC
		LCALL 	1ABH 			//0119 	31AB
		MOVLP 	0H 			//011A 	0180

		//;Learn.C: 593: WriteOneChar(0x44);
		LDWI 	44H 			//011B 	0044
		LCALL 	1ABH 			//011C 	31AB
		MOVLP 	0H 			//011D 	0180

		//;Learn.C: 594: DelayMs(50);
		LDWI 	32H 			//011E 	0032
		LCALL 	261H 			//011F 	3261
		MOVLP 	0H 			//0120 	0180

		//;Learn.C: 595: Init_DS18B20();
		LCALL 	211H 			//0121 	3211
		MOVLP 	0H 			//0122 	0180

		//;Learn.C: 596: WriteOneChar(0xcc);
		LDWI 	CCH 			//0123 	00CC
		LCALL 	1ABH 			//0124 	31AB
		MOVLP 	0H 			//0125 	0180

		//;Learn.C: 597: WriteOneChar(0xbe);
		LDWI 	BEH 			//0126 	00BE
		LCALL 	1ABH 			//0127 	31AB
		MOVLP 	0H 			//0128 	0180

		//;Learn.C: 599: TLV=ReadOneChar();
		LCALL 	23BH 			//0129 	323B
		MOVLP 	0H 			//012A 	0180
		MOVLB 	0H 			//012B 	1020
		STR 	28H 			//012C 	10A8

		//;Learn.C: 600: THV=ReadOneChar();
		LCALL 	23BH 			//012D 	323B
		MOVLP 	0H 			//012E 	0180
		MOVLB 	0H 			//012F 	1020
		STR 	25H 			//0130 	10A5

		//;Learn.C: 601: TRISA5 =1;
		MOVLB 	1H 			//0131 	1021
		BSR 	CH, 5H 			//0132 	268C

		//;Learn.C: 602: GIE = 1;
		BSR 	BH, 7H 			//0133 	278B

		//;Learn.C: 603: TZ = ((TLV>>4)|(THV<< 4))&0X3f;
		MOVLB 	0H 			//0134 	1020
		LDR 	25H, 0H 			//0135 	1825
		STR 	22H 			//0136 	10A2
		SWAPR 	22H, 0H 		//0137 	1E22
		ANDWI 	F0H 			//0138 	09F0
		STR 	22H 			//0139 	10A2
		SWAPR 	28H, 0H 		//013A 	1E28
		ANDWI 	FH 			//013B 	090F
		IORWR 	22H, 0H 		//013C 	1422
		STR 	29H 			//013D 	10A9
		LDWI 	3FH 			//013E 	003F
		ANDWR 	29H, 1H 		//013F 	15A9

		//;Learn.C: 604: TX = TLV << 4;
		SWAPR 	28H, 0H 		//0140 	1E28
		ANDWI 	F0H 			//0141 	09F0
		STR 	2AH 			//0142 	10AA

		//;Learn.C: 606: ge = TZ % 10;
		LDWI 	AH 			//0143 	000A
		STR 	72H 			//0144 	10F2
		LDR 	29H, 0H 			//0145 	1829
		LCALL 	2CFH 			//0146 	32CF
		MOVLP 	0H 			//0147 	0180
		STR 	26H 			//0148 	10A6

		//;Learn.C: 607: shi = TZ / 10;
		LDWI 	AH 			//0149 	000A
		STR 	72H 			//014A 	10F2
		LDR 	29H, 0H 			//014B 	1829
		LCALL 	2B7H 			//014C 	32B7
		MOVLP 	0H 			//014D 	0180
		STR 	27H 			//014E 	10A7

		//;Learn.C: 608: wd = 0;
		CLRF 	2BH 			//014F 	11AB
		CLRF 	2CH 			//0150 	11AC

		//;Learn.C: 609: if (TX & 0x80) wd = wd + 5000;
		BTSS 	2AH, 7H 		//0151 	2FAA
		LJUMP 	157H 			//0152 	3957
		LDWI 	88H 			//0153 	0088
		ADDWR 	2BH, 1H 		//0154 	17AB
		LDWI 	13H 			//0155 	0013
		ADDWFC 	2CH, 1H 		//0156 	0DAC

		//;Learn.C: 610: if (TX & 0x40) wd = wd + 2500;
		BTSS 	2AH, 6H 		//0157 	2F2A
		LJUMP 	15DH 			//0158 	395D
		LDWI 	C4H 			//0159 	00C4
		ADDWR 	2BH, 1H 		//015A 	17AB
		LDWI 	9H 			//015B 	0009
		ADDWFC 	2CH, 1H 		//015C 	0DAC

		//;Learn.C: 611: if (TX & 0x20) wd = wd + 1250;
		BTSS 	2AH, 5H 		//015D 	2EAA
		LJUMP 	163H 			//015E 	3963
		LDWI 	E2H 			//015F 	00E2
		ADDWR 	2BH, 1H 		//0160 	17AB
		LDWI 	4H 			//0161 	0004
		ADDWFC 	2CH, 1H 		//0162 	0DAC

		//;Learn.C: 612: if (TX & 0x10) wd = wd + 625;
		BTSS 	2AH, 4H 		//0163 	2E2A
		LJUMP 	169H 			//0164 	3969
		LDWI 	71H 			//0165 	0071
		ADDWR 	2BH, 1H 		//0166 	17AB
		LDWI 	2H 			//0167 	0002
		ADDWFC 	2CH, 1H 		//0168 	0DAC

		//;Learn.C: 613: shifen = wd / 1000;
		LDWI 	E8H 			//0169 	00E8
		STR 	77H 			//016A 	10F7
		LDWI 	3H 			//016B 	0003
		STR 	78H 			//016C 	10F8
		LDR 	2CH, 0H 			//016D 	182C
		STR 	7AH 			//016E 	10FA
		LDR 	2BH, 0H 			//016F 	182B
		STR 	79H 			//0170 	10F9
		LCALL 	1CCH 			//0171 	31CC
		MOVLP 	0H 			//0172 	0180

		//;Learn.C: 614: baifen = (wd % 1000) / 100;
		LDWI 	64H 			//0173 	0064
		LCALL 	305H 			//0174 	3305
		MOVLP 	0H 			//0175 	0180
		LDWI 	E8H 			//0176 	00E8
		STR 	72H 			//0177 	10F2
		LDWI 	3H 			//0178 	0003
		STR 	73H 			//0179 	10F3
		LCALL 	1F1H 			//017A 	31F1
		MOVLP 	0H 			//017B 	0180
		LCALL 	311H 			//017C 	3311
		MOVLP 	0H 			//017D 	0180
		LCALL 	1CCH 			//017E 	31CC
		MOVLP 	0H 			//017F 	0180

		//;Learn.C: 615: qianfen = (wd % 100) / 10;
		LDWI 	AH 			//0180 	000A
		LCALL 	305H 			//0181 	3305
		MOVLP 	0H 			//0182 	0180
		LDWI 	64H 			//0183 	0064
		STR 	72H 			//0184 	10F2
		CLRF 	73H 			//0185 	11F3
		LCALL 	1F1H 			//0186 	31F1
		MOVLP 	0H 			//0187 	0180
		LCALL 	311H 			//0188 	3311
		MOVLP 	0H 			//0189 	0180
		LCALL 	1CCH 			//018A 	31CC
		MOVLP 	0H 			//018B 	0180

		//;Learn.C: 616: wanfen = wd % 10;
		LDWI 	AH 			//018C 	000A
		STR 	72H 			//018D 	10F2
		CLRF 	73H 			//018E 	11F3
		LDR 	2CH, 0H 			//018F 	182C
		STR 	75H 			//0190 	10F5
		LDR 	2BH, 0H 			//0191 	182B
		STR 	74H 			//0192 	10F4
		LCALL 	1F1H 			//0193 	31F1
		MOVLP 	0H 			//0194 	0180

		//;Learn.C: 617: __nop();
		NOP 					//0195 	1000

		//;Learn.C: 618: temperature = shi*10+ge;
		MOVLB 	0H 			//0196 	1020
		LDR 	27H, 0H 			//0197 	1827
		STR 	72H 			//0198 	10F2
		LDWI 	AH 			//0199 	000A
		CLRF 	73H 			//019A 	11F3
		STR 	74H 			//019B 	10F4
		CLRF 	75H 			//019C 	11F5
		LCALL 	2E7H 			//019D 	32E7
		LDR 	73H, 0H 			//019E 	1873
		STR 	24H 			//019F 	10A4
		LDR 	72H, 0H 			//01A0 	1872
		STR 	23H 			//01A1 	10A3
		LDR 	26H, 0H 			//01A2 	1826
		ADDWR 	23H, 1H 		//01A3 	17A3
		BTSC 	3H, 0H 			//01A4 	2803
		INCR 	24H, 1H 		//01A5 	1AA4

		//;Learn.C: 620: return temperature;
		LDR 	24H, 0H 			//01A6 	1824
		STR 	21H 			//01A7 	10A1
		LDR 	23H, 0H 			//01A8 	1823
		STR 	20H 			//01A9 	10A0
		RET 					//01AA 	1008
		STR 	74H 			//01AB 	10F4

		//;Learn.C: 570: for(i=8;i>0;i--)
		LDWI 	8H 			//01AC 	0008
		STR 	76H 			//01AD 	10F6

		//;Learn.C: 571: {
		//;Learn.C: 572: temp=dat&0x01;
		LDR 	74H, 0H 			//01AE 	1874
		STR 	75H 			//01AF 	10F5
		LDWI 	1H 			//01B0 	0001
		ANDWR 	75H, 1H 		//01B1 	15F5

		//;Learn.C: 573: RA5 = 0; TRISA5 = 0;
		MOVLB 	0H 			//01B2 	1020
		BCR 	CH, 5H 			//01B3 	228C
		MOVLB 	1H 			//01B4 	1021
		BCR 	CH, 5H 			//01B5 	228C

		//;Learn.C: 574: __nop();__nop();__nop();__nop();__nop();
		NOP 					//01B6 	1000
		NOP 					//01B7 	1000
		NOP 					//01B8 	1000
		NOP 					//01B9 	1000
		NOP 					//01BA 	1000

		//;Learn.C: 575: if(temp == 1)
		DECRSZ 	75H, 0H 		//01BB 	1B75
		LJUMP 	1BFH 			//01BC 	39BF

		//;Learn.C: 576: TRISA5 =1;
		MOVLB 	1H 			//01BD 	1021
		BSR 	CH, 5H 			//01BE 	268C

		//;Learn.C: 577: DelayUs(63);
		LDWI 	3FH 			//01BF 	003F
		LCALL 	232H 			//01C0 	3232
		MOVLP 	0H 			//01C1 	0180

		//;Learn.C: 578: TRISA5 =1;
		MOVLB 	1H 			//01C2 	1021
		BSR 	CH, 5H 			//01C3 	268C

		//;Learn.C: 579: __nop();__nop();
		NOP 					//01C4 	1000
		NOP 					//01C5 	1000

		//;Learn.C: 580: dat>>=1;
		LSRF 	74H, 1H 		//01C6 	06F4
		DECR 	76H, 1H 		//01C7 	13F6
		LDR 	76H, 0H 			//01C8 	1876
		BTSC 	3H, 2H 			//01C9 	2903
		RET 					//01CA 	1008
		LJUMP 	1AEH 			//01CB 	39AE
		CLRF 	7BH 			//01CC 	11FB
		CLRF 	7CH 			//01CD 	11FC
		LDR 	77H, 0H 			//01CE 	1877
		IORWR 	78H, 0H 		//01CF 	1478
		BTSC 	3H, 2H 			//01D0 	2903
		LJUMP 	1ECH 			//01D1 	39EC
		CLRF 	7DH 			//01D2 	11FD
		INCR 	7DH, 1H 		//01D3 	1AFD
		BTSC 	78H, 7H 		//01D4 	2BF8
		LJUMP 	1D9H 			//01D5 	39D9
		LSLF 	77H, 1H 		//01D6 	05F7
		RLR 	78H, 1H 			//01D7 	1DF8
		LJUMP 	1D3H 			//01D8 	39D3
		LSLF 	7BH, 1H 		//01D9 	05FB
		RLR 	7CH, 1H 			//01DA 	1DFC
		LDR 	78H, 0H 			//01DB 	1878
		SUBWR 	7AH, 0H 		//01DC 	127A
		BTSS 	3H, 2H 			//01DD 	2D03
		LJUMP 	1E1H 			//01DE 	39E1
		LDR 	77H, 0H 			//01DF 	1877
		SUBWR 	79H, 0H 		//01E0 	1279
		BTSS 	3H, 0H 			//01E1 	2C03
		LJUMP 	1E8H 			//01E2 	39E8
		LDR 	77H, 0H 			//01E3 	1877
		SUBWR 	79H, 1H 		//01E4 	12F9
		LDR 	78H, 0H 			//01E5 	1878
		SUBWFB 	7AH, 1H 		//01E6 	0BFA
		BSR 	7BH, 0H 			//01E7 	247B
		LSRF 	78H, 1H 		//01E8 	06F8
		RRR 	77H, 1H 			//01E9 	1CF7
		DECRSZ 	7DH, 1H 		//01EA 	1BFD
		LJUMP 	1D9H 			//01EB 	39D9
		LDR 	7CH, 0H 			//01EC 	187C
		STR 	78H 			//01ED 	10F8
		LDR 	7BH, 0H 			//01EE 	187B
		STR 	77H 			//01EF 	10F7
		RET 					//01F0 	1008
		LDR 	72H, 0H 			//01F1 	1872
		IORWR 	73H, 0H 		//01F2 	1473
		BTSC 	3H, 2H 			//01F3 	2903
		LJUMP 	20CH 			//01F4 	3A0C
		CLRF 	76H 			//01F5 	11F6
		INCR 	76H, 1H 		//01F6 	1AF6
		BTSC 	73H, 7H 		//01F7 	2BF3
		LJUMP 	1FCH 			//01F8 	39FC
		LSLF 	72H, 1H 		//01F9 	05F2
		RLR 	73H, 1H 			//01FA 	1DF3
		LJUMP 	1F6H 			//01FB 	39F6
		LDR 	73H, 0H 			//01FC 	1873
		SUBWR 	75H, 0H 		//01FD 	1275
		BTSS 	3H, 2H 			//01FE 	2D03
		LJUMP 	202H 			//01FF 	3A02
		LDR 	72H, 0H 			//0200 	1872
		SUBWR 	74H, 0H 		//0201 	1274
		BTSS 	3H, 0H 			//0202 	2C03
		LJUMP 	208H 			//0203 	3A08
		LDR 	72H, 0H 			//0204 	1872
		SUBWR 	74H, 1H 		//0205 	12F4
		LDR 	73H, 0H 			//0206 	1873
		SUBWFB 	75H, 1H 		//0207 	0BF5
		LSRF 	73H, 1H 		//0208 	06F3
		RRR 	72H, 1H 			//0209 	1CF2
		DECRSZ 	76H, 1H 		//020A 	1BF6
		LJUMP 	1FCH 			//020B 	39FC
		LDR 	75H, 0H 			//020C 	1875
		STR 	73H 			//020D 	10F3
		LDR 	74H, 0H 			//020E 	1874
		STR 	72H 			//020F 	10F2
		RET 					//0210 	1008

		//;Learn.C: 531: unsigned char presence = 1,cnt =0;
		CLRF 	75H 			//0211 	11F5
		INCR 	75H, 1H 		//0212 	1AF5
		CLRF 	74H 			//0213 	11F4

		//;Learn.C: 532: while(presence&&cnt<15){
		LDR 	75H, 0H 			//0214 	1875
		BTSC 	3H, 2H 			//0215 	2903
		RET 					//0216 	1008
		LDWI 	FH 			//0217 	000F
		SUBWR 	74H, 0H 		//0218 	1274
		BTSC 	3H, 0H 			//0219 	2803
		RET 					//021A 	1008

		//;Learn.C: 533: RA5 = 0; TRISA5 = 0 ;
		MOVLB 	0H 			//021B 	1020
		BCR 	CH, 5H 			//021C 	228C
		MOVLB 	1H 			//021D 	1021
		BCR 	CH, 5H 			//021E 	228C

		//;Learn.C: 534: DelayUs(503);
		LDWI 	F7H 			//021F 	00F7
		LCALL 	232H 			//0220 	3232
		MOVLP 	0H 			//0221 	0180

		//;Learn.C: 535: TRISA5 =1 ;
		MOVLB 	1H 			//0222 	1021
		BSR 	CH, 5H 			//0223 	268C

		//;Learn.C: 536: DelayUs(40);
		LDWI 	28H 			//0224 	0028
		LCALL 	232H 			//0225 	3232
		MOVLP 	0H 			//0226 	0180

		//;Learn.C: 537: if(RA5==1){
		MOVLB 	0H 			//0227 	1020
		BTSS 	CH, 5H 			//0228 	2E8C
		LJUMP 	22DH 			//0229 	3A2D

		//;Learn.C: 538: presence = 1;
		CLRF 	75H 			//022A 	11F5
		INCR 	75H, 1H 		//022B 	1AF5

		//;Learn.C: 539: }else{
		LJUMP 	22EH 			//022C 	3A2E

		//;Learn.C: 540: presence = 0;
		CLRF 	75H 			//022D 	11F5

		//;Learn.C: 541: }
		//;Learn.C: 542: DelayUs(430);
		LDWI 	AEH 			//022E 	00AE
		LCALL 	232H 			//022F 	3232
		MOVLP 	0H 			//0230 	0180
		LJUMP 	214H 			//0231 	3A14
		STR 	72H 			//0232 	10F2

		//;Learn.C: 134: unsigned char a;
		//;Learn.C: 135: for(a=0;a<Time;a++)
		CLRF 	73H 			//0233 	11F3
		LDR 	72H, 0H 			//0234 	1872
		SUBWR 	73H, 0H 		//0235 	1273
		BTSC 	3H, 0H 			//0236 	2803
		RET 					//0237 	1008

		//;Learn.C: 136: {
		//;Learn.C: 137: __nop();
		NOP 					//0238 	1000
		INCR 	73H, 1H 		//0239 	1AF3
		LJUMP 	234H 			//023A 	3A34
		LDWI 	8H 			//023B 	0008

		//;Learn.C: 551: unsigned char dat=0;
		CLRF 	74H 			//023C 	11F4

		//;Learn.C: 552: static unsigned char j;
		//;Learn.C: 553: for (i=8;i>0;i--)
		STR 	75H 			//023D 	10F5

		//;Learn.C: 554: {
		//;Learn.C: 555: dat>>=1;
		LSRF 	74H, 1H 		//023E 	06F4

		//;Learn.C: 556: RA5 = 0; TRISA5 = 0;
		MOVLB 	0H 			//023F 	1020
		BCR 	CH, 5H 			//0240 	228C
		MOVLB 	1H 			//0241 	1021
		BCR 	CH, 5H 			//0242 	228C

		//;Learn.C: 557: __nop();__nop();__nop();__nop();__nop();__nop();
		NOP 					//0243 	1000
		NOP 					//0244 	1000
		NOP 					//0245 	1000
		NOP 					//0246 	1000
		NOP 					//0247 	1000
		NOP 					//0248 	1000

		//;Learn.C: 558: TRISA5 =1;
		MOVLB 	1H 			//0249 	1021
		BSR 	CH, 5H 			//024A 	268C

		//;Learn.C: 559: __nop();__nop();__nop();__nop();__nop();
		NOP 					//024B 	1000
		NOP 					//024C 	1000
		NOP 					//024D 	1000
		NOP 					//024E 	1000
		NOP 					//024F 	1000

		//;Learn.C: 560: j = RA5;
		LDWI 	0H 			//0250 	0000
		MOVLB 	0H 			//0251 	1020
		BTSC 	CH, 5H 			//0252 	2A8C
		LDWI 	1H 			//0253 	0001
		STR 	31H 			//0254 	10B1

		//;Learn.C: 561: if(j==1)
		DECRSZ 	31H, 0H 		//0255 	1B31
		LJUMP 	258H 			//0256 	3A58

		//;Learn.C: 562: dat|=0x80;
		BSR 	74H, 7H 			//0257 	27F4

		//;Learn.C: 563: DelayUs(63);
		LDWI 	3FH 			//0258 	003F
		LCALL 	232H 			//0259 	3232
		MOVLP 	0H 			//025A 	0180
		DECR 	75H, 1H 		//025B 	13F5
		LDR 	75H, 0H 			//025C 	1875
		BTSS 	3H, 2H 			//025D 	2D03
		LJUMP 	23EH 			//025E 	3A3E

		//;Learn.C: 564: }
		//;Learn.C: 565: return(dat);
		LDR 	74H, 0H 			//025F 	1874
		RET 					//0260 	1008
		STR 	74H 			//0261 	10F4

		//;Learn.C: 148: unsigned char a,b;
		//;Learn.C: 149: for(a=0;a<Time;a++)
		CLRF 	75H 			//0262 	11F5
		LDR 	74H, 0H 			//0263 	1874
		SUBWR 	75H, 0H 		//0264 	1275
		BTSC 	3H, 0H 			//0265 	2803
		RET 					//0266 	1008

		//;Learn.C: 150: {
		//;Learn.C: 151: for(b=0;b<5;b++)
		CLRF 	76H 			//0267 	11F6

		//;Learn.C: 152: {
		//;Learn.C: 153: DelayUs(197);
		LDWI 	C5H 			//0268 	00C5
		LCALL 	232H 			//0269 	3232
		MOVLP 	0H 			//026A 	0180
		LDWI 	5H 			//026B 	0005
		INCR 	76H, 1H 		//026C 	1AF6
		SUBWR 	76H, 0H 		//026D 	1276
		BTSS 	3H, 0H 			//026E 	2C03
		LJUMP 	268H 			//026F 	3A68
		INCR 	75H, 1H 		//0270 	1AF5
		LJUMP 	263H 			//0271 	3A63
		STR 	77H 			//0272 	10F7

		//;Learn.C: 165: unsigned char a,b;
		//;Learn.C: 166: for(a=0;a<Time;a++)
		CLRF 	78H 			//0273 	11F8
		LDR 	77H, 0H 			//0274 	1877
		SUBWR 	78H, 0H 		//0275 	1278
		BTSC 	3H, 0H 			//0276 	2803
		RET 					//0277 	1008

		//;Learn.C: 167: {
		//;Learn.C: 168: for(b=0;b<10;b++)
		CLRF 	79H 			//0278 	11F9

		//;Learn.C: 169: {
		//;Learn.C: 170: DelayMs(100);
		LDWI 	64H 			//0279 	0064
		LCALL 	261H 			//027A 	3261
		MOVLP 	0H 			//027B 	0180
		LDWI 	AH 			//027C 	000A
		INCR 	79H, 1H 		//027D 	1AF9
		SUBWR 	79H, 0H 		//027E 	1279
		BTSS 	3H, 0H 			//027F 	2C03
		LJUMP 	279H 			//0280 	3A79
		INCR 	78H, 1H 		//0281 	1AF8
		LJUMP 	274H 			//0282 	3A74

		//;Learn.C: 204: OSCCON = 0B01110001;
		LDWI 	71H 			//0283 	0071
		MOVLB 	1H 			//0284 	1021
		STR 	19H 			//0285 	1099

		//;Learn.C: 207: INTCON = 0;
		CLRF 	BH 			//0286 	118B

		//;Learn.C: 208: PCKEN |=0B00000001;
		BSR 	1AH, 0H 			//0287 	241A

		//;Learn.C: 209: PORTA = 0B00000000;
		MOVLB 	0H 			//0288 	1020
		CLRF 	CH 			//0289 	118C

		//;Learn.C: 210: TRISA = 0B11111111;
		LDWI 	FFH 			//028A 	00FF
		MOVLB 	1H 			//028B 	1021
		STR 	CH 			//028C 	108C

		//;Learn.C: 211: PORTB = 0B00000000;
		MOVLB 	0H 			//028D 	1020
		CLRF 	DH 			//028E 	118D

		//;Learn.C: 212: TRISB = 0B11110111;
		LDWI 	F7H 			//028F 	00F7
		MOVLB 	1H 			//0290 	1021
		STR 	DH 			//0291 	108D

		//;Learn.C: 213: PORTC = 0B00000000;
		MOVLB 	0H 			//0292 	1020
		CLRF 	EH 			//0293 	118E

		//;Learn.C: 214: TRISC = 0B01111111;
		LDWI 	7FH 			//0294 	007F
		MOVLB 	1H 			//0295 	1021
		STR 	EH 			//0296 	108E

		//;Learn.C: 215: PORTD = 0B00000000;
		MOVLB 	0H 			//0297 	1020
		CLRF 	FH 			//0298 	118F

		//;Learn.C: 216: TRISD = 0B11111000;
		LDWI 	F8H 			//0299 	00F8
		MOVLB 	1H 			//029A 	1021
		STR 	FH 			//029B 	108F

		//;Learn.C: 218: WPUA = 0B00000000;
		MOVLB 	3H 			//029C 	1023
		CLRF 	CH 			//029D 	118C

		//;Learn.C: 219: WPUB = 0B00000000;
		CLRF 	DH 			//029E 	118D

		//;Learn.C: 220: WPUC = 0B00001000;
		LDWI 	8H 			//029F 	0008
		STR 	EH 			//02A0 	108E

		//;Learn.C: 221: WPUD = 0B00000000;
		CLRF 	FH 			//02A1 	118F

		//;Learn.C: 223: WPDA = 0B00000000;
		MOVLB 	4H 			//02A2 	1024
		CLRF 	CH 			//02A3 	118C

		//;Learn.C: 224: WPDB = 0B00000000;
		CLRF 	DH 			//02A4 	118D

		//;Learn.C: 225: WPDC = 0B00000000;
		CLRF 	EH 			//02A5 	118E

		//;Learn.C: 226: WPDD = 0B00000000;
		CLRF 	FH 			//02A6 	118F

		//;Learn.C: 228: PSRC0 = 0B11111111;
		LDWI 	FFH 			//02A7 	00FF
		MOVLB 	2H 			//02A8 	1022
		STR 	1AH 			//02A9 	109A

		//;Learn.C: 232: PSRC1 = 0B11111111;
		STR 	1BH 			//02AA 	109B

		//;Learn.C: 236: PSINK0 = 0B11111111;
		MOVLB 	3H 			//02AB 	1023
		STR 	1AH 			//02AC 	109A

		//;Learn.C: 237: PSINK1 = 0B11111111;
		STR 	1BH 			//02AD 	109B

		//;Learn.C: 238: PSINK2 = 0B11111111;
		STR 	1CH 			//02AE 	109C

		//;Learn.C: 239: PSINK3 = 0B11111111;
		STR 	1DH 			//02AF 	109D

		//;Learn.C: 240: TRISB3 = 0;
		MOVLB 	1H 			//02B0 	1021
		BCR 	DH, 3H 			//02B1 	218D

		//;Learn.C: 241: TRISC5 = 0;
		BCR 	EH, 5H 			//02B2 	228E

		//;Learn.C: 242: TRISC6 = 0;
		BCR 	EH, 6H 			//02B3 	230E

		//;Learn.C: 243: ANSELA = 0B00000000;
		MOVLB 	3H 			//02B4 	1023
		CLRF 	17H 			//02B5 	1197
		RET 					//02B6 	1008
		STR 	73H 			//02B7 	10F3
		CLRF 	75H 			//02B8 	11F5
		LDR 	72H, 0H 			//02B9 	1872
		BTSC 	3H, 2H 			//02BA 	2903
		LJUMP 	2CDH 			//02BB 	3ACD
		CLRF 	74H 			//02BC 	11F4
		INCR 	74H, 1H 		//02BD 	1AF4
		BTSC 	72H, 7H 		//02BE 	2BF2
		LJUMP 	2C2H 			//02BF 	3AC2
		LSLF 	72H, 1H 		//02C0 	05F2
		LJUMP 	2BDH 			//02C1 	3ABD
		LSLF 	75H, 1H 		//02C2 	05F5
		LDR 	72H, 0H 			//02C3 	1872
		SUBWR 	73H, 0H 		//02C4 	1273
		BTSS 	3H, 0H 			//02C5 	2C03
		LJUMP 	2CAH 			//02C6 	3ACA
		LDR 	72H, 0H 			//02C7 	1872
		SUBWR 	73H, 1H 		//02C8 	12F3
		BSR 	75H, 0H 			//02C9 	2475
		LSRF 	72H, 1H 		//02CA 	06F2
		DECRSZ 	74H, 1H 		//02CB 	1BF4
		LJUMP 	2C2H 			//02CC 	3AC2
		LDR 	75H, 0H 			//02CD 	1875
		RET 					//02CE 	1008
		STR 	74H 			//02CF 	10F4
		LDWI 	8H 			//02D0 	0008
		STR 	75H 			//02D1 	10F5
		CLRF 	76H 			//02D2 	11F6
		LDR 	74H, 0H 			//02D3 	1874
		STR 	73H 			//02D4 	10F3
		LDWI 	7H 			//02D5 	0007
		LSRF 	73H, 1H 		//02D6 	06F3
		DECRSZ 	9H, 1H 		//02D7 	1B89
		LJUMP 	2D6H 			//02D8 	3AD6
		LSLF 	76H, 0H 		//02D9 	0576
		IORWR 	73H, 0H 		//02DA 	1473
		STR 	76H 			//02DB 	10F6
		LSLF 	74H, 1H 		//02DC 	05F4
		LDR 	72H, 0H 			//02DD 	1872
		SUBWR 	76H, 0H 		//02DE 	1276
		BTSS 	3H, 0H 			//02DF 	2C03
		LJUMP 	2E3H 			//02E0 	3AE3
		LDR 	72H, 0H 			//02E1 	1872
		SUBWR 	76H, 1H 		//02E2 	12F6
		DECRSZ 	75H, 1H 		//02E3 	1BF5
		LJUMP 	2D3H 			//02E4 	3AD3
		LDR 	76H, 0H 			//02E5 	1876
		RET 					//02E6 	1008
		CLRF 	76H 			//02E7 	11F6
		CLRF 	77H 			//02E8 	11F7
		BTSS 	72H, 0H 		//02E9 	2C72
		LJUMP 	2EFH 			//02EA 	3AEF
		LDR 	74H, 0H 			//02EB 	1874
		ADDWR 	76H, 1H 		//02EC 	17F6
		LDR 	75H, 0H 			//02ED 	1875
		ADDWFC 	77H, 1H 		//02EE 	0DF7
		LSLF 	74H, 1H 		//02EF 	05F4
		RLR 	75H, 1H 			//02F0 	1DF5
		LSRF 	73H, 1H 		//02F1 	06F3
		RRR 	72H, 1H 			//02F2 	1CF2
		LDR 	72H, 0H 			//02F3 	1872
		IORWR 	73H, 0H 		//02F4 	1473
		BTSS 	3H, 2H 			//02F5 	2D03
		LJUMP 	2E9H 			//02F6 	3AE9
		LDR 	77H, 0H 			//02F7 	1877
		STR 	73H 			//02F8 	10F3
		LDR 	76H, 0H 			//02F9 	1876
		STR 	72H 			//02FA 	10F2
		RET 					//02FB 	1008
		LDR 	30H, 0H 			//02FC 	1830
		STR 	79H 			//02FD 	10F9
		LDR 	2FH, 0H 			//02FE 	182F
		STR 	78H 			//02FF 	10F8
		LDR 	2EH, 0H 			//0300 	182E
		STR 	77H 			//0301 	10F7
		LDR 	2DH, 0H 			//0302 	182D
		STR 	76H 			//0303 	10F6
		RET 					//0304 	1008
		STR 	77H 			//0305 	10F7
		CLRF 	78H 			//0306 	11F8
		LDR 	2CH, 0H 			//0307 	182C
		STR 	75H 			//0308 	10F5
		LDR 	2BH, 0H 			//0309 	182B
		STR 	74H 			//030A 	10F4
		RET 					//030B 	1008
		STR 	20H 			//030C 	10A0
		CLRF 	21H 			//030D 	11A1
		CLRF 	22H 			//030E 	11A2
		CLRF 	23H 			//030F 	11A3
		RET 					//0310 	1008
		LDR 	73H, 0H 			//0311 	1873
		STR 	7AH 			//0312 	10FA
		LDR 	72H, 0H 			//0313 	1872
		STR 	79H 			//0314 	10F9
		RET 					//0315 	1008
			END
