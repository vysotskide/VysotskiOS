c_put:
  call getobj
  test rax,rax
  jz bad
  mov rbp,rax
  call oa_free
  jmp pbody

c_add:
  call getobj
  test rax,rax
  jz bad
  mov rbp,rax
pbody:
  mov rsi,r14
  mov rdi,rsi
pb1:
  cmp byte ptr [rdi],0
  je pb2
  inc rdi
  jmp pb1
pb2:
  mov rcx,rdi
  sub rcx,rsi
  test ecx,ecx
  jz pb9
  call oa_append
  jc oom
pb9:
  ret
