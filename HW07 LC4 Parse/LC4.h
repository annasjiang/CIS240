/* 
 * LC4.h : header file for LC4.c
 *
 */

// main lc4 function
char* LC4(unsigned short int instruction);
// helper to do SEXT of signed numbers
signed int sextI(unsigned int x, int length);