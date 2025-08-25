bits 16
;nasm -f bin -o loader32.com loader.asm
org 0x100
boots:
jmp _start
db '$'
loopss:
mov ax,0
int 0x21
int 0x20
_start:
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
cli
jmp kernel
gdt_start:

gdt_null:
    dd 0x0
    dd 0x0

gdt_code:
    dw 0xffff
    dw 0x0
    db 0x0
    db 10011010b
    db 11001111b
    db 0x0

gdt_data:
    dw 0xffff
    dw 0x0
    db 0x0
    db 10010010b
    db 11001111b
    db 0x0

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start
    dd gdt_start

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
kernel:
    mov ax, 0
    mov ss, ax
    mov sp, 0xFFFC

    mov ax, 0
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    cli
    lgdt[gdt_descriptor]
    mov eax, cr0
    or eax, 0x1
    mov cr0, eax
    jmp CODE_SEG:b32

[bits 32]
nop 

b32:
    mov ax, DATA_SEG
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    mov ebp, 0x90000
    mov esp, ebp
;start eax ebx ecx edx to enter on program
    mov eax,0
    mov ebx,0
    mov ecx,0xf000
    mov edx,0
    mov esi,0
    mov edi,0
    ds
    call dword 0x70000
exits:
halts:
    jmp halts
hello:
db 'hello world.....', 0
spere:
signature:
dw 0xaa55

