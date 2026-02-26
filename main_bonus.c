#include "./include/libasm_bonus.h"

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main(int ac, char **av)
{
    (void)ac;
    (void)av;
    // printf("%d\n", ft_atoi_base(av[1], "0123456789abcdef"));

    t_list  *begin_list = NULL;

    char *data1 = malloc(sizeof(char *));
    char *data2 = malloc(sizeof(char *));
    char *data3 = malloc(sizeof(char *));
    if (!data1 || !data2 || !data3)
        return (1);

    data1 = "data1";
    data2 = "data2";
    data3 = "data3";

    printf("data1 address: %p, value: %s\n", data1, data1);
    printf("data2 address: %p, value: %s\n", data2, data2);
    printf("data3 address: %p, value: %s\n", data3, data3);

    ft_list_push_front(&begin_list, data1);
    printf("\nNew link data address: %p\n", begin_list->data);
    printf("New link data value: %s\n", (char *)begin_list->data);
    ft_list_push_front(&begin_list, data2);
    printf("\nNew link data address: %p\n", begin_list->data);
    printf("New link data value: %s\n", (char *)begin_list->data);
    ft_list_push_front(&begin_list, data3);
    printf("\nNew link data address: %p\n", begin_list->data);
    printf("New link data value: %s\n", (char *)begin_list->data);
    ft_list_push_front(&begin_list, data2);
    printf("\nNew link data address: %p\n", begin_list->data);
    printf("New link data value: %s\n", (char *)begin_list->data);
    ft_list_push_front(&begin_list, data1);
    printf("\nNew link data address: %p\n", begin_list->data);
    printf("New link data value: %s\n", (char *)begin_list->data);

    int lSize = ft_list_size(begin_list);

    printf("List size = %d\n", lSize);

    ft_list_sort(&begin_list, strcmp);

    int i = 0;
    while (begin_list)
    {
        printf("Node %d data: %s\n", i++, (char *)begin_list->data);
        begin_list = begin_list->next;
    }

    printf("cmp data1 data2: %d\n", strcmp("data1", "data2"));
    printf("cmp data2 data1: %d\n", strcmp("data2", "data1"));


    return (0);
}