#include <stdio.h>

main()
{
	char line[8];

	fgets(line, 8, stdin);
	printf("%s\n", line);
}
