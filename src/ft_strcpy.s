bits 64

global ft_strcpy

section .text

ft_strcpy:

	mov rax, rdi

	.while:
		mov cl, [rsi]
		mov byte [rdi], cl 

		cmp cl, 0
		je .return

		inc rdi
		inc rsi
		jmp .while

	.return:
		ret