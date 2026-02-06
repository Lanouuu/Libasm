bits 64

global ft_write
extern __errno_location

section .text

; ssize_t ft_write(int fildes, const void *buf, size_t nbyte);

ft_write:
    mov rax, 1                              ; on stock 1 dans rax, 1 = write
    syscall                                 ; syscall de write
    test rax, rax                           
    js .error                               ; on verifie si write a renvoye une valeur negative avec test -> jump vers .error
    ret

    .error:
        neg rax                             ; on rend positif le code d'erreur
        push rax                            ; on stock le code d'erreur dans la stack
        call __errno_location wrt ..plt     ; on recupere l'adresse de errno
        pop rdi                             ; on recupere le code d'erreur depuis la stack vers rdi
        mov [rax], edi                      ; on copie le code d'erreur à l'adresse de errno
        mov rax, -1                         ; on return -1 (comportement de write)
        ret