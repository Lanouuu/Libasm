bits 64

global ft_atoi_base

section .text

; int ft_atoi_base(char *str, char *base);

; On trim la string des whitspaces de devant (check si whitespace appartient a la base)
; Droit a UN SEUL + ou - avant un char qui appartient a la base
; Le +/- doit etre colle au char de la base sinon ret 0
; On convertit jusqu'a un char qui n'est pas dans base ou fin

; Gaffe overflows (si overflow retourne -1 (pas une erreur))

ft_atoi_base:

	; Gestion d'erreur

	xor rax, rax

	xor rcx, rcx	; +/- counter

    .skip_whitespace:
            movzx eax, byte [rdi]
            cmp al, ' '
            je .next
            cmp al, 9
            jb .sign
            cmp al, 13
            ja .sign
    .next:
        inc rdi
        jmp .skip_whitespace
	
		push rdi
	.sign:
		call belongs_to_base

	pop rdi
	inc rdi
    
	.while:
		
		; Si fin de la string fin de la boucle 
		cmp byte [rdi], 0
		je .return

			



		inc rdi
		jmp .while

    .return:

    .error:

    .overflow:
