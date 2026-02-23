bits 64 
default rel

struc s_list
	.data: resq 1
	.next: resq 1
	.size:
endstruc

section .text

global ft_list_sort
extern ft_list_size

switch_node:

	;rdi tete de liste
	;rsi	i - 1
	;rdx	i		|	--> Switch
	;rcx	i + 1	|
	cmp rsi, 0
	je .changehead			; Ca veut dire que le noeud actuel (i) est en premiere position dans la liste

	mov [rsi + s_list.next], rcx
	mov rax, [rcx + s_list.next]
	mov [rcx + s_list.next], rdx
	mov [rdx + s_list.next], rax

	ret

	.changehead:
		mov rax, [rcx + s_list.next]
		mov [rcx + s_list.next], rdx
		mov [rdx + s_list.next], rax
		mov rdi, rcx						; rdi n'est plus qu'un simple pointeur

		ret


; void ft_list_sort(t_list **begin_list, int (*cmp)())
ft_list_sort:

	push rbp
	mov rbp, rsp

	sub rsp, 32
	mov [rbp - 8], rdi				; **begin_list
	mov rdi, [rdi]
	mov [rbp - 16], rdi 			; *node
	mov [rbp - 24], rsi 			; *cmp



	xor rax, rax
	call ft_list_size
	cmp rax, 1
	jbe .return
	mov [rbp - 32], rax

	push r12
	sub rsp, 8
	.while:

		cmp qword [rbp - 32], 1
		je .return

		mov r12 , 1					; r12 = Compteur
		xor r9, r9

		.innerwhile:
			cmp r12, [rbp - 32]
			je .end

			mov r8, [rbp - 16]				; DOUTES
			mov r8, [r8 + s_list.next]		; pointer vers le noeud d'apres

			mov rdi, [rbp - 16]				; pointeur vers le noeud actuel
			mov rdi, [rdi + s_list.data]
			mov rsi, r8
			mov rsi, [rsi + s_list.data]
			call [rbp - 24]					; Call fonction de comparaison

			cmp rax, 0
			jle .skipswitch

			mov rdi, [rbp - 8]
			mov rsi, r9
			mov rdx, [rbp - 16]
			mov rcx, r8

			call switch_node
			mov [rbp - 8], rdi
			.skipswitch:

			mov r9, [rbp - 16]				; Pointeur vers le noeud d'avant
			mov [rbp - 16], r8
			inc r12

			jmp .innerwhile

		.end:
			; Reset [rbp - 16] aka le noeud actuel pour boucler depuis le debut
			dec qword [rbp - 32]
			jmp .while

	.return:
		mov rdi, [rbp - 8]
		add rsp, 8
		pop r12
		mov rsp, rbp
		pop rbp
		ret


		; mettre r8 et r9 en non volatile
		; double pointeur dans switch