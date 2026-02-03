bits 64

global ft_strcmp

section .text

; int strcmp(const char *s1, const char *s2);

ft_strcmp:
	xor rax, rax

	.while:

		mov al, byte [rdi]
		mov cl, byte [rsi]

		cmp al, cl
		jne .return

		cmp al, 0
		je .return
		cmp cl, 0
		je .return

		inc rdi
		inc rsi
		jmp .while

	.return:
		movzx eax, al
		movzx ecx, cl
		sub eax, ecx
		ret 