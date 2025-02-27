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
    # a daemon that manages containers. Users in the “lxd” group can interact with the daemon (e.g. to start or stop containers) using the lxc command line tool, among others.
    lxd.enable = false;
    # a daemon that manages containers. Users in the “lxd” group can interact with the daemon (e.g. to start or stop containers) using the lxc command line tool, among others.
    lxc.enable = true;
    # lxc.lxcfs.enable = true;
    lxc.unprivilegedContainers = true;
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
