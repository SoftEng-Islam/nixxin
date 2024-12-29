{ pkgs, inputs, settings, ... }: {
  # Run Hyprland in a nested session for testing within GNOME:
  # Install waypipe and weston: These tools allow you to run Wayland compositors inside existing Wayland/X11 sessions.
  # Start Nested Hyprland: Inside GNOME, run:
  # `weston --socket=wayland-1 &`
  # `WAYLAND_DISPLAY=wayland-1 Hyprland`
  services.xserver.displayManager.startx.enable = true;
  programs = {
    uwsm.enable = false;
    hyprlock.enable = false;
    xwayland.enable = false;
    hyprland = {
      xwayland.enable = false;
      enable = true;
      withUWSM = false; # Launch Hyprland with the UWSM session manager.
      # xwayland.enable = true;
      # set the flake package
      package =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.default;
      # make sure to also set the portal package, so that they are in sync
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland.override {
          inherit (pkgs) mesa;
        };
    };
  };

  services = {
    # Applications messaging system
    dbus = {
      enable = true;
      packages = with pkgs; [
        gcr # crypto services (from gnome)
        dconf # settings daemon (from gnome)
      ];
    };
  };
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
    };
    # settings.default_session.command = pkgs.writeShellScript "greeter" ''
    #   export XKB_DEFAULT_LAYOUT=${config.services.xserver.xkb.layout}
    #   export XCURSOR_THEME=Qogir
    #   ${asztal}/bin/greeter
    # '';
  };

  systemd.tmpfiles.rules = [ "d '/var/cache/greeter' - greeter greeter - -" ];
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # hint electron apps to use wayland
    MOZ_ENABLE_WAYLAND = "1"; # ensure enable wayland for Firefox
    WLR_RENDERER_ALLOW_SOFTWARE = "1"; # enable software rendering for wlroots
    WLR_NO_HARDWARE_CURSORS = "1"; # disable hardware cursors for wlroots
    NIXOS_XDG_OPEN_USE_PORTAL = "1"; # needed to open apps after web login
  };
  xdg.desktopEntries."org.gnome.Settings" = {
    name = "Settings";
    comment = "Gnome Control Center";
    icon = "org.gnome.Settings";
    exec =
      "env XDG_CURRENT_DESKTOP=gnome ${pkgs.gnome-control-center}/bin/gnome-control-center";
    categories = [ "X-Preferences" ];
    terminal = false;
  };
  home-manager.users.${settings.username} = {
    # home.file.".config/hypr/hyprland.conf".text = builtins.readFile ./hypr/hyprland.conf;
    # home.file.".config/hypr/hyprland.conf".source = ./hypr/hyprland.conf;
    # home.file.".config/hypr/hyprlock.conf".source = ./hypr/hyprlock.conf;
    # home.file.".config/hypr/scripts/hyprlock-time.sh".source = ./hypr/scripts/hyprlock-time.sh;
    imports = [
      # ./hyprland/ags.nix
      # ./hyprland/env.nix
      # ./hyprland/binds.nix
      # ./hyprland/scripts.nix
      # ./hyprland/rules.nix
      # ./hyprland/settings.nix
      # ./hyprland/plugins.nix
      # ./hyprland/hyprlock.nix
    ];
    wayland.windowManager.hyprland = {
      enable = true;
      # package = pkgs.hyprland;
      systemd.enable = true;
      plugins = [
        inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprbars
        inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprexpo
        inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.borders-plus-plus
        inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprtrails
      ];

      settings = {
        monitor = [
          # "eDP-1, 1920x1080, 0x0, 1"
          # "HDMI-A-1, 2560x1440, 1920x0, 1"
          ",preferred,auto,1"
        ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    uwsm # Universal wayland session manager
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
