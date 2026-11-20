  mov dword ptr ds:[BOOT_E820_COUNT],0
  mov di,BOOT_E820_MAP
  xor ebx,ebx
e8l:
  mov dword ptr [di+20],1
  mov eax,0E820h
  mov edx,534D4150h
  mov ecx,24
  int 15h
  jc e8d
  cmp eax,534D4150h
  jne e8d
  jcxz e8n
  inc dword ptr ds:[BOOT_E820_COUNT]
  add di,24
  cmp dword ptr ds:[BOOT_E820_COUNT],BOOT_E820_MAX
  jae e8d
e8n:
  test ebx,ebx
  jnz e8l
