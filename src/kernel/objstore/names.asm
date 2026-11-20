mkname:
  lea rdi,[nbuf]
  xor eax,eax
  mov [rdi],rax
  mov [rdi+8],rax
  mov [rdi+16],rax
  mov [rdi+24],rax
  mov ecx,31
mnl:
  lodsb
  test al,al
  jz mnd
  stosb
  loop mnl
mnd:
  cmp byte ptr [nbuf],0
  ret

find:
  mov edx,OTAB
  mov ecx,NOBJ
  lea rsi,[nbuf]
fdl:
  mov rax,[rsi]
  cmp [rdx],rax
  jne fdn
  mov rax,[rsi+8]
  cmp [rdx+8],rax
  jne fdn
  mov rax,[rsi+16]
  cmp [rdx+16],rax
  jne fdn
  mov rax,[rsi+24]
  cmp [rdx+24],rax
  je fdf
fdn:
  add rdx,OE
  dec ecx
  jnz fdl
  xor eax,eax
  ret
fdf:
  mov rax,rdx
  ret

getobj:
  mov rsi,r13
  call mkname
  jne gof
  xor eax,eax
  ret
gof:
  jmp find
