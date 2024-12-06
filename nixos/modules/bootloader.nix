{ pkgs, ... }: {
  # Bootloader Configuration:
  boot = {
    tmp.cleanOnBoot = true;
    supportedFilesystems = [ "ntfs" ];
    initrd.kernelModules = [ "amdgpu" ];

    loader = {
      timeout = 4;
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true; # disable to use GRUB instead of systemd-boot
      # Grub boot

      grub = {
        enable = false;
        efiSupport = true;
        gfxmodeEfi = "1920x1080";

        # List all the devices with their by-id symlinks
        # ls -l /dev/disk/by-id/
        device = "/dev/disk/by-uuid/7FD3-5156";
        useOSProber = true;
        extraConfig = ''
          GRUB_DISABLE_OS_PROBER=false
        '';
      };
    };
    kernelParams = [
      "quiet"
      "splash"
      "loglevel=3"

      # for Southern Islands (SI i.e. GCN 1) cards
      # "radeon.si_support=1"
      # "amdgpu.si_support=0"

      # for Sea Islands (CIK i.e. GCN 2) cards
      # "radeon.cik_support=1"
      # "amdgpu.cik_support=0"
      # "amdgpu.dc=1"
      # "amdgpu.dpm=1"
      # "amdgpu.gpu_recovery=1"
      # "amdgpu.runpm=0"
      # "amdgpu.gttsize=4096"
      # "amdgpu.ppfeaturemask=0xffffffff"
      "amdgpu.deep_color=1"
      # "amdgpu.vm_size=8"
      # "amdgpu.exp_hw_support=1"
      # "amdgpu.vm_fragment_size=9"
      # "amdgpu.vm_fault_stop=2"
      # "amdgpu.vm_update_mode=3"
      "drm.kms_helper.parallel_locks=1"
      "rtl8xxxu_disable_hw_crypto=1"
      "acpi_enforce_resources=lax"
      "iommu=pt"
      # "nopat"
      "mitigations=off"
      "pcie_aspm=force"
      "acpi_osi=Linux"
      "pci=realloc"
      # "amdgpu.unified_memory=1"
      # "amdgpu.memory_alloc_mode=2"
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
    plymouth.theme = "bgrt";
  };
  environment.systemPackages = with pkgs; [ os-prober grub2_efi grub2_full ];
}
