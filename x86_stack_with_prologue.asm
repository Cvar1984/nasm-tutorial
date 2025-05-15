; read this before continue
; push: decrements %esp by 4 and stores the data at the top (i.e., [esp])
; pop: reads data from where %esp points, moves it into the target register, and then increments %esp by 4
; %esp is a moving reference that always points to the most recently pushed data on the stack
; %ebp is used as a fixed reference point for stack frames and doesn't change unless explicitly modified
; %eip always holds the address of the next instruction to be executed
; call: pushes the address of the next instruction after call (address of call + number of bytes used by call) onto the stack, then jumps to the target
;   - Because when the call instruction runs, %eip still points to the call instruction itself
;   - in x86 and x86_64, typical call instruction (rel32) is 5 bytes (1-byte opcode E8 + 4-byte relative offset)
;   - indirect calls (e.g., call eax, call [rip + offset]) are 2–7 bytes depending on addressing mode
; ret: pops the return address from the stack (from [esp]) and sets %eip to it
; jmp: modifies %eip directly, so no pushing %eip to the stack
; 1 bit = 2^1 = 2 values (0 or 1)
; 1 byte = 8 bit
; 32 bit / 8 = 4 bytes per column or 2^(4*8) = 4,294,967,296 maximum unsigned integer storable in 4 bytes

section .text
global _start
; function _add:
; adds two integers passed via the stack and returns the result in eax
; this version uses a proper function prologue/epilogue
_add:
    push ebp ; save ebp to the stack
    mov ebp, esp ; move ebp to wherever esp located, to establish new base pointer (frame start)
    push esi
    push edi
    push ebx
    ; In this example, memory grows downward (from high to low addresses)
    ; So "down" is the top of the stack
    ; Right side = offset from ebp
    ; Left side  = offset from esp
    ;          _____Stack Memory_____
    ;       +24          2           +12
    ;       +20          3           +8
    ;       +16  address after call  +4
    ;       +12      old ebp          0  <-ebp
    ;       +8          esi          -4
    ;       +4          edi          -8
    ; esp->  0          ebx          -12

    ; skip eip on [ebp+4]
    mov eax, [ebp+8] ;  = 3 or [esp+20]
    add eax, [ebp+12] ; = 2 or [esp+24]
    pop ebx
    pop edi
    pop esi
    mov esp, ebp ; cleanup stack by moving esp to ebp (unecessary for this case cuz esp already at ebp)
    pop ebp ; restore old ebp
    ret ; return eip on the stack and continue to next execution after call ended

_exit:
    mov eax, 1 ; sys_exit https://www.chromium.org/chromium-os/developer-library/reference/linux-constants/syscalls/#i686_1
    int 0x80

_start:
    push 2 ; push value to the stack
    push 3
    call _add ; save current instruction pointer on the stack (push eip)
    mov ebx, eax ; set arg1 for exit to the value of eax we get from _add
    jmp _exit

; Further reading/watching
; https://wiki.osdev.org/CPU_Registers_x86-64
; https://www.youtube.com/watch?v=T03idxny9jE
; https://www.youtube.com/watch?v=8QzOC8HfOqU
; https://www.youtube.com/watch?v=HSlhY4Uy8SA
