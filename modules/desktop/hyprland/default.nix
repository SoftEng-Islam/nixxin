{
  settings,
  lib,
  pkgs,
  forge,
  ...
}:
with forge.lib;
let

  xwaylandEnabled = settings.modules.desktop.xwayland.enable or false;
in
{
  imports = [
    # hyprland Plugins
    ./plugins
    ./hypridle.nix
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

    # HYPRLAND_CONFIG = ""; # Specifies where you want your Hyprland configuration.
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  # ----------------------------------------
  # ---------- HOME MANAGER ----------------
  # ----------------------------------------
  home-manager.users.${settings.user.username} = {

    # programs.hyprland-qt-support = {
    #   enable = true;
    #   package = pkgs.hyprland-qt-support;
    #   settings = {
    #     roundness = 1;
    #     border_width = 1;
    #     reduce_motion = false;
    #   };
    # };

    # Pointer Cursor
    home.pointerCursor = {
      enable = true; # <-- add this
      gtk.enable = true;
      package = settings.common.cursor.package;
      name = settings.common.cursor.name;
      size = settings.common.cursor.size;
    };

    # ----------------------------------------
    # HYPRLAND
    # ----------------------------------------
    wayland.windowManager.hyprland = {
      enable = true;
      package = pkgs.hyprland;
      systemd.enable = true;
      systemd.variables = [ "--all" ];
      systemd.enableXdgAutostart = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
      configType = "lua"; # "lua" or "hyprlang"
      settings = (
        importDir ./configs {
          inherit
            pkgs
            lib
            settings
            inputs
            ;
        }
      );
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

        -- Custom gradient using Noctalia color table
        hl.config({
          general = {
            col = {
              active_border = {
                colors = {
                  noctalia.colors.primary,
                  noctalia.colors.surface,
                  noctalia.colors.surface,
                  noctalia.colors.primary,
                },
                angle = 45,
              },
              inactive_border = {
                colors = {
                  noctalia.colors.surface,
                },
                angle = 0,
              },
            },
          },
        })
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
