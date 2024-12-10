{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ docker-compose distrobox ];

  # Enable docker daemon. Rootless docker doesn't properly work
  # with distrobox. Let's use podman for that)
  virtualisation.docker.enable = false;
  virtualisation.podman.enable = false;
  virtualisation.podman.defaultNetwork.settings.dns_enabled = false;
}

