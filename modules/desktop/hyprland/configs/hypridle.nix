{ inputs, settings, pkgs, ... }:
let
  lockScript = pkgs.writeShellScript "lock-script" ''
    action=$1
    ${pkgs.pipewire}/bin/pw-cli i all | ${pkgs.ripgrep}/bin/rg running
    if [ $? == 1 ]; then
      if [ "$action" == "lock" ]; then
        ${pkgs.hyprlock}/bin/hyprlock
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
          # before_sleep_cmd = "${pkgs.stdenv.hostPlatform.system}/bin/loginctl lock-session";
          # after_sleep_cmd = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
          # ignore_dbus_inhibit = true;
          # lock_cmd = "pidof ${pkgs.hyprlock}/bin/hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
          lock_cmd = "noctalia-shell ipc call lockScreen lock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };
        listener = [
          {
            # timeout = 300;
            # on-timeout = "${lockScript.outPath} lock";
            timeout = 300;
            on-timeout =
              "if ! pactl list sink-inputs | grep -q 'Corked: no'; then hyprctl dispatch dpms off; fi";
            on-resume = "hyprctl dispatch dpms on";
          }
          {
            # timeout = 1800;
            # on-timeout = "${lockScript.outPath} suspend";
            timeout = 320;
            on-timeout =
              "if ! pactl list sink-inputs | grep -q 'Corked: no'; then loginctl lock-session; fi";
          }
        ];
      };
    };
  };
}
