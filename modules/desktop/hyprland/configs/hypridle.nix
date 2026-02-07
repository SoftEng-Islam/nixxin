{ inputs, settings, pkgs, ... }:
let
  lockScript = pkgs.writeShellScript "lock-script" ''
    action=$1
    ${pkgs.pipewire}/bin/pw-cli i all | ${pkgs.ripgrep}/bin/rg running
    if [ $? == 1 ]; then
      if [ "$action" == "lock" ]; then
        noctalia-shell ipc call sessionMenu lockAndSuspend
      elif [ "$action" == "suspend" ]; then
        ${pkgs.systemd}/bin/systemctl suspend
      fi
    fi
  '';
in {
  home-manager.users.${settings.user.username} = {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          before_sleep_cmd =
            "${pkgs.stdenv.hostPlatform.system}/bin/loginctl lock-session";
          after_sleep_cmd = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
          ignore_dbus_inhibit = true;
          lock_cmd = "noctalia-shell ipc call lockScreen lock";
        };
        listener = [
          {
            # timeout = 300;
            on-timeout = "${lockScript.outPath} lock";
          }
          {
            # timeout = 1800;
            on-timeout = "${lockScript.outPath} suspend";
          }
        ];
      };
    };
  };
}
