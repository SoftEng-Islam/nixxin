{ settings, ... }: {
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland = {
      settings.misc = {
        # controls the VFR status of Hyprland.
        # Heavily recommended to leave enabled to conserve resources.
        vfr = true;

        # controls the VRR (Adaptive Sync) of your monitors.
        # 0 - off,
        # 1 - on,
        # 2 - fullscreen only [0/1/2]
        vrr = 1;

        # If true, the config will not reload automatically on save, and..
        # instead needs to be reloaded with hyprctl reload.
        # Might save on battery.
        disable_autoreload = true;

        # if true, will allow you to restart a lockscreen app in case it crashes (red screen of death)
        allow_session_lock_restore = false;

        # If true, will animate manual window resizes/moves
        animate_manual_resizes = true;

        # If true, will animate windows being dragged by mouse,
        # note that this can cause weird behavior on some curves
        animate_mouse_windowdragging = false;

        # disables the random Hyprland logo / anime girl background. :(
        disable_hyprland_logo = true;

        # change the background color. (requires enabled disable_hyprland_logo)
        background_color = "rgb(000000)";

        # disables the Hyprland splash rendering. (requires a monitor reload to take effect)
        disable_splash_rendering = true;

        # disable the warning if XDG environment is externally managed
        disable_xdg_env_checks = true;

        # disable the warning if hyprland-qtutils is not installed
        # disable_hyprland_qtutils_check = true;

        # whether to enable the ANR (app not responding) dialog when your apps hang
        # enable_anr_dialog = false;

        # The enable_swallow option in Hyprland allows a parent..
        # window (like a terminal) to "swallow" a child window (like a launched GUI app),
        # meaning the parent window will temporarily hide when the child window is opened.
        # When the child window is closed, the parent window reappears.
        enable_swallow = false;
        # # Only these terminals will swallow
        swallow_regex = "(wezterm|foot|kitty|allacritty|Alacritty)";
        # swallow_regex = "^(wezterm)$";
        swallow_exception_regex =
          ".*micro.*"; # Exception: Don't swallow Micro editor

        # Whether Hyprland should focus an app that requests to be focused (an activate request)
        focus_on_activate = false;

        # Enforce any of the 3 default wallpapers. Setting this
        # to 0 or 1 disables the anime background. -1 means
        # “random”. [-1/0/1/2]
        force_default_wallpaper = 0;

        # if enabled, windows will open on the workspace they were invoked on.
        # 0 - disabled
        # 1 - single-shot
        # 2 - persistent (all children too)
        initial_workspace_tracking = 0;

        # whether to enable middle-click-paste (aka primary selection)
        middle_click_paste = false;

        # If DPMS is set to off, wake up the monitors if the mouse moves.
        mouse_move_enables_dpms = true;
        # If DPMS is set to off, wake up the monitors if a key is pressed.
        key_press_enables_dpms = true;

        # if there is a fullscreen or maximized window,
        # decide whether a new tiled window opened should replace it,
        # stay behind or disable the fullscreen/maximized state.
        # 0 - behind
        # 1 - takes over
        # 2 - unfullscreen/unmaxize
        new_window_takes_over_fullscreen = 1;
        exit_window_retains_fullscreen = true;

        # [Warning: buggy] starts rendering before your monitor displays a frame in order to lower latency
        # render_ahead_of_time = false;
        # how many ms of safezone to add to rendering ahead of time. Recommended 1-2.
        # render_ahead_safezone = 1;
      };
    };
  };
}
