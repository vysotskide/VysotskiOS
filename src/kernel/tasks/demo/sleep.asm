dsleep:
  xor edi,edi
dl0:
  mov edx,dword ptr gs:[8]
  shl edx,12
  mov eax,edi
  and eax,0FFFh
  or edx,eax
  call bar
  inc edi
  mov eax,50
  call sleep
  jmp dl0
