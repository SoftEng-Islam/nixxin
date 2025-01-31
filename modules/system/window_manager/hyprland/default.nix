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

  ];
  programs = {
    uwsm.enable = false;
    hyprlock.enable = true;
    xwayland.enable = false;
    hyprland = {
      enable = lib.optional settings.hyprland.enable true;
      withUWSM = false; # Launch Hyprland with the UWSM session manager.
      xwayland.enable = false;
      package = pkgs.hyprland;
      # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };
  };

  # home.file.".config/hypr/hyprland.conf".text = builtins.readFile ./hypr/hyprland.conf;
  # home.file.".config/hypr/hyprland.conf".source = ./hypr/hyprland.conf;
  # home.file.".config/hypr/hyprlock.conf".source = ./hypr/hyprlock.conf;
  # home.file.".config/hypr/scripts/hyprlock-time.sh".source = ./hypr/scripts/hyprlock-time.sh;

  environment =
    # let exec = "exec dbus-launch Hyprland";
    # in
    {
      #loginShellInit = ''
      # if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
      #    ${exec}
      #  fi
      #'';
      variables = {
        LIBSEAT_BACKEND = "logind";

        # HYPRLAND_PLUGIN_PATH = lib.concatStringsSep ":" [
        #   "${pkgs.hyprlandPlugins.hyprspace}/lib"
        #   "${pkgs.hyprlandPlugins.hyprbars}/lib"
        #   "${pkgs.hyprlandPlugins.borders-plus-plus}/lib"
        #   "${pkgs.hyprlandPlugins.hyprtrails}/lib"
        # ];
        HYPRCURSOR_THEME = settings.cursorTheme;
        HYPRCURSOR_SIZE = toString settings.cursorSize;

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
  #security.pam.services.hyprlock = {
  # text = "auth include system-auth";
  #text = "auth include login";
  #fprintAuth = if settings.hostName == "nixos" then true else false;
  # enableGnomeKeyring = false;
  #};

  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command =
  #         "${inputs.hyprland.packages.${pkgs.system}.hyprland}/bin/Hyprland";
  #       user = settings.users.selected.username;
  #     };
  #   };
  #   vt = 7;
  # };

  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=no
    AllowSuspendThenHibernate=no
    AllowHybridSleep=no
  '';

  home-manager.users.${settings.users.selected.username} = {
    wayland.windowManager.hyprland = {
      enable = lib.optional settings.hyprland.enable true;
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
    # inputs.hyprpolkitagent.packages."${system}".hyprpolkitagent
    hyprpolkitagent

    # albert # Fast and flexible keyboard launcher
    # hyprgui # unstable GUI for configuring Hyprland written in Rust
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
    adw-gtk3
    material-symbols
  ];
}
