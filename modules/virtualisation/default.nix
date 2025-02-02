{ settings, pkgs, ... }: {
  virtualisation = {
    waydroid.enable = true; # waydroid to run android apps
    spiceUSBRedirection.enable = true; # for virt-manager usb forwarding
    libvirtd = {
      enable = false; # for qemu/kvm VMs in virt-manager
      allowedBridges = [ "nm-bridge" "virbr0" ];
      qemu.runAsRoot = false;
    };
  };
  environment = {
    systemPackages = with pkgs; [
      #for virtualisation virt-manager
      virtiofsd
      virt-manager
      # distrobox
    ];
  };
}
