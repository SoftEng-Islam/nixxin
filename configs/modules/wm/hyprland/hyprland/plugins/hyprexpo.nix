{ settings, inputs, pkgs, ... }: {
  # ---- hyprexpo ---- #
  # bind = $main, tab, hyprexpo:expo, toggle # can be: toggle, off/disable or on/enable
  home-manager.users.${settings.username} = {
    wayland.windowManager.hyprland.plugins = [
      pkgs.hyprlandPlugins.hyprexpo
      # inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
    ];

    wayland.windowManager.hyprland.extraConfig = ''
      # ------------------ #
      # ---- hyprexpo ---- #
      # ------------------ #
      plugin:hyprexpo {
        columns = 3
        gap_size = 5
        bg_col = rgb(111111)
        # [center/first] [workspace] e.g. first 1 or center m+1
        workspace_method = center current

        enable_gesture = true # laptop touchpad
        gesture_fingers = 3 # 3 or 4
        gesture_distance = 300 # how far is the "max"
        gesture_positive = true # positive = swipe down. Negative = swipe up.
      }
    '';
  };
}
