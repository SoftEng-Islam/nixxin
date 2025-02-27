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
    lxd.enable = true;
    lxc.enable = true;
    # lxc.lxcfs.enable = true;
    lxc.unprivilegedContainers = true;
  };
  systemd.services.lxc = {
    restartIfChanged = false; # Prevent unnecessary restarts during rebuild.
    serviceConfig = {
      Restart = "always";
      RestartSec = "5s"; # Add a 5-second delay before restarting.
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
