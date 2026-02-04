bits 64

global ft_strdup
extern ft_strlen
extern malloc

section .text

ft_strdup:

    push rdi ; Conserve l'addresse de la string a dupliquer

    call ft_strlen
    ; rax = longueur de la string a dupliquer (sans le \0) = n bytes

    inc rax
    mov rdi, rax
    call malloc
    ; rax = addr de la zone memoire allouee

    test rax, rax ; Voir sous quelle forme est retournee l'erreur d'un malloc en asm
    ; error
    ; js .error
    
    
    pop rdi
    ; rax = addr de la memoire allouee
    ; rdi = addr de la string a dupliquer
    .while:
        mov cl, [rdi]
        mov [rax], cl

        cmp cl, 0
        je .return


        inc rax
        inc rdi
        jmp .while
    
    .return:
        ret
