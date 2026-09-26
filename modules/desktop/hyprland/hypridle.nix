{ settings, ... }: {
  home-manager.users.${settings.user.username} = {
    services.hypridle = {
      enable = false;
      settings = {
        general = {
          lock_cmd = "pidof qs || qs -c noctalia-shell ipc call lockScreen lock";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };
        listener = [
          {
            timeout = 900;
            on-timeout = "pidof qs || qs -c noctalia-shell ipc call lockScreen lock";
          }
          {
            timeout = 1200;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
  };
}
