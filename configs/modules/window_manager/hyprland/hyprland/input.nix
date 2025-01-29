{ settings, ... }: {
  home-manager.users.${settings.users.selected.username} = {
    wayland.windowManager.hyprland = {
      settings.input = {
        kb_layout = "us,eg";
        kb_variant = "";
        kb_model = "";
        kb_rules = "";
        accel_profile = "flat";
        kb_options = "grp:alt_shift_toggle";
        # follow_mouse = 1;
        # numlock_by_default = true;
        repeat_rate = 30;
        repeat_delay = 250;
        sensitivity = -0.3; # Adjust pointer sensitivity (speed)
        # special_fallthrough = true;
        float_switch_override_focus = false;
        left_handed = false;
        touchpad = {
          clickfinger_behavior = true;
          disable_while_typing = true;
          drag_lock = false;
          middle_button_emulation = true;
          natural_scroll = "yes";
          scroll_factor = 0.5;
          tap-to-click = true;
        };
        # below for devices with touchdevice ie. touchscreen
        touchdevice = {
          # enabled = true
        };
        # below is for table see link above for proper variables
        tablet = {
          # transform = 0
          # left_handed = 0
        };
      };
    };
  };
}
