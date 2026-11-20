c_bench:
  rdtsc
  shl rdx,32
  or rax,rdx
  mov rbx,rax
  mov r15d,100000
bn1:
  call yield
  dec r15d
  jnz bn1
  rdtsc
  shl rdx,32
  or rax,rdx
  sub rax,rbx
  xor edx,edx
  mov ecx,100000
  div rcx
  call putdec
  lea rsi,[mcyc]
  jmp puts
