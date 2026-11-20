addpiece:
  push rax
  push rcx
  push rsi
  mov esi,ebx
  shl esi,9
  add esi,CPUS
  mov eax,[rsi+80]
  cmp eax,8
  jae adp_x
  test eax,eax
  jnz adp_n
  mov [rsi+24],r11
  mov [rsi+32],rdx
adp_n:
  mov ecx,eax
  shl ecx,4
  mov [rsi+rcx+384],r11
  mov [rsi+rcx+392],rdx
  inc eax
  mov [rsi+80],eax
adp_x:
  pop rsi
  pop rcx
  pop rax
  ret
