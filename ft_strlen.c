#include <stdio.h>

int	ft_strlen(char *str)
{
	unsigned int	i;

	i = 0;
	while (str[i])
		i ++;
	return (i);
}
/*
int	main(void)
{
	char hi[] = "asdfwersadfwwwerwe";
	char hello[] = "12 34Tr";
	char hey [] = "hello\n123World";

	printf("%d\n", ft_strlen(hi));
	printf("%d\n", ft_strlen(hello));
	printf("%d\n", ft_strlen(hey));
}
*/