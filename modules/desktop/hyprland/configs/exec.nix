{ settings, inputs, pkgs, ... }:
let
  fontName = "${settings.modules.fonts.main.name} ${
      toString settings.modules.fonts.main.size.main
    }";
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    #!/usr/bin/env bash
    # ---- DBUS ---- #
    systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP PATH
    ${pkgs.hyprshade}/bin/hyprshade toggle ~/.config/hypr/shaders/blue-light-filter.glsl & disown

    # Core components (authentication, lock screen, notification daemon)
    ${pkgs.gnome-keyring}/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh & disown

    # ---- Clipboard ---- #
    ${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store  & disown
    ${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store & disown

    # ---- Set Cursor ---- #
    hyprctl setcursor ${settings.common.cursor.name} ${
      toString settings.common.cursor.size
    } & disown

    # ---- Set Desktop Wallpaper ---- #
    changeWallpaper & disown
    sleep 1

    # ---- Start Ashell a status bar ---- #
    ${pkgs.ashell}/bin/ashell & disown
    sleep 1

    # ---- Notification daemon ---- #
    swaync & disown
    sleep 1

    # ---- Apps To Start ---- #
    # Telegram -startintray & disown

    Auto-start the overview (add to Hyprland config):
    qs -c overview & disown
  '';
in {
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland.settings = {
      exec-once = "${startupScript}/bin/start";
    };
  };
}
