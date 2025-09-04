{ settings, lib, pkgs, ... }: {
  imports = lib.optionals (settings.modules.desktop.enable or true) [
    ./hyprland
    # ./xdg
    ./file_manager.nix
    ./image_viewer.nix
    ./qt_gtk.nix
    ./screenshot.nix
    ./tools.nix
  ];
  environment.systemPackages = with pkgs; [ bitwarden-cli bitwarden-desktop ];
}
