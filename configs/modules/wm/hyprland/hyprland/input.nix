{ settings, ... }: {
  home-manager.users.${settings.username} = {
    wayland.windowManager.hyprland = {
      settings.input = {
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
    };
  };
}
