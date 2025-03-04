{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  # flatpak remote-add --if-not-exists
  # flathub https://dl.flathub.org/repo/flathub.flatpakrepo
in mkIf (settings.modules.flatpak.enable) {
  services.flatpak = {
    enable = true;
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
  };
  environment.systemPackages = with pkgs; [ flatpak ];
}
