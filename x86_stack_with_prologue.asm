section .text
global _start
; with prologue and epilogue
_add:
    push ebp ; save ebp to the stack
    mov ebp, esp ; move ebp to whatever esp located at
    push esi
    push edi
    push ebx
    
    ; skip return address of _add on [ebp+4]
    mov eax, [ebp+8] ;  = 3 or [esp+20] 
    add eax, [ebp+12] ; = 2 or [esp+24]
    pop ebx
    pop edi
    pop esi
    mov esp, ebp ; cleanup stack by moving esp to ebp (unecessary for this case cuz esp already at ebp)
    pop ebp ; return old ebp
    ret ; return eip on the stack

_exit:
    mov eax, 1 ; syscall for exit
    int 0x80

_start:
    push 2 ; push value to the stack
    push 3
    call _add ; save current instruction pointer on the stack (push eip)
    mov ebx, eax ; set arg1 for exit to the value of eax we get from _add
    jmp _exit


; Memory growing from top to bottom.
; number on the right relative to ebp position.
; number on the left relative to esp position
; ebp is used as fixed reference while esp used as relative refrence
; 32bit/8 = 4 bytes per memory column.
; call: pushes return address and modifies eip.
; jump: modifies eip directly

;         _____Stack Memory____
;      +24        2             +12
;      +20        3             +8
;      +16 saved eip from _add  +4
;      +12      old ebp          0  <-ebp
;      +8         esi           -4
;      +4         edi           -8
;esp->  0         ebx           -12 

; Great you understand how stack flow works now watch this
; https://www.youtube.com/watch?v=T03idxny9jE
; https://www.youtube.com/watch?v=8QzOC8HfOqU
; https://www.youtube.com/watch?v=HSlhY4Uy8SA
