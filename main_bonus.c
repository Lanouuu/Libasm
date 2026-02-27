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

    char *data1 = strdup("data1");
    char *data2 = strdup("data2");
    char *data3 = strdup("data3");
    char *data4 = strdup("data4");
    char *data5 = strdup("data5");
    if (!data1 || !data2 || !data3 || !data4 || !data5)
        return (1);

    ft_list_push_front(&begin_list, data1);
    ft_list_push_front(&begin_list, data2);
    ft_list_push_front(&begin_list, data3);
    ft_list_push_front(&begin_list, data4);
    ft_list_push_front(&begin_list, data5);

    int lSize = ft_list_size(begin_list);

    printf("List size = %d\n\n", lSize);
    
    int i = 0;
    t_list *curs = begin_list;
    printf("PUSH_FRONT\n");
    while (begin_list)
    {
        printf("Node %d data: %s\n", i++, (char *)begin_list->data);
        begin_list = begin_list->next;
    }

    begin_list = curs;
    ft_list_sort(&begin_list, strcmp);
    curs = begin_list;
    printf("\n\n");

    i = 0;
    printf("LIST_SORT\n");
    while (begin_list)
    {
        printf("Node %d data: %s\n", i++, (char *)begin_list->data);
        begin_list = begin_list->next;
    }
    printf("\n\n");


    begin_list = curs;
    ft_list_remove_if(&begin_list, "data3", strcmp, free);
    printf("LIST_REMOVE_IF\n");
    i = 0;
    while (begin_list)
    {
        printf("Node %d data: %s\n", i++, (char *)begin_list->data);
        begin_list = begin_list->next;
    }

    begin_list = curs;
    i = 0;
    while (begin_list)
    {
        t_list *temp = begin_list;
        free(begin_list->data);
        begin_list = begin_list->next;
        free(temp);
    }

    return (0);
}