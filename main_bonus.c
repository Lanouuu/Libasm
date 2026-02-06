#include "./include/libasm_bonus.h"

#include <stdlib.h>
#include <stdio.h>

int main(int ac, char **av)
{
    (void)ac;
    printf("%d\n", atoi(av[1]));
    return (0);
}