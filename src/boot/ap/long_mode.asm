  lgdt fword ptr [gdtr]
  mov eax,20h
  mov cr4,eax
  mov eax,BOOT_PML4
  mov cr3,eax
  mov ecx,0C0000080h
  rdmsr
  or eax,100h
  wrmsr
  mov eax,80000001h
  mov cr0,eax
  db 66h,0EAh
  dd KERNEL_AP_ENTRY
  dw 8
