{ settings, inputs, pkgs, ... }:
let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    #!/usr/bin/env bash

    # dconf write /org/gnome/desktop/interface/gtk-theme "'Adwaita'"
    # dconf write /org/gnome/desktop/interface/icon-theme "'Flat-Remix-Red-Dark'"
    # dconf write /org/gnome/desktop/interface/document-font-name "'Noto Sans Medium 11'"
    # dconf write /org/gnome/desktop/interface/font-name "'Noto Sans Medium 11'"
    # dconf write /org/gnome/desktop/interface/monospace-font-name "'Noto Sans Mono Medium 11'"

    gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark
    gsettings set org.gnome.desktop.interface color-scheme prefer-dark
    gsettings set org.gnome.desktop.interface cursor-theme Bibata-Modern-Classic
    gsettings set org.gnome.desktop.interface icon-theme Papirus-Dark
    gsettings set org.gnome.desktop.interface font-name "CaskaydiaCove Nerd Font 10"

    # ---- hyprpolkitagent for Hyprland ---- #
    systemctl --user start hyprpolkitagent
    # ${
      inputs.hyprpolkitagent.packages.${pkgs.system}.hyprpolkitagent
    }/libexec/hyprpolkitagent"
    # ${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent
    # ${pkgs.hyprpolkitagent}/libexec/.hyprpolkitagent-wrapped

    # ---- hyprpolkitagent for Hyprland with uwsm ---- #
    # systemctl --user enable --now hyprpolkitagent.service

    # Core components (authentication, lock screen, notification daemon)
    ${pkgs.gnome-keyring}/bin/gnome-keyring-daemon --start --components=secrets

    # ---- polkit-gnome ---- #
    #${pkgs.polkit_gnome}/polkit-gnome-authentication-agent-1


    # ---- notification daemon ---- #
    # dunst &

    # ---- Start IGNIS ---- #
    ignis init &

    # ---- Make nautilus Run in Background ---- #
    # nautilus --no-desktop &

    # ---- DBUS ---- #
    # ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

    # ---- hyprlock ---- #
    # ${pkgs.hyprlock}/bin/hyprlock

    # ---- SWWW & Set Image as Background ---- #
    ${pkgs.swww}/bin/swww-daemon --no-cache --format xrgb &
    # sleep 1
    ${pkgs.swww}/bin/swww img ~/Pictures/Wallpapers/Study-table.png --transition-bezier .43,1.19,1,.4 --transition-fps 30 --transition-type grow --transition-pos 0.925,0.977 --transition-duration 2

    # ---- Input Method ---- #
    #${pkgs.fcitx5}/bin/fcitx5

    # ---- Clipboard ---- #
    ${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store
    ${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store

    # ---- Set Cursor ---- #
    hyprctl setcursor ${settings.common.cursor.name} ${
      toString settings.common.cursor.size
    }

    # ---- Hyprland Fix ---- #3
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
