{ settings, inputs, pkgs, ... }:

# ${inputs.ashell.defaultPackage.${settings.system.architecture}}/bin/ashell

let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    #!/usr/bin/env bash


    # dconf write /org/gnome/desktop/interface/gtk-theme "'Adwaita'"
    # dconf write /org/gnome/desktop/interface/icon-theme "'Flat-Remix-Red-Dark'"
    # dconf write /org/gnome/desktop/interface/document-font-name "'Noto Sans Medium 11'"
    # dconf write /org/gnome/desktop/interface/font-name "'Noto Sans Medium 11'"
    # dconf write /org/gnome/desktop/interface/monospace-font-name "'Noto Sans Mono Medium 11'"


    # ---- hyprpolkitagent for Hyprland ---- #
    # systemctl --user start hyprpolkitagent
    # ${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent
    # ${pkgs.hyprpolkitagent}/libexec/.hyprpolkitagent-wrapped

    # ---- hyprpolkitagent for Hyprland with uwsm ---- #
    # systemctl --user enable --now hyprpolkitagent.service


    # ---- notification daemon ---- #
    # dunst &

    # ---- Start IGNIS ---- #
    ignis init &

    # ---- Make nautilus Run in Background ---- #
    # nautilus --no-desktop &

    # ---- DBUS ---- #
    # ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

    # ${pkgs.hyprlock}/bin/hyprlock

    # ---- Set Background ---- #
    #${pkgs.swww}/bin/swww init &
    #${pkgs.swww}/bin/swww-daemon --format xrgb &
    # sleep 1
    #${pkgs.swww}/bin/swww img ~/Pictures/evening-sky.png --transition-bezier .43,1.19,1,.4 --transition-fps 30 --transition-type grow --transition-pos 0.925,0.977 --transition-duration 2


    # Core components (authentication, lock screen, notification daemon)
    #${pkgs.gnome-keyring}/bin/gnome-keyring-daemon --start --components=secrets

    # ---- polkit-gnome ---- #
    #${pkgs.polkit_gnome}/polkit-gnome-authentication-agent-1

    # ---- Input Method ---- #
    #${pkgs.fcitx5}/bin/fcitx5

    # ---- Clipboard ---- #
    ${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store
    ${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store

    # ---- Set Cursor ---- #
    hyprctl setcursor ${settings.global.cursor.name} ${
      toString settings.global.cursor.size
    }

    # ---- HyprlandPlugins Fix ---- #3
    # hyprpm reload

    # ---- Apps To Start ---- #
    # telegram-desktop -startintray
  '';
in {
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland.settings = {
      exec-once = "${startupScript}/bin/start";
    };
  };
}
