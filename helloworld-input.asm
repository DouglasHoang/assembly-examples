%include 'functions.asm'

SECTION .data
msg1 db 'Please enter your name: ', 0h
msg2 db 'Hello, ', 0h

SECTION .bss
sinput: resb 255

SECTION .text
global _start

_start:
  mov eax, msg1
  call sprint

  mov edx, 255    ; number of bytes to read
  mov ecx, sinput ; reserved space to store our input
  mov ebx, 0      ; read from STDIN file
  mov eax, 3      ; invoke SYS_READ
  int 80h

  mov eax, msg2
  call sprint

  mov eax, sinput
  call sprint

  call quit