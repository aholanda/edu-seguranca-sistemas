#include <stdio.h>

main()
{
	char line[128];

	fgets(line, 128, stdin);
	printf("%s\n", line);
}
