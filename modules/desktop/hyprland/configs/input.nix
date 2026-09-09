{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland = {
      settings.config = {
        input = {
        kb_layout = "us,eg";
        kb_variant = "";
        kb_model = "";
        kb_rules = "";
        kb_options = "grp:alt_shift_toggle";

        # Sets the mouse input sensitivity. Value is clamped to the range -1.0 to 1.0.
        # https://wayland.freedesktop.org/libinput/doc/latest/pointer-acceleration.html#pointer-acceleration
        sensitivity = settings.common.mouse.sensitivity;

        # Sets the cursor acceleration profile.
        #  Can be one of adaptive, flat.
        #  Leave empty to use libinput’s default mode for your input device.
        accel_profile = "${settings.common.mouse.accelProfile}"; # flat prevents speed-up on fast movement, great for fast mice

        # Scroll Factor global modifier (1.0 is default, lower values reduce scroll speed)
        scroll_factor = settings.common.mouse.scrollSpeed;

        follow_mouse = 1;
        mouse_refocus = false;
        repeat_delay = 140;
        repeat_rate = 30;
        numlock_by_default = true;
        float_switch_override_focus = 0;
      };
    };
  };
}
