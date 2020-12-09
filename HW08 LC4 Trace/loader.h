/* 
 * loader.h : header file for loader.c
 *
 */

// main loader function
unsigned short int* loader(char* input_file, unsigned short int * buf);
// helper to convert big endian to little endian
unsigned short int big_to_lil(unsigned short int x);
