{ pkgs, ... }:
{
  # you can try this command if you have any problem with gnome settings
  # dconf reset -f /org/gnome/

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
          [org.gnome.desktop.interface]
          gtk-theme='Colloid-Dark'
          icon-theme='Papirus-Dark'
          color-scheme='prefer-dark'
          cursor-theme='Breeze_Light'
          cursor-size=24

          [org.gnome.desktop.wm.preferences]
          button-layout='close,minimize,maximize:'

          [org.gnome.mutter]
          check-alive-timeout=0
        '';
      };
    };
  };
  environment.systemPackages = with pkgs; [
    gdm # A program that manages graphical display servers and handles graphical user logins
    gjs # JavaScript bindings for GNOME
    gnome-bluetooth # Application that lets you manage Bluetooth in the GNOME desktop
    gnome-chess # Play the classic two-player boardgame of chess
    gnome-control-center # Utilities to configure the GNOME desktop
    # gnome-firmware # Tool for installing firmware on devices
    gnome-keyring # Collection of components in GNOME that store secrets, passwords, keys, certificates and make them available to applications
    gnome-pomodoro # Time management utility for GNOME based on the pomodoro technique
    gnome-settings-daemon # GNOME Settings Daemon
    gnome-themes-extra
    gnome-tweaks # A tool to customize advanced GNOME 3 options
    gnomeExtensions.net-speed-simplified # A Net Speed extension With Loads of Customization. Fork of simplenetspeed
    gnomeExtensions.night-light-slider-updated # Night Light Slider updated for GNOME
    libgnome-keyring # Framework for managing passwords and other secrets
    libsoup_3 # HTTP client/server library for GNOME
    #__ polkit-gnome __#
    polkit # A toolkit for defining and handling the policy that allows unprivileged processes to speak to privileged processes
    polkit_gnome # A dbus session bus service that is used to bring up authentication dialogs
    libsForQt5.polkit-qt # A Qt wrapper around PolKit
  ];
}
