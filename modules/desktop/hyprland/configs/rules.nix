{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland.settings.config.windows_rule = [
      {
        match.class = "^(waydroid.*)$";
        fullscreen = true;
        no_blur = true;
      }
      {
        match.title = "^(Waydroid)$";
        fullscreen = true;
        no_blur = true;
      }
      {
        match.class = "mpv$";
        idle_inhibit = "focus";
      }
    ];
  };
}
