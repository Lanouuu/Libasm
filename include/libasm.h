#ifndef LIBASM_H
# define LIBASM_H

#include <error.h>
#include <stdio.h>
#include <unistd.h>

size_t  ft_strlen(const char *s);
int		ft_strcmp(const char *s1, const char *s2);
char	*ft_strcpy(char *dest, const char *src);
ssize_t ft_write(int fildes, const void *buf, size_t nbyte);
ssize_t ft_read(int fildes, void *buf, size_t nbyte);
char    *ft_strdup(const char *s);

#endif