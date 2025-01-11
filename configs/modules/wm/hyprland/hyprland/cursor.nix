{ settings, ... }: {
  home-manager.users.${settings.username} = {
    wayland.windowManager.hyprland = {
      settings.cursor = {
        no_hardware_cursors = false;
        enable_hyprcursor = true;
        warp_on_change_workspace = true;
        no_warps = true;
      };
    };
  };
}
