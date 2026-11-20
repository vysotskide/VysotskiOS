e8d:
  cmp dword ptr ds:[BOOT_E820_COUNT],0
  jne e8k
  mov ax,0E801h
  int 15h
  jc e8k
  test ax,ax
  jnz e81
  mov ax,cx
  mov bx,dx
e81:
  movzx eax,ax
  shl eax,10
  mov di,BOOT_E820_MAP
  mov dword ptr [di],100000h
  mov dword ptr [di+4],0
  mov dword ptr [di+8],eax
  mov dword ptr [di+12],0
  mov dword ptr [di+16],1
  mov dword ptr [di+20],1
  mov dword ptr ds:[BOOT_E820_COUNT],1
  movzx ebx,bx
  test ebx,ebx
  jz e8k
  shl ebx,16
  add di,24
  mov dword ptr [di],1000000h
  mov dword ptr [di+4],0
  mov dword ptr [di+8],ebx
  mov dword ptr [di+12],0
  mov dword ptr [di+16],1
  mov dword ptr [di+20],1
  mov dword ptr ds:[BOOT_E820_COUNT],2
