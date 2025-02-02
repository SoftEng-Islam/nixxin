{ pkgs, lib, settings, ... }: {
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
    # ./configs/hyprlock.nix
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
    # ./hyprpolkitagent.nix
  ];
  programs = {
    uwsm.enable = false;
    hyprlock.enable = true;
    xwayland.enable = false;
    hyprland = {
      enable = settings.hyprland.enable;
      withUWSM = false; # Launch Hyprland with the UWSM session manager.
      xwayland.enable = false;
      package = pkgs.hyprland;
      # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };
  };

  environment = {
    variables = {
      LIBSEAT_BACKEND = "logind";

      HYPRCURSOR_THEME = settings.style.cursor.name;
      HYPRCURSOR_SIZE = toString settings.style.cursor.size;

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

  home-manager.users.${settings.users.selected.username} = {
    wayland.windowManager.hyprland = {
      enable = settings.hyprland.enable;
      package = pkgs.hyprland;
      # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      systemd.enable = true;
      systemd.variables = [ "--all" ];
      systemd.enableXdgAutostart = true;
      settings = {
        debug = {
          disable_logs = false;
          enable_stdout_logs = true;
        };
        # extraConfig = "";
      };
    };
    # Scripts for Hyprland
    home.file.".config/hypr/scripts".source = ./configs/scripts;
  };
  environment.systemPackages = with pkgs; [
    # Install Hyprland from Inputes (latest version)
    # inputs.hyprland.packages.${system}.hyprland

    # A wlroots-compatible Wayland color picker that does not suck
    # inputs.hyprpicker.packages.${system}.hyprpicker

    fd # A simple, fast and user-friendly alternative to find
    gtk-engine-murrine # for gtk themes
    hyprcursor # The hyprland cursor format, library and utilities
    hyprland
    hyprland-protocols # Wayland protocol extensions for Hyprland
    hyprlang # The official implementation library for the hypr config language
    hyprlock # Hyprland's GPU-accelerated screen locking utility
    hyprpaper # A blazing fast wayland wallpaper utility
    hyprpicker
    hyprshot # Hyprshot is an utility to easily take screenshots in Hyprland using your mouse.
    hyprutils # Small C++ library for utilities used across the Hypr* ecosystem
    # hyprwayland-scanner # A Hyprland version of wayland-scanner in and for C++
    hyprprop

    # gui
    yad

    # tools
    gojq
    showmethekey
    ydotool

    # hyprland
    temurin-jre-bin
    grim
    tesseract
    imagemagick
    pavucontrol
    playerctl
    swappy
    slurp
    swww
    wayshot
    wlsunset
    wf-recorder

    # langs
    nodejs
    bun
    cargo
    go
    typescript
    eslint

    # very important stuff
    uwuify

    adwaita-qt6
    material-symbols
  ];
}
