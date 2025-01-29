{ settings, pkgs, ... }: {
  home-manager.users.${settings.users.selected.username} = {
    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = true;
        splash = false;
        preload = "$HOME/.config/wall.png";
        wallpaper = ",$HOME/.config/wall.png";
      };
    };
  };
}
