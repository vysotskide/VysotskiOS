puts:
psl:
  lodsb
  test al,al
  jz psd
  call putc
  jmp psl
psd:
  ret
