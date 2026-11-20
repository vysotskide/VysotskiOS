disk_init:
  mov byte ptr [pbus],0
di_bus:
  mov byte ptr [pdev],0
di_dev:
  mov byte ptr [pfn],0
di_fn:
  call pcibdf
  xor ecx,ecx
  call pcir
  cmp ax,0FFFFh
  je di_nf
  mov ecx,8
  call pcir
  mov r12d,eax
  call pci_probe
  cmp byte ptr [dkind],0
  jne di_done
  cmp byte ptr [pfn],0
  jne di_nextfn
  call pcibdf
  mov ecx,0Ch
  call pcir
  test eax,800000h
  jnz di_nextfn
  jmp di_nextdev
di_nf:
  cmp byte ptr [pfn],0
  je di_nextdev
di_nextfn:
  inc byte ptr [pfn]
  cmp byte ptr [pfn],8
  jb di_fn
di_nextdev:
  inc byte ptr [pdev]
  cmp byte ptr [pdev],32
  jb di_dev
  inc byte ptr [pbus]
  jnz di_bus
di_done:
  ret

pci_probe:
  mov eax,r12d
  shr eax,16
  cmp ax,0101h
  je probe_ide
  cmp ax,0106h
  jne pp9
  mov eax,r12d
  shr eax,8
  cmp al,1
  je probe_ahci
pp9:
  ret
