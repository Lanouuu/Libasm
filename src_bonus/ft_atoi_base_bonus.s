bits 64

global ft_atoi_base

section .text

; int ft_atoi_base(char *str, char *base);

; On trim la string des whitspaces de devant
; Droit a UN SEUL + ou - avant un char qui appartient a la base
; Le +/- doit etre colle au char de la base sinon ret 0
; On convertit jusqu'a un char qui n'est pas dans base ou fin

; Gaffe overflows (si overflow retourne -1 (pas une erreur))

; bool  check_base_char(char **base);
check_base_char:
    xor rax, rax
    push rdi

    .while:
        movzx edx, byte [rdi]

        cmp dl, 0
        je .endwhile

        cmp dl, 9
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
        
; bool  check_base_dup(char **base);                0 1 2 3 4 5
check_base_dup:
    xor rax, rax
    push rdi

    .while:
        movzx edx, byte [rdi]
        
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

; bool  belongs_to_base(char c, char **base);
belongs_to_base:
    xor rax, rax
    push rsi

    .while:
        cmp byte [rsi], 0
        je .return

        cmp dil, byte [rsi]
        je .true
        
        inc rsi
        jmp .while

    .true:
        mov rax, 1

    .return:
        pop rsi
        ret


check_plus_minus:
    xor rax, rax
    
    cmp byte [rdi], '+'
    je .plus
    cmp byte [rdi], '-'
    je .minus
    jmp .return
    .plus:
        inc rdi
        mov rax, 1 
    .minus:
        inc rdi
        mov rax, -1
    .return:
        ret


ft_atoi_base:

    ; gestion d'erreur base
    push rdi
    mov rdi, rsi
    call check_base_char
    cmp rax, 0
    je .error

    call check_base_char
    cmp rax, 0
    je .error

    mov rsi, rdi
    pop rdi
	xor rax, rax

    ; skip les whitespaces
    call skip_whitespace

    

	.while:
		
        ; check si char est dans la base
	    call belongs_to_base
    
		; Si fin de la string fin de la boucle 
		cmp byte [rdi], 0
		je .return

			



		inc rdi
		jmp .while

    .return:

    .error:

    .overflow:
