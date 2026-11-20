dio:
  push rbx
dio0:
  test r8d,r8d
  jz diod
  mov ebx,r8d
  cmp ebx,128
  jbe dio1
  mov ebx,128
dio1:
  test r10b,r10b
  jz dio2
  mov ecx,ebx
  shl ecx,6
  mov rsi,rdi
  mov edi,BOUNCE
  rep movsq
  mov rdi,rsi
dio2:
  call bop
  jc dioe
  test r10b,r10b
  jnz dio3
  mov ecx,ebx
  shl ecx,6
  mov esi,BOUNCE
  rep movsq
dio3:
  add r11d,ebx
  sub r8d,ebx
  jmp dio0
diod:
  clc
dioe:
  pop rbx
  ret
