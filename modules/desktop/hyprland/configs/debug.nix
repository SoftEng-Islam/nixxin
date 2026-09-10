{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland = {
      settings.config = {
        debug = {
          damage_tracking = 2;
          disable_logs = false;
          enable_stdout_logs = true;
          gl_debugging = true;
        };
      };
    };
  };
}
