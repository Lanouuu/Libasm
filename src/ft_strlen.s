bits 64

global ft_strlen

section .text

ft_strlen:
    xor rax, rax

    .while:
        cmp byte [rdi], 0
        je .return
        inc rdi
        inc rax
        jmp .while

    .return:
        ret

