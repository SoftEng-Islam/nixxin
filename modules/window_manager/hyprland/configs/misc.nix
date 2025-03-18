{ settings, ... }: {
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland = {
      settings.misc = {
        vfr = true;
        vrr = true;

        # If true, the config will not reload automatically on save, and..
        # instead needs to be reloaded with hyprctl reload.
        # Might save on battery.
        disable_autoreload = true;

        allow_session_lock_restore = true;

        # If true, will animate manual window resizes/moves
        animate_manual_resizes = true;

        # If true, will animate windows being dragged by mouse,
        # note that this can cause weird behavior on some curves
        animate_mouse_windowdragging = false;

        disable_hyprland_logo = true;
        background_color = "rgb(000000)";
        disable_splash_rendering = true;

        # The enable_swallow option in Hyprland allows a parent..
        # window (like a terminal) to "swallow" a child window (like a launched GUI app),
        # meaning the parent window will temporarily hide when the child window is opened.
        # When the child window is closed, the parent window reappears.
        enable_swallow = false;
        # # Only these terminals will swallow
        swallow_regex = "(foot|kitty|allacritty|Alacritty)";
        swallow_exception_regex = ".*nvim.*"; # Exception: Don't swallow Neovim

        focus_on_activate = false;
        force_default_wallpaper = -1; # -1 or 0 or 1
        initial_workspace_tracking = false;
        middle_click_paste = false;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        new_window_takes_over_fullscreen = 1;
        # new_window_takes_over_fullscreen = 2;
        # frame pre-rendering
        render_ahead_of_time = false;
      };
    };
  };
}
