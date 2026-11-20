fexit:
  mov rdx,qword ptr gs:[0]
  mov rsp,[rdx+64]
  mov ecx,[rdx+12]
  shl ecx,5
  mov dword ptr [rdx+rcx+144],0
  jmp fnext

fkill:
  mov rdx,qword ptr gs:[0]
  mov rsp,[rdx+64]
  mov ecx,[rdx+12]
  mov eax,ecx
  shl eax,5
  lea rsi,[rdx+rax+128]
  test dword ptr [rsi+16],2
  jz fk1
  mov rax,[rsi+8]
  mov r9d,[rsi+16]
  call tinit
  jmp fnext
fk1:
  mov dword ptr [rsi+16],0
  jmp fnext

wdkill:
  jmp fkill
