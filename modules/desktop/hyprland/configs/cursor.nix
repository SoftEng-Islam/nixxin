{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland = {
      settings.cursor = {
        no_hardware_cursors = false;
        enable_hyprcursor = false;
        warp_on_change_workspace = true;

        # if true, will not warp the cursor in many cases (focusing, keybinds, etc)
        no_warps = true;

        # in seconds, after how many seconds of cursor’s inactivity to hide it. Set to 0 for never.
        inactive_timeout = 2;

        # minimum refresh rate for cursor movement when no_break_fs_vrr is active. Set to minimum supported refresh rate or higher
        # min_refresh_rate = 35;

        # Hides the cursor when you press any key until the mouse is moved.
        # hide_on_key_press = true;
      };
    };
  };
}
