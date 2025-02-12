{ settings, ... }: {
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland = {
      settings.source = [ "~/.cache/ignis/material/dark_colors-hyprland.conf" ];
    };
  };
}
