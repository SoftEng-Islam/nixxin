# Themes & Graphical Interfaces
{ settings, pkgs, ... }:
let _qt_gtk = settings.common.qt;
in {
  gtk.iconCache.enable = settings.common.gtk.icon_cache;
  home-manager.users.${settings.user.username} = {
    gtk = {
      enable = true;
      theme = {
        name = settings.common.gtk.theme;
        package = settings.common.gtk.package;
      };
      iconTheme = {
        name = settings.common.icons.nameInDark;
        package = settings.common.icons.package;
      };
      gtk2 = { enable = true; };
      gtk3 = {
        bookmarks = [
          "file:///home/${settings.user.username}/Downloads"
          "file:///home/${settings.user.username}/Documents"
          "file:///home/${settings.user.username}/Pictures"
          "file:///home/${settings.user.username}/Music"
          "file:///home/${settings.user.username}/Videos"
          # "file:///home/${settings.user.username}/Dev"
          # "file:///home/${settings.user.username}/GitHub"
          # "file:///home/${settings.user.username}/.config"
          # "file:///mnt/Windows"
        ];
        extraCss = ''
          headerbar, .titlebar,
          .csd:not(.popup):not(tooltip):not(messagedialog) decoration {
            border-radius: 0;
          }
        '';
      };
      gtk4 = {
        enable = true;
        colorScheme = "dark";
        # extraCss = ''
        #   .nautilus-window {
        #     background: transparent;
        #     backdrop-filter: blur(20px);
        #   }
        # '';
      };
    };
    qt = {
      enable = true;
      platformTheme.name = _qt_gtk.platformTheme;
      style.name = _qt_gtk.style;
    };
  };

  environment.variables = {
    # Enable automatic screen scaling for Qt apps
    QT_AUTO_SCREEN_SCALE_FACTOR = _qt_gtk.SCALE_FACTOR;

    # Set the scale factor for Qt apps
    QT_SCALE_FACTOR = _qt_gtk.SCALE_FACTOR;

    # Force QT to use wayland
    # QT_PLATFORM_PLUGIN = "wayland";
    QT_QPA_PLATFORM = "wayland";

    QT_QPA_PLATFORMTHEME = _qt_gtk.QT_QPA_PLATFORMTHEME;

    # fix old GTK3 applications
    GDK_GL = "always"; # "gles" "disable" "always"
  };
  environment.systemPackages = with pkgs; [
    # QT & KDE Stuff
    adwaita-qt
    adwaita-qt6
    gsettings-qt
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5ct # Qt5 Configuration Tool
    libsForQt5.qwt
    qt5.qtgraphicaleffects
    qt5.qtimageformats
    qt5.qtquickcontrols2
    qt6.qtbase
    qt6.qtdeclarative
    qt6.qtsvg
    qt6.qtwayland

    # GTK
    adw-gtk3

    gobject-introspection
    gtk_engines # Theme engines for GTK 2

    gtk3 # A multi-platform toolkit for creating graphical user interfaces
    gtk4 # A multi-platform toolkit for creating graphical user interfaces
    gtk4-layer-shell # A library to create panels and other desktop components for Wayland using the Layer Shell protocol and GTK4
    gtkmm4 # C++ interface to the GTK graphical user interface library
    gtksourceview
    libappindicator-gtk3
    tk
    # webkitgtk # Web content rendering engine, GTK port
    webkitgtk_6_0
    webp-pixbuf-loader
    yad
    ydotool
  ];
}
