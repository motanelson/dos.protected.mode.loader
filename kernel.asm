[bits 32]
;org 0x70000
;nasm -f elf32 -o kernel.o kernel.asm
;x86_64-linux-gnu-ld -m elf_i386 -nostdlib -T link.ld kernel.o -o kernel.oo
;x86_64-linux-gnu-objcopy kernel.oo kernel.bin -O binary
extern kinit
kinit:
mov eax,0
mov ds,ax
mov es,ax
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