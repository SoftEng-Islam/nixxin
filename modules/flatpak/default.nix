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
    remotes = {
      "flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      "launcher-moe" = "https://gol.launcher.moe/gol.launcher.moe.flatpakrepo";
    };
    # packages = [ ];
  };
  environment.systemPackages = with pkgs; [ flatpak ];
}
