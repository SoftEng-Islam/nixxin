{ pkgs, ... }: {
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
