{ settings, pkgs, ... }: {
  # Bootloader Configuration:
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    tmp.cleanOnBoot = true;
    supportedFilesystems = [ "ntfs" ];
    initrd.kernelModules = [ "amdgpu" ];

    loader = {
      timeout = 4;
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = false; # disable to use GRUB instead of systemd-boot
      # Grub boot

      grub = {
        enable = true;
        fontSize = settings.fontSize;
        # nix path-info -r nixpkgs#sleek-grub-theme
        theme = "${pkgs.sleek-grub-theme}/grub/themes/sleek";
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

        #   menuentry 'Windows Boot Manager (on /dev/sda1)' --class windows --class os $menuentry_id_option 'osprober-efi-B091-959B' {
        #   	insmod part_gpt
        #   	insmod fat
        #   	set root='hd0,gpt1'
        #   	if [ x$feature_platform_search_hint = xy ]; then
        #   	  search --no-floppy --fs-uuid --set=root --hint-bios=hd0,gpt1 --hint-efi=hd0,gpt1 --hint-baremetal=ahci0,gpt1  B091-959B
        #   	else
        #   	  search --no-floppy --fs-uuid --set=root B091-959B
        #   	fi
        #   	chainloader /EFI/Microsoft/Boot/bootmgfw.efi
        #   }
        # '';
      };
    };
    kernelParams = [
      "quiet"
      "splash"
      "loglevel=3"

      # for Southern Islands (SI i.e. GCN 1) cards
      "radeon.si_support=0"
      "amdgpu.si_support=1"

      # for Sea Islands (CIK i.e. GCN 2) cards
      "radeon.cik_support=0"
      "amdgpu.cik_support=1"

      "amdgpu.dc=1"
      "amdgpu.dpm=1"
      "amdgpu.gpu_recovery=1"
      "amdgpu.runpm=0"
      "amdgpu.gttsize=4096"
      "amdgpu.ppfeaturemask=0xffffffff"
      "amdgpu.deep_color=1"
      "amdgpu.vm_size=8"
      "amdgpu.exp_hw_support=1"
      "amdgpu.vm_fragment_size=9"
      "amdgpu.vm_fault_stop=2"
      "amdgpu.vm_update_mode=3"
      "amdgpu.unified_memory=1"
      "amdgpu.memory_alloc_mode=2"

      # Performance
      "mitigations=off"
      "zswap.enabled=1"
      "zswap.compressor=lz4"
      "zswap.max_pool_percent=20"

      "rtl8xxxu_disable_hw_crypto=1"
      "iommu=pt"
      "drm.kms_helper.parallel_locks=1"
      "acpi_enforce_resources=lax"
      "pcie_aspm=force"
      "acpi_osi=Linux"
      "pci=realloc"
    ];
    kernel.sysctl = {
      "net.ipv4.ip_forward" = true; # Enable IPv4 forwarding
      "net.ipv6.conf.all.forwarding" = true; # Enable IPv6 forwarding
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.core.default_qdisc" = "fq";
      "vm.swappiness" = 60;
      "net.core.rmem_max" = 16777216;
      "net.core.wmem_max" = 16777216;
    };
    # extraModprobeConfig = ''
    # blacklist r8188eu
    # blacklist rtl8xxxu
    # '';

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
