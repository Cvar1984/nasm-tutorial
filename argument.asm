section .rodata
separator db 0x20
linebreak db 0xa
sys_write equ 1
sys_exit equ 60
sys_stdout equ 1

section .text
global _start

strlen:
    cmp byte [rdi], 0
    jne sloop
    ret
    jmp write
sloop:
    inc rdi
    inc rax
    jmp strlen
_start:
    pop r8
    pop rsi
    dec r8
    jz  exit
check_args:
    xor rax, rax
    mov qword rdi, [rsp]; uint64_t arg1
    call strlen
write:
    mov rdx, rax;

    mov rax, sys_write
    mov rdi, sys_stdout
    pop rsi
    syscall
    
    mov rax, sys_write
    mov rsi, separator; space
    mov rdx, 1
    syscall
    
    dec r8
    jnz check_args
    
    mov rax, sys_write
    mov rsi, linebreak; \n
    syscall
exit:
    mov rax, sys_exit
    mov rdi, 0
    syscall
