{ settings, ... }: {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "swww-daemon &"
      # "swww init"
      # "swww img ~/Downloads/nixos-chan.png"
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"
      #"ags &"
      "ignis init"
      "hyprctl setcursor ${settings.cursorTheme}  ${
        toString settings.cursorSize
      }"
    ];
  };
}
