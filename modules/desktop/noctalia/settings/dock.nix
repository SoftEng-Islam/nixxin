{
  dock = {
    enabled = false; # set true to activate
    position = "bottom"; # top | bottom | left | right
    icon_size = 52;
    main_axis_padding = 20;
    cross_axis_padding = 12;
    item_spacing = 10;
    background_opacity = 0.8;
    radius = 24;
    radius_top_left = 24;
    radius_top_right = 24;
    radius_bottom_left = 24;
    radius_bottom_right = 24;
    margin_ends = 12;
    margin_edge = 12;
    shadow = true;
    show_running = true;
    auto_hide = false;
    # smart_auto_hide   = false;       # show when the active workspace is empty; hide when it has windows
    reserve_space = true;
    layer = "top"; # top | overlay
    active_scale = 1.05;
    inactive_scale = 0.9;
    magnification = true;
    magnification_scale = 1.55;
    active_opacity = 1.0;
    inactive_opacity = 0.75;
    show_dots = true;
    show_instance_count = true;
    launcher_position = "start"; # none | start | end
    launcher_icon = "apps"; # Tabler glyph name
    active_monitor_only = false;
    pinned = [
      "firefox"
      "kitty"
      "code"
      "nautilus"
    ]; # e.g. ["firefox", "code", "kitty"]
  };
}
