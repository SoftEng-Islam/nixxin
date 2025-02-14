{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  imports = [ ./networking.nix ./dnsmasq.nix ];
  # environment.systemPackages = with pkgs; [ ];
}
