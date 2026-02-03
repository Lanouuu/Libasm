#include "./include/libasm.h"

int main(void)
{
    size_t r = ft_strlen("Hello world!");
    printf("strlen -> %zu\n", r);

    int i = ft_strcmp("Som", "Tom");
    printf("strcmp -> %d\n", i);

    char *src = "Tom";
    char dest[4];
    printf("strcpry -> %s\n", ft_strcpy(dest, src));

    return (0);
}