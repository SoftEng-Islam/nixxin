{ settings, pkgs, ... }: {
  # imports = [ ./dconf.nix ];
  # Run this command to Remove window close and minimize buttons in GTK:
  # gsettings set org.gnome.desktop.wm.preferences button-layout ':'
  services.gnome.core-shell.enable = true;
  services.gnome.core-utilities.enable = false; # GNOME without the apps
  services.gnome.evolution-data-server.enable = true;
  services.gnome.glib-networking.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.gnome.gnome-online-accounts.enable = true;
  services.gnome.games.enable = false;
  services.gnome.localsearch.enable = false;
  services.gnome.tinysparql.enable = false; # indexing files
  services.udev.packages = with pkgs; [ gnome-settings-daemon ];
  # services.gnome.core-developer-tools.enable = true;

  programs = {
    # Required by gnome file managers
    file-roller.enable = true;
    gnome-disks.enable = true;
  };

  services.xserver.desktopManager.gnome = {
    extraGSettingsOverrides = ''
      [org.gnome.desktop.interface]
      gtk-theme='${settings.gtkTheme}'
      icon-theme='${settings.iconNameDark}'
      color-scheme='${settings.colorScheme}'
      cursor-theme='${settings.cursorTheme}'
      cursor-size=${toString settings.cursorSize}
      scaling-factor=1

      [org.gnome.desktop.wm.preferences]
      button-layout=':minimize,maximize,close'

      [org.gnome.mutter]
      check-alive-timeout=0
    '';
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

  home-manager.users.${settings.users.user1.username} = {
    # Autostart
    home.file.".config/autostart/input-remapper.desktop".text = ''
      [Desktop Entry]
      Name=InputRemapperAutoload
      Type=Application
      Exec=input-remapper-control --command autoload
      Terminal=true
    '';
  };

  environment.gnome.excludePackages = with pkgs; [
    atomix # puzzle game
    cheese
    epiphany
    geary # email reader
    gedit
    gnome-characters
    gnome-contacts
    gnome-initial-setup
    gnome-maps
    gnome-music
    gnome-shell-extensions
    gnome-tour
    hitori # sudoku game
    iagno # go game
    tali # poker game
    totem # video player
    yelp # Help view
  ];
  environment.systemPackages = with pkgs; [
    eog # GNOME image viewer
    gdm # A program that manages graphical display servers and handles graphical user logins
    gdm-settings
    gjs # JavaScript bindings for GNOME
    gjs.dev
    gnome-bluetooth # Application that lets you manage Bluetooth in the GNOME desktop
    gnome-chess # Play the classic two-player boardgame of chess
    gnome-control-center # Utilities to configure the GNOME desktop
    gnome-keyring # Collection of components in GNOME that store secrets, passwords, keys, certificates and make them available to applications
    gnome-pomodoro # Time management utility for GNOME based on the pomodoro technique
    gnome-secrets # Password manager for GNOME which makes use of the KeePass v.4 format
    gnome-settings-daemon # GNOME Settings Daemon
    gnome-shell
    gnome-text-editor
    gnome-themes-extra
    gnome-tweaks # A tool to customize advanced GNOME 3 options
    gsettings-desktop-schemas
    lexend
    libgnome-keyring # Framework for managing passwords and other secrets
    libsoup_3 # HTTP client/server library for GNOME
    nautilus-open-any-terminal
    playerctl # gsconnect play/pause command
    twitter-color-emoji

    # Polkit
    polkit # A toolkit for defining and handling the policy that allows unprivileged processes to speak to privileged processes
    polkit_gnome # A dbus session bus service that is used to bring up authentication dialogs
    libsForQt5.polkit-qt # A Qt wrapper around PolKit
  ];
}
