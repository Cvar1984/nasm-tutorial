section .text
    global sum
    global exit

sum:
    push ebp
    mov ebp, esp
             ;[ebp+4] return addr
    mov eax, dword [ebp+8] ; first arg
    add eax, dword [esp+12] ; second arg
    pop ebp
    ret
exit:
    mov eax, 1
    mov ebx, [esp+4]
    int 0x80
    ret
