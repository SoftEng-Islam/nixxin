{
  bar = {
    main = {
      position = "top"; # top | bottom | left | right
      thickness = 48;
      background_opacity = 0.85;
      radius = 16;
      margin_ends = 12;
      margin_edge = 8;
      padding = 16;
      widget_spacing = 12;
      scale = 1.2;
      font_scale = 1.15; # text-only scale multiplier across widgets
      shadow = true;
      auto_hide = false;
      # smart_auto_hide    = false;       # show when the active workspace is empty; hide when it has windows
      # show_on_workspace_switch = true;   # with auto_hide: briefly reveal when the active workspace changes
      reserve_space = true;
      capsule = true;
      capsule_fill = "surface_variant";
      capsule_radius = 12.0; # omit/blank in Settings for automatic pill radius; 0.0 = square
      capsule_opacity = 0.95;
      # capsule_border   = "outline";      # uncomment for a border on all widgets

      start = [
        "launcher"
        "keyboard_layout"
        "workspaces"
        "notifications"
        "network_rx"
        "network_tx"
      ];
      center = [ "clock" ];
      end = [
        "tray"
        "clipboard"
        "network"
        "volume"
        "wallpaper"
        "control-center"
        "session"
      ];
      # Commands for the bar margin outside widget sections (dead zone):
      # dead_zone.actions = {
      #    left = "panel-toggle launcher";
      #    right = "panel-toggle control-center";
      #    middle = "none";
      #    scroll_up = "none";
      #    scroll_down = "none";
      # };

      # Per-monitor override example — only the fields you list are overridden:
      # monitor.dp1 = {
      #   match     = "DP-1";
      #   thickness = 44;
      #   dead_zone.actions = {
      #       left = "panel-toggle launcher";
      #   };
      # };
    };
  };
}
