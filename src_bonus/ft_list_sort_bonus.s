bits 64 
default rel

struc s_list
	.data: resq 1
	.next: resq 1
	.size:
endstruc

section .text

global ft_list_sort
extern ft_list_push_front

insert_node:



; void ft_list_sort(t_list **begin_list, int (*cmp)())
ft_list_sort:

	push rbp
	mov rbp, rsp

	sub rsp, 16
	mov [rbp - 8], rdi				; **begin_list
	mov [rbp - 16], rsi 			; *cmp


	push rbx
	push r12
	mov rdi, [rdi]
	mov rbx, [rdi + s_list.next]	; cursor sur la liste non triee
	mov [rdi + s_list.next], 0
	mov r12, rdi

	.while: 
		cmp rbx, 0					; head == NULL
		je .return

		; utiliser r12 comme pointeur vers sorted + le noeud de la liste courrante a trier
		call insert_node

		mov rbx, [rbx + s_list.next]	; rbp24 contient l'adresse du premier node
		jmp .while

	.return:
		mov rdi, [rbp - 8]
		mov [rdi], r12
		pop r12
		pop rbx
		mov rsp, rbp
		pop rbp
		ret
