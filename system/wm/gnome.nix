{ pkgs, ... }: {
  imports = [ ./common/wayland.nix ./common/fonts.nix ];

  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  # you can try this command if you have any problem with gnome settings
  # dconf reset -f /org/gnome/

  # Run the following command to disable the Gnome check-alive-timeout or "App Not Responding" dialog:
  # dconf write /org/gnome/mutter/debug/enable-frame-timing false
  # gsettings set org.gnome.mutter check-alive-timeout 0

  # Run this command to Remove window close and minimize buttons in GTK:
  # gsettings set org.gnome.desktop.wm.preferences button-layout ':'

  # Set Gnome Settings and Shortcuts
  services = {
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
  programs.kdeconnect = {
    package = pkgs.gnomeExtensions.gsconnect;
    enable = true;
  };
  environment.systemPackages = with pkgs; [
    gsettings-desktop-schemas
    playerctl # gsconnect play/pause command
    pamixer # gcsconnect volume control
    dconf-editor
    gdm # A program that manages graphical display servers and handles graphical user logins
    gjs # JavaScript bindings for GNOME
    gnome-bluetooth # Application that lets you manage Bluetooth in the GNOME desktop
    gnome-chess # Play the classic two-player boardgame of chess
    gnome-control-center # Utilities to configure the GNOME desktop
    gnome-keyring # Collection of components in GNOME that store secrets, passwords, keys, certificates and make them available to applications
    gnome-pomodoro # Time management utility for GNOME based on the pomodoro technique
    gnome-settings-daemon # GNOME Settings Daemon
    gnome-themes-extra
    gnome-tweaks # A tool to customize advanced GNOME 3 options
    gnomeExtensions.net-speed-simplified # A Net Speed extension With Loads of Customization. Fork of simplenetspeed
    libgnome-keyring # Framework for managing passwords and other secrets
    libsoup_3 # HTTP client/server library for GNOME
    eog # GNOME image viewer

    # Polkit
    polkit # A toolkit for defining and handling the policy that allows unprivileged processes to speak to privileged processes
    polkit_gnome # A dbus session bus service that is used to bring up authentication dialogs
    libsForQt5.polkit-qt # A Qt wrapper around PolKit
  ];
  environment.gnome.excludePackages =
    (with pkgs; [ gnome-photos gnome-tour gedit ]) ++ (with pkgs.gnome; [
      #        cheese # webcam tool
      #        gnome-music
      #        epiphany # web browser
      geary # email reader
      #        evince # document viewer
      gnome-characters
      #        totem # video player
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
    ]);

  #    nixpkgs.overlays = [
  #        (final: prev: {
  #        gnome = prev.gnome.overrideScope' (gnomeFinal: gnomePrev: {
  #            mutter = gnomePrev.mutter.overrideAttrs ( old: {
  #                src = pkgs.fetchgit {
  #                    url = "https://gitlab.gnome.org/vanvugt/mutter.git";
  #                    # GNOME 45: triple-buffering-v4-45
  #                    rev = "0b896518b2028d9c4d6ea44806d093fd33793689";
  #                    sha256 = "sha256-mzNy5GPlB2qkI2KEAErJQzO//uo8yO0kPQUwvGDwR4w=";
  #                };
  #            } );
  #        });
  #        })
  #    ];
}
