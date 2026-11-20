irq0:
  push rax
  push rcx
  push rdx
  inc qword ptr [ticks]
  mov al,20h
  out 20h,al
  cmp byte ptr [sched_on],0
  je i0o
  cmp byte ptr [x2],0
  jne i0x
  mov rdx,[lapicb]
i0w:
  test dword ptr [rdx+300h],1000h
  jnz i0w
  mov dword ptr [rdx+300h],0C40F0h
  jmp i0d
i0x:
  mov eax,0C40F0h
  xor edx,edx
  mov ecx,830h
  wrmsr
i0d:
  inc qword ptr gs:[48]
  cmp qword ptr gs:[48],WDLIM
  jb i0o
  mov qword ptr gs:[48],0
  lea rax,[wdkill]
  mov [rsp+24],rax
i0o:
  pop rdx
  pop rcx
  pop rax
  iretq
