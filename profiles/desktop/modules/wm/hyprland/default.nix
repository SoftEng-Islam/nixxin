{ lib, mySettings, inputs, pkgs, ... }: {

  services.hypridle.enable = false; # Hyprland’s idle daemon.

  programs = {
    uwsm.enable = true;
    xwayland.enable = false; # an X server for interfacing X11 apps.
    hyprlock.enable = false;
    hyprland = {
      enable = true;
      withUWSM = true; # Launch Hyprland with the UWSM session manager.
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
    hyprland # A dynamic tiling Wayland compositor that doesn't sacrifice on its looks
    hyprland-protocols # Wayland protocol extensions for Hyprland
    # hyprlandPlugins.hyprbars # Hyprland window title plugin
    # hyprlandPlugins.hyprexpo # Hyprland workspaces overview plugin
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
  # swww = "swww img";
  # effect = "--transition-bezier .43,1.19,1,.4 --transition-fps 30 --transition-type grow --transition-pos 0.925,0.977 --transition-duration 2";

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # ~~~~~~ Home_Manager ~~~~~~~
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~

  home-manager.users.${mySettings.username} = {
    imports = [
      ./ags.nix
      ./binds.nix
      ./env.nix
      # ./hyprlock.nix
      ./plugins.nix
      ./rules.nix
      ./scripts.nix
      ./settings.nix
    ];

    # Make stuff work on wayland
    home.sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
      XDG_SESSION_TYPE = "wayland";
    };

    wayland.windowManager.hyprland = {
      enable = true;
      package = pkgs.hyprland;
      systemd.enable = true;
      plugins = with pkgs;
        [
          hyprlandPlugins.hyprbars
          hyprlandPlugins.hyprexpo
          hyprlandPlugins.hypr-dynamic-cursors
        ] ++ lib.optional (mySettings.themeDetails.bordersPlusPlus)
        hyprlandPlugins.borders-plus-plus;
    };
    # home.packages = with pkgs; [ hyprcursor ];
  };
}
