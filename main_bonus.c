#include "./include/libasm_bonus.h"

#include <stdlib.h>
#include <stdio.h>

int main(int ac, char **av)
{
    (void)ac;
    (void)av;
    // printf("%d\n", ft_atoi_base(av[1], "0123456789abcdef"));

    t_list  *begin_list = NULL;

    int *data1 = malloc(sizeof(int));
    int *data2 = malloc(sizeof(int));
    int *data3 = malloc(sizeof(int));
    if (!data1 || !data2 || !data3)
        return (1);

    *data1 = 1;
    *data2 = 2;
    *data3 = 3;

    printf("data1 address: %p, value: %d\n", data1, *data1);
    printf("data2 address: %p, value: %d\n", data2, *data2);
    printf("data3 address: %p, value: %d\n", data3, *data3);

    ft_list_push_front(&begin_list, data1);
    printf("\nNew link data address: %p\n", begin_list->data);
    printf("New link data value: %d\n", *(int *)begin_list->data);
    ft_list_push_front(&begin_list, data2);
    printf("\nNew link data address: %p\n", begin_list->data);
    printf("New link data value: %d\n", *(int *)begin_list->data);
    ft_list_push_front(&begin_list, data3);
    printf("\nNew link data address: %p\n", begin_list->data);
    printf("New link data value: %d\n", *(int *)begin_list->data);
    ft_list_push_front(&begin_list, data3);
    printf("\nNew link data address: %p\n", begin_list->data);
    printf("New link data value: %d\n", *(int *)begin_list->data);

    int lSize = ft_list_size(begin_list);

    printf("List size = %d\n", lSize);

    for (int i = 0; i < lSize; i++)
    {
        printf("Node %d data: %d\n", i, *(int *)begin_list->data);
        begin_list = begin_list->next;
    }


    
    return (0);
}