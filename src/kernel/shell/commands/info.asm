c_info:
  lea rsi,[mi1]
  call puts
  movzx eax,byte ptr [dkind]
  call putdec
  mov al,20h
  call putc
  lea rsi,[dcap]
  mov eax,dword ptr [rsi+4]
  call puthex
  lea rsi,[dcap]
  mov eax,dword ptr [rsi]
  call puthex
  mov al,13
  call putc
  lea rsi,[mi2]
  call puts
  movzx eax,byte ptr [s5ok]
  call putdec
  mov al,20h
  call putc
  movzx eax,byte ptr [slptypa]
  call putdec
  mov al,20h
  call putc
  movzx eax,byte ptr [slptypb]
  call putdec
  mov al,20h
  call putc
  mov eax,[fflags]
  call puthex
  mov al,20h
  call putc
  mov eax,dword ptr [pm1ac_a]
  call puthex
  mov al,13
  call putc
  lea rsi,[mi3]
  call puts
  movzx eax,byte ptr [x2]
  call putdec
  mov al,13
  jmp putc
