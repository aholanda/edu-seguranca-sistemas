#include <stdio.h>

main()
{
	char line[128];

	gets(line);
	printf("%s\n", line);
}
