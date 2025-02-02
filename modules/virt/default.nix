{ settings, pkgs, ... }: {
  virtualisation = {
    waydroid.enable = true; # waydroid to run android apps
    libvirtd.enable = true; # for qemu/kvm VMs in virt-manager
    spiceUSBRedirection.enable = true; # for virt-manager usb forwarding
  };
  environment = {
    systemPackages = with pkgs;
      [
        #for virtualisation virt-manager
        virtiofsd
      ];
  };
}
