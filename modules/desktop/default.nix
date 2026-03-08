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
    ./fileManager
    ./hyprland
    ./image_viewer.nix
    ./keyring.nix
    ./noctalia
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
  ];
}
