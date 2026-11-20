dosave:
dsv0:
  cmp byte ptr [savebusy],0
  je dsv1
  call yield
  jmp dsv0
dsv1:
  mov byte ptr [savebusy],1
  cmp byte ptr [dkind],0
  je svnodisk
  xor r13d,r13d
  mov ebp,OTAB
  mov r9d,NOBJ
sv0:
  cmp byte ptr [rbp],0
  je sv0n
  mov rax,[rbp+32]
  add rax,511
  shr rax,9
  add r13,rax
sv0n:
  add rbp,OE
  dec r9d
  jnz sv0
  add r13,TS
  cmp r13,[areasz]
  ja svnospace
  mov r14d,1
  cmp byte ptr [curslot],1
  jne sv1a
  mov r14d,2
sv1a:
  mov r15,[areasz]
  lea eax,[r14-1]
  imul r15,rax
  add r15,SNAP0
  lea r12,[r15+TS]
  mov ebp,OTAB
  mov r9d,NOBJ
sv1:
  cmp byte ptr [rbp],0
  je sv9
  mov [rbp+56],r12
  call snap_wobj
  jc svfail
sv9:
  add rbp,OE
  dec r9d
  jnz sv1
  mov esi,OTAB
  mov ecx,NOBJ*OE
  mov edx,0FFFFFFFFh
  call crc32f
  not edx
  mov [tcrc],edx
  mov edi,OTAB
  mov r11d,r15d
  mov r8d,TS
  mov r10b,1
  call dio
  jc svfail
  call dflush
  mov edi,HDRB
  mov ecx,64
  xor eax,eax
  rep stosq
  mov esi,HDRB
  mov rax,494B53544F535956h
  mov [rsi],rax
  mov rax,[gen]
  inc rax
  mov [rsi+8],rax
  mov [rsi+16],r15
  mov rax,[areasz]
  mov [rsi+24],rax
  mov eax,[tcrc]
  mov [rsi+32],eax
  mov [rsi+40],r13
  mov dword ptr [rsi+48],1
  mov ecx,52
  mov edx,0FFFFFFFFh
  call crc32f
  not edx
  mov esi,HDRB
  mov [rsi+52],edx
  mov edi,HDRB
  lea r11d,[r14+127]
  mov r8d,1
  mov r10b,1
  call dio
  jc svfail
  call dflush
  mov [curslot],r14b
  inc qword ptr [gen]
  mov byte ptr [savebusy],0
  lea rsi,[msaved]
  jmp puts
svnodisk:
  mov byte ptr [savebusy],0
  lea rsi,[mnodisk]
  jmp puts
svnospace:
  mov byte ptr [savebusy],0
  lea rsi,[mnospc]
  jmp puts
svfail:
  mov byte ptr [savebusy],0
  lea rsi,[merr]
  jmp puts
