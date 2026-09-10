{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland = {
      settings.quirks = {
        prefer_hdr = 2;
      };
    };
  };
}
