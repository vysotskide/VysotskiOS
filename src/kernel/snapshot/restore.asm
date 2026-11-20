rtry:
  cmp ecx,1
  jne rty2
  cmp byte ptr [hv1],0
  je rty_f
  jmp rty3
rty2:
  cmp byte ptr [hv2],0
  je rty_f
rty3:
  mov [rslot],cl
  jmp tryslot
rty_f:
  stc
  ret

restore:
  cmp byte ptr [dkind],0
  je rt_none
  cmp qword ptr [areasz],0
  je rt_none
  mov byte ptr [hv1],0
  mov byte ptr [hv2],0
  mov ecx,1
  call hdrload
  jc rt_h2
  mov byte ptr [hv1],1
rt_h2:
  mov ecx,2
  call hdrload
  jc rt_go
  mov byte ptr [hv2],1
rt_go:
  mov ecx,1
  mov edx,2
  cmp byte ptr [hv1],0
  je rt_o
  cmp byte ptr [hv2],0
  je rt_s
  lea rsi,[hdrs]
  mov rax,[rsi+8]
  cmp rax,[rsi+72]
  jae rt_s
rt_o:
  mov ecx,2
  mov edx,1
rt_s:
  push rdx
  call rtry
  pop rdx
  jnc rt_ok
  mov ecx,edx
  call rtry
  jc rt_none
rt_ok:
  movzx ecx,byte ptr [rslot]
  mov [curslot],cl
  lea rsi,[hdrs]
  lea eax,[rcx*8]
  mov rax,[rsi+rax*8-64+8]
  mov [gen],rax
  xor r15d,r15d
  mov ebp,OTAB
  mov r9d,NOBJ
rt_cn:
  cmp byte ptr [rbp],0
  je rt_cn2
  inc r15d
rt_cn2:
  add rbp,OE
  dec r9d
  jnz rt_cn
  mov eax,r15d
  call putdec
  lea rsi,[mrest]
  jmp puts
rt_none:
  mov edi,OTAB
  mov ecx,NOBJ*OE/8
  xor eax,eax
  rep stosq
  mov byte ptr [curslot],0
  mov qword ptr [gen],0
  ret
