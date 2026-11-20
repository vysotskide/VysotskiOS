ahci_stop:
  mov rdx,[ahcip]
  mov eax,[rdx+18h]
  and eax,0FFFFFFEEh
  mov [rdx+18h],eax
  mov r9,[ticks]
  add r9,500
as1:
  mov eax,[rdx+18h]
  test eax,0C000h
  jz as9
  cmp [ticks],r9
  jae as9
  call yield
  jmp as1
as9:
  ret

ahci_port_init:
  call ahci_stop
  mov rdx,[ahcip]
  mov edi,AHCIM
  mov ecx,512
  xor eax,eax
  rep stosq
  mov dword ptr [rdx],AHCIM
  mov dword ptr [rdx+4],0
  mov dword ptr [rdx+8],AHCIM+400h
  mov dword ptr [rdx+0Ch],0
  mov eax,0FFFFFFFFh
  mov [rdx+30h],eax
  mov [rdx+10h],eax
  mov dword ptr [rdx+14h],0
  mov eax,[rdx+18h]
  or eax,10h
  mov [rdx+18h],eax
  mov r9,[ticks]
  add r9,1000
api1:
  mov eax,[rdx+20h]
  test al,88h
  jz api2
  cmp [ticks],r9
  jae api_f
  call yield
  jmp api1
api2:
  mov eax,[rdx+18h]
  or eax,1
  mov [rdx+18h],eax
  clc
  ret
api_f:
  stc
  ret
