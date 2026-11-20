poweroff:
  call dosave
  call acpioff
  cmp byte ptr [hv],0
  je po9
  mov dx,604h
  mov ax,2000h
  out dx,ax
  mov dx,0B004h
  out dx,ax
  mov dx,4004h
  mov ax,3400h
  out dx,ax
  mov dx,8900h
  lea rsi,[mshut]
po1:
  lodsb
  test al,al
  jz po2
  out dx,al
  jmp po1
po2:
  mov eax,1000
  call sleep
po9:
  lea rsi,[mpoff]
  jmp puts
