pcibdf:
  movzx ebx,byte ptr [pbus]
  shl ebx,16
  movzx eax,byte ptr [pdev]
  shl eax,11
  or ebx,eax
  movzx eax,byte ptr [pfn]
  shl eax,8
  or ebx,eax
  or ebx,80000000h
  ret

pcir:
  mov eax,ebx
  or eax,ecx
  mov dx,0CF8h
  out dx,eax
  mov dx,0CFCh
  in eax,dx
  ret

pciw:
  push rax
  mov eax,ebx
  or eax,ecx
  mov dx,0CF8h
  out dx,eax
  pop rax
  mov dx,0CFCh
  out dx,eax
  ret
