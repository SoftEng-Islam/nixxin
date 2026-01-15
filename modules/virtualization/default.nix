{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.virtualization.enable or false) {
  # ----------------------------------------------
  # ---- virtualisation
  # ----------------------------------------------
  virtualisation = {
    spiceUSBRedirection.enable = false; # for virt-manager usb forwarding
    libvirtd = {
      enable = true; # for qemu/kvm VMs in virt-manager
      allowedBridges = [ "nm-bridge" "virbr0" ];
      qemu.runAsRoot = true;
    };
  };

  programs.virt-manager.enable = false;

  # ----------------------------------------------
  # ---- System Packages
  # ----------------------------------------------
  environment.systemPackages = with pkgs;
    [
      # For virtualisation virt-manager
      # virtiofsd # vhost-user virtio-fs device backend written in Rust
      # virt-manager # Desktop user interface for managing virtual machines
      # distrobox # Wrapper around podman or docker to create and start containers
      # kvmtool # Lightweight tool for hosting KVM guests
    ];
}
