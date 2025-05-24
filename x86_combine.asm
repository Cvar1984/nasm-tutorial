section .text
    global sum
    global exit

sum:
    push ebp
    mov ebp, esp
             ;[ebp+4] return addr
    mov eax, [ebp+8] ; first arg
    add eax, [esp+12] ; second arg
    pop ebp
    ret
exit:
    mov eax, 1
    pop ebx
    int 0x80
    ret
