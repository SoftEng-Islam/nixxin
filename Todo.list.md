# To Do List

1. Check GameMode `./scripts/gamemode.nix`
2. Check zsh `./modules/cli_tools/shells/zsh.nix`
3. develop `./pc_diagnose.sh`
4. hashcat command keeping run in the background why
5. Is there any thing reduce/slowing the PC performance in `./modules/system/memory.nix`
6.

Secound: I want make handbrake that exist here `modules/media/default.nix` recognize and use `h264_vaapi /dev/dri/renderD128` like ffmpeg does

Thired: I have these problems with the ACPI
journalctl -p 3 -b
Feb 10 05:39:52 nixxin kernel: ACPI: \LNKA: \_CRS returned 0
Feb 10 05:39:52 nixxin kernel: ACPI: \LNKB: \_CRS returned 0
Feb 10 05:39:52 nixxin kernel: ACPI: \LNKC: \_CRS returned 0
Feb 10 05:39:52 nixxin kernel: ACPI: \LNKD: \_CRS returned 0
Feb 10 05:39:52 nixxin kernel: ACPI: \LNKE: \_CRS returned 0
Feb 10 05:39:52 nixxin kernel: ACPI: \LNKF: \_CRS returned 0
Feb 10 05:39:52 nixxin kernel: ACPI: \LNKG: \_CRS returned 0
Feb 10 05:39:52 nixxin kernel: ACPI: \LNKH: \_CRS returned 0
Feb 10 05:39:52 nixxin kernel: ACPI BIOS Error (bug): Could not resolve symbol [\_SB.ALIB], AE_NOT_FOUND (20250807/psargs-332)
Feb 10 05:39:52 nixxin kernel: ACPI Error: Aborting method \_SB.PCI0.VGA.ATC0 due to previous error (AE_NOT_FOUND) (20250807/psparse-529)
Feb 10 05:39:52 nixxin kernel: ACPI Error: Aborting method \_SB.PCI0.VGA.ATCS due to previous error (AE_NOT_FOUND) (20250807/psparse-529)

and someone also here `https://forums.gentoo.org/viewtopic-p-8675013.html?sid=72f8112accb80d47fd6612888b74831e` was fix this problme but I don't know how I fix it

## PC Information

- **Hardware Model**: HP HP EliteDesk 705 G2 SFF/805A, BIOS N06 Ver. 02.52 04/11/2022
- **Hardware SKU**: L1M89AV
- **Hardware Version**: KBC Version 05.35
- **Architecture**: x86-64
- **Firmware Date**: Tue 2020-10-20
- **CPU**: AMD PRO A8-8650B R7, 10 Compute Cores 4C+6G (family: 0x15, model: 0x38, stepping: 0x1) (4 cores, 4 threads)
- **GPU**: AMD Radeon R7 Graphics (KAVERI / GCN-era iGPU) 0000:00:01.0
- **Memory**: 18 GB DDR3 installed (4 GB + 2 GB + 4 GB + 8 GB), configured at **1333 MT/s** on all sticks. More details in (`./logs/RAM.txt`)
- **OS / Kernel**: NixOS 26.05 (Yarara), Linux `6.18.0-zen1`
