{
  settings,
  lib,
  pkgs,
  ...
}:
let
  xwaylandEnabled = settings.modules.desktop.xwayland.enable or false;
in
{
  imports = [
    # hyprland Plugins
    ./configs/plugins

    ./configs/animations.nix
    ./configs/cursor.nix
    ./configs/debug.nix
    ./configs/decoration.nix
    ./configs/ecosystem.nix
    ./configs/exec.nix
    ./configs/input.nix
    ./configs/keybinding.nix
    ./configs/misc.nix
    ./configs/monitor.nix
    ./configs/quirks.nix
    ./configs/render.nix
    ./configs/rules.nix
  ];

  # Run XDG autostart, this is needed for a DE-less setup like Hyprland
  services.xserver.desktopManager.runXdgAutostartIfNone = true;

  # Allows Hyprland to run without root privileges
  services.seatd.enable = lib.mkForce false;

  # 'false' why?
  services.gnome.core-shell.enable = false;

  programs = {
    hyprlock.enable = true;
    xwayland.enable = xwaylandEnabled;
    hyprland = {
      enable = true;
      withUWSM = false; # Launch Hyprland with the UWSM session manager.
      xwayland.enable = xwaylandEnabled;
      package = pkgs.hyprland;
      # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };
  };

  environment.variables = {
    LIBSEAT_BACKEND = "logind";
    HYPRLAND_TRACE = 0; # 1 to enable more verbose logging.
    AQ_TRACE = 0;

    HYPRCURSOR_THEME = settings.common.cursor.name;
    HYPRCURSOR_SIZE = toString settings.common.cursor.size;

    # HYPRLAND_NO_RT = 1; # Disables realtime priority setting by Hyprland.
    # HYPRLAND_NO_SD_NOTIFY = 1; # If systemd, disables the sd_notify calls.

    # Disables management of variables in systemd and dbus activation environments.
    # HYPRLAND_NO_SD_VARS = 1;

    # HYPRLAND_CONFIG = ""; # Specifies where you want your Hyprland configuration.
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  home-manager.users.${settings.user.username} = {
    home.file.".config/hypr/shaders".source = ./shaders;

    home.pointerCursor = {
      enable = true; # <-- add this
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
      configType = "lua"; # "lua" or "hyprlang"
      settings = {
        mod = {
          _var = "SUPER";
        };
        config = {
          xwayland = {
            force_zero_scaling = true;
          };
        };
      };
      extraConfig = ''
        -- Load Noctalia theme module
        local noctalia = require("noctalia")

        -- Apply primary, surface, and group border colors globally
        noctalia.apply_theme()

        -- Expose Noctalia colors as local variables for plugins (e.g., hyprbars)
        local colors = noctalia.colors

        -- Configure hyprbars using Noctalia palette
        if hl.plugin and hl.plugin.hyprbars then
          hl.config({
            plugin = {
              hyprbars = {
                bar_color = colors.surface,
                ["col.text"] = colors.on_surface,
              }
            }
          })
        end
      '';
    };
  };
  environment.systemPackages = with pkgs; [
    # Dynamic tiling Wayland compositor that doesn't sacrifice on its looks
    (hyprland.override {
      # or inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland
      enableXWayland = xwaylandEnabled; # whether to enable XWayland
      withSystemd = true; # whether to build with systemd support
    })
    hyprshade
    kitty
  ];
}
