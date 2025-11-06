{ settings, inputs, lib, pkgs, ... }:
let xwaylandEnabled = settings.modules.desktop.xwayland.enable or false;
in {
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
  ];

  # Run XDG autostart, this is needed for a DE-less setup like Hyprland
  services.xserver.desktopManager.runXdgAutostartIfNone = true;

  # Allows Hyprland to run without root privileges
  services.seatd.enable = lib.mkForce false;

  services.gnome.core-shell.enable = false;

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
    xwayland.enable = xwaylandEnabled;
    hyprland = {
      enable = true;
      withUWSM = false; # Launch Hyprland with the UWSM session manager.
      xwayland.enable = xwaylandEnabled;
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
      enable = true;
      package = pkgs.hyprland;
      systemd.enable = true;
      systemd.variables = [ "--all" ];
      systemd.enableXdgAutostart = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
      settings = {
        debug = {
          disable_logs = false;
          enable_stdout_logs = true;
        };
        # active color
        "$primary" = settings.common.primaryColor;
        # inactive color
        "$surface" = settings.common.surfaceColor;
      };
      # extraConfig = ''
      # '';
    };
    # Scripts for Hyprland
    home.file.".config/hypr/scripts".source = ./configs/scripts;
  };
  environment.systemPackages = with pkgs;
    [
      # Dynamic tiling Wayland compositor that doesn't sacrifice on its looks
      (hyprland.override { # or inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland
        enableXWayland = xwaylandEnabled; # whether to enable XWayland
        # whether to use the legacy renderer (for old GPUs)
        legacyRenderer = false;
        withSystemd = true; # whether to build with systemd support
      })
    ];
}
