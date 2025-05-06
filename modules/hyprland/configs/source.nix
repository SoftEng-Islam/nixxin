{ settings, ... }: {
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland = {
      
    };
  };
}
