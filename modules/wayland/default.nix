{ settings, lib, pkgs, ... }:

let inherit (lib) mkIf;
in mkIf (settings.modules.wayland.enable) {
  # environment.variables = { };
  environment.systemPackages = with pkgs; [
    libqalculate # Advanced calculator library
    mkvtoolnix-cli # Cross-platform tools for Matroska
    seatd # A minimal seat management daemon, and a universal seat management library
    slurp # Select a region in a Wayland compositor
    swww # Efficient animated wallpaper daemon for wayland, controlled at runtime
    wayland # Core Wayland window system code and protocol
    wayland-utils # Wayland utilities (wayland-info)
    waypipe # Network proxy for Wayland clients (apps)
    wayvnc # VNC server for wlroots based Wayland compositors
    wev # Wayland event viewer
    wf-recorder # Utility program for screen recording of wlroots-based compositors
    wl-gammactl # Contrast, brightness, and gamma adjustments for Wayland
    wl-gammarelay-rs # A simple program that provides DBus interface to control display temperature and brightness under wayland without flickering
    wlogout # Wayland based logout menu
    wlr-protocols # Wayland roots protocol extensions
    wlrctl # Command line utility for miscellaneous wlroots Wayland extensions
    wlroots # A modular Wayland compositor library
    wlsunset # Day/night gamma adjustments for Wayland
    wtype # xdotool type for wayland
    egl-wayland # EGLStream-based Wayland external platform
  ];
}
