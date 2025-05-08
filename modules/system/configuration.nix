{ settings, config, lib, pkgs, ... }:
# ------------------------------------------------
# !NOTICE: You Must Read And Customize This File
# ------------------------------------------------
# ---- Table Of Content
# -- Boot Configuration
# -- Hardware Configuration
# ------------------------------------------------

let inherit (lib) mkIf;
in {

  # ------------------------------------------------
  # ---- Boot Configuration
  # ------------------------------------------------
  boot = {
    # Change kernal to zen kernal
    kernelPackages = pkgs.linuxPackages_zen;
    # kernelPackages = pkgs.linuxKernel.packages.linux_zen;

    tmp.cleanOnBoot = true;
    supportedFilesystems = [ "btrfs" "ext4" "fat32" "nfs" "ntfs" ];
    consoleLogLevel = 0;

    # Boot Time out in seconds
    loader.timeout = settings.modules.system.boot.loader.timeout;

    # Whether the installation process is allowed to modify EFI boot variables.
    loader.efi.canTouchEfiVariables = true;

    # Make Memtest86+ available from the systemd-boot menu. Memtest86+ is a program for testing memory.
    loader.systemd-boot.memtest86.enable = false;

    # NOTE!! disable to use GRUB instead of systemd-boot
    loader.systemd-boot.enable =
      if (settings.modules.system.boot.loader.manager.name == "SYSTEMD") then
        true
      else
        false;

    bootspec.enable =
      if (settings.modules.system.boot.loader.manager.name == "SYSTEMD") then
        true
      else
        false;

    loader.grub = {
      enable =
        if (settings.modules.system.boot.loader.manager.name == "GRUB") then
          true
        else
          false;

      fontSize = settings.modules.system.boot.loader.manager.grub.fontSize;
      # theme = settings.boot.loader.manager.grub.theme;
      efiSupport = settings.modules.system.boot.loader.manager.grub.efiSupport;
      gfxmodeEfi = settings.modules.system.boot.loader.manager.grub.gfxmodeEfi;
      devices = settings.modules.system.boot.loader.manager.grub.devices;
      device = settings.modules.system.boot.loader.manager.grub.device;
      useOSProber = settings.modules.system.boot.loader.manager.grub.osProber;

      # Make Memtest86+, a memory testing program, available from the GRUB boot menu.
      memtest86.enable = false;
      extraConfig =
        settings.modules.system.boot.loader.manager.grub.extraConfig;
      # extraEntries = ''
      #   menuentry 'Arch Linux' {
      #   	insmod part_gpt
      #   	insmod ext2
      #   	search --no-floppy --fs-uuid --set=root d8ac40a1-c821-402f-b593-baf82f4efc31
      #   	linux /boot/vmlinuz-linux root=UUID=d8ac40a1-c821-402f-b593-baf82f4efc31 rw
      #   	initrd /boot/initramfs-linux.img
      #   }

      #   menuentry 'Windows Boot Manager (on /dev/sdb2)' --class windows --class os $menuentry_id_option 'osprober-efi-0AEE-1E17' {
      #   	insmod part_gpt
      #   	insmod fat
      #   	set root='hd0,gpt1'
      #   	if [ x$feature_platform_search_hint = xy ]; then
      #   	  search --no-floppy --fs-uuid --set=root --hint-bios=hd0,gpt1 --hint-efi=hd0,gpt1 --hint-baremetal=ahci0,gpt1  0AEE-1E17
      #   	else
      #   	  search --no-floppy --fs-uuid --set=root 0AEE-1E17
      #   	fi
      #   	chainloader /EFI/Microsoft/Boot/bootmgfw.efi
      #   }
      # '';
    };

    initrd = {
      verbose = false;
      # systemd.dbus.enable = false;
      kernelModules = [ "amdgpu" ];

      # Additional kernel modules needed for virtualization
      availableKernelModules = [
        "ahci"
        "amdgpu"
        "cryptd"
        "ehci_pci"
        "ohci_pci"
        "pata_atiixp"
        "sd_mod"
        "usb_storage"
        "usbhid"
        "vfio_iommu_type1"
        "vfio_pci"
        "vfio"
        "xhci_pci"
      ];
    };
    kernelModules = [
      "radeon"
      "amd-pstate"
      "bfq"
      "binder_linux"
      "coretemp"
      "fuse"
      "kvm-amd"
      "msr"
      "uinput"
      "zenpower"
      "v4l2loopback"
    ];
    blacklistedKernelModules = [ "k10temp" ];
    extraModulePackages = with config.boot.kernelPackages;
      [
        v4l2loopback
        # zenpower
      ];

    extraModprobeConfig = ''
      options binder_linux devices=binder,hwbinder,vndbinder
    '';

    kernelParams = [
      # Reduce Boot Delay
      "quiet"
      "splash"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "ibt=off"
      "psi=1"

      # Makes Linux Pretend to be Windows 10/11 (2020 version) when interacting with ACPI.
      # Some BIOS/UEFI implementations contain Windows-specific ACPI tables, so they behave differently depending on the OS.
      # ''acpi_osi="Windows 2020"''

      "acpi_osi=Linux"
      # "acpi_enforce_resources=lax"

      # "nomodeset" # Black Screen Issues

      # "vt.default_red=30,243,166,249,137,245,148,186,88,243,166,249,137,245,148,166"
      # "vt.default_grn=30,139,227,226,180,194,226,194,91,139,227,226,180,194,226,173"
      # "vt.default_blu=46,168,161,175,250,231,213,222,112,168,161,175,250,231,213,200"

      "elevator=bfq" # Optimized disk performance for desktops

      # CPU optimizations
      "threadirqs"
      "mitigations=off"
      "idle=nomwait"
      "processor.max_cstate=1"
      # "amd_pstate=active" # Enables AMD's new power scaling
      # "amd_pstate.shared_mem=1"
      "clearcpuid=rdrand"

      # ---- Swap ---- #
      #"zswap.enabled=1"
      #"zswap.compressor=zstd"
      #"zswap.max_pool_percent=20"

      # AMD GPU optimizations
      # for Southern Islands (SI i.e. GCN 1) cards
      "radeon.si_support=1" # Ensures Radeon drivers don’t interfere
      "amdgpu.si_support=0"

      # for Sea Islands (CIK i.e. GCN 2) cards
      "radeon.cik_support=1"
      "amdgpu.cik_support=0"

      # If you want full control over power settings, use:
      # "amdgpu.ppfeaturemask=0xffffffff" # Unlock all gpu controls
      # If you have stability issues (freezes, black screens, crashes), try:
      # "amdgpu.ppfeaturemask=0xFFF7FFFF"
      # Check If It’s Applied:
      # cat /sys/module/amdgpu/parameters/ppfeaturemask
      # "amdgpu.dcfeaturemask=0x8"
      # "amdgpu.freesync_video=1"
      # "amdgpu.gpu_recovery=1"

      # "amdgpu.sg_display=0" # Fixes display-related ROCm issues
      # "amdgpu.noretry=0" # Improve memory handling
      # "amdgpu.dc=1" # Enables Display Core (improves multi-display support)
      # "amdgpu.dpm=1"
      # "amdgpu.deep_color=1"
      # "amdgpu.vramlimit=4096"
      # "amdgpu.gttsize=4096"

      # # increases the timeout of GFX jobs
      #"amdgpu.lockup_timeout=5000"

      # Disables HDMI/DisplayPort audio output on AMD GPUs.
      # Useful if you're not using HDMI/DP audio and want to prevent driver conflicts.
      # "amdgpu.audio=0"

      # "amdgpu.runpm=0"
      # "amdgpu.vm_size=8"
      # "amdgpu.exp_hw_support=1"
      # "amdgpu.vm_fragment_size=9"
      # "amdgpu.vm_fault_stop=2"
      # "amdgpu.vm_update_mode=3"
      # "amdgpu.unified_memory=1"
      # "amdgpu.memory_alloc_mode=2"
      # "pci=realloc"

      # System Performance
      "preempt=voluntary" # or full
      "transparent_hugepage=never"
      "clocksource=tsc"
      "tsc=reliable"

      # Power Management
      "workqueue.power_efficient=off" # General power responsiveness
      "pcie_aspm=off" # Disables PCIe power saving (better performance)
      # These control IOMMU (Input-Output Memory Management Unit), used for device isolation and passthrough in virtualization.
      "amd_iommu=on"
      "iommu=pt"

      # Storage
      "libata.force=noncq"

      # Prevents USB devices (e.g., keyboards, mice, controllers) from disconnecting due to power-saving.
      # Can fix issues where USB devices randomly stop working.
      "usbcore.autosuspend=-1" # Prevents USB disconnect issues

      # Prevents audio crackling or delay issues by keeping the sound card active.
      # If set to 1, the sound card powers down after a few seconds of inactivity.
      "snd_hda_intel.power_save=0"

      # Helps force-detect certain HDA (High Definition Audio) devices.
      "snd_hda_intel.probe_mask=1" # (Force Specific Audio Codec Detection)

      # WIFI
      "rtl8xxxu_disable_hw_crypto=1"
    ];

    kernel.sysctl = {
      # Users will do scary things and suddenly require more memory,
      # so let's take a bunch of spares from the cache so we don't OOM
      # as easily.
      "vm.user_reserve_kbytes" = 196608; # 1(2^17)
      "vm.admin_reserve_kbytes" = 65536; # 0.5(2^17)

      # Virtual memory tweaks
      "vm.swappiness" = 10; # Use RAM more before swapping
      "vm.vfs_cache_pressure" = 50;
      "vm.dirty_background_ratio" = 2;
      "vm.max_map_count" = 2147483642;
      # Write data to disk more frequently (prevents slowdowns)
      "vm.dirty_ratio" = 15;

      # Kernel Scheduler
      "kernel.sched_autogroup_enabled" = 0;
      "kernel.sched_child_runs_first" = 1;
      "kernel.sched_min_granularity_ns" = 10000000; # Improves CPU scheduling
      "kernel.sched_wakeup_granularity_ns" = 15000000; # Faster thread response

      # Disables watchdog timer (can improve latency)
      "kernel.nmi_watchdog" = 0;

      # File system tweaks
      "fs.file-max" = 2097152;
      "fs.inotify.max_user_watches" = 524288; # Prevent game crashes

      # Network optimization
      "net.core.rmem_max" = 16777216;
      "net.core.wmem_max" = 16777216;
      "net.core.rmem_default" = 1048576;
      "net.core.wmem_default" = 1048576;
      "net.ipv4.tcp_fastopen" = 3;
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.ipv4.tcp_slow_start_after_idle" = 0;
      "net.ipv4.ip_forward" = true; # Enable IPv4 forwarding
      "net.ipv6.conf.all.forwarding" = true; # Enable IPv6 forwarding
      "net.core.default_qdisc" = "fq";
      # sets the kernel’s TCP keepalive time to 120 seconds. To see the available parameters, run sysctl -a.
      "net.ipv4.tcp_keepalive_time" = 120;

      # PID optimization
      "kernel.pid_max" = 4194304;

      # ---- NoNewPrivs
      # Run this command to check if a process has NoNewPrivileges set:
      # grep NoNewPrivs /proc/*/status
      "kernel.unprivileged_userns_clone" = 1;
    };

    # extraModprobeConfig = ''
    # blacklist r8188eu
    # blacklist rtl8xxxu
    # '';

    # The Linux kernel does not have Rust language support enabled by default.
    # For kernel versions 6.7 or newer,
    # experimental Rust support can be enabled.
    # In a NixOS configuration, set:
    kernelPatches = [{
      name = "Rust Support";
      patch = null;
      features = { rust = true; };
    }];

    plymouth.enable = true;
    # plymouth.theme = "bgrt";
  };

  # ------------------------------------------------
  # ---- Hardware Configuration
  # ------------------------------------------------
  hardware = {
    uinput.enable = true;
    enableAllFirmware = true;
    cpu.amd.updateMicrocode = true;
    # cpu.amd.sev.enable = true;
    enableRedistributableFirmware = true;

    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
      legacySupport.enable = true;
      amdvlk = {
        enable = true;
        support32Bit.enable = true;
        supportExperimental.enable = true;
        settings = {
          IFH = 0;
          ShaderCacheMode = 1;
          EnableVmAlwaysValid = 1;
          IdleAfterSubmitGpuMask = 1;
          AllowVkPipelineCachingToDisk = 1;
        };
      };
    };

    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        # OpenCL ICD definition for AMD GPUs using the ROCm stack
        # rocmPackages.clr.icd
        # OpenCL runtime for AMD GPUs, part of the ROCm stack
        # rocmPackages.clr

        libva
        vaapiVdpau
        libvdpau-va-gl
        vulkan-loader

        # AMD Open Source Driver For Vulkan
        amdvlk

        # amf
        amdvlk # AMD Vulkan driver
        vulkan-validation-layers
        vulkan-tools
        vulkan-loader

        mesa
        mesa.opencl
        mesa-demos # Provides glxinfo, glxgears
        libglvnd
        libva
        libvdpau
        xorg.libXv
        xorg.libXvMC

        # Hardware-accelerated video playpack
        # VDPAU driver for the VAAPI library
        vaapiVdpau
        # VDPAU driver with OpenGL/VAAPI backend
        libvdpau-va-gl
        # Tool to query the Video Decode and Presentation API for Unix (VDPAU) abilities of the system
        vdpauinfo
        libGL
        libGLU
        libGLX
        libva
        libva-utils

        # ---- Unlocks OpenCL GPU Acceleration ---- #
        # rocmPackages.clr
        rocmPackages.clr.icd
        rocmPackages.rocm-runtime
        # rocmPackages.rocm-smi
        # rocmPackages.rocminfo
      ];

      # To enable Vulkan support for 32-bit applications, also add:
      extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
    };
  };

  # ------------------------------------------------
  # ---- AMD Configuration
  # ------------------------------------------------
  # Video Drivers
  services.xserver.videoDrivers = [ "radeon" "amdgpu" "modesetting" ];

  # Enable auto-epp for amd active pstate.
  services.auto-epp.enable = false;

  # services.ucodenix = {
  # enable = true;
  # docs: https://github.com/e-tho/ucodenix?tab=readme-ov-file#usage
  # cpuid -1 -l 1 -r | sed -n 's/.*eax=0x\([0-9a-f]*\).*/\U\1/p'
  # 00630F81
  # Replace with your processor's model ID, use (cpuid)
  # cpuModelId = "00630F81";
  # };

  # ---- Rocm Combined ---- #
  # - Fix for AMDGPU - Disabled cause it fails to build as of 30/01/2025
  systemd.tmpfiles.rules = let
    rocmEnv = pkgs.symlinkJoin {
      name = "rocm-combined";
      paths = with pkgs.rocmPackages; [ rocblas hipblas clr ];
    };
  in [
    "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
    "f /dev/shm/looking-glass 0660 dreamingcodes kvm -"
  ];

  # ------------------------------------------------
  # ---- etc
  # ------------------------------------------------
  # environment.etc."OpenCL/vendors/amdocl64.icd".source = pkgs.rocmPackages.clr.icd;
  environment.etc."OpenCL/vendors/amdocl64.icd".text =
    "${pkgs.rocmPackages.clr.icd}/lib/libamdocl64.so ";

  # ------------------------------------------------
  # ---- Kernel Thread Scheduler Optimization
  # ------------------------------------------------
  # https://github.com/sched-ext/scx
  # https://wiki.cachyos.org/configuration/sched-ext/
  # Use the newest kernel thread scheduler.
  services.scx = {
    enable = true;
    # scheduler = "scx_rusty"; # "scx_rusty" or "scx_lavd"
    scheduler = "scx_bpfland";
    package = pkgs.scx.full;
  };

  # ------------------------------------------------
  # ---- Variables
  # ------------------------------------------------
  environment.variables = {
    ROCM_PATH = "${pkgs.rocmPackages.rocm-runtime}";
    OCL_ICD_VENDORS = "/etc/OpenCL/vendors/";

    # HIP_VISIBLE_DEVICES = "0,2";

    # Optimize rendering and disable hardware cursors for Wayland-based compositors.
    WLR_RENDERER_ALLOW_SOFTWARE = "0"; # enable software rendering for wlroots
    # WLR_NO_HARDWARE_CURSORS = "1"; # disable hardware cursors for wlroots

    # This env var forces wgpu to use OpenGL instead of Vulkan
    WGPU_BACKEND = "gl";

    # Adjusts DRM devices, vsync, and atomic modes.
    WLR_DRM_DEVICES = "/dev/dri/card1";
    WLR_DRM_NO_ATOMIC = "1";
    WLR_VSYNC = "1";

    # ROCM_PATH = "${pkgs.rocmPackages.rocm-runtime}";
    # ROCM_TARGET = "gfx700";
    # ROC_ENABLE_PRE_VEGA = "1";

    GPU_FORCE_64BIT_PTR = "1";
    GPU_MAX_ALLOC_PERCENT = "100";
    GPU_MAX_HEAP_SIZE = "50";
    GPU_MAX_USE_SYNC_OBJECTS = "1";
    GPU_SINGLE_ALLOC_PERCENT = "50";

    # HIP_PATH = "${pkgs.rocmPackages.hip-common}/libexec/hip";
    # HSA_OVERRIDE_GFX_VERSION = "9.0.0"; # 10.3.0 or 9.0.0

    # OCL_ICD_VENDORS = "${pkgs.rocmPackages.clr.icd}/etc/OpenCL/vendors/";
    # OCL_ICD_VENDORS = "/etc/OpenCL/vendors/";

    # Fixes screen tearing in games & Hyprland.
    # vulkaninfo | grep "driverName"
    AMD_VULKAN_ICD = "RADV"; # Force RADV instead of AMDVLK

    #? What the Differante?
    VK_ICD_FILENAMES =
      "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";
    # VK_ICD_FILENAMES = "${pkgs.amdvlk}/share/vulkan/icd.d/amd_icd64.json";

    # VK_LAYER_PATH = "/etc/vulkan/layer.d";
    VK_LAYER_PATH = "/run/opengl-driver/share/vulkan/explicit_layer.d";

    AMD_VULKAN_DRIVER = "RADV";

    # Improves OpenGL compatibility & speed.
    MESA_GL_VERSION_OVERRIDE = "4.6";
    MESA_GLSL_VERSION_OVERRIDE = "460";
    AMD_DEBUG = "nodcc"; # Fixes rendering bugs on some games

    DISABLE_LAYER_AMD_SWITCHABLE_GRAPHICS_1 = "1";

  };

  environment.memoryAllocator.provider = "libc";

  environment.systemPackages = with pkgs; [
    linux-firmware # Binary firmware collection packaged by kernel.org
    v4l-utils
    dmidecode
    # ------------------------------------------------
    # ---- Boot Packages
    # ------------------------------------------------
    acpid
    fatcat
    os-prober
    grub2_efi
    grub2_full
    sleek-grub-theme
    nixos-grub2-theme

    # ------------------------------------------------
    # ---- Hardware Packages
    # ------------------------------------------------
    cpuid
    llvmPackages.mlir # Multi-Level IR Compiler Framework
    oclgrind # OpenCL device simulator and debugger
    pciutils # Collection of programs for inspecting and manipulating configuration of PCI devices
    # xivlauncher # Custom launcher for FFXIV
    # zenstates # Linux utility for Ryzen processors and motherboards

    # ------------------------------------------------
    # ---- AMD Stuff
    # ------------------------------------------------
    # amd-libflame # LAPACK-compatible linear algebra library optimized for AMD CPUs
    # amf # AMD's closed source Advanced Media Framework (AMF) driver
    amd-blis # BLAS-compatible library optimized for AMD CPUs
    amd-ucodegen # Tool to generate AMD microcode files
    amdctl # Set P-State voltages and clock speeds on recent AMD CPUs on Linux
    amdenc # AMD Encode Core Library
    amdgpu_top # Tool to display AMDGPU usage
    amdvlk # AMD Open Source Driver For Vulkan
    aocl-utils # Interface to all AMD AOCL libraries to access CPU features
    microcode-amd # AMD Processor microcode patch
    microcodeAmd
    nvtopPackages.amd

    clinfo # Print all known information about all available OpenCL platforms and devices in the system
    clpeak
    dxvk # A Vulkan-based translation layer for Direct3D
    glaxnimate # Simple vector animation program.
    glmark2 # OpenGL (ES) 2.0 benchmark
    gpu-viewer # A front-end to glxinfo, vulkaninfo, clinfo and es2_info
    hwdata # Hardware Database, including Monitors, pci.ids, usb.ids, and video cards
    libdrm # Direct Rendering Manager library and headers
    libplacebo # Reusable library for GPU-accelerated video/image rendering primitives
    libva # An implementation for VA-API (Video Acceleration API)
    openal # OpenAL alternative
    # clblast # Tuned OpenCL BLAS library
    khronos-ocl-icd-loader # Official Khronos OpenCL ICD Loader
    ocl-icd # OpenCL ICD Loader for opencl-headers-2023.12.14
    # oclgrind # OpenCL device simulator and debugger
    # opencl-clang # A clang wrapper library with an OpenCL-oriented API and the ability to compile OpenCL C kernels to SPIR-V modules
    # opencl-clhpp # OpenCL Host API C++ bindings
    # opencl-headers # Khronos OpenCL headers version 2023.12.14
    # pocl # Portable Computing Language

    spirv-cross
    spirv-headers
    spirv-llvm-translator
    spirv-tools
    libunwind
    llvm

    vkbasalt # Vulkan post processing layer for Linux
    vkquake # Vulkan Quake port based on QuakeSpasm
    vulkan-extension-layer # Layers providing Vulkan features when native support is unavailable
    vulkan-headers # Vulkan Header files and API registry
    vulkan-tools # Khronos official Vulkan Tools and Utilities
    vulkan-utility-libraries # Set of utility libraries for Vulkan

    xorg.xf86videoamdgpu
    lact # Linux AMDGPU Controller and GPU overclocking tool

    # ------------------------------------------------
    # ---- Mesa Packages
    # ------------------------------------------------
    mesa # An open source 3D graphics library
    mesa_glu # OpenGL utility library
    mesa_i686 # Open source 3D graphics library
    mesa-demos # Collection of demos and test programs for OpenGL and Mesa
    driversi686Linux.mesa # An open source 3D graphics library

    # ------------------------------------------------
    # ---- ROCM Packages
    # ------------------------------------------------
    # rocmPackages.clr
    # rocmPackages.hip-common
    # rocmPackages.hipblas
    # rocmPackages.hipcc
    # rocmPackages.hipcub
    # rocmPackages.hipfft
    # rocmPackages.hipify
    # rocmPackages.hiprand
    # rocmPackages.rocm-runtime
    # rocmPackages.rocminfo
    # rocmPackages.rpp-opencl

    # ------------------------------------------------
    # ---- Vulkan
    # ------------------------------------------------
    dxvk # A Vulkan-based translation layer for Direct3D
    vkbasalt # Vulkan post processing layer for Linux
    vkquake # Vulkan Quake port based on QuakeSpasm
    vulkan-caps-viewer
    vulkan-cts
    vulkan-extension-layer # Layers providing Vulkan features when native support is unavailable
    vulkan-hdr-layer-kwin6
    vulkan-headers # Vulkan Header files and API registry
    vulkan-helper
    vulkan-loader
    vulkan-memory-allocator
    vulkan-tools # Khronos official Vulkan Tools and Utilities
    vulkan-tools-lunarg
    vulkan-utility-libraries # Set of utility libraries for Vulkan
    vulkan-validation-layers
    vulkan-volk
    driversi686Linux.amdvlk # AMD Open Source Driver For Vulkan
    # ------------------------------------------------
    # ---- AMD Packages
    # ------------------------------------------------
    amd-blis # BLAS-compatible library optimized for AMD CPUs
    amd-ucodegen # Tool to generate AMD microcode files
    amdctl # Set P-State voltages and clock speeds on recent AMD CPUs on Linux
    amdenc # AMD Encode Core Library
    amdgpu_top # Tool to display AMDGPU usage
    amdvlk # AMD Open Source Driver For Vulkan
    aocl-utils # Interface to all AMD AOCL libraries to access CPU features
    microcode-amd # AMD Processor microcode patch
    microcodeAmd # AMD Processor microcode patch
    nvtopPackages.amd # (h)top like task monitor for AMD, Adreno, Intel and NVIDIA GPUs
    xorg.xf86videoamdgpu
    # amd-libflame # LAPACK-compatible linear algebra library optimized for AMD CPUs

    # ---- Radeon Cards
    radeon-profile
    radeontools
    radeontop

    # Inspect and manipulate PCI devices
    pciutils

    # Print all known information about all available OpenCL platforms and devices in the system
    # clinfo

    # Top-like tool for viewing AMD Radeon GPU utilization
    radeontop

    # Application to read current clocks of AMD Radeon cards
    radeon-profile

    # ROCm Application for Reporting System Info
    # rocmPackages.rocminfo

    # System management interface for AMD GPUs supported by ROCm
    # rocmPackages.rocm-smi

    # Platform runtime for ROCm
    # rocmPackages.rocm-runtime

    # CMake modules for common build tasks for the ROCm stack
    # rocmPackages.rocm-cmake

    # Radeon open compute thunk interface
    # rocmPackages.rocm-thunk

    lshw # Provide detailed information on the hardware configuration of the machine
    lshw-gui

    libglvnd
  ];
}
