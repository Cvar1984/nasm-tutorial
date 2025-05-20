section .text

global _start

multiply:; multiply ebx(arg0), ecx(arg1)
    push ebp; save pointer
    mov ebp, esp

    sub esp, 8; reserve 2 columns of memory on the stack
    ; push are preferred but you could also store value to stack like this, using ebp is a good idea but you on your own
    mov dword [esp+4], ebx; store arg0 to stack
    mov dword [esp], ecx; store arg1 to stack

    mov eax, dword [esp]; load ecx value
    mul dword [esp+4]; unsigned multiply with eax by default

    add esp, 8; free reserved space by poping 2 columns of stack
    mov esp, ebp; free reserved space by reseting stack pointer to base pointer

    pop ebp; restore saved base pointer
    ret

_start:
    mov ebx, 2
    mov ecx, 3
    call multiply

    mov ebx, eax; store return value to arg0
    mov eax, 1; sys_exit
    int 0x80; kernel call
