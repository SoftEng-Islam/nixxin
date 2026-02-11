# ALIB / ACPI override (HP EliteDesk 705 G2 / Kaveri)

## Problem

On this hardware the kernel logs show ACPI interpreter failures because the
firmware calls `\_SB.ALIB` but the method is **missing**:

```
ACPI BIOS Error (bug): Could not resolve symbol [\_SB.ALIB], AE_NOT_FOUND
ACPI Error: Aborting method \_SB.PCI0.VGA.ATC0 due to previous error (AE_NOT_FOUND)
ACPI Error: Aborting method \_SB.PCI0.VGA.ATCS due to previous error (AE_NOT_FOUND)
```

When `ATC0/ATCS` abort, the AMD ACPI video/thermal glue for the iGPU/APU can end
up in a degraded state.

## What we did

1. Added a helper to dump and disassemble ACPI tables on the target machine:
   - `scripts/acpi_dump_alib.sh`

2. Extended the initrd ACPI override support to accept `*.asl` files and compile
   them to AML during the Nix build (so we don’t need to commit binaries):
   - `modules/system/configuration.nix`

3. Added an SSDT override that defines a **stub** `\_SB.ALIB` method with the
   correct argument count (2) and returns a zeroed Buffer:
   - `modules/system/acpi_override/ssdt-alib-noop.asl`

The ACPI dump confirmed ALIB is referenced with two arguments in the firmware
tables:

- `ssdt3.dsl` (ATCS/ATC*): `\_SB.ALIB (Zero, M208)` / `\_SB.ALIB (0x02, Arg0)`…
- `ssdt4.dsl`: `\_SB.ALIB (0x06, M115)`

## Why a stub?

This is the smallest possible override that:

- Stops `AE_NOT_FOUND` by providing a callable `\_SB.ALIB`.
- Avoids type issues by returning a Buffer (callers store the return into a
  Buffer like `M207`).

It does **not** implement the real AMD “ALIB” functionality. If the platform
expects ALIB to actually modify power limits (STAPM/DPTC), we may need a more
accurate implementation or a different approach.

## How it’s enabled

`modules/system/configuration.nix` embeds ACPI override tables found in:

- `modules/system/acpi_override/*.aml`
- `modules/system/acpi_override/*.asl` (compiled to `*.aml` automatically)

These are placed into the initrd at:

`/kernel/firmware/acpi/<name>.aml`

Linux can then override firmware ACPI tables at boot (requires
`CONFIG_ACPI_TABLE_UPGRADE=y` in the kernel).

### Requirements / gotchas

1. **Initrd must be uncompressed**

   The kernel scans an **uncompressed leading** initrd CPIO archive for
   `/kernel/firmware/acpi/*.aml`. If initrd is compressed, the override tables
   will be ignored.

2. **Kernel lockdown / Secure Boot**

   On some systems, if the kernel is in *lockdown* mode (often due to UEFI Secure
   Boot), it may refuse ACPI table overrides.

## Apply / test

Rebuild and reboot:

```bash
sudo nixos-rebuild switch --flake .#nixxin
reboot
```

After reboot, check logs:

```bash
sudo journalctl -k -b | rg -n "ALIB|ATC0|ATCS"
```

Expected outcome: the `AE_NOT_FOUND` errors for `\_SB.ALIB` should disappear.

## Troubleshooting (if errors still appear)

```bash
# 1) Check kernel config
zcat /proc/config.gz | rg -n "CONFIG_ACPI_TABLE_UPGRADE"

# 2) Check initrd compression (ACPI override needs uncompressed CPIO)
file /run/current-system/initrd

# 3) Check kernel lockdown state
cat /sys/kernel/security/lockdown 2>/dev/null || true

# 4) Look for table-override related kernel log messages
sudo journalctl -k -b | rg -n "ACPI.*(override|upgrade)|locked down|firmware/acpi"
```

## Rollback

Remove the override file and rebuild:

```bash
rm modules/system/acpi_override/ssdt-alib-noop.asl
sudo nixos-rebuild switch --flake .#nixxin
reboot
```

## Notes / risks

- ACPI overrides can affect boot stability. Keep a known-good boot entry and be
  ready to rollback.
- If the error changes to an argument-count/type mismatch, adjust the SSDT’s
  `Method (ALIB, ...)` signature/return value to match what the firmware
  expects.
