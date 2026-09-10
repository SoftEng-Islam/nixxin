{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland.settings.config.windows_rule = [
      {
        match = {
          class = "waydroid";
        };
        fullscreen = true;
      }
    ];
  };
}
