{
  settings,
  lib,
  pkgs,
  ...
}:
{
  xdg.portal = {
    #   # Enable XDG portals, which allow sandboxed applications
    #   # (e.g., Flatpak or Snap) to interact with the system securely.
    enable = true;

    #   # Add the xdg-desktop-portal package as an extra portal service.
    #   # This package provides key portal services such as file access,
    #   # printing, and screenshots for sandboxed apps.
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];

    #   # Set the default access configuration for portals.
    #   # The "*" wildcard here allows all sandboxed applications
    #   # to access available portals, providing them with broad access
    #   # to system resources like file dialogs and screen sharing.
    config = {
      common.default = "*";
      hyprland = {
        default = [
          "hyprland"
          "gtk"
        ];
        # "org.freedesktop.impl.portal.Filechooser" = [
        #   "kde"
        # ];
      };
    };
  };
  home-manager.users.${settings.user.username} = {
    xdg.systemDirs.data = [
      "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
      "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
    ];
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        # "x-scheme-handler/http" = "app.zen_browser.zen.desktop";
        # "x-scheme-handler/https" = "app.zen_browser.zen.desktop";
        # "text/html" = "app.zen_browser.zen.desktop";
        # "application/pdf" = "org.gnome.Evince.desktop";
        # "audio/mpeg" = "io.mpv.Mpv.desktop";
        # "video/mp4" = "io.mpv.Mpv.desktop";
        # "x-scheme-handler/video" = "io.mpv.Mpv.desktop";
        # "image/jpeg" = "org.gnome.Loupe.desktop";
        # "image/png" = "org.gnome.Loupe.desktop";
        # "image/*" = "org.gnome.Loupe.desktop";
        # "x-scheme-handler/terminal" = "kitty.desktop";
        # "x-scheme-handler/mailto" = "eu.betterbird.Betterbird.desktop";
        # "message/rfc822" = "eu.betterbird.Betterbird.desktop";
      };
    };
  };
}
