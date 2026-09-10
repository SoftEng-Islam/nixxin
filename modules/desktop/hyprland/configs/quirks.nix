{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland = {
      settings.config.quirks = {
        prefer_hdr = 2;
      };
    };
  };
}
