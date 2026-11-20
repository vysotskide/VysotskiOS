e8k:
  mov di,BOOT_PML4
  mov cx,1800h
  xor eax,eax
  rep stosd
  mov word ptr ds:[BOOT_PML4],2003h
  mov word ptr ds:[2000h],3003h
  mov word ptr ds:[2008h],4003h
  mov word ptr ds:[2010h],5003h
  mov word ptr ds:[2018h],6003h
  mov di,3000h
  mov eax,83h
  mov cx,2048
pdl:
  mov dword ptr [di],eax
  add di,8
  add eax,200000h
  loop pdl
