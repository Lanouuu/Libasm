#include "./include/libasm_bonus.h"

static void    print_list(t_list *list)
{
    int     i = 0;
    t_list  *temp = list;

    while (temp)
    {
        printf("Node %d data: %s\n", i++, (char *)temp->data);
        temp = temp->next;
    }
    return;
}

int main(int ac, char **av)
{
    if (ac != 2)
    {
        dprintf(2, "Need one argument for atoi_base");
        return (1);
    }


    /////////////////////////////////////////// ft_atoi_base
    printf("%d\n", ft_atoi_base(av[1], "0123456789abcdef"));
    printf("\n\n");




    /////////////////////////////////////////// ft_list_push_front
    t_list  *begin_list = NULL;

    char *data1 = strdup("data1");
    char *data2 = strdup("data2");
    char *data3 = strdup("data3");
    char *data4 = strdup("data4");
    char *data5 = strdup("data5");
    if (!data1 || !data2 || !data3 || !data4 || !data5)
    {
        free(data1);
        free(data2);
        free(data3);
        free(data4);
        free(data5);
        return (1);
    }

    ft_list_push_front(&begin_list, data1);
    ft_list_push_front(&begin_list, data2);
    ft_list_push_front(&begin_list, data3);
    ft_list_push_front(&begin_list, data4);
    ft_list_push_front(&begin_list, data5);

    printf("PUSH_FRONT:\n");
    print_list(begin_list);
    printf("\n\n");




    /////////////////////////////////////////// ft_list_size
    int lSize = ft_list_size(begin_list);
    printf("List size = %d\n\n", lSize);
    printf("\n\n");




    /////////////////////////////////////////// ft_list_sort
    ft_list_sort(&begin_list, strcmp);
    printf("LIST_SORT:\n");
    print_list(begin_list);
    printf("\n\n");




    /////////////////////////////////////////// ft_list_remove_if
    ft_list_remove_if(&begin_list, "data3", strcmp, free);
    printf("LIST_REMOVE_IF:\n");
    print_list(begin_list);
    printf("\n\n");




    /////////////////////////////////////////// free
    while (begin_list)
    {
        t_list *temp = begin_list;
        free(begin_list->data);
        begin_list = begin_list->next;
        free(temp);
    }

    return (0);
}