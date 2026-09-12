{
  settings,
  ...
}:
let
  HOME_DIR = "/home/${settings.user.username}";
in
{
  widget = {
    launcher = {
      # custom_image = "${HOME_DIR}/Pictures/launcher_icon.svg";
      # custom_image_colorize = false;
    };

    control-center = {
      custom_image = "${HOME_DIR}/Pictures/snowflake.svg";
      custom_image_colorize = false;
    };

    notifications = {
      hide_when_no_unread = false;
    };

    network_rx = {
      network_speed_unit = "auto"; # auto | kb | mb
      network_speed_compact = false; # show "1.2M" instead of "1.2 MB/s"
    };
    network_tx = {
      network_speed_unit = "auto"; # auto | kb | mb
      network_speed_compact = false; # show "1.2M" instead of "1.2 MB/s"
    };

    # [widget.network]
    # vpn_status     = "replace"         # replace | both | hidden
    # show_label     = true
    # show_vpn_label = false             # replace: replaces network label; both: adds VPN label

    # [widget.volume.effects_profile_glyphs]
    # eq_desktop = "device-speaker"

    keyboard_layout = {
      display = "short"; # "short" (e.g. "DE") or "full" (full layout name)
      show_icon = true;
      show_label = true;
      hide_when_single_layout = false; # hide the widget when only one layout is configured
      # cycle_command           = ""         # custom command to cycle layouts (empty = compositor backend)
      custom_labels = {
        # override display labels by exact layout name
        "English (US)" = "EN";
        "Arabic (EG)" = "AR";
      };
    };

    # [widget.lock_button]
    # type                = "custom_button"
    # glyph               = "lock"
    # tooltip             = "Lock screen"
    # command             = "noctalia msg session lock"
    # right_command       = ""
    # middle_command      = ""
    # scroll_up_command   = ""
    # scroll_down_command = ""
    #
    clock = {
      format = " {:%A %e, %B %m, %Y • %I:%M %p} ";
      vertical_format = "{:%I\n%M\n%p}";
      tooltip_format = "{:%A, %B %d, %Y}";
      scale = 1.0; # multiplies the bar scale for this widget only
      font_scale = 1.0; # multiplies text size for this widget only
      font_weight = 700;
      interactive = false; # pass clicks/scrolls through to the bar and disable hover/tooltips
    };

    udiskie = {
      type = "aristides/udiskie:status";
    };
  };
}
