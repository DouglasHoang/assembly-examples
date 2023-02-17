;-----------------------------------------
; int slen(String message)
; String length calculation function
slen:
  push ebx
  mov ebx, eax

nextchar:
  cmp byte [eax], 0
  jz .finished
  inc eax
  jmp nextchar

  .finished:
    sub eax, ebx
    pop ebx
    ret

;---------------------------------------
; void sprint(String message)
; String printing function
sprint:
  push edx
  push ecx
  push ebx
  push eax

  call slen

  mov edx, eax
  pop eax

  mov ecx, eax
  mov ebx, 1

  push eax
  mov eax, 4
  int 80h

  pop eax
  pop ebx
  pop ecx
  pop edx
  ret

;--------------------------------------------------------
; void sprintLF(String message)
; String printing with line feed function
sprintLF:
  call sprint

  call sprintln
  ret

quit:
  mov ebx, 0
  mov eax, 1
  int 80h
  ret

;---------------------------------------
; void sprintln(String message)
; Prints a newline
sprintln:
  push eax,
  mov eax, 0Ah
  push eax
  mov eax, esp
  call sprint
  pop eax
  pop eax
  ret

; Used for single digits only
printDigit:
  push eax

  cmp eax, 10
  jge printDigitReturn

  add eax, 48
  push eax

  mov eax, esp
  call sprint

  pop eax

printDigitReturn:
  pop eax
  ret

itoa:
  push esi
  push edx
  push ecx
  push eax

  mov ecx, 0

  divide_loop:
    mov esi, 10 
    mov edx, 0
    idiv esi

    inc ecx
    push edx

    cmp eax, 0
  jnz divide_loop

  print_loop:
    cmp ecx, 0
    jz itoa_return

    pop eax
    call printDigit
    dec ecx

    jmp print_loop

  itoa_return:
    call sprintln

    pop eax
    pop ecx
    pop edx
    pop esi

    ret

atoi:
  push ebx
  push ecx
  push edx
  push esi
  mov esi, eax
  mov eax, 0
  mov ecx, 0

  .multiply_loop:
    mov ebx, ebx      ; resets both lower and upper bytes of ebx to be 0
    mov bl, [esi+ecx] ; move a single byte into ebx register's lower half

    cmp bl, 48        ; compare ebx register's lower half value against ascii value 48
    jl .finished      ; jump if less than to label finished
    cmp bl, 57        ; compare ebx register's lower half value against ascii value 57
    jg .finished      ; jump if greater than to label finished

    sub bl, 48        ; convert ebx register's lower half to decimal representation of ascii value
    add eax, ebx      ; add ebx to our integer value in eax
    mov ebx, 10       ; move decimal value 10 into ebx
    mul ebx           ; multiply eax by ebx to get place value
    inc ecx           ; increment ecx (counter register)
    jmp .multiply_loop

  .finished:
    cmp ecx, 0        ; compare ecx register's value against decimal 0
    je .restore       ; jump if equal to 0
    mov ebx, 10       ; move decimal value 10 into ebx
    div ebx           ; divide eax by value in ebx

  .restore:
    pop esi
    pop edx
    pop ecx
    pop ebx
    ret