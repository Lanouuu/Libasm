bits 64
default rel

global ft_atoi_base
extern ft_strlen

section .text

; int ft_atoi_base(char *str, char *base);

; On trim la string des whitspaces de devant
; Droit a UN SEUL + ou - avant un char qui appartient a la base
; Le +/- doit etre colle au char de la base sinon ret 0
; On convertit jusqu'a un char qui n'est pas dans base ou fin

; Gaffe overflows (si overflow retourne -1 (pas une erreur))

; bool  check_base_char(char **base);
; Return 0 si la base contient des char interdits
check_base_char:
    xor rax, rax
    push rdi

    .while:
        mov dl, byte [rdi]

        cmp dl, 0
        je .endwhile

        cmp dl, 14
        jb .return
        cmp dl, 127
        ja .return
        cmp dl, ' '
        je .return
        cmp dl, '-'
        je .return
        cmp dl, '+'
        je .return
        inc rdi
        jmp .while

    .endwhile:
        mov rax, 1
        
    .return:
        pop rdi
        ret
        
; bool  check_base_dup(char **base);
; Return 0 si la base contient un doublon
check_base_dup:
    xor rax, rax
    push rdi

    .while:
        mov dl, byte [rdi]
        
        cmp dl, 0
        je .endwhile

        mov rcx, rdi

        .iter:
            inc rcx
            cmp byte [rcx], 0
            je .enditer
            cmp dl, byte [rcx]
            je .return
            jmp .iter
            
        .enditer:
            inc rdi
            jmp .while

    .endwhile:
        mov rax, 1

    .return:
        pop rdi
        ret

; void  skip_whitespace(char **str);
; Incremente rdi pour rogner les whitespaces
skip_whitespace:
    .skip:
        movzx eax, byte [rdi]
        cmp al, ' '
        je .next
        cmp al, 9
        jb .return
        cmp al, 13
        ja .return
    .next:
        inc rdi
        jmp .skip
    .return:
        ret

; void   check_plus_minus(char c)
; Check si le premier char est un + ou un - et renvoie respectivement 1 ou -1
; Return 0 si autre 
check_plus_minus:
    xor rax, rax
    
    cmp byte [rdi], '+'
    je .plus
    cmp byte [rdi], '-'
    je .minus
    ret

    .plus:
        inc rdi
        mov rax, 1
        ret

    .minus:
        inc rdi
        mov rax, -1
        ret

; bool  belongs_to_base(char c, char **base);
; Return 1 si c appartient a base
belongs_to_base:
    xor rax, rax
    xor rcx, rcx

    .while:
        cmp byte [rsi + rcx], 0
        je .return

        cmp dil, byte [rsi + rcx]
        je .true
        
        inc rcx
        jmp .while

    .true:
        mov rax, 1

    .return:
        ret


; int   get_index(char c, char **base)
; Conserve rsi
; Renvoie l'indice dans le base du char c
get_index:
    xor rcx, rcx

    .find:
        cmp dil, byte [rsi + rcx]
        je .found

        inc rcx
        jmp .find

    .found:
        mov rax, rcx
        ret


; int ft_atoi_base(char *str, char *base);
ft_atoi_base:

    ; -8 ==> str
    ; -16 ==> base
    ; -24 ==> longueur de la base
    ; -32 ==> -1 1 0 -> sign

    ; Prologue stack frame
    push rbp 
    mov rbp, rsp
    sub rsp, 32                             ; Parceque 4 variable + alignement

    ; On sauvegarde (soit stack frame soit registre callee-save (non volatile) genre r12 ou rbx)
    mov [rbp - 8], rdi                      ; Param 1 = str 
    mov [rbp - 16], rsi                     ; Param 2 = base

    mov rdi, [rbp - 16]                     ; On recup la base pour check
    call ft_strlen wrt..plt
    cmp rax, 0
    je .returnerror
    mov [rbp - 24], rax                     ; On save en local

    call check_base_char
    cmp rax, 0
    je .returnerror

    call check_base_dup
    cmp rax, 0
    je .returnerror


    mov rdi, [rbp - 8]                      ; Charge var1 (str) dans rdi
    call skip_whitespace                    ; Logiquement rdi pointe le premier "vrai" char

    call check_plus_minus
    mov [rbp - 32], rax                     ; Valeur +/- stockee en variable local aka stackframe

    push rbx
    sub rsp, 8                              ; Alignement stack
    xor rbx, rbx                            ; On va stocker la valeur ici
    mov r10, rdi                            ; On va iterer avec r10 pour laisser rdi prendre le char

  	.while:
		; Si fin de la string fin de la boucle 
		cmp byte [r10], 0
		je .return

        ; check si char est dans la base
        movzx rdi, byte [r10]               ; Chargement du char pour le call a fonction
	    call belongs_to_base
        cmp rax, 0
        je .return

			
        call get_index                      ; get l'index du char dans la base

        imul rbx, [rbp - 24]                ; On multiplie par la longueur de la base
        jo .overflow
        add rbx, rax                        ; On ajoute l'index au resultat
        jo .overflow
        
        ; check overflow flag

		inc r10
		jmp .while


    .return:
        mov rax, rbx
        cmp dword [rbp - 32], -1
        je .invert

    .epilogue:
        add rsp, 8
        pop rbx
        mov rsp, rbp
        pop rbp
        ret

    .invert:
        imul rax, -1
        jo .overflow
        jmp .epilogue

    .returnerror:
        mov rsp, rbp
        pop rbp
        mov rax, 0
        ret

    .overflow:
        mov rax, 0
        jmp .epilogue
