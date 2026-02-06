bits 64

global ft_read
extern __errno_location

section .text

; ssize_t ft_read(int fildes, void *buf, size_t nbyte);

ft_read:
    mov rax, 0
    syscall
    test rax, rax
    js .error
    ret

    .error:
        neg rax
        push rax
        call __errno_location wrt ..plt
        pop rdi
        mov [rax], edi
        mov rax, -1
        ret