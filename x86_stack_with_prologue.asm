section .text
global _start
; with prologue and epilogue
_add:
    push ebp ; save ebp to the stack
    mov ebp, esp ; move ebp to whatever esp located at
    
    ; skip return address of _call on [ebp+4]
    mov eax, [ebp+8] ; 32bit/8 = 4bytes + 4bytes = 8bytes 
    add eax, [ebp+12] ; 8+4 = 12
    mov esp, ebp ; cleanup stack
    pop ebp ; return old ebp
    ret ; return eax sum

_exit:
    mov eax, 1 ; syscall for exit
    int 0x80

_start:
    push 2 ; push value to the stack
    push 3
    call _add ; return address pushed to the stack

    mov ebx, eax ; set arg1 for exit to the return value of _add
    jmp _exit


; Memory growing from top to bottom
; number relative to ebp position

;____Stack Memory____;
;          2        ; +12
;          3        ; +8
;  ret addr of add  ; +4
;      old ebp      ;  0  <-ebp
;    empty space    ; -4  <-esp (esp could be pointing to empty space)