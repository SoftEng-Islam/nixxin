{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland.settings = {
      monitor = [
        "HDMI-A-1,2560x1440@144,0x0,1"
        "DP-1,1920x1080@60,2560x0,1"
      ];
    };
  };
}
