{ config, pkgs, ... }: {
  # Bootloader Configuration:
  boot = {
    # bootspec.enable = true;
    kernelPackages = pkgs.linuxPackages_latest;
    tmp.cleanOnBoot = true;
    supportedFilesystems = [ "ntfs" "nfs" "btrfs" "ext4" "fat32" ];
    consoleLogLevel = 0;
    loader = {
      timeout = 4;
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = false; # disable to use GRUB instead of systemd-boot
      # Grub boot

      grub = {
        enable = true;
        fontSize = 18;
        # nix path-info -r nixpkgs#sleek-grub-theme
        # theme = "${pkgs.sleek-grub-theme}/grub/themes/sleek";
        efiSupport = true;
        gfxmodeEfi = "1920x1080";
        # List all the devices with their by-id symlinks
        # ls -l /dev/disk/by-id/
        # mirroredBoots = ;
        # device = "nodev";
        # devices = [ "/dev/disk/by-uuid/7FD3-5156" ];
        devices = [ "nodev" ];
        device = "nodev"; # Let GRUB automatically detect EFI
        useOSProber = false;
        extraConfig = ''
          GRUB_DISABLE_OS_PROBER=true
          GRUB_CMDLINE_LINUX="root=UUID=ba8daecb-c5d6-4dc9-bc51-a38b344ca6ed rootflags=subvol=@"
        '';
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
    };
    initrd = {
      verbose = false;
      # systemd.dbus.enable = false;
      kernelModules = [ "amdgpu" "radeon" ];
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "ohci_pci"
        "ehci_pci"
        "usbhid"
        "usb_storage"
        "sd_mod"
        "radeon"
        "cryptd"
        "aes_x86_64"
      ];
    };
    kernelModules = [ "fuse" "kvm-amd" "coretemp" "bfq" "uinput" ]; # "amdgpu"
    blacklistedKernelModules = [ "k10temp" "rtl8812au" "rtl8xxxu" "r8188eu" ];
    extraModulePackages = with config.boot.kernelPackages; [
      rtl8188eus-aircrack
      v4l2loopback
    ];
    # extraModprobeConfig = ''
    #   options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    # '';
    kernelParams = [
      "quiet"
      "splash"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"

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

      # CPU optimizations
      "threadirqs"
      "mitigations=off"
      "idle=nomwait"
      "processor.max_cstate=1"
      "amd_pstate=active"
      "clearcpuid=rdrand"

      # ---- Swap ---- #
      # "zswap.enabled=1"
      # "zswap.compressor=lz4"
      # "zswap.max_pool_percent=20"

      # AMD GPU optimizations
      "amdgpu.ppfeaturemask=0xffffffff"
      "amdgpu.dcfeaturemask=0x8"
      "amdgpu.freesync_video=1"
      "amdgpu.gpu_recovery=1"
      # for Southern Islands (SI i.e. GCN 1) cards
      # "radeon.si_support=0"
      # "amdgpu.si_support=1"
      # for Sea Islands (CIK i.e. GCN 2) cards
      "radeon.cik_support=0"
      "amdgpu.cik_support=1"
      # "amdgpu.dc=1"
      # "amdgpu.dpm=1"

      # "amdgpu.runpm=0"
      # "amdgpu.gttsize=4096"
      # "amdgpu.deep_color=1"
      # "amdgpu.vm_size=8"
      # "amdgpu.exp_hw_support=1"
      # "amdgpu.vm_fragment_size=9"
      # "amdgpu.vm_fault_stop=2"
      # "amdgpu.vm_update_mode=3"
      # "amdgpu.unified_memory=1"
      # "amdgpu.memory_alloc_mode=2"

      # System performance
      "preempt=voluntary"
      "transparent_hugepage=never"
      "clocksource=tsc"
      "tsc=reliable"

      # Power management
      "workqueue.power_efficient=off"
      "amd_iommu=off"
      "pcie_aspm=off"

      # Audio and USB
      # "amdgpu.audio=0"
      # "usbcore.autosuspend=-1"
      # "snd_hda_intel.power_save=0"
      # "snd_hda_intel.probe_mask=1"
    ];

    kernel.sysctl = {
      # Virtual memory tweaks
      "vm.swappiness" = 10;
      "vm.dirty_ratio" = 60;
      "vm.dirty_background_ratio" = 2;
      "vm.vfs_cache_pressure" = 50;
      "vm.max_map_count" = 262144;

      # Kernel scheduler
      "kernel.sched_autogroup_enabled" = 0;
      "kernel.sched_child_runs_first" = 1;
      "kernel.sched_min_granularity_ns" = 10000000;
      "kernel.sched_wakeup_granularity_ns" = 15000000;

      # File system tweaks
      "fs.file-max" = 2097152;
      "fs.inotify.max_user_watches" = 524288;

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
  environment.systemPackages = with pkgs; [
    fatcat
    os-prober
    grub2_efi
    grub2_full
    sleek-grub-theme
    nixos-grub2-theme
  ];
}
