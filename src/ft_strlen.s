bits 64

global ft_strlen

section .text
    ft_strlen:
        mov rax, rdi
        add rax, rsi
        ret