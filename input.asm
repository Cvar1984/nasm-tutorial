section .rodata
    question db "how old are you?: "
    disp db "You are, "
    lb db 0xa; \n

    fd_stdin equ 0
    fd_stdout equ 1
    fd_stderr equ 2
    
    sys_read equ 0
    sys_write equ 1
    sys_exit equ 60

section .bss
    age resb 3; reserve 3 byte

section .text
    global _start

_print:
    mov rax, sys_write
    mov rdi, fd_stdout
    ;mov rsi, text
    ;mov rdx, len-text
    syscall
    ret

_lb:; line break sometime necessary
    mov rsi, lb
    mov rdx, 1
    call _print

_read:
    mov rax, sys_read
    mov rdi, fd_stdin
    ;mov rsi, age
    ;mov rdx, 3
    syscall
    ret

_exit:
    mov rax, sys_exit
    ;mov rdi, 0
    syscall

_start:
    mov rsi, question
    mov rdx, 18
    call _print; how old are you?

    mov rsi, age
    mov rdx, 3
    call _read; read your input

    mov rsi, disp
    mov rdx, 9
    call _print; print disp
    
    mov rsi, age
    mov rdx, 3
    call _print; print your input
    
    mov rdi, 0; success
    call _exit; exit success
