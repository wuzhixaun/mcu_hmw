#ifndef	_CONST_H_
#define	_CONST_H_

#include  "SYSCFG.h"
#include  "Bin.h"
//***********************∫Í∂®“Â*********************************
typedef unsigned char   u8;
typedef unsigned int    u16;
typedef unsigned long    u32;

typedef unsigned char   uchar;
typedef unsigned int    uint;
typedef unsigned long    ulong;

typedef unsigned char   unchar;
typedef unsigned int    unint;
typedef unsigned long    unlong;

#define COM1 PB5
#define COM2 PB4
#define COM3 PB3
#define COM4 PB2

#define SEG0 PB6
#define SEG1 PB7
#define SEG2 PC0
#define SEG3 PA1
#define SEG4 PA0
#define SEG5 PB0
#define SEG6 PB1
#define SEG7 PD3
#define SEG8 PD2
#define SEG9 PD1
#define SEG10 PC6
#define SEG11 PC5
#define SEG12 PC4

#define COM1_H TRISB5=0;COM1=1
#define COM2_H TRISB4=0;COM2=1
#define COM3_H TRISB3=0;COM3=1
#define COM4_H TRISB2=0;COM4=1

#define COM1_L TRISB5=0;COM1=0
#define COM2_L TRISB4=0;COM2=0
#define COM3_L TRISB3=0;COM3=0
#define COM4_L TRISB2=0;COM4=0


#define COM1_HALF TRISB5=1;WPUB5=1;WPDB5=1;
#define COM2_HALF TRISB4=1;WPUB4=1;WPDB4=1;
#define COM3_HALF TRISB3=1;WPUB3=1;WPDB3=1;
#define COM4_HALF TRISB2=1;WPUB2=1;WPDB2=1;

volatile bit BZ_1A = 0;
volatile bit BZ_1B = 0;
volatile bit BZ_1C = 0;
volatile bit BZ_1D = 0;
volatile bit BZ_1E = 0;
volatile bit BZ_1F = 0;
volatile bit BZ_1G = 0;

volatile bit BZ_2A = 0;
volatile bit BZ_2B = 0;
volatile bit BZ_2C = 0;
volatile bit BZ_2D = 0;
volatile bit BZ_2E = 0;
volatile bit BZ_2F = 0;
volatile bit BZ_2G = 0;

volatile bit BZ_3A = 0;
volatile bit BZ_3B = 0;
volatile bit BZ_3C = 0;
volatile bit BZ_3D = 0;
volatile bit BZ_3E = 0;
volatile bit BZ_3F = 0;
volatile bit BZ_3G = 0;

volatile bit BZ_4A = 0;
volatile bit BZ_4B = 0;
volatile bit BZ_4C = 0;
volatile bit BZ_4D = 0;
volatile bit BZ_4E = 0;
volatile bit BZ_4F = 0;
volatile bit BZ_4G = 0;

volatile bit BZ_5A = 0;
volatile bit BZ_5B = 0;
volatile bit BZ_5C = 0;
volatile bit BZ_5D = 0;
volatile bit BZ_5E = 0;
volatile bit BZ_5F = 0;
volatile bit BZ_5G = 0;

volatile bit BZ_T1 = 0;
volatile bit BZ_T2 = 0;
volatile bit BZ_T3 = 0;

volatile bit BZ_S1 = 0;
volatile bit BZ_S2 = 0;
volatile bit BZ_S3 = 0;
volatile bit BZ_S4 = 0;
volatile bit BZ_S5 = 0;
volatile bit BZ_S6 = 0;
volatile bit BZ_S7 = 0;
volatile bit BZ_S8 = 0;
volatile bit BZ_S9 = 0;
volatile bit BZ_S10 = 0;
volatile bit BZ_S11 = 0;
volatile bit BZ_S12 = 0;
volatile bit BZ_S13 = 0;
volatile bit BZ_S14 = 0;

volatile u8 Step = 0;

#endif	