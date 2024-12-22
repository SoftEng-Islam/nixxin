{ pkgs, ... }: {
  # you can try this command if you have any problem with gnome settings
  # dconf reset -f /org/gnome/

  # Run the following command to disable the Gnome check-alive-timeout or "App Not Responding" dialog:
  # dconf write /org/gnome/mutter/debug/enable-frame-timing false
  # gsettings set org.gnome.mutter check-alive-timeout 0

  # Run this command to Remove window close and minimize buttons in GTK:
  # gsettings set org.gnome.desktop.wm.preferences button-layout ':'
  services.gnome.core-shell.enable = true;
  services.gnome.core-utilities.enable = false; # GNOME without the apps
  services.gnome.evolution-data-server.enable = true;
  services.gnome.glib-networking.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.gnome.gnome-online-accounts.enable = true;
  services.gnome.games.enable = false;
  services.gnome.localsearch.enable = true;
  services.gnome.tinysparql.enable = true; # indexing files
  services.udev.packages = with pkgs; [ gnome-settings-daemon ];
  # services.gnome.core-developer-tools.enable = true;

  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
    [org.gnome.mutter]
    check-alive-timeout=0
  '';

  services.xserver.desktopManager.gnome = {
    # extraGSettingsOverrides = ''
    #   [org.gnome.desktop.interface]
    #   gtk-theme='${settings.gtkTheme}'
    #   icon-theme='${settings.icons}'
    #   color-scheme='${settings.colorScheme}'
    #   cursor-theme='${settings.cursorTheme}'
    #   cursor-size=${settings.cursorSize}

    #   [org.gnome.desktop.wm.preferences]
    #   button-layout='close,minimize,maximize:'
    # '';
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

    gdm-settings
    gdm # A program that manages graphical display servers and handles graphical user logins
    gjs # JavaScript bindings for GNOME

    gnomeExtensions.net-speed-simplified # A Net Speed extension With Loads of Customization. Fork of simplenetspeed
    libgnome-keyring # Framework for managing passwords and other secrets
    libsoup_3 # HTTP client/server library for GNOME
    eog # GNOME image viewer

    gnome-shell
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
  ];
}
