extern printf

section .rodata
    msg db "Hello World", 0xa,0 ; newline, null terminator
    format db "%s",0

section .text
    global main

main:
    push rbp; Create a stack-frame, re-aligning the stack to 16-byte alignment before calls
    mov rdi, format; %s
    mov rsi, msg; Hello World\n
    call printf

    pop rbp
    mov rdi, rax
    mov rax, 60
    syscall