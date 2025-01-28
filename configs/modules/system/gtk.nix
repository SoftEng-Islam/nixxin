{ settings, pkgs, ... }: {
  gtk.iconCache.enable = false;
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
          "file:///home/${settings.username}/Downloads"
          "file:///home/${settings.username}/Documents"
          "file:///home/${settings.username}/Pictures"
          "file:///home/${settings.username}/Music"
          "file:///home/${settings.username}/Videos"
          "file:///home/${settings.username}/Dev"
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
    # gtk_engines # Theme engines for GTK 2
    # gtk-layer-shell
    gtk3 # A multi-platform toolkit for creating graphical user interfaces
    # gtk-doc
    # gtk-server
    gtk4 # A multi-platform toolkit for creating graphical user interfaces
    gtk4-layer-shell # A library to create panels and other desktop components for Wayland using the Layer Shell protocol and GTK4
    # gtkmm2 # C++ interface to the GTK graphical user interface library
    # gtkmm3 # C++ interface to the GTK graphical user interface library
    gtkmm4 # C++ interface to the GTK graphical user interface library
    gtksourceview
    # gtksourceview3
    libappindicator-gtk3
    # tk
    #webkitgtk_6_0 # Web content rendering engine, GTK port
    webp-pixbuf-loader
    wrapGAppsHook
    yad
    ydotool
  ];
}
