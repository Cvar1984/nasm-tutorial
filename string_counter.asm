section .data
    text db "Hello world", 0xa, 0

section .text
    global _start

_start:
    mov rax, text
    call _print
    call _exit

_print:
    push rax
    xor rbx, rbx
    jmp _printCounter

_printCounter:
    inc rax
    inc rbx
    mov cl, byte [rax]; rcx 64bit(8byte), ecx 32bit(4byte), cx 16bit(2byte), cl 8bit(1byte)
    cmp cl, 0
    jne _printCounter; loop

_printWrite:
    mov rax, 1
    mov rdi, 1
    pop rsi
    mov rdx, rbx
    syscall
    ret

_exit:
    mov rax, 60
    mov rdi, 0
    syscall
;registers size https://wiki.osdev.org/CPU_Registers_x86-64
