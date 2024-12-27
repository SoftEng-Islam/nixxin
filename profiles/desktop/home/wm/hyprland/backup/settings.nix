{ config, settings, ... }:
let details = settings.themeDetails;
in {

  wayland.windowManager.hyprland.settings = {
    monitor = [
      # "DP-1, 3440x1440@120, 0x0, 1"
      # "HDMI-A-2,1920x1080@120,3440x100, 1"
      # "HDMI-A-1,3840x2160@120,-300x-2160, 1"
      #"HDMI-A-1,2560x1440@60,-900x-100, 1.6,transform,3"
      # "eDP-1,1920x1080@60,0x0, 1"
      # "eDP-1,2560x1600@120,2560x400, 1.6"
      # "DP-3,3840x2160@60,0x0, 1.5"
      # "HEADLESS-2,1920x1080@60,-1920x100, 1"
      # "HEADLESS-3,1280x800@60,1080x1440, 1"
      # "DVI-I-1, 3840x2160@60, 1920x0, 1"
      # ",1920x1080@60,auto,1"
      ",preferred,auto,1"
    ];
    debug = {
      disable_logs = false;
      enable_stdout_logs = true;
    };
    exec-once = [
      "swww-daemon &"
      # "swww init"
      # "swww img ~/Downloads/nixos-chan.png"
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"
      "ags &"
      "hyprctl setcursor ${settings.cursorTheme}  ${
        toString settings.cursorSize
      }"
    ];
    master = { new_is_master = true; };

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
      "col.active_border" = "$primary";
      "col.inactive_border" = "rgb(000000)";
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
      rounding = details.rounding;
      blur = {
        enabled = true;
        special = true;
        brightness = 1.0;
        contrast = 1.0;
        noise = 2.0e-2;
        passes = 3;
        size = 10;
        new_optimizations = true;
      };
      shadow = {
        range = 20;
        render_power = 3;
        offset = "2 2";
        ignore_window = false;
      };
      drop_shadow = details.shadow;
      "col.shadow" = "rgba(${config.lib.stylix.colors.base00}ff)";
      # shadow_ignore_window = false;
      # shadow_offset = "2 2";
      # shadow_range = 20;
      # shadow_render_power = 3;
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
    binds = { allow_workspace_cycles = true; };

    # device = {
    #   name = "logitech-usb-receiver-mouse";
    #   sensitivity = -1.0;
    # };

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
    windowrule = [ "float, ^(imv)$" "float, ^(mpv)$" ];

  };
}
