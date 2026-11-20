tryslot:
  push r12
  push r13
  push r14
  push r15
  lea rsi,[hdrs]
  lea eax,[rcx*8]
  lea rsi,[rsi+rax*8-64]
  mov r15,[rsi+16]
  mov r14d,[rsi+32]
  mov r13d,ecx
  mov edi,OTAB
  mov r11d,r15d
  mov r8d,TS
  xor r10d,r10d
  call dio
  jc ts_bad
  mov esi,OTAB
  mov ecx,NOBJ*OE
  mov edx,0FFFFFFFFh
  call crc32f
  not edx
  cmp edx,r14d
  jne ts_bad
  mov ebp,OTAB
  mov r9d,NOBJ
ts1:
  cmp byte ptr [rbp],0
  je ts1n
  mov byte ptr [rbp+31],0
  mov rax,[rbp+32]
  cmp rax,40000000h
  ja ts_bad
  mov [rbp+52],eax
  add rax,511
  shr rax,9
  mov rcx,[rbp+56]
  lea rdx,[r15+TS]
  cmp rcx,rdx
  jb ts_bad
  add rcx,rax
  lea rdx,[r15]
  add rdx,[areasz]
  cmp rcx,rdx
  ja ts_bad
  mov qword ptr [rbp+32],0
  mov qword ptr [rbp+40],0
ts1n:
  add rbp,OE
  dec r9d
  jnz ts1
  mov ebp,OTAB
  mov r9d,NOBJ
ts2:
  cmp byte ptr [rbp],0
  je ts2n
  mov eax,[rbp+52]
  test eax,eax
  jz ts2n
  call oa_ensure
  jc ts_bad2
  call snap_robj
  jc ts_bad2
ts2n:
  add rbp,OE
  dec r9d
  jnz ts2
  clc
  pop r15
  pop r14
  pop r13
  pop r12
  ret
ts_bad2:
  call snapclear
  stc
  pop r15
  pop r14
  pop r13
  pop r12
  ret
ts_bad:
  mov edi,OTAB
  mov ecx,NOBJ*OE/8
  xor eax,eax
  rep stosq
  stc
  pop r15
  pop r14
  pop r13
  pop r12
  ret
