section .rodata
    msg db 'Ramdhan Firmansyah', 0xa
    len equ $-msg
    
    ;sys call list
    sys_exit equ 1
    sys_fork equ 2
    sys_read equ 3
    sys_write equ 4
    sys_open equ 5
    sys_close equ 6

     ;file descryptor list
     stdin equ 0
     stdout equ 1

section .text
    global _start

_start:
    mov edx, len ; msg length
    mov ecx, msg
    mov ebx, stdout; 1
    mov eax, sys_write; 4
    int 0x80; kernel call

    mov eax, sys_exit; 1
    int 0x80; kernel call
