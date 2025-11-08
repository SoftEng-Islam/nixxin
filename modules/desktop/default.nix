{ settings, lib, pkgs, ... }: {
  imports = lib.optionals (settings.modules.desktop.enable or true) [
    ./dconf.nix
    ./keyring.nix
    ./polkit.nix
    ./ashell
    ./hyprland
    ./file_manager.nix
    ./image_viewer.nix
    ./qt_gtk.nix
    ./screenshot.nix
    ./tools.nix
  ];
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
}
