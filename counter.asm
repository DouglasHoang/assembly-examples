%include 'functions.asm'

SECTION .text
global _start

_start:
  mov ecx, 0

nextNumber:
  inc ecx
  mov eax, ecx
  call itoa

  cmp ecx, 20
  jne nextNumber

  call quit

