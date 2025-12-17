{ settings, lib, pkgs, ... }:
# https://dunst-project.org/
let
  # dunst-toggle-mode = pkgs.writeScriptBin "dunst-toggle-mode"
  #   (builtins.readFile ./scripts/dunst-toggle-mode.sh);
in lib.mkIf (settings.notifications.dunst.enable or false) {
  environment.systemPackages = with pkgs; [
    dunst
    # dunst-toggle-mode
    libnotify
  ];

  # programs.dunst.enable = true;
  home-manager.users."${settings.user.username}" = {
    home.file.".config/dunst/dunstrc".source = ./dunstrc;
  };
}
