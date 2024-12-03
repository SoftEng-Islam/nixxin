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
        enable = true;
        efiSupport = true;
        device =
          "nodev"; # Ensures GRUB installs only to /boot and doesn't overwrite any disk
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
      "radeon.cik_support=0"
      "radeon.si_support=0"
      "amdgpu.si_support=1"
      "amdgpu.cik_support=1"
      "amdgpu.dc=1"
      "amdgpu.dpm=1"
      "amdgpu.gpu_recovery=1"
      "amdgpu.runpm=0"
      "amdgpu.gttsize=4096"
      "amdgpu.ppfeaturemask=0xffffffff"
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
    plymouth.enable = true;
    plymouth.theme = "bgrt";
  };
  environment.systemPackages = with pkgs; [ os-prober grub2_efi grub2_full ];
}
