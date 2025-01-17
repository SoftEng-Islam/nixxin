{ settings, pkgs, ... }: {
  gtk.iconCache.enable = true;
  home-manager.users.${settings.username} = {
    gtk = {
      enable = true;
      # gtk2.configLocation = "/home/${settings.username}/.config/gtk-2.0/gtkrc";
      # theme = {
      #   name = lib.mkForce settings.gtkTheme;
      #   package = lib.mkForce settings.gtkPackage;
      # };
      gtk3 = {
        bookmarks = [
          "file:///home/${settings.username}/Dev"
          "file:///home/${settings.username}/Downloads"
          "file:///home/${settings.username}/Documents"
          "file:///home/${settings.username}/Pictures"
          "file:///home/${settings.username}/Music"
          "file:///home/${settings.username}/Videos"
          "file:///home/${settings.username}/GitHub"
          "file:///home/${settings.username}/.config"
          # "file:///mnt/Windows"
        ];
        extraCss = ''
          headerbar, .titlebar,
          .csd:not(.popup):not(tooltip):not(messagedialog) decoration{
            border-radius: 0;
          }
        '';
      };
    };
  };
  environment.systemPackages = with pkgs; [
    # GTK  Stuff & Themes & Graphical Interfaces
    gobject-introspection
    gruvbox-dark-gtk # Gruvbox theme for GTK based desktop environments
    gruvbox-gtk-theme # GTK theme based on the Gruvbox colour palette
    gtk_engines # Theme engines for GTK 2
    gtk-layer-shell
    gtk3 # A multi-platform toolkit for creating graphical user interfaces
    gtk3.dev
    gtk-doc
    gtk-server
    gtk4 # A multi-platform toolkit for creating graphical user interfaces
    gtk4-layer-shell # A library to create panels and other desktop components for Wayland using the Layer Shell protocol and GTK4
    gtk4.dev
    gtkmm2 # C++ interface to the GTK graphical user interface library
    gtkmm3 # C++ interface to the GTK graphical user interface library
    gtkmm4 # C++ interface to the GTK graphical user interface library
    gtksourceview
    gtksourceview.dev
    gtksourceview3
    libadwaita # Library to help with developing UI for mobile devices using GTK/GNOME
    libappindicator-gtk3.dev
    libdbusmenu-gtk3 # Library for passing menu structures across DBus
    tk
    upower
    #webkitgtk_6_0 # Web content rendering engine, GTK port
    webp-pixbuf-loader
    wrapGAppsHook
    yad
    ydotool
  ];
}
