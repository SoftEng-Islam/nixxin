{ settings, pkgs, ... }: {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "swww-daemon &"
      # "swww init"
      # "swww img ~/Downloads/nixos-chan.png"

      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"

      #"ags &"
      "ignis init"

      "${pkgs.polkit_gnome}/polkit-gnome-authentication-agent-1"
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "hyprctl setcursor ${settings.cursorTheme}  ${
        toString settings.cursorSize
      }"

      "~/.config/eww/scripts/start.sh"
      # exec-once = /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
      # exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      # exec-once = telegram-desktop -startintray

    ];
  };
}
