{ settings, ... }: {
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland.settings = {
      monitor = [
        # "DP-1, 3440x1440@120, 0x0, 1"
        # "HDMI-A-2,1920x1080@120,3440x100, 1"
        # "HDMI-A-1,3840x2160@120,-300x-2160, 1"
        # "HDMI-A-1,2560x1440@60,-900x-100, 1.6,transform,3"
        # "eDP-1,1920x1080@60,0x0, 1"
        # "eDP-1,2560x1600@120,2560x400, 1.6"
        # "DP-3,3840x2160@60,0x0, 1.5"
        # "HEADLESS-2,1920x1080@60,-1920x100, 1"
        # "HEADLESS-3,1280x800@60,1080x1440, 1"
        # "DVI-I-1, 3840x2160@60, 1920x0, 1"
        # ",preferred,auto,1"
        ",1920x1080@60,auto,1"
      ];
    };
  };
}
