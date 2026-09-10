{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland.settings.windows_rule = [
      {
        match.class = "^(waydroid.*)$";
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
