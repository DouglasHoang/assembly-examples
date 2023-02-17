all:
	nasm -f elf -g -F dwarf ${name}.asm	-l build/${name}.lst -o build/${name}.o
	ld -m elf_i386 build/${name}.o -o build/${name}
