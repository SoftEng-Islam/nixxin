{ settings, pkgs, ... }:
let HOME = settings.HOME;
in {
  home-manager.users.${settings.user.username} = {
    services.hyprpaper = {
      enable = false;
      settings = {
        ipc = true;
        splash = false;
        preload = "${HOME}/.config/wall.png";
        wallpaper = "${HOME}/.config/wall.png";
      };
    };
  };
  environment.systemPackages = with pkgs;
    [
      # Blazing fast wayland wallpaper utility
      hyprpaper
    ];
}
