{ inputs, pkgs, settings, ... }: {
  # swww = "swww img";
  # effect = "--transition-bezier .43,1.19,1,.4 --transition-fps 30 --transition-type grow --transition-pos 0.925,0.977 --transition-duration 2";
  imports = [ ./packages.nix ./eww ];

  # Run Hyprland in a nested session for testing within GNOME:
  # Install waypipe and weston: These tools allow you to run Wayland compositors inside existing Wayland/X11 sessions.
  # Start Nested Hyprland: Inside GNOME, run:
  # `weston --socket=wayland-1 &`
  # `WAYLAND_DISPLAY=wayland-1 Hyprland`
  # services.xserver.displayManager.startx.enable = false;
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
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # hint electron apps to use wayland
    MOZ_ENABLE_WAYLAND = "1"; # ensure enable wayland for Firefox
    WLR_RENDERER_ALLOW_SOFTWARE = "1"; # enable software rendering for wlroots
    WLR_NO_HARDWARE_CURSORS = "1"; # disable hardware cursors for wlroots
    NIXOS_XDG_OPEN_USE_PORTAL = "1"; # needed to open apps after web login
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
        debug = {
          disable_logs = false;
          enable_stdout_logs = true;
        };
        dwindle = {
          # keep floating dimentions while tiling
          pseudotile = true;
          preserve_split = true;
          force_split = 2;
          split_width_multiplier = 1.5;
          # no_gaps_when_only = "yes";
        };
        general = {
          layout = "dwindle";
          gaps_in = 8;
          gaps_out = 16;
          border_size = 2;
          allow_tearing = true;
          resize_on_border = true;

          # no_cursor_warps = false;
          # layout = "dwindle";
          # col.active_border = "$primary";
          # col.inactive_border = "rgb(000000)";
          # "col.inactive_border" = "rgb(000000)";
          # "col.active_border" = "rgba(${config.lib.stylix.colors.base0D}ff)";
          # "col.inactive_border" = "rgba(${config.lib.stylix.colors.base02}ff)";
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
          dim_special = 0.5;
          # dim_inactive = false;
          rounding = settings.rounding;
          blur = {
            enabled = true;
            xray = true;
            special = true;
            brightness = 1.0;
            contrast = 1.0;
            noise = 2.0e-2;
            passes = 4;
            size = 12;
            new_optimizations = true;
          };
          shadow = {
            enabled = true;
            range = 30;
            render_power = 4;
            offset = "2 2";
            ignore_window = false;
            # col.shadow = "rgb(000000)";
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
          workspace_swipe_distance = 200;
          workspace_swipe_fingers = 3;
          workspace_swipe_invert = false;
          workspace_swipe_forever = true;
        };
        misc = {
          vrr = 2;
          force_default_wallpaper = -1;
          animate_manual_resizes = true;
          animate_mouse_windowdragging = true;
          enable_swallow = true;
          render_ahead_of_time = false;
          disable_hyprland_logo = true;
        };
        source = [ "~/.config/eww/scripts/colors/colors-hyprland.conf" ];
        extraConfig = ''
          exec-once = ~/.config/eww/scripts/start.sh
          #exec-once = /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
          #exec-once = swww init
          #exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
          # exec-once = telegram-desktop -startintray

          $EWW_SCRIPTS = ~/.config/eww/scripts
          bind = $mod, F, exec, $EWW_SCRIPTS/select_wallpaper.sh
          bind = $mod SHIFT, F, exec, $EWW_SCRIPTS/generate_wallpaper.sh
          bind = $mod, Z, exec, $EWW_SCRIPTS/toggle_launcher.sh
          bind = $mod, X, exec, $EWW_SCRIPTS/toggle_control_center.sh
          bind = $mod, M, exec, $EWW_SCRIPTS/toggle_powermenu.sh
          bind = $mod, U, exec, $EWW_SCRIPTS/picker.sh

          $script = ~/.config/eww/scripts/toggle_osd.sh
          # Sink volume raise
          bind = ,XF86AudioRaiseVolume, exec, $script --up
          # Sink volume lower
          bind = ,XF86AudioLowerVolume, exec, $script --down
          # Sink volume toggle mute
          bind = ,XF86AudioMute, exec, $script --toggle
        '';
      };
    };
  };

}
