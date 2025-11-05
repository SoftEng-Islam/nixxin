{ settings, inputs, pkgs, ... }:
let
  fontName = "${settings.modules.fonts.main.name} ${
      toString settings.modules.fonts.main.size.main
    }";
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    #!/usr/bin/env bash
    #* ---- Set `GTK_THEME` Env Variable ---- #
    # export GTK_THEME=${settings.common.gtk.GTK_THEME}

    # ---- DBUS ---- #
    systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP PATH

    changeWallpaper
    # ${pkgs.swww}/bin/swww-daemon --no-cache --format xrgb &
    # ${pkgs.swww}/bin/swww img ~/Pictures/desktop.png --transition-bezier .43,1.19,1,.4 --transition-fps 30 --transition-type grow --transition-pos 0.925,0.977 --transition-duration 2
    sleep 1

    # ---- Start Ashell a status bar ---- #
    ${pkgs.ashell}/bin/ashell
    sleep 1

    # dconf write /org/gnome/desktop/interface/gtk-theme "'Adwaita'"
    # dconf write /org/gnome/desktop/interface/icon-theme "'Flat-Remix-Red-Dark'"
    # dconf write /org/gnome/desktop/interface/document-font-name "'Noto Sans Medium 11'"
    # dconf write /org/gnome/desktop/interface/font-name "'Noto Sans Medium 11'"
    # dconf write /org/gnome/desktop/interface/monospace-font-name "'Noto Sans Mono Medium 11'"

    # gsettings set org.gnome.desktop.interface gtk-theme ${settings.common.gtk.theme}
    # gsettings set org.gnome.desktop.interface color-scheme ${settings.modules.desktop.dconf.colorScheme}
    # gsettings set org.gnome.desktop.interface cursor-theme ${settings.common.cursor.name}
    # gsettings set org.gnome.desktop.interface icon-theme ${settings.common.icons.nameInDark}
    # gsettings set org.gnome.desktop.interface font-name ${fontName}

    # Core components (authentication, lock screen, notification daemon)
    ${pkgs.gnome-keyring}/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh

    # ---- notification daemon ---- #
    swaync &

    # ---- Clipboard ---- #
    ${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store
    ${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store

    # ---- Set Cursor ---- #
    hyprctl setcursor ${settings.common.cursor.name} ${
      toString settings.common.cursor.size
    }

    # ---- Apps To Start ---- #
    # telegram-desktop -startintray

    #! ---- The Screen Edge Actions ---- #
    # detect-mouse-position
  '';
in {
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland.settings = {
      exec-once = "${startupScript}/bin/start";
    };
  };
}
