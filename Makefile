all: argv-print.asm
	nasm -f elf32 argv-print.asm
	ld -m elf_i386 -o argv-print argv-print.o -lc -I/lib/ld-linux.so.2 -L /usr/lib32
