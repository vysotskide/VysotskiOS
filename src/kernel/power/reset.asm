doreset:
  test dword ptr [fflags],400h
  jz rst8
  cmp qword ptr [rstr_a],0
  je rst8
  movzx eax,byte ptr [rstv]
  lea rdi,[rstr]
  call rw8
  mov eax,200
  call sleep
rst8:
  mov ecx,10000h
rst1:
  in al,64h
  test al,2
  jz rst2
  dec ecx
  jnz rst1
rst2:
  mov al,0FEh
  out 64h,al
  mov eax,200
  call sleep
  mov dx,0CF9h
  mov al,2
  out dx,al
  mov al,6
  out dx,al
  mov eax,200
  call sleep
  cli
  lidt tbyte ptr [nidt]
  ud2
