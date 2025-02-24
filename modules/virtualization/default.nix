{ settings, lib, pkgs, ... }:

let inherit (lib) mkIf;
in mkIf (settings.modules.virtualization.enable) {
  virtualisation = {
    spiceUSBRedirection.enable = true; # for virt-manager usb forwarding
    libvirtd = {
      enable = false; # for qemu/kvm VMs in virt-manager
      allowedBridges = [ "nm-bridge" "virbr0" ];
      qemu.runAsRoot = false;
    };
  };
  environment = {
    systemPackages = with pkgs;
      [
        #for virtualisation virt-manager
        # virtiofsd
        # virt-manager
        # distrobox
      ];
  };
}
