yield:
  pushall
  mov rdx,qword ptr gs:[0]
  mov ecx,[rdx+12]
  shl ecx,5
  mov [rdx+rcx+128],rsp
fnext:
  mov rax,[rdx+40]
  test rax,rax
  jz fn1
  mov qword ptr [rdx+40],0
  mov r9d,'x'*256+1
  call lspawn
fn1:
  mov ecx,[rdx+12]
  mov r8d,FPC
fn2:
  inc ecx
  and ecx,FPC-1
  mov eax,ecx
  shl eax,5
  cmp dword ptr [rdx+rax+144],0
  jne fn3
  dec r8d
  jnz fn2
  xor ecx,ecx
  xor eax,eax
fn3:
  mov [rdx+12],ecx
  mov qword ptr [rdx+48],0
  mov rsp,[rdx+rax+128]
  popall
  sti
  ret
