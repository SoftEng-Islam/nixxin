{ settings, ... }: {
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland.settings = {
      env = [
        # Environment Variables Configuration
        # Environment variables. See https://wiki.hyprland.org/Configuring/Environment-variables/

        # Examples
        # "XDG_CURRENT_DESKTOP,Hyprland"
        # "XDG_SESSION_DESKTOP,Hyprland"
        # "XDG_SESSION_TYPE,wayland"
      ];
    };
  };
}
