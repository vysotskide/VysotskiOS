aml_int:
  movzx eax,byte ptr [r10]
  test al,al
  jnz ai1
  inc r10
  clc
  ret
ai1:
  cmp al,1
  jne ai2
  inc r10
  mov eax,1
  clc
  ret
ai2:
  cmp al,0FFh
  jne ai3
  inc r10
  mov eax,7
  clc
  ret
ai3:
  cmp al,0Ah
  jne ai4
  movzx eax,byte ptr [r10+1]
  add r10,2
  clc
  ret
ai4:
  cmp al,0Bh
  jne ai5
  movzx eax,word ptr [r10+1]
  add r10,3
  clc
  ret
ai5:
  cmp al,0Ch
  jne ai6
  mov eax,[r10+1]
  add r10,5
  clc
  ret
ai6:
  stc
  ret
