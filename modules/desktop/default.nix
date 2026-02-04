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
  ];

  programs.appimage = {
    enable = true;
    binfmt = true;
    package = pkgs.appimage-run.override {
      # Extra libraries and packages for Appimage run
      extraPkgs = pkgs: with pkgs; [ ffmpeg imagemagick ];
    };
  };

  services.flatpak.enable = true;

  home-manager.users.${settings.user.username} = {
    xdg.configFile = {
      # "hypr/hyprshade.toml".text = ''
      #   [[shades]]
      #   name = "blue-light-filter"
      #   start_time = 19:00:00
      #   end_time = 06:00:00
      # '';

      # Copied from: https://github.com/TheRiceCold/dots/blob/d25001db1529195174b214fe61e507522ea2195d/home/wolly/kaizen/desktop/wayland/hyprland/ecosystem/hyprshade.nix#L35C4-L50C8
      # "hypr/shaders/grayscale.glsl".text = '''';

      # Edited from: https://github.com/loqusion/hyprshade/blob/main/shaders/blue-light-filter.glsl.mustache
      # "hypr/shaders/blue-light-filter.glsl.mustache".text = '''';
    };
  };

  environment.systemPackages = with pkgs; [
    # Run this to add the flathub repo
    # flatpak --user remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    bazaar
    flatpak
    gnome-software
    hyprshade
  ];
}
