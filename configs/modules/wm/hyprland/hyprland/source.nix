{ settings, ... }: {
  home-manager.users.${settings.username} = {
    wayland.windowManager.hyprland = {
      settings.source = [
        # "~/.cache/ignis/material/dark_colors-hyprland.conf"
      ];
    };
  };
}
