//Deviec:FT62F08X
//-----------------------Variable---------------------------------
		_W_TMP		EQU		70H
		_BSR_TMP		EQU		71H
//-----------------------Variable END---------------------------------

		MOVLP 	0H 			//0000 	0180
		LJUMP 	1FH 			//0001 	381F
		ORG		0003H
		NOP 					//0003 	1000
		STR 	70H 			//0004 	10F0
		SWAPR 	8H, 0H 		//0005 	1E08
		STR 	71H 			//0006 	10F1
		MOVLB 	1FH 			//0007 	103F
		SWAPR 	71H, 0H 		//0008 	1E71
		STR 	66H 			//0009 	10E6
		SWAPR 	3H, 0H 		//000A 	1E03
		SWAPR 	9H, 0H 		//000B 	1E09
		STR 	64H 			//000C 	10E4
		LDR 	AH, 0H 			//000D 	180A
		STR 	67H 			//000E 	10E7
		LDR 	4H, 0H 			//000F 	1804
		STR 	68H 			//0010 	10E8
		LDR 	5H, 0H 			//0011 	1805
		STR 	69H 			//0012 	10E9
		LDR 	6H, 0H 			//0013 	1806
		STR 	6AH 			//0014 	10EA
		LDR 	7H, 0H 			//0015 	1807
		STR 	6BH 			//0016 	10EB
		LDR 	70H, 0H 			//0017 	1870
		STR 	65H 			//0018 	10E5
		BSR 	7EH, 0H 			//0019 	247E
		MOVLP 	0H 			//001A 	0180

		//;test.C: 48: user_isr();
		MOVLP 	0H 			//001B 	0180
		LCALL 	27H 			//001C 	3027
		BCR 	7EH, 0H 			//001D 	207E
		RETI 					//001E 	1009
		MOVLP 	0H 			//001F 	0180
		LJUMP 	21H 			//0020 	3821
		BCR 	7EH, 0H 			//0021 	207E
		MOVLB 	0H 			//0022 	1020
		MOVLP 	0H 			//0023 	0180
		LJUMP 	1FH 			//0024 	381F
		MOVLP 	0H 			//0025 	0180
		LJUMP 	1FH 			//0026 	381F
		RET 					//0027 	1008
			END
