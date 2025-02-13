{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.flatpak.enable) {
  services = { flatpak.enable = false; };
}
