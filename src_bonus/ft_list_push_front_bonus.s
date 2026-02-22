bits 64
default rel

struc s_list
	.data: resq 1
	.next: resq 1
	.size:
endstruc

section .text

extern malloc

global ft_list_push_front

; void	ft_list_push_front(t_list **begin_list, void *data)
ft_list_push_front:

	; rdi --> pointe vers l'adresse du debut de la liste
	; rsi --> pointe vers la valeur pour le nouveau noeud

	;1. Allouer l'espace memoire pour le nouveau noeud
	;2. initialiser le nouveau noeud (data + adresse de l'ancien premier noeud)
	;3. Remplacer l'adresse pointee par begin_list par l'adresse du nouveau noeud

	push rdi								; On save les parametres en vue de l'appel a malloc
	push rsi								
	sub rsp, 8								; Pour alignement

	; 1.
	mov rdi, s_list.size
	call malloc								; Allocation du nouveau noeud
	cmp rax, 0								; Check erreur malloc
	je .error

	; A ce stade rax pointe vers le nouveau noeud (pas encore init)

	; 2.
	add rsp, 8								; On realigne
	pop rsi									; On recup *data
	pop rdi									; On recup **begin_list
	mov rcx, [rdi]							; On charge ds rcx l'adresse du premier noeud
	mov [rax + s_list.data], rsi			; Init
	mov [rax + s_list.next], rcx

	; 3.
	mov [rdi], rax							; On modifie la valeur de **begin_list pour qu'elle pointe vers la nouveau
											; premier noeud

	ret

	.error:
		add rsp, 8								; On realigne
		pop rsi									; On recup *data
		pop rdi									; On recup **begin_list
		ret