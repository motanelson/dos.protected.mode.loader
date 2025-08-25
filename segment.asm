[bits 32]
;org 0x70000
extern kmain
global kinit
kinit:
mov eax,0
mov ds,ax
mov es,ax
jmp kmain
mov ebx,0xb8000
mov ecx,2000
mov eax,0x6021
loop1:
    mov [ebx],ax
    inc ebx
    inc ebx
    dec ecx
    cmp ecx,0
    jnz loop1

loop2:
    jmp loop2

section .note.GNU-stack