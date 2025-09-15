{ settings, inputs, pkgs, ... }:
let
  fontName = "${settings.modules.fonts.main.name} ${
      toString settings.modules.fonts.main.size.main
    }";
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    #!/usr/bin/env bash

    #* ---- Set `GTK_THEME` Env Variable ---- #
    export GTK_THEME=${settings.common.gtk.GTK_THEME}

    # ---- SWWW & Set Image as Background ---- #
    ${pkgs.swww}/bin/swww-daemon --no-cache --format xrgb &
    sleep 1
    ${pkgs.swww}/bin/swww img ~/Pictures/desktop.png --transition-bezier .43,1.19,1,.4 --transition-fps 30 --transition-type grow --transition-pos 0.925,0.977 --transition-duration 2


    # dconf write /org/gnome/desktop/interface/gtk-theme "'Adwaita'"
    # dconf write /org/gnome/desktop/interface/icon-theme "'Flat-Remix-Red-Dark'"
    # dconf write /org/gnome/desktop/interface/document-font-name "'Noto Sans Medium 11'"
    # dconf write /org/gnome/desktop/interface/font-name "'Noto Sans Medium 11'"
    # dconf write /org/gnome/desktop/interface/monospace-font-name "'Noto Sans Mono Medium 11'"

    gsettings set org.gnome.desktop.interface gtk-theme ${settings.common.gtk.theme}
    # gsettings set org.gnome.desktop.interface color-scheme ${settings.modules.dconf.colorScheme}
    # gsettings set org.gnome.desktop.interface cursor-theme ${settings.common.cursor.name}
    # gsettings set org.gnome.desktop.interface icon-theme ${settings.common.icons.nameInDark}
    # gsettings set org.gnome.desktop.interface font-name ${fontName}

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

    # ---- Make nautilus Run in Background ---- #
    # nautilus --no-desktop &

    rm -rf ~/.cache/thumbnails/*
    nautilus -q

    # ---- DBUS ---- #
    # ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    # kill active portals and restart them
    $scriptsDir/PortalHyprland-NixOS.sh

    # ---- hyprlock ---- #
    # ${pkgs.hyprlock}/bin/hyprlock

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

    #! ---- The Screen Edge Actions ---- #
    # detect-mouse-position

    ashell
  '';
in {
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland.settings = {
      exec-once = "${startupScript}/bin/start";
    };
  };
}
