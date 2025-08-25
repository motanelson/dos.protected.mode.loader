[bits 32]
;org 0x70000
;nasm -f elf32 -o segment.o segment.asm
;x86_64-linux-gnu-ld -m elf_i386 -nostdlib -T link.ld segment.o -o kernel.oo
;x86_64-linux-gnu-objcopy kernel.oo kernel.bin -O binary
global kinit
kinit:
mov eax,0
mov ds,ax
mov es,ax
;jmp 
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