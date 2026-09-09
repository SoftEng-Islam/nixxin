# Themes & Graphical Interfaces
#
# Noctalia owns the live GTK palette when theme templates `gtk3`/`gtk4` are
# enabled: it writes ~/.config/gtk-{3,4}.0/noctalia.css, imports them into
# gtk.css, and switches gsettings between adw-gtk3 / adw-gtk3-dark.
# Do not set GTK_THEME — that env var overrides gsettings and blocks those CSS
# color roles from applying.
{
  settings,
  pkgs,
  lib,
  ...
}:
let
  _qt_gtk = settings.common.qt;
  preferDark = settings.modules.desktop.dconf.colorScheme == "prefer-dark";
  # Fallback for settings.ini only; Noctalia's apply.sh may switch this at runtime.
  gtkThemeName =
    if settings.common.gtk.theme != null && settings.common.gtk.theme != "" then
      settings.common.gtk.theme
    else if preferDark then
      "adw-gtk3-dark"
    else
      "adw-gtk3";
in
{
  gtk.iconCache.enable = settings.common.gtk.icon_cache;
  home-manager.users.${settings.user.username} = {

    # ----------------  ----------------
    #                 GTK
    # ----------------  ----------------
    gtk = {
      enable = settings.common.gtk.enable;
      colorScheme = if preferDark then "dark" else "light";
      theme = {
        name = gtkThemeName;
        package = settings.common.gtk.package;
      };

      iconTheme = {
        name = if preferDark then settings.common.icons.nameInDark else settings.common.icons.nameInLight;
        package = settings.common.icons.package;
      };

      cursorTheme = {
        name = settings.common.cursor.name;
        size = settings.common.cursor.size;
        package = settings.common.cursor.package;
      };

      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = preferDark;
        gtk-decoration-layout = "menu:";
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintfull";
        gtk-xft-rgba = "rgb";
        gtk-recent-files-enabled = true;
        gtk-cursor-theme-name = settings.common.cursor.name;
      };

      gtk3.bookmarks = [
        # "recent:///"

        "file:///home/${settings.user.username}/Downloads"
        "file:///home/${settings.user.username}/Documents"
        "file:///home/${settings.user.username}/Pictures"
        "file:///home/${settings.user.username}/Music"
        "file:///home/${settings.user.username}/Videos"

        # "file:///home/${settings.user.username}/Torrents"
        # "file:///home/${settings.user.username}/.config"
        # "file:///home/${settings.user.username}/.cache"
        # "file:///home/${settings.user.username}/.local"

        # "network:///"
        # "computer:///"
      ];

      gtk4 = {
        # Leave null so libadwaita reads gtk.css (Noctalia noctalia.css import).
        theme = null;
        extraConfig = {
          gtk-application-prefer-dark-theme = preferDark;
        };
      };
    };

    # ----------------  ----------------
    #                 Qt
    # ----------------  ----------------
    qt = {
      enable = true;
      platformTheme.name = _qt_gtk.platformTheme;
      # style.name = _qt_gtk.style;
    };

    # Select the palette Noctalia generates for the "qt" template.
    xdg.configFile."qt6ct/qt6ct.conf".text = ''
      [Appearance]
      style=Fusion
      custom_palette=true
      color_scheme_path=~/.config/qt6ct/colors/noctalia.conf
      standard_dialogs=default
    '';
  };

  environment.variables = {
    # Enable automatic screen scaling for Qt apps
    QT_AUTO_SCREEN_SCALE_FACTOR = _qt_gtk.SCALE_FACTOR;

    # Set the scale factor for Qt apps
    QT_SCALE_FACTOR = _qt_gtk.SCALE_FACTOR;

    QT_QPA_PLATFORMTHEME = _qt_gtk.QT_QPA_PLATFORMTHEME;

    # Fix old GTK3 applications
    GDK_GL = "always"; # "gles" "disable" "always"
  }
  //
    lib.optionalAttrs (settings.common.gtk.GTK_THEME != null && settings.common.gtk.GTK_THEME != "")
      {
        GTK_THEME = settings.common.gtk.GTK_THEME;
      };
  environment.systemPackages = with pkgs; [
    # QT & KDE Stuff

    adwaita-qt6
    gsettings-qt

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

    gtk3 # A multi-platform toolkit for creating graphical user interfaces
    gtk4 # A multi-platform toolkit for creating graphical user interfaces
    gtk4-layer-shell # A library to create panels and other desktop components for Wayland using the Layer Shell protocol and GTK4
    gtkmm4 # C++ interface to the GTK graphical user interface library
    gtksourceview
    libappindicator-gtk3
    tk
    webkitgtk_6_0
    webp-pixbuf-loader
  ];
}
