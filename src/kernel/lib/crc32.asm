crcinit:
  mov edi,CRCT
  xor ecx,ecx
ci1:
  mov eax,ecx
  mov edx,8
ci2:
  shr eax,1
  jnc ci3
  xor eax,0EDB88320h
ci3:
  dec edx
  jnz ci2
  mov [rdi+rcx*4],eax
  inc ecx
  cmp ecx,256
  jb ci1
  ret

crc32f:
  test ecx,ecx
  jz cr9
  mov r8d,CRCT
cr1:
  movzx eax,byte ptr [rsi]
  xor al,dl
  shr edx,8
  xor edx,[r8+rax*4]
  inc rsi
  dec ecx
  jnz cr1
cr9:
  ret
