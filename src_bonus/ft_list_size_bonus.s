bits 64
default rel

struc s_list
	.data: resq 1
	.next: resq 1
	.size:
endstruc

section .text

global ft_list_size

; int	ft_list_size(t_list *begin_list);
ft_list_size:

	; rdi = *begin_list

	; Boucle (endif next == null --> 0)
	; Incrementer rax a chaque saut

	xor rax, rax

	push rdi							; on save rdi 

	.while:
		cmp rdi, 0						; Si rdi == NULL on return
		je .return
		mov rdi, qword [rdi + s_list.next]	; rdi = *next
		inc rax							; counter++
		jmp .while

	.return:
		pop rdi							; On recharge rdi
		ret