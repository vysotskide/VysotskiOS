dap:
  db 10h,0
  dw KERNEL_SECTORS
  dw 0,KERNEL_SEGMENT
  dq KERNEL_LBA
dap2:
  db 10h,0
  dw 1
  dw AP_TRAMPOLINE,0
  dq AP_LBA
