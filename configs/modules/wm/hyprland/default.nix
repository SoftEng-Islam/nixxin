{ inputs, pkgs, settings, ... }: {
  # swww = "swww img";
  # effect = "--transition-bezier .43,1.19,1,.4 --transition-fps 30 --transition-type grow --transition-pos 0.925,0.977 --transition-duration 2";
  imports = [ ./packages.nix ./ignis ];

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
  };

  home-manager.users.${settings.username} = {
    imports = [
      ./hyprland/binds.nix
      ./hyprland/env.nix
      ./hyprland/exec.nix
      ./hyprland/monitor.nix
      ./hyprland/rules.nix
      ./hyprland/scripts.nix
    ];
    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      systemd.enable = true;
      systemd.enableXdgAutostart = true;
      settings = {
        binds = {
          # This allows cycling through workspaces when reaching the last one.
          allow_workspace_cycles = true;
          scroll_event_delay = 0;
          workspace_back_and_forth = false;
          pass_mouse_when_bound = false;
        };
        # render section for Hyprland >= v0.42.0
        render = {
          # Controls explicit synchronization for rendering.
          # `0`: Disabled.
          # `1`: Enabled, but only for clients that explicitly request it.
          # `2`: Always enabled.
          explicit_sync = 2;

          # helpful on systems with modern GPUs to avoid tearing when interacting with displays.
          # `0` = disable
          # `1` = Enabled only when explicitly required
          # `2` = Always enabled.
          explicit_sync_kms = 2;

          # Direct scan-out can improve performance and reduce latency by skipping the compositor and allowing the display to render directly. However, it may not always work depending on hardware, drivers, or specific applications. Setting this to false disables it entirely.
          direct_scanout = true; # true or false
        };
        debug = {
          disable_logs = false;
          enable_stdout_logs = true;
        };
        dwindle = {
          pseudotile = true;
          smart_split = true;
          preserve_split = true;
          smart_resizing = true;
          special_scale_factor = 0.8;
          # no_gaps_when_only = 0;
        };
        master = {
          new_status = "master";
          new_on_top = 1;
          mfact = 0.5;
          smart_resizing = true;
          new_on_active = true;
          drop_at_cursor = true;
        };
        general = {
          layout = "dwindle";

          # This just allows the `immediate` window rule to work
          allow_tearing = true;

          no_focus_fallback = true;
          gaps_in = 5;
          gaps_out = 8;
          gaps_workspaces = 50;
          border_size = 4;
          resize_on_border = true;
          col.inactive_border = "rgba(9e9e9e40)";
          #=> Active Borders
          # col.active_border="rgba(3584E4ff)"; # Blue
          # col.active_border="rgba(2190A4ff)"; # Teal
          # col.active_border="rgba(3A944Aff)"; # Greesn
          # col.active_border="rgba(C88800ff)"; # Yellow
          # col.active_border="rgba(ED5B00ff)"; # Ornage
          col.active_border = "rgba(E62D42ff)"; # Red
          # col.active_border="rgba(D56199ff)"; # Pink
          # col.active_border="rgba(9141ACff)"; # Purple
          # col.active_border="rgba(6F8396ff)"; # Slate

          #=> Active Border with graid colors
          # col.active_border="rgba(673ab7ff) rgba(E62D42ff) 45deg";

          # col.active_border = "$primary";
          # "col.active_border" = "rgba(${config.lib.stylix.colors.base0D}ff)";
          # "col.inactive_border" = "rgba(${config.lib.stylix.colors.base02}ff)";
        };
        cursor = {
          no_hardware_cursors = false;
          enable_hyprcursor = true;
          warp_on_change_workspace = true;
          no_warps = true;
        };
        input = {
          kb_layout = "us,eg";
          kb_variant = "lang";
          kb_options = "grp:alt_shift_toggle";
          follow_mouse = true;
          touchpad = {
            natural_scroll = "yes";
            disable_while_typing = true;
            drag_lock = true;
          };
          sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
          float_switch_override_focus = 2;
        };
        decoration = {
          rounding = settings.rounding;
          blur = {
            enabled = false;
            xray = true;
            ignore_opacity = true;
            special = true;
            new_optimizations = true;
            size = 6;
            passes = 2;
            brightness = 1;
            noise = 1.0e-2;
            contrast = 1;
            popups = true;
            popups_ignorealpha = 0.6;
          };

          shadow = {
            enabled = true;
            range = 20;
            offset = "0 2";
            render_power = 2;
            ignore_window = true;
            # col.shadow = rgba(00000070)
            # col.shadow_inactive = rgba(00000020)
          };
        };
        animations = {
          enabled = true;
          bezier = [
            "wind, 0.05, 0.9, 0.1, 1.05"
            "winIn, 0.1, 1.1, 0.1, 1.1"
            "winOut, 0.3, -0.3, 0, 1"
            "liner, 1, 1, 1, 1"
            "workIn, 0.72, -0.07, 0.41, 0.98"
          ];
          animation = [
            "windows, 1, 6, wind, slide"
            "windowsIn, 1, 6, winIn, slide"
            "windowsOut, 1, 5, winOut, slide"
            "windowsMove, 1, 5, wind, slide"
            "border, 1, 1, liner"
            "borderangle, 1, 30, liner, loop"
            "fade, 1, 10, default"
            "workspaces, 1, 5, wind"
            "specialWorkspace, 1, 5, workIn, slidevert"
          ];
        };
        gestures = {
          workspace_swipe = true;
          workspace_swipe_distance = 700;
          workspace_swipe_fingers = 4;
          workspace_swipe_cancel_ratio = 0.2;
          workspace_swipe_min_speed_to_force = 5;
          workspace_swipe_direction_lock = true;
          workspace_swipe_direction_lock_threshold = 10;
          workspace_swipe_create_new = true;
        };
        misc = {
          vrr = 2;
          vfr = true;
          force_default_wallpaper = -1;
          animate_manual_resizes = true;
          animate_mouse_windowdragging = true;
          enable_swallow = true;
          render_ahead_of_time = false;
          disable_hyprland_logo = true;
        };
        # source = [ "~/.cache/ignis/material/dark_colors-hyprland.conf" ];
        # extraConfig = "";
      };
    };
  };

}
