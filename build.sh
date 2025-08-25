
printf "\033c\033[43;30m\n"
mkdir bin 2>/dev/null
nasm -f bin -o /tmp/pe.bin pe.asm
nasm -f bin -o ./bin/loader32.com loader.asm
nasm -f elf32 -o /tmp/segment.o segment.asm
x86_64-linux-gnu-gcc -c -m32 -o /tmp/kernel.o  kernel.c -nostdlib
x86_64-linux-gnu-ld -m elf_i386 -nostdlib -T link.ld /tmp/segment.o /tmp/kernel.o -o /tmp/kernel.oo
x86_64-linux-gnu-objcopy /tmp/kernel.oo ./bin/kernel.bin -O binary
