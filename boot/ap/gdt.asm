gdt:
  dq 0
  dq 00AF9A000000FFFFh
  dq 00CF92000000FFFFh
gdtr:
  dw 23
  dd offset gdt
