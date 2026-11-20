getcpu:
  call apicid
  mov edx,AIDS
  xor ecx,ecx
gcp1:
  cmp [rdx+rcx*4],eax
  je gcp2
  inc ecx
  cmp ecx,[ncpu]
  jb gcp1
  xor ecx,ecx
gcp2:
  mov eax,ecx
  ret
