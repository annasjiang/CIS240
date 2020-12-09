/* 
 * loader.c : rountines for opening and loading object files
 *
 */

#include "loader.h"
#include <stdio.h>
#include <stdlib.h>

// helper function to convert big endian to little endian
unsigned short int big_to_lil(unsigned short int x) {
	short int upper, lower, final;
	upper = (x & 0xFF00) >> 8; // shift last half to first half and 0 out last half
	lower = (x & 0x00FF) << 8; // shift first half to last half and 0 out first hald
	final = upper | lower; // or to add
	return final;
}

unsigned short int* loader(char* input_file, unsigned short int* lc4mem) {
	// file opening business
	FILE *file;
	file = fopen(input_file, "rb");

	// null file
	if (file == NULL) {
		printf("Couldn't open file rip :(\n");
		exit(1);
	}

	unsigned short int i, section, addy, n, words, line, index;
	char c;
	// start readin bois!
	while(fread(&section, sizeof(unsigned short int), 1, file) == 1) { 
		// look for headers
		if(section == 0xDECA) { // code section
			// get address
			fread(&addy, sizeof(unsigned short int), 1, file);
			addy = big_to_lil(addy);
			// get section size
			fread(&n, sizeof(unsigned short int), 1, file);
			n = big_to_lil(n);
			// read and fill next n slots of the addy
			for (i = 0; i < n; i++) {
				fread(&words, sizeof(unsigned short int), 1, file);
				lc4mem[addy] = big_to_lil(words);
				addy++;
			}
		} else if(section == 0xDADA) { // data setion
			// get address
			fread(&addy, sizeof(unsigned short int), 1, file);
			addy = big_to_lil(addy);
			// get section size
			fread(&n, sizeof(unsigned short int), 1, file);
			n = big_to_lil(n);
			// read and fill next n slots of the addy
			for (i = 0; i < n; i++) {
				fread(&words, sizeof(unsigned short int), 1, file);
				lc4mem[addy] = big_to_lil(words);
				addy++;
			}
		} else if(section == 0xB7C3) { // symbol section
			// get address
			fread(&addy, sizeof(unsigned short int), 1, file);
			addy = big_to_lil(addy);
			// get section size
			fread(&n, sizeof(unsigned short int), 1, file);
			n = big_to_lil(n);
			// dont fill array for symbols
			for (i = 0; i < n; i++) {
				fread(&c, sizeof(char), 1, file);
			}
		} else if(section == 0x7EF1) { // file name section
			// get section size
			fread(&n, sizeof(unsigned short int), 1, file);
			n = big_to_lil(n);
			// read (dont need to fill array)
			for (i = 0; i < n; i++) {
				fread(&c, sizeof(char), 1, file);
			}
		} else if(section == 0x5E71) { // line number section
			// get address
			fread(&addy, sizeof(unsigned short int), 1, file);
			addy = big_to_lil(addy);
			// get line
			fread(&line, sizeof(unsigned short int), 1, file);
			line = big_to_lil(line);
			// get file index
			fread(&index, sizeof(unsigned short int), 1, file);
			index = big_to_lil(index);
		} 
	}
	fclose(file);
	return lc4mem;
}
