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

1.  **Git Check**: If your config is in a Git repo, you must run `git add dsdt.cpio`. Nix ignores untracked files in flakes.
2.  **Pathing**: Ensure `dsdt.cpio` is in the same directory as the `.nix` file that references it, or update the path accordingly.
3.  **Permissions**: Ensure the file is readable by your user.
