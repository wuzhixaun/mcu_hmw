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

#define TESTIO PA2

#define IO_IN 1
#define IO_OUT 0

#define COM1 PB5
#define COM2 PB4
#define COM3 PB3
#define COM4 PB2

#define COM1_STATE TRISB5
#define COM2_STATE TRISB4
#define COM3_STATE TRISB3
#define COM4_STATE TRISB2

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

#define SEG0_STATE TRISB6
#define SEG1_STATE TRISB7
#define SEG2_STATE TRISC0
#define SEG3_STATE TRISA1
#define SEG4_STATE TRISA0
#define SEG5_STATE TRISB0
#define SEG6_STATE TRISB1
#define SEG7_STATE TRISD3
#define SEG8_STATE TRISD2
#define SEG9_STATE TRISD1
#define SEG10_STATE TRISC6
#define SEG11_STATE TRISC5
#define SEG12_STATE TRISC4


volatile u8 Flash_Code=0;
volatile bit Flash_BZ=0;

volatile u8 Dis_Data=0;

#endif	