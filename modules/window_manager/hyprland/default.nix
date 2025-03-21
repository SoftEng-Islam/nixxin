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
    ./hyprpolkitagent.nix

    # nix scripts
    ./configs/nix_scripts/gamemode.nix
  ];

  # Run XDG autostart, this is needed for a DE-less setup like Hyprland
  services.xserver.desktopManager.runXdgAutostartIfNone = true;
  programs.uwsm = {
    enable = true;
    waylandCompositors.hyprland = {
      prettyName = "Hyprland";
      comment = "Hyprland compositor managed by UWSM";
      # binPath = lib.getExe pkgs.hyprland;
      binPath = "/run/current-system/sw/bin/Hyprland";
    };
  };

  programs = {
    hyprlock.enable = true;
    xwayland.enable = false;
    hyprland = {
      enable = settings.modules.window_manager.hyprland.enable;
      withUWSM = true; # Launch Hyprland with the UWSM session manager.
      xwayland.enable = false;
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
      enable = settings.modules.window_manager.hyprland.enable;
      package = pkgs.hyprland;
      systemd.enable = false;
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
      enableXWayland = false; # whether to enable XWayland
      legacyRenderer = true; # whether to use the legacy renderer (for old GPUs)
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

    gnome-control-center
  ];
}
