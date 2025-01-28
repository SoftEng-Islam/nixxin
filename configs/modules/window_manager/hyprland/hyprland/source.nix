{ settings, ... }: {
  home-manager.users.${settings.users.user1.username} = {
    wayland.windowManager.hyprland = {
      settings.source = [ "~/.cache/ignis/material/dark_colors-hyprland.conf" ];
    };
  };
}
