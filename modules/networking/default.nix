{ pkgs, ... }: {
  imports = [ ./networking.nix ./dnsmasq.nix ];
  # environment.systemPackages = with pkgs; [ ];
}
