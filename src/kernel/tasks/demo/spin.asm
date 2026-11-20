dspin:
  xor edi,edi
ds0:
  mov ecx,1000000h
ds1:
  dec ecx
  jnz ds1
  mov edx,dword ptr gs:[8]
  shl edx,12
  mov eax,edi
  and eax,0FFFh
  or edx,eax
  call bar
  inc edi
  call yield
  jmp ds0
