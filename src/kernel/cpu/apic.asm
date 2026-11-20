lapw:
  cmp byte ptr [x2],0
  jne lapw2
  mov rdx,[lapicb]
  mov [rdx+rcx],eax
  ret
lapw2:
  shr ecx,4
  add ecx,800h
  xor edx,edx
  wrmsr
  ret

ipi_send:
  cmp byte ptr [x2],0
  jne ips2
  mov rcx,[lapicb]
ips0:
  test dword ptr [rcx+300h],1000h
  jnz ips0
  shl edx,24
  mov [rcx+310h],edx
  mov [rcx+300h],eax
  ret
ips2:
  mov ecx,830h
  wrmsr
  ret

apicid:
  cmp byte ptr [x2],0
  jne apid2
  mov rsi,[lapicb]
  mov eax,[rsi+20h]
  shr eax,24
  ret
apid2:
  mov ecx,802h
  rdmsr
  ret
