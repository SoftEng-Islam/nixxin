{ inputs, pkgs, ... }: {
  # Window Managers: ["Hyprland", "Gnome"]

  # you can try this command if you have any problem with gnome settings
  # dconf reset -f /org/gnome/

  # Run the following command to disable the Gnome check-alive-timeout or "App Not Responding" dialog:
  # dconf write /org/gnome/mutter/debug/enable-frame-timing false
  # gsettings set org.gnome.mutter check-alive-timeout 0

  # Run this command to Remove window close and minimize buttons in GTK:
  # gsettings set org.gnome.desktop.wm.preferences button-layout ':'

  services = {
    udev.packages = with pkgs; [ gnome-settings-daemon ];
    hypridle.enable = false; # Hyprland’s idle daemon.
    gnome = {
      # gnome-settings-daemon.enable = true;
      core-shell.enable = true;
      core-utilities.enable = true;
      evolution-data-server.enable = true;
      glib-networking.enable = true;
      gnome-keyring.enable = true;
      gnome-online-accounts.enable = true;
      localsearch.enable = true;
      tinysparql.enable = true;
    };
    xserver.desktopManager = {
      gnome = {
        enable = true;
        # Specify GNOME GSettings overrides
        extraGSettingsOverrides = ''
          [org.gnome.mutter]
          check-alive-timeout=0
        '';
      };
    };
  };

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
    kdeconnect = {
      package = pkgs.gnomeExtensions.gsconnect;
      enable = true;
    };
  };
  security = {
    polkit.enable = true;
    pam.services.astal-auth = { };
  };
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart =
          "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
  environment.gnome.excludePackages = with pkgs; [
    gnome-photos
    cheese
    evince
    epiphany
    gedit
    gnome-tour
    totem # video player
    gnome-music
    gnome-characters
    geary # email reader
    atomix # puzzle game
    hitori # sudoku game
    iagno # go game
    tali # poker game
  ];

  environment.systemPackages = with pkgs; [
    gsettings-desktop-schemas
    playerctl # gsconnect play/pause command
    pamixer # gcsconnect volume control

    gdm # A program that manages graphical display servers and handles graphical user logins
    gjs # JavaScript bindings for GNOME

    gnomeExtensions.net-speed-simplified # A Net Speed extension With Loads of Customization. Fork of simplenetspeed
    libgnome-keyring # Framework for managing passwords and other secrets
    libsoup_3 # HTTP client/server library for GNOME
    eog # GNOME image viewer

    gnome-bluetooth # Application that lets you manage Bluetooth in the GNOME desktop
    gnome-chess # Play the classic two-player boardgame of chess
    gnome-control-center # Utilities to configure the GNOME desktop
    gnome-keyring # Collection of components in GNOME that store secrets, passwords, keys, certificates and make them available to applications
    gnome-pomodoro # Time management utility for GNOME based on the pomodoro technique
    gnome-secrets # Password manager for GNOME which makes use of the KeePass v.4 format
    gnome-settings-daemon # GNOME Settings Daemon
    gnome-themes-extra
    gnome-tweaks # A tool to customize advanced GNOME 3 options

    # Polkit
    polkit # A toolkit for defining and handling the policy that allows unprivileged processes to speak to privileged processes
    polkit_gnome # A dbus session bus service that is used to bring up authentication dialogs
    libsForQt5.polkit-qt # A Qt wrapper around PolKit

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
    hyprlandPlugins.hyprbars # Hyprland window title plugin
    hyprlandPlugins.hyprexpo # Hyprland workspaces overview plugin
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
