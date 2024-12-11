{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    cliphist # Wayland clipboard manager
    gpaste # Clipboard management system with GNOME integration
    wl-clipboard # Command-line copy/paste utilities for Wayland
    clipman # A simple clipboard manager for Wayland
    fuzzel # Wayland-native application launcher, similar to rofi’s drun mode
  ];
}
