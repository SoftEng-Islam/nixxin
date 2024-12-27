{ pkgs, inputs, ... }: {
  # Run Hyprland in a nested session for testing within GNOME:
  # Install waypipe and weston: These tools allow you to run Wayland compositors inside existing Wayland/X11 sessions.
  # Start Nested Hyprland: Inside GNOME, run:
  # `weston --socket=wayland-1 &`
  # `WAYLAND_DISPLAY=wayland-1 Hyprland`

  programs = {
    uwsm.enable = true;
    hyprlock.enable = true;
    hyprland = {
      enable = true;
      withUWSM = true; # Launch Hyprland with the UWSM session manager.
      xwayland.enable = false;
      package = inputs.hyprland.packages.${pkgs.system}.default;
      portalPackage =
        inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    };
  };
  environment.systemPackages = with pkgs; [
    # Hyprland -----------------------------------------------------------
    # albert # Fast and flexible keyboard launcher
    ags # A EWW-inspired widget system as a GJS library
    brightnessctl # This program allows you read and control device brightness
    fd # A simple, fast and user-friendly alternative to find
    gpu-screen-recorder # A screen recorder that has minimal impact on system performance by recording a window using the GPU only
    gpu-screen-recorder-gtk # GTK frontend for gpu-screen-recorder.
    hyprcursor # The hyprland cursor format, library and utilities
    # hyprgui # unstable GUI for configuring Hyprland written in Rust
    hypridle # Hyprland's idle daemon
    hyprland-protocols # Wayland protocol extensions for Hyprland
    hyprlang # The official implementation library for the hypr config language
    hyprlauncher # GUI for launching applications, written in Rust
    hyprlock # Hyprland's GPU-accelerated screen locking utility
    hyprnotify # DBus Implementation of Freedesktop Notification spec for 'hyprctl notify'
    hyprpaper # A blazing fast wayland wallpaper utility
    hyprpicker # A wlroots-compatible Wayland color picker that does not suck
    hyprshot # Hyprshot is an utility to easily take screenshots in Hyprland using your mouse.
    hyprutils # Small C++ library for utilities used across the Hypr* ecosystem
    hyprwayland-scanner # A Hyprland version of wayland-scanner in and for C++
  ];
}
