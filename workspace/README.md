# Workspace Folder

> Here you can put your log/test files

## [OVERVIEW]

- ./acpi_fix
  - I was have a problem with the ACPI "missing symbol (`\_SB.ALIB`)", and I was use this dir to fix the problem and I don't see any improvement in the performance only the error massage is gone.
  - As `ALIB` (AMD Linux Interface Bridge) is responsible for power state communication between the BIOS and the `amdgpu` driver, its absence appears to be capping the APU's TDP and clock speeds. This prevents the hardware from reaching the performance levels seen on Windows.

  - [LOG SNIPPET]

  ```text
  Feb 08 02:11:27 nixxin kernel: ACPI BIOS Error (bug): Could not resolve symbol [\_SB.ALIB], AE_NOT>
  Feb 08 02:11:27 nixxin kernel: ACPI Error: Aborting method \_SB.PCI0.VGA.ATC0 due to previous erro>
  Feb 08 02:11:27 nixxin kernel: ACPI Error: Aborting method \_SB.PCI0.VGA.ATCS due to previous erro>
  Feb 08 02:11:27 nixxin kernel: amdgpu: Overdrive is enabled, please disable it before reporting an>
  ```

  - [PERFORMANCE METRICS]
    - GPU Utilization: ~50-60% on Linux vs 95-100% on Windows

## [HARDWARE DETAILS]

- **Hardware Model**: HP HP EliteDesk 705 G2 SFF/805A, BIOS N06 Ver. 02.52 04/11/2022
- **Hardware SKU**: L1M89AV
- **Hardware Version**: KBC Version 05.35
- **Architecture**: x86-64
- **Firmware Date**: Tue 2020-10-20
- **CPU/APU**: AMD PRO A8-8650B R7 (Kaveri, 4 cores/4 threads, 3.2GHz base/3.9GHz boost)
- **iGPU**: AMD Radeon R7 (GCN 1.1 / GFX7 / GCN-era iGPU / 0000:00:01.0 ), 512 shaders, 720MHz base clock
- **Memory**: 16GB DDR3 (2x8GB) running at 1333MHz (Dual Channel)
- **Storage**: 256GB SATA SSD
- **OS**: NixOS Unstable (as of February 2026)
- **Kernel**: Linux 6.18-zen1
- **Display**: 1920x1080 @ 60Hz
