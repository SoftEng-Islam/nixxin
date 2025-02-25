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

    tmp.cleanOnBoot = true;
    supportedFilesystems = [ "btrfs" "ext4" "fat32" "nfs" "ntfs" ];
    consoleLogLevel = 0;

    # Boot Time out in seconds
    loader.timeout = settings.boot.loader.timeout;

    # Whether the installation process is allowed to modify EFI boot variables.
    loader.efi.canTouchEfiVariables = true;

    # NOTE!! disable to use GRUB instead of systemd-boot
    loader.systemd-boot.enable =
      if (settings.system.boot.loader.manager.name == "SYSTEMD") then
        true
      else
        false;

    bootspec.enable =
      if (settings.boot.loader.manager.name == "SYSTEMD") then true else false;

    loader.grub = {
      enable =
        if (settings.boot.loader.manager.name == "GRUB") then true else false;

      fontSize = settings.boot.loader.manager.grub.fontSize;
      # theme = settings.boot.loader.manager.grub.theme;
      efiSupport = settings.boot.loader.manager.grub.efiSupport;
      gfxmodeEfi = settings.boot.loader.manager.grub.gfxmodeEfi;
      devices = settings.boot.loader.manager.grub.devices;
      device = settings.boot.loader.manager.grub.device;
      useOSProber = settings.boot.loader.manager.grub.osProber;
      extraConfig = settings.boot.loader.manager.grub.extraConfig;
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
      "amd-pstate"
      "bfq"
      "binder_linux"
      "coretemp"
      "fuse"
      "kvm-amd"
      "msr"
      "uinput"
      "zenpower"
    ];
    blacklistedKernelModules = [ "k10temp" "rtl8812au" "rtl8xxxu" "r8188eu" ];
    extraModulePackages = with config.boot.kernelPackages; [
      rtl8188eus-aircrack
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

      # makes Linux pretend to be Windows 10/11 (2020 version) when interacting with ACPI.
      # Some BIOS/UEFI implementations contain Windows-specific ACPI tables, so they behave differently depending on the OS.
      ''acpi_osi="Windows 2020"''
      # this doesn't fix my ACPI Bios errors :c
      # source: https://discordapp.com/channels/761178912230473768/1159412133117833286
      # "acpi_osi=Linux"

      # Black Screen Issues
      # "nomodeset"

      "rtl8xxxu_disable_hw_crypto=1"
      "iommu=pt"
      # "drm.kms_helper.parallel_locks=1"
      # "acpi_enforce_resources=lax"
      "pcie_aspm=off"

      # "acpi_osi=Linux"
      # "pci=realloc"

      # "vt.default_red=30,243,166,249,137,245,148,186,88,243,166,249,137,245,148,166"
      # "vt.default_grn=30,139,227,226,180,194,226,194,91,139,227,226,180,194,226,173"
      # "vt.default_blu=46,168,161,175,250,231,213,222,112,168,161,175,250,231,213,200"

      "elevator=bfq" # Optimized disk performance for desktops

      # CPU optimizations
      "threadirqs"
      "mitigations=off"
      "idle=nomwait"
      "processor.max_cstate=1"
      "amd_pstate=active" # Enables AMD's new power scaling
      "amd_pstate.shared_mem=1"
      "clearcpuid=rdrand"

      # ---- Swap ---- #
      # "zswap.enabled=1"
      # "zswap.compressor=lz4"
      # "zswap.max_pool_percent=20"

      # AMD GPU optimizations
      # If you want full control over power settings, use:
      "amdgpu.ppfeaturemask=0xffffffff" # Unlock all gpu controls
      # If you have stability issues (freezes, black screens, crashes), try:
      # "amdgpu.ppfeaturemask=0xFFF7FFFF"
      # Check If It’s Applied:
      # cat /sys/module/amdgpu/parameters/ppfeaturemask

      "amdgpu.dcfeaturemask=0x8"
      "amdgpu.freesync_video=1"
      "amdgpu.gpu_recovery=1"

      # for Southern Islands (SI i.e. GCN 1) cards
      "radeon.si_support=0" # Ensures Radeon drivers don’t interfere
      "amdgpu.si_support=1"

      # for Sea Islands (CIK i.e. GCN 2) cards
      "radeon.cik_support=0"
      "amdgpu.cik_support=1"

      "amdgpu.audio=0"
      "amdgpu.sg_display=0" # Fixes display-related ROCm issues
      "amdgpu.noretry=0" # Improve memory handling
      "amdgpu.dc=1" # Enables Display Core (improves multi-display support)
      "amdgpu.dpm=1"
      "amdgpu.gttsize=4096"
      "amdgpu.deep_color=1"
      # "amdgpu.runpm=0"
      # "amdgpu.vm_size=8"
      # "amdgpu.exp_hw_support=1"
      # "amdgpu.vm_fragment_size=9"
      # "amdgpu.vm_fault_stop=2"
      # "amdgpu.vm_update_mode=3"
      # "amdgpu.unified_memory=1"
      # "amdgpu.memory_alloc_mode=2"

      # System Performance
      "preempt=voluntary"
      "transparent_hugepage=never"
      "clocksource=tsc"
      "tsc=reliable"

      # Power Management
      "workqueue.power_efficient=off"
      "amd_iommu=off"
      "pcie_aspm=off" # Disables PCIe power saving (better performance)

      # Audio and USB
      "usbcore.autosuspend=-1" # Prevents USB disconnect issues
      "snd_hda_intel.power_save=0"
      "snd_hda_intel.probe_mask=1"
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
      "vm.max_map_count" = 262144;
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
      opencl.enable = false;
      legacySupport.enable = false;
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
        amf
        amdvlk # AMD Vulkan driver
        vulkan-validation-layers
        vulkan-tools
        vulkan-loader

        mesa
        mesa.drivers
        mesa.vulkan-drivers # Adds RADV Vulkan driver
        mesa.opencl
        mesa-demos # Provides glxinfo, glxgears
        libglvnd
        libva
        libvdpau
        xorg.libXv
        xorg.libXvMC

        libvdpau-va-gl
        libGL
        libGLU
        libGLX
        libva
        libva-utils
        vaapiVdpau

        # ---- Unlocks OpenCL GPU acceleration ---- #
        # rocmPackages.clr
        # rocmPackages.clr.icd
        # rocmPackages.rocm-runtime
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
  services.xserver.videoDrivers = [ "amdgpu" "radeon" ];

  # Enable auto-epp for amd active pstate.
  services.auto-epp.enable = true;

  # Whether to enable auto-cpufreq daemon.
  services.auto-cpufreq.enable = true;

  # services.ucodenix = {
  # enable = true;
  # docs: https://github.com/e-tho/ucodenix?tab=readme-ov-file#usage
  # cpuid -1 -l 1 -r | sed -n 's/.*eax=0x\([0-9a-f]*\).*/\U\1/p'
  # 00630F81
  # Replace with your processor's model ID, use (cpuid)
  # cpuModelId = "00630F81";
  # };

  systemd.services.lact = {
    enable = false;
    description = "AMDGPU Control Daemon";
    after = [ "multi-user.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = { ExecStart = "${pkgs.lact}/bin/lact daemon"; };
  };

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
  # ---- Variables
  # ------------------------------------------------
  environment.variables = {
    # HIP_VISIBLE_DEVICES = "0,2";

    # Optimize rendering and disable hardware cursors for Wayland-based compositors.
    WLR_RENDERER_ALLOW_SOFTWARE = "1"; # enable software rendering for wlroots
    WLR_NO_HARDWARE_CURSORS = "1"; # disable hardware cursors for wlroots

    # If you have graphical issues like missing transparency or graphical artifact you could launch ashell with WGPU_BACKEND=gl. This env var forces wgpu to use OpenGL instead of Vulkan
    WGPU_BACKEND = "gl";

    # Adjusts DRM devices, vsync, and atomic modes.
    WLR_DRM_DEVICES = "/dev/dri/card1";
    WLR_DRM_NO_ATOMIC = "1";
    WLR_VSYNC = "1";

    # ROCM_PATH = "${pkgs.rocmPackages.rocm-runtime}";
    # ROCM_TARGET = "gfx700";
    # ROC_ENABLE_PRE_VEGA = "1";

    GPU_FORCE_64BIT_PTR = "1";
    GPU_MAX_ALLOC_PERCENT = "50";
    GPU_MAX_HEAP_SIZE = "50";
    GPU_MAX_USE_SYNC_OBJECTS = "1";
    GPU_SINGLE_ALLOC_PERCENT = "50";

    # HIP_PATH = "${pkgs.rocmPackages.hip-common}/libexec/hip";
    # HSA_OVERRIDE_GFX_VERSION = "9.0.0"; # 10.3.0 or 9.0.0

    LIBVA_DRIVER_NAME = "amdgpu"; # Load AMD driver for Xorg and Waylandard
    # OCL_ICD_VENDORS = "${pkgs.rocmPackages.clr.icd}/etc/OpenCL/vendors/";
    # OCL_ICD_VENDORS = "/etc/OpenCL/vendors/";

    # Fixes screen tearing in games & Hyprland.
    AMD_VULKAN_ICD = "RADV"; # Force RADV instead of AMDVLK
    #VK_ICD_FILENAMES = "${pkgs.amdvlk}/share/vulkan/icd.d/amd_icd64.json";
    VK_ICD_FILENAMES =
      "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";
    VK_LAYER_PATH = "/etc/vulkan/layer.d";
    vblank_mode = "0"; # Reduces latency

    # Improves OpenGL compatibility & speed.
    MESA_GL_VERSION_OVERRIDE = "4.6";
    MESA_GLSL_VERSION_OVERRIDE = "460";
    AMD_DEBUG = "nodcc"; # Fixes rendering bugs on some games

    VDPAU_DRIVER = "amdgpu";
  };

  environment.systemPackages = with pkgs; [
    linux-firmware # Binary firmware collection packaged by kernel.org

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
    xivlauncher # Custom launcher for FFXIV
    zenstates # Linux utility for Ryzen processors and motherboards

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
    driversi686Linux.amdvlk # AMD Open Source Driver For Vulkan
    driversi686Linux.mesa # An open source 3D graphics library
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
    mesa # An open source 3D graphics library
    mesa_glu # OpenGL utility library
    mesa_i686 # Open source 3D graphics library
    mesa-demos # Collection of demos and test programs for OpenGL and Mesa
    openal # OpenAL alternative
    # clblast # Tuned OpenCL BLAS library
    # khronos-ocl-icd-loader # Official Khronos OpenCL ICD Loader
    # ocl-icd # OpenCL ICD Loader for opencl-headers-2023.12.14
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
    driversi686Linux.amdvlk # AMD Open Source Driver For Vulkan
    driversi686Linux.mesa # An open source 3D graphics library
    mesa_glu # OpenGL utility library
    mesa_i686 # Open source 3D graphics library
    microcode-amd # AMD Processor microcode patch
    microcodeAmd # AMD Processor microcode patch
    nvtopPackages.amd # (h)top like task monitor for AMD, Adreno, Intel and NVIDIA GPUs
    xorg.xf86videoamdgpu
    amf # AMD's closed source Advanced Media Framework (AMF) driver
    # amd-libflame # LAPACK-compatible linear algebra library optimized for AMD CPUs
  ];
}
