c_ls:
  mov ebp,OTAB
  mov r9d,NOBJ
lst:
  cmp byte ptr [rbp],0
  je lsn
  mov rsi,rbp
  call puts
  mov al,20h
  call putc
  mov eax,[rbp+32]
  call putdec
  mov al,13
  call putc
lsn:
  add rbp,OE
  dec r9d
  jnz lst
  ret
