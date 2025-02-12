{ settings, ... }: {
  home-manager.users.${settings.users.selected.username} = {
    wayland.windowManager.hyprland = {
      settings.misc = {
        vfr = true;
        vrr = true;
        allow_session_lock_restore = true;
        animate_manual_resizes = false;
        animate_mouse_windowdragging = false;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        enable_swallow = false;
        focus_on_activate = false;
        force_default_wallpaper = -1; # -1 or 0 or 1
        initial_workspace_tracking = false;
        middle_click_paste = false;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        new_window_takes_over_fullscreen = 1;
        # new_window_takes_over_fullscreen = 2;
        swallow_regex = "(foot|kitty|allacritty|Alacritty)";
        # frame pre-rendering
        render_ahead_of_time = false;
      };
    };
  };
}
