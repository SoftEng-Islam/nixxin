{ pkgs, inputs, settings, ... }: {
  # Run Hyprland in a nested session for testing within GNOME:
  # Install waypipe and weston: These tools allow you to run Wayland compositors inside existing Wayland/X11 sessions.
  # Start Nested Hyprland: Inside GNOME, run:
  # `weston --socket=wayland-1 &`
  # `WAYLAND_DISPLAY=wayland-1 Hyprland`
  programs = {
    uwsm.enable = true;
    hyprlock.enable = true;
    # xwayland.enable = true;
    hyprland = {
      enable = true;
      withUWSM = false; # Launch Hyprland with the UWSM session manager.
      # xwayland.enable = true;
      # set the flake package
      package =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # make sure to also set the portal package, so that they are in sync
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    };
  };

  home-manager.users.${settings.username} = {
    # home.file.".config/hypr/hyprland.conf".text =
    #   builtins.readFile ./hypr/hyprland.conf;
    # Make stuff work on wayland

    # home.file.".config/hypr/hyprland.conf".source = ./hypr/hyprland.conf;
    # home.file.".config/hypr/hyprlock.conf".source = ./hypr/hyprlock.conf;
    # home.file.".config/hypr/scripts/hyprlock-time.sh".source =
    #   ./hypr/scripts/hyprlock-time.sh;
    imports = [
      ./hyprland/ags.nix
      ./hyprland/env.nix
      ./hyprland/binds.nix
      ./hyprland/scripts.nix
      ./hyprland/rules.nix
      ./hyprland/settings.nix
      ./hyprland/plugins.nix
      ./hyprland/hyprlock.nix
    ];
    wayland.windowManager.hyprland = {
      enable = true;
      package = pkgs.hyprland;
      systemd.enable = true;
      plugins = [
        inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprbars
        "/absolute/path/to/plugin.so"

        inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprexpo
        inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.borders-plus-plus
        inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprtrails
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    # albert # Fast and flexible keyboard launcher
    ags # A EWW-inspired widget system as a GJS library
    brightnessctl # This program allows you read and control device brightness
    fd # A simple, fast and user-friendly alternative to find
    gpu-screen-recorder # A screen recorder that has minimal impact on system performance by recording a window using the GPU only
    gpu-screen-recorder-gtk # GTK frontend for gpu-screen-recorder.
    gtk-engine-murrine # for gtk themes
    hyprcursor # The hyprland cursor format, library and utilities
    # hyprgui # unstable GUI for configuring Hyprland written in Rust
    # hypridle # Hyprland's idle daemon
    # hyprland-protocols # Wayland protocol extensions for Hyprland
    # hyprlang # The official implementation library for the hypr config language
    # hyprlauncher # GUI for launching applications, written in Rust
    # hyprlock # Hyprland's GPU-accelerated screen locking utility
    # hyprnotify # DBus Implementation of Freedesktop Notification spec for 'hyprctl notify'
    # hyprpaper # A blazing fast wayland wallpaper utility
    hyprpicker # A wlroots-compatible Wayland color picker that does not suck
    # hyprshot # Hyprshot is an utility to easily take screenshots in Hyprland using your mouse.
    # hyprutils # Small C++ library for utilities used across the Hypr* ecosystem
    # hyprwayland-scanner # A Hyprland version of wayland-scanner in and for C++
  ];
}
