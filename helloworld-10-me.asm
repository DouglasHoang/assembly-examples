%include 'functions.asm'

SECTION .text
global _start

_start:
  mov eax, 10
  call printNum

  call quit

printNums:
  mov ebx, 0

printNum:
  cmp eax, ebx
  jle done
  push eax
  mov eax, ebx

  add eax, 48
  push eax

  mov eax, esp
  call sprintLF

  inc ebx

  pop eax
  pop eax
  jmp printNum

done:
  ret