{ config, pkgs, settings, inputs, ... }: {
  home.packages = [ inputs.swww.packages.${pkgs.system}.swww ];

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      #"exec-once = dbus-update-activation-environment --systemd DISPLAY XAUTHORITY WAYLAND_DISPLAY XDG_SESSION_DESKTOP=Hyprland XDG_CURRENT_DESKTOP=Hyprland XDG_SESSION_TYPE=wayland"
      "swww-daemon &"
      "ags &"
      "hyprpm reload"

      # exec-once = dconf write /org/gnome/desktop/interface/gtk-theme "'Adwaita'"
      # exec-once = dconf write /org/gnome/desktop/interface/icon-theme "'Flat-Remix-Red-Dark'"
      # exec-once = dconf write /org/gnome/desktop/interface/document-font-name "'Noto Sans Medium 11'"
      # exec-once = dconf write /org/gnome/desktop/interface/font-name "'Noto Sans Medium 11'"
      # exec-once = dconf write /org/gnome/desktop/interface/monospace-font-name "'Noto Sans Mono Medium 11'"

      # "hyprctl setcursor Catppuccin-Mocha-Lavender-Cursors 24"
      # "[workspace 2 silent] firefox"
      # "[workspace 3 silent] kitty btop"
      # "[workspace 3 silent] kitty ncmpcpp"
      # "[workspace 3 silent] kitty cava"
      # "steam -nochatui -nofriendsui -silent -vgui"
    ];

    general = {
      gaps_in = 8;
      gaps_out = 16;
      border_size = 2;
      allow_tearing = true;
      "col.active_border" = "rgba(${config.lib.stylix.colors.base0D}ff)";
      "col.inactive_border" = "rgba(${config.lib.stylix.colors.base02}ff)";
    };

    decoration = {
      dim_special = 0.5;
      rounding = settings.rounding;
      blur = {
        enabled = true;
        special = true;
        brightness = 1.0;
        contrast = 1.0;
        noise = 2.0e-2;
        passes = 3;
        size = 10;
      };

      drop_shadow = settings.shadow;
      shadow_ignore_window = false;
      shadow_offset = "2 2";
      shadow_range = 20;
      "col.shadow" = "rgba(${config.lib.stylix.colors.base00}ff)";
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

    debug = { disable_logs = false; };

    input = {
      kb_layout = "us,eg";
      kb_options = "grp:alt_shift_toggle";
      follow_mouse = true;
      touchpad = { natural_scroll = true; };
    };

    gestures = {
      workspace_swipe = true;
      workspace_swipe_distance = 200;
    };

    dwindle = {
      # keep floating dimentions while tiling
      pseudotile = true;
      preserve_split = true;
      force_split = 2;
      split_width_multiplier = 1.5;
    };

    misc = {
      force_default_wallpaper = -1;
      vrr = 2;
    };
  };
}
