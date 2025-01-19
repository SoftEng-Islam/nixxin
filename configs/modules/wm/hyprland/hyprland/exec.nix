{ settings, pkgs, ... }:
let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''

    # ---- Set Background ---- #
    ${pkgs.swww}/bin/swww init &
    ${pkgs.swww}/bin/swww-daemon --format xrgb &
    sleep 1
    ${pkgs.swww}/bin/swww img ~/Pictures/nord.jpg --transition-bezier .43,1.19,1,.4 --transition-fps 30 --transition-type grow --transition-pos 0.925,0.977 --transition-duration 2

    # ---- Start IGNIS ---- #
    ignis init

    # ---- Input Method ---- #
    fcitx5

    # Core components (authentication, lock screen, notification daemon)
    gnome-keyring-daemon --start --components=secrets

    # ---- polkit-gnome ---- #
    ${pkgs.polkit_gnome}/polkit-gnome-authentication-agent-1 &

    # ---- DBUS ---- #
    dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

    # ---- Clipboard ---- #
    wl-paste --type text --watch cliphist store
    wl-paste --type image --watch cliphist store

    # ---- Set Cursor ---- #
    hyprctl setcursor ${settings.cursorTheme}  ${toString settings.cursorSize}

    # ---- HyprlandPlugins Fix ---- #3
    # hyprpm reload

    # ---- Apps To Start ---- #
    # telegram-desktop -startintray
  '';
in {
  home-manager.users.${settings.username} = {
    wayland.windowManager.hyprland.settings = {
      exec-once = "${startupScript}/bin/start";
    };
  };
}
