{ settings, pkgs, config, lib, ... }:
# ------------------------------------------------
# !NOTICE: You Must Read And Customize This File
# ------------------------------------------------
# ---- Table Of Content
# -- Boot Configuration
# -- Hardware Configuration
# ------------------------------------------------
let
  _system = settings.modules.system;

  # Optional ACPI table override support.
  #
  # Drop patched ACPI override tables in `modules/system/acpi_override/` and
  # they will be embedded into initrd at
  # `/kernel/firmware/acpi/<file>.aml`, which allows Linux to override buggy BIOS
  # ACPI tables (CONFIG_ACPI_TABLE_UPGRADE=y).
  acpiOverrideDir = ./acpi_override;
  acpiOverrideEntries = if builtins.pathExists acpiOverrideDir then
    builtins.readDir acpiOverrideDir
  else
    { };
  acpiOverrideAmlFiles = builtins.attrNames (lib.filterAttrs (name: type:
    type == "regular" && lib.hasSuffix ".aml" name) acpiOverrideEntries);
  acpiOverrideAslFiles = builtins.attrNames (lib.filterAttrs (name: type:
    type == "regular" && lib.hasSuffix ".asl" name) acpiOverrideEntries);

  acpiOverrideExtraFilesAml = builtins.listToAttrs (map (name: {
    name = "kernel/firmware/acpi/${name}";
    value = {
      source = pkgs.runCommand "acpi-override-${name}" {
        src = acpiOverrideDir + "/${name}";
        preferLocalBuild = true;
      } ''
        cp "$src" "$out"
      '';
    };
  }) acpiOverrideAmlFiles);

  acpiOverrideExtraFilesAsl = builtins.listToAttrs (map (name:
    let amlName = "${lib.removeSuffix ".asl" name}.aml";
    in {
      name = "kernel/firmware/acpi/${amlName}";
      value = {
        source = pkgs.runCommand "acpi-override-${amlName}" {
          src = acpiOverrideDir + "/${name}";
          nativeBuildInputs = [ pkgs.acpica-tools ];
          preferLocalBuild = true;
        } ''
          cp "$src" override.asl
          iasl -tc override.asl >/dev/null
          cp override.aml "$out"
        '';
      };
    }) acpiOverrideAslFiles);

  acpiOverrideExtraFiles = acpiOverrideExtraFilesAml // acpiOverrideExtraFilesAsl;
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
      systemd.enable = false;
      systemd.dbus.enable = false;
      verbose = false;
      # systemd.dbus.enable = false;
      # Additional kernel modules needed for virtualization
      availableKernelModules = [
        # "amdgpu"
        # "acpi"
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

      extraFiles = acpiOverrideExtraFiles;
    };

    kernelModules = _system.boot.kernelModules ++ [
      "amdgpu-i2c"
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
    extraModulePackages = with config.boot.kernelPackages; [
      pkgs.nftables
      amdgpu-i2c
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
      "loglevel=0"
      "systemd.show_status=false"
      "rd.systemd.show_status=false"
      "udev.log_level=0"
      "rd.udev.log_level=0"
      "plymouth.ignore-serial-consoles"

      # Disable Mitigation
      "mitigations=off"
      "split_lock_mitigate=off" # prevents some games from being slowed
      "retbleed=off" # Disable Retbleed mitigation

      "threadirqs"

      # ---- USB Devices ---- #
      # Prevents USB devices (e.g., keyboards, mice, controllers) from disconnecting due to power-saving.
      # Can fix issues where USB devices randomly stop working.
      # "usbcore.autosuspend=-1" # Prevents USB disconnect issues

      # ---- WIFI ---- #
      "rtl8xxxu_disable_hw_crypto=1"

      # ---- Networking ---- #
      # Use legacy network interface names (eth0, wlan0, etc.)
      "net.ifnames=0"

      # ---- Storage ---- #
      # "libata.force=noncq"

      # ---- New memory management parameters ---- #
      # "hugepagesz=2M" # Enable 2MB huge pages
      # "hugepages=2048" # Reserve 4GB for huge pages (2048 * 2MB)
      # "default_hugepagesz=2M" # Set default huge page size
      "transparent_hugepage=always" # Enable transparent huge pages

      # ---- Swap ---- #
      # "zswap.enabled=1"
      # "zswap.compressor=zstd"
      # "zswap.max_pool_percent=20"
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

  services.thermald.enable = true;
  services.thermald.ignoreCpuidCheck = true;

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

    i2c.enable = true;

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

  services.udev.extraRules = ''
    # When the AMD GPU (card1) is added, force it to high performance mode
    ACTION=="add", SUBSYSTEM=="drm", KERNEL=="card1", ATTR{device/power_dpm_force_performance_level}="high"
  '';

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
  # services.xserver.videoDrivers = _system.videoDrivers;

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
}
