bits 64

global ft_strdup
extern ft_strlen
extern malloc
extern __errno_location

section .text

ft_strdup:

    push rdi ; Conserve l'addresse de la string a dupliquer
    
    call ft_strlen wrt ..plt
    ; rax = longueur de la string a dupliquer (sans le \0) = n bytes

    inc rax
    mov rdi, rax
    call malloc wrt ..plt
    ; rax = addr de la zone memoire allouee
    mov r8, rax
    pop rdi

    test rax, rax ; Voir sous quelle forme est retournee l'erreur d'un malloc en asm
    jz .error
    ; error
    ; js .error
    
    ; r8 = addr de la memoire allouee
    ; rdi = addr de la string a dupliquer
    .while:
        mov cl, [rdi]
        mov [r8], cl

        cmp cl, 0
        je .return


        inc r8
        inc rdi
        jmp .while
    
    .return:
        ret

    .error:
        call __errno_location wrt ..plt
        mov dword [rax], 12
        xor rax, rax
        ret
