c_ps:
  xor ebx,ebx
ps1:
  cmp ebx,[ncpu]
  jae ps9
  mov eax,ebx
  call putdec
  mov al,':'
  call putc
  mov r8d,ebx
  shl r8d,9
  add r8d,CPUS
  xor ecx,ecx
ps2:
  mov esi,ecx
  shl esi,5
  mov eax,[r8+rsi+144]
  test eax,1
  jz ps3
  push rax
  mov al,20h
  call putc
  pop rax
  mov al,ah
  call putc
ps3:
  inc ecx
  cmp ecx,FPC
  jb ps2
  mov al,13
  call putc
  inc ebx
  jmp ps1
ps9:
  ret
