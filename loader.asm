bits 16

org 0x100
init:
jmp loads
db '$'
loopss:
mov ax,0
int 0x21
int 0x20
loads:

;load into 7000h:0h

    mov di,0x80
    mov ax,0
    mov al,[di]
    inc ax
    add di,ax
    mov al,0
    mov [di],al
    mov dx,0x82
    mov al,0x0
    mov cx,0
    mov ah,0x3d
    int 0x21
    jc loopss
    mov bx,ax
    mov ax,0x7000
    mov ds,ax
    mov dx,0
    mov cx,0xfff0
    mov ah,0x3f
    push bx
    int 0x21
    jc loopss
    pop bx
    push cs
    pop ds
    mov ah,0x3e
    int 0x21
    jc loopss
    mov di,0x80
    mov ax,0
    mov al,[di]
    inc ax
    add di,ax
    mov al,0
    mov [di],al
    mov al,'$'
    mov [di],al
    mov dx,0x82
    mov ah,0x9
    int 0x21

tables:
    mov si,files
    mov edi,0x7c00
    mov eax,0
    mov es,ax
    mov ecx,64
table2:
    ds
    mov eax,[si]
    es
    mov [edi],eax
    inc si
    inc si
    inc si
    inc si
    inc edi
    inc edi
    inc edi
    inc edi
    dec ecx
    cmp ecx,0
    jnz table2



    jmp 0:0x7c00
files:
incbin "/tmp/pe.bin"

mov ds,ax
mov eax,0
mov ds,ax
mov es,ax
mov ebx,0xb8000
mov ecx,2000
mov eax,0x6021

loop8:
    mov [ebx],ax
    inc ebx
    inc ebx
    dec ecx
    cmp ecx,0
    jnz loop8

loop9:
    jmp loop9
