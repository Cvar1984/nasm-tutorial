section .text
global _start

_add: ; a = param1
      ; a + param2
      ; return a

    ; move stack 1 to rax
    mov rax, [rsp+8] ;64/8 = 8
    ; (rax = rax + stack 2)
    add rax, [rsp+16] ;8+8 = 16
    ret ; return value of rax
_exit: ; exit(%rdi)
    mov rax, 60; sys_exit
    syscall
_start:
    push 2 ; param1 = 2
    push 3 ; param2 = 3
    call _add ; %rax = add(param1, param2)

    mov rdi, rax ; %rdi = %rax
    call _exit ; exit(%rdi)
