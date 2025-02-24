# https://wiki.gnome.org/Apps/Geary
{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.emails.client.geary) {
  environment.systemPackages = with pkgs; [ geary ];
}
