ahci_ident:
  xor r11d,r11d
  mov ebx,1
  xor r10d,r10d
  mov r12d,0ECh
  call ahci_do
  jc ahq9
  mov esi,BOUNCE
  mov eax,[rsi+120]
  test word ptr [rsi+166],400h
  jz ahq1
  mov rax,[rsi+200]
ahq1:
  mov [dcap],rax
  clc
ahq9:
  ret
