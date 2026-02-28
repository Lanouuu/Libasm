bits 64
default rel

global ft_strdup
extern ft_strlen
extern malloc
extern __errno_location

section .text

; char    *ft_strdup(const char *s);

ft_strdup:
    push rdi                    ; On conserve le pointeur de la string a dupliquer
    
    call ft_strlen wrt ..plt    ; rax = longueur de la string a dupliquer (sans le \0) = n bytes
    inc rax                     ; on incremente la len pour inclure le \0

    mov rdi, rax
    call malloc wrt ..plt       ; rax = addr de la zone memoire allouee
    test rax, rax
    jz .error

    mov r8, rax
    pop rdx

    ; r8 = addr de la memoire allouee
    ; rdi = addr de la string a dupliquer
    .while:
        mov cl, [rdx]
        mov [r8], cl

        cmp cl, 0
        je .return


        inc r8
        inc rdx
        jmp .while
    
    .return:
        ret

    .error:
        call __errno_location wrt ..plt
        mov dword [rax], 12
        xor rax, rax
        pop rdi
        ret
