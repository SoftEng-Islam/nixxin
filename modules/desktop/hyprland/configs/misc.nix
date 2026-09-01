{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland = {
      settings.misc = {
        # ╔═══════════════════════════════════════════════════════════════╗
        # ║                   Performance & Behavior                      ║
        # ╚═══════════════════════════════════════════════════════════════╝

        # ---- Display Features ---- #
        # Variable Refresh Rate (Adaptive Sync/FreeSync)
        # 0 = off, 1 = on, 2 = fullscreen only
        # For 144Hz monitor: fullscreen mode works best for gaming
        vrr = 2;

        # ---- Config & System ---- #
        # Don't auto-reload config on save (saves battery/resources on APU)
        disable_autoreload = true;

        # Allow lockscreen recovery if it crashes
        allow_session_lock_restore = true;

        # ---- Animations ---- #
        # Animate manual window resizes/moves
        animate_manual_resizes = true;

        # Disable mouse drag animation (can cause issues with some curves)
        animate_mouse_windowdragging = false;

        # ---- Visual Preferences ---- #
        # Disable Hyprland logo/anime background
        disable_hyprland_logo = true;
        background_color = "rgb(000000)";

        # Disable splash rendering (requires monitor reload to take effect)
        disable_splash_rendering = true;

        # ---- Environment ---- #
        # Disable XDG environment externally managed warning
        disable_xdg_env_checks = true;

        # ---- Window Behavior ---- #
        # Window swallowing: parent window hides when child opens
        # (e.g., terminal launching GUI app)
        enable_swallow = false;
        swallow_regex = "(wezterm|foot|kitty|allacritty|Alacritty)";
        swallow_exception_regex = ".*micro.*";

        # Don't auto-focus apps that request focus
        focus_on_activate = false;

        # Disable default wallpapers (-1=random, 0/1=specific, disables anime bg)
        force_default_wallpaper = 0;

        # Workspace tracking: windows open on the workspace they were invoked on
        # 0 = disabled, 1 = single-shot, 2 = persistent (all children too)
        initial_workspace_tracking = 0;

        # ---- Input Behavior ---- #
        # Disable middle-click paste (primary selection)
        middle_click_paste = false;

        # Wake monitors from DPMS on mouse/keyboard input
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;

        # ╔═══════════════════════════════════════════════════════════════╗
        # ║  IMPORTANT: render_ahead_of_time is DEPRECATED and removed    ║
        # ║  Modern Hyprland uses automatic adaptive rendering             ║
        # ╚═══════════════════════════════════════════════════════════════╝
        # render_ahead_of_time = false;  # REMOVED - deprecated
        # render_ahead_safezone = 1;     # REMOVED - deprecated
      };
    };
  };
}
