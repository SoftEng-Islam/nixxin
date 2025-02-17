{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  imports = [ ./networking.nix ./dnsmasq.nix ];
  services.avahi.publish.enable = true;
  services.avahi.publish.userServices = true;
}
