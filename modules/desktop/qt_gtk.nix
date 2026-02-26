# Themes & Graphical Interfaces
{ settings, pkgs, ... }:
let
  _qt_gtk = settings.common.qt;
  _icons = settings.common.icons;
  _isPapirus = builtins.match "^Papirus" _icons.nameInDark != null;
  _useSystemIconTheme = _isPapirus && (settings.modules.icons.enable or false);
  _gtkIconThemePackage =
    if _useSystemIconTheme then
      # Papirus is installed system-wide (see `modules/icons/default.nix`) and
      # includes the folder-color override. Don't install a user-profile copy
      # that could shadow it (and revert folders to blue).
      null
    else if _isPapirus then
      # Use the final `pkgs` so the Papirus folder-color overlay applies.
      pkgs.papirus-icon-theme
    else
      _icons.package;
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
        package = _gtkIconThemePackage;
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

      gtk3.extraCss = ''
        .nemo-window .sidebar .cell { /* notice the .cell */
          padding: 3px; /* padding space between lines/rows */
        }
        .nemo-window .sidebar .view {
          background-color: @theme_bg_color;
          color: @theme_fg_color;
        }
      '';

      gtk3.bookmarks = [
        "file:///home/${settings.user.username}/Downloads"
        "file:///home/${settings.user.username}/Documents"
        "file:///home/${settings.user.username}/Pictures"
        "file:///home/${settings.user.username}/Music"
        "file:///home/${settings.user.username}/Videos"
      ];

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
