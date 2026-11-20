rspawn:
  mov edx,ecx
  shl edx,9
  add edx,CPUS
rsp1:
  cmp qword ptr [rdx+40],0
  je rsp2
  call yield
  jmp rsp1
rsp2:
  mov [rdx+40],rax
  ret
