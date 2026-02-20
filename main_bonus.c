#include "./include/libasm_bonus.h"

#include <stdlib.h>
#include <stdio.h>

int main(int ac, char **av)
{
    (void)ac;
    printf("%d\n", ft_atoi_base(av[1], "0123456789abcdef"));
    return (0);
}