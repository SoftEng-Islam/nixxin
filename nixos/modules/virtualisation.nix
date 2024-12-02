{ pkgs, ... }:
{
  virtualisation = {
    podman.enable = false;
    docker.enable = false;
    libvirtd.enable = false;
  };
  programs.virt-manager = {
    enable = false;
    package = pkgs.virt-manager;
  };
}
