{ settings, config, pkgs, ... }:
# ------------------------------------------------
# !NOTICE: You Must Read And Customize This File
# ------------------------------------------------
# ---- Table Of Content
# -- Boot Configuration
# -- Hardware Configuration
# ------------------------------------------------

{

  # ------------------------------------------------
  # ---- Boot Configuration
  # ------------------------------------------------
  boot = {
    kernelPackages = settings.system.kernel;
    # tmp.cleanOnBoot = true;
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
      theme = settings.modules.system.boot.loader.manager.grub.theme;
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
      # Additional kernel modules needed for virtualization
      availableKernelModules = [
        "amdgpu"
        "ahci"
        "cryptd"
        "ehci_pci"
        "ohci_pci"
        "pata_atiixp"
        "sd_mod"
        "usb_storage"
        "usbhid"
        # "vfio_iommu_type1"
        # "vfio_pci"
        # "vfio"
        "xhci_pci"
      ];
    };
    kernelModules = settings.modules.system.boot.kernelModules;
    blacklistedKernelModules =
      settings.modules.system.boot.blacklistedKernelModules ++ [ "k10temp" ];
    extraModulePackages = with config.boot.kernelPackages;
      [
        v4l2loopback
        # zenpower
      ];

    extraModprobeConfig = settings.modules.system.boot.extraModprobeConfig;

    kernelParams = settings.modules.system.boot.kernelParams ++ [
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
      ''acpi_osi="Windows 2020"''
      # "acpi_osi=Linux"
      # "acpi_enforce_resources=lax"

      # "nomodeset" # Black Screen Issues

      "elevator=bfq" # Optimized disk performance for desktops

      # FX CPUs do NOT have P-State.
      # "amd_pstate.shared_mem=1"
      # "amd_pstate=guided" # Enable AMD P-State driver

      "clearcpuid=rdrand"
      "idle=nomwait"
      "mitigations=off"

      # "processor.max_cstate=1" # Limit C-states for better response time
      "threadirqs"

      "scsi_mod.use_blk_mq=1" # Use multi-queue for faster I/O

      # Memory security parameters
      # "slab_nomerge" # Disables merging of slabs of similar sizes
      "vsyscall=none" # Disables legacy system call interface
      # "slub_debug=FZP" # Enables sanity checks (F), redzoning (Z) and poisoning (P).
      # "init_on_free=1" # Fill freed pages and heap objects with zeroes
      # "init_on_alloc=1" # to initialize memory on allocation (complements init_on_free=1).
      "page_alloc.shuffle=1" # Helps detect memory issues earlier + Major security gain

      # New memory management parameters
      # "hugepagesz=2M" # Enable 2MB huge pages
      # "hugepages=2048" # Reserve 4GB for huge pages (2048 * 2MB)
      # "default_hugepagesz=2M" # Set default huge page size
      "transparent_hugepage=madvise" # Enable transparent huge pages

      # "pti=on" # Page Table Isolation for security
      # "page_poison=1"             # Poison freed memory pages (As it conflicts with init_on_free)
      "randomize_kstack_offset=on" # Enhanced kernel stack ASLR

      # ---- Swap ---- #
      #"zswap.enabled=1"
      #"zswap.compressor=zstd"
      #"zswap.max_pool_percent=20"

      # System Performance
      "preempt=voluntary" # or full
      # "clocksource=tsc"
      # "tsc=reliable"

      # Power Management
      "workqueue.power_efficient=off" # General power responsiveness

      # "pcie_aspm=off" # Disables PCIe power saving (better performance)

      # Storage
      # "libata.force=noncq"

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

      #! Swap related { Virtual memory tweaks }
      # "vm.swappiness" = 10; # Use RAM more before swapping
      "vm.swappiness" =
        0; # Change this value as needed (0-100) 0 makes kernel avoid swap as much as possible

      #! Memory management
      # Write data to disk more frequently (prevents slowdowns)
      "vm.dirty_ratio" = 10; # Full writeback at 10%
      "vm.page-cluster" = 3; # Default page clustering (test with 0 if needed)
      "vm.min_free_kbytes" =
        65536; # Reserve 64MB of free memory (adjust as needed)
      "vm.dirty_background_ratio" = 5; # Background writeback at 5%
      "vm.compaction_proactiveness" =
        0; # Default memory compaction (change to 1 if fragmentation issues arise)

      # Memory security
      "vm.mmap_rnd_bits" = 32; # Increase ASLR entropy
      "kernel.kptr_restrict" = 2; # Hide kernel pointers
      "kernel.dmesg_restrict" = 1; # Restrict dmesg access
      "vm.mmap_rnd_compat_bits" = 16; # Compatible ASLR entropy

      "vm.vfs_cache_pressure" = 50;
      "vm.max_map_count" = 2147483642;

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

    plymouth = {
      enable = settings.modules.system.boot.plymouth.enable;
      theme = "flame";
      themePackages = with pkgs;
        [
          (adi1090x-plymouth-themes.override {
            selected_themes = [ "flame" ]; # "glow", "flame", "green loader"
          })
        ];
    };

  };

  # ------------------------------------------------
  # ---- Hardware Configuration
  # ------------------------------------------------
  hardware = {
    firmware = with pkgs; [ linux-firmware sof-firmware wireless-regdb ];
    # one of "xz", "zstd", "none", "auto"
    firmwareCompression = "zstd"; # ?

    uinput.enable = true;
    enableAllFirmware = true;
    enableRedistributableFirmware = true;

    cpu.amd.updateMicrocode = true;
    # cpu.amd.sev.enable = true; #?

    amdgpu = {
      initrd.enable = settings.modules.system.amdgpu.initrd;
      opencl.enable = settings.modules.system.amdgpu.opencl;
      legacySupport.enable = settings.modules.system.amdgpu.legacySupport;
      amdvlk = {
        enable = settings.modules.system.amdgpu.amdvlk;
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
        amdvlk # AMD Vulkan driver
        libGL
        libGLU
        libglvnd
        libGLX
        libva
        libva-utils
        libvdpau
        libvdpau-va-gl
        mesa
        mesa-demos # Provides glxinfo, glxgears
        mesa.opencl
        vaapiVdpau
        vdpauinfo
        vulkan-loader
        vulkan-tools
        vulkan-validation-layers
        xorg.libXv
        xorg.libXvMC
        pocl
      ];

      # To enable Vulkan support for 32-bit applications, also add:
      extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
    };

  };

  # ------------------------------------------------
  # ---- Services Configuration
  # ------------------------------------------------
  services.libinput = {
    enable = true;
    # mouse.accelSpeed = "-0.5";
    mouse.accelProfile = "adaptive"; # one of "flat", "adaptive", "custom"
  };

  # The General Purpose Mouse daemon, which enables mouse support in virtual consoles.
  services.gpm.enable = true;

  # ------------------------------------------------
  # ---- AMD Configuration
  # ------------------------------------------------
  # Video Drivers
  services.xserver.videoDrivers = settings.modules.system.videoDrivers;

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

  # Limit Systemd Journal Size
  # https://wiki.archlinux.org/title/Systemd/Journal#Persistent_journals
  # Optional: Move logs to RAM (careful—logs won't persist reboots)
  services.journald.extraConfig = ''
    # Store logs in RAM
    Compress=yes
    Storage=volatile
    SystemMaxUse=100M
    RuntimeMaxUse=50M
    SystemMaxFileSize=50M
  '';

  # ------------------------------------------------
  # ---- Variables
  # ------------------------------------------------
  environment.variables = {
    # HIP_VISIBLE_DEVICES = "0,2";

    # ROC_ENABLE_PRE_VEGA = "1";
    # RUSTICL_ENABLE = "radeonsi"; # "llvmpipe" or "radeonsi"

    # Optimize rendering and disable hardware cursors for Wayland-based compositors.
    WLR_RENDERER_ALLOW_SOFTWARE = "1"; # enable software rendering for wlroots
    # WLR_NO_HARDWARE_CURSORS = "1"; # disable hardware cursors for wlroots

    # This env var forces wgpu to use OpenGL instead of Vulkan
    WGPU_BACKEND = "gl"; # vulkan, metal, dx12, gl
    WGPU_POWER_PREF = "low"; # Prefer integrated GPU

    # Adjusts DRM devices, vsync, and atomic modes.
    # WLR_DRM_DEVICES = "/dev/dri/card1";
    # WLR_DRM_NO_ATOMIC = "1";
    # WLR_VSYNC = "1";

    # GPU_FORCE_64BIT_PTR = "1";
    # GPU_MAX_ALLOC_PERCENT = "100";
    # GPU_MAX_HEAP_SIZE = "50";
    # GPU_MAX_USE_SYNC_OBJECTS = "1";
    # GPU_SINGLE_ALLOC_PERCENT = "50";

    # Improves OpenGL compatibility & speed.
    # MESA_GL_VERSION_OVERRIDE = "4.6";
    # MESA_GLSL_VERSION_OVERRIDE = "460";
    AMD_DEBUG = "nodcc"; # Fixes rendering bugs on some games

    # DISABLE_LAYER_AMD_SWITCHABLE_GRAPHICS_1 = "1";
  };

  environment.memoryAllocator.provider = "libc";
}
