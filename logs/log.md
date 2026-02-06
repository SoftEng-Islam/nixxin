# System Analysis and Debugging Log

## 1. System State Analysis

Based on the investigation of `logs/debug.md`, `logs/journalctl--dmesg.log.txt`, and configuration files:

- **Hardware**: HP EliteDesk 705 G2 SFF with AMD PRO A8-8650B R7 (Kaveri APU, GCN 1.1 / GFX7).
- **Kernel**: Linux 6.18-zen1.
- **Driver**: `amdgpu` is correctly loaded (replacing `radeon`).
- **OpenCL**: Currently using **Mesa Rusticl** (OpenCL 3.0 via `radeonsi`). `clvk` and `pocl` are present but not being used by Hashcat (skipped or failed).
- **Performance**: Hashcat speed is ~12k H/s (vs ~24k H/s on Windows). This confirms a significant performance regression (~50%).

## 2. Identified Issues

### A. ACPI Errors (`_SB.ALIB`)

The most critical error in `dmesg` is:

```
ACPI BIOS Error (bug): Could not resolve symbol [\_SB.ALIB], AE_NOT_FOUND
ACPI Error: Aborting method \_SB.PCI0.VGA.ATC0 ...
```

**Impact**: `ALIB` (AMD Library) is an ACPI method used by the BIOS to communicate power state, backlight, and switching info to the OS. Its failure means the `amdgpu` driver **cannot** properly interact with the platform firmware for advanced power management. This explains the log message:

```
amdgpu 0000:00:01.0: amdgpu: Runtime PM not available
```

Without Runtime PM, the GPU may be stuck in a "safe" or default clock state, preventing full boost frequencies.

### B. Configuration Contradictions

- **`default.nix`**: Contains `amdgpu.dpm=0`.
- **`debug.md` & Logs**: Shows `boot.kernelParams` included `amdgpu.dpm=1`.
  **Impact**: Dynamic Power Management (DPM) _is_ enabled in the current boot (which is good), but the config file is inconsistent. If `dpm=0` were applied, performance would be even worse.

### C. OpenCL/Compute Stack

- Hashcat reports `max_gpu_freq = 757 MHz` and `memory_freq = 0 GHz`.
- **Memory Frequency 0 GHz**: This is a major red flag. It likely means the driver cannot query memory clock, possibly due to the ACPI/Power failure. If memory is stuck at boot clocks (e.g. DDR3-1333 base without interleaving or adjustment), bandwidth will severely limit Hashcat performance.
- **Driver Choice**: `rusticl` is functional but early. `clvk` failed validity checks.

## 3. Proposed Solutions

### Step 1: Fix ACPI tables via OSI Strings

The BIOS is likely hiding the `ALIB` method because it doesn't think the OS is Windows. We need to spoof a specific Windows version.
**Recommended Changes in `users/softeng/desktop/HP/default.nix`**:

1.  **Enable `acpi_osi="Windows 2009"`** (Windows 7). This is often the "magic string" for HP machines of this era (2012-2015 BIOS base). The log showed `acpi_osi=Linux` was accepted but didn't work.
2.  **Remove `acpi_enforce_resources=lax`** unless you are 100% sure you need it (it can break ACPI power management).

### Step 2: Clean up Kernel Parameters

Ensure optimal `amdgpu` settings in `default.nix`:

```nix
"amdgpu.dpm=1"            # MUST be 1 for performance
"amdgpu.runpm=1"          # Release runtime power management (retry with fixed ACPI)
"amdgpu.ppfeaturemask=0xffffffff" # Fully unlock power play features
"amdgpu.vm_fragment_size=9"
"amdgpu.audio=0"          # Keep as requested
```

### Step 3: Force Clocks (If ACPI fails)

If ACPI cannot be fixed to allow automatic boosting:

1.  Use `corectrl` (enable it in `overclock/corectrl.nix` and disable `lactd` if they conflict) to forcefully set the GPU power profile to "Compute" or "VR" (High Fixed Clocks).
2.  Your APU shares system RAM. Verify in BIOS that RAM is running at max supported speed (1600/1866/2133 MHz if supported). The log says "configured at 1333 MT/s". **This is slow**. Kaveri's performance scales linearly with RAM speed. If you can enable XMP or manually boost RAM to 1600+ MHz in BIOS, do it. This alone could account for 20-30% of the missing speed.

### Step 4: Alternative OpenCL

If Rusticl stays slow:

- You are using `clvk` but it errors. The error `CL_INVALID_ARG_VALUE` suggests a bug in `clvk`'s handling of specific kernels on this hardware.
- **ROCm** does not officially support GFX7 (Kaveri).
- **Mesa Clover** (older OpenCL) might actually be more stable for GFX7 than Rusticl, though Rusticl is faster _if_ it works. You can toggle this via `RUSTICL_ENABLE` env var (unset it to fallback to Clover if installed).

## Summary Plan

1.  Edit `users/softeng/desktop/HP/default.nix`.
2.  Change `acpi_osi` to `"Windows 2009"`.
3.  Set `amdgpu.dpm=1`.
4.  Rebuild and check `dmesg` if `_SB.ALIB` error persists.
