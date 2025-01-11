{ settings, pkgs, ... }: {
  home-manager.users.${settings.username} = {
    wayland.windowManager.hyprland.settings = {
      exec-once = [
        "swww-daemon --format xrgb &"
        "ignis init"
        # "swww init"
        # "swww-daemon"
        # "swww img ~/Downloads/nixos-chan.png"

        # Input method
        # "fcitx5"

        # Core components (authentication, lock screen, notification daemon)
        "gnome-keyring-daemon --start --components=secrets"

        # polkit-gnome on nixos
        "${pkgs.polkit_gnome}/polkit-gnome-authentication-agent-1 &"

        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        # "dbus-update-activation-environment --all"
        # "sleep 1 && dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP" # Some fix idk

        "hyprpm reload"

        # "hypridle"

        # Clipboard: history
        "clipman store &"
        "wl-paste --watch cliphist store &"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"

        # Cursor
        "hyprctl setcursor ${settings.cursorTheme}  ${
          toString settings.cursorSize
        }"
        # Apps To Start
        # "telegram-desktop -startintray"
      ];
    };
  };
}
