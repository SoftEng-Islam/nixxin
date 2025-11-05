{ settings, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ tailscale ];
  services.tailscale.enable = false;
}
