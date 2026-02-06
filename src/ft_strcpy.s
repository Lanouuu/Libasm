bits 64

global ft_strcpy

section .text

; char	*ft_strcpy(char *dest, const char *src);

ft_strcpy:
	mov rax, rdi			; copie du pointeur dest vers rax

	.while:
		mov cl, [rsi] 		; copie du char src vers le sous registre cl
		mov byte [rdi], cl	; copie du char dans cl vers dest

		cmp cl, 0
		je .return			; check avec cmp si cl = \0 => jump vers return

		inc rdi				; incrementation du pointeur dest
		inc rsi				; incrementation du pointeur src
		jmp .while			; on continu la boucle

	.return:
		ret					; on return rax qui contient le pointeur dest