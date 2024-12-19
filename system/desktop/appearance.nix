{ settings, pkgs, ... }: {
  services = {
    xserver.desktopManager = {
      gnome = {
        # extraGSettingsOverrides = ''
        #   [org.gnome.desktop.interface]
        #   gtk-theme='${settings.gtkTheme}'
        #   icon-theme='${settings.icons}'
        #   color-scheme='${settings.colorScheme}'
        #   cursor-theme='${settings.cursorTheme}'
        #   cursor-size=${settings.cursorSize}

        #   [org.gnome.desktop.wm.preferences]
        #   button-layout='close,minimize,maximize:'
        # '';
      };
    };
  };
  environment.systemPackages = with pkgs; [
    # GRUB Themes
    # Plymouth Theme For Nixos:
    plymouth # Boot splash and boot logger
    nixos-bgrt-plymouth # BGRT theme with a spinning NixOS logo

    # Themes & Graphical Interfaces
    gtk3 # A multi-platform toolkit for creating graphical user interfaces
    gtk4 # A multi-platform toolkit for creating graphical user interfaces
    gtk_engines # Theme engines for GTK 2
    libadwaita # Library to help with developing UI for mobile devices using GTK/GNOME

    adw-gtk3 # Theme from libadwaita ported to GTK-3
    gruvbox-dark-gtk # Gruvbox theme for GTK based desktop environments
    gruvbox-gtk-theme # GTK theme based on the Gruvbox colour palette
    colloid-gtk-theme # Modern and clean Gtk theme

    # Icons
    gruvbox-dark-icons-gtk
    gruvbox-plus-icons
    papirus-icon-theme # Pixel perfect icon theme for Linux

    # QT Themes
  ];
}
