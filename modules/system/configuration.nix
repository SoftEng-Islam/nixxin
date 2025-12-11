{ settings, config, pkgs, ... }:
# ------------------------------------------------
# !NOTICE: You Must Read And Customize This File
# ------------------------------------------------
# ---- Table Of Content
# -- Boot Configuration
# -- Hardware Configuration
# ------------------------------------------------
let _system = settings.modules.system;
in {

  # ------------------------------------------------
  # ---- Boot Configuration
  # ------------------------------------------------
  boot = {
    kernelPackages = settings.system.kernel;
    # tmp.cleanOnBoot = true;
    supportedFilesystems = [
      "btrfs"
      "ext4"
      "fat32"
      # "nfs"
      "ntfs"
    ];
    consoleLogLevel = 0;

    # Boot Time out in seconds
    loader.timeout = _system.boot.loader.timeout;

    # Whether the installation process is allowed to modify EFI boot variables.
    loader.efi.canTouchEfiVariables = true;

    # Make Memtest86+ available from the systemd-boot menu. Memtest86+ is a program for testing memory.
    loader.systemd-boot.memtest86.enable = false;

    # NOTE!! disable to use GRUB instead of systemd-boot
    loader.systemd-boot.enable =
      if (_system.boot.loader.manager.name == "SYSTEMD") then true else false;

    bootspec.enable =
      if (_system.boot.loader.manager.name == "SYSTEMD") then true else false;

    loader.grub = {
      enable =
        if (_system.boot.loader.manager.name == "GRUB") then true else false;

      fontSize = _system.boot.loader.manager.grub.fontSize;
      # theme = settings.boot.loader.manager.grub.theme;
      efiSupport = _system.boot.loader.manager.grub.efiSupport;
      gfxmodeEfi = _system.boot.loader.manager.grub.gfxmodeEfi;
      devices = _system.boot.loader.manager.grub.devices;

      device = _system.boot.loader.manager.grub.device;
      useOSProber = _system.boot.loader.manager.grub.osProber;
      theme = _system.boot.loader.manager.grub.theme;
      # Make Memtest86+, a memory testing program, available from the GRUB boot menu.
      memtest86.enable = false;
      extraConfig = _system.boot.loader.manager.grub.extraConfig;
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
        "xhci_pci"
      ];
    };
    kernelModules = _system.boot.kernelModules ++ [
      "acpi_cpufreq"
      # "ip_tables"
      # "iptable_filter"
      # "iptable_nat"
      # "nf_nat"
      # "nf_conntrack"
      # "x_tables"
      # "xt_conntrack"
      # "xt_MASQUERADE"
    ];
    blacklistedKernelModules = _system.boot.blacklistedKernelModules
      ++ [ "k10temp" ];
    extraModulePackages = [
      pkgs.nftables
      # pkgs.iptables-legacy
      # config.hardware.nvidia.package
      # config.boot.kernelPackages.v4l2loopback
      # pkgs.snd-hda-codec-realtek
      # pkgs.hp-wmi-fan-control
    ];
    extraModprobeConfig = _system.boot.extraModprobeConfig;
    kernelParams = _system.boot.kernelParams ++ [
      # Reduce Boot Delay
      "quiet"
      "splash"
      "loglevel=3"
      "udev.log_level=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "ibt=off"
      "psi=1"
      "nowatchdog=0"

      # Makes Linux Pretend to be Windows 10/11 (2020 version) when interacting with ACPI.
      # Some BIOS/UEFI implementations contain Windows-specific ACPI tables, so they behave differently depending on the OS.
      # ''acpi_osi="Windows 2020"''
      # "acpi_osi=Linux"
      # "acpi_enforce_resources=lax"

      # "nomodeset" # Black Screen Issues

      "idle=nomwait"
      "mitigations=off"

      # "processor.max_cstate=1" # Limit C-states for better response time

      "threadirqs" # ?

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
      "preempt=full" # voluntary or full
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

      # WIFI
      "rtl8xxxu_disable_hw_crypto=1"
    ];

    kernel.sysctl = {
      # Runtime parameters of the Linux Kernel to enhance gaming performance and to help future-proof.
      "kernel.sched_cfs_bandwidth_slice_us" = 3000;

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
      enable = _system.boot.plymouth.enable;
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

    # What is the cpu.amd.sev.enable?
    # AMD Secure Encrypted Virtualization (SEV) is a technology that allows virtual machines
    # to run with encrypted memory, providing an additional layer of security.
    # It is typically used in server environments to protect sensitive data in virtual machines.
    # It is not commonly used on desktop systems, and enabling it may not be necessary unless
    # you have specific security requirements or are running virtual machines that benefit from it.
    cpu.amd.sev.enable = false;

    amdgpu = {
      initrd.enable = _system.amdgpu.initrd;
      opencl.enable = _system.amdgpu.opencl;
      legacySupport.enable = _system.amdgpu.legacySupport;
    };

    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        vulkan-memory-allocator
        vulkan-extension-layer
        vulkan-loader
        vulkan-tools
        vulkan-validation-layers
        mesa
        mesa-demos # Provides glxinfo, glxgears
        mesa.opencl
        libclc
        libGL
        libGLU
        libglvnd
        libGLX
        libvdpau
        libva
        libva-utils
        libva-vdpau-driver
        vdpauinfo
        xorg.libXv
        xorg.libXvMC
        pocl
      ];
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
  services.xserver.videoDrivers = _system.videoDrivers;

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
    # Optimize rendering and disable hardware cursors for Wayland-based compositors.
    WLR_RENDERER_ALLOW_SOFTWARE = "1"; # enable software rendering for wlroots
    WLR_NO_HARDWARE_CURSORS = "0"; # disable hardware cursors for wlroots

    # This env var forces wgpu to use OpenGL instead of Vulkan
    WGPU_BACKEND = "vulkan"; # vulkan, metal, dx12, gl
    WGPU_POWER_PREF = "high"; # Prefer integrated GPU

    AMD_DEBUG = "nodcc"; # Fixes rendering bugs on some games
  };
}
