{ inputs, settings, lib, pkgs, ... }: {
  imports = lib.optionals (settings.modules.desktop.enable or false) [

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
    ./quickShell
    ./rofi.nix
    ./noctalia.nix
    # ./flatpak.nix
  ];

  programs.appimage = {
    enable = true;
    binfmt = true;
    package = pkgs.appimage-run.override {
      # Extra libraries and packages for Appimage run
      extraPkgs = pkgs: with pkgs; [ ffmpeg imagemagick ];
    };
  };

  environment.systemPackages = with pkgs; [
    hyprshade

    # Noctalia Shell screenshot plugin need this package
    hyprshot
  ];
}
