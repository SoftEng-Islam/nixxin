# Themes & Graphical Interfaces
{ settings, pkgs, ... }:
let _qt_gtk = settings.common.qt;
in {
  gtk.iconCache.enable = settings.common.gtk.icon_cache;
  home-manager.users.${settings.user.username} = {
    gtk = {
      enable = true;
      # iconTheme = {
      #   name = settings.common.icons.nameInDark;
      #   package = settings.common.icons.package;
      # };
      gtk2 = {
        enable = true;
        # gtk2.theme.name = settings.common.gtk.theme;
      };
      gtk3 = {
        enable = true;
        theme.name = settings.common.gtk.theme;
        # extraConfig = {
        #   gtk-decoration-layout = "menu:";
        #   gtk-xft-antialias = 1;
        #   gtk-xft-hinting = 1;
        #   gtk-xft-hintstyle = "hintfull";
        #   gtk-xft-rgba = "rgb";
        #   gtk-recent-files-enabled = false;
        # };

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
        extraConfig = { "gtk-application-prefer-dark-theme" = true; };
        colorScheme = "dark";
      };
      gtk4 = {
        enable = true;
        theme.name = settings.common.gtk.theme;
        colorScheme = "dark";
        extraConfig = { "gtk-application-prefer-dark-theme" = true; };
      };
    };
    qt = {
      enable = true;
      platformTheme.name = _qt_gtk.platformTheme;
      style.name = _qt_gtk.style;
    };

    # nix build nixpkgs#adw-gtk3 --print-out-paths --no-link
    xdg.configFile = {
      "gtk-3.0/gtk.css".source =
        "${settings.common.gtk.package}/share/themes/adw-gtk3-dark/gtk-3.0/gtk.css";
      "gtk-3.0/gtk-dark.css".source =
        "${settings.common.gtk.package}/share/themes/adw-gtk3-dark/gtk-3.0/gtk-dark.css";

      "gtk-4.0/gtk.css".source =
        "${settings.common.gtk.package}/share/themes/adw-gtk3-dark/gtk-4.0/gtk.css";
      "gtk-4.0/gtk-dark.css".source =
        "${settings.common.gtk.package}/share/themes/adw-gtk3-dark/gtk-4.0/gtk-dark.css";
    };

    # Set the gtk css files in ~/.config
    # home.file.".config/gtk-3.0".source =
    #   "${pkgs.adw-gtk3}/share/themes/adw-gtk3-dark/gtk-3.0";
    # home.file.".config/gtk-4.0".source =
    #   "${pkgs.adw-gtk3}/share/themes/adw-gtk3-dark/gtk-4.0";
  };

  environment.variables = {
    GTK_THEME = settings.common.gtk.GTK_THEME;
    # GTK2_RC_FILES = "$HOME/.config/gtk-2.0/gtkrc";
    QT_STYLE_OVERRIDE = "Adwaita-dark";

    # Enable automatic screen scaling for Qt apps
    QT_AUTO_SCREEN_SCALE_FACTOR = _qt_gtk.SCALE_FACTOR;

    # Set the scale factor for Qt apps
    QT_SCALE_FACTOR = _qt_gtk.SCALE_FACTOR;

    # Force QT to use wayland
    # QT_PLATFORM_PLUGIN = "wayland";
    QT_QPA_PLATFORM = "wayland";

    QT_QPA_PLATFORMTHEME = _qt_gtk.QT_QPA_PLATFORMTHEME;

    # fix old GTK3 applications
    # GDK_GL = "always"; # "gles" "disable" "always"
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
    yad
    ydotool
  ];
}
