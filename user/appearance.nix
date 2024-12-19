{ settings, pkgs, lib, config, ... }: {

  xdg.configFile."gtk-4.0/gtk.css".enable = lib.mkForce false;

  # GTK Settings
  gtk = {
    enable = true;

    cursorTheme = {
      name = settings.cursorTheme;
      size = settings.cursorSize;
      package = settings.cursorPackage;
    };

    font = {
      name = settings.fontName;
      package = settings.fontPackage;
      size = settings.fontSize;
    };

    iconTheme = {
      name = settings.iconName;
      package = settings.iconPackage;
    };

    theme = {
      name = settings.gtkTheme;
      package = settings.gtkPackage;
    };

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  };

  # QT Settings
  qt = {
    enable = true;
    platformTheme = settings.qtPlatformTheme;
    style = settings.qtStyle;
  };
  environment.systemPackages = with pkgs; [
    # Themes & Graphical Interfaces
    gtk3 # A multi-platform toolkit for creating graphical user interfaces
    gtk4 # A multi-platform toolkit for creating graphical user interfaces
    gtk_engines # Theme engines for GTK 2
    libadwaita # Library to help with developing UI for mobile devices using GTK/GNOME

    adw-gtk3 # Theme from libadwaita ported to GTK-3
    gruvbox-dark-gtk # Gruvbox theme for GTK based desktop environments
    gruvbox-gtk-theme # GTK theme based on the Gruvbox colour palette
    colloid-gtk-theme # Modern and clean Gtk theme

    qt6Packages.qtstyleplugin-kvantum
    qt6Packages.qt6ct
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct

    # Icons
    gruvbox-dark-icons-gtk
    gruvbox-plus-icons
    papirus-icon-theme # Pixel perfect icon theme for Linux

    # QT Themes
    adwaita-qt
    adwaita-qt6
  ];
}
