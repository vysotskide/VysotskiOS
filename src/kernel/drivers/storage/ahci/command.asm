ahci_do:
  mov rdx,[ahcip]
  mov edi,AHCIM
  mov eax,5
  test r10b,r10b
  jz ad1
  or eax,40h
ad1:
  test ebx,ebx
  jz ad2
  or eax,10000h
ad2:
  mov [rdi],eax
  mov dword ptr [rdi+4],0
  mov dword ptr [rdi+8],AHCIM+500h
  mov dword ptr [rdi+12],0
  mov edi,AHCIM+500h
  mov eax,r12d
  shl eax,16
  or eax,8027h
  mov [rdi],eax
  mov eax,r11d
  and eax,0FFFFFFh
  or eax,40000000h
  mov [rdi+4],eax
  mov eax,r11d
  shr eax,24
  mov [rdi+8],eax
  mov [rdi+12],ebx
  mov dword ptr [rdi+16],0
  test ebx,ebx
  jz ad3
  mov dword ptr [rdi+80h],BOUNCE
  mov dword ptr [rdi+84h],0
  mov dword ptr [rdi+88h],0
  mov eax,ebx
  shl eax,9
  dec eax
  mov [rdi+8Ch],eax
ad3:
  mov dword ptr [rdx+10h],0FFFFFFFFh
  mov dword ptr [rdx+38h],1
  mov r9,[ticks]
  add r9,2000
ad4:
  mov eax,[rdx+38h]
  test al,1
  jz ad5
  mov eax,[rdx+10h]
  test eax,40000000h
  jnz ad_e
  cmp [ticks],r9
  jae ad_e
  call yield
  jmp ad4
ad5:
  mov eax,[rdx+10h]
  test eax,40000000h
  jnz ad_e
  mov eax,[rdx+20h]
  test al,1
  jnz ad_e
  clc
  ret
ad_e:
  call ahci_port_init
  stc
  ret

ahci_op:
  mov r12d,25h
  test r10b,r10b
  jz ao0
  mov r12d,35h
ao0:
  jmp ahci_do
