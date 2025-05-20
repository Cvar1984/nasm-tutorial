; register parameter position
; 1s     rdi
; 2nd    rsi
; 3rd    rdx
; 4th    rcx
; 5th    r8
; 6th    r9
; Extra arguments (after 6) go on the stack.
extern  printf

section .rodata
    msg    db "Input something: ",0 ; null terminator
    msg2   db "You entered: ", 0
    format db "%s",0

section .text
    global main
    extern printf ; int printf(const char *restrict format, ...);
    extern scanf  ; int scanf(const char *restrict format, ...);

main:
    push rbp
    mov  rbp, rsp

    ; using mov
    mov  rdi, format
    mov  rsi, msg
    xor  eax, eax    ; vardiac functions expect AL=0
    call printf

    ; using stack
    lea  rdi, [rel format]
    sub  rsp, 8            ; reserve 8 bytes for input
    lea  rsi, [rsp]        ; use address of empty stack memory (&input)
    mov  rax, rsi
    push rax
    xor  eax, eax
    call scanf

    mov  rdi, format
    mov  rsi, msg2
    xor  eax, eax    ; vardiac functions expect AL=0
    call printf

    lea  rdi, [rel format]
    pop  rsi               ; second arg from the stack
    xor  eax, eax
    call printf

    leave
    ret