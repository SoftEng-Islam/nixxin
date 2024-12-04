{ pkgs, ... }: {
  # Environment Variables
  # Desktop Manager
  # QT
  # GTK
  # Terminal
  environment.systemPackages = with pkgs; [
    gruvbox-dark-gtk
    gruvbox-dark-icons-gtk
    gruvbox-gtk-theme
    gruvbox-plus-icons
    adw-gtk3
  ];
}
