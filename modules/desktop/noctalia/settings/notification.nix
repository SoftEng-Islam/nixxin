{
  notification = {
    enable_daemon = true;
    show_app_name = true;
    show_actions = true; # show action buttons; when false, clicking a toast triggers its default action
    layer = "overlay"; # top | overlay
    scale = 1.0; # notification size multiplier applied on top of accessibility.ui_scale
    background_opacity = 0.92;
    offset_x = 24; # absolute horizontal margin from the screen edge
    offset_y = 12; # absolute vertical margin from the screen edge
    # [notification.filter.rhythmbox]
    # enabled         = true
    # match           = "rhythmbox"
    # show_toast      = true
    # save_history    = false
    # play_sound      = true
    # bypass_dnd      = false            # bypass DND for matching notifications; play_sound still controls sound
    # allowed_urgencies = ["normal", "critical"]  # omit or list all three to allow every level
    # IPC examples:
    # noctalia msg notification-invoke-latest
    # noctalia msg notification-clear-active
    # noctalia msg notification-clear-history
  };
}
