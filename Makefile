all: argvtest.asm
	nasm -f elf32 argvtest.asm
	ld -m elf_i386 -o argvtest argvtest.o -lc -I/lib/ld-linux.so.2 -L /usr/lib32
