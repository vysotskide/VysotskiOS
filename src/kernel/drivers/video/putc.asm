putc:
  cmp dword ptr gs:[8],0
  jne pring
vputc:
  push rax
  push rcx
  push rdx
  push rsi
  push rdi
  mov ecx,[cpos]
  cmp al,13
  je pnl
  cmp al,8
  je pbs
  mov ah,07h
  mov edi,0B8000h
  mov [rdi+rcx*2],ax
  inc ecx
  jmp pchk
pnl:
  mov eax,ecx
  xor edx,edx
  mov esi,80
  div esi
  sub ecx,edx
  add ecx,80
  jmp pchk
pbs:
  cmp ecx,80
  jbe pchk
  dec ecx
  mov edi,0B8000h
  mov word ptr [rdi+rcx*2],0720h
pchk:
  cmp ecx,2000
  jb pend
  mov esi,0B8140h
  mov edi,0B80A0h
  mov ecx,460
  rep movsq
  mov rax,0720072007200720h
  mov ecx,20
  rep stosq
  mov ecx,1920
pend:
  mov [cpos],ecx
  mov dx,3D4h
  mov al,0Fh
  out dx,al
  inc dx
  mov al,cl
  out dx,al
  dec dx
  mov al,0Eh
  out dx,al
  inc dx
  mov al,ch
  out dx,al
  pop rdi
  pop rsi
  pop rdx
  pop rcx
  pop rax
  ret
