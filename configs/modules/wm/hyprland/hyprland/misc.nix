{ settings, ... }: {
  home-manager.users.${settings.username} = {
    wayland.windowManager.hyprland = {
      settings.misc = {
        vrr = 2;
        vfr = true;
        force_default_wallpaper = -1;
        animate_manual_resizes = true;
        animate_mouse_windowdragging = true;
        enable_swallow = true;
        render_ahead_of_time = false;
        disable_hyprland_logo = true;
      };
    };
  };
}
