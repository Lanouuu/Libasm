bits 64

global ft_strlen

section .text

; size_t  ft_strlen(const char *s);

ft_strlen:
    xor rax, rax            ; rax = 0

    .while:
        cmp byte [rdi], 0
        je .return          ; check avec cmp si [rdi] = \0 => jump vers return
        inc rdi             ; incrementation du pointeur de la string
        inc rax             ; incrementation du compteur de len
        jmp .while          ; on continu la boucle

    .return:
        ret                 ; on return rax qui contient la len

