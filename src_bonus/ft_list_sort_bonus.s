bits 64 
default rel

struc s_list
	.data: resq 1
	.next: resq 1
	.size:
endstruc

section .text

global ft_list_sort


; void ft_list_sort(t_list **begin_list, int (*cmp)())
ft_list_sort:

	push rbp
	mov rbp, rsp

	sub rsp, 16
	mov [rbp - 8], rdi				; **begin_list
	mov [rbp - 16], rsi 			; *cmp

	push rbx
	push r12
	push r13
	push r14
	push r15
	sub rsp, 8
	mov rdi, [rdi]

	cmp rdi, 0
	je .emptylist

	mov rbx, [rdi + s_list.next]	; cursor sur la liste non triee
	mov qword [rdi + s_list.next], 0
	mov r12, rdi

	.while: 
		cmp rbx, 0					; head == NULL
		je .return

		; rbx = noeud a inserer
		; r12 = tete de liste sorted
		; r13 = cursor sur sorted			| rcx
		; r14 = save rbx->next				| r9
		; r15 = save noeud d'avant			| r8



		mov r13, r12	
		mov r14, [rbx + s_list.next]
		mov qword [rbx + s_list.next], 0
			.innerwhile:			; Boucle de comparaison data: current vs sorted data
				cmp qword r13, 0
				je .appendend

				mov rdi, [rbx + s_list.data]	; current->data
				mov rsi, [r13 + s_list.data]	; sorted->data
				call [rbp - 16]

				cmp eax, 0
				jle .appendbefore

				mov r15, r13
				mov r13, [r13 + s_list.next] 
				jmp .innerwhile
			.appendend:
				mov [r15 + s_list.next], rbx
				jmp .innerend
			.appendbefore:

				cmp r13, r12
				je .appendbegin

				; A -> C | on veut inserer B
				; set A.next = B
				; set B.next = C
				mov [r15 + s_list.next], rbx
				mov [rbx + s_list.next], r13

				jmp .innerend
			
			.appendbegin:
				mov [rbx + s_list.next], r13
				mov r12, rbx
				jmp .innerend

			.innerend:

		mov rbx, r14
		jmp .while

	.return:
		mov rdi, [rbp - 8]
		mov [rdi], r12
		pop r15
		pop r14
		pop r13
		pop r12
		pop rbx
		mov rsp, rbp
		pop rbp
		ret

	.emptylist:
		pop r15
		pop r14
		pop r13
		pop r12
		pop rbx
		mov rsp, rbp
		pop rbp
		ret