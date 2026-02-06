# Debug The System

Here we will analyize some a three log files to find something wrong or not work correctly and want to be fixed, or something we could improve.

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

### kernel driver

```bash
lspci -k -d ::03xx
00:01.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Kaveri [Radeon R7 Graphics] (rev d6)
        Subsystem: Hewlett-Packard Company Device 805a
        Kernel driver in use: amdgpu
        Kernel modules: radeon, amdgpu


modinfo amdgpu | grep mask
  parm:           ip_block_mask:IP Block Mask (all blocks enabled (default)) (uint)
  parm:           ppfeaturemask:all power features enabled (default)) (hexint)
  parm:           cg_mask:Clockgating flags mask (0 = disable clock gating) (ullong)
  parm:           pg_mask:Powergating flags mask (0 = disable power gating) (uint)
  parm:           ras_mask:Mask of RAS features to enable (default 0xffffffff), only valid when ras_enable == 1 (uint)
  parm:           dcfeaturemask:all stable DC features enabled (default)) (uint)
  parm:           dcdebugmask:all debug options disabled (default)) (uint)
  parm:           debug_mask:debug options for amdgpu, disabled by default (uint)


sudo  dmesg | grep kfd
  [sudo] password for softeng:
  [    9.641917] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
  [    9.641951] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
  [    9.642220] kfd kfd: amdgpu: added device 1002:1313

grep flags /sys/class/kfd/kfd/topology/nodes/*/io_links/0/properties
  /sys/class/kfd/kfd/topology/nodes/0/io_links/0/properties:flags 15
  /sys/class/kfd/kfd/topology/nodes/1/io_links/0/properties:flags 1
```

## How my nixos configs work? and what We want to do?

1. First in flake.nix we imported the `_settings.nix`
2. In `_settings.nix` we imported the Path of the user Profile that we want to apply his settings
3. Here is the User settings `users/softeng/desktop/HP/default.nix`
4. Here is the file where we imported all the modules that we want `users/softeng/desktop/HP/configuration.nix`
5. Here the user hardware configs file `users/softeng/desktop/HP/hardware.nix`
6. Here the user Home-Manager configs file `users/softeng/desktop/HP/home.nix`
7. We can enable/disable a spacific module when we set true/false in `users/softeng/desktop/HP/default.nix` also there are some settings for each module
8. In `modules/overclock` We trying to overclock the pc to get more performance
9. The `modules/graphics/default.nix` is the most important module for me, this is the module where all graphics/compute settings and packages exist, and also I use the compute with hashcat, like mesa opencl, and its work but it slow, I don't know why, there something make hashcast slow and lose 30% or 40% of the Performace/Speed and clvk doesn't work and gives me an error `clSetKernelArg(): CL_INVALID_ARG_VALUE`. also pocl doesn't work, In the past when I was work on the windows where radeon drivers on the hashcat speed was 24000 h/s and as you see its 12111 H/s. it so slow so there is something wrong, maybe because the drivers like mesa, amdgpu or the PC Mix RAMS make the A/B Channels now work correctly, or the APU Power, I realy doesn'y know.
10. You will find some useful logs about hashcat in `logs/hashcat_backend.log.txt` and `logs/hashcat.log.txt`
11. Here you will find the important system/boot configs `modules/system/*.nix`
12. Here you will find the power configs 4. `modules/power/*.nix`
13. I want you to understand the configs how it work and than focus/understand the errors that related to ACPI through read/analyize the FULL log file `logs/journalctl--dmesg.log.txt` , so we can know the erros/problem and things that doens't work correctly and make the pc slow, The APU doesn't work in his full power it lose 50% of his performance, I think it because of ACPI Errors, And also the Windows Tricks like adding acpi*osi to kernal params (acpi_osi=! acpi_osi=Linux acpi_osi=Windows "acpi_osi=acpi_osi=Windows 2020" etc...) doesn't work for me, Also I think that the ACPI problem because of the UEFI, What if we install the NIXOS on legacy BIOS and disable the UEFI, I really doesn't know what I must do, Windows was work perfectly on this PC, But I don't use Windows anymore for years, And I will not use it again.1. Example of logs that we aims to fix
    Jan 31 21:18:09 nixxin kernel: APIC: Static calls initialized
    Jan 31 21:18:09 nixxin kernel: efi: EFI v2.4 by HP
    Jan 31 21:18:09 nixxin kernel: efi: ACPI 2.0=0x7effe014 SMBIOS=0x7e1cb000 ESRT=0x7e1b2f98 INITRD=0x72f92d18
    Jan 31 21:18:09 nixxin kernel: efi: Remove mem35: MMIO range=[0xe0000000-0xefffffff] (256MB) from e820 map
    Jan 31 21:18:09 nixxin kernel: SMBIOS 2.7 present.
    Jan 31 21:18:09 nixxin kernel: DMI: HP HP EliteDesk 705 G2 SFF/805A, BIOS N06 Ver. 02.52 04/11/2022
    Jan 31 21:18:09 nixxin kernel: DMI: Memory slots populated: 4/4
    Jan 31 21:18:09 nixxin kernel: tsc: Fast TSC calibration using PIT
    Jan 31 21:18:09 nixxin kernel: tsc: Detected 3194.001 MHz processor
    Jan 31 21:18:09 nixxin kernel: ACPI: Early table checksum verification disabled
    Jan 31 21:18:09 nixxin kernel: ACPI: Core revision 20250807
    Jan 31 21:18:09 nixxin kernel: clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
    Jan 31 21:18:09 nixxin kernel: APIC: Switch to symmetric I/O mode setup
    Jan 31 21:18:09 nixxin kernel: ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
    Jan 31 21:18:09 nixxin kernel: clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2e0a2765c9e, max_idle_ns: 440795366920 ns
    Jan 31 21:18:09 nixxin kernel: smpboot: CPU0: AMD PRO A8-8650B R7, 10 Compute Cores 4C+6G (family: 0x15, model: 0x38, stepping: 0x1)
    Jan 31 21:18:09 nixxin kernel: Performance Events: Fam15h core perfctr, AMD PMU driver.
    Jan 31 21:18:09 nixxin kernel: cpuidle: using governor menu
    Jan 31 21:18:09 nixxin kernel: ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
    Jan 31 21:18:09 nixxin kernel: acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
    Jan 31 21:18:09 nixxin kernel: PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for domain 0000 [bus 00-ff]
    Jan 31 21:18:09 nixxin kernel: PCI: Using configuration type 1 for base access
    Jan 31 21:18:09 nixxin kernel: kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
    Jan 31 21:18:09 nixxin kernel: HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
    Jan 31 21:18:09 nixxin kernel: HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
    Jan 31 21:18:09 nixxin kernel: HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
    Jan 31 21:18:09 nixxin kernel: HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
    Jan 31 21:18:09 nixxin kernel: ACPI: Added \_OSI(Module Device)
    Jan 31 21:18:09 nixxin kernel: ACPI: Added \_OSI(Processor Device)
    Jan 31 21:18:09 nixxin kernel: ACPI: Added \_OSI(Processor Aggregator Device)
    Jan 31 21:18:09 nixxin kernel: ACPI: Added \_OSI(Linux)
    Jan 31 21:18:09 nixxin kernel: ACPI: 6 ACPI AML tables successfully acquired and loaded
    Jan 31 21:18:09 nixxin kernel: ACPI: EC: EC started
    Jan 31 21:18:09 nixxin kernel: ACPI: EC: interrupt blocked
    Jan 31 21:18:09 nixxin kernel: ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
    Jan 31 21:18:09 nixxin kernel: ACPI: \_SB*.PCI0.LPCB.EC0\_: Boot DSDT EC used to handle transactions
    Jan 31 21:18:09 nixxin kernel: ACPI: Interpreter enabled
    Jan 31 21:18:09 nixxin kernel: ACPI: PM: (supports S0 S3 S4 S5)
    Jan 31 21:18:09 nixxin kernel: ACPI: Using IOAPIC for interrupt routing
    Jan 31 21:18:09 nixxin kernel: PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
    Jan 31 21:18:09 nixxin kernel: PCI: Using E820 reservations for host bridge windows
    Jan 31 21:18:09 nixxin kernel: ACPI: Enabled 10 GPEs in block 00 to 1F
    Jan 31 21:18:09 nixxin kernel: ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
    Jan 31 21:18:09 nixxin kernel: acpi PNP0A08:00: \_OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
    Jan 31 21:18:09 nixxin kernel: acpi PNP0A08:00: \_OSC: platform does not support [LTR]
    Jan 31 21:18:09 nixxin kernel: acpi PNP0A08:00: \_OSC: OS now controls [PCIeHotplug PME PCIeCapability]
    Jan 31 21:18:09 nixxin kernel: acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
    Jan 31 21:18:09 nixxin kernel: PCI host bridge to bus 0000:00
    Jan 31 21:18:09 nixxin kernel: ACPI BIOS Error (bug): Could not resolve symbol [\_SB.ALIB], AE_NOT_FOUND (20250807/psargs-332)
    Jan 31 21:18:09 nixxin kernel: ACPI Error: Aborting method \_SB.PCI0.VGA.ATC0 due to previous error (AE_NOT_FOUND) (20250807/psparse-529)
    Jan 31 21:18:09 nixxin kernel: ACPI Error: Aborting method \_SB.PCI0.VGA.ATCS due to previous error (AE_NOT_FOUND) (20250807/psparse-529)
    Jan 31 21:18:09 nixxin kernel: [drm] RAM width 128bits UNKNOWN
    Jan 31 21:18:10 nixxin kernel: ACPI: OSL: Resource conflict; ACPI support missing from driver?
    Jan 31 21:18:10 nixxin kernel: acpi_cpufreq: overriding BIOS provided \_PSD data

14. As you know this is a desktop pc device it is not a laptop so we don't care about saving the power, All we care about is the **Performance** and fixing ACPI or use someting else instead of ACPI
15. While you working you can wrote a log/information and errors list, warns list and issues inside a `logs/log.md` or anything you want to save. and write everyting we must fix and change and if you have a soultion it would be nice to write it also in the `logs/log.md` don't edit directly the configs just read what you want to read.

## Importnat Logs

```bash
❯  sudo dmesg | grep -i acpi
[sudo] password for softeng:
[    0.000000] Command line: BOOT_IMAGE=(hd0,gpt1)//kernels/wka79msdzqphqr48nlw03fxldfz3s2c9-linux-zen-6.18-bzImage init=/nix/store/zwz42j647khqc44mxgs6g92z2c5zlj9n-nixos-system-nixxin-26.05.20251208.addf7cf/init radeon.si_support=0 amdgpu.si_support=1 radeon.cik_support=0 amdgpu.cik_support=1 amdgpu.ppfeaturemask=0xffffffff amdgpu.dc=0 amdgpu.runpm=0 amdgpu.dpm=1 amdgpu.gpu_recovery=1 amdgpu.vm_fragment_size=9 amdgpu.dcfeaturemask=0x1 amdgpu.dcdebugmask=0x10 amdgpu.sg_display=0 amdgpu.bapm=1 amd_iommu=on amdgpu.audio=0 amdgpu.gpu_recovery=1 processor.ignore_ppc=1 pci=noaer idle=nomwait thermal.off=1 random.trust_cpu=on tsc=reliable clocksource=tsc no_timer_check acpi_osi=Linux acpi_enforce_resources=lax intremap=off iommu=pt audit=0 quiet splash loglevel=0 systemd.show_status=false rd.systemd.show_status=false udev.log_level=0 rd.udev.log_level=0 plymouth.ignore-serial-consoles mitigations=off split_lock_mitigate=off retbleed=off threadirqs preempt=full pcie_aspm=off net.ifnames=0 transparent_hugepage=always psi=1 psi=1
[    0.000000] BIOS-e820: [mem 0x000000007e8cf000-0x000000007efcefff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007efcf000-0x000000007effefff] ACPI data
[    0.000000] efi: ACPI 2.0=0x7effe014 SMBIOS=0x7e1cb000 ESRT=0x7e1b2f98 INITRD=0x751cee18
[    0.015830] ACPI: Early table checksum verification disabled
[    0.015834] ACPI: RSDP 0x000000007EFFE014 000024 (v02 HPQOEM)
[    0.015840] ACPI: XSDT 0x000000007EFFE120 00009C (v01 HPQOEM SLIC-BPC 00000001      01000013)
[    0.015846] ACPI: FACP 0x000000007EFFC000 0000F4 (v04 HPQOEM SLIC-BPC 00000001 HP   00000001)
[    0.015853] ACPI: DSDT 0x000000007EFE7000 00DE31 (v02 HPQOEM 805A     00000000 INTL 20121018)
[    0.015856] ACPI: FACS 0x000000007EF88000 000040
[    0.015859] ACPI: UEFI 0x000000007EFFD000 000042 (v01                 00000000      00000000)
[    0.015862] ACPI: MSDM 0x000000007EFFB000 000055 (v03 HPQOEM SLIC-BPC 00000000 HP   00000001)
[    0.015866] ACPI: SLIC 0x000000007EFFA000 000176 (v01 HPQOEM SLIC-BPC 00000001 HP   00000001)
[    0.015869] ACPI: WSMT 0x000000007EFF9000 000028 (v01 HPQOEM 805A     00000001 HP   00000001)
[    0.015872] ACPI: ASF! 0x000000007EFF8000 00006E (v32 HPQOEM 805A     00000001 HP   00000001)
[    0.015875] ACPI: HPET 0x000000007EFF7000 000038 (v01 HPQOEM 805A     00000001 HP   00000001)
[    0.015878] ACPI: APIC 0x000000007EFF6000 000090 (v03 HPQOEM 805A     00000001 HP   00000001)
[    0.015881] ACPI: MCFG 0x000000007EFF5000 00003C (v01 HPQOEM 805A     00000001 HP   00000001)
[    0.015884] ACPI: SSDT 0x000000007EFE6000 000346 (v02 AMD    BIANCHI  00000002 MSFT 04000000)
[    0.015887] ACPI: IVRS 0x000000007EFE5000 000078 (v02 AMD    BIANCHI  00000001 AMD  00000000)
[    0.015889] ACPI: SSDT 0x000000007EFE3000 0019DD (v01 HP     CPMDFIGP 00000001 INTL 20121018)
[    0.015892] ACPI: SSDT 0x000000007EFE1000 0015EE (v01 AMD    CPMCMN   00000001 INTL 20121018)
[    0.015895] ACPI: FPDT 0x000000007EFE0000 000044 (v01 HPQOEM EDK2     00000002      01000013)
[    0.015898] ACPI: BGRT 0x000000007EFDF000 000038 (v01 HPQOEM EDK2     00000002      01000013)
[    0.015900] ACPI: Reserving FACP table memory at [mem 0x7effc000-0x7effc0f3]
[    0.015902] ACPI: Reserving DSDT table memory at [mem 0x7efe7000-0x7eff4e30]
[    0.015903] ACPI: Reserving FACS table memory at [mem 0x7ef88000-0x7ef8803f]
[    0.015904] ACPI: Reserving UEFI table memory at [mem 0x7effd000-0x7effd041]
[    0.015905] ACPI: Reserving MSDM table memory at [mem 0x7effb000-0x7effb054]
[    0.015906] ACPI: Reserving SLIC table memory at [mem 0x7effa000-0x7effa175]
[    0.015907] ACPI: Reserving WSMT table memory at [mem 0x7eff9000-0x7eff9027]
[    0.015908] ACPI: Reserving ASF! table memory at [mem 0x7eff8000-0x7eff806d]
[    0.015909] ACPI: Reserving HPET table memory at [mem 0x7eff7000-0x7eff7037]
[    0.015910] ACPI: Reserving APIC table memory at [mem 0x7eff6000-0x7eff608f]
[    0.015911] ACPI: Reserving MCFG table memory at [mem 0x7eff5000-0x7eff503b]
[    0.015912] ACPI: Reserving SSDT table memory at [mem 0x7efe6000-0x7efe6345]
[    0.015913] ACPI: Reserving IVRS table memory at [mem 0x7efe5000-0x7efe5077]
[    0.015913] ACPI: Reserving SSDT table memory at [mem 0x7efe3000-0x7efe49dc]
[    0.015914] ACPI: Reserving SSDT table memory at [mem 0x7efe1000-0x7efe25ed]
[    0.015915] ACPI: Reserving FPDT table memory at [mem 0x7efe0000-0x7efe0043]
[    0.015916] ACPI: Reserving BGRT table memory at [mem 0x7efdf000-0x7efdf037]
[    0.111432] ACPI: PM-Timer IO Port: 0x408
[    0.111442] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.111445] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.111446] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.111447] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.111462] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.111465] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.111469] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.111471] ACPI: HPET id: 0x10228210 base: 0xfed00000
[    0.117566] Kernel command line: BOOT_IMAGE=(hd0,gpt1)//kernels/wka79msdzqphqr48nlw03fxldfz3s2c9-linux-zen-6.18-bzImage init=/nix/store/zwz42j647khqc44mxgs6g92z2c5zlj9n-nixos-system-nixxin-26.05.20251208.addf7cf/init radeon.si_support=0 amdgpu.si_support=1 radeon.cik_support=0 amdgpu.cik_support=1 amdgpu.ppfeaturemask=0xffffffff amdgpu.dc=0 amdgpu.runpm=0 amdgpu.dpm=1 amdgpu.gpu_recovery=1 amdgpu.vm_fragment_size=9 amdgpu.dcfeaturemask=0x1 amdgpu.dcdebugmask=0x10 amdgpu.sg_display=0 amdgpu.bapm=1 amd_iommu=on amdgpu.audio=0 amdgpu.gpu_recovery=1 processor.ignore_ppc=1 pci=noaer idle=nomwait thermal.off=1 random.trust_cpu=on tsc=reliable clocksource=tsc no_timer_check acpi_osi=Linux acpi_enforce_resources=lax intremap=off iommu=pt audit=0 quiet splash loglevel=0 systemd.show_status=false rd.systemd.show_status=false udev.log_level=0 rd.udev.log_level=0 plymouth.ignore-serial-consoles mitigations=off split_lock_mitigate=off retbleed=off threadirqs preempt=full pcie_aspm=off net.ifnames=0 transparent_hugepage=always psi=
[    0.331876] ACPI: Core revision 20250807
[    0.481004] ACPI: PM: Registering ACPI NVS region [mem 0x7e8cf000-0x7efcefff] (7340032 bytes)
[    0.487967] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.487970] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.495213] ACPI: Added _OSI(Module Device)
[    0.495216] ACPI: Added _OSI(Processor Device)
[    0.495217] ACPI: Added _OSI(Processor Aggregator Device)
[    0.495231] ACPI: Added _OSI(Linux)
[    0.505022] ACPI: 4 ACPI AML tables successfully acquired and loaded
[    0.508083] ACPI: EC: EC started
[    0.508086] ACPI: EC: interrupt blocked
[    0.508430] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.508433] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used to handle transactions
[    0.508435] ACPI: Interpreter enabled
[    0.508486] ACPI: PM: (supports S0 S3 S4 S5)
[    0.508488] ACPI: Using IOAPIC for interrupt routing
[    0.508873] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.509189] ACPI: Enabled 10 GPEs in block 00 to 1F
[    0.519340] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.519351] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig Segments MSI HPX-Type3]
[    0.519354] acpi PNP0A08:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
[    0.519437] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    0.519559] acpi PNP0A08:00: ignoring host bridge window [mem 0x000cc000-0x000cffff window] (conflicts with Video ROM [mem 0x000c0000-0x000cf5ff])
[    0.525901] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.526007] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.526116] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.526225] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.526311] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.526375] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.526438] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.526501] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.526615] ACPI Warning: GPE type mismatch (level/edge) (20250807/evxface-791)
[    0.526626] ACPI: EC: interrupt unblocked
[    0.526627] ACPI: EC: event unblocked
[    0.526630] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.526631] ACPI: EC: GPE=0x8
[    0.526633] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC initialization complete
[    0.526636] ACPI: \_SB_.PCI0.LPCB.EC0_: EC: Used to handle transactions and events
[    0.526842] ACPI: bus type USB registered
[    0.528215] PCI: Using ACPI for IRQ routing
[    0.539014] pnp: PnP ACPI init
[    0.540869] pnp: PnP ACPI: found 8 devices
[    0.547665] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.659872] ACPI: bus type drm_connector registered
[    0.660076] amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled
[    0.935950] caller acpi_os_map_iomem+0x244/0x280 mapping multiple BARs
[    0.991745] ACPI: video: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[    0.991785] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query honored via cmdline
[    9.406625] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.ALIB], AE_NOT_FOUND (20250807/psargs-332)
[    9.406639] ACPI Error: Aborting method \_SB.PCI0.VGA.ATC0 due to previous error (AE_NOT_FOUND) (20250807/psparse-529)
[    9.406646] ACPI Error: Aborting method \_SB.PCI0.VGA.ATCS due to previous error (AE_NOT_FOUND) (20250807/psparse-529)
[   10.293493] ata3.00: ACPI cmd f5/00:00:00:00:00:e0(SECURITY FREEZE LOCK) filtered out
[   10.293502] ata3.00: ACPI cmd b1/c1:00:00:00:00:e0(DEVICE CONFIGURATION OVERLAY) filtered out
[   10.293709] ata2.00: ACPI cmd f5/00:00:00:00:00:e0(SECURITY FREEZE LOCK) filtered out
[   10.293719] ata2.00: ACPI cmd b1/c1:00:00:00:00:e0(DEVICE CONFIGURATION OVERLAY) filtered out
[   10.294655] ata3.00: ACPI cmd f5/00:00:00:00:00:e0(SECURITY FREEZE LOCK) filtered out
[   10.294659] ata3.00: ACPI cmd b1/c1:00:00:00:00:e0(DEVICE CONFIGURATION OVERLAY) filtered out
[   10.295437] ata2.00: ACPI cmd f5/00:00:00:00:00:e0(SECURITY FREEZE LOCK) filtered out
[   10.295441] ata2.00: ACPI cmd b1/c1:00:00:00:00:e0(DEVICE CONFIGURATION OVERLAY) filtered out
[   10.295536] ata1.00: ACPI cmd f5/00:00:00:00:00:e0(SECURITY FREEZE LOCK) filtered out
[   10.321368] ata1.00: ACPI cmd f5/00:00:00:00:00:e0(SECURITY FREEZE LOCK) filtered out
[   14.842093] ACPI: button: Power Button [PWRB]
[   14.847904] ACPI: button: Power Button [PWRF]
[   14.976416] ACPI Warning: SystemIO range 0x0000000000000B00-0x0000000000000B08 conflicts with OpRegion 0x0000000000000B00-0x0000000000000B06 (\_SB.PCI0.SMBS.SMBO) (20250807/utaddress-204)
[   14.976630] ACPI: OSL: Resource conflict; ACPI support missing from driver?
[   14.976632] ACPI: OSL: Resource conflict: System may be unstable or behave erratically
```
