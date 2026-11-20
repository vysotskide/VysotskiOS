c_new:
  mov rsi,r13
  call mkname
  je bad
  call find
  test rax,rax
  jnz bad
  mov edx,OTAB
  mov ecx,NOBJ
nf1:
  cmp byte ptr [rdx],0
  je nf2
  add rdx,OE
  dec ecx
  jnz nf1
  jmp oom
nf2:
  lea rsi,[nbuf]
  mov rax,[rsi]
  mov [rdx],rax
  mov rax,[rsi+8]
  mov [rdx+8],rax
  mov rax,[rsi+16]
  mov [rdx+16],rax
  mov rax,[rsi+24]
  mov [rdx+24],rax
  mov qword ptr [rdx+32],0
  mov qword ptr [rdx+40],0
  mov qword ptr [rdx+48],0
  mov qword ptr [rdx+56],0
  ret
