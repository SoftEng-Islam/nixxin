{
  inputs,
  settings,
  pkgs,
  ...
}:
let
  lockScript = pkgs.writeShellScript "lock-script" ''
    action=$1
    ${pkgs.pipewire}/bin/pw-cli i all | ${pkgs.ripgrep}/bin/rg running
    if [ $? == 1 ]; then
      if [ "$action" == "lock" ]; then
        noctalia-shell ipc --any-display call lockScreen lock
      elif [ "$action" == "suspend" ]; then
        ${pkgs.systemd}/bin/systemctl suspend
      fi
    fi
  '';
in
{
  home-manager.users.${settings.user.username} = {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          before_sleep_cmd = "${pkgs.systemd}/bin/loginctl lock-session";
          after_sleep_cmd = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
          ignore_dbus_inhibit = true;
          lock_cmd = "noctalia-shell ipc --any-display call lockScreen lock";
        };
        listener = [
          {
            timeout = 600; # 10 minutes
            on-timeout = "${lockScript.outPath} lock";
          }
          {
            timeout = 1800; # 30 minutes
            on-timeout = "${lockScript.outPath} suspend";
          }
        ];
      };
    };
  };
  environment.systemPackages = with pkgs; [
    hypridle
  ];
}
