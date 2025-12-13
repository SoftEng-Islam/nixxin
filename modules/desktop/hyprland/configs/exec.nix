{ settings, inputs, pkgs, ... }:
let
  fontName = "${settings.modules.fonts.main.name} ${
      toString settings.modules.fonts.main.size.main
    }";

  # ashell = inputs.ashell.defaultPackage.${pkgs.system};

  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    #!/usr/bin/env bash
    # ---- DBUS ---- #
    systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP PATH
    ${pkgs.hyprshade}/bin/hyprshade toggle ~/.config/hypr/shaders/blue-light-filter.glsl

    # ---- Set Desktop Wallpaper ---- #
    changeWallpaper & disown
    sleep 1

    # ---- Start Ashell a status bar ---- #
    ${pkgs.ashell}/bin/ashell & disown

    # Core components (authentication, lock screen, notification daemon)
    ${pkgs.gnome-keyring}/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh

    # ---- Clipboard ---- #
    ${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store
    ${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store

    # ---- Set Cursor ---- #
    hyprctl setcursor ${settings.common.cursor.name} ${
      toString settings.common.cursor.size
    }

    # ---- Notification daemon ---- #
    swaync & disown

    # ---- Apps To Start ---- #
    Telegram -startintray & disown

    # ---- Set The Appearence ---- #
    # dconf write /org/gnome/desktop/interface/gtk-theme "'Adwaita'"
    # dconf write /org/gnome/desktop/interface/icon-theme "'Flat-Remix-Red-Dark'"
    # dconf write /org/gnome/desktop/interface/document-font-name "'Noto Sans Medium 11'"
    # dconf write /org/gnome/desktop/interface/font-name "'Noto Sans Medium 11'"
    # dconf write /org/gnome/desktop/interface/monospace-font-name "'Noto Sans Mono Medium 11'"

  '';
in {
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland.settings = {
      exec-once = "${startupScript}/bin/start";
    };
  };
}
# gsettings set org.gnome.desktop.interface gtk-theme ${settings.common.gtk.theme}
# gsettings set org.gnome.desktop.interface color-scheme ${settings.modules.desktop.dconf.colorScheme}
# gsettings set org.gnome.desktop.interface cursor-theme ${settings.common.cursor.name}
# gsettings set org.gnome.desktop.interface icon-theme ${settings.common.icons.nameInDark}
# gsettings set org.gnome.desktop.interface font-name ${fontName}
