c_mem:
  xor ebx,ebx
  xor r15d,r15d
cm1:
  cmp ebx,[ncpu]
  jae cm2
  mov edx,ebx
  shl edx,9
  add edx,CPUS
  mov rax,[rdx+32]
  sub rax,[rdx+24]
  shr rax,12
  add rax,[rdx+72]
  add r15,rax
  mov ecx,[rdx+88]
  inc ecx
cm3:
  cmp ecx,[rdx+80]
  jae cm4
  mov esi,ecx
  shl esi,4
  mov rax,[rdx+rsi+392]
  sub rax,[rdx+rsi+384]
  shr rax,12
  add r15,rax
  inc ecx
  jmp cm3
cm4:
  inc ebx
  jmp cm1
cm2:
  mov eax,r15d
  shl eax,2
  call putdec
  lea rsi,[mkb]
  jmp puts
