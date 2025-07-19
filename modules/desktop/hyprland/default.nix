{ settings, lib, pkgs, ... }: {

  imports = [
    ./configs/animations.nix
    ./configs/binds.nix
    ./configs/cursor.nix
    ./configs/decoration.nix
    ./configs/env.nix
    ./configs/exec.nix
    ./configs/general.nix
    ./configs/gestures.nix

    # ./configs/hypridle.nix
    ./configs/hyprlock.nix

    # ./configs/hyprpaper.nix
    ./configs/input.nix
    ./configs/keybinding.nix
    ./configs/misc.nix
    ./configs/monitor.nix
    ./configs/plugins
    ./configs/render.nix
    ./configs/rules.nix

    # ./configs/scripts.nix
    ./configs/source.nix

    # nix scripts
    ./configs/nix_scripts/gamemode.nix
    #./configs/nix_scripts/detect_mouse_position.nix
  ];

  # -----------------------------------
  # hyprpolkitagent
  # -----------------------------------
  security.polkit.enable = true;
  security.polkit.package = pkgs.polkit;
  systemd.services.polkit = { serviceConfig.NoNewPrivileges = false; };

  # Run XDG autostart, this is needed for a DE-less setup like Hyprland
  services.xserver.desktopManager.runXdgAutostartIfNone = true;

  services.seatd.enable = lib.mkForce false;

  services.gnome.core-shell.enable = true;

  programs.uwsm = {
    enable = false;
    waylandCompositors.hyprland = {
      prettyName = "Hyprland";
      comment = "Hyprland compositor managed by UWSM";
      # binPath = lib.getExe pkgs.hyprland;
      binPath = "/run/current-system/sw/bin/Hyprland";
    };
  };

  programs = {
    hyprlock.enable = true;
    xwayland.enable = true;
    hyprland = {
      enable = settings.modules.hyprland.enable;
      withUWSM = false; # Launch Hyprland with the UWSM session manager.
      xwayland.enable = true;
      package = pkgs.hyprland;
      # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };
  };

  environment = {
    variables = {
      LIBSEAT_BACKEND = "logind";

      HYPRCURSOR_THEME = settings.common.cursor.name;
      HYPRCURSOR_SIZE = toString settings.common.cursor.size;

      # HYPRLAND_TRACE = 1; # Enables more verbose logging.

      # HYPRLAND_NO_RT = 1; # Disables realtime priority setting by Hyprland.
      # HYPRLAND_NO_SD_NOTIFY = 1; # If systemd, disables the sd_notify calls.

      # Disables management of variables in systemd and dbus activation environments.
      # HYPRLAND_NO_SD_VARS = 1;

      # HYPRLAND_CONFIG = ""; # Specifies where you want your Hyprland configuration.
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      _JAVA_AWT_WM_NONREPARENTING = "1";
    };
  };

  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=no
    AllowSuspendThenHibernate=no
    AllowHybridSleep=no
  '';

  home-manager.users.${settings.user.username} = {

    home.pointerCursor = {
      gtk.enable = true;
      # x11.enable = true;
      package = settings.common.cursor.package;
      name = settings.common.cursor.name;
      size = settings.common.cursor.size;
    };

    wayland.windowManager.hyprland = {
      enable = settings.modules.hyprland.enable;
      package = pkgs.hyprland;
      systemd.enable = true;
      systemd.variables = [ "--all" ];
      systemd.enableXdgAutostart = true;
      settings = {
        debug = {
          disable_logs = false;
          enable_stdout_logs = true;
        };
        # active color
        "$primary" = "rgba(E62D42ff)";
        # inactive color
        "$surface" = "rgba(191919ff)";
      };
      # extraConfig = ''
      # '';
    };
    # Scripts for Hyprland
    home.file.".config/hypr/scripts".source = ./configs/scripts;
  };
  environment.systemPackages = with pkgs; [
    # Dynamic tiling Wayland compositor that doesn't sacrifice on its looks
    (hyprland.override { # or inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland
      enableXWayland = true; # whether to enable XWayland
      legacyRenderer =
        false; # whether to use the legacy renderer (for old GPUs)
      withSystemd = true; # whether to build with systemd support
    })

    hyprlang # The official implementation library for the hypr config language
    hyprlock # Hyprland's GPU-accelerated screen locking utility
    hyprpaper # A blazing fast wayland wallpaper utility
    hyprpicker # Wlroots-compatible Wayland color picker that does not suck
    hyprshot # Hyprshot is an utility to easily take screenshots in Hyprland using your mouse.
    hyprutils # Small C++ library for utilities used across the Hypr* ecosystem
    hyprprop # An xprop replacement for Hyprland
    hyprland-qtutils # Hyprland QT/qml utility apps
    hyprland-protocols # Wayland protocol extensions for Hyprland
    hyprwayland-scanner # A Hyprland version of wayland-scanner in and for C++
    hyprsunset # Application to enable a blue-light filter on Hyprland
    xwayland
    xwayland-run
    adwaita-qt6
    gojq
    grim
    imagemagick
    material-symbols
    pavucontrol
    playerctl
    showmethekey
    slurp
    swappy
    swww
    temurin-jre-bin
    tesseract
    uwuify
    wayshot
    wf-recorder
    wlsunset
    yad
    ydotool

    junction
    metadata-cleaner

    # -----------------------------------
    # hyprpolkitagent
    # -----------------------------------
    inputs.hyprpolkitagent.packages."${pkgs.system}".hyprpolkitagent
    # inputs.hyprutils
    # inputs.hyprland-qt-support
    # hyprpolkitagent # Polkit authentication agent written in QT/QML
    polkit # Toolkit for defining and handling the policy that allows unprivileged processes to speak to privileged processes

    # Wayland Packages
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
