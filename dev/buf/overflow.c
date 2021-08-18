#include <stdio.h>
#include <string.h>

/*
  Adaptado de "Hacking: The Art of Exploitation", 2nd Edition. Jon Erickson.
  Testar com argv[1] =
  - 1234567890
  - AAAAAAAAAAAAAAAAAAAAAAAAAAAAA
*/

int main(int argc, char *argv[]) {
	int valor = 5;
	char buffer_um[8], buffer_dois[8];

	strcpy(buffer_um, "um"); /* Copia "um" para buffer_um */
	strcpy(buffer_dois, "dois"); /* Copia "dois" para buffer_dois */

	printf("[ANTES] buffer_dois esta em %p e contem \'%s\'\n", buffer_dois, buffer_dois);
	printf("[ANTES] buffer_um esta em %p e contem \'%s\'\n", buffer_um, buffer_um);
	printf("[ANTES] valor  esta em %p e eh %d (0x%08x)\n", &valor, valor, valor);
	
	printf("[STRCPY] copying %ld bytes into byffer_dois\n\n", strlen(buffer_dois));
	strcpy(buffer_dois, argv[1]);

	printf("[DEPOIS] buffer_dois esta em %p e contem \'%s\'\n", buffer_dois, buffer_dois);
	printf("[DEPOIS] buffer_um esta em %p e contem \'%s\'\n", buffer_um, buffer_um);
	printf("[DEPOIS] valor esta em %p e eh %d (0x%08x)\n", &valor, valor, valor);
}
