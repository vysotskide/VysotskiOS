gdtr:
  dw 24+MAXCPU*16-1
  dq GDT
idtr:
  dw 4095
  dq IDT
nidt:
  dw 0
  dq 0
