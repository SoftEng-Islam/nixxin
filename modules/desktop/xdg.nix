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
    xdg.enable = true;
    xdg.configFile."mimeapps.list".force = true;

    xdg.systemDirs.data = [
      "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
      "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
    ];
    # Desktop entries are located in /run/current-system/sw/share/applications/
    # For programs installed using home manager /etc/profiles/per-user/{user}/share/applications/
    # Chrome PWAs are located in ~/.local/share/applications/
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "application/xhtml+xml" = browserDesktopEntry;
        "text/html" = browserDesktopEntry;
        "x-scheme-handler/about" = browserDesktopEntry;
        "x-scheme-handler/http" = browserDesktopEntry;
        "x-scheme-handler/https" = browserDesktopEntry;
        "x-scheme-handler/unknown" = browserDesktopEntry;
        "x-scheme-handler/ftp" = browserDesktopEntry; # open `ftp:` url with `browser`
        "application/rdf+xml" = browserDesktopEntry;
        "application/rss+xml" = browserDesktopEntry;
        "application/x-extension-htm" = browserDesktopEntry;
        "application/x-extension-html" = browserDesktopEntry;
        "application/x-extension-shtml" = browserDesktopEntry;
        "application/x-extension-xht" = browserDesktopEntry;
        "application/x-extension-xhtml" = browserDesktopEntry;
        "application/xhtml_xml" = browserDesktopEntry;

        "x-scheme-handler/vscode" = "code-url-handler.desktop;";

        # Text files
        "text/plain" = "dev.zed.Zed.desktop;";
        "text/x-python" = "dev.zed.Zed.desktop;";
        "application/x-shellscript" = "dev.zed.Zed.desktop;";
        "application/json" = "dev.zed.Zed.desktop;";
        "application/xml" = "code.desktop;";
        # "application/x-executable" = "kitty-open.desktop;Alacritty.desktop;";

        # PDF
        "application/pdf" = "org.gnome.Evince.desktop";

        # Images
        "image/png" = "org.gnome.Loupe.desktop;";
        "image/jpeg" = "org.gnome.Loupe.desktop;";
        "image/gif" = "org.gnome.Loupe.desktop;";
        "image/webp" = "org.gnome.Loupe.desktop;";

        # Telegram
        "x-scheme-handler/tg" = "org.telegram.desktop.desktop;io.github.kukuruzka165.materialgram.desktop;";
        "x-xdg-protocol-tg" = "org.telegram.desktop.desktop;io.github.kukuruzka165.materialgram.desktop;";
        "x-scheme-handler/tonsite" =
          "org.telegram.desktop.desktop;io.github.kukuruzka165.materialgram.desktop;";

        # Media
        "audio/*" = "mpv.desktop;";
        "video/*" = "mpv.desktop;";
      };
      associations.added = {

      };
    };
  };
}
