{ settings, pkgs, ... }: {
  home-manager.users.${settings.username} = {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          before_sleep_cmd = "${pkgs.systemd}/bin/loginctl lock-session";
          after_sleep_cmd =
            "${config.programs.hyprland.package}/bin/hyprctl dispatch dpms on";
          ignore_dbus_inhibit = true;
          lock_cmd =
            "pidof ${pkgs.hyprlock}/bin/hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
        };
        listener = [
          {
            timeout = 300;
            on-timeout = "${lockScript.outPath} lock";
          }
          {
            timeout = 1800;
            on-timeout = "${lockScript.outPath} suspend";
          }
        ];
      };
    };
  };
}
