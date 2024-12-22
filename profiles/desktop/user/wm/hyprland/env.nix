{ ... }: {
  wayland.windowManager.hyprland.settings = {
    env = [
      "XDG_CURRENT_DESKTOP,Hyprland"
      "XDG_SESSION_DEKSTOP,Hyprland"
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
    ];
  };
}
