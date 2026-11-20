  mov si,offset dap
  mov ah,42h
  int 13h
  jc hang
  mov dl,byte ptr ds:[BOOT_DRIVE]
  mov si,offset dap2
  mov ah,42h
  int 13h
  jc hang
