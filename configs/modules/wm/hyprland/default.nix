{ inputs, pkgs, settings, ... }: {
  # swww = "swww img";
  # effect = "--transition-bezier .43,1.19,1,.4 --transition-fps 30 --transition-type grow --transition-pos 0.925,0.977 --transition-duration 2";
  imports = [
    ./packages.nix
    ./ignis

    ./hyprland/source.nix
    ./hyprland/monitor.nix
    ./hyprland/keybinding.nix
    ./hyprland/env.nix
    ./hyprland/exec.nix
    ./hyprland/input.nix
    ./hyprland/binds.nix
    ./hyprland/animations.nix
    ./hyprland/cursor.nix
    ./hyprland/decoration.nix
    ./hyprland/general.nix
    ./hyprland/gestures.nix
    ./hyprland/misc.nix
    ./hyprland/render.nix
    ./hyprland/rules.nix
    ./hyprland/scripts.nix
    # ./hyprland/hyprlock.conf
    # ./hyprland/plugins.nix
  ];
  programs = {
    uwsm.enable = false;
    hyprlock.enable = false;
    xwayland.enable = false;
    hyprland = {
      enable = true;
      withUWSM = false; # Launch Hyprland with the UWSM session manager.
      xwayland.enable = false;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };
  };

  # home.file.".config/hypr/hyprland.conf".text = builtins.readFile ./hypr/hyprland.conf;
  # home.file.".config/hypr/hyprland.conf".source = ./hypr/hyprland.conf;
  # home.file.".config/hypr/hyprlock.conf".source = ./hypr/hyprlock.conf;
  # home.file.".config/hypr/scripts/hyprlock-time.sh".source = ./hypr/scripts/hyprlock-time.sh;
  environment.variables = {
    HYPRCURSOR_THEME = settings.cursorTheme;
    HYPRCURSOR_SIZE = toString settings.cursorSize;

    # HYPRLAND_TRACE = 1; # Enables more verbose logging.

    # HYPRLAND_NO_RT = 1; # Disables realtime priority setting by Hyprland.
    # HYPRLAND_NO_SD_NOTIFY = 1; # If systemd, disables the sd_notify calls.

    # Disables management of variables in systemd and dbus activation environments.
    # HYPRLAND_NO_SD_VARS = 1;

    # HYPRLAND_CONFIG = ""; # Specifies where you want your Hyprland configuration.
  };

  home-manager.users.${settings.username} = {
    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      systemd.enable = true;
      systemd.enableXdgAutostart = true;
      settings = {
        debug = {
          disable_logs = false;
          enable_stdout_logs = true;
        };
        # extraConfig = "";
      };
    };
  };

}
