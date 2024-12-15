{ pkgs, ... }: {
  # users.users.softeng.extraGroups = [ "libvirtd" ]; exist in users.nix
  networking.firewall.checkReversePath = false;
  virtualisation = {
    podman = {
      enable = false;
      # Enable docker daemon. Rootless docker doesn't properly work
      # with distrobox. Let's use podman for that)
      defaultNetwork.settings.dns_enabled = false;
    };
    docker.enable = false;
    libvirtd.enable = true;
  };
  programs.virt-manager = {
    enable = true;
    package = pkgs.virt-manager;
  };
  environment.systemPackages = with pkgs; [ docker-compose distrobox ];
}
