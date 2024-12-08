{ pkgs, ... }: {
  # Environment Variables
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
  # Desktop Manager
  # QT
  # GTK
  # Terminal
  # Nautilus
  services = {
    xserver.desktopManager = {
      gnome = {
        extraGSettingsOverrides = ''
          [org.gnome.desktop.interface]
          gtk-theme='Colloid-Dark'
          icon-theme='Papirus-Dark'
          color-scheme='prefer-dark'
          cursor-theme='Breeze_Light'
          cursor-size=24

          [org.gnome.desktop.wm.preferences]
          button-layout='close,minimize,maximize:'
        '';
      };
    };
  };
  environment.systemPackages = with pkgs; [
    # GRUB Themes

    # GTK Themes
    adw-gtk3 # Theme from libadwaita ported to GTK-3
    gruvbox-dark-gtk
    gruvbox-gtk-theme
    gruvbox-dark-icons-gtk
    gruvbox-plus-icons

    # QT Themes

    # Plymouth Theme For Nixos:
    plymouth # Boot splash and boot logger
    nixos-bgrt-plymouth # BGRT theme with a spinning NixOS logo
  ];
}
