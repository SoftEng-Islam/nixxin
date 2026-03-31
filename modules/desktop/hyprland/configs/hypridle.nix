{
  settings,
  pkgs,
  ...
}:
let
  lockCmd = "noctalia-shell ipc call lockScreen lock";
  dpmsOnCmd = "hyprctl dispatch dpms on";
  dpmsOffCmd = "hyprctl dispatch dpms off";
  lockTimeout = settings.modules.desktop.hyprland.lockscreen.timeOut or 900;
  displayOffTimeout = lockTimeout + 300;
in
{
  home-manager.users.${settings.user.username} = {
    xdg.configFile."hypr/hypridle.conf".text = ''
      general {
          lock_cmd = ${lockCmd}
          before_sleep_cmd = ${lockCmd}
          after_sleep_cmd = ${dpmsOnCmd}
          ignore_dbus_inhibit = false
      }

      listener {
          timeout = ${toString lockTimeout}
          on-timeout = ${lockCmd}
      }

      listener {
          timeout = ${toString displayOffTimeout}
          on-timeout = ${dpmsOffCmd}
          on-resume = ${dpmsOnCmd}
      }
    '';
  };
  environment.systemPackages = with pkgs; [
    hypridle
  ];
}
