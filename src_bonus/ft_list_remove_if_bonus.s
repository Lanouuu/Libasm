bits 64
default rel

global ft_list_remove_if
extern free

struc s_list
	.data: resq 1
	.next: resq 1
	.size:
endstruc

section .text

; void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));

ft_list_remove_if:

    ; rdi -> tete de liste
    ; rsi -> string de reference
    ; rdx -> strcmp
    ; rcx -> free_fct

    push rbp
    mov rbp, rsp

    sub rsp, 32
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov [rbp - 24], rdx
    mov [rbp - 32], rcx

    push rbx
    push r12

    mov rbx, [rdi]

    xor r12, r12

    .while:
        cmp rbx, 0
        je .return

        mov rdi, [rbx + s_list.data]
        mov rsi, [rbp - 16]

        call [rbp - 24]
        cmp eax, 0
        je .delete

        mov r12, rbx
        mov rbx, [rbx + s_list.next]
        jmp .while

    .delete:
        mov rdi, [rbx + s_list.data]
        call [rbp - 32]

        cmp r12, 0
        je .deletehead

        mov r9, [rbx + s_list.next]
        mov [r12 + s_list.next], r9

        mov rdi, rbx
        mov rbx, [rbx + s_list.next]
        
        call free wrt..plt

        jmp .while



    .deletehead:
        mov rdi, rbx
        mov rbx, [rbx + s_list.next]
        mov r8, [rbp - 8]
        mov [r8], rbx

        call free wrt..plt

        jmp .while


    .return:
        mov rdi, [rbp - 8]
        pop r12
        pop rbx
        mov rsp, rbp
        pop rbp
        ret