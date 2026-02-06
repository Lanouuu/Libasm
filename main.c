#include "./include/libasm.h"

int main(void)
{
    size_t r = ft_strlen("Hello world!");
    printf("ft_strlen -> %zu\n", r);

    int i = ft_strcmp("Som", "Tom");
    printf("ft_strcmp -> %d\n", i);

    char *src = "Tom";
    char dest[4];
    printf("ft_strcpry -> %s\n", ft_strcpy(dest, src));

    ft_write(1, "ft_write -> Alan\n", 17);

    if (ft_write(-1, "alan", 5) < 0)
    {
        perror("ft_write error ->");
    }

    char buf[255];
    ft_read(0, buf, 255);
    printf("ft_read -> %s\n", buf);

    if (ft_read(-1, buf, 255) < 0)
    {
        perror("ft_read error ->");
    }

    char    *s = "Alan\n";

    char    *dup = ft_strdup(s);
    if (!dup)
    {
        perror("ft_strdup error ->");
        return (1);
    }
    printf("ft_strdup -> %s", dup);
    free(dup);

    return (0);
}