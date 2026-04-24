{
  settings,
  lib,
  pkgs,
  ...
}:
let
  browserDesktopEntry = "${settings.modules.desktop.xdg.defaults.webBrowser}.desktop";
in
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
        "application/xhtml+xml" = browserDesktopEntry;
        "text/html" = browserDesktopEntry;
        "x-scheme-handler/about" = browserDesktopEntry;
        "x-scheme-handler/http" = browserDesktopEntry;
        "x-scheme-handler/https" = browserDesktopEntry;
        "x-scheme-handler/unknown" = browserDesktopEntry;
      };
    };
  };
}
