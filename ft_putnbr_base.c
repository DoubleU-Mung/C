#include <unistd.h>

unsigned int	str_len(char	*str)
{
	unsigned int	i;

	i = 0;
	while (str[i])
		i ++;
	return (i);
}

unsigned int	is_valid_base(unsigned int	b_len, char	*str)
{
	unsigned int	i;
	unsigned int	j;

	if (b_len < 2)
		return (1);
	i = 0;
	while (str[i])
	{
		j = i + 1;
		while (str[j])
		{
			if (str[i] == str[j])
				return (1);
			j ++;
		}
		if (str[i] == '-' || str[i] == '+')
			return (1);
		i ++;
	}
	return (0);
}

void	ft_putnbr_base(int	nbr, char *base)
{
	long	nb;
	unsigned int	b_len;

	nb = nbr;
	b_len = str_len(base);
	if (is_valid_base(b_len, base))
		return ;
	if (nb < 0)
	{
		write (1, "-", 1);
		nb = -nb;
	}
	if (nb >= b_len)
		ft_putnbr_base((nb / b_len), base);
	write (1, base + (nb % b_len), 1);
}

int	main(void)
{
	char	base_01[] = "01";
	char	base_dec[] = "0123456789";
	char	base_hex[] = "0123456789ABCDEF";
	char	base_oct[] = "poneyvif";

	ft_putnbr_base(1234, base_01);
	write (1, "\n", 1);
	ft_putnbr_base(1234, base_dec);
	write (1, "\n", 1);
	ft_putnbr_base(1234, base_hex);
	write (1, "\n", 1);
	ft_putnbr_base(1234, base_oct);
	write (1, "\n", 1);

	ft_putnbr_base(-2147483647, base_01);
	write (1, "\n", 1);
	ft_putnbr_base(-2147483647, base_dec);
	write (1, "\n", 1);
	ft_putnbr_base(-2147483647, base_hex);
	write (1, "\n", 1);
	ft_putnbr_base(-2147483647, base_oct);
	write (1, "\n", 1);
}