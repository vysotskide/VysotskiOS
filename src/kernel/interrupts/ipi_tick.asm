ipitick:
  push rax
  push rcx
  push rdx
  cmp byte ptr [x2],0
  jne ipx
  mov rdx,[lapicb]
  mov dword ptr [rdx+0B0h],0
  jmp ipd
ipx:
  xor eax,eax
  xor edx,edx
  mov ecx,80Bh
  wrmsr
ipd:
  inc qword ptr gs:[48]
  cmp qword ptr gs:[48],WDLIM
  jb ipo
  mov qword ptr gs:[48],0
  lea rax,[wdkill]
  mov [rsp+24],rax
ipo:
  pop rdx
  pop rcx
  pop rax
  iretq
