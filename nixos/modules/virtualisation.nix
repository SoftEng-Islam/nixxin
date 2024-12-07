{ pkgs, ... }: {
  # users.users.softeng.extraGroups = [ "libvirtd" ]; exist in users.nix
  networking.firewall.checkReversePath = false;
  virtualisation = {
    podman.enable = false;
    docker.enable = false;
    libvirtd.enable = true;
  };
  programs.virt-manager = {
    enable = true;
    package = pkgs.virt-manager;
  };
}
