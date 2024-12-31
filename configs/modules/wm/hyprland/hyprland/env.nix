{ config, pkgs, settings, ... }: {
  wayland.windowManager.hyprland.settings = {
    env = [
      "HYPRCURSOR_SIZE,32"
      "HYPRCURSOR_THEME,${settings.cursorTheme}"
      "MOZ_ENABLE_WAYLAND,1"
      "QT_AUTO_SCREEN_SCALE_FACTOR,1"
      "QT_QPA_PLATFORM,wayland"
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "XDG_CURRENT_DESKTOP,Hyprland"
      "XDG_SESSION_DEKSTOP,Hyprland"
      "XDG_SESSION_TYPE,wayland"
    ];
  };
}
