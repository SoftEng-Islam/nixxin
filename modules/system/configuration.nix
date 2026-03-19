{
  settings,
  pkgs,
  config,
  inputs,
  lib,
  ...
}:
# ------------------------------------------------
# !NOTICE: You Must Read And Customize This File
# ------------------------------------------------
# ---- Table Of Content
# -- Boot Configuration
# -- Hardware Configuration
# ------------------------------------------------
let
  _system = settings.modules.system;
  quietBoot = _system.boot.quietBoot or true;
  # 1. Override the base kernel derivation (notice it's NOT 'linuxPackages-...')
  # We start with your desired LTO/v2 base and just change the scheduler.
  customKernel = pkgs.cachyosKernels.linux-cachyos-latest-lto-x86_64-v2.override {
    cpusched = "bore"; # Excellent for desktop snappiness
    hzTicks = "1000"; # 1000Hz (default) is best for low-latency desktop feel
    performanceGovernor = true; # Forces the CPU to stay at its higher clock speeds
    bbr3 = true; # Improved network congestion control (better web/gaming)
    hugepage = "always"; # Can speed up memory-heavy apps (like browsers/compiling)
    preemptType = "full"; # "full" is the most responsive for desktop usage
    tickrate = "full"; # Maintains high responsiveness even under load
    # acpiCall = true;
  };

  # 2. Load the helper functions from the nix-cachyos-kernel flake
  helpers = pkgs.callPackage "${inputs.nix-cachyos-kernel.outPath}/helpers.nix" { };

  # 3. Generate the kernel package set and apply the LTO compiler fixes
  customKernelPackages = helpers.kernelModuleLLVMOverride (pkgs.linuxKernel.packagesFor customKernel);
in
{

  # ------------------------------------------------
  # ---- Boot Configuration
  # ------------------------------------------------
  boot = {
    kernelPackages = customKernelPackages;
    # tmp.cleanOnBoot = true;
    supportedFilesystems = [
      "btrfs"
      "ext4"
      "fat32"
      "vfat"
      "xfs"
      # "nfs"
      "ntfs"
    ];
    consoleLogLevel = if quietBoot then 0 else 7;

    # Boot Time out in seconds
    loader.timeout = _system.boot.loader.timeout;

    # Whether the installation process is allowed to modify EFI boot variables.
    loader.efi.canTouchEfiVariables = true;

    # Make Memtest86+ available from the systemd-boot menu. Memtest86+ is a program for testing memory.
    loader.systemd-boot.memtest86.enable = false;

    # NOTE!! disable to use GRUB instead of systemd-boot
    loader.systemd-boot.enable =
      if (_system.boot.loader.manager.name == "SYSTEMD") then true else false;

    bootspec.enable = if (_system.boot.loader.manager.name == "SYSTEMD") then true else false;

    loader.grub = {
      enable = if (_system.boot.loader.manager.name == "GRUB") then true else false;

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

      enableCryptodisk = lib.mkDefault false;
      backgroundColor = "#000000"; # null or string: "#000000"
      splashImage = null;
    };

    initrd = {
      systemd.enable = false;
      systemd.dbus.enable = false;
      verbose = !quietBoot;

      prepend = [ "${./dsdt.cpio}" ];

      # systemd.dbus.enable = false;
      # Additional kernel modules needed for virtualization
      availableKernelModules = [
        "amdgpu"
        "ahci"
        "cryptd"
        "sd_mod"
        "usb_storage"
        "xhci_pci"
        "ehci_pci"
        "ohci_pci"
        "pata_atiixp"
        "usbhid"
      ];
      # kernelModules = [ "amdgpu" ];
    };

    kernelModules = _system.boot.kernelModules ++ [ ];
    blacklistedKernelModules = _system.boot.blacklistedKernelModules ++ [
      # "k10temp"
    ];

    extraModprobeConfig = _system.boot.extraModprobeConfig;
    kernelParams =
      _system.boot.kernelParams
      ++ [
        # Disable various mitigations (l1tf=off, retbleed=off, noibpb, nopti
        # are all redundant when mitigations=off is set)
        "mitigations=off"

        # ---- Networking ---- #
        # Use legacy network interface names (eth0, wlan0, etc.)
        "net.ifnames=0"
      ]
      ++ lib.optionals quietBoot [
        #---- Reduce Boot Delay ---- #
        # tell the kernel to not be verbose
        "quiet"
        # kernel log message level
        "loglevel=0" # 1: sustem is unusable | 3: error condition | 7: very verbose
        "splash"
        # rd.systemd.show_status is set to "auto" below, don't duplicate with "false"
        "udev.log_level=0"
        "plymouth.ignore-serial-consoles"

        # disable systemd status messages
        # rd prefix means systemd-udev will be used instead of initrd
        "systemd.show_status=false"
        "rd.systemd.show_status=auto"
        "rd.udev.log_level=0"
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

    # Note: Rust kernel support and custom kernel patches are handled
    # conditionally in kernelPatches.nix to avoid conflicts with
    # pre-patched kernels like cachyos.
    # kernelPatches = [];

    plymouth = {
      enable = _system.boot.plymouth.enable;
      theme = "flame";
      themePackages = with pkgs; [
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
    firmware = with pkgs; [
      linux-firmware
      sof-firmware
      wireless-regdb
    ];
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
  };

  # Speed up boot / shut down
  systemd.services.systemd-udev-settle.enable = false;

  services.udev.extraRules = ''
    # When the AMD GPU (card1) is added, force it to high performance mode
    ACTION=="add", SUBSYSTEM=="drm", KERNEL=="card1", ATTR{device/power_dpm_force_performance_level}="high"
  '';

  # ------------------------------------------------
  # ---- Services Configuration
  # ------------------------------------------------
  services.libinput = {
    enable = true;
    mouse.accelSpeed = builtins.toString settings.common.mouse.sensitivity; # Slow down mouse
    mouse.accelProfile = "${settings.common.mouse.accelProfile}"; # flat profile is more predictable for fast mice
  };

  # The General Purpose Mouse daemon, which enables mouse support in virtual consoles.
  services.gpm.enable = true;

  # ------------------------------------------------
  # ---- AMD Configuration
  # ------------------------------------------------
  # Video Drivers
  # services.xserver.videoDrivers = _system.videoDrivers;

  # ------------------------------------------------
  # ---- Kernel Thread Scheduler Optimization
  # ------------------------------------------------
  # https://github.com/sched-ext/scx
  # https://wiki.cachyos.org/configuration/sched-ext/
  # Use the newest kernel thread scheduler.
  # better fps in games
  services.scx = {
    enable = true;
    package = pkgs.scx.full;
    extraArgs = [
      "--performance"
    ];
    scheduler = "scx_lavd";
  };

  # Limit Systemd Journal Size
  # https://wiki.archlinux.org/title/Systemd/Journal#Persistent_journals
  # Optional: Move logs to RAM (careful—logs won't persist reboots)
  services.journald.extraConfig = ''
    # Store Logs in RAM
    Compress=yes
    Storage=volatile
    SystemMaxUse=100M
    RuntimeMaxUse=50M
    SystemMaxFileSize=50M
    MaxRetentionSec=1day
  '';
}
