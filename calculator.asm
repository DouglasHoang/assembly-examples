%include 'functions.asm'

SECTION .text
global _start

_start:
  pop ecx
  pop edx
  sub ecx, 1
  mov edx, 0

next_arg:
  cmp ecx, 0h
  jz no_more_args
  pop eax
  call atoi
  add edx, eax
  dec ecx
  jmp next_arg

no_more_args:
  mov eax, edx
  call itoa
  call quit