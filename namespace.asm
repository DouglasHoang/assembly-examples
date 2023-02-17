%include 'functions.asm'

SECTION .data
msg1 db 'Jumping to finished label.', 0h
msg2 db 'Inside subroutine number: ', 0h
msg3 db 'Inside subroutine "finished".', 0h

SECTION .text
global _start

_start:

subroutine_one:
  mov eax, msg1
  call sprintLF
  jmp .finished

  .finished:
    mov eax, msg2
    call sprint
    mov eax, 1
    call printDigit

subroutine_two:
    mov eax, msg1
    call sprintLF
    jmp .finished

  .finished:
    mov eax, msg2
    call sprint
    mov eax, 2
    call printDigit

    mov eax, msg1
    call sprintLF
    jmp finished

finished:
  mov eax, msg3
  call sprintLF
  call quit