### [CRITICAL IMPACT]

* **Performance Regression:** There is a severe performance gap between Windows and Linux on this hardware. On Windows, the APU performs at 100% capacity. On Linux, we observe a **loss of 50% or more in performance**.
* **Scale of Deployment:** This is a fleet-wide issue affecting an entire workplace. We have a large number of identical HP EliteDesk 705 G2 SFF units; all exhibit the same performance degradation and ACPI errors. This is currently blocking our full migration to Linux.

---

### [OVERVIEW]

On the HP EliteDesk 705 G2 SFF, the kernel consistently reports ACPI interpreter errors during boot. The primary failure is a missing symbol `\_SB.ALIB`.

As `ALIB` (AMD Linux Interface Bridge) is responsible for power state communication between the BIOS and the `amdgpu` driver, its absence appears to be capping the APU's TDP and clock speeds. This prevents the hardware from reaching the performance levels seen on Windows.

### [LOG SNIPPET]

```text
Feb 07 06:06:33 nixxin kernel: ACPI BIOS Error (bug): Could not resolve symbol [\_SB.ALIB], AE_NOT_FOUND (20250807/psargs-332)
```

### [HARDWARE DETAILS]

* **Hardware Model**: HP HP EliteDesk 705 G2 SFF/805A, BIOS N06 Ver. 02.52 04/11/2022
* **Hardware SKU**: L1M89AV
* **Hardware Version**: KBC Version 05.35
* **Architecture**: x86-64
* **Firmware Date**: Tue 2020-10-20
* **CPU/APU**: AMD PRO A8-8650B R7 (Kaveri, 4 cores/4 threads, 3.2GHz base/3.9GHz boost)
* **iGPU**: AMD Radeon R7 (GCN 1.1 / GFX7 / GCN-era iGPU / 0000:00:01.0 ), 512 shaders, 720MHz base clock
* **Memory**: 16GB DDR3 (2x8GB) running at 1333MHz (Dual Channel)
* **Storage**: 256GB SATA SSD
* **OS**: NixOS Unstable (as of February 2026)
* **Kernel**: Linux 6.18-zen1
* **Display**: 1920x1080 @ 60Hz

### [PERFORMANCE METRICS]

* GPU Utilization: ~50-60% on Linux vs 95-100% on Windows

**Thermals**:

* Idle: 35-40°C (Linux), 40-45°C (Windows)
* Load: 65-70°C (Linux), 75-80°C (Windows)

### [WORKAROUNDS ATTEMPTED]

1. **ACPI Override**:
   * Tried `acpi_osi=Linux`, `Windows 2020`, `Windows 10`, `Windows 8.1` - No effect
   * `acpi_enforce_resources=lax` - No improvement
   * Custom DSDT override - Partially loaded but didn't resolve ALIB

2. **Power Management**:
   * Toggled `amdgpu.dpm` between 0 and 1
   * Tested `amdgpu.ppfeaturemask=0xffffffff`
   * Tried `amdgpu.runpm=1` with various parameters

3. **Memory Configuration**:
   * Verified dual-channel operation
   * Tested different memory timings in BIOS
   * Confirmed no ECC or other special memory features enabled

### [ADDITIONAL OBSERVATIONS]

1. **Power States**:
   * Windows: Proper power state transitions (D0, D1, D3)
   * Linux: Gets stuck in D0 state, no deep sleep states observed

2. **Clock Behavior**:
   * Core clock fluctuates between 300-500MHz under load (vs 720MHz target)
   * Memory clock shows 0MHz in monitoring tools
   * No thermal throttling observed

3. **ACPI Debugging**:
   * Full ACPI tables dumped and analyzed
   * `_SB.ALIB` is indeed missing from the ACPI tables
   * No vendor-specific ACPI extensions found for this platform

### [REPRODUCTION]

The issue can be reproduced on any HP EliteDesk 705 G2 SFF with:

1. Clean NixOS install
2. Latest linux-zen kernel
3. amdgpu driver

### [ERROR]

```bash
Feb 08 02:11:27 nixxin kernel: ACPI BIOS Error (bug): Could not resolve symbol [\_SB.ALIB], AE_NOT>
Feb 08 02:11:27 nixxin kernel: ACPI Error: Aborting method \_SB.PCI0.VGA.ATC0 due to previous erro>
Feb 08 02:11:27 nixxin kernel: ACPI Error: Aborting method \_SB.PCI0.VGA.ATCS due to previous erro>
Feb 08 02:11:27 nixxin kernel: amdgpu: Overdrive is enabled, please disable it before reporting an>
```
