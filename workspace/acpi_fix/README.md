# AMD A8 NixOS ACPI & GPU Optimization Guide

This document outlines the steps taken to fix the ALIB (Power Management) and LNKx (Interrupt) bugs on HP laptops with AMD A8 processors, and how to apply these fixes permanently in NixOS.

## 1. The DSDT Patching Process

The BIOS on this machine contains "broken" logic that causes the AMD GPU driver to fail and the kernel to spam interrupt errors. We fix this by overriding the DSDT (Differentiated System Description Table).

### Step 1: Edit the Version Number

Open `dsdt.dsl` and locate the `DefinitionBlock`. You must increment the revision so the kernel knows your file is "newer" than the BIOS version.

**Original:**

```asl
DefinitionBlock ("", "DSDT", 2, "HPQOEM", "805A    ", 0x00000000)
```

**Change to:**

```asl
DefinitionBlock ("", "DSDT", 2, "HPQOEM", "805A    ", 0x00000001)
```

### Step 2: Compile and Package

The Linux kernel expects a very specific directory structure inside the `initrd` to recognize the override.

Run the following commands:

```bash
# Compile the code into a binary .aml file.
# The -f forces it even if there are minor warnings.
iasl -f -sa dsdt.dsl

# Create the internal path required by the Linux kernel.
mkdir -p kernel/firmware/acpi

# Place the compiled fix in the correct path.
cp dsdt.aml kernel/firmware/acpi/

# Pack the folder structure into a CPIO archive.
find kernel | cpio -H newc --create > dsdt.cpio
```

## 2. NixOS Configuration

Add the following logic to your NixOS configuration (e.g., `hardware-configuration.nix`).

### Initrd Prepend

This "injects" your fix into the boot process before the main operating system starts.

```nix
boot.initrd.prepend = [ "${./dsdt.cpio}" ];
```

### Critical Kernel Parameters

These parameters handle hardware quirks that cannot be fixed by ACPI alone. Add these to `boot.kernelParams`.

| Parameter                         | Purpose                                                                                                 |
| :-------------------------------- | :------------------------------------------------------------------------------------------------------ |
| `pci=nocrs`                       | Tells the kernel to ignore BIOS-assigned resource windows which are often '0' (broken) on this machine. |
| `idle=nomwait`                    | Disables a specific sleep instruction that causes AMD A8 CPUs to freeze randomly.                       |
| `processor.max_cstate=1`          | Limits the CPU to "Light Sleep" (C1). Prevents the deep-sleep voltage drops that cause hard crashes.    |
| `amdgpu.ppfeaturemask=0xffffffff` | Unlocks the power tables so the GPU can clock up and down correctly.                                    |
| `mitigations=off`                 | Disables security patches (Spectre/Meltdown) to regain performance on this older CPU.                   |

## 3. Verification

### Check if the Patch Loaded

After rebooting, run this to see if the kernel actually used your `dsdt.cpio`:

```bash
dmesg | grep -i "Table Upgrade"
# Success output: ACPI: Table Upgrade: override [DSDT-HPQOEM-805A]
```

### Check for ALIB Errors

If the patch worked, this command should return nothing or only a success message:

```bash
journalctl -b | grep -i "ALIB"
```

### Monitor CPU Sleep States

To ensure `max_cstate=1` is working and your CPU isn't entering "Danger Zone" deep sleeps:

```bash
sudo cpupower monitor
```

## 4. Troubleshooting

If `nixos-rebuild` fails with a "File not found" error regarding `dsdt.cpio`:

1. **Git Check**: If your config is in a Git repo, you must run `git add dsdt.cpio`. Nix ignores untracked files in flakes.
2. **Pathing**: Ensure `dsdt.cpio` is in the same directory as the `.nix` file that references it, or update the path accordingly.
3. **Permissions**: Ensure the file is readable by your user.

## 5. Check BIOS / UEFI Updates for ACPI Fixes

Sometimes ACPI bugs are fixed by vendor firmware updates. Before applying complex DSDT overrides, check for BIOS/UEFI updates:

- Visit your vendor support page (e.g., HP Support) and search for BIOS/UEFI updates for your model.
- Review the changelog for mentions of "ACPI", "DSDT", "power management", "thermal", or "firmware" fixes.
- If an update is available, follow the vendor's instructions to flash the firmware.
- As an alternative, `fwupdmgr get-updates` can list vendor-supplied firmware updates if your system is supported by LVFS (requires working network/DNS).

After updating the firmware, reboot and re-check the kernel log for ACPI-related warnings (e.g., `journalctl -b | grep -i acpi`).

## 6. Gather ACPI tables and GPE logs (for debugging)

When you see warnings like "ACPI Warning: GPE type mismatch", collect the ACPI tables and surrounding kernel logs so you can inspect the DSDT and identify the offending device/GPE handler.

Commands to collect useful artifacts:

```bash
# Save kernel messages that contain the GPE warning and nearby context
journalctl -b -k | grep -i -n -C3 "GPE type mismatch" > workspace/logs/acpi-gpe-mismatch.log

# Dump ACPI tables (requires acpidump/iasl tools installed). Save DSDT binary
sudo cat /sys/firmware/acpi/tables/DSDT > DSDT.dat

# Decompile the DSDT to human-readable ASL
iasl -d DSDT.dat
# This produces DSDT.dsl which you can inspect or edit.

# If acpidump is available, you can also capture all tables:
sudo acpidump -o acpi_tables.dat
iasl -d acpi_tables.dat
```

Attach `DSDT.dsl` and `workspace/logs/acpi-gpe-mismatch.log` when asking for help — they allow targeted fixes.

## 7. Kernel boot-time workarounds to try

If a BIOS update isn't available or doesn't fix the problem, try conservative kernel boot parameters (add to `boot.kernelParams` for NixOS) one at a time and reboot between tests.

- `acpi_osi=!Windows 2015` — restricts the strings the DSDT will see and can silence problematic code paths.
- `acpi_enforce_resources=lax` — relaxes resource enforcement when BIOS reports conflicting resources.
- `pci=nocrs` — ignore BIOS created resource windows (already suggested earlier in this guide).

Notes:

- These are workarounds, not fixes. Prefer firmware updates or DSDT overrides where possible.
- Keep a copy of your original `boot.kernelParams` so you can revert quickly.

## 8. Analysis of Current DSDT (modules/system/dsdt.cpio)

**Status**: DSDT override is **active** and loaded via `boot.initrd.prepend` in `modules/system/configuration.nix` (line 103).

**Decompiled Details**:

- OEM: HPQOEM, Model: 805A (revision 0x00000001 = patched)
- Size: 56870 bytes (0xDE26)
- Compiled with: iasl 20250807
- Location: `kernel/firmware/acpi/dsdt.aml` inside the CPIO archive
- Decompiled copy: `workspace/logs/dsdt-decompiled.dsl` for inspection

**GPE Configuration**:

- The DSDT defines **11 Level-triggered GPE handlers** (_L08,_L05, _L06, etc.) at lines 13900+.
- **GPE 0x8** is the Embedded Controller (EC) interrupt, defined as level-triggered (`_L08` handler).
- **Current Warning**: `ACPI Warning: GPE type mismatch (level/edge)` occurs during EC initialization.
  - The BIOS likely expects edge-triggering for GPE 0x8, but the DSDT handler is level-triggered.
  - Or: a driver is registering GPE 0x8 with the opposite trigger type than the DSDT handler expects.
  - **Impact**: Minor warning; system continues and EC initialization completes successfully (`ACPI: EC: Boot DSDT EC initialization complete`).

**Recommendations**:

1. **Safe to ignore for now**: The EC is working despite the warning. The mismatch is typically a BIOS quirk and doesn't prevent system operation.
2. **To silence the warning** (advanced): Edit the DSDT to flip GPE 0x8 from level-triggered (_L08) to edge-triggered (_E08) and recompile.
   - Trade-off: might cause EC events to be missed if the hardware is actually level-triggered.
3. **Best long-term fix**: Check HP firmware updates for this model (805A) to see if ACPI/EC bugs are addressed.

**How to modify the DSDT** (if you want to fix the warning):

```bash
# Edit workspace/logs/dsdt-decompiled.dsl
# Find the line with: Method (_L08, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
# Change _L08 to _E08 to make it edge-triggered
# Then recompile:
iasl -f -sa dsdt-decompiled.dsl
mkdir -p kernel/firmware/acpi
cp dsdt.aml kernel/firmware/acpi/
find kernel | cpio -H newc --create > modules/system/dsdt.cpio
# Rebuild NixOS: sudo nixos-rebuild switch --flake .#nixxin
```

## 9. Next steps I can take for you

- Apply the GPE 0x8 fix (rename _L08 to_E08 in the DSDT, recompile, and update the CPIO) if you want to silence the warning.
- Search HP firmware updates for this model to see if BIOS changes address the GPE mismatch.
- Add safe kernel parameters to your NixOS `schema/default.nix` (e.g., `acpi_osi=!Windows 2015`) for testing if you suspect other ACPI issues.

**Which option would you like me to pursue?**
