{ settings, pkgs, ... }: {
  # gtk.iconCache.enable = false;
  home-manager.users.${settings.users.selected.username} = {
    gtk = {
      enable = true;
      gtk2.configLocation =
        "/home/${settings.users.selected.username}/.config/gtk-2.0/gtkrc";
      # theme = {
      #   name = lib.mkForce settings.gtkTheme;
      #   package = lib.mkForce settings.gtkPackage;
      # };
      gtk3 = {
        bookmarks = [
          "file:///home/${settings.users.selected.username}/Downloads"
          "file:///home/${settings.users.selected.username}/Documents"
          "file:///home/${settings.users.selected.username}/Pictures"
          "file:///home/${settings.users.selected.username}/Music"
          "file:///home/${settings.users.selected.username}/Videos"
          # "file:///home/${settings.users.selected.username}/Dev"
          # "file:///home/${settings.users.selected.username}/GitHub"
          # "file:///home/${settings.users.selected.username}/.config"
          # "file:///mnt/Windows"
        ];
        # extraCss = ''
        #   headerbar, .titlebar,
        #   .csd:not(.popup):not(tooltip):not(messagedialog) decoration{
        #     border-radius: 0;
        #   }
        # '';
      };
    };
  };
  environment.systemPackages = with pkgs; [
    # GTK  Stuff & Themes & Graphical Interfaces
    gobject-introspection
    gtk_engines # Theme engines for GTK 2

    gtk3 # A multi-platform toolkit for creating graphical user interfaces
    gtk4 # A multi-platform toolkit for creating graphical user interfaces

    gtk4-layer-shell # A library to create panels and other desktop components for Wayland using the Layer Shell protocol and GTK4
    gtkmm4 # C++ interface to the GTK graphical user interface library
    gtksourceview
    libappindicator-gtk3
    tk
    webkitgtk # Web content rendering engine, GTK port
    webp-pixbuf-loader
    wrapGAppsHook
    yad
    ydotool
  ];
}
