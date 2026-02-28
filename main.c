#include "./include/libasm.h"

int main(void)
{
    /////////////////////////////////////////// ft_strlen
    printf("ft_strlen -> %zu\n", ft_strlen("Hello worldu!"));
    printf("ft_strlen empty -> %zu\n", ft_strlen(""));
    printf("\n\n");



    /////////////////////////////////////////// ft_strcmp
    int i = ft_strcmp("Som", "Tom");
    int j = ft_strcmp("", "Tom");
    printf("ft_strcmp -> %d\n", i);
    printf("ft_strcmp empty s1 -> %d\n", j);
    printf("\n\n");



    /////////////////////////////////////////// ft_strcpy
    char *src = "Tom";
    char dest[4];
    printf("ft_strcpry -> %s\n", ft_strcpy(dest, src));
    printf("\n\n");



    /////////////////////////////////////////// ft_write
    ft_write(1, "ft_write -> alan\n", 17);
    ft_write(1, "ft_write 2 char -> alan", 21);
    printf("\n\n");

    if (ft_write(-1, "alan", 5) < 0)
    {
        perror("ft_write error ->");
    }

    if (ft_write(1, NULL, 5) < 0)
    {
        perror("ft_write error ->");
    }

    printf("\n\n");


    /////////////////////////////////////////// ft_read
    char buf[255];
    bzero(buf, 255);

    ft_read(0, buf, 255);
    printf("ft_read -> %s\n", buf);

    bzero(buf, 255);

    ft_read(0, buf, 2);
    printf("ft_read 2 char -> %s\n", buf);
    printf("\n\n");

    if (ft_read(-1, buf, 255) < 0)
    {
        perror("ft_read error ->");
    }

    if (ft_read(0, NULL, 255) < 0)
    {
        perror("ft_read error ->");
    }
    printf("\n\n");

    
    /////////////////////////////////////////// ft_strdup
    char    *s = "Alan\n";

    char    *dup = ft_strdup(s);
    if (!dup)
    {
        perror("ft_strdup error ->");
        return (1);
    }
    printf("ft_strdup -> %s", dup);
    free(dup);
    printf("\n\n");

    return (0);
}