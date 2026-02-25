# Themes & Graphical Interfaces
{ settings, pkgs, ... }:
let
  _qt_gtk = settings.common.qt;
in
{
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

      cursorTheme = {
        name = settings.common.cursor.name;
        size = settings.common.cursor.size;
        package = settings.common.cursor.package;
      };

      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = true;
        gtk-decoration-layout = "menu:";
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintfull";
        gtk-xft-rgba = "rgb";
        gtk-recent-files-enabled = false;
      };

      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = true;
        gtk-interface-color-scheme = 2;
      };
    };

    qt = {
      enable = true;
      platformTheme.name = _qt_gtk.platformTheme;
      style.name = _qt_gtk.style;
    };
  };

  environment.variables = {
    GTK_THEME = settings.common.gtk.GTK_THEME;
    # GTK2_RC_FILES = "${HOME}/.config/gtk-2.0/gtkrc";
    QT_STYLE_OVERRIDE = _qt_gtk.style;

    # Enable automatic screen scaling for Qt apps
    QT_AUTO_SCREEN_SCALE_FACTOR = _qt_gtk.SCALE_FACTOR;

    # Set the scale factor for Qt apps
    QT_SCALE_FACTOR = _qt_gtk.SCALE_FACTOR;

    QT_QPA_PLATFORMTHEME = _qt_gtk.platformTheme;

    # Fix old GTK3 applications
    GDK_GL = "always"; # "gles" "disable" "always"
  };
  environment.systemPackages = with pkgs; [
    # QT & KDE Stuff
    # adwaita-qt
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
    libadwaita

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
    # yad
    # ydotool
  ];
}
