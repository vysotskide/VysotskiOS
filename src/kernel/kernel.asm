.x64p
include common/layout.inc
include kernel/config/memory_layout.inc
include kernel/config/limits.inc
include kernel/config/macros.inc

_TEXT segment use64
assume ds:_TEXT
org KERNEL_BASE

include kernel/entry/reset_vector.asm
include kernel/entry/ap_entry.asm
include kernel/entry/bsp_entry.asm
include kernel/core/fatal.asm

include kernel/mm/memory_map.asm
include kernel/mm/range_set.asm
include kernel/mm/pool.asm
include kernel/mm/mmio_map.asm
include kernel/mm/arena.asm
include kernel/mm/arena_piece.asm
include kernel/mm/page_alloc.asm

include kernel/cpu/apic.asm
include kernel/cpu/cpu_index.asm

include kernel/interrupts/idt_gate.asm
include kernel/interrupts/exceptions.asm
include kernel/interrupts/pit_irq.asm
include kernel/interrupts/ipi_tick.asm
include kernel/interrupts/spurious.asm

include kernel/time/delay.asm
include kernel/time/sleep.asm

include kernel/sched/switch.asm
include kernel/sched/spawn.asm
include kernel/sched/exit.asm
include kernel/sched/remote_spawn.asm
include kernel/sched/idle.asm

include kernel/lib/crc32.asm
include kernel/lib/puts.asm
include kernel/lib/putdec.asm
include kernel/lib/puthex.asm
include kernel/lib/tokenize.asm
include kernel/lib/streq.asm

include kernel/drivers/video/clear.asm
include kernel/drivers/video/putc.asm
include kernel/drivers/video/console_ring.asm
include kernel/drivers/keyboard/init.asm
include kernel/drivers/keyboard/read.asm
include kernel/drivers/pci/config.asm

include kernel/acpi/discovery.asm
include kernel/acpi/table_check.asm
include kernel/acpi/rsdp.asm
include kernel/acpi/madt.asm
include kernel/acpi/fadt.asm
include kernel/acpi/gas.asm
include kernel/acpi/s5_scan.asm
include kernel/acpi/aml.asm
include kernel/acpi/register_io.asm

include kernel/power/acpi_enable.asm
include kernel/power/sleep_state.asm
include kernel/power/poweroff.asm
include kernel/power/reset.asm

include kernel/drivers/storage/ide/pio.asm
include kernel/drivers/storage/ide/identify.asm
include kernel/drivers/storage/ide/dma.asm
include kernel/drivers/storage/ide/transfer.asm
include kernel/drivers/storage/ahci/port.asm
include kernel/drivers/storage/ahci/command.asm
include kernel/drivers/storage/ahci/identify.asm
include kernel/drivers/storage/block/device.asm
include kernel/drivers/storage/block/transfer.asm
include kernel/drivers/storage/block/flush.asm
include kernel/drivers/storage/probe/scan.asm
include kernel/drivers/storage/probe/ide.asm
include kernel/drivers/storage/probe/ahci.asm

include kernel/objstore/level.asm
include kernel/objstore/slot.asm
include kernel/objstore/page.asm
include kernel/objstore/ensure.asm
include kernel/objstore/free.asm
include kernel/objstore/append.asm
include kernel/objstore/names.asm

include kernel/snapshot/write_object.asm
include kernel/snapshot/read_object.asm
include kernel/snapshot/init.asm
include kernel/snapshot/save.asm
include kernel/snapshot/header.asm
include kernel/snapshot/clear.asm
include kernel/snapshot/try_slot.asm
include kernel/snapshot/restore.asm

include kernel/shell/readline.asm
include kernel/shell/main.asm
include kernel/shell/errors.asm
include kernel/shell/commands/ls.asm
include kernel/shell/commands/new.asm
include kernel/shell/commands/put_add.asm
include kernel/shell/commands/get.asm
include kernel/shell/commands/rm.asm
include kernel/shell/commands/mem.asm
include kernel/shell/commands/save.asm
include kernel/shell/commands/off.asm
include kernel/shell/commands/cls.asm
include kernel/shell/commands/cpus.asm
include kernel/shell/commands/info.asm
include kernel/shell/commands/ps.asm
include kernel/shell/commands/run.asm
include kernel/shell/commands/bench.asm
include kernel/shell/commands/reboot.asm

include kernel/tasks/housekeeping.asm
include kernel/tasks/demo/status_bar.asm
include kernel/tasks/demo/spin.asm
include kernel/tasks/demo/sleep.asm
include kernel/tasks/demo/memory.asm
include kernel/tasks/demo/fault.asm

include kernel/data/demo_tasks.asm
include kernel/data/descriptor_tables.asm
include kernel/data/command_table.asm
include kernel/data/keymap.asm
include kernel/data/strings.asm

include kernel/data/state/time.asm
include kernel/data/state/keyboard.asm
include kernel/data/state/console.asm
include kernel/data/state/memory.asm
include kernel/data/state/cpu.asm
include kernel/data/state/acpi.asm
include kernel/data/state/storage.asm
include kernel/data/state/snapshot.asm
include kernel/data/state/acpi_registers.asm
include kernel/data/state/buffers.asm

_TEXT ends
end
