{ settings, ... }: {
  home-manager.users.${settings.users.selected.username} = {
    wayland.windowManager.hyprland = {
      settings.source = [ "~/.cache/ignis/material/dark_colors-hyprland.conf" ];
    };
  };
}
