{
  inputs,
  settings,
  lib,
  pkgs,
  ...
}:
{
  imports = lib.optionals (settings.modules.desktop.enable or false) [
    ./dconf.nix
    ./file_manager.nix
    ./hyprland
    ./image_viewer.nix
    ./keyring.nix
    ./noctalia/default.nix
    ./polkit.nix
    ./qt_gtk.nix
    ./quickShell
    ./rofi.nix
    ./screenshot.nix
    ./tools.nix
  ];

  programs.appimage = {
    enable = true;
    binfmt = true;
    package = pkgs.appimage-run.override {
      # Extra libraries and packages for Appimage run
      extraPkgs =
        pkgs: with pkgs; [
          ffmpeg
          imagemagick
        ];
    };
  };

  environment.systemPackages = with pkgs; [
    hyprshade

    # Noctalia Shell screenshot plugin need this package
    hyprshot
  ];
}
