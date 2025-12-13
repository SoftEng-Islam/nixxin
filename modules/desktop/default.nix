{ settings, lib, pkgs, ... }: {
  imports = lib.optionals (settings.modules.desktop.enable or true) [
    ./dconf.nix
    ./keyring.nix
    ./polkit.nix
    ./ashell
    ./hyprland
    ./file_manager.nix
    ./image_viewer.nix
    # ./qt_gtk.nix
    ./screenshot.nix
    ./tools.nix
  ];

  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

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

  environment.systemPackages = with pkgs; [ hyprshade quickshell ];
}
