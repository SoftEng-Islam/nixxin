{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.virtualization.enable) {
  # ----------------------------------------------
  # ---- virtualisation
  # ----------------------------------------------
  virtualisation = {
    spiceUSBRedirection.enable = true; # for virt-manager usb forwarding
    libvirtd = {
      enable = true; # for qemu/kvm VMs in virt-manager
      allowedBridges = [ "nm-bridge" "virbr0" ];
      qemu.runAsRoot = true;
    };
  };

  programs.virt-manager.enable = true;

  # ----------------------------------------------
  # ---- System Packages
  # ----------------------------------------------
  environment.systemPackages = with pkgs; [
    #for virtualisation virt-manager
    # virtiofsd
    virt-manager
    # distrobox
    kvmtool

  ];
}
