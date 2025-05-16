section .data
    prompt db "Enter something: ", 0
    format db "%d", 0
    result db "You entered: %d", 10, 0 ; "%d" with newline

section .text
    global main
    extern printf
    extern scanf
    extern exit

main:
    push ebp                ; Save old base pointer
    mov ebp, esp            ; Set base pointer for this function's stack frame

    sub esp, 4              ; reserve 4 bytes for local variable (e.g., user input)

    push prompt             ; printf(prompt)
    call printf
    add esp, 4              ; clean up prompt on the stack

    lea eax, [ebp-4]        ; [esp] Load address of reserved local variable (pointer)
    push eax                ; Argument 2: store address of pointer to stack

    push format             ; Argument 1: format string "%d"
    call scanf              ; scanf("%d", &input)
    add esp, 8              ; clean up pointer address and format

    mov eax, [ebp-4]        ; [esp] get the scanned integer value from local variable
    push eax                ; Argument 2: value from local variable
    push result             ; Argument 1: format string
    call printf             ; printf("You entered: %d", input)
    add esp, 8              ; clean up format string and argument 2 value

    ;add esp, 4              ; clean up reserved local variable

    mov esp, ebp            ; reset stack pointer
    pop ebp                 ; restore old base pointer

    push 0
    call exit
