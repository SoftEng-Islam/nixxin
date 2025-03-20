# GTK  Stuff & Themes & Graphical Interfaces
{ settings, pkgs, ... }: {
  gtk.iconCache.enable = settings.common.gtk.icon_cache;
  home-manager.users.${settings.user.username} = {
    gtk = {
      enable = true;
      gtk2.configLocation =
        "/home/${settings.user.username}/.config/gtk-2.0/gtkrc";
      # theme = {
      #   name = lib.mkForce settings.gtkTheme;
      #   package = lib.mkForce settings.gtkPackage;
      # };
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
    wrapGAppsHook
    yad
    ydotool
  ];
}
