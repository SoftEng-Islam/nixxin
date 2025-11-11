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

  home-manager.users.${settings.user.username} = {
    xdg.configFile = {
      # "hypr/hyprshade.toml".text = ''
      #   [[shades]]
      #   name = "blue-light-filter"
      #   start_time = 19:00:00
      #   end_time = 06:00:00
      # '';

    };
  };

  environment.systemPackages = with pkgs; [ hyprshade ];
}
